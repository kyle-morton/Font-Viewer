//
//  ViewController.swift
//  Font Viewer
//
//  Created by Kyle Morton on 6/19/19.
//  Copyright © 2019 Morton-Development. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var fontFamiliesPopup: NSPopUpButton!
    @IBOutlet weak var fontTypesPopup: NSPopUpButton!
    @IBOutlet weak var sampleLabel: NSTextField!
    
    var selectedFontFamily: String?
    
    var fontFamilyMembers = [[Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        setupUI()
        populateFontFamilies()
    }
    
    func setupUI () {
        fontFamiliesPopup.removeAllItems()
        fontTypesPopup.removeAllItems()
        sampleLabel.stringValue = ""
        sampleLabel.alignment = .center
    }
    
    func populateFontFamilies () {
        fontFamiliesPopup.removeAllItems()
        fontFamiliesPopup.addItems(withTitles: NSFontManager.shared.availableFontFamilies)
        
        handleFontFamilySelection(self)
    }
    
    func updateFontTypesPopup () {
        fontTypesPopup.removeAllItems()
        
        for member in fontFamilyMembers {
            if let fontType = member[1] as? String {
                fontTypesPopup.addItem(withTitle: fontType)
            }
        }
        
        fontTypesPopup.selectItem(at: 0)
        handleFontTypeSelection(self)
    }
    
    @IBAction func handleFontFamilySelection(_ sender: Any) {
        
        if let fontFamily = fontFamiliesPopup.titleOfSelectedItem {
            
            selectedFontFamily = fontFamily
            
            if let members = NSFontManager.shared.availableMembers(ofFontFamily: selectedFontFamily!) {
                
                fontFamilyMembers.removeAll()
                fontFamilyMembers = members
                
                /* Example Response from availableMembers() function -
                 *
                 * (("Times-Roman", "Roman", 5, 4),
                 *    ("Times-Italic", "Italic", 6, 5),
                 *    ("Times-Bold", "Bold", 9, 2),
                 *    ("Times-BoldItalic", "Bold Italic", 9, 3)
                 *    )
                 *
                */
                
                updateFontTypesPopup()
                
                view.window?.title = fontFamily
            
            }
            
        }
     }
    
    @IBAction func handleFontTypeSelection(_ sender: Any) {
        
        
        let selectedMember = fontFamilyMembers[fontTypesPopup.indexOfSelectedItem]
        if let postscriptName = selectedMember[0] as? String,
            let weight = selectedMember[2] as? Int,
            let traits = selectedMember[3] as? UInt,
            let fontFamily = selectedFontFamily {
            
            let font = NSFontManager.shared.font(
                withFamily: fontFamily,
                traits: NSFontTraitMask(rawValue: traits),
                weight: weight,
                size: 19.0
            )
            
            sampleLabel.font = font
            sampleLabel.stringValue = postscriptName
            
        }
    }
    
    @IBAction func displayAllFonts(_ sender: Any) {
        let storyboardName = NSStoryboard.Name(stringLiteral: "Main")
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        
        let storyboardID = NSStoryboard.SceneIdentifier(stringLiteral: "fontsDisplayStoryboardID")
        
        if let fontsDisplayWindowController = storyboard.instantiateController(withIdentifier: storyboardID) as? NSWindowController {
            
            if let fontsDisplayVC = fontsDisplayWindowController.contentViewController as? FontsDisplayViewController {
                fontsDisplayVC.fontFamily = selectedFontFamily
                fontsDisplayVC.fontFamilyMembers = fontFamilyMembers
            }
            
            fontsDisplayWindowController.showWindow(nil)
        }
    }

}

