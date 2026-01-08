require_relative 'helpers'
text = %Q{BEGIN TRANSMISSION
You ask many questions and threaten to descry that which must not be touched. They should never have seen what they saw or learned what they learned. 
ask yourself. are you prepared to get the answers you seek?
perhaps it would be best if he stayed the last. but perhaps it cant be helped. after all, Some actors never know they're in the script.
The above text is not canon, and is to test a fun method I thought of at work.
NULL
END TRANSMISSION
}
text = CodeHelpers.string_sanitize(text)
container = {}
ciphertext = []
split_text = text.upcase.split("\n")

split_text.each do |str|
    ("A".."Z").to_a.each { |chr| container[chr] = [] }
    str.chars.each_with_index do |chr, idx|
        container[chr].push(idx+1)
    end
    batch_txt = []
    container.each do |k,v| 
        batch_txt.push("[#{v.join(".")}]")
    end
    ciphertext << batch_txt.join("").gsub("[]","[0]")
end

File.open('./boredatwork.txt','w') { |f| f.write('')} #clearing file for quick reuse
File.open('./boredatwork.txt','w') { |f| f.write(ciphertext.join("\n"))}