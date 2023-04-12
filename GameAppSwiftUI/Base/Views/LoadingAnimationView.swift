//
//  LoadingAnimationView.swift
//  GameAppSwiftUI
//
//  Created by Hubert Szczechowski on 08/04/2023.
//
import SwiftUI
import Lottie

/*struct LottieAnimationView: UIViewRepresentable {
    let animationView = LottieAnimationView()
    var animationName: String
    
    func makeUIView(context: Context) -> UIView {
        let animation = Animation.named("Aniki Hamster")
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        return animationView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // empty
    }
}*/


struct LottieView: UIViewRepresentable {
    
    var lottieFile: String
    var loopMode: LottieLoopMode = .playOnce
    var animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        
        animationView.animation = LottieAnimation.named("Aniki Hamster")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = loopMode
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}
