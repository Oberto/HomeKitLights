//
//  ActivityIndicatorView.swift
//  IoTWIFI
//
//  Created by Kraig Spear on 1/6/20.
//  Copyright © 2020 Kraig Spear. All rights reserved.
//

import SwiftUI
import UIKit

/// Makes a `UIActivityIndicatorView` available to SwiftUI
struct ActivityView: UIViewRepresentable {
    /// Is the activity indicaotr currently animating
    @Binding var isActive: Bool

    func makeUIView(context _: UIViewRepresentableContext<ActivityView>) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = UIColor.white
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context _: UIViewRepresentableContext<ActivityView>) {
        if isActive {
            if !uiView.isAnimating {
                uiView.startAnimating()
            }
        } else {
            if uiView.isAnimating {
                uiView.stopAnimating()
            }
        }
    }
}
