//
//  DetailViewController.swift
//  album art
//
//  Created by Adolfo Lozano Mendez on 3/02/18.
//  Copyright © 2018 Adolfo Lozano Mendez. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mNameTxtField: UITextField!
    @IBOutlet weak var mCommentTxtField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mImageView.isUserInteractionEnabled = true
        let gestureReconizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.selectImage))
        mImageView.addGestureRecognizer(gestureReconizer)
    }
    
    @objc func selectImage(){
        print("selectImge")
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        mImageView.image = chosenImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        let nameInput = mNameTxtField.text
        let commentInput = mCommentTxtField.text
        let image = mImageView.image
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newArt = NSEntityDescription.insertNewObject(forEntityName: "Pictures", into: context)
        
        newArt.setValue(nameInput, forKey: "name")
        newArt.setValue(commentInput, forKey: "detail")
        
        let data = UIImageJPEGRepresentation(image!, 0.5)
        newArt.setValue(data, forKey: "image")

        do {
            try context.save()
            print("Saved!")
        } catch {
            print("error")
        }
        
    }
    
}
