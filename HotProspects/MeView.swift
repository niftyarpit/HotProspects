//
//  MeView.swift
//  HotProspects
//
//  Created by Arpit Srivastava on 12/02/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {

    @AppStorage("name") private var name = "Arpit"
    @AppStorage("email") private var email = "nifty.arpit@gmail.com"

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)

                TextField("Email address", text: $email)
                    .textContentType(.emailAddress)
                    .font(.title)

                Image(uiImage: generateQRCode(string: "\(name)/n\(email)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            .navigationTitle("Your code")
        }
    }

    func generateQRCode(string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle")!
    }
}

#Preview {
    MeView()
}
