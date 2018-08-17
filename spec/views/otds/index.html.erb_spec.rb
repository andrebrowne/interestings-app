require "rails_helper"

RSpec.describe "otds/index" do
    it "displays empty page when no data returned" do
        assign(:interestings, nil)
        render
        expect(rendered).to be_empty
        expect(rendered).to match /^$/
    end

    it "display correct page title" do
        assign(:interestings, Wikipedia.find("August 16"))
        render
        expect(rendered).not_to be_empty
        expect(rendered).to match /\<h1\>August 16\<\/h1\>/
    end

    it "display correct page summary" do
        assign(:interestings, Wikipedia.find("August 30"))
        render
        expect(rendered).not_to be_empty
        expect(rendered).to include("August 30 is the 242nd day of the year")
        expect(rendered).not_to match /August 30 is the 242nd day of the year.*August 30 is the 242nd day of the year/m
    end

    it "displays interestings for events, births, holidays and observances" do
        assign(:interestings, Wikipedia.find("August 14"))
        render
        expect(rendered).not_to be_empty
        expect(rendered).to match /\=\= Events \=\=/
        expect(rendered).to match /\=\= Births \=\=/
        expect(rendered).to match /\=\= Holidays and observances \=\=/
    end

    it "displays each event on new line" do
        # assign interestings a value
        wiki_page = Wikipedia.find("August 18")
        assign(:interestings, wiki_page)
        # display html in the view (render)
        render
        # figure out number of interestings in the array
        num_interestings = convertPageText(wiki_page.text).length
        puts num_interestings
        puts rendered.scan(/^.+\<br\/\>$/).count
        # Assert that when you compare number of events to number of line breaks that they are equal
        expect(rendered.scan(/^.+\<br\/\>$/).count).to eq(num_interestings)
        # Assert that each event is followed by a line break
        puts rendered
        expect(rendered).to match /^\<h.*\>$|^.*\<br\/\>$/
    end
end

# ["str1", "str2", "str3"]
# <p>str1</P>
# <br/>
# <p>str2</P>
# <br/>
# <p>str3</P>
# <br/>
