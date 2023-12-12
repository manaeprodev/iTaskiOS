//
//  NewListController.swift
//  MonProjet
//
//  Created by etudiant on 12/12/2023.
//

import SwiftUI

class NewListController: UIViewController {
    
    
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        print("Coucou, le bouton est cliqué")
    }
    
}

