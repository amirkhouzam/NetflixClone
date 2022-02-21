//
//  APICALLER.swift
//  Netflix
//
//  Created by Amirkhouzam on 01/02/2022.
//

import Alamofire
import UIKit

class Apicaller {
    
    static let shared = Apicaller()
    
    
    func call_populars ( table : UITableView? , completion :@escaping(Bool ,TrendingTitleResponse?) -> Void){
        guard let url = URL(string: baseurl+categorypopular+apikey) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            if response.error != nil {
                print(response.error?.localizedDescription ?? "")
            }
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let res = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    DispatchQueue.main.async {
                        table!.reloadData()
                    }
                    
                    completion(true , res)
                  
                    
                }catch{
                    print(error.localizedDescription)
                    completion(false , nil)
                    return
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(false , nil)
            }
            
        }
    }
    
    
    func call_nowplaying ( table : UITableView? , completion :@escaping(Bool ,TrendingTitleResponse?) -> Void){
        guard let url = URL(string: baseurl+categorynowplaying+apikey) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            if response.error != nil {
                print(response.error?.localizedDescription ?? "")
            }
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let res = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    DispatchQueue.main.async {
                        table!.reloadData()
                    }
                    
                    completion(true , res)
                  
                    
                }catch{
                    print(error.localizedDescription)
                    completion(false , nil)
                    return
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(false , nil)
            }
            
        }
    }
    
    func call_latest ( table : UITableView? , completion :@escaping(Bool ,TrendingTitleResponse?) -> Void){
        guard let url = URL(string: baseurl+categorylatest+apikey) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            if response.error != nil {
                print(response.error?.localizedDescription ?? "")
            }
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let res = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    DispatchQueue.main.async {
                        table!.reloadData()
                    }
                    
                    completion(true , res)
                  
                    
                }catch{
                    print(error.localizedDescription)
                    completion(false , nil)
                    return
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(false , nil)
            }
            
        }
    }
    
    func call_toprated ( table : UITableView? , completion :@escaping(Bool ,TrendingTitleResponse?) -> Void){
        guard let url = URL(string: baseurl+categorytoprated+apikey) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            if response.error != nil {
                print(response.error?.localizedDescription ?? "")
            }
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let res = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    DispatchQueue.main.async {
                        table!.reloadData()
                    }
                    
                    completion(true , res)
                  
                    
                }catch{
                    print(error.localizedDescription)
                    completion(false , nil)
                    return
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(false , nil)
            }
            
        }
    }
    
    func call_upcoming ( table : UITableView? , completion :@escaping(Bool ,TrendingTitleResponse?) -> Void){
        guard let url = URL(string: baseurl+categoryupcoming+apikey) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            if response.error != nil {
                print(response.error?.localizedDescription ?? "")
            }
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let res = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    DispatchQueue.main.async {
                        table!.reloadData()
                    }
                    
                    completion(true , res)
                  
                    
                }catch{
                    print(error.localizedDescription)
                    completion(false , nil)
                    return
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(false , nil)
            }
            
        }
    }
    
    func fetchdata(search : String , completion : @escaping(Bool , TrendingTitleResponse?)-> Void){
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie\(apikey)&query=\(search)") else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result {
                
            case .success(_):
                do{
                    let res = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(true , res)
                }catch{
                    print(error.localizedDescription)
                    completion(false , nil)
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(false , nil)
            }
        }
    }
}
