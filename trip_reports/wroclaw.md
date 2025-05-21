# Trip Report: Autumn ISO C++ Committee Meeting (Wrocław, Poland)

_22 November 2024_

The ISO C++ Standard Committee held its November 2024 meeting in Wrocław, Poland. It's an important meeting for C++26 as it's the last meeting for the Evolution Working Group to approve C++26 features needing library response. This means that proposals having both core language and standard library impact need to get either Evolution Working Group (EWG) or Library Evolution Working Group (LEWG) approved by the end of the Wrocław meeting to be included in C++26. For most of the time, I was sitting in the Evolution Working Group as I am mostly interested in language features that may impact compiler designs. Here are some thoughts on some of the major discussions I have participated in.

## Reflection

[P2996](wg21.link/P2996) is a paper that progressed very quickly through the previous three meetings. It was first seen in Kona in November 2023. During the St. Louis meeting, the paper received strong consensus to be forwarded to LWG and CWG for review. I am personally very excited about this feature. It's a transformative feature for C++26 and will empower libraries to significantly improve ergonomics for daily programming. (e.g. think about deriving serialization, logging entire structs, and command line argument parsing.)

[P3451](https://wg21.link/P3451): The biggest open question as a challenge to the status quo of [P2996](http://wg21.link/p2996) is whether reflection APIs like `members_of` should respect accessibility. This was the main argument in EWG on Wednesday.

* The libc++ maintainer voiced their concern about people depending on reflection APIs to access private APIs in the standard library. However, in practice, people do try to access standard library private APIs by providing an alternative class declaration with friends.
* I tried to propose to the libc++ author in the room that we can have a second API with an alternative, potentially inconvenient spelling that returns all members ignoring accessibility, because accessing inaccessible members can be useful in cases like logging.
* Arguments against an inconvenient spelling include the implied unsafety of reflection, and that people should have no expectations on portability.

In the end, no consensus was reached whether we should make inconvenient spellings for accessing private members. The general feeling of the room is that we need to retain some form of access to private and protected members. 

## Pattern Matching

Pattern Matching is a feature seen in many functional languages that provides very powerful and ergonomic control flow. Currently, it's extremely inconvenient to pattern match standard library constructs like `std::variant<Ts...>` . As of C++23, people have to do library tricks to emulate pattern matching that is nowhere nearly as powerful and elegant. I believe there's good reasons to be excited about [P2688](https://wg21.link/p2688): Pattern Matching: `match` Expression. Michael Park presented the paper in EWG on Thursday morning where the committee made progress on the discussions. There is consensus that we'd like to encourage more work on Michael Park's P2688 for C++26 inclusion.

There's also an alternative proposal [P2392](https://wg21.link/P2392) by Herb Sutter to adopt 'is' and 'as' for pattern matching. My main concern on 'is' and 'as' is that it's introducing plenty of cascading rules, potentially making it difficult to distinguish dynamic or static casts, which is particularly problematic under dependent contexts. The working group reached no consensus on whether we want such a feature.

## Contracts

[P2900R11](https://wg21.link/p2900r11): Contracts for C++ is a much requested language feature for safety critical application. The EWG reserved a day and a half to discuss contracts and make a decision on whether Contracts should be included in C++26. The notion of safety in contracts is different from UB safety. In short, the current status of P2900 allows users to define dynamic assertions as preconditions and postconditions on function parameters as well as using contract assertion statements within a function body. A brief example can be found on section 2.2 of the paper. Although the group voted to forward this paper for library and wording review, the consensus for the current design is weak. There are major objections around multiple aspects of the design. 

* UB during contract evaluation: there are strong objections to allowing all expressions in contracts predicate due to UB safety issues. However, the trade off might be the expressibility of the contract. 
* Constification: Values used in contract predicate are *implicitly const l-values* to prevent bugs caused by *unintentional modifications of entities outside the predicate*. (Note: text in *italics* are quotes from paper, cr to original author) It was quite a debate in the room. Supporting parties have attempted to convert certain open source projects (including LLVM) to contract assertions and a large majority (>98%) are free of issues. The remaining bits included fixing bugs where existing assertion code had side effects.
* Limited customization for contract violation handling. 

An alternative proposal for what's called a conveyor function would like to limit what expression you can put into the predicate and hence address UB and the motivation of constification. This, on the other hand, makes contracts much less powerful. P2900 and its competing papers Since the consensus is weak we will likely see objections later on in the process. 

## Profiles

Herb Sutter presented [P3081](https://wg21.link/p3081): *Core safety Profiles: Specification, adoptability, and impact* to EWG on Friday Morning. Profiles has been a popular topic among folks who cite the [February White House paper](https://www.whitehouse.gov/wp-content/uploads/2024/02/Final-ONCD-Technical-Report.pdf) on the recommendation of Programming Languages. There was also a discussion referred to a post by Chandler Carruth about how Google [enabled bounds checking with minimal overhead](https://chandlerc.blog/posts/2024/11/story-time-bounds-checking/). While I am in support for safety and security, I voiced my concerns about how diverging perception of safety can be harmful. If we are on our way to convince the US government about C++ being safe (or safer now,) we might be sending the wrong message to the developers who may start to treat memory safety less seriously. Since we have only seen a published version of this paper a bit over a month ago, time for inclusion to C++26 is limited. The committee reached consensus to make a policy exception for Profiles to be reviewed again in Hagenberg in February for potential inclusion to C++26, despite its simultaneous language and library impact.

## Fun Stuff

On Thursday afternoon, JF Bastien presented [P3477](https://wg21.link/p3477): *There are exactly 8 bits in a byte*. This paper had seen hot internet engagement before the meeting and made us aware of many exotic architectures. In the end, we forwarded this paper to CWG for inclusion in C++26 with consensus. 

## Final Words

Overall, it's an overwhelmingly positive experience to meet with the other 144 committee members who attended in person. It's a good reminder to all of us that different interests and strong opinions occur based on the vastly different backgrounds of committee members. We may not agree with one another but with our enthusiasm, the collective goal is to make C++ experience better over time for millions. Personally, it's an opportunity for growth in my comfort zone and practicing technical trade off discussions at high stakes.
