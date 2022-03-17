//
//  Searchcontroller.swift
//  Netflix
//
//  Created by Amirkhouzam on 08/02/2022.
//

import AlamofireImage
import UIKit



class Searchcontroller: UIViewController  , UISearchBarDelegate{
    
    //MARK: - Constants
    var ismovie : Bool?
    var data:TrendingTitleResponse?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var Searchbar: UISearchBar!
    @IBOutlet weak var Collectionsearch: UICollectionView!
    
    //MARK: - Viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupscreen()
    }
    
    //MARK: - Helper Functions
    
    func setupscreen(){
        
        /// Setup Collectionview and Register Cell
        
        Collectionsearch.register(UINib(nibName: "Searchcell", bundle: nil), forCellWithReuseIdentifier: "Searchcell")
        Collectionsearch.dataSource = self
        Collectionsearch.delegate = self
        
        /// Setup navigation title and color
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.title = "Search"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white , NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.Collectionsearch.backgroundColor = .black
        self.view.backgroundColor = .black
        self.Searchbar.backgroundColor = .black
        self.Searchbar.barTintColor = .black
        self.Searchbar.barStyle = .black
        self.Searchbar.tintColor = .white
        self.Searchbar.scopeButtonTitles = ["Movies" , "TV"]
        self.Searchbar.showsScopeBar = true
        /// Netflix logo
        
        let image = UIImage(named: "sss")
        let imgview = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        imgview.image = image
        imgview.contentMode = .scaleToFill
        let btn = UIBarButtonItem(customView: imgview)
        btn.target = self
        btn.action = #selector(self.homescreen)
        self.navigationItem.leftBarButtonItem = btn
        let widthConstraint = imgview.widthAnchor.constraint(equalToConstant: 55)
        let heightConstraint = imgview.heightAnchor.constraint(equalToConstant: 120)
        widthConstraint.isActive = true
        heightConstraint.isActive = true
    }
    @objc func homescreen(){
        self.tabBarController?.selectedIndex = 0
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ///Calling Data For Search Result
        if Searchbar.selectedScopeButtonIndex == 0{
            
            Apicaller.shared.fetchmovies(search: searchText) { res in
                self.data = res
                self.ismovie = true
                DispatchQueue.main.async {
                    self.Collectionsearch.reloadData()
                }
            }
        }else if searchBar.selectedScopeButtonIndex == 1 {
            Apicaller.shared.fetchtvs(search: searchText) { res in
                self.data = res
                self.ismovie = false
                DispatchQueue.main.async {
                    self.Collectionsearch.reloadData()
                }
            }
        }
        
        
    }
}
//MARK: - Extension for Collectionview Delegate , Datasource And Scrolling Function

extension Searchcontroller : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Searchcell", for: indexPath) as! Searchcell
        
        ///Handling Name
        
        if let name = data?.results[indexPath.row].original_title{
            
            cell.filmlbl.text = name
        }
        
        ///Handling img
        
        if let img = data?.results[indexPath.row].poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(img)")
            cell.filmimg.af.setImage(withURL: url!)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: width/2.5, height: height/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let film = data?.results[indexPath.row] else {return}
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieController") as! MovieController
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true) {
            
            /// Showing data in labels
            
            vc.filmname.text = film.original_title ?? film.original_name
            vc.Releaselbl.text = "Release date : \(film.release_date ?? film.first_air_date ?? "")"
            vc.Ratelabel.text = "\(film.vote_average) / 10 ⭐️"
            vc.filmdescription.text = film.overview
            vc.core_data = film
            
            /// Checking if the movie is saved
            
            let check = coredatacaller.shared.checkexist(filmname: film.original_title ?? film.original_name ?? "")
            switch check{
            case true:vc.savemoviebtnoutlet.setImage(UIImage(systemName:"heart.fill"), for: .normal)
            case false:vc.savemoviebtnoutlet.setImage(UIImage(systemName: "heart"), for: .normal)
                
            }
            
            /// Showing the trailer
            
            Apicaller.shared.getvideoid(query: "\(film.original_title ?? film.original_name ?? "") official trailer") { response in
                guard let id = response?.items[0].id.videoId else {return}
                
                vc.youtube.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(id)")!))
            }
            
            /// Checking movie or tv to call the recommended
            
            switch self.ismovie {
            case true : Apicaller.shared.getrecomendedmovie(movieid: film.id) { res in
                vc.result = res
                vc.Ismovie = true
            }
            case false : Apicaller.shared.getrecomendedtv(tvid: film.id) { res in
                vc.result = res
                vc.Ismovie = false
            }
            default:
                break;
            }
            
        }
        
    }
    
}


