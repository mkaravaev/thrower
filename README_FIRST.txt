needs to run: mix deps.get

Hello,
dear Sonnen engineers, this is my solution for a task.

I have a pleasant time to solving it even though, I don't have much
time to make it with a quality I would expect for production-ready code.

Here I want to mention about assumptions, limitations and intentional decisions I made.

First of all about test_cases.json. 
I ran it after I finished the code for the task and was surprised with some cases:

 - In case 3 (the one with prioritize-Vader) the villains' list for the expecting radar entry is sorted in a weird way.
I assumed there is some human-related error as it's not sorted by original entries, by malice or costume nor reversed. Maybe I overlooked
something but in the end this test did not pass even if it choose the correct radar entry.

 - case 4 (the one with avoid-crossfire)
 This test is not passed too. As I understand it should take the first non Donald Duck radar entry.
 As I'm processing radar entries in an order they came in params. I don't see any reasons to
 change implementation just to make a test pass. The strategy works correctly it just not working as
 test expected or there are some other intentions that are not clear to me enough.

 - cases 6 and 7(the last one and previous to it) those tests are passing but when 
 radar entry contains Lucifer villains are not an array(JS) as described in the task but just a plain 
 object. It may be made intentionally or again typo.

 Second of all, I've intentionally skipped moduledocs, specs as I had not much time to work on a task. 
 Only occasionally after working hours. Test coverage is also so-so.

 Thirdly, I haven't thought about any complexity optimizations event some parts seem can be improved.
