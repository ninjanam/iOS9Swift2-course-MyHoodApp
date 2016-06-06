//
//  AddPostVC.swift
//  my-hood-devslopes
//
//  Created by Nam-Anh Vu on 02/06/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postImg: UIImageView!
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var descField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        //set the delegate for the imagePicker
        imagePicker.delegate = self
        
    }
    
    @IBAction func AddPicBtnPressed(sender: UIButton) {
        sender.setTitle("", forState: .Normal)
        // present the imagePicker
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func MakePostBtnPressed(sender: AnyObject) {
        // this makes sure that a title, description and image exists before posting. If one of these don't
        // the code won't run
        if let title = titleField.text, let desc = descField.text, let img = postImg.image {
            
            // get the image path from the DataService
            let imgPath = DataService.instance.saveImageAndCreatePath(img)
            
            let post = Post(imagePath: imgPath, title: title, description: desc)
            DataService.instance.addPost(post)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // When the user selects an image, we want to high the image picker selector
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImg.image = image
    }
}
