# GCI-Ruby

> Disclaimer: a lot in flux

To help cloud developers to deal with the impact of non-deterministic garbage collection interventions, we
implemented an easy-to-use mechanism called **Garbage Collection Control Interceptor (GCI)**. Instead of attempting to
minimize the negative impact of garbage collector interventions, GCI controls the garbage collector and sheds the
incoming load during collections, which avoids CPU competition and stop-the-world pauses while processing requests.

GCI has two main parts: i) the [GCI-Proxy](https://github.com/gcinterceptor/gci-proxy) -- a multiplatform,
runtime-agnostic HTTP intermediary responsible for controlling the garbage collector and shedding the
load when necessary -- and the ii) the Request Processor(RP), a thin layer which runs within the service and is
usually implemented as a framework middleware. The latter is responsible for checking the heap allocation and performing
a garbage collection.

This repository implements a GCI Request Processor for [Rack](https://rack.github.io/) services. This middleware can be used
in rails application (example [here](https://github.com/gcinterceptor/msgpush-ruby)).
