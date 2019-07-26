//
//  ImageDownloader.swift
//  XPC-App-ImageDownloader
//
//  Created by Michael Redig on 7/26/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

class ImageDownloader: NSObject, ImageDownloaderProtocol {
	let session: URLSession

	override init() {
		let config = URLSessionConfiguration.default
		session = URLSession(configuration: config)
	}

	func downloadImage(at url: URL, withReply completion: @escaping (Data?) -> Void) {
		let task = session.dataTask(with: url) { data, response, error in
			guard let httpResponse = response as? HTTPURLResponse else { return }
			switch (data, httpResponse) {
			case let (d, r) where (200 <= r.statusCode) && (r.statusCode <= 399):
				completion(d)
			default:
				completion(nil)
			}

		}
		task.resume()
	}
}
