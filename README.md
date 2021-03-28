## Versioned Values

A transparency and decisions making tool to create and maintain **semantically versioned principles and values** to live a principle-centered life.
  
## Motivation

Living a principle centered life gives someone the tools to act pro-actively, to live by their values rather than react to life's circumstances. Principle-centered decisions give the necessary distance and perspective to avoid emotional decisions that may not be in line with what someone believes. 

Principles are in-arguable, non-changing and intrinsic. Principles are not actionable. Values are our interpretation of our principles. Values are actionable. Values are a decision making tool to live a principle-centered life. Someone's interpretation of their principles will change over time. Their decisions may put certain values in conflict. Because cognitive dissonance is a fact of life, a hierarchy of values is necessary. 

**Versioned Values offers the following:**
- A decision making tool to make principle-centered decisions and live the way you want to
- The flexibility to update your principles as you learn and grow
- Transparency and clarity over your own principles and values for yourself and others


### Principle Value Hierarchy example

Value Hierarchy Version: 1-1
1. Principle: Accountability | Value: Keeping my commitments, even in the face of adversity
2. Principle: Empathy | Value: Actively listening and engaging others to connect and understand other perspectives.
3. Principle: Initiative | Value: Focus not on finishing, but starting. Start as early as possible and start as often as possible

### Learn more

- https://dazne.net/principle/
- https://open.spotify.com/episode/1uDbfEbRvi1S3Bckr7VUU3?si=066b7087032b4a21

## Installation
1. Install Ruby
2. Clone the repo down

## How To Use

Run the application using the following command. If this is the first time you've run the command the application will initialize your values. Otherwise it will print the latest value.
```
ruby main.rb
```
Flags
```
-u : update your hierarchy
-r : print release notes
-l : print version list
-v : print a specific version by providing a version after the flag in this format '1-0'
```

### Example CLI
```
#Print Version 1-0
ruby main.rb -v 1-0

#Print Release Notes
ruby main.rb -r

#Print latest version
ruby main.rb
```

## Tech

Built with
- [Ruby](https://www.ruby-lang.org/en/)
