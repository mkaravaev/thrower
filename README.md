Dear comic fan,

You're invited to a carnival party with the motto "comic-heroes". Some guests
dressed up as all the heroes you've admired being a child, especially as Donald
Duck. Other guests obviously celebrate the comic villains. That can't be! 

Your skills and knowledge of cream pies and physics are remarkable. That is why
we need your help to modify a cream pie thrower to show the villains who is
winning tonight. :) 

Your **mission** will consist of reprogramming the **villains selection
module**. This module is responsible for selecting the next position to attack
given several possible attack positions. The cream pie thrower will communicate
via *HTTP POST* requests with your module, providing the data that the vision
module has collected.

The objective of the mission is to develop an **HTTP endpoint** that accepts
**JSON** data and returns **JSON** data.

This is an example of a request from the control unit to your module:

```json
[
  {
    "attack-mode": [
      "closest-first"
    ],
    "radar": [
      {
        "position": {
          "x":0,
          "y":40
        },
        "villains": [
          {
            "costume": "Shir Khan",
            "malice": 80
          },
          {
            "costume": "Voldemort",
            "malice": 20
          },
          {
            "costume": "Donald Duck"
          }
        ]
      },
      {
        "position": {
          "x": 2,
          "y":60
        },
        "villains": [
          {
            "costume":"Shir Khan",
            "malice": 40
          }
        ]
      },
      ...
```

And here's a definition of the properties:

- **attack-mode**: Chosen mode for the attack.
- **radar**
  - **position**: Target group position.
    - **x**: X coordinate.
    - **y**: Y coordinate.
  - **villains**: Found villains.
    - **costume**: Costume type.
    - **malice**: The malice of the villain.

Given the previous request, your module should return a response like this:

```json
{ "position": { "x": 0, "y": 40 }, "villains": [ "Shir Khan", "Voldemort" ] }
```

The attack modes we have implemented in the cream pie thrower are:

- **closest-first**: Attack the nearest areas.
- **furthest-first**: Attack the furthest areas.
- **avoid-crossfire**: Do not attack any area where Donald Duck costume is present.
- **prioritize-vader**: The attack must always prioritize Darth Vader costumes.

Costumes that the vision system will detect are:

- **Donald Duck**
- **Shir Khan**
- **Joker**
- **Darth Vader**
- **Lucifer**
- **Captain Hook**
- **Voldemort**

Keep in mind that attack modes can be chained but you should not chain opposite
attack modes, like closest-first and furthest-first. Example

```json
[{ "attack-mode": [ "closest-first", "prioritize-vader" ], "radar": ...
```

New guests will show up at the party and dress like other comic villains; the
system should be prepared to add new attack modes.

By running the *test_attack.sh* script on your machine, you will have access to
a set of tests to prove your villains selection module, present in the
*test_cases.json* file. 

At the end of the mission, you must compress all source files with the
**unmodified** `test_attack.sh` file included in a file called
`<your-name>_codetest_sonnen.zip` and send it back to us.

PS: Add to the compressed file any document that you have generated to solve
the problem even if it is just a text file, a diagram, git commits etc. because
we would like to see your problem-solving approach, not only the final
solution.
