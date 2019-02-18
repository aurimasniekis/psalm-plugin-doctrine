Feature: Collections
  In order to use Doctrine Collections safely
  As a Psalm user
  I need Psalm to typecheck collections

  Background:
    Given I have the following config
      """
      <?xml version="1.0"?>
      <psalm totallyTyped="true">
        <projectFiles>
          <directory name="."/>
        </projectFiles>
        <plugins>
          <pluginClass class="Weirdan\DoctrinePsalmPlugin\Plugin" />
        </plugins>
      </psalm>
      """
    And I have the following code preamble
      """
      <?php
      use Doctrine\Common\Collections\Collection;
      use Doctrine\Common\Collections\ArrayCollection;

      """

  @Collection::add
  Scenario: Adding an item of invalid type to the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->add(1);
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                 |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::add expects string, int% provided |
    And I see no other errors

  @Collection::add
  Scenario: Adding an item of a valid type to the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->add("d");
      """
    When I run Psalm
    Then I see no errors

  @Collection::contains
  Scenario: Checking if collection contains an element of invalid type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->contains(1);
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                      |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::contains expects string, int% provided |
    And I see no other errors

  @Collection::contains
  Scenario: Checking if collection contains an element of a valid type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->contains("a");
      """
    When I run Psalm
    Then I see no errors

  @Collection::remove
  Scenario: Removing element with an invalid key type from the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->remove("string key");
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                    |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::remove expects int, string% provided |
    And I see no other errors

  @Collection::remove
  Scenario: Removing element with a valid key type from the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->remove(1));
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                 |
      | InvalidScalarArgument | Argument 1 of atan expects float, null\|string provided |
    And I see no other errors

  @Collection::removeElement
  Scenario: Removing element of an invalid type from the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->removeElement(1);
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                           |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::removeElement expects string, int% provided |
    And I see no other errors

  @Collection::removeElement
  Scenario: Removing element of a valid type from the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->removeElement("a"));
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                         |
      | InvalidScalarArgument | Argument 1 of atan expects float, bool provided |
    And I see no other errors

  @Collection::containsKey
  Scenario: Checking if collection contains a key with invalid key type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->containsKey("string key");
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                         |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::containsKey expects int, string% provided |
    And I see no other errors

  @Collection::containsKey
  Scenario: Checking if collection contains a key with valid key type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->containsKey(1);
      """
    When I run Psalm
    Then I see no errors

  @Collection::get
  Scenario: Getting an element from the collection using invalid key type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->get("string key");
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                 |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::get expects int, string% provided |
    And I see no other errors

  @Collection::get
  Scenario: Getting an element from the collection using a valid key type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->get(1));
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                 |
      | InvalidScalarArgument | Argument 1 of atan expects float, null\|string provided |
    And I see no other errors

  @Collection::getKeys
  Scenario: Getting collection keys from the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->getKeys());
      """
    When I run Psalm
    Then I see these errors
      | Type            | Message                                                  |
      | InvalidArgument | Argument 1 of atan expects float, array<%, int> provided |
    And I see no other errors

  @Collection::getValues
  Scenario: Getting collection values from the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->getValues());
      """
    When I run Psalm
    Then I see these errors
      | Type            | Message                                                     |
      | InvalidArgument | Argument 1 of atan expects float, array<%, string> provided |
    And I see no other errors

  @Collection::set
  Scenario: Setting collection entry with invalid key
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->set("string key", "d");
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                 |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::set expects int, string% provided |
    And I see no other errors

  @Collection::set
  Scenario: Setting collection entry with invalid value
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->set(1, 1);
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                 |
      | InvalidScalarArgument | Argument 2 of Doctrine\Common\Collections\Collection::set expects string, int% provided |
    And I see no other errors

  @Collection::toArray
  Scenario: Getting array of collection contents
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->toArray());
      """
    When I run Psalm
    Then I see these errors
      | Type            | Message                                                       |
      | InvalidArgument | Argument 1 of atan expects float, array<int, string> provided |
    And I see no other errors

  @Collection::first
  Scenario: Getting first item of the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->first());
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                  |
      | InvalidScalarArgument | Argument 1 of atan expects float, false\|string provided |
    And I see no other errors

  @Collection::last
  Scenario: Getting last item of the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->last());
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                  |
      | InvalidScalarArgument | Argument 1 of atan expects float, false\|string provided |
    And I see no other errors

  @Collection::key
  Scenario: Getting current key of the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      strlen($c->key());
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                 |
      | InvalidScalarArgument | Argument 1 of strlen expects string, null\|int provided |
    And I see no other errors

  @Collection::current
  Scenario: Getting current value of the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->current());
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                  |
      | InvalidScalarArgument | Argument 1 of atan expects float, false\|string provided |
    And I see no other errors

  @Collection::next
  Scenario: Getting next value of the collection
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->next());
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                  |
      | InvalidScalarArgument | Argument 1 of atan expects float, false\|string provided |
    And I see no other errors

  @Collection::exists
  Scenario: Invoking exists with a closure accepting wrong type of argument
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->exists(function(int $_p): bool { return (bool) rand(0,1); });
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                                               |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::exists expects Closure(string):bool, Closure(int):bool provided |
    And I see no other errors

  @Collection::exists
  Scenario: Invoking exists with a closure having a wrong return type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->exists(function(string $_p): int { return rand(0,1); });
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                                                 |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::exists expects Closure(string):bool, Closure(string):int provided |
    And I see no other errors

  @Collection::filter
  Scenario: Invoking filter with a valid closure
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->filter(function(string $_p): bool { return (bool) rand(0,1); }));
      """
    When I run Psalm
    Then I see these errors
      | Type            | Message                                                                                        |
      | InvalidArgument | Argument 1 of atan expects float, Doctrine\Common\Collections\Collection<int, string> provided |
    And I see no other errors

  @Collection::filter
  Scenario: Invoking filter with a closure having wrong param type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->filter(function(int $_p): bool { return (bool) rand(0,1); });
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                                               |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::filter expects Closure(string):bool, Closure(int):bool provided |
    And I see no other errors

  @Collection::filter
  Scenario: Invoking filter with a closure having wrong return type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->filter(function(string $_p): int { return rand(0,1); });
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                                                 |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::filter expects Closure(string):bool, Closure(string):int provided |
    And I see no other errors

  @Collection::forAll
  Scenario: Invoking forAll with a closure having wrong first argument type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->forAll(function(string $_k, string $_v): bool { return (bool) rand(0,1); });
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                                                               |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::forAll expects Closure(int, string):bool, Closure(string, string):bool provided |
    And I see no other errors

  @Collection::forAll
  Scenario: Invoking forAll with a closure having wrong second argument type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->forAll(function(int $_k, int $_v): bool { return (bool) rand(0,1); });
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                                                         |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::forAll expects Closure(int, string):bool, Closure(int, int):bool provided |
    And I see no other errors

  @Collection::forAll
  Scenario: Invoking forAll with a closure having wrong return type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->forAll(function(int $_k, string $_v): int { return rand(0,1); });
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                                                           |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::forAll expects Closure(int, string):bool, Closure(int, string):int provided |
    And I see no other errors

  @Collection::map
  Scenario: Invoking map with a proper closure
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->map(function(string $_p): bool { return (bool) rand(0,1); }));
      """
    When I run Psalm
    Then I see these errors
      | Type            | Message                                                                                      |
      | InvalidArgument | Argument 1 of atan expects float, Doctrine\Common\Collections\Collection<int, bool> provided |
    And I see no other errors

  @Collection::map
  Scenario: Invoking map with a closure having wrong parameter type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->map(function(int $_p): bool { return (bool) rand(0,1); });
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                                             |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::map expects Closure(string):mixed, Closure(int):bool provided |
    And I see no other errors

  @Collection::partition
  Scenario: Invoking partition with a proper closure
    Given I have Psalm newer than "3.0.12" (because of "Psalm bug, see vimeo/psalm#1248")
    And I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->partition(function(string $_p): bool { return (bool) rand(0,1); }));
      """
    When I run Psalm
    Then I see these errors
      | Type            | Message                                                                                                                                                        |
      | InvalidArgument | Argument 1 of atan expects float, array{0:Doctrine\Common\Collections\Collection<int, string>, 1:Doctrine\Common\Collections\Collection<int, string>} provided |
    And I see no other errors

  @Collection::partition
  Scenario: Invoking partition with a closure having wrong parameter type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->partition(function(int $_p): bool { return (bool) rand(0,1); });
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                                                  |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::partition expects Closure(string):bool, Closure(int):bool provided |
    And I see no other errors

  @Collection::partition
  Scenario: Invoking partition with a closure having wrong return type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->partition(function(string $_p): int { return rand(0,1); });
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                                                    |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::partition expects Closure(string):bool, Closure(string):int provided |
    And I see no other errors

  @Collection::indexOf
  Scenario: Invoking indexOf with a wrong type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->indexOf(1);
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                     |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::indexOf expects string, int% provided |
    And I see no other errors

  @Collection::indexOf
  Scenario: Invoking indexOf with a proper type
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      strlen($c->indexOf("d"));
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                  |
      | InvalidScalarArgument | Argument 1 of strlen expects string, false\|int provided |
    And I see no other errors

  @Collection::slice
  Scenario: Invoking slice with a wrong start offset
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->slice("string key");
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                   |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::slice expects int, string% provided |
    And I see no other errors

  @Collection::slice
  Scenario: Invoking slice with a wrong length
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c->slice(1, "zzzz");
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                         |
      | InvalidScalarArgument | Argument 2 of Doctrine\Common\Collections\Collection::slice expects int\|null, string% provided |
    And I see no other errors

  @Collection::slice
  Scenario: Invoking slice with correct param types
    Given I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      atan($c->slice(1, 1));
      atan($c->slice(1, null));
      atan($c->slice(1 ));
      """
    When I run Psalm
    Then I see these errors
      | Type            | Message                                                       |
      | InvalidArgument | Argument 1 of atan expects float, array<int, string> provided |
      | InvalidArgument | Argument 1 of atan expects float, array<int, string> provided |
      | InvalidArgument | Argument 1 of atan expects float, array<int, string> provided |
    And I see no other errors

  @Collections::ArrayAccess
  Scenario: Adding an item to collection like an array
    Given I have Psalm newer than "3.0.13" (because of "Psalm bug, see vimeo/psalm#1260")
    And I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c[] = "d";
      """
    When I run Psalm
    Then I see no errors

  @Collections::ArrayAccess
  Scenario: Adding an item to collection with array offset access
    # This was fine previously, but only because no types were checked in this assignment
    And I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c[10] = "d";
      """
    When I run Psalm
    Then I see no errors

  @Collections::ArrayAccess
  Scenario: Adding an item of a wrong type with array-like push
    Given I have Psalm newer than "3.0.13" (because of "Psalm bug, see vimeo/psalm#1260")
    And I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c[] = 1.1;
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                         |
      | InvalidScalarArgument | Argument 2 of Doctrine\Common\Collections\Collection::offsetSet expects string, float% provided |

  @Collections::ArrayAccess
  Scenario: Adding an item using wrong type with array offset access
    Given I have Psalm newer than "3.0.13" (because of "Psalm bug, see vimeo/psalm#1260")
    And I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c[10] = 1.1;
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                         |
      | InvalidScalarArgument | Argument 2 of Doctrine\Common\Collections\Collection::offsetSet expects string, float% provided |

  @Collections::ArrayAccess
  Scenario: Adding an item using wrong key type with array offset access
    Given I have Psalm newer than "3.0.13" (because of "Psalm bug, see vimeo/psalm#1260")
    And I have the following code
      """
      /** @var Collection<int,string> */
      $c = new ArrayCollection(["a", "b", "c"]);
      $c["10"] = "aaa";
      """
    When I run Psalm
    Then I see these errors
      | Type                  | Message                                                                                         |
      | InvalidScalarArgument | Argument 1 of Doctrine\Common\Collections\Collection::offsetSet expects null\|int, string% provided |
