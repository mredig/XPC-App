//
//  ImageDownloaderProtocol.swift
//  XPC App
//
//  Created by Michael Redig on 7/26/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

@objc protocol ImageDownloaderProtocol {
	func downloadImage(at url: URL, withReply completion: @escaping (Data?) -> Void)
}
