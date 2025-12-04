<h1>Go–Swift Integration (macOS): Static Linking with cgo</h1>

<p>
This repository demonstrates how to integrate Go code into a macOS Swift application
using <strong>static linking</strong> via Go’s <code>c-archive</code> mode.
The project showcases how Go functions can be compiled into a C-compatible
static library and then called directly from Swift through a bridging header.
</p>

<p>
All implementation details, technical explanations, and code examples are documented here:
<a href="https://secretive-fascinator-c6c.notion.site/GO-Wrapper-in-Swift-126d7fcea35280e3aa7eff0076d13135?pvs=4" target="_blank">Full Implementation Documentation</a>.
</p>

<h2>Concept Overview</h2>
<p>
Unlike older approaches that relied on dynamically loading Go <code>.so</code> files,
modern Xcode versions no longer allow external dynamic libraries of this type.
The correct and supported method is to compile Go code as a
<strong>static archive (.a)</strong> along with a generated
<strong>C header (.h)</strong>.
</p>

<p>
These files are then imported into Swift using a bridging header, allowing the
Swift macOS application to call Go-exported functions as if they were native
C functions.
</p>

<h2>Contents</h2>
<ul>
  <li><strong>Go Code:</strong> Go functions exported via cgo using the C ABI. The Go code is compiled into <code>libfibonacci.a</code> and a generated header <code>libfibonacci.h</code>.</li>
  <li><strong>Swift macOS Project:</strong> A macOS application written in Swift that statically links the Go library and calls the exported Go function through the bridging header.</li>
</ul>

<h2>Workflow</h2>
<ul>
  <li><strong>Go Source (fibonacci.go):</strong> Written in Go, exported using <code>//export</code> and compiled via <code>c-archive</code> to produce a static library and header.</li>
  <li><strong>Static Library Build:</strong> The Go code is compiled into <code>libfibonacci.a</code> and <code>libfibonacci.h</code>, which are added to the macOS project.</li>
  <li><strong>Bridging Header:</strong> The generated header is included in the Xcode bridging header so Swift can recognize the exported C symbols.</li>
  <li><strong>Swift macOS App:</strong> Calls the Go function directly through the imported symbol exposed by the bridging header.</li>
</ul>

<h2>How It Works</h2>
<p>
Go’s cgo toolchain can export Go functions using the C ABI. When compiled using the
<code>c-archive</code> build mode, Go produces a static library (.a) plus a C header file.
The Swift macOS project imports the header through a bridging header, allowing the app to
invoke Go functions as if they were plain C functions. This enables the Swift app to
use computational logic written in Go while maintaining a native macOS UI.
</p>

<h2>Getting Started</h2>

<h3>1. Compile the Go Static Library</h3>
<p>Run the following command inside the Go source directory:</p>
<pre><code>go build -buildmode=c-archive -o libfibonacci.a .</code></pre>

<h3>2. Integrate with Swift (macOS)</h3>
<p>
Add <code>libfibonacci.a</code> and <code>libfibonacci.h</code> to the Xcode project.
Include <code>libfibonacci.h</code> in the bridging header so that Swift can see the exported symbols.
The Swift code can then call the Go function directly through the C interface.
</p>

<h2>Platform Support</h2>
<ul>
  <li><strong>macOS:</strong> Fully supported using static linking.</li>
  <li><strong>iOS:</strong> Not supported with <code>c-archive</code>; requires <code>gomobile bind</code>.</li>
</ul>

<h2>Screenshot</h2>
<img src="" width="500" height="250">
