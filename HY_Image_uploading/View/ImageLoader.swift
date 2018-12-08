//
//  ImageLoader.swift
//  HY_Image_uploading
//
//  Created by nitin patil on 12/7/18.
//  Copyright © 2018 Arora Engineers. All rights reserved.
//

import Foundation
protocol ImageLoader :NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func showImageData(list : [LoadedImageModel])
}
