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
    
    
    func call_populars ( table : UITableView? , completion :@escaping(TrendingTitleResponse?) -> Void){
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
                    
                    completion(res)
                  
                    
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(nil)
            }
            
        }
    }
    
    
    func call_nowplaying ( table : UITableView? , completion :@escaping(TrendingTitleResponse?) -> Void){
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
                    
                    completion(res)
                  
                    
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(nil)
            }
            
        }
    }
    
    func call_latest ( table : UITableView? , completion :@escaping(TrendingTitleResponse?) -> Void){
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
                    
                    completion(res)
                  
                    
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(nil)
            }
            
        }
    }
    
    func call_toprated ( table : UITableView? , completion :@escaping(TrendingTitleResponse?) -> Void){
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
                    
                    completion(res)
                  
                    
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(nil)
            }
            
        }
    }
    
    func call_upcoming ( table : UITableView? , completion :@escaping(TrendingTitleResponse?) -> Void){
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
                    
                    completion(res)
                  
                    
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(nil)
            }
            
        }
    }
    
    func call_trendingmovies(table : UITableView ,completion : @escaping (TrendingTitleResponse?)-> Void){
        
        guard let url = URL(string: baseurl+trendingmovies+apikey) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let res = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(res)
                    DispatchQueue.main.async {
                        table.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                }
                
            case .failure(_):
                completion(nil)
            }
        }
        
    }
    
    func call_popular_tv(tableview : UITableView,completion : @escaping(TrendingTitleResponse?)-> Void){
        
        guard let url = URL(string: baseurl+populartv+apikey) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(result)
                    DispatchQueue.main.async {
                        tableview.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(nil)
            }
        }
    }
    
    func call_toprated_tv(table : UITableView ,completion : @escaping(TrendingTitleResponse?)-> Void){
        
        guard let url = URL(string: baseurl+topratedtv+apikey) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(result)
                    DispatchQueue.main.async {
                        table.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(nil)
            }
        }
    }
    func call_trending_tv(table :  UITableView, completion : @escaping(TrendingTitleResponse?)-> Void){
        
        guard let url = URL(string: baseurl+trendingtv+apikey) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(result)
                    DispatchQueue.main.async {
                        table.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(nil)
            }
        }
    }
    
    func fetchmovies(search : String , completion : @escaping(TrendingTitleResponse?)-> Void){
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie\(apikey)&query=\(search)") else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result {
                
            case .success(_):
                do{
                    let res = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(res)
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                }
            case .failure(_):
                print(response.error?.localizedDescription ?? "")
                completion(nil)
            }
        }
    }
    func fetchtvs(search : String , completion : @escaping(TrendingTitleResponse?)->  Void){
        guard let url = URL(string: "https://api.themoviedb.org/3/search/tv?api_key=9bf3ee16cadd8a8f4cd76be582e80814&query=\(search)") else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let res = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(res)
                }catch{
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    func postlogin(parameter : [String:Any]? , completion : @escaping(login?)->Void){
        guard let url = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=9bf3ee16cadd8a8f4cd76be582e80814") else {return}
        
        AF.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
            case .success(_):
                do{
                    let res = try JSONDecoder().decode(login.self, from: data)
                    completion(res)
                }catch{
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
}
