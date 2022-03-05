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
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Selectedmovie") as! Selectedmovie
        
        guard let contaner = container else {return}
        guard let film = data?.results[indexPath.row] else {return}
        guard let test = film.backdrop_path else {return}
        guard let url = URL(string: imageurl+test) else {return}
        vc.modalPresentationStyle = .fullScreen
        contaner.present(vc, animated: true) {
            vc.filmname.text = film.original_title ?? film.original_name
            vc.filmdescription.text = film.overview
            vc.Ratelabel.text = "\(film.vote_average) / 10 ⭐️"
            vc.Releaselbl.text = "Release date : \(film.release_date ?? film.first_air_date ?? "")"
            vc.filmimage.af.setImage(withURL: url)
            vc.filmimage.contentMode = .scaleAspectFill
        }
        
        
    }

}

