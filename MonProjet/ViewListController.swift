//
//  ViewListController.swift
//  MonProjet
//
//  Created by etudiant on 08/01/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ViewListController: UIViewController {
    
    @IBOutlet weak var wordsList: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var trainButton: UIButton!
    
    var labelName: String?
    
    let db = Firestore.firestore()
    
    var collectionName = ""
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        trainButton.addTarget(self, action: #selector(trainButtonTapped), for: .touchUpInside)
        
        if let currentUser = Auth.auth().currentUser {
                       let email = currentUser.email
            collectionName = email ?? ""
                   }
        if let labelName = labelName {
            titleLabel.text = "Liste '\(labelName)'"
            let documentName = labelName
            
            let documentReference = db.collection(collectionName).document(documentName)
            
            documentReference.getDocument { (document, error) in
                if let error = error {
                    print("Error : ", error)
                } else if let document = document, document.exists {
                    if let data = document.data() {
                        
                        for (key, value) in data {
                            
                            let wordAndMatch = UILabel()
                            wordAndMatch.text = "\(key) ---> \(value)"
                            self.wordsList.addArrangedSubview(wordAndMatch)
                            
                        }
                    }
                } else {
                    print("Le document demandé n'existe pas.")
                }
            }
        }
    }
    @objc func trainButtonTapped() {
        let alertController = UIAlertController(title: "Ready?", message: "Challange yourself and go for this list?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) {_ in
            print("Yes")
        }
        alertController.addAction(yesAction)
        
        let noAction = UIAlertAction(title: "No", style: .cancel) {_ in
            print("No")
        }
        alertController.addAction(noAction)
        
        present(alertController, animated:true, completion: nil)
    }
}
