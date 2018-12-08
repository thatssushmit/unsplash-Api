//
//  ImageLoadingService.swift
//  HY_Image_uploading
//
//  Created by sushmit yadav on 12/7/18.
//  Copyright © 2018 sushmit yadav. All rights reserved.
//

import Foundation
import UnsplashPhotoPicker
class ImageLoadingService{
    private var imageDataTask: URLSessionDataTask?
    private static var cache = URLCache(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "unsplash")

    func downloadPhoto(_ photo: UnsplashPhoto,callback:@escaping ([LoadedImageModel]) -> Void) {
        guard let url = photo.urls[.regular] else { return }
        
        if let cachedResponse = ImageLoadingService.cache.cachedResponse(for: URLRequest(url: url)),
            let image = UIImage(data: cachedResponse.data) {
            let temp = LoadedImageModel(objImage:image)
            callback([temp])
            return
        }
        imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let strongSelf = self else { return }
            strongSelf.imageDataTask = nil
            guard let data = data, let image = UIImage(data: data), error == nil else { return }
            let temp = LoadedImageModel(objImage:image)
             callback([temp])

        }
        
        imageDataTask?.resume()
    }
}
