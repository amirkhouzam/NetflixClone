//
//  TCell.swift
//  Netflix
//
//  Created by Amirkhouzam on 28/01/2022.
//

import UIKit
import AlamofireImage



class TCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var Collectionmovies: UICollectionView!
    
    //MARK: - Constants
    var container : UIViewController?
    var data : TrendingTitleResponse?{
        didSet{
            Collectionmovies.reloadData()
        }
    }
    var tableviewsection : Int?
    static let identifier_name = "TCell"
    
    //MARK: - AwakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        SetupScreen()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    //MARK: - Helper Functions
    
    func SetupScreen(){
        
        ///Setup CollectionView
        
        self.Collectionmovies.delegate = self
        self.Collectionmovies.dataSource = self
        Collectionmovies.register(UINib(nibName: "CCell", bundle: nil), forCellWithReuseIdentifier: "CCell")
        
        self.Collectionmovies.backgroundColor = .black
    }
    
}

//MARK: - Extension For Collectionview Delegate , DataSource

extension TCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data?.results.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! CCell
        
        ///Handling Name
        
        cell.namelbl.text = data?.results[indexPath.row].original_name ?? data?.results[indexPath.row].original_title
        
        ///Handling Img
        
        if let img = data?.results[indexPath.row].poster_path {

            let url = URL(string: "https://image.tmdb.org/t/p/w500\(img)")
            cell.filmimg.af.setImage(withURL: url!)
            cell.filmimg.contentMode = .scaleToFill
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: width / 4, height: height / 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Collectionmovies.deselectItem(at: indexPath, animated: true)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieController") as! MovieController
        
        guard let section = tableviewsection else {return}
        guard let contaner = container else {return}
        guard let film = data?.results[indexPath.row] else {return}
        vc.modalPresentationStyle = .fullScreen
        contaner.present(vc, animated: true) {
            
            /// Showing data in labels
            
            vc.filmname.text = film.original_title ?? film.original_name
            vc.filmdescription.text = film.overview
            vc.Ratelabel.text = "\(film.vote_average) / 10 ⭐️"
            vc.Releaselbl.text = "Release date : \(film.release_date ?? film.first_air_date ?? "")"
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
            
            switch section {
            case 0...3 : Apicaller.shared.getrecomendedmovie(movieid: film.id) { res in
                vc.result = res
                vc.Ismovie = true
            }
            case 4...6 : Apicaller.shared.getrecomendedtv(tvid: film.id) { res in
                vc.result = res
                vc.Ismovie = false
            }
            default:
                break;
            }
            
        }
    }

}

