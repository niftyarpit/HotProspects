//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Arpit Srivastava on 12/02/24.
//

import SwiftUI
import SwiftData
import CodeScanner

struct ProspectsView: View {

    enum FilterType {
        case none, contacted, uncontacted
    }

    let filter: FilterType

    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @State private var isShowingScanner = false

    var body: some View {
        NavigationStack {
            List(prospects) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.email)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button("Scan", systemImage: "qrcode.viewfinder") {
                    isShowingScanner = true
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Arpit\nnifty.arpit@gmail.com", completion: handleScan)
            }
        }
    }

    init(_ type: FilterType) {
        filter = type
        if  filter != .none {
            let showContactedOnly = filter == .contacted
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }

    private var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted"
        case .uncontacted:
            "Uncontacted"
        }
    }

    func handleScan(_ result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let scanResult):
            let components = scanResult.string.components(separatedBy: "\n")
            guard components.count == 2 else { return }
            let prospect = Prospect(name: components[0], email: components[1], isContacted: false)
            modelContext.insert(prospect)
        case .failure(let scanError):
            print("Scanning failed \(scanError.localizedDescription)")
        }
    }
}

#Preview {
    ProspectsView(.none)
        .modelContainer(for: Prospect.self)
}
