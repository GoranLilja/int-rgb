//
//  ContentView.swift
//  Shared
//
//  Created by Göran Lilja on 2020-11-18.
//

import SwiftUI

struct ContentView: View {
    // MARK: - State properties
    @State private var red: String = "255"
    @State private var green: String = "255"
    @State private var blue: String = "255"
    @State private var alpha: String = "255"
    @State private var intValue: String = "-1"
    @State private var previewColor: Color = .white

    // MARK: - UI properties
    var body: some View {
        VStack(spacing: 10) {
            Text("Enter color values")
                .font(.title)

            HStack {
                VStack(spacing: 4) {
                    Text("Red")
                    TextField("Red", text: $red)
                        .frame(width: 35)
                }
                VStack(spacing: 4) {
                    Text("Green")
                    TextField("Green", text: $green)
                        .frame(width: 35)
                }
                VStack(spacing: 4) {
                    Text("Blue")
                    TextField("Blue", text: $blue)
                        .frame(width: 35)
                }
                VStack(spacing: 4) {
                    Text("Alpha")
                    TextField("Alpha", text: $alpha)
                        .frame(width: 35)
                }
            }

            VStack(spacing: 4) {
                Text("32 bit integer value")
                TextField("Integer", text: $intValue)
                    .frame(width: 100)
            }

            ColorPicker("", selection: $previewColor)
                .frame(width: 100, height: 100)
        }
        .padding()
        .onChange(of: red+green+blue+alpha, perform: calculateFromRGBA)
        .onChange(of: intValue, perform: calculateFromInt)
        .onChange(of: "\(previewColor.hashValue)", perform: calculateFromColor)
    }

    // MARK: - Private functions
    private func calculateFromRGBA(_ value: String) {
        guard let r = Int32(red),
              (0...255).contains(r),
              let g = Int32(green),
              (0...255).contains(g),
              let b = Int32(blue),
              (0...255).contains(b),
              let a = Int32(alpha),
              (0...255).contains(a) else {
            print("⚠️ Invalid number format!")
            return
        }
        let rgba = ColorCalculator.colorIntFromRBG(r: r, g: g, b: b, a: a)
        intValue = "\(rgba)"
        previewColor = Color(red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255).opacity(Double(a)/255)
    }

    private func calculateFromInt(_ value: String) {
        guard let rgbaInt = Int32(intValue) else {
            print("⚠️ Invalid 32 bit integer!")
            return
        }
        let rgba = ColorCalculator.RBGAFromInteger(rgbValue: rgbaInt)
        red = "\(rgba.r)"
        green = "\(rgba.g)"
        blue = "\(rgba.b)"
        alpha = "\(rgba.a)"
        previewColor = Color(red: Double(rgba.r)/255,
                             green: Double(rgba.g)/255,
                             blue: Double(rgba.b)/255)
            .opacity(Double(rgba.a)/255)
    }

    private func calculateFromColor(_ value: String) {
        print(#function)
        guard let components = previewColor.components else {
            print("⚠️ Unable to parse color!")
            return
        }

        red = "\(Int(components.red * 255))"
        green = "\(Int(components.green * 255))"
        blue = "\(Int(components.blue * 255))"
        alpha = "\(Int(components.alpha * 255))"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
