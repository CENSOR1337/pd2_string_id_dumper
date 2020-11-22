import json

rawJson = open('../saves/string_id_dumper_output/raw/data_string_ID.json',
               'r', encoding="utf8").read()
parsed = json.loads(rawJson)
resultJson = json.dumps(parsed, indent=4, sort_keys=True)

ourputFileJson = open(
    '../saves/string_id_dumper_output/string_id_result.json', "w+", encoding="utf8")
ourputFileJson.write(resultJson)
ourputFileJson.close()


with open('../saves/string_id_dumper_output/hashlist', "w") as hashlist_file:
    hashlist_file.truncate(0)

for key in parsed:
    with open('../saves/string_id_dumper_output/hashlist', "a", encoding="utf8") as hashlist_out:
        hashlist_out.write(key + "\n")
