import SwiftUI

struct ContentView: View {
    @State private var width: CGFloat = 300
    @State private var height: CGFloat = 100
    @State private var selectedView: String? = nil
    @State private var generation: Int = 0

    var subject: some View {
        Text("Hello")
            .debugLayout("Text")
            .padding()
            .debugLayout("padding")
    }

    var body: some View {
        VStack {
            VStack {
                subject
                    .startDebugLayout(selection: selectedView)
                    .id(generation)
                    .frame(width: width, height: height)
                    .overlay {
                        Rectangle()
                            .strokeBorder(style: StrokeStyle(dash: [5]))
                    }
                    .padding(.bottom, 16)

                VStack {
                    LabeledContent {
                        HStack {
                            Slider(value: $width, in: 50...500, step: 1)
                            Stepper("Width", value: $width)
                        }
                        .labelsHidden()
                    } label: {
                        Text("W \(width, format: .number.precision(.fractionLength(0)))")
                            .monospacedDigit()
                    }

                    LabeledContent {
                        HStack {
                            Slider(value: $height, in: 50...500, step: 1)
                            Stepper("Height", value: $height)
                        }
                        .labelsHidden()
                    } label: {
                        Text("H \(height, format: .number.precision(.fractionLength(0)))")
                            .monospacedDigit()
                    }

                    Button("Reset layout cache") {
                        generation += 1
                    }
                }
                .buttonStyle(.bordered)
            }
            .padding()

            DebugLayoutLogView(selection: $selectedView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
