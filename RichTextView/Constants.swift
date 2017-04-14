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

    static let colorBianchi = NSColor.colorWithHexValue(0x8bddd1)

    static let colorTableBackground = NSColor.colorWithHexValue(0xf5f5f5)
    static let colorTableBackgroundLight = NSColor.white
    static let colorTableBorder = NSColor.colorWithHexValue(0xc8c8c8)

    static let iconfontScan = "\u{f029}"
    static let iconfontHistory = "\u{f03a}"
    static let iconfontlight = "\u{f0e7}"
    static let iconfontImage = "\u{f03e}"
    static let iconfontDelete = "\u{f014}"

    static let iconfontCog = "\u{f013}"
    static let iconfontEdit = "\u{f044}"
    static let iconfontText = "\u{f0f6}"
    static let iconfontRandom = "\u{f074}"
}