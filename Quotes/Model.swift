//
//  Model.swift
//  quotes
//
//  Created by Ali on 12/10/2023.
//

import Foundation

func parseCSV(contents: String) -> [Quote] {
    var rows = contents.components(separatedBy: "\n")
    rows.removeFirst() // Remove header

    return rows.enumerated().compactMap { (id, row) -> Quote? in
        let columns = row.components(separatedBy: ";")
        guard columns.count == 1 || columns.count == 2 else {return nil}
        let quote = columns[0].trimmingCharacters(in: .whitespaces)
        let author = columns.count == 1 ? "" : columns[1].trimmingCharacters(in: .whitespaces)
        if author == "" && quote == "" {
            return nil
        }
        return Quote(id: id, quote: quote, author: author)
    }
}

func loadCSV(_ filename: String) -> [Quote] {
    guard let path = Bundle.main.path(forResource: filename, ofType: "csv"),
          let contents = try? String(contentsOfFile: path) else {
        return []
    }

    return parseCSV(contents: contents)
}

final class ModelData: ObservableObject {
    // published decorator allows you to modify the data
    var quotes: [Quote] = loadCSV("quotes")

    func nextIndex(taps: Int, todaysIndex: Int) -> Int {
        (quotes.count + todaysIndex + taps) % quotes.count
    }

    func nextQuote(taps: Int, todaysIndex: Int) -> Quote {
        quotes[nextIndex(taps: taps, todaysIndex: todaysIndex)]
    }
}
