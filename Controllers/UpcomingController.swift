//
//  UpcomingController.swift
//  Netflix
//
//  Created by Amirkhouzam on 18/02/2022.
//

import UIKit
import AlamofireImage
import CoreData

class UpcomingController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var TBView: UITableView!
    
    //MARK: - Constants
    
    var data : TrendingTitleResponse?
    
    //MARK: - Viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupscreen()
    }
    
    //MARK: - Helper functions
    
    func setupscreen(){
        
        ///Setup tableview
        
        TBView.register(UINib(nibName: "UpcomingCell", bundle: nil), forCellReuseIdentifier: "UpcomingCell")
        TBView.delegate = self
        TBView.dataSource = self
        TBView.separatorStyle = .none
        
        /// Setup Navigation bar For title and color
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.title = "Upcoming Movies"
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
        
        ///Fetching data
        
        Apicaller.shared.call_upcoming(table: TBView) { check, res in
            
            self.data = res
            
        }
       
    }

}

//MARK: - Extensions for Tableview Delegate and Datasource , Scrolling Functions

extension UpcomingController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data?.results.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TBView.dequeueReusableCell(withIdentifier: "UpcomingCell", for: indexPath) as! UpcomingCell
        
        /// Handling Name
        
        if let name = data?.results[indexPath.row].original_title{
            
            cell.filmname.text = name
        }
        
        /// Handling images
        
        if let img = data?.results[indexPath.row].poster_path{
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(img)")
            
            cell.filmimg.af_setImage(withURL: url!)
            cell.filmimg.contentMode = .scaleToFill
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return height / 5
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let Savemovie = UIContextualAction(style: .normal, title: "Add To Watchlist") { action, view,completion  in
            
            let film = self.data?.results[indexPath.row]
            
            if let img = film?.poster_path{
                
                let object = NSEntityDescription.insertNewObject(forEntityName: "Film", into: context) as! Film
                
                object.name = film?.original_title
                object.overview = film?.overview
                print(img)
                getImage("https://image.tmdb.org/t/p/w500\(img)") { imgs in
                    
                    let imgstring = imagetostring(image: imgs!)
                    object.urlimage = imgstring
                    
                }
                
                context.insert(object)
                do{
                    try context.save()
                    
                }catch{
                    
                        let alert = UIAlertController(title: "Error", message: "Cannot Add It To Your Watchlist", preferredStyle: .alert)
                        let alertaction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                        alert.addAction(alertaction)
                        self.present(alert, animated: true, completion: nil)
                }
                
            }
            
        }
        
        let swipe = UISwipeActionsConfiguration(actions: [Savemovie])
        
        return swipe
        
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
    //TODO Didselect movie
    
}
