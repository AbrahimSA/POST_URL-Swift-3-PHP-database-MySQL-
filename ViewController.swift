//
//  ViewController.swift
//  POST_URL
//
//  Created by abrahim abrahao on 2016-11-09.
//  Copyright © 2016 abrahim abrahao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblPhone: UILabel!

    @IBAction func btnValidate(_ sender: Any) {
        
        var localPhone = "Phone: "
        if txtUser.text == "" || txtPassword.text == "" {
            print("User or Password invalid")
            lblPhone.text = "Phone: "
            
        } else {
            print("Step01")
            
            let myUrl = URL(string: "http://localhost:8888/swift_post/login.php");
        
            //let cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
            //var request = URLRequest(url:myUrl!)
            //request = NSMutableURLRequest(url: myUrl!, cachePolicy: cachePolicy, timeoutInterval: 10.0) as URLRequest
        
            var request = URLRequest(url:myUrl!)
            print("Step02")
            request.httpMethod = "POST"// Compose a query string
        
            let postString = "user=" +  txtUser.text! + " &pwd=" + txtPassword.text!;
        
            request.httpBody = postString.data(using: String.Encoding.utf8);
            print("Step05")
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
                if error != nil
                {
                    print("error=\(error)")
                    return
                }
            print("Step06")
                // You can print out response object
                print("response = \(response)")
                //Let's convert response sent from a server side script to a NSDictionary object:
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                    if let parseJSON = json {
                    
                        // Now we can access value of First Name by its key
                        let phone = parseJSON["phone"] as? String
                        
                        localPhone = "Phone: \(phone!)"
                        print(localPhone)
                        //let firstNameValue = parseJSON["firstName"] as? String
                        //let lastNameValue = parseJSON["lastName"] as? String
                        //print("firstNameValue: \(firstNameValue)")
                        //print("lastNameValue: \(lastNameValue)")
                    }
                } catch {
                    print("Last Error: \(error)")
                }
            }
              task.resume()
        }
        lblPhone.text = localPhone
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

