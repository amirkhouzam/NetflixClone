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
    var countdata : Int?
    var data : [Film] = []
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
        
        /// Setup navigation bar
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
    
        /// Register Cell
        
        CollectionWatchlist.register(UINib(nibName: "MyWatchlistcell", bundle: nil), forCellWithReuseIdentifier: "MyWatchlistcell")
        
        
        /// Font Size and Color for title
        
        self.navigationItem.title = "My Watchlist"
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
        
        /// profile image
        
        let imageview = UIImageView(frame: CGRect(x: 350, y: 0, width: 45, height: 45))
        let img = UIImage(named: "user-48")
        imageview.image = img
        imageview.contentMode = .scaleToFill
        let secondbtn = UIBarButtonItem(customView: imageview)
        self.navigationItem.rightBarButtonItem = secondbtn
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
        
        getdataoffline(self: self) { film in
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
        
        if let url = data[indexPath.row].urlimage{
            stringtoimage(encodedimage: url) { image in
                cell.filmimage.contentMode = .scaleToFill
                cell.filmimage.image = image
                
            }
        }
            cell.filmname.text = data[indexPath.row].name
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width/2.5, height: height/3.5)
  }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        UIView.animate(withDuration: 0.5) {
            if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
                self.navigationController?.navigationBar.alpha = 0.0
            }else{
                self.navigationController?.navigationBar.alpha = 1
            }
        }
    }
}
