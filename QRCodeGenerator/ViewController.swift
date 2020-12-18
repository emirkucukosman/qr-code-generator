//
//  ViewController.swift
//  QRCodeGenerator
//
//  Created by Emir Küçükosman on 4.12.2020.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    @IBOutlet weak var urlTxt: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTxt.delegate = self
        urlTxt.returnKeyType = .done
        urlTxt.textContentType = .URL
        urlTxt.autocorrectionType = .no
        urlTxt.autocapitalizationType = .none
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(qrCodeLongPressed))
        
        qrImageView.isUserInteractionEnabled = true
        qrImageView.addGestureRecognizer(recognizer)
    }
    
    @IBAction func generateTapped() {
        
        urlTxt.resignFirstResponder()
        
        if urlTxt.text != "" {
            
            guard let url = URL(string: urlTxt.text!) else {
                let alert = self.getAlert(tile: "Please enter a valid URL", message: nil)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            guard let qrCodeImage = generateQRCode(from: url) else {
                let alert = self.getAlert(tile: "Can not generate QR code", message: nil)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.qrImageView.image = qrCodeImage
            self.infoLabel.isHidden = false
            
        }
        
    }
    
    func generateQRCode(from url: URL) -> UIImage? {
        
        let urlData = url.dataRepresentation
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(urlData, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    @objc func qrCodeLongPressed() {
        
        if let qrImage = qrImageView.image {
            let items = [qrImage]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            
            self.present(ac, animated: true, completion: nil)
        }
        
    }
    
}

