//
//  MyWatchlist.swift
//  Netflix
//
//  Created by Amirkhouzam on 21/02/2022.
//

import UIKit
import CoreData

class MyWatchlist: UIViewController {
    
    @IBOutlet weak var CollectionWatchlist: UICollectionView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    var ismovie : Bool?
    var countdata : Int?
    var data : [Film]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupui()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getdata()
        getcount()
    }
    func setupui(){
        
        
        
        /// Setup navigation barπ
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
    
        /// Register Cell
        
        CollectionWatchlist.register(UINib(nibName: "MyWatchlistcell", bundle: nil), forCellWithReuseIdentifier: "MyWatchlistcell")
        
        
        /// Font Size and Color for title
        
        self.navigationItem.title = "My Watchlist"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white , NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.CollectionWatchlist.backgroundColor = .black
        
        
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
    
    func getcount(){
        
        let predict:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Film")
        
        do{
            countdata = try context.count(for: predict)
            DispatchQueue.main.async {
                self.CollectionWatchlist.reloadData()
            }
        }catch{
            return
        }
        
    }
    func getdata(){
        
        coredatacaller.shared.getdataoffline(self: self) { film in
            self.data = film!
            
            DispatchQueue.main.async {
                self.CollectionWatchlist.reloadData()
            }
        }
    }
    
    
}
extension MyWatchlist : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return countdata ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyWatchlistcell", for: indexPath) as! MyWatchlistcell
        
        guard let filmss = data else {return UICollectionViewCell()}
        cell.filmname.text = filmss[indexPath.row].name
        if let image = filmss[indexPath.row].posterimage{
            getImage(imageurl+image) { image in
                
                cell.filmimage.image = image
            }
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width/2.5, height: height/3.5)
  }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let film = data?[indexPath.row] else {return}
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieController") as! MovieController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true) {
            
            vc.Releaselbl.text = "Release date : \( film.releasedate ?? "")"
            vc.Ratelabel.text = "\(film.voteaverage ) / 10 ⭐️"
            vc.filmname.text = film.name
            vc.filmdescription.text = film.overview
            vc.savemoviebtnoutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            Apicaller.shared.getvideoid(query: "\(film.name ?? "") official trailer") { response in
                guard let id = response?.items.first?.id.videoId else {return}
                
                vc.youtube.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(id)")!))
            }
            switch film.ismovie {
            case true : Apicaller.shared.getrecomendedmovie(movieid: Int(film.id)) { res in
                vc.result = res
            }
            case false : Apicaller.shared.getrecomendedtv(tvid: Int(film.id)) { res in
                vc.result = res
            }
            }
            
        }
        
        
    }
}
