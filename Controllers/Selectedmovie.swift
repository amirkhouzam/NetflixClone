//
//  Selectedmovie.swift
//  Netflix
//
//  Created by Amirkhouzam on 14/02/2022.
//

import UIKit
import AlamofireImage
import WebKit
class Selectedmovie: UIViewController {
    
    var data : Title?
    var id : String?
    
    @IBOutlet weak var youtube: WKWebView!
    @IBOutlet weak var messagelabel: UILabel!
    @IBOutlet weak var messageview: UIView!
    @IBOutlet weak var Releaselbl: UILabel!
    @IBOutlet weak var Ratelabel: UILabel!
    @IBOutlet weak var filmname: UILabel!
    @IBOutlet weak var filmdescription: UILabel!
    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBOutlet weak var savemoviebtnoutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    @IBAction func Savedmovie(_ sender: UIButton) {
        
        
        let check = coredatacaller.shared.checkexist(filmname: filmname.text)
        switch check{
        case true: coredatacaller.shared.deleteattribute(filmname: filmname.text)
            savemoviebtnoutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            unsavedmessage()
            
        case false: coredatacaller.shared.insertdata(film: data, ismovie: nil)
            savemoviebtnoutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            savemessage()
        }
    }
    
    @IBAction func Backbtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func SetupUI(){
        
        /// Configure UI
        
        self.view.backgroundColor = .black
        filmname.textColor = .white
        filmdescription.textColor = .white
        Releaselbl.textColor = .white
        Ratelabel.textColor = .white
        messageview.alpha = 0
        messageview.layer.cornerRadius = 10
        messageview.backgroundColor = .black
        messagelabel.textColor = .white
        messagelabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        messagelabel.textAlignment = .center
        backbtnoutlet.backgroundColor = .black
        backbtnoutlet.layer.cornerRadius = backbtnoutlet.frame.height / 2
        
        /// Adding swipe gesture to dismiss
        
        let swipeleft  = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeback))
        swipeleft.direction = .right
        self.view.addGestureRecognizer(swipeleft)
    }
    func getimage(){
        
    }
    @objc func swipeback(){
        
        self.dismiss(animated: true, completion: nil)
    }
    func unsavedmessage(){
        messagelabel.text = "Removed from watchlist"
        UIView.animate(withDuration: 3) {
            self.messageview.alpha = 1
            self.messageview.alpha = 0
        }
    }
    func savemessage(){
        messagelabel.text = "Added to watchlist"
        UIView.animate(withDuration: 3) {
            self.messageview.alpha = 1
            self.messageview.alpha = 0
        }
        
    }
    
}

