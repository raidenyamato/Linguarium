//
//  FlipPresentAnimationController.swift
//  Linguarium
//
//  Created by Raiden Yamato on 17.01.2023.
//

import UIKit

class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
        init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ViewController,
              let toVC = transitionContext.viewController(forKey: .to) as? QuestionViewController,
              let snapshot = toVC.questionView.snapshotView(afterScreenUpdates: true)
        else { return }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
      
        let window = fromVC.view.window ?? toVC.view.window
        let cellImageViewRect = fromVC.selectedCell!.contentView.convert(fromVC.selectedCell!.bounds, to: window)
        snapshot.frame = cellImageViewRect
       // snapshot.frame = fromVC.view.frame
        snapshot.layer.cornerRadius = QuestionGroupCell.cellCornerRadius
        snapshot.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.isHidden = true
        
        
        snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: .calculationModeCubic,
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
                AnimationHelper.perspectiveTransform(for: containerView)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 2/3, animations: {
                snapshot.layer.transform = AnimationHelper.yRotation(0.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                snapshot.frame = finalFrame
                snapshot.layer.cornerRadius = 0
            })
        }, completion: { _ in
            toVC.view.isHidden = false
            snapshot.removeFromSuperview()
            fromVC.view.layer.transform = CATransform3DIdentity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    
        })
        
    }
    

    
}
