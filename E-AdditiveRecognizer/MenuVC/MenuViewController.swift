//
//  MenuViewController.swift
//  TextRecognizer
//
//  Created by Виталий Субботин on 02/10/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var imagePickerController: UIImagePickerController?
    var pickedImage: UIImage?
    
    @IBAction func openPhotoLibrary(_ sender: UIButton) {
        guard let imagePickerController = imagePickerController else { return }
        imagePickerController.modalPresentationStyle = .fullScreen
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupImagePickerController()
    }
    
    private func setupImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePickerController = UIImagePickerController()
            
            guard let imagePickerController = imagePickerController else { return }
            
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RecognitionViewController {
            
            vc.image = pickedImage
        }
    }

}

