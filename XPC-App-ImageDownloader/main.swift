//
//  main.swift
//  XPC-App-ImageDownloader
//
//  Created by Michael Redig on 7/26/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

class ServiceDelegate: NSObject, NSXPCListenerDelegate {
	func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
		newConnection.exportedInterface = NSXPCInterface(with: ImageDownloaderProtocol.self)
		let exportedObject = ImageDownloader()
		newConnection.exportedObject = exportedObject
		newConnection.resume()
		return true
	}
}

let delegate = ServiceDelegate()
let listener = NSXPCListener.service()
listener.delegate = delegate
listener.resume()
