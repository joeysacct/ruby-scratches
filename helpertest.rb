require_relative 'helpers'
puts CodeHelpers.numtoletter([1,2,3,4,5]).inspect
puts CodeHelpers.a1z26("poopfart").inspect
puts CodeHelpers.string_sanitize("test? this should work fine. ''quotes here. ()[]")