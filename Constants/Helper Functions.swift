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
func getdataoffline(self : UIViewController , completion :@escaping([Film]?) -> Void){
    
    let predict : NSFetchRequest = Film.fetchRequest()
    
    do{
        let result = try context.fetch(predict)
        completion(result)
        
    }catch{
        completion(nil)
        let alert = UIAlertController(title: "Error Getting Data", message: "Cannot getting data", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
        alert.addAction(alertaction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
func deleteallofflinedata(collection : UICollectionView){
    
    let fetch : NSFetchRequest = Film.fetchRequest()
    do{
        let result = try context.fetch(fetch)
        for res in result {
            context.delete(res)
            print("all data deleted")
        }
    }catch{
        print(error.localizedDescription)
    }
}
func insertdataoffline(self : UIViewController , filmname : String , filmimage : UIImage , filmoverview : String){
    let object = NSEntityDescription.insertNewObject(forEntityName: "Film", into: context) as! Film
    
    ///Checking if the data exists
    
    object.name = filmname
    object.posterimage = imagetostring(image: filmimage)
    object.overview = filmoverview
    context.insert(object)
    
    do{
        try context.save()
        
    }catch{
        let alert = UIAlertController(title: "Error", message: "Cannot Add It To Your Watchlist", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(alertaction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
func deletealldata(collection : UICollectionView){
    
    
    let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Film")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

    do {
        try context.execute(deleteRequest)
        try context.save()
        DispatchQueue.main.async {
            collection.reloadData()
        }
    } catch {
        // TODO: handle the error
        print("all data deleted")
    }
    
}
func deleteobject(){
    
    let fetch: NSFetchRequest = Film.fetchRequest()
    
    let predict = NSPredicate(format: "pName='car'")
    
    fetch.predicate = predict
    
    do{
        let results = try context.fetch(fetch)
        
        for result in results{
            
            context.delete(result)
        }
        
        try context.save()
        print("Data Deleted")
        
    }catch{
        
        print(error.localizedDescription)
    }
    
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

