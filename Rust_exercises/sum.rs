use std::io;

fn main() {
    let mut first = String::new();
    let mut second = String::new();

    println!("Enter the first number:");
    io::stdin().read_line(&mut first).unwrap();

    println!("Enter the second number:");
    io::stdin().read_line(&mut second).unwrap();

    let a: i32 = first.trim().parse().unwrap();
    let b: i32 = second.trim().parse().unwrap();

    println!("Sum = {}", a + b);
}
