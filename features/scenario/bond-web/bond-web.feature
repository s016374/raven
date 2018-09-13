@trunk
Feature: bond-web API testing
  Background: mock api
    Given launch recall after mocking
    Given allow real request while mocking

  Scenario: function: /bond-web/api/bond/analysis/pdRank/indus
    Given mocking '/bond-web/api/bond/analysis/pdRank/indus'
    When get '/bond-web/api/bond/analysis/pdRank/indus'
    Then check '/bond-web/api/bond/analysis/pdRank/indus'
