//
//  FontsDisplayViewController.swift
//  Font Viewer
//
//  Created by Kyle Morton on 6/20/19.
//  Copyright © 2019 Morton-Development. All rights reserved.
//

import Cocoa

class FontsDisplayViewController: NSViewController {

    @IBOutlet var fontsTextView: NSTextView!
    
    var fontFamily: String?
    var fontFamilyMembers = [[Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setupTextView()
    }
    
    func setupTextView () {
        fontsTextView.backgroundColor = NSColor(white: 1.0, alpha: 0.0)
        fontsTextView.enclosingScrollView?.backgroundColor = NSColor(white: 1.0, alpha: 0.0)
        fontsTextView.isEditable = false
        fontsTextView.enclosingScrollView?.autohidesScrollers = true
    }
    
    @IBAction func closeWindow(_ sender: Any) {
        
    }
    
}
