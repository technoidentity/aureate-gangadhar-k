use std::io;

struct HashTable {
    buckets: Vec<Vec<(i32, i32)>>,
}

impl HashTable {
    fn new() -> Self {
        let mut buckets = Vec::new();

        for _ in 0..10 {
            buckets.push(Vec::new());
        }

        Self { buckets }
    }

    fn insert(&mut self, key: i32, value: i32) {
        let index = key.rem_euclid(10) as usize;

        for (k, v) in &mut self.buckets[index] {
            if *k == key {
                *v = value;
                return;
            }
        }

        self.buckets[index].push((key, value));
    }

    fn search(&self, key: i32) -> Option<i32> {
        let index = key.rem_euclid(10) as usize;

        for (k, v) in &self.buckets[index] {
            if *k == key {
                return Some(*v);
            }
        }

        None
    }
}

fn main() {
    let mut table = HashTable::new();
    let mut input = String::new();

    println!("How many pairs?");
    io::stdin().read_line(&mut input).unwrap();

    let n: usize = input.trim().parse().unwrap();

    for _ in 0..n {
        input.clear();

        println!("Enter key and value:");
        io::stdin().read_line(&mut input).unwrap();

        let mut values = input.split_whitespace();

        let key: i32 = values.next().unwrap().parse().unwrap();
        let value: i32 = values.next().unwrap().parse().unwrap();

        table.insert(key, value);
    }

    input.clear();

    println!("Enter key to search:");
    io::stdin().read_line(&mut input).unwrap();

    let key: i32 = input.trim().parse().unwrap();

    match table.search(key) {
        Some(value) => println!("Value: {}", value),
        None => println!("Key not found"),
    }
}
