//
//  MovieController.swift
//  Netflix
//
//  Created by Amirkhouzam on 13/03/2022.
//

import UIKit
import WebKit
import AlamofireImage

class MovieController: UIViewController {

    @IBOutlet weak var Relatedfilmcollection: UICollectionView!
    @IBOutlet weak var similartext: UILabel!
    @IBOutlet weak var relatedtext: UILabel!
    @IBOutlet weak var similarview: UIView!
    @IBOutlet weak var Relatedview: UIView!
    @IBOutlet weak var morelikethislbl: UILabel!
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var youtube: WKWebView!
    @IBOutlet weak var messagelabel: UILabel!
    @IBOutlet weak var messageview: UIView!
    @IBOutlet weak var Releaselbl: UILabel!
    @IBOutlet weak var Ratelabel: UILabel!
    @IBOutlet weak var filmname: UILabel!
    @IBOutlet weak var filmdescription: UILabel!
    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBOutlet weak var savemoviebtnoutlet: UIButton!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    var Ismovie : Bool?
    var core_data : Title?
    var result : TrendingTitleResponse?{
        didSet{
            Relatedfilmcollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        
    }
    func SetupUI(){
        
        /// Configure UI
        
        self.view.backgroundColor = .black
        filmname.textColor = .white
        filmdescription.textColor = .white
        Releaselbl.textColor = .white
        Ratelabel.textColor = .white
        
        
        /// Configure Message view and message label
        
        messageview.alpha = 0
        messageview.layer.cornerRadius = 10
        messageview.backgroundColor = .black
        messageview.layer.shadowOffset = CGSize(width: 5, height: 8)
        messageview.layer.shadowColor = CGColor(gray: 1, alpha: 1)
        messagelabel.textColor = .white
        messagelabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        messagelabel.textAlignment = .center
        
        /// Configure Back button
        
        backbtnoutlet.backgroundColor = .black
        backbtnoutlet.layer.cornerRadius = backbtnoutlet.frame.height / 2
        
        /// Adding swipe gesture to dismiss
        
        let swipeleft  = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeback))
        swipeleft.direction = .right
        self.view.addGestureRecognizer(swipeleft)
        
        /// Collectionview Configuration
        
        Relatedfilmcollection.delegate = self
        Relatedfilmcollection.dataSource = self
        Relatedfilmcollection.register(UINib(nibName: "RelatedCell", bundle: nil), forCellWithReuseIdentifier: "RelatedCell")
        
        /// Enable Scrolling
        
        self.scroller.isScrollEnabled = true
        
        
        /// Configure Related , Similar and morelikethis labels
        
        morelikethislbl.text = "More like this"
        morelikethislbl.textColor = .white
        morelikethislbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        relatedtext.text = "Related"
        similartext.text = "Similar"
        relatedtext.textColor = .white
        similartext.textColor = .white
        relatedtext.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        similartext.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        relatedtext.textColor = .white
        similartext.textColor = .white
        similarview.backgroundColor = .clear
        
        /// Adding tap gesture to Similar and related label
        
        let taplblsimilar = UITapGestureRecognizer(target: self, action: #selector(self.tapsimilar))
        let taplblrelated = UITapGestureRecognizer(target: self, action: #selector(self.taprelated))
        self.Relatedview.addGestureRecognizer(taplblrelated)
        self.similarview.addGestureRecognizer(taplblsimilar)
        
        /// Calling api to collection view
        
            }
    @objc func tapsimilar(){
        similarview.backgroundColor = .red
        Relatedview.backgroundColor = .clear
        guard let id = core_data?.id else {return}
        switch Ismovie {
        case true : Apicaller.shared.getsimilarmovies(movieid: id) { res in
            self.result = res
        }
        case false : Apicaller.shared.getsimilartv(tvid: id) { res in
            
            self.result = res
        }
        default : break;
        }
    }
    @objc func taprelated(){
        similarview.backgroundColor = .clear
        Relatedview.backgroundColor = .red
        guard let id = core_data?.id else {return}
        switch Ismovie {
        case true : Apicaller.shared.getrecomendedmovie(movieid: id) { res in
            self.result = res
        }
        case false : Apicaller.shared.getrecomendedtv(tvid: id) { res in
            
            self.result = res
        }
        default : break;
        }
    }
    @IBAction func Savedmovie(_ sender: UIButton) {
        
        
        let check = coredatacaller.shared.checkexist(filmname: filmname.text)
        switch check{
        case true: coredatacaller.shared.deleteattribute(filmname: filmname.text)
            savemoviebtnoutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            unsavedmessage()
            
        case false: coredatacaller.shared.insertdata(film: core_data, ismovie: Ismovie)
            savemoviebtnoutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            savemessage()
        }
    }
    
    @IBAction func Backbtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func swipeback(){
        
        self.dismiss(animated: true, completion: nil)
    }
    func unsavedmessage(){
        messagelabel.text = "Removed from watchlist"
        UIView.animate(withDuration: 3) {
            self.messageview.alpha = 1
            self.messageview.alpha = 0
        }
    }
    func savemessage(){
        messagelabel.text = "Added to watchlist"
        UIView.animate(withDuration: 3) {
            self.messageview.alpha = 1
            self.messageview.alpha = 0
        }
        
    }

}
extension MovieController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return result?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = Relatedfilmcollection.dequeueReusableCell(withReuseIdentifier: "RelatedCell", for: indexPath) as! RelatedCell
        
        cell.filmnamelbl.text = result?.results[indexPath.row].original_title
        
        if let img = result?.results[indexPath.row].poster_path{
            
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(img)") else {return UICollectionViewCell()}
            
            cell.filmimage.af.setImage(withURL: url)
            cell.filmimage.contentMode = .scaleToFill
        }
        

        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: width / 3, height: height / 4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let film = result?.results[indexPath.row] else {return}
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieController") as! MovieController
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true) {
           
            /// Showing data in labels
            
            vc.filmname.text = film.original_title ?? film.original_name
            vc.Releaselbl.text = "Release date : \(film.release_date ?? film.first_air_date ?? "")"
            vc.Ratelabel.text = "\(film.vote_average) / 10 ⭐️"
            vc.filmdescription.text = film.overview
            vc.core_data = film
            vc.Ismovie = self.Ismovie
            
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
            
            /// Calling data for collectionview
            
            switch self.Ismovie {
            case true : Apicaller.shared.getrecomendedmovie(movieid: film.id) { res in
                vc.result = res
            }
            case false : Apicaller.shared.getrecomendedtv(tvid: film.id) { res in
                
                vc.result = res
            }
            default : break;
            }
        }
        
    }
    
    
    
    
    
    
    
}
