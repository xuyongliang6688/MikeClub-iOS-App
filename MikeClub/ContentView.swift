import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        LocalHTMLView()
            .background(Color(red: 0.10, green: 0.10, blue: 0.10))
            .ignoresSafeArea(.container, edges: .bottom)
    }
}

private struct LocalHTMLView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .default()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.isOpaque = false
        webView.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1)
        webView.scrollView.backgroundColor = webView.backgroundColor
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.allowsBackForwardNavigationGestures = false
        loadIndexHTML(in: webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if webView.url == nil {
            loadIndexHTML(in: webView)
        }
    }

    private func loadIndexHTML(in webView: WKWebView) {
        guard let url = Bundle.main.url(forResource: "index", withExtension: "html") else {
            webView.loadHTMLString("<html><body style='background:#1a1a1a;color:white;font:-apple-system-body;padding:24px'>未找到 index.html</body></html>", baseURL: nil)
            return
        }

        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
}
