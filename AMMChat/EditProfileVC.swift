//
//  EditProfileVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 02.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase
import ByvImagePicker

class EditProfileVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameTextField: BlueCorenerTextField!
    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var picker: ByvImagePicker? = nil
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    var layer: UIView! = nil
    var savedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.frame = CGRect(x: self.view.bounds.width / 2 - 25.0, y: self.view.bounds.height / 2 - 50.0, width: 50.0, height: 50.0);
        layer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        layer.backgroundColor = UIColor(red: 62.0/255.0, green: 144.0/255.0, blue: 252.0/255.0, alpha: 1)
        layer.layer.opacity = 0.8
        layer.addSubview(activityIndicator)

        userAvatar.layer.cornerRadius = 189 / 2
        userAvatar.clipsToBounds = true
        
        userNameTextField.delegate = self
        coursePicker.delegate = self
        coursePicker.dataSource = self

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if currentUser != nil {
            userNameTextField.text = currentUser.userName
            let indexOfCurCourse = courses.index(of: currentUser.course)
            coursePicker.selectRow(indexOfCurCourse!, inComponent: 0, animated: true)
            
            if currentUser.avatar != "" {
                if !ProfileVC.userAvatars.isEmpty {
                    userAvatar.image = ProfileVC.userAvatars.last?.image as? UIImage
                }
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let course = courses[row]
        return course
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return courses.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TODO: Update when selected
    }

    @IBAction func selectPhotoTapped(_ sender: UITapGestureRecognizer) {
        if picker == nil {
            picker = ByvImagePicker()
        }
        let from = ByvFrom(controller: self, from:sender.accessibilityFrame, inView:self.view, arrowDirections:.any)
        picker!.getCircularImage(from: from, completion: { image in
            if image != nil {
                self.userAvatar.image = image
                self.savedImage = image!
            }
        })
    }
    
    func tapMethod(sender: UITapGestureRecognizer) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 50), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)

        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        guard userNameTextField.text != "" else {
            let alertController = UIAlertController(title: "Ошибка", message: "Вы заполнили не все поля", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        activityIndicator.startAnimating()
        self.view.addSubview(layer)

        
        if savedImage != nil {
            if let img = savedImage {
                if let imageData = UIImageJPEGRepresentation(img, 0.5) {
                    let imgUID = NSUUID().uuidString
                    let metadata = FIRStorageMetadata()
                    metadata.contentType = "image/jpeg"
                    
                    DataService.ds.REF_TO_SAVE_AVATAR.child(imgUID).put(imageData, metadata: metadata) { (metadata, error) in
                        if error != nil {
                            let alertController = UIAlertController(title: "Ошибка", message: "Не удается загрузить изображение", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        } else {
                            print("LOG: Successfuly uploaded image to Firebase storage")
                            let downloadURL = metadata?.downloadURL()?.absoluteString
                            if let url = downloadURL {
                                let ref = DataService.ds.REF_USER_CURRENT
                                let userName = self.self.userNameTextField.text
                                let course = courses[self.coursePicker.selectedRow(inComponent: 0)]
                                let avatar = url
                                ref.updateChildValues(["username": userName!,
                                                       "lowcasename" : userName!.lowercased(),
                                                       "course" : course,
                                                       "avatar" : avatar])
                                self.popUpView()
                            }
                        }
                    }
                }
            }
        } else {
            let ref = DataService.ds.REF_USER_CURRENT
            let userName = userNameTextField.text
            let course = courses[coursePicker.selectedRow(inComponent: 0)]
            ref.updateChildValues(["username" : userName!,
                                   "lowcasename" : userName!.lowercased(),
                                   "course" : course])
            self.popUpView()
        }
        
        
    }
    
    func popUpView() {
        activityIndicator.stopAnimating()
        layer.removeFromSuperview()
        _ = self.navigationController?.popViewController(animated: true)
    }

}
