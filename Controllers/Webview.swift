//
//  Webview.swift
//  Netflix
//
//  Created by Amirkhouzam on 03/03/2022.
//

import UIKit
import WebKit

class Webview: UIViewController {
    
    let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: height, height: width))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupui()
        
    }
    func setupui(){
        self.navigationController?.navigationBar.backgroundColor = .black
        self.view.addSubview(webView)
        
        
        
        let LOGO = UIImageView(frame: CGRect(x: width-50, y: 0, width: 120, height: 50))
        LOGO.image = UIImage(named: "Netflix")
        LOGO.contentMode = .scaleAspectFit
        let thirdbtn = UIBarButtonItem(customView: LOGO)
        let widthConstraint = LOGO.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = LOGO.heightAnchor.constraint(equalToConstant: 100)
        widthConstraint.isActive = true
        heightConstraint.isActive = true
        self.navigationItem.leftBarButtonItem = thirdbtn
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-88-24"), style: .done, target: self, action: #selector(self.bckbtnaction))
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func bckbtnaction(){
        
        self.dismiss(animated: true, completion: nil)
    }
}
