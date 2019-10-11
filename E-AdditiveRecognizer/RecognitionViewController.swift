//
//  EffectsViewController.swift
//  TextRecognizer
//
//  Created by Виталий Субботин on 13/09/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit
import FirebaseMLVision

class RecognitionViewController: UIViewController {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func showCodesButtonTapped(_ sender: UIButton) {
        print(#function)
        if additives.count > 0 {
            performSegue(withIdentifier: "recognitedCodesSegue", sender: self)
        }
        else {
            print(additives.count)
        }
    }
    
    var textRecognizer: VisionTextRecognizer!
    var image: UIImage?
    var recognizedText: String = ""
    var codes: [String] = []
    var additives: [Additive] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = image

        configureTextRecognizer()
        
        startRecognition()
    }
    
    
    
    private func configureTextRecognizer() {
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
    }

//    override func viewDidAppear(_ animated: Bool) {
//        startRecognition()
//    }
    
    private func startRecognition() {
        guard let image = self.photoImageView.image?.resize(to: CGSize(width: 720, height: 1280)) else { return }

        let visionImage = VisionImage(image: image)

        textRecognizer.process(visionImage) { (visionText, error) in
            self.displayText(from: visionText, error: error)
        }
    }
    
    private func displayText(from text: VisionText?, error: Error?) {
        guard error == nil else {
            print("Error: ", error!.localizedDescription)
            return
        }
        
        guard let visionText = text else {
            print("Text not found.")
            return
        }
        
        for block in visionText.blocks {
            self.recognizedText += block.text
            
        }
        
        filterText()
    }
    
    private func filterText() {
        print(#function)
        do {

            let range = NSRange(location: 0, length: self.recognizedText.count)
            let regex = try NSRegularExpression(pattern: "E[ -]?[0-9]{3,4}[a-z]?")

//            let result = regex.firstMatch(in: self.recognizedText, options: [], range: range)
            let result = regex.matches(in: self.recognizedText, options: [], range: range)
            for elem in result {
                print("new iteration")
                let elemRange = elem.range(at: 0)
                
                let startIndex = self.recognizedText.index(self.recognizedText.startIndex, offsetBy: elemRange.location)
                let endIndex = self.recognizedText.index(startIndex, offsetBy: elemRange.length)

                let newHashtagRange = startIndex..<endIndex

                var newHashTagFound = String(self.recognizedText[newHashtagRange])
                newHashTagFound = newHashTagFound.replacingOccurrences(of: " ", with: "")
                newHashTagFound = newHashTagFound.replacingOccurrences(of: "-", with: "")
                //
                print(newHashTagFound)
                print(eCodes[newHashTagFound] ?? "error")
                //
                self.codes.append(String(newHashTagFound))
            }
            getInfoFromCodes()
        } catch {
            print("E not found ", error.localizedDescription)
        }
        
        
        
    }

    private func getInfoFromCodes() {
        print(#function)
        if codes.count > 0 {
            for code in codes {
                if let additive = Additive(code: code) {
                    additives.append(additive)
                }
            }
            print(additives)
        }
        else {
            print("codes count = 0")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RecognitedCodesTableViewController {
            vc.recognitedAdditives = self.additives
        }
    }

}
