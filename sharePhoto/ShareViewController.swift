//
//  ShareViewController.swift
//  sharePhoto
//
//  Created by Amir on 7/27/2016.
//  Copyright © 2018 com. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    var sharedId = "group.com.shareExtensionApp"
    var selectedImage : UIImage!
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        print("didselect")
        self.dataAtchment()
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    func dataAtchment(){
        print("POSTTTTTT")
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        let contentType = kUTTypeImage as String
        
        for attachment in content.attachments as! [NSItemProvider]{
            if attachment.hasItemConformingToTypeIdentifier(contentType){

                attachment.loadItem(forTypeIdentifier: contentType, options: nil)  { data, error in
                    print("loading....")
                    
                    if error == nil {
                        print("NOERRRORRR")
                        
                        let url = data as! NSURL
                        if let imageData = NSData(contentsOf : url as URL) {
                            self.saveDataToUserDefault(suiteName: self.sharedId, dataKey:"Image", dataValue : imageData)
                            
                        }
                    }else{ print("there is error -- > \(error)") }
                }
                
            }
        }
        
        saveDataToUserDefault(suiteName: self.sharedId, dataKey:"Name", dataValue : contentText as AnyObject)
        
    }
    
    func saveDataToUserDefault(suiteName: String, dataKey:String, dataValue : AnyObject){
        
        if let sharedData = UserDefaults(suiteName: suiteName){
            
            sharedData.removeObject(forKey: dataKey)
            sharedData.set(dataValue, forKey: dataKey)
            
        }
        
    }
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
