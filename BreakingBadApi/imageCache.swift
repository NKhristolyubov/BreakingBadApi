//
//  imageCache.swift
//  BreakingBadApi
//
//  Created by Николай Христолюбов on 15.11.2022.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
