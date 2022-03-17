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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
        self.TBView.backgroundColor = .black
        self.view.backgroundColor = .black
        
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
        
        ///Fetching data
        
        Apicaller.shared.call_upcoming(table: TBView) {  res in
            
            self.data = res
            
        }
       
    }
    @objc func homescreen(){
        self.tabBarController?.selectedIndex = 0
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
            
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(img)") else {return UITableViewCell()}
            
            cell.filmimg.af.setImage(withURL: url)
            cell.filmimg.contentMode = .scaleToFill
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return height / 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let film = data?.results[indexPath.row] else {return}
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieController") as! MovieController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true) {
            
            /// Showing data in labels
            
            vc.filmname.text = film.original_title ?? film.original_name ?? "Something went wrong"
            vc.Releaselbl.text = "Release date : \(film.release_date ?? "")"
            vc.Ratelabel.text = "\(film.vote_average) / 10 ⭐️"
            vc.filmdescription.text = film.overview
            vc.core_data = film
            
            /// Checking if saved
            
            let check = coredatacaller.shared.checkexist(filmname: film.original_title ?? film.original_name)
            switch check{
            case true:vc.savemoviebtnoutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            case false:vc.savemoviebtnoutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            
            /// Showing trailer
            
            Apicaller.shared.getvideoid(query: "\(film.original_title ?? film.original_name ?? "") official trailer") { response in
                guard let id = response?.items.first?.id.videoId else {return}
                
                vc.youtube.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(id)")!))
            }
            
            /// Calling api for collectionview
            
            Apicaller.shared.getrecomendedmovie(movieid: film.id) { res in
                
                vc.result = res
                vc.Ismovie = true
            }
        }
            
    }
    
}
