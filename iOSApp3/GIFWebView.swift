//
//  GIFWebView.swift
//  ExerciseApp
//
//  Created by Chris Goerk on 2025-02-19.
//

import SwiftUI
import WebKit

struct GIFWebView: UIViewRepresentable {
  let url: URL

  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.scrollView.isScrollEnabled = false
    webView.contentMode = .scaleAspectFit
    return webView
  } // makeUIView()

  func updateUIView(_ webView: WKWebView, context: Context) {
    let htmlString = """
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
      </head>
      <body style="margin:0;padding:0;display:flex;justify-content:center;align-items:center;height:100%;">
        <img src="\(url.absoluteString)" style="max-width:100%;height:auto;" />
      </body>
    </html>
    """
    webView.loadHTMLString(htmlString, baseURL: nil)
  } // updateUIView()
} // GIFWebView

#Preview {
  GIFWebView(url: URL(string: "https://example.com/animated.gif")!)
} // GIFWebView_Previews
