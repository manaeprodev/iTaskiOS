//
//  ListsController.swift
//  MonProjet
//
//  Created by etudiant on 12/12/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

class ListsController: UIViewController {
    
    var results : [String: Any]?
    
    @IBOutlet weak var monStackView: UIStackView!
    
    @IBOutlet weak var currentUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = Auth.auth().currentUser {
            let email = currentUser.email
            let userLists = Firestore.firestore().collection(email ?? "")
            
            self.currentUser.text = email
            
            userLists.getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print("Error : ", error)
                        } else {
                            for document in querySnapshot!.documents {
                                if document.documentID == "results" {
                                    self.results = document.data()
                                } else {
                                    let name = document.documentID
                                        
                                    print(name)
                                    let nameLabel = UILabel()
                                    nameLabel.text = name
                                    nameLabel.textAlignment = .center
                                    nameLabel.textColor = .white
                                    nameLabel.backgroundColor = UIColor.systemTeal
                                    nameLabel.layer.cornerRadius = 10
                                    nameLabel.clipsToBounds = true
                                    nameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

                                    self.monStackView.addArrangedSubview(nameLabel)
                                    
                                }
                            }
                        }
                        
                        //print(self.results as Any)
                    }
        } else {
            print("Error : No user.")
        }

        
    }

}
