//
//  MenuVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 30.04.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    var interactor: Interactor? = nil
    
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Left)
        
        MenuHelper.mapGestureStateToInteractor(gestureState: sender.state, progress: progress, interactor: interactor) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    

    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }



}
