//
//  SignVC.swift
//  Netflix
//
//  Created by Amirkhouzam on 20/01/2022.
//

import UIKit


class SignVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupui()
        didchange()
        
    }
    //MARK: - Outlets
    
    @IBOutlet weak var Nametxt: UITextField!
    @IBOutlet weak var passtxt: UITextField!
    @IBOutlet weak var signoutlet: UIButton!
    @IBOutlet weak var errlbl: UILabel!
    
    //MARK: - IBActions
    
    @IBAction func Signinbtnpressed(_ sender: UIButton) {
        if let name = Nametxt.text {
            
            let vcc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbarVC") as! tabbarVC
            let parameter = ["username":"amiir" , "password" : "amir1234"]
            Apicaller.shared.postlogin(parameter: parameter) { res in
                print(res)
            }
            vcc.modalPresentationStyle = .fullScreen
            self.present(vcc, animated: true, completion: nil)
            
        }
        
        
    }
    @IBAction func Recoverpassbtnpressed(_ sender: UIButton) {
        
    }
    
    //MARK: - Helper Functions
    
    
    func didchange(){
        
        /// Adding Target For Name And Password TextField
        
        Nametxt.addTarget(self, action: #selector(self.textdidchange), for: .editingChanged)
        passtxt.addTarget(self, action: #selector(self.textdidchange), for: .editingChanged)
        
    }
    
    func setupui(){
        
        ///Setup Opening Screen For The First Time
        
        errlbl.isHidden = true
        signoutlet.isUserInteractionEnabled = false
        signoutlet.backgroundColor = .clear
        signoutlet.layer.borderColor = UIColor.black.cgColor
        
        ///Help Button
        
        let HelpBTN = UIButton(frame: CGRect(x: 180, y: -10, width: 50, height: 50))
        let SecondBtn = UIBarButtonItem(customView: HelpBTN)
        HelpBTN.addTarget(self, action: #selector(self.HelpBTNpressed), for: .touchUpInside)
        HelpBTN.setTitle("Help", for: .normal)
        HelpBTN.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        HelpBTN.titleLabel?.textColor = .white
        self.navigationItem.rightBarButtonItem = SecondBtn
        
        ///Logo Netflix For Title View
        
        let LOGO = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        LOGO.image = UIImage(named: "Netflix")
        LOGO.contentMode = .scaleAspectFit
        self.navigationItem.titleView = LOGO
        
        /// SetupUI For Sign In Button
        
        signoutlet.layer.cornerRadius = 5
        signoutlet.layer.borderWidth = 1
        signoutlet.layer.borderColor = UIColor.black.cgColor
        
        ///Setup BackButton
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-88-24"), style: .done, target: self, action: #selector(self.bckbtnaction))
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    @objc func bckbtnaction(){
        
        self.navigationController?.popViewController(animated: true)
    }
    @objc func HelpBTNpressed(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Webview") as! Webview
        self.present(vc, animated: true) {
            let url = URL(string: "https://help.netflix.com/en/")
            vc.webView.load(URLRequest(url: url!))
        }
    }
    @objc func textdidchange(){
        
        /// Disabling Sign in button when the Textfield is empty
        
        if Nametxt.text?.isEmpty == true || passtxt.text?.isEmpty == true {
                    signoutlet.isUserInteractionEnabled = false
                    signoutlet.backgroundColor = .clear
        }else if Nametxt.text?.isEmpty == false && passtxt.text?.isEmpty == false{
                    signoutlet.isUserInteractionEnabled = true
                    signoutlet.backgroundColor = .red
                }
        
    }
    
    

    
}
