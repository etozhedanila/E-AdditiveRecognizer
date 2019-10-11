//
//  CameraViewController + photoOutput.swift
//  TextRecognizer
//
//  Created by Виталий Субботин on 13/09/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit
import AVFoundation

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else { return }
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        
        self.photoImage = UIImage(data: imageData)
        
        performSegue(withIdentifier: "effectsSegue", sender: self)
        
        
    }
    
}
