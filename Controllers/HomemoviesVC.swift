//
//  HomemoviesVC.swift
//  Netflix
//
//  Created by Amirkhouzam on 27/01/2022.
//

import UIKit

class HomemoviesVC: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var TBView: UITableView!
    
    //MARK: - Constants
    var container : UIViewController?
    var popular : TrendingTitleResponse?
    var nowplaying : TrendingTitleResponse?
    var toprated : TrendingTitleResponse?
    var Trendingmovies : TrendingTitleResponse?
    var trendingtv : TrendingTitleResponse?
    var populartv : TrendingTitleResponse?
    var topratedtv : TrendingTitleResponse?
    
    //MARK: - Viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupui()
        getdata()
    }
    
    //MARK: - Functions
    
    func setupui(){
        
        ///Register Cell
        
        TBView.register(UINib(nibName: "TCell", bundle: nil), forCellReuseIdentifier: "TCell")
        
        ///TABLEVIEW delegate & datasource
        
        self.TBView.delegate = self
        self.TBView.dataSource = self
        
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.barTintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.TBView.backgroundColor = .black
        
        /// NETFLIX LOGO LEFT
        
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
        
        ///Title for navigationbar
        
        self.navigationItem.title = "Home"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white , NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        let customtabbar = UITabBarItem(title: "Home", image: UIImage(named: "homekit")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "homekit"))
        self.tabBarItem = customtabbar
    }
    
    
    
    func getdata(){
        Apicaller.shared.call_populars(table: TBView) { res in
            
            self.popular = res
        }
        Apicaller.shared.call_nowplaying(table: TBView) { res in
            
            self.nowplaying = res
        }
        Apicaller.shared.call_toprated(table: TBView) { res in
            
            self.toprated = res
        }
        Apicaller.shared.call_trendingmovies(table: TBView) { res in
            
            self.Trendingmovies = res
        }
        Apicaller.shared.call_popular_tv(tableview: TBView) { res in
            
            self.populartv = res
        }
        Apicaller.shared.call_toprated_tv(table: TBView) { res in
            
            self.topratedtv = res
        }
        Apicaller.shared.call_trending_tv(table: TBView) { res in
            
            self.trendingtv = res
        }
        
    }
    
}

//MARK: - Extension For Tableview Delegate , Datasource And Scrolling Function

extension HomemoviesVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCell" , for: indexPath) as! TCell
        
        cell.container = self
        switch indexPath.section{
            
        case 0 : cell.data = popular
        case 1 : cell.data = Trendingmovies
        case 2 : cell.data = toprated
        case 3 : cell.data = nowplaying
        case 4 : cell.data = populartv
        case 5 : cell.data = topratedtv
        case 6 : cell.data = trendingtv
            
        default:
            return UITableViewCell()
        }
    
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0 : return "Popular movies"
        case 1 : return "Trending movies"
        case 2 : return "Toprated movies"
        case 3 : return "Nowplaying Movies"
        case 4 : return "Popular TV"
        case 5 : return "Toprated TV"
        case 6 : return "Trending TV"
        default : return "Error"
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        
    }
    
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        UIView.animate(withDuration: 0.5) {
//            if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
//                self.navigationController?.navigationBar.alpha = 0.0
//            }else{
//                self.navigationController?.navigationBar.alpha = 1
//            }
//        }
//    }
//
    
}









