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
	let imageDownloadConnection: NSXPCConnection = {
		let connection = NSXPCConnection(serviceName: "com.redeggproductions.XPC-App-ImageDownloader")
		connection.remoteObjectInterface = NSXPCInterface(with: ImageDownloaderProtocol.self)
		connection.resume()
		return connection
	}()

	weak var delegate: ImageDisplayable?
	internal init() {
		self.images = []

		let array = ["https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mac-pro-select-hero-201711?wid=892&hei=820&&qlt=80&.v=1509566658416", "https://images.idgesg.net/images/article/2019/06/mac-pro-display-100798260-large.jpg"].map { URL(string: $0) }.compactMap { $0 }

		guard let downloader = imageDownloadConnection.remoteObjectProxyWithErrorHandler ({ (error) in
			NSLog("remote proxy error: \(error)")
		}) as? ImageDownloaderProtocol else { return }

		for url in array {
			downloader.downloadImage(at: url) { (imageData) in
				guard let imageData = imageData, let image = NSImage(data: imageData) else {
					print("escaped")
					return
				}
				print("got \(imageData.count) bytes")
				self.images.append(image)
				self.delegate?.imageWasLoaded()
			}
		}
	}

	var images: [NSImage]
}

//class ImageLoader {
//	let session: URLSession
//
//	init() {
//		let config = URLSessionConfiguration.default
//		session = URLSession(configuration: config)
//	}
//
//	func retrieveImage(atURL url: URL, completionHandler: @escaping (NSImage?) -> Void) {
//		let task = session.dataTask(with: url) { maybeData, response, error in
//			guard let data = maybeData else {
//				completionHandler(nil)
//				return
//			}
//			DispatchQueue.global().async {
//				let image = NSImage(data: data)
//				completionHandler(image)
//			}
//		}
//		task.resume()
//	}
//}
