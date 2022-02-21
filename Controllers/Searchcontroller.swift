//
//  Searchcontroller.swift
//  Netflix
//
//  Created by Amirkhouzam on 08/02/2022.
//

import AlamofireImage
import UIKit

protocol delegatesendata {
    
    func sendata(title : filmpreviewmodel)
    
}

class Searchcontroller: UIViewController  , UISearchBarDelegate{
    
    //MARK: - Constants
    
    var model:TrendingTitleResponse?
    var delegate : delegatesendata?
    
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
        
        /// Netflix logo
        
        let image = UIImage(named: "sss")
        let imgview = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        imgview.image = image
        imgview.contentMode = .scaleToFill
        let btn = UIBarButtonItem(customView: imgview)
        self.navigationItem.leftBarButtonItem = btn
        let widthConstraint = imgview.widthAnchor.constraint(equalToConstant: 55)
        let heightConstraint = imgview.heightAnchor.constraint(equalToConstant: 120)
        widthConstraint.isActive = true
        heightConstraint.isActive = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        ///Calling Data For Search Result
        
        Apicaller.shared.fetchdata(search: searchText) { check, res in
            self.model = res
            DispatchQueue.main.async {
                self.Collectionsearch.reloadData()
            }
        }
    }
    
    
}

//MARK: - Extension for Collectionview Delegate , Datasource And Scrolling Function

extension Searchcontroller : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.results.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Searchcell", for: indexPath) as! Searchcell
        
        ///Handling Name
        
        if let name = model?.results[indexPath.row].original_title{
            
            cell.filmlbl.text = name
        }
        
        ///Handling img
        
        if let img = model?.results[indexPath.row].poster_path {
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
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = model?.results[indexPath.row]
        if let filmname = title?.original_title {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Selectedmovie") as! Selectedmovie
            delegate?.sendata(title: filmpreviewmodel(title: filmname))
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
    }
}


