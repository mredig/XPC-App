//
//  ViewController.swift
//  XPC App
//
//  Created by Michael Redig on 7/24/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
	@IBOutlet var tableView: NSTableView!

	var imageSet: ImageSet?

	override func viewDidLoad() {
		super.viewDidLoad()
		imageSet = ImageSet()
		imageSet?.delegate = self

		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
}

extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("Image"), owner: self) as! NSTableCellView
		var image: NSImage? = nil
		let c = self.imageSet?.images.count ?? 0
		if row < c {
			image = imageSet?.images[row]
		}

		cellView.imageView?.image = image
		return cellView
	}

	func numberOfRows(in tableView: NSTableView) -> Int {
		return imageSet?.images.count ?? 0
	}

	func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
		return 100
	}

}

extension ViewController: ImageDisplayable {
	func imageWasLoaded() {
		print("called")
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
