//
//  ViewController.swift
//  HY_Image_uploading
//
//  Created by sushmit yadav on 12/6/18.
//  Copyright © 2018 sushmit yadav. All rights reserved.
//

import UIKit
import Firebase
import UnsplashPhotoPicker

class ViewController: UIViewController {
    @IBOutlet weak var viewProgress: UIActivityIndicatorView!
    var imageModel  = [LoadedImageModel]()
    var presenter = ImagePresnter(loadimageService: ImageLoadingService())
    
    @IBOutlet weak var hy_imgView: UIImageView!
    var picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.presenter.attachedImageView(imageView: self as ImageLoader)
    }
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        //successfully authenticated user
        if (self.hy_imgView.image != nil){
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
        let uploadMetadata = StorageMetadata()
            uploadMetadata.contentType = "image/jpeg/png"
        if let uploadData = self.hy_imgView.image!.pngData() {
            let uploadTask = storageRef.putData(uploadData, metadata: uploadMetadata, completion: { (metadata, err) in
                storageRef.downloadURL(completion: { (url, err) in
                    if let err = err {
                        print(err)
                        completion(nil)
                        return
                    }else {
                        print(metadata)
                        completion(url?.absoluteString)
                    }
                    guard let url = url else { return }
                    print(url)
                    
                })
                
            })
        }
        }
    }
    @IBAction func action_Upload(_ sender: UIButton) {
        self.uploadMedia { (url) in
//            print(url!)
            Auth.auth().createUser(withEmail: "sush@gmail.com", password: "@dityaY1997", completion: { (res, error) in
                
                if let error = error {
                    print(error)
                    return
                }
                
                guard let uid = res?.user.uid else {
                    return
                }
                
                //successfully authenticated user
                let imageName = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
                
                if let uploadData = self.hy_imgView.image!.pngData() {
                    
                    storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
                        
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        storageRef.downloadURL(completion: { (url, err) in
                            if let err = err {
                                print(err)
                                return
                            }
                            
                            guard let url = url else { return }
                            let values = ["name": "harishdy@gmail.com", "email": "Harishdy@oo7", "profileImageUrl": url.absoluteString]
                            
                            self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
                        })
                        
                    })
                }
            })
//            self.ref?.child("123").childByAutoId().setValue([
//                "Title"      : "titleText.text",
//                "Article"    : "mainText.text",
//                "Author"     : "authorText.text",
//                "Date"       : "dateText.text",
//                "myImageURL" : url!
//                ])
//            let values = ["name": "harishdy@gmail.com", "email": "Harishdy@oo7", "profileImageUrl": url]
//
//            self.registerUserIntoDatabaseWithUID("6OAF76uo9CPL9UY0ZVFBY3K5sHT2", values: values as [String : AnyObject])
            //Checking username existence
//            Database.database().reference().child("active_usernames").child("6OAF76uo9CPL9UY0ZVFBY3K5sHT2").observeSingleEvent(of: .value, with: {(usernameSnap) in
//
//                if usernameSnap.exists(){
//                    //This username already exists
//                    print(usernameSnap)
//
//                }else{
//
//                    //Yippee!.. This can be my username
//                                        print(usernameSnap)
//                }
//
//            })
            
        }
//        Auth.auth().createUser(withEmail: "sushmit007@gmail.com", password: "@dityaY1997", completion: { (res, error) in
//
//            if let error = error {
//                print(error)
//                return
//            }
//
//            guard let uid = res?.user.uid else {
//                return
//            }
//
//            //successfully authenticated user
//            let imageName = NSUUID().uuidString
//            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
//
//            if let uploadData = self.hy_imgView.image!.pngData() {
//
//                storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
//
//                    if let error = error {
//                        print(error)
//                        return
//                    }
//
//                    storageRef.downloadURL(completion: { (url, err) in
//                        if let err = err {
//                            print(err)
//                            return
//                        }
//
//                        guard let url = url else { return }
//                        let values = ["name": "harishdy@gmail.com", "email": "Harishdy@oo7", "profileImageUrl": url.absoluteString]
//
//                        self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
//                    })
//
//                })
//            }
//        })
    }
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference(fromURL: "https://hyimageuploading.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err {
                print(err)
                return
            }
            
//            self.dismiss(animated: true, completion: nil)
        })
    }
    @IBAction func action_OpenLibrary(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .overCurrentContext
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    @IBAction func action_Take(_ sender: UIButton)
    {
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.modalPresentationStyle = .overCurrentContext
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
        present(picker, animated: true, completion: nil)
    }
    @IBAction func action_OpenUnsplash(_ sender: Any) {
        let configuration = UnsplashPhotoPickerConfiguration(
            accessKey: "3bc8601f5ce72ba440b967153173aa3352812db9e401e153407d0a84a4085075",
            secretKey: "3c9a24ae82bc933f828c3ea5d8c73bcc4807a58dd200394359606dc67c56e061"
        )
        let unsplashPhotoPicker = UnsplashPhotoPicker(configuration: configuration)
        unsplashPhotoPicker.photoPickerDelegate = self
        
        present(unsplashPhotoPicker, animated: true, completion: nil)
    }
}

