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
        view.bringSubviewToFront(itemView)
    }

    func addGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handleGesture(sender: UIPanGestureRecognizer) {
        
        guard let fileView = sender.view else { return }
        
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
        case .ended:
            if itemView.frame.intersects(trashView.frame) {
                UIView.animate(withDuration: 0.3) {
                    fileView.alpha = 0.0
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    fileView.frame.origin = self.itemViewOrigin
                }
            }
        default: break
        }
    }

    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
}

