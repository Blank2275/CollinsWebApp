//
//  ViewController.swift
//  CollinsWebApp
//
//  Created by Connor Reed on 7/5/22.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var needsHelpCirlceView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        needsHelpCirlceView.layer.cornerRadius = ((needsHelpCirlceView.bounds.width + needsHelpCirlceView.bounds.height) / 4)
        needsHelpCirlceView.layer.backgroundColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 1)
        
        colorCirlce()
        
        Firestore.firestore().collection("test").document("oof").addSnapshotListener({ documentSnapshot, error in
            print("run")
            self.colorCirlce()
        })
    }
    
    func colorCirlce(){
        let docRef = Firestore.firestore().collection("test").document("oof")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!
                let needsHelp = dataDescription["needsHelp"]!
                if(needsHelp) as! Bool{
                    self.needsHelpCirlceView.layer.backgroundColor = CGColor.init(red: 0, green: 255, blue: 0, alpha: 1)
                }else{
                    self.needsHelpCirlceView.layer.backgroundColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 1)
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}
