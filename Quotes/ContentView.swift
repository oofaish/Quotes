//
//  ContentView.swift
//  quotes
//
//  Created by Ali on 11/10/2023.
//

import SwiftUI
import SafariServices

extension View {
    func modify<T: View>(@ViewBuilder _ modifier: (Self) -> T) -> some View {
        return modifier(self)
    }
}

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    private var maxTaps = 2
    @State var taps: Int = 0
    @State var todaysIndex: Int = daysSinceSometimeIn2023()
    private var quoteOpacity: Double { taps == 0 ? 1.0 : 0.8}
    var quote: Quote {modelData.nextQuote(taps: taps, todaysIndex: todaysIndex)}

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                (colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.2) : Color.gray.opacity(0.2))
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    VStack {
                        Text(quote.quote)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .opacity(quoteOpacity)
                        // .animation(.easeIn(duration: 1.0), value: 1.0)
                            .colorScheme(.light)
                            .padding(.bottom, 20)

                        quote.author == "" ? nil : Text("- \(quote.author)")
                            .font(.caption)
                            .opacity(quoteOpacity)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal, 20)

                    Spacer()
                    VStack(alignment: .leading) {
                        Text("more tomorrow.")
                        Text("or tap to see a couple more.")
                        HStack(spacing: 0) {
                            Text("made with ❤️ and some 🐛's by ")
                            Text("ali cigari")
                                .underline()
                                .onTapGesture {
                                    if let url = URL(string: "https://cigari.co.uk") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            Text(".")
                        }
                        HStack(spacing: 0) {
                            Text("any issues? ")
                            Text("hit me up")
                                .underline()
                                .onTapGesture {
                                    if let url = URL(string: "https://cigari.co.uk/contact") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            Text(".")
                        }
                    }
                    .font(.footnote)
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.4) : .black.opacity(0.4))

                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .modify {// Makes the entire VStack tappable
                if #available(iOS 17.0, *) {
                    $0.onTapGesture { location in
                        withAnimation {
                            if location.x > geometry.size.width / 2 {
                                taps = min(maxTaps, taps + 1)
                            } else {
                                taps = max(-maxTaps, taps - 1)
                            }
                        }
                    }
                } else {
                    // Fallback on earlier versions
                    $0.onTapGesture {
                        withAnimation {
                            taps = (taps + 1) % maxTaps
                        }
                    }
                }
            }
        }
        .onAppear {
            taps = 0
            todaysIndex = daysSinceSometimeIn2023()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            taps = 0
            todaysIndex = daysSinceSometimeIn2023()
        }

    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
