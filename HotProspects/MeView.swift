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
    @State private var qrImage = UIImage()

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

                Image(uiImage: qrImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        ShareLink(item: Image(uiImage: qrImage),
                                  preview: SharePreview("My QR code",
                                                        image: Image(uiImage: qrImage)))
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateQRImage)
            .onChange(of: name, updateQRImage)
            .onChange(of: email, updateQRImage)
        }
    }

    private func generateQRCode(string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle")!
    }

    private func updateQRImage() {
        qrImage = generateQRCode(string: "\(name)/n\(email)")
    }
}

#Preview {
    MeView()
}
