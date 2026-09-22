pub struct HighScores<'a> {
    scores: &'a [u32],
}

impl<'a> HighScores<'a> {
    pub fn new(scores: &'a [u32]) -> Self {
        Self { scores }
    }

    pub fn scores(&self) -> &[u32] {
        self.scores
    }

    pub fn personal_best(&self) -> Option<u32> {
        self.scores.iter().max().copied()
    }

    pub fn latest(&self) -> Option<u32> {
        self.scores.last().copied()
    }

    pub fn personal_top_three(&self) -> Vec<u32> {
        let mut scores = self.scores.to_vec();

        scores.sort_unstable_by(|a, b| b.cmp(a));

        scores.into_iter().take(3).collect()
    }
}

fn main() {
    let scores = [30, 50, 20, 70, 65, 45];
    let high_scores = HighScores::new(&scores);

    println!("scores: {:?}", high_scores.scores());
    println!("personal best: {:?}", high_scores.personal_best());
    println!("latest: {:?}", high_scores.latest());
    println!("top three: {:?}", high_scores.personal_top_three());
}