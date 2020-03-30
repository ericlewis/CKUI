import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .foregroundColor(.white)
                .padding()
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 13, style: .continuous).fill(Color.accentColor))
    }
}
