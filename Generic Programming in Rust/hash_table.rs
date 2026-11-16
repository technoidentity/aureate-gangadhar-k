use std::hash::{DefaultHasher, Hash, Hasher};
use std::io;

struct HashTable<K, V> {
    buckets: Vec<Vec<(K, V)>>,
}

impl<K: Eq + Hash, V> HashTable<K, V> {
    fn new() -> Self {
        let mut buckets = Vec::new();

        for _ in 0..10 {
            buckets.push(Vec::new());
        }

        Self { buckets }
    }

    fn bucket_index(&self, key: &K) -> usize {
        let mut hasher = DefaultHasher::new();
        key.hash(&mut hasher);
        (hasher.finish() % self.buckets.len() as u64) as usize
    }

    fn insert(&mut self, key: K, value: V) {
        let index = self.bucket_index(&key);

        for (k, v) in &mut self.buckets[index] {
            if *k == key {
                *v = value;
                return;
            }
        }

        self.buckets[index].push((key, value));
    }

    fn search(&self, key: &K) -> Option<&V> {
        let index = self.bucket_index(key);

        for (k, v) in &self.buckets[index] {
            if k == key {
                return Some(v);
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

    match table.search(&key) {
        Some(value) => println!("Value: {}", value),
        None => println!("Key not found"),
    }
}

