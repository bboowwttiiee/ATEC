//
//  ImagePicker.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var avatarImage: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let photoPicker: ImagePicker
        
        init(photoPicker: ImagePicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.jpegData(compressionQuality: 0.2), let compressedImage = UIImage(data: data) else { return }
                photoPicker.avatarImage = compressedImage
            }
            
            picker.dismiss(animated: true)
        }
    }
}
