@jmeter
Feature: API performce testing with jmeter

  Scenario: performce: /bond-web/api/bond/analysis/pdRank/indus
    When jmeter get '/bond-web/api/bond/analysis/pdRank/indus'
