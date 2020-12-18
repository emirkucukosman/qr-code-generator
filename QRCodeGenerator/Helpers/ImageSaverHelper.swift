//
//  ImageSaverHelper.swift
//  QRCodeGenerator
//
//  Created by Emir Küçükosman on 5.12.2020.
//

import UIKit

class ImageSaverHelper: NSObject {
    
    func saveImageToPhotos(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            return print(error!.localizedDescription)
        }
        print("saved")
    }
    
}
