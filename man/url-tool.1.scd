url-tool(1) "" "Go-Camo Manual"

# NAME

*url-tool* -- provides a simple way to generate signed URLs from the command line

# SYNOPSIS

*url-tool* [_OPTIONS_] [_OPTION-ARGUMENTS_]

# DESCRIPTION

url-tool provides a simple way to generate signed URLs from the command line
compatible with *go-camo*(1).

# OPTIONS

*-k*, *--key*=<_hmac-key_>
	The HMAC key to use.

*-h*, *--help*
	Show help output and exit

# COMMANDS

url-tool has two subcommands.

*encode* <_url_>

	Available encode options:

	*-b*, *--base*=<_base_>
		The base encoding to use. Can be one of hex or base64.

	*--prefix*=<_prefix_>
		Optional url prefix used by encode output.

*decode* <_url_>

# EXAMPLES

*Note*: Long urls below are truncated to improve manpage viewability.

Encode a url as hex:

```
$ ./url-tool -k "test" encode -p \\
  "https://img.example.org" \\
  "http://golang.org/doc/gopher/frontpage.png"
# https://img.example.org/..../....2e706e67
```

Encode a url as base64:

```
$ ./url-tool -k "test" encode -b base64 -p \\
  "https://img.example.org" \\
  "http://golang.org/doc/gopher/frontpage.png"
# https://img.example.org/..../....Z2UucG5n
```

Decode a hex url:

```
$ ./url-tool -k "test" decode \\
  "https://img.example.org/..../....2e706e67"
# http://golang.org/doc/gopher/frontpage.png
```

Decode a base64 url:

```
$ ./url-tool -k "test" decode \\
  "https://img.example.org/..../....Z2UucG5n"
# http://golang.org/doc/gopher/frontpage.png
```

# WWW

*https://github.com/cactus/go-camo*
