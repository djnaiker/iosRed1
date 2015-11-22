//
//  ViewController.swift
//  NubeIOS
//
//  Created by Ruben Lopez Diez on 20/11/15.
//  Copyright © 2015 Naiker. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var isbn: UITextField!
    @IBOutlet weak var result: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        isbn.clearButtonMode = UITextFieldViewMode.WhileEditing;
        isbn.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getJSON(isbn:String){
        let url : String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let nsurl = NSURL(string: url + isbn)
        let sesion = NSURLSession.sharedSession()
        let bloque = { (datos : NSData?, resp : NSURLResponse?, error: NSError?) -> Void in
            if (error == nil){
                self.result.text = String(data: datos!, encoding: NSUTF8StringEncoding)
            }else{
                
                let alert = UIAlertView()
                alert.title = "Fallo"
                alert.message = "No se ha podido conectar con el servidor"
                alert.show()            }
         
        }
        
        let dt = sesion.dataTaskWithURL(nsurl!, completionHandler: bloque)
        dt.resume()
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        getJSON(self.isbn.text!)
        return true;
    }
    
    
   

   

}

