require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TestHelperHelper. For example:
#
# describe TestHelperHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

RSpec.describe WikipediaPageHelper, type: :helper do
    describe "#getOnThisDayInterestings" do
        it "returns expected data structure" do
            expect(helper.getOnThisDayInterestings()).to be_an_instance_of(Wikipedia::Page)
        end

        it "returns the data for the current day" do
            expect(helper.getOnThisDayInterestings().title).to eq(DateTime.now.strftime("%B %-d"))
        end

        pending "write test that checks for successful API call"

        pending "write test that checks for failed API call"
    end


    describe "#convertPageText" do
        it "returns the converted page text" do
            text = Wikipedia.find("April 9").text
            res = helper.convertPageText(text)
            #expect(res).to eq(text.split("\n"))
            res.should_not include("", "\n")
        end

        it "should not contain the page summary" do
            wiki_page = Wikipedia.find("December 23")
            res = helper.convertPageText(wiki_page.text)
            res.should_not include wiki_page.summary
        end

        pending "returns nothing if page is empty" 
    end

    describe "#organize_page_content" do
        it "should return section titles and section value(s) in ascending order" do
        
            input = [
                "== Events ==",
                "3 Section1 - item 3",
                "1 Section1 - item 1",
                "2 Section1 - item 2",
                "== Births ==",
                "Section2 - item 1",
                "Section2 - item 2",
                "Section2 - item 3",
                "== Holidays ==",
                "Section3 - item 1",
                "Section3 - item 2",
                "Section3 - item 3"
            ]
            output = 
                [ 
                    "1 Section1 - item 1",
                    "2 Section1 - item 2",
                    "3 Section1 - item 3"]
         
            expect(helper.organize_page_content(input,"Events")).to be_an_instance_of(Array)
            expect(helper.organize_page_content(input,"Events")).to eq(output)
        end
    end

end
