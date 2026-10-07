fn main() {
    let numbers = [1, 2, 3, 4, 5];
    let mut sum = 0;

    for n in numbers {
        sum += n;
    }
    println!("Sum of array: {}", sum);
}
