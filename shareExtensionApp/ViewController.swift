//
//  ViewController.swift
//  shareExtensionApp
//
//  Created by Amir on 7/27/2016.
//  Copyright © 2018 com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    var sharedId = "group.com.shareExtensionApp"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func getData(){
        
        if let shareData = UserDefaults(suiteName: sharedId){
            if let imageData = shareData.object(forKey: "Image") as? Data{
                
                DispatchQueue.main.async(execute: {
                    self.imageView.image = UIImage(data:imageData)
                })
                
            }
            if let text =  shareData.object(forKey: "Name") as? String{
                textField.text = text
            }
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

