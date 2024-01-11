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
    
    @IBOutlet weak var disconnectButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disconnectButton.addTarget(self, action: #selector(disconnect), for: .touchUpInside)
        
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

                                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
                                    nameLabel.isUserInteractionEnabled = true
                                    nameLabel.addGestureRecognizer(tapGesture)
                                    
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

    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        if let tappedLabel = sender.view as? UILabel {
            if let labelName = tappedLabel.text {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let destinationVC = storyboard.instantiateViewController(withIdentifier: "ViewListController") as? ViewListController {
                    destinationVC.labelName = labelName
                    
                    present(destinationVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func disconnect() {
        do {
            try Auth.auth().signOut()
            
            print("Déconnexion réussie")
        } catch let signOutError as NSError {
            print("Erreur : %@", signOutError)
        }
    }
}
