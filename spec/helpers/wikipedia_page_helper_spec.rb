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
            expect(helper.getOnThisDayInterestings().title).to eq(DateTime.now.strftime("%B %e"))
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

        xit "returns nothing if page is empty" do
        end
    end

    describe "#organize_page_content" do
        it "should return section titles and section value(s)" do
            # expect organize_page_content() to return a collection of section titles that match to section values
            # setup the the test assertion
            input = [
                "== Section1 ==",
                "Section1 - item 1",
                "Section1 - item 2",
                "Section1 - item 3",
                "== Section2 ==",
                "Section2 - item 1",
                "Section2 - item 2",
                "Section2 - item 3",
                "== Section3 ==",
                "Section3 - item 1",
                "Section3 - item 2",
                "Section3 - item 3"
            ]
            output = {
                "== Section1 ==" => [ 
                    "Section1 - item 1",
                    "Section1 - item 2",
                    "Section1 - item 3"],
                "== Section2 =="  => [
                    "Section2 - item 1",
                    "Section2 - item 2",
                    "Section2 - item 3"
                ],
                "== Section3 ==" => [
                    "Section3 - item 1",
                    "Section3 - item 2",
                    "Section3 - item 3"
                ]
            }
            # invoke the unit to be tested
            # validate assertions
            expect(helper.organize_page_content(input)).to be_an_instance_of(Hash)
            expect(helper.organize_page_content(input)).to eq(output)
        end
    end

end
