//
//  URLOpener.swift
//  HomeKitLights
//
//  Created by Kraig Spear on 1/16/20.
//  Copyright © 2020 Kraig Spear. All rights reserved.
//

import UIKit

/// Type that is able to open a URL
protocol URLOpenable {
    /// Open a URL
    /// - Parameter url: URL to open
    func open(_ url: URL)
}

/// Opens a URL
final class URLOpener: URLOpenable {
    /// Open a URL
    /// - Parameter url: URL to open
    func open(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
