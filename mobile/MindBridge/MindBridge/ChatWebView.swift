//
//  ChatWebView.swift
//  MindBridge
//
//  Created by Sonal Prasad on 5/3/25.
//

import SwiftUI
import WebKit

struct ChatbotWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.allowsBackForwardNavigationGestures = false
        webview.scrollView.isScrollEnabled = true
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}

