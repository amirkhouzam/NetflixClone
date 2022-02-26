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
    
    var datapopular : TrendingTitleResponse?{
        didSet{
            Collectionmovies.reloadData()
        }
    }
    var datalates : TrendingTitleResponse?{
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
    }
    
}

//MARK: - Extension For Collectionview Delegate , DataSource

extension TCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return datapopular?.results.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! CCell
        
        ///Handling Name
        
        if let name = datapopular?.results[indexPath.row].original_title {
            
            cell.namelbl.text = name
        }
        
        ///Handling Img
        
        if let img = datapopular?.results[indexPath.row].poster_path {

            let url = URL(string: "https://image.tmdb.org/t/p/w500\(img)")
            cell.filmimg.af.setImage(withURL: url!)
            cell.filmimg.contentMode = .scaleToFill
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: width / 4, height: height / 5)
    }

}

