# Codex format


  The codex format is how bridge expects to find a useful ingenium to be
organized. 

Tis simple to explain and easy to do.  Let us say we are writing an ingenium called Genesis.  We shall need a structure like so:

```
- /genesis
  - /orb
  - /src
  - /doc
  - /lib
  - /etc
  - genesis
```

We see that we have a directory, five subsidiaries, and an eponymous file.

So far so good. 

## orb

  The `/orb` directory is the source of all truth. It contains Grimoires.

These are woven and knitted into `/doc` and `/src`, respectively.

It is allowable for the `/orb` directory to be empty. 


## src

`/src` is short for sorcery.  The source is in `/orb`.  We call the source to
sorcery transition a knit. 

  The important thing to know about the `/src` directory, is that Genesis 
considers it the home directory at runtime. 

It's where the code to run is kept, in whatever arrangement is useful to
the runtime, once it has been knitted out of the `/orb` directory by `grym`.

Codices tend to be like libraries or like programs.  For a program, the 
format is `name/name`, for a library, an alternative is `name/src/name/`,
and/or `name/src/name.ext`.  This is handy for codicies which happen to be
both.

In order to support the delicate operation of wrapping existing codebases
into codex format, `/src` can be the only source of truth. In this case
the `/orb` directory will either be empty, or contain only dotfiles. 


## lib

  All dependencies for `/src` are to be found at `/src/lib/`, a symlink to
`/lib`.  This is a subtlety.  `/lib` itself has one directory per dependency,
which in a normal bridge install will themselves be symlinks. 

One reason is that "src/lib" is a simple literal string, while "../lib" is a
description, with a verb, `..`, that is appreciably harder to reason about. 

Another is that it's a brown M & M. One way to make sure you don't make poor
assumptions about filesystems being literal is to make a mandatory symlink part
of the description format for programs.

In the end, I want `/lib` and `/src/lib`, and I want them to be identical, so
that's how it is. Since `/src` is the base directory from the code's 
perspective, `/lib` gives you the dependencies directly, and keeps the `/orb`
and `/doc` out of the way; not hidden, just that a normal program won't refer
to them or affect them.

Quirks are useful.  There's not much bandwidth in a filesystem with which to 
signal. A directory called `/lib` under `/src` could be anything, if it
resolves to the same absolute path as `../lib`, the likelihood we're dealing
with a codex goes up. 


### A further subtlety of /lib

Let us say we have a library, also in codex, which is called `numbers`. It
would have a format such as this:

```
- /numbers
  - /orb
  - /src
    - numbers.ext
  - /doc
  - /lib
  - /etc
  - numbers

```

In order to provide this as a library to `genesis`, we create a symlink in
this fashion, presuming that `.` contains both directories:

```sh
ln -s ./numbers/src/ ./genesis/lib/numbers
```

With this result:

```
- /genesis
  - /orb
  - /src
  - /doc
  - /lib
    - /numbers
      - numbers.ext
  - /etc
  - genesis
```

This allows `require` and friends to refer simply to "numbers", or if this is locally shadowed, "lib/numbers". 

Note that we intend to write a friendly tool, `manifest`, which will automate,
or at least smooth out, this process. 

For now, let's note some of the advantages of this approach.  One may readily
pin a library, provided some snapshot revision control system such as `git`,
by simply symlinking to the blob in question.

In addition, `/genesis` may be expanded thus:

```
- /genesis
  - /orb
  - /src
  - /doc
  - /lib
    - /numbers
      - /lib
      - numbers.ext
  - /etc
  - genesis
```

`./genesis/lib/numbers/lib`, followed, puts us in the actual directory
`./numbers/lib`.  The elision of `/src` is thus fairly well-behaved in
practice.  If directories in `/lib` are themselves in codex format this
may be readily checked and taken advantage of.


## /doc

  This contains the weave or weaves.  This is itself an opinionate use of HTML
and friends.  A back end responsible for assembling some web view can stick its
product anywhere it chooses (I have a notion for where); if it's in codex
format the documentation view of the source code will go here.

The subdirectories of `/doc` have names like `/html`, `/md`, or `/pdf`. These
are the main suffixes you would expect to find, to be sure, but refer to 
compilation targets rather than text formats per se. 

The root for an html weave of Genesis could be expected to be found at `/genesis/doc/html/genesis.html`, and so forth. 


## /etc

  Is the first example of an optional codex directory.  It's always good to
have a junk drawer.  Think of it as a lightweight container for assets.  If
a codex just needs a few binaries of the non-executable variety, toss them in
here.


### etc etc

  I'd rather you stick to three letters, but don't intend that my tools will
burn your barn and salt your fields if you don't. `manifest` and `bridge` only
need an `/orb` directory and will try and step lightly around any weirdly structured directories of the other names, but no promises. 

The premise is that if you have a few images and icons, they can go directly
into `/etc` or in `/etc/img`, as you please, while a codex with a whole work
history of hand-crafted image binaries would want a root-level `/img` 
directory to organize that.

I expect there will be projects for which a top-level `/bin` is also
appropriate. `/tmp` and `/log`, naturally, will show up from time to time. 

I should probably add some kind of dotfile at the root without which the
bettertools will refuse to recursively mangle a filesystem.  Hmm.


## (assert is-codex?)

  If a directory has an `/orb` directory, a `/src`  directory, a `/lib`
directory, and a `/src/lib` directory, and the `/src/lib` and `/lib` 
directories are the same entity, my tools will conclude they are in a 
familiar environment and... do things. 


### grym files

`bridge` shouldn't absolutely require that a codex-compliant directory
involve `grym` in any capacity.  Nor will it ignore that 99% of such
directories will be.

The additional criteria are a `.grymrc` file at the root, and that's it.
a `/.grym` directory is reserved but I intend that simple Grimoires won't
require, create, or use it. 

These aren't part of the core assertion because I want to support putting 
an existing project in the sorcery drawer, adding an `/orb` and `/lib`
and purling a `/src/lib` to please the djinn, and letting that work.

There is no need in such an instance to pretend the sorcery emanates from 
the orb.  



