//
//  TextWindow.swift
//  RichTextView
//
//  Created by wenyou on 2017/3/20.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa

class TextWindow: NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)

        contentViewController = TextViewController()
        title = "TextView Example"
    }
}
