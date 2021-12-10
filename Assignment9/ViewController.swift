//
//  ViewController.swift
//  Assignment9
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let myimgv:UIImageView={
        let img=UIImageView()
        img.image = UIImage(named: "flower.jpg")
        img.isUserInteractionEnabled = true
        img.frame=CGRect(x: 100, y: 100, width: 200, height: 200)
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(myimgv)
        
        let tapgesture=UITapGestureRecognizer(target:self,action: #selector(tappedImg))
        tapgesture.numberOfTapsRequired=1
        tapgesture.numberOfTouchesRequired=1
        myimgv.addGestureRecognizer(tapgesture)
        
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
    
    
}
extension ViewController{
    @objc private func tappedImg(gesture: UITapGestureRecognizer) {
        print("tapped at location: \(gesture.location(in: myimgv))")
        performSegue(withIdentifier: "segue", sender: self)
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
            myimgv.frame = CGRect(x: myimgv.frame.origin.x+40, y: myimgv.frame.origin.y, width: 200, height: 200)
        }
        else  if gesture.direction == .up{
            myimgv.frame = CGRect(x: myimgv.frame.origin.x, y: myimgv.frame.origin.y-40, width: 200, height: 200)
        }
        else  if gesture.direction == .down{
            myimgv.frame = CGRect(x: myimgv.frame.origin.x, y: myimgv.frame.origin.y+40, width: 200, height: 200)
        }
    }
    
    @objc private func panImg(gesture: UIPanGestureRecognizer) {
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        myimgv.center=CGPoint(x: x, y: y)
    }
}
