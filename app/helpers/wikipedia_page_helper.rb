module WikipediaPageHelper
    def getOnThisDayInterestings
        Wikipedia.find(DateTime.now.strftime("%B %e"))
    end

    def convertPageText(page_text)
        puts "page_text String #{page_text.class}"
        converted_text = page_text.split("\n")
        puts "converted_text Array #{converted_text.class}"
        converted_text.delete("")
        puts "converted_text Array #{converted_text.class}"
        converted_text.delete_at(0)
        converted_text
    end

    def organize_page_content(interestings_data, interestings_key)
        result = {}
        cat_key = nil
        interestings_data.each do |i|
            if i.start_with? "=="
                cat_key = i
                result[i] = []
                next
            end

            if cat_key == nil
                next
            end

            result[cat_key].push(i)
        end
        interestings_content = result["== #{interestings_key} =="].sample(7).sort_by { |x| x[/\d+/].to_i }
        interestings_content
    end
end

