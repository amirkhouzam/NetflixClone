//
//  Selectedmovie.swift
//  Netflix
//
//  Created by Amirkhouzam on 14/02/2022.
//

import UIKit
import AlamofireImage
import CoreData
class Selectedmovie: UIViewController {
    
    
    @IBOutlet weak var Releaselbl: UILabel!
    @IBOutlet weak var Ratelabel: UILabel!
    @IBOutlet weak var filmimage: UIImageView!
    @IBOutlet weak var filmname: UILabel!
    @IBOutlet weak var filmdescription: UILabel!
    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBOutlet weak var savemoviebtnoutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        
    }
    @IBAction func Savedmovie(_ sender: UIButton) {
        
//        let predict = Film.fetchRequest()
//        do{
//            let result = try context.fetch(predict)
//            for res in result{
//                if filmname.text == res.name{
//                    savemoviebtnoutlet.imageView?.image = UIImage(named: "heart.fill")
//                }else{
//                    savemoviebtnoutlet.imageView?.image = UIImage(named: "heart")
//                }
//            }
//        }catch{
//
//        }
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
       
        
    }
   
}

