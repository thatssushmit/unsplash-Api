//
//  ViewController+UIImagePickerControllerDelegate.swift
//  HY_Image_uploading
//
//  Created by sushmit yadav on 12/6/18.
//  Copyright © 2018 sushmit yadav. All rights reserved.
//

import UIKit
extension ViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            self.hy_imgView.image = selectedImage!
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            self.hy_imgView.image = selectedImage!
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
