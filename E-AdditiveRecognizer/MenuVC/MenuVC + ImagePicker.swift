//
//  MenuVC + ImagePicker.swift
//  TextRecognizer
//
//  Created by Виталий Субботин on 02/10/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

extension MenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        self.pickedImage = image
        
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "recognitionSegue", sender: self)
        }
        
        
    }
}
