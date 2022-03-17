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
    
    //MARK: - MOVIES
    func call_populars ( table : UITableView? , completion :@escaping(TrendingTitleResponse?) -> Void){
        guard let url = URL(string: baseurl+categorypopular+tmdbapikey) else {return}
        
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
        guard let url = URL(string: baseurl+categorynowplaying+tmdbapikey) else {return}
        
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
                        table?.reloadData()
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
        guard let url = URL(string: baseurl+categorytoprated+tmdbapikey) else {return}
        
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
        guard let url = URL(string: baseurl+categoryupcoming+tmdbapikey) else {return}
        
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
                        table?.reloadData()
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
        
        guard let url = URL(string: baseurl+trendingmovies+tmdbapikey) else {return}
        
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
    
    //MARK: - TVS
    
    func call_popular_tv(tableview : UITableView,completion : @escaping(TrendingTitleResponse?)-> Void){
        
        guard let url = URL(string: baseurl+populartv+tmdbapikey) else {return}
        
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
        
        guard let url = URL(string: baseurl+topratedtv+tmdbapikey) else {return}
        
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
        
        guard let url = URL(string: baseurl+trendingtv+tmdbapikey) else {return}
        
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
    
    //MARK: - SEARCH MOVIES AND TVS
    
    func fetchmovies(search : String , completion : @escaping(TrendingTitleResponse?)-> Void){
        guard let url = URL(string: searchmovie+search) else {return}
        
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
        guard let url = URL(string: searchtvs+search) else {return}
        
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
    //MARK: - Login APIS
    
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
    
    //MARK: - YOUTUBE APIS
    
    func getvideoid(query : String , completion : @escaping(YoutubeSearchResponse?)-> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(youtubebaseurl)\(query)\(youtubeapikey)") else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                    completion(result)
                }catch{
                    completion(nil)
                    print(error.localizedDescription)
                }
            case .failure(_):
                completion(nil)
            }
        }
        
        
    }
    
    
    
    //MARK: - RECOMMENDED MOVIES AND TVS
    
    func getrecomendedmovie(movieid : Int, completion : @escaping(TrendingTitleResponse?)-> Void){
        
        
        guard let url = URL(string: baseurl+"/movie/\(movieid)/recommendations"+tmdbapikey) else {return}
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(result)
                }catch{
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    func getrecomendedtv(tvid : Int, completion : @escaping(TrendingTitleResponse?)-> Void){
        
        
        guard let url = URL(string: baseurl+"/tv/\(tvid)/recommendations"+tmdbapikey) else {return}
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(result)
                }catch{
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    //MARK: - SIMILAR MOVIES AND TVS
    
    func getsimilartv(tvid : Int, completion : @escaping(TrendingTitleResponse?)-> Void){
        
        
        guard let url = URL(string: baseurl+"/tv/\(tvid)/similar"+tmdbapikey) else {return}
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(result)
                }catch{
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getsimilarmovies(movieid : Int, completion : @escaping(TrendingTitleResponse?)-> Void){
        
        
        guard let url = URL(string: baseurl+"/movie/\(movieid)/similar"+tmdbapikey) else {return}
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: httpheader).responseData { response in
            
            guard let data = response.data else {return}
            
            switch response.result{
                
            case .success(_):
                do{
                    let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(result)
                }catch{
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
}
