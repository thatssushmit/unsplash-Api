//
//  ImagePresenter.swift
//  HY_Image_uploading
//
//  Created by nitin patil on 12/7/18.
//  Copyright © 2018 Arora Engineers. All rights reserved.
//

import Foundation
import UIKit
import UnsplashPhotoPicker
class ImagePresnter :NSObject{
    private let imageLoadingService : ImageLoadingService
    weak private var imageloaderview : ImageLoader?
    init(loadimageService:ImageLoadingService) {
        self.imageLoadingService = loadimageService
    }
    func attachedImageView(imageView:ImageLoader){
        self.imageloaderview = imageView
        self.imageloaderview?.stopLoading()
        
    }
    func detachView(){
        imageloaderview = nil
    }
    func getImage(_ loaclphoto:UnsplashPhoto){
        self.imageloaderview?.startLoading()
        self.imageLoadingService.downloadPhoto(loaclphoto) { [weak self] list  in
            self?.imageloaderview?.stopLoading()
            self?.imageloaderview?.showImageData(list: list)
        }
    }
}
