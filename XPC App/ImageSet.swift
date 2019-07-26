//
//  ImageSet.swift
//  XPC App
//
//  Created by Michael Redig on 7/24/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import AppKit

protocol ImageDisplayable: AnyObject {
	func imageWasLoaded()
}

class ImageSet {
	let loader = ImageLoader()
	weak var delegate: ImageDisplayable?
	internal init() {
		self.images = []

		let array = ["https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mac-pro-select-hero-201711?wid=892&hei=820&&qlt=80&.v=1509566658416", "https://images.idgesg.net/images/article/2019/06/mac-pro-display-100798260-large.jpg"].map { URL(string: $0) }.compactMap { $0 }

		for url in array {
			loader.retrieveImage(atURL: url) { (image) in
				guard let image = image else {
					print("escaped")
					return
				}
				print(image)
				self.images.append(image)
				self.delegate?.imageWasLoaded()
			}
		}
	}

	var images: [NSImage]
}

class ImageLoader {
	let session: URLSession

	init() {
		let config = URLSessionConfiguration.default
		session = URLSession(configuration: config)
	}

	func retrieveImage(atURL url: URL, completionHandler: @escaping (NSImage?) -> Void) {
		let task = session.dataTask(with: url) { maybeData, response, error in
			guard let data = maybeData else {
				completionHandler(nil)
				return
			}
			DispatchQueue.global().async {
				let image = NSImage(data: data)
				completionHandler(image)
			}
		}
		task.resume()
	}
}
