enum Color {
    Red,
    Yellow,
    Green,
    Custom(u8, u8, u8),
}

fn main() {
    let color = Color::Custom(255, 128, 0);

    match color {
        Color::Red => println!("red"),
        Color::Yellow => println!("yellow"),
        Color::Green => println!("green"),
        Color::Custom(r, g, b) => println!("custom: {r}, {g}, {b}"),
    }
}
