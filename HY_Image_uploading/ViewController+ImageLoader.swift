//
//  ViewController+ImageLoader.swift
//  HY_Image_uploading
//
//  Created by sushmit yadav on 12/6/18.
//  Copyright © 2018 sushmit yadav. All rights reserved.
//rved.

import Foundation
import UIKit
extension ViewController : ImageLoader{
    func startLoading() {
        print("OK")
        DispatchQueue.main.async {
        self.viewProgress.startAnimating()
        self.viewProgress.isHidden = false
        }
    }
    
    func stopLoading() {
        print("OK")
        DispatchQueue.main.async {
        self.viewProgress.startAnimating()
        self.viewProgress.isHidden = true
        }
    }
    
    func showImageData(list: [LoadedImageModel]) {
        DispatchQueue.main.async {
            UIView.transition(with: (self.hy_imgView)!, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                self.imageModel = list
                self.hy_imgView.image = self.imageModel[0].objImage
                
            }, completion: nil)
        }

    }
    
    
}
