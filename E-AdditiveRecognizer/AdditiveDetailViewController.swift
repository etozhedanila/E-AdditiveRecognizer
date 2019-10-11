//
//  CodeDetailViewController.swift
//  TextRecognizer
//
//  Created by Виталий Субботин on 03/10/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

class AdditiveDetailViewController: UIViewController {

    @IBOutlet weak var eCodeDescriptionLabel: UILabel!
    @IBOutlet weak var eCodeLabel: UILabel!
    @IBOutlet weak var eCodeNameLabel: UILabel!
    
    var additive: Additive?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureInterface()
    }
    
    private func configureInterface() {
        guard let additive = additive else { return }
        
        eCodeLabel.text = additive.code
        eCodeNameLabel.text = additive.name
        eCodeDescriptionLabel.text = additive.description
    }
    
}
