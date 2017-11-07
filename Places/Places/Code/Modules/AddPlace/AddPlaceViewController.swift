//
//  AddPlaceViewController.swift
//  Places
//
//  Created by Borja Igartua Pastor on 8/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class AddPlaceViewController: UIViewController, ImageSlideBoardViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    var interactor: AddPlaceInteractor?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var placeDescriptionTextField: UITextField!
    @IBOutlet weak var locationMapView: LocationMapView!
    @IBOutlet weak var imagesSlideBoardView: ImageSlideBoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesSlideBoardView.delegate = self
        self.interactor?.fillCurrentData(name: &nameTextField.text,
                                         description: &placeDescriptionTextField.text,
                                         coordinate: &locationMapView.location)
        
        nameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var closeButton: UIBarButtonItem
        
        closeButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                    target: self,
                                    action: #selector(AddPlaceViewController.closeAddPlaceModule))
        

        
        self.navigationItem.setLeftBarButton(closeButton, animated: true)
    }

    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        do {
            try self.interactor?.savePlace(name: nameTextField.text,
                                           description: placeDescriptionTextField.text,
                                           coordinate: locationMapView.location)
            
            self.closeAddPlaceModule()
            
        } catch PlacesError.NamePlaceIsRequired {
            self.nameTextField.animateError(true)
            
        } catch let error {
            print(error)
        }
    }
    
    @objc func closeAddPlaceModule() {
        self.dismiss(animated: true, completion: nil)
    }
    
//MARK: - Image slide board delegate
    
    func addImage() {
        
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        
        let alertController = UIAlertController()
        let imageAction = UIAlertAction(title: "Album",
                                        style: UIAlertActionStyle.default) { [weak self] (action) in
                                            imagePickerViewController.sourceType = UIImagePickerControllerSourceType.photoLibrary
                                            self?.present(imagePickerViewController, animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: UIAlertActionStyle.default) { [weak self] (action) in
                                            imagePickerViewController.sourceType = UIImagePickerControllerSourceType.camera
                                            self?.present(imagePickerViewController, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(imageAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
//MARK: - Image Picker delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)  { [unowned self] in
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.imagesSlideBoardView.addImage(image)
            }
        }
    }
    
//MARK: - UITextfield delegate
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.nameTextField.animateError(false)
        return true
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        self.nameTextField.animateError(false)
        return true
    }
}
