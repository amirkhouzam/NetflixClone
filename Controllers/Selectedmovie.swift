//
//  Selectedmovie.swift
//  Netflix
//
//  Created by Amirkhouzam on 14/02/2022.
//

import UIKit

class Selectedmovie: UIViewController {
    
    
    var model : filmpreviewmodel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Searchcontroller") as! Searchcontroller
        vc.delegate = self
        print(model?.title)
    }
   
    var data : Title?{
        didSet{
            filmname.text = data?.original_title
        }
    }
    @IBOutlet weak var filmimage: UIImageView!
    @IBOutlet weak var filmname: UILabel!
    
    @IBOutlet weak var filmdescription: UILabel!
    func configure(title : filmpreviewmodel){
        model = title
        filmname.text = title.title
        print(title.title)
    }
}
extension Selectedmovie : delegatesendata {
    func sendata(title: filmpreviewmodel) {
        print(title.title)
    }
    
    
}
