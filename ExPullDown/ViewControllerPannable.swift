//
//  ViewControllerPannable.swift
//  ExPullDown
//
//  Created by Jake.K on 2022/02/22.
//

import UIKit

class ViewControllerPannable: UIViewController {
  private var originalPosition: CGPoint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
    self.view.addGestureRecognizer(panGestureRecognizer)
  }
  
  @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
    switch panGesture.state {
    case .began:
      self.originalPosition = view.center
    case .changed:
      let translation = panGesture.translation(in: view)
      self.view.frame.origin = CGPoint(x: translation.x, y: translation.y)
    case .ended:
      guard let originalPosition = self.originalPosition else { return }
      let velocity = panGesture.velocity(in: view)
      guard velocity.y >= 1500 else {
        UIView.animate(withDuration: 0.2, animations: {
          self.view.center = originalPosition
        })
        return
      }

      UIView.animate(
        withDuration: 0.2,
        animations: {
          self.view.frame.origin = CGPoint(
            x: self.view.frame.origin.x,
            y: self.view.frame.size.height
          )
        },
        completion: { (isCompleted) in
          if isCompleted {
            self.dismiss(animated: false, completion: nil)
          }
        }
      )
      default:
      return
    }
  }
}
