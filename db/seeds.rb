dating_cat = Category.create!(code: "dating")
offer = Offer.create!(code: "dating-tips", affiliate_url: "https://www.tut.by/")
Page.create!(category: dating_cat, offer: offer,
  code: "why-senior-engineers-hate",
  content_url: "https://medium.com/swlh/why-senior-engineers-hate-coding-interviews-d583d2855757",
  title: "Why Senior Engineers Hate Coding Interviews")