//
//  Load.swift
//  PokeDex
//
//  Created by Caue Camara on 12/05/23.
//

import UIKit

final public class CustomActivityIndicator: UIImageView {

    public override init(image: UIImage? = nil) {
        super.init(image: image)
        self.image = UIImage(named: "pokeballred")
        self.contentMode = .scaleAspectFit
        self.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func startAnimating() {
        isHidden = false
        rotate()
    }

    public override func stopAnimating() {
        isHidden = true
        removeRotation()
    }

    private func rotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.8
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        layer.add(rotation, forKey: "rotationAnimation")
    }

    private func removeRotation() {
        layer.removeAnimation(forKey: "rotationAnimation")
        removeFromSuperview()
    }
}

