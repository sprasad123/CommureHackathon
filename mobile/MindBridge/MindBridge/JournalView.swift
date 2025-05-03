//
//  JournalView.swift
//  MindBridge
//
//  Created by Sonal Prasad on 5/3/25.
//

import SwiftUI

struct JournalView: View {
    @State private var journalText: String = ""
    @State private var entries: [String] = UserDefaults.standard.stringArray(forKey: "journalEntries") ?? []

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $journalText)
                    .border(.gray)
                    .padding()

                Button("Submit") {
                    guard !journalText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                    entries.append(journalText)
                    UserDefaults.standard.set(entries, forKey: "journalEntries")
                    journalText = ""
                }
                .padding()
                .disabled(journalText.trimmingCharacters(in: .whitespaces).isEmpty)

                List(entries, id: \.self) { entry in
                    Text(entry)
                        .padding(.vertical, 4)
                }
            }
            .navigationTitle("Journal")
        }
    }
}

