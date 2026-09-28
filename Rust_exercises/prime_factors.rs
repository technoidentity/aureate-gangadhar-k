pub fn factors(mut n: u64) -> Vec<u64> {
    let mut result = Vec::new();
    let mut divisor = 2;

    while n > 1 {
        if n % divisor == 0 {
            result.push(divisor);
            n /= divisor;
        } else {
            divisor += 1;
        }
    }

    result
}

fn main() {
    let numbers = [60, 84, 2, 999, 1];

    for n in numbers {
        println!("{} -> {:?}", n, factors(n));
    }
}