RSpec.describe 'gds-vale' do
  before(:all) do
    `docker build -t gds-vale .`
  end

  describe 'unexpanded_acronyms_bad.md' do
    it 'should not complain when there are established acronyms'
    it 'should complain about unexpanded acronyms' do
      input_file = self.class.description

      expected_output = <<~OUT
        #{input_file}:1:3:General.UnexpandedAcronym:'TLAs' has no definition
        #{input_file}:3:4:General.UnexpandedAcronym:'MTV' has no definition
        #{input_file}:5:1:General.UnexpandedAcronym:'FND' has no definition
        #{input_file}:7:18:General.UnexpandedAcronym:'WER' has no definition
        #{input_file}:9:24:General.UnexpandedAcronym:'QWER' has no definition
        #{input_file}:11:19:General.UnexpandedAcronym:'SDF' has no definition
        #{input_file}:13:21:General.UnexpandedAcronym:'ASDF' has no definition
        #{input_file}:15:41:General.UnexpandedAcronym:'2LA' has no definition
        #{input_file}:17:24:General.UnexpandedAcronym:'SP' has no definition
      OUT

      actual_output = run_vale(input_file)

      expect(actual_output).to eq(expected_output)
    end
  end

  describe 'Contractions.md' do
    it 'should tell you to use positive contractions but not negative contractions'  do
      input_file = self.class.description

      expected_output = <<~OUT
        #{input_file}:1:1:General.Contractions:Use 'we'll' instead of 'We will.'
        #{input_file}:3:17:General.Contractions:Use 'we'll' instead of 'we will.'
        #{input_file}:6:20:General.Contractions:Use 'it's' instead of 'it is.'
        #{input_file}:9:1:General.Contractions:Use 'do not' instead of 'Don't.'
        #{input_file}:11:17:General.Contractions:Use 'do not' instead of 'don't.'
        #{input_file}:14:20:General.Contractions:Use 'do not' instead of 'don't.'
      OUT

      actual_output = run_vale(input_file)

      expect(actual_output).to eq(expected_output)
    end
  end

  describe 'List.md' do
    it 'should complain about list items not in sentence case' do
      input_file = self.class.description

      expected_output = <<~OUT
        ======> I like pie.
      OUT

      actual_output = run_vale(input_file)

      expect(actual_output).to eq(expected_output)
    end
  end

  def run_vale(input_file)
    Dir.chdir("test") do
      `docker run --rm -v "$PWD":/repo gds-vale --output line #{input_file} 2>&1`
    end
  end
end
