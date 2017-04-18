//
//  Constants.swift
//  RichTextView
//
//  Created by wenyou on 2017/4/13.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa

typealias SimpleBlockNoneParameter = () -> Void
typealias SimpleBlock = (_ data: AnyObject) -> Void

class Constants {
    static let hostInfoFontSize: CGFloat = 40

    static let hostFontColor = NSColor.colorWithHexValue(0x333333)
    static let hostNoteFontColor = NSColor.brown
    static let hostFont = NSFont(name: "PT Mono", size: Constants.hostInfoFontSize)!
}
