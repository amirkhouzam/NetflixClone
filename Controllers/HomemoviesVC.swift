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
    
    var popular : Title?
    
    //MARK: - Viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupui()
        
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
        
        ///PROFILE IMAGE RIGHT
        
        let imageview = UIImageView(frame: CGRect(x: 350, y: 0, width: 45, height: 45))
        let img = UIImage(named: "user-48")
        imageview.image = img
        imageview.contentMode = .scaleToFill
        let secondbtn = UIBarButtonItem(customView: imageview)
        self.navigationItem.rightBarButtonItem = secondbtn
        
    }
    
}

//MARK: - Extension For Tableview Delegate , Datasource And Scrolling Function

extension HomemoviesVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCell" , for: indexPath) as! TCell
        
        
            Apicaller.shared.call_populars(table: TBView) { check, res in
                
                /// Moving Data To The Cell
                
                cell.datapopular = res
                
            }
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Popular"
        }else if section == 1 {
            return "Now Playing"
        }else{
            return "Top Rated"
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return height / 4
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









