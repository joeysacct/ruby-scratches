require_relative 'monoalp_helpers'
require_relative 'helpers'
ciphertext = %Q{vdudhddefsgudccbelfmbaqpindfqcgedkpsvddnapsvmgfvdgaatodgsdvddnagejvmgfvdgaatodbagqpindfqcgedvmgfdudsbefmdodgefbodvdmgudkptejiptefcdaaqcgidaksddcxfsgudcbelfmbaqcgidvgaedudsapodfmbelvdfmptlmffpjpgejogxhdfmdsdvgaglppjsdgapedudsxvmdsdvdlpbaaprtbdfabcdefjdgjfmdadqcgidavdsdqsphghcxmbjjdekpsgsdgapehtfvmpigefdccvdqpqbebtaffpaddepfmbeldudsxvmdsdgejeppedvmgfiptcjbfgccodgehbampqbelvdcckbejptfbkvdnddqcppnbel}
# ciphertext = %Q{UminmqkmuuminubsucrubnpvnrucmkXbnubnqucrkmignqckubnhckeumrvttnqUbnrgckarskesqqmxrmtmvuqsanmvrtmquvknMqumusfnsqhrsasckrusrnsmtuqmvignrSkeijmoomrckankeubnhUmecnumrgnnoKmhmqnskeijsrgnnoumrsjxnnkeUbnbnsquslbnskeubnubmvrskeksuvqsgrbmlfrUbsutgnrbcrbncqumucrslmkrvhhsucmk}.downcase

# actual key is SILENTABCDFGHKMOPQRUVWXYJZ from the word TACITVS

# step 1: make initial key based off of frequiencies
key = MAHelpers.get_expected_key(ciphertext)
plaintext = MAHelpers.decrypt_monoalpha(ciphertext,key)

p_new = 1
50000.times do
  #score probability of good text
  p_old = CodeHelpers.score_bigram_deviation(plaintext)

  #swap two randopm characters in current key to build new key
  a,b = rand(26),rand(26)
  temp = key.chars
  temp[a], temp[b] = temp[b], temp[a]
  test_key = temp.join

  plaintext_new = MAHelpers.decrypt_monoalpha(ciphertext,test_key)
  p_new = CodeHelpers.score_bigram_deviation(plaintext_new)

  if p_new > p_old
    key = test_key
  else
    coinflip = rand
    if coinflip > (p_new / p_old)
      key = test_key
    end
  end
end

puts p_new

puts key
puts MAHelpers.decrypt_monoalpha(ciphertext,key)