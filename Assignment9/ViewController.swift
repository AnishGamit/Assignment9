//
//  ViewController.swift
//  Assignment9
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    private let imgpicker = UIImagePickerController()
    
    private let myimgv :UIImageView = {
        let imgview = UIImageView()
        imgview.contentMode = .scaleAspectFill
        imgview.backgroundColor = .gray
        imgview.clipsToBounds = true
        return imgview
    }()
    private let lblTitle:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Tap Below To select Image"
        label.textColor = .blue
        label.font = UIFont.italicSystemFont(ofSize: 30)
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(myimgv)
        view.addSubview(lblTitle)
        imgpicker.delegate = self
        
       let tapgesture=UITapGestureRecognizer(target:self,action: #selector(tappedImg))
        tapgesture.numberOfTapsRequired=1
        tapgesture.numberOfTouchesRequired=1
        view.addGestureRecognizer(tapgesture)
       
        let pinchgesture=UIPinchGestureRecognizer(target:self,action: #selector(pinchImg))
        myimgv.addGestureRecognizer(pinchgesture)
        
        let rotationgesture=UIRotationGestureRecognizer(target: self, action:#selector(rotateImg))
        view.addGestureRecognizer(rotationgesture)
        
        let lswipe=UISwipeGestureRecognizer(target: self, action:#selector(swipeImg))
        lswipe.direction = .left
        view.addGestureRecognizer(lswipe)
        
        let rswipe=UISwipeGestureRecognizer(target: self, action:#selector(swipeImg))
        lswipe.direction = .right
        view.addGestureRecognizer(rswipe)
        
        let uswipe=UISwipeGestureRecognizer(target: self, action:#selector(swipeImg))
        lswipe.direction = .up
        view.addGestureRecognizer(uswipe)
        
        let dswipe=UISwipeGestureRecognizer(target: self, action:#selector(swipeImg))
        lswipe.direction = .down
        view.addGestureRecognizer(dswipe)
        
        let pangesture=UIPanGestureRecognizer(target: self, action: #selector(panImg))
        view.addGestureRecognizer(pangesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lblTitle.frame = CGRect(x: 30, y: 50, width: view.width-30, height: 50)
        myimgv.frame = CGRect(x: 70, y:150, width: 200, height: 200)
    }
    
}
extension ViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let getimage = info[.originalImage] as? UIImage{
            myimgv.image = getimage
        }
        imgpicker.dismiss(animated: true)
    }
    
    
    @objc private func tappedImg(gesture: UITapGestureRecognizer) {
        imgpicker.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.imgpicker, animated: true)
        }
    }
    
    @objc private func pinchImg(gesture: UIPinchGestureRecognizer) {
        myimgv.transform=CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    @objc private func rotateImg(gesture: UIRotationGestureRecognizer) {
        myimgv.transform=CGAffineTransform(rotationAngle: gesture.rotation)
    }
    @objc private func swipeImg(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left{
            UIView.animate(withDuration: 0.5){
                self.myimgv.frame = CGRect(x: self.myimgv.frame.origin.x-40, y: self.myimgv.frame.origin.y, width: 200, height: 200)
            }
        }
        else  if gesture.direction == .right{
            UIView.animate(withDuration: 0.5){
                self.myimgv.frame = CGRect(x: self.myimgv.frame.origin.x+40, y: self.myimgv.frame.origin.y, width: 200, height: 200)
            }
        }
        else  if gesture.direction == .up{
            UIView.animate(withDuration: 0.5){
                self.myimgv.frame = CGRect(x: self.myimgv.frame.origin.x, y: self.myimgv.frame.origin.y-40, width: 200, height: 200)
            }
        }
        else  if gesture.direction == .down{
            UIView.animate(withDuration: 0.5){
                self.myimgv.frame = CGRect(x: self.myimgv.frame.origin.x, y: self.myimgv.frame.origin.y+40, width: 200, height: 200)
            }
        }
    }
    
    @objc private func panImg(gesture: UIPanGestureRecognizer) {
        
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        myimgv.center=CGPoint(x: x, y: y)
    }
}
