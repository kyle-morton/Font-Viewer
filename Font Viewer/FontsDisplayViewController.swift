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
        showFonts()
    }
    
    func setupTextView () {
        fontsTextView.backgroundColor = NSColor(white: 1.0, alpha: 0.0)
        fontsTextView.enclosingScrollView?.backgroundColor = NSColor(white: 1.0, alpha: 0.0)
        fontsTextView.isEditable = false
        fontsTextView.enclosingScrollView?.autohidesScrollers = true
    }
    
    func showFonts() {
        guard let fontFamily = fontFamily else { return }
        
        var fontPostscriptNames = ""
        var lengths = [Int]()
        
        for member in fontFamilyMembers {
            if let postscript = member[0] as? String {
                fontPostscriptNames += "\(postscript)\n"
                lengths.append(postscript.count)
            }
        }
        
        let attributedString = NSMutableAttributedString(string: fontPostscriptNames)
        
        for (index, member) in fontFamilyMembers.enumerated() {
            if let weight = member[2] as? Int, let traits = member[3] as? UInt {
                
                if let font = NSFontManager.shared.font(withFamily: fontFamily, traits: NSFontTraitMask(rawValue: traits), weight: weight, size: 19.0) {
                    
                    var location = 0
                    if index > 0 {
                        for i in 0..<index {
                            location += lengths[i] + 1
                        }
                    }
                    
                    let range = NSMakeRange(location, lengths[index])
                    
                    attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
                }
            }
        }
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.white, range: NSMakeRange(0, attributedString.string.count))
        
        fontsTextView.textStorage?.setAttributedString(attributedString)
    }

    
    @IBAction func closeWindow(_ sender: Any) {
        view.window?.close()
    }
    
}
