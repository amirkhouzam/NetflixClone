//
//  ViewController.swift
//  Netflix
//
//  Created by Amirkhouzam on 18/01/2022.
//

import UIKit
import CoreData
import Alamofire

class Home: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var PGControl: UIPageControl!
    @IBOutlet weak var SignBTN: UIButton!
    @IBOutlet weak var HomeCV: UICollectionView!
    
    //MARK: - Viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setbarbutton()
        PGControl.pageIndicatorTintColor = .gray
        PGControl.currentPageIndicatorTintColor = .red

    }
    //MARK: - Constants
    
    let imagess = [UIImage(named: "net 1"),UIImage(named: "net 3"),UIImage(named: "net 2"),UIImage(named: "net 4")]
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Functions
    
    func setbarbutton(){
        
        ///PRIVACY BUTTON
        
        let PrivacyBTN = UIButton(frame: CGRect(x: 220, y: -10, width: 50, height: 50))
        let firstBTN = UIBarButtonItem(customView: PrivacyBTN)
        PrivacyBTN.addTarget(self, action: #selector(self.PrivacyBTNPRESSED), for: .touchUpInside)
        PrivacyBTN.setTitle("Privacy", for: .normal)
        PrivacyBTN.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        PrivacyBTN.titleLabel?.textColor = .white
        
        ///Help Button
        
        let HelpBTN = UIButton(frame: CGRect(x: 180, y: -10, width: 50, height: 50))
        let SecondBtn = UIBarButtonItem(customView: HelpBTN)
        HelpBTN.addTarget(self, action: #selector(self.HelpBTNpressed), for: .touchUpInside)
        HelpBTN.setTitle("Help", for: .normal)
        HelpBTN.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        HelpBTN.titleLabel?.textColor = .white
        self.navigationItem.rightBarButtonItems = [firstBTN , SecondBtn]
        
        ///image view
        
        let LOGO = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
        LOGO.image = UIImage(named: "Netflix")
        LOGO.contentMode = .scaleAspectFit
        let thirdbtn = UIBarButtonItem(customView: LOGO)
        let widthConstraint = LOGO.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = LOGO.heightAnchor.constraint(equalToConstant: 100)
        widthConstraint.isActive = true
        heightConstraint.isActive = true
        self.navigationItem.leftBarButtonItem = thirdbtn
        
        ///register nib
        
        HomeCV.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
    }

    //MARK: - IBActions
    
    @IBAction func SignBTNpressed(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignVC") as! SignVC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func PrivacyBTNPRESSED(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Webview") as! Webview
        self.present(vc, animated: true) {
            let url = URL(string: "https://help.netflix.com/legal/privacy")
            vc.webView.load(URLRequest(url: url!))
        }
    }
    @objc func HelpBTNpressed(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Webview") as! Webview
        self.present(vc, animated: true) {
            let url = URL(string: "https://help.netflix.com/en/")
            vc.webView.load(URLRequest(url: url!))
        }
    }
    
}

//MARK: - Extension For Collectionview Delegate , Datasource

extension Home : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagess.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = HomeCV.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        cell.Homeimgview.image = imagess[indexPath.row]
        cell.Homeimgview.contentMode = .scaleAspectFill
        cell.Boldlbl.text = homemodel.Flbl[indexPath.row]
        cell.basiclbl.text = homemodel.slbl[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        self.PGControl.currentPage = indexPath.row
        PGControl.numberOfPages = imagess.count
        
    }
    
   
}
