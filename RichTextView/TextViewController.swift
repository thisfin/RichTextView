//
//  TextViewController.swift
//  RichTextView
//
//  Created by wenyou on 2017/3/20.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa
import SnapKit


class TextViewController: NSViewController, NSTextViewDelegate {
    var rulerView: TextVerticalRulerView!

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.orange.cgColor
        view.frame = NSRect(origin: .zero, size: AppDelegate.windowSize)

        let scrollView = NSScrollView(frame: CGRect(origin: .zero, size: AppDelegate.windowSize))
        scrollView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        view.addSubview(scrollView)

        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false

        scrollView.rulersVisible = true
        scrollView.hasVerticalRuler = true

        let textView = NSTextView(frame: CGRect(origin: .zero, size: scrollView.frame.size))
        textView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        scrollView.documentView = textView

        textView.delegate = self
        textView.font = NSFont(name: "PT Mono", size: 40)
        textView.textColor = NSColor.colorWithHexValue(0x333333)
//        textView.isRulerVisible = true
        textView.backgroundColor = .white
//        textView.usesRuler = true
        textView.isEditable = true
        textView.isSelectable = true
        textView.string = "hahahahah"

        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.minSize = NSMakeSize(0, scrollView.contentSize.height)
        textView.maxSize = NSMakeSize(CGFloat(FLT_MAX), CGFloat(FLT_MAX))
        textView.textContainer?.containerSize = NSMakeSize(scrollView.contentSize.width, CGFloat(FLT_MAX))
        textView.textContainer?.widthTracksTextView = true
        textView.textContainer?.heightTracksTextView = false

        textView.postsFrameChangedNotifications = true
        rulerView = TextVerticalRulerView(textView: textView) //TextVerticalRulerView(scrollView: scrollView, orientation: .verticalRuler)
        scrollView.verticalRulerView = rulerView

//        textView.enclosingScrollView?.hasVerticalScroller = true


//        scrollView.contentView.addSubview(textView)

//        textView.enclosingScrollView?.verticalRulerView = NSRulerView.init(scrollView: textView.enclosingScrollView, orientation: .verticalRuler)
//        textView.enclosingScrollView?.hasVerticalRuler = true
//        textView.isRulerVisible = true




//        scrollView.addSubview(textView)
//        scrollView.con

        NotificationCenter.default.addObserver(self, selector: #selector(TextViewController.selectorFrameDidChange(_:)), name:.NSViewFrameDidChange, object: textView)
        NotificationCenter.default.addObserver(self, selector: #selector(TextViewController.selectorTextDidChange(_:)), name:.NSTextDidChange, object: textView)
    }

    func selectorFrameDidChange(_ sender: NSTextView) {
        rulerView.needsDisplay = true
    }

    func selectorTextDidChange(_ sender: NSTextView) {
        rulerView.needsDisplay = true
    }

    // MARK: - NSTextViewDelegate
}
