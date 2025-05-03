//
//  ContentView.swift
//  MindBridge
//
//  Created by Sonal Prasad on 5/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DailyLogView()
                .tabItem {
                    Image(systemName: "book.closed")
                    Text("Daily Log")
                }

            JournalView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Journaling")
                }

//            ChatbotWebView(url: URL(string: "https://your-gradio-app-url")!)
//                .tabItem {
//                    Image(systemName: "message")
//                    Text("Chatbot")
//                }
        }
    }
}
