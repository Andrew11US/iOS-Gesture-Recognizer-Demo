//
//  ViewController.swift
//  Gesture Recognizer Demo
//
//  Created by Andrew on 8/17/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var trashView: UIView!
    
    var itemViewOrigin: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesture(view: itemView)
        itemViewOrigin = itemView.frame.origin
    }

    func addGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handleGesture(sender: UIPanGestureRecognizer) {
        
        guard let fileView = sender.view else { return }
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            fileView.center = CGPoint(x: fileView.center.x + translation.x, y: fileView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended: break
        default: break
        }
    }

}

