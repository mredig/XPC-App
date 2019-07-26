//
//  ImageDownloaderProtocol.swift
//  XPC App
//
//  Created by Michael Redig on 7/26/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

@objc(ImageDownloaderProtocol) protocol ImageDownloaderProtocol {
	func downloadImage(at url: URL, withReply completion: (Data?) -> Void)
}