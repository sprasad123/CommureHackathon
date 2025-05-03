//
//  DailyLogView.swift
//  MindBridge
//
//  Created by Sonal Prasad on 5/3/25.
//

import SwiftUI

struct DailyLogEntry: Codable, Identifiable {
    var id = UUID()
    let date: Date
    let coping: Int
    let mood: Int
    let stress: Int
    let activities: [String]
}

struct DailyLogView: View {
    @State private var coping: Double = 5
    @State private var mood: Double = 5
    @State private var stress: Double = 5
    @State private var activities: [String] = [""]

    @State private var entries: [DailyLogEntry] = (UserDefaults.standard.data(forKey: "dailyLogEntries").flatMap {
        try? JSONDecoder().decode([DailyLogEntry].self, from: $0)
    }) ?? []

    var body: some View {
        NavigationView {
            Form {
                //–– Sliders (no header) ––
                Section {
                    VStack(alignment: .leading) {
                        Text("Coping ability: \(Int(coping))")
                        Slider(value: $coping, in: 0...10, step: 1)
                            .accessibility(value: Text("\(Int(coping))"))
                            .padding(.bottom)
                    }
                    VStack(alignment: .leading) {
                        Text("Overall mood: \(Int(mood))")
                        Slider(value: $mood, in: 0...10, step: 1)
                            .accessibility(value: Text("\(Int(mood))"))
                            .padding(.bottom)
                    }
                    VStack(alignment: .leading) {
                        Text("Stress level: \(Int(stress))")
                        Slider(value: $stress, in: 0...10, step: 1)
                            .accessibility(value: Text("\(Int(stress))"))
                    }
                }

                //–– Activities (no header) ––
                Section {
                    ForEach(activities.indices, id: \.self) { idx in
                        TextField("Activity \(idx + 1)", text: $activities[idx])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    Button(action: {
                        activities.append("")
                    }) {
                        Label("Add Activity", systemImage: "plus.circle")
                    }
                }

                //–– Save button ––
                Section {
                    Button("Save Entry") {
                        saveEntry()
                    }
                    .disabled(activities.allSatisfy { $0.trimmingCharacters(in: .whitespaces).isEmpty })
                }
            }
            .navigationTitle("Daily Log")
            .toolbar {
                Text("\(entries.count) entries")
            }
        }
    }

    private func saveEntry() {
        let entry = DailyLogEntry(
            date: Date(),
            coping: Int(coping),
            mood: Int(mood),
            stress: Int(stress),
            activities: activities.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        )
        entries.insert(entry, at: 0)

        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: "dailyLogEntries")
        }

        // Reset form
        coping = 5; mood = 5; stress = 5
        activities = [""]
    }
}

