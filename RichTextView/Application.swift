//
//  Application.swift
//  RichTextView
//
//  Created by wenyou on 2017/3/20.
//  Copyright © 2017年 wenyou. All rights reserved.
//


import Cocoa

class Application: NSApplication { // 注册到info.plist
    let appDelegate = AppDelegate()

    override init() {
        super.init()
        self.delegate = appDelegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // move to other
//    override func sendEvent(_ event: NSEvent) {
//        if event.type == .keyDown {
//            switch event.modifierFlags.rawValue & NSEventModifierFlags.deviceIndependentFlagsMask.rawValue {
//            case NSEventModifierFlags.command.rawValue:
//                switch event.charactersIgnoringModifiers! {
//                case "x":
//                    if NSApp.sendAction(#selector(NSText.cut(_:)), to: nil, from: self) {
//                        return
//                    }
//                case "c":
//                    if NSApp.sendAction(#selector(NSText.copy(_:)), to: nil, from: self) {
//                        return
//                    }
//                case "v":
//                    if NSApp.sendAction(#selector(NSText.paste(_:)), to: nil, from: self) {
//                        return
//                    }
//                case "z":
//                    if NSApp.sendAction(Selector(("undo:")), to: nil, from: self) {
//                        return
//                    }
//                case "a":
//                    if NSApp.sendAction(#selector(NSText.selectAll(_:)), to: nil, from: self) {
//                        return
//                    }
//                default:
//                    ()
//                }
//            case NSEventModifierFlags.command.rawValue | NSEventModifierFlags.shift.rawValue:
//                if event.charactersIgnoringModifiers == "Z" {
//                    if NSApp.sendAction(Selector(("redo:")), to:nil, from:self) {
//                        return
//                    }
//                }
//            default:
//                ()
//            }
//        }
//        super.sendEvent(event)
//    }
}
