//
//  EvaluationTVC + UIImagePickerDelegate.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/17/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import UIKit
import Photos

extension EvaluationTVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    func loadImagePickerController() {
        let actionSheet = UIAlertController(title: "Take a Photo", message: "Choose a source", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) in
            self.checkCameraAuthorization { authorized in
                if authorized {
                    print("Success! User is authorized to use camera.")
                    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                        let cameraController = UIImagePickerController()
                        cameraController.sourceType = .camera
                        cameraController.allowsEditing = false
                        cameraController.delegate = self
                        self.present(cameraController, animated: true, completion: nil)
                    }
                } else {
                    print("Permission to use camera denied.")
                }
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) in
            self.checkPhotoLibraryAuthorization { authorized in
                if authorized {
                    print("Success! User is authorized to use photo library.")
                    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
                        let photoLibraryController = UIImagePickerController()
                        photoLibraryController.sourceType = .photoLibrary
                        photoLibraryController.allowsEditing = false
                        photoLibraryController.delegate = self
                        self.present(photoLibraryController, animated: true, completion: nil)
                    }
                    
                } else {
                    print("Permission to use photo library denied.")
                }
            }
            
            
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePhotos.append(image)

        // Reload the collection view to display new image
        collectionViewPhotos.reloadData()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func checkPhotoLibraryAuthorization(_ completionHandler: @escaping ((_ authorized: Bool) -> Void)) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            // The user has previously granted access to the photo library.
            print("The user has previously granted access to the photo library.")
            completionHandler(true)
            
        case .notDetermined:
            // The user has not yet been presented with the option to grant photo library access so request access.
            print("The user has not yet been presented with the option to grant photo library access so request access.")
            PHPhotoLibrary.requestAuthorization({ status in
                completionHandler((status == .authorized))
            })
            
        case .denied:
            // The user has previously denied access.
            print("The user has previously denied access.")
            completionHandler(false)
            
        case .restricted:
            // The user doesn't have the authority to request access e.g. parental restriction.
            print("The user doesn't have the authority to request access e.g. parental restriction.")
            completionHandler(false)
        }
    }
    
    private func checkCameraAuthorization(_ completionHandler: @escaping ((_ authorized: Bool) -> Void)) {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            // The user has previously granted access to the camera.
            print("The user has previously granted access to the camera.")
            completionHandler(true)
            
        case .notDetermined:
            // The user has not yet been presented with the option to grant video access so request access.
            print("The user has not yet been presented with the option to grant video access so request access.")
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { success in
                completionHandler(success)
            })
            
        case .denied:
            // The user has previously denied access.
            print("The user has previously denied access.")
            completionHandler(false)
            
        case .restricted:
            // The user doesn't have the authority to request access e.g. parental restriction.
            print("The user doesn't have the authority to request access e.g. parental restriction.")
            completionHandler(false)
        }
    }
}

