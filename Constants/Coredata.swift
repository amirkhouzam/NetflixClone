//
//  Coredata.swift
//  Netflix
//
//  Created by Amirkhouzam on 10/03/2022.
//

import CoreData
import UIKit

class coredatacaller {
    
    static let shared = coredatacaller()
    func insertdata(film : Title? , ismovie : Bool?){
        guard let film = film else {return}

        let object = NSEntityDescription.insertNewObject(forEntityName: "Film", into: context) as! Film
        
        object.name = film.original_title?.stripped ?? film.original_name?.stripped
        object.releasedate = film.release_date ?? film.first_air_date
        object.voteaverage = film.vote_average
        object.overview = film.overview
        object.posterimage = film.poster_path
        guard let back = film.backdrop_path else {return}
        object.backimage = back
        object.ismovie = ismovie!
        object.id = Int64(film.id)
        context.insert(object)
        do{
            try context.save()
        }catch{
            return
        }
    }
    
    func deleteattribute(filmname : String? ){
        guard let name = filmname?.stripped else {return}
        let fetchreq = Film.fetchRequest()
        let predict = NSPredicate(format: "name='\(name)'")
        fetchreq.predicate = predict
        do{
            let result = try context.fetch(fetchreq)
            for res in  result {
                context.delete(res)
            }
            try context.save()
        }catch{
            return
        }
        
    }
   
    func checkexist(filmname : String? ) -> Bool{
        guard let name = filmname?.stripped else {return Bool()}
        let fetchreq = Film.fetchRequest()
        let predict = NSPredicate(format: "name='\(name)'")
        fetchreq.predicate = predict
        var count : Int?
        do{
              count = try context.count(for: fetchreq)
        
        }catch{
            print(error.localizedDescription)
        }
        if count == 1 {
            return true
        }else {
            return false
        }
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
}
