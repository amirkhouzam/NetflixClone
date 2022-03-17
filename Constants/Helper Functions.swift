//
//  Helper Functions.swift
//  Netflix
//
//  Created by Amirkhouzam on 21/02/2022.
//

import UIKit
import CoreData
import Alamofire

func imagetostring( image : UIImage ) -> String{
    
    let imagedata = image.jpegData(compressionQuality: 0.5)
    guard let encodedimage = imagedata?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) else {return ""}
    
    return encodedimage
}
func stringtoimage(encodedimage : String , withblock:(_ image : UIImage?) -> Void){
    
    var image : UIImage?
    
    let decodeddata = NSData(base64Encoded: encodedimage, options: NSData.Base64DecodingOptions(rawValue: 0))
    
    image = UIImage(data: decodeddata! as Data)
    
    withblock(image)
}

func getImage(_ url:String,handler: @escaping (UIImage?)->Void) {
    
    AF.request(url, method: .get).responseImage { response in
        if let data = response.value{
            handler(data)
            
        } else {
            handler(nil)
        }
    }
}



