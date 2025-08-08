import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Uffici") {
                eseguiComando("http://192.168.7.251/fcgi/do?action=OpenDoor&UserName=admin&Password=Cit1Uffici&DoorNum=1")
            }
            .buttonStyle(StilePulsante())

            Button("Uff-mag") {
                eseguiComando("http://192.168.7.251/fcgi/do?action=OpenDoor&UserName=admin&Password=Cit2Magazzino&DoorNum=1")
            }
            .buttonStyle(StilePulsante())

            Button("Carraio") {
                eseguiComando("http://192.168.7.252/fcgi/do?action=OpenDoor&UserName=admin&Password=Cit3Carraio&DoorNum=1")
            }
            .buttonStyle(StilePulsante())
        }
        .padding()
    }

    private func eseguiComando(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("Errore: \(error.localizedDescription)")
            } else {
                print("Comando inviato con successo a \(urlString)")
            }
        }.resume()
    }
}

struct StilePulsante: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
