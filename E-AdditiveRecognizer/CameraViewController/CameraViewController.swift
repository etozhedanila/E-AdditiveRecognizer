//
//  ViewController.swift
//  TextRecognizer
//
//  Created by Виталий Субботин on 03/07/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraImageView: UIImageView!
    
    var captureSession: AVCaptureSession?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var photoImage: UIImage?
    
    @IBAction func takePhotoButtonTapped(_ sender: UIButton) {

        guard let capturePhotoOutput = capturePhotoOutput else { return }
        let settings = AVCapturePhotoSettings()
        
        settings.isAutoStillImageStabilizationEnabled = true
        settings.isHighResolutionPhotoEnabled = true
        settings.flashMode = .auto
        
        capturePhotoOutput.capturePhoto(with: settings, delegate: self)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
    }

    private func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            
            guard let output = capturePhotoOutput, let captureSession = captureSession else { return }
            
            captureSession.addInput(input)
            captureSession.addOutput(output)
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            
            guard let previewLayer = previewLayer else { return }
            
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewLayer.frame = self.view.layer.bounds
            
            cameraImageView.layer.addSublayer(previewLayer)
            
            captureSession.startRunning()
    
        } catch {
            print(error.localizedDescription)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RecognitionViewController {
            vc.image = photoImage
        }
    }

}

