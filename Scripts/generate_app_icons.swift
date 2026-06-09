import AppKit

struct IconSpec {
    let filename: String
    let size: Int
}

let specs = [
    IconSpec(filename: "Icon-20.png", size: 20),
    IconSpec(filename: "Icon-20@2x.png", size: 40),
    IconSpec(filename: "Icon-20@3x.png", size: 60),
    IconSpec(filename: "Icon-29.png", size: 29),
    IconSpec(filename: "Icon-29@2x.png", size: 58),
    IconSpec(filename: "Icon-29@3x.png", size: 87),
    IconSpec(filename: "Icon-40.png", size: 40),
    IconSpec(filename: "Icon-40@2x.png", size: 80),
    IconSpec(filename: "Icon-40@3x.png", size: 120),
    IconSpec(filename: "Icon-60@2x.png", size: 120),
    IconSpec(filename: "Icon-60@3x.png", size: 180),
    IconSpec(filename: "Icon-76.png", size: 76),
    IconSpec(filename: "Icon-76@2x.png", size: 152),
    IconSpec(filename: "Icon-83.5@2x.png", size: 167),
    IconSpec(filename: "Icon-1024.png", size: 1024)
]

let outputDirectory = URL(fileURLWithPath: "MikeClub/Assets.xcassets/AppIcon.appiconset")
try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)

for spec in specs {
    let image = NSImage(size: NSSize(width: spec.size, height: spec.size))
    image.lockFocus()

    let bounds = NSRect(x: 0, y: 0, width: spec.size, height: spec.size)
    let gradient = NSGradient(colors: [
        NSColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1),
        NSColor(red: 0.95, green: 0.61, blue: 0.07, alpha: 1)
    ])
    gradient?.draw(in: bounds, angle: 45)

    let inset = CGFloat(spec.size) * 0.18
    let circle = NSBezierPath(ovalIn: bounds.insetBy(dx: inset, dy: inset))
    NSColor.white.setFill()
    circle.fill()

    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    let fontSize = max(8, CGFloat(spec.size) * 0.30)
    let attributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.boldSystemFont(ofSize: fontSize),
        .foregroundColor: NSColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1),
        .paragraphStyle: paragraph
    ]
    let text = "MC" as NSString
    let textHeight = text.size(withAttributes: attributes).height
    let textRect = NSRect(x: 0, y: (CGFloat(spec.size) - textHeight) / 2, width: CGFloat(spec.size), height: textHeight)
    text.draw(in: textRect, withAttributes: attributes)

    image.unlockFocus()

    guard
        let tiff = image.tiffRepresentation,
        let bitmap = NSBitmapImageRep(data: tiff),
        let png = bitmap.representation(using: .png, properties: [:])
    else {
        fatalError("Failed to render \(spec.filename)")
    }

    try png.write(to: outputDirectory.appendingPathComponent(spec.filename))
}

print("Generated \(specs.count) app icon files.")
