pub fn reverse(input: &str) -> String {
    input.chars().rev().collect()
}

fn main() {
    let result = reverse("stressed");
    println!("{}", result);

    let result = reverse("strops");
    println!("{}", result);

    let result = reverse("racecar");
    println!("{}", result);
}