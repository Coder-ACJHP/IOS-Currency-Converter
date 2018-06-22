//
//  ViewController.swift
//  Currency Convert
//
//  Created by akademobi5 on 22.06.2018.
//  Copyright © 2018 akademobi5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let url: String = "http://data.fixer.io/api/latest?access_key=0d573a288d506940887c7e2c634d21d0&format=1"
    @IBOutlet weak var cadlabel: UILabel!
    @IBOutlet weak var chflabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func fetchButtonPressed(_ sender: Any) {
        
       /*
        *First of all if our link starts with 'http' we have to get access permision
        *from info.plist file as App Transport Security Setting and than add Allow Arbitrary loads = YES
        */
        
        //Convert the String url to URL object
        let apiUrl = URL(string: url)
        //Create session shared
        let session = URLSession.shared
        //Create task with dataTask (data, response, error)
        let task = session.dataTask(with: apiUrl!) { (data, response, error) in
            //First handle the error
            if error != nil {
                let alert = UIAlertController(title: "Warning", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let cancelButton = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(cancelButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                //just for be sure check the data is nil
                if data != nil {
                    do {
                        let jSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
                        
                        DispatchQueue.main.async {
                            //print(jSONResult)
                            //Now get the key from this dict
                            let rates = jSONResult["rates"] as! [String:AnyObject]
                            //Here we can get any currency rate from handled dictionary
                            for rate in  rates {
                                
                                if rate.key == "TRY" {
                                    self.tryLabel.text = "\(String(describing: rate.value))"
                                } else if rate.key == "USD" {
                                    self.usdLabel.text = "\(String(describing: rate.value))"
                                } else if rate.key == "JPY" {
                                    self.jpyLabel.text = "\(String(describing: rate.value))"
                                } else if rate.key == "GBP" {
                                    self.gbpLabel.text = "\(String(describing: rate.value))"
                                } else if rate.key == "CHF" {
                                    self.chflabel.text = "\(String(describing: rate.value))"
                                } else if rate.key == "CAD" {
                                    self.cadlabel.text = "\(String(describing: rate.value))"
                                }
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            
        }
        task.resume()
        print("Pressed!")
    }
    
}

