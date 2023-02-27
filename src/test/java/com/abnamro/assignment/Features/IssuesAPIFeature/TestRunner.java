package com.abnamro.assignment.Features.IssuesAPIFeature;

import com.abnamro.assignment.Helper.TokenHandler;
import com.intuit.karate.junit5.Karate;


class TestRunner {
	
	@Karate.Test
	Karate allTests() {
		return Karate.run().relativeTo(getClass()).systemProperty("token", TokenHandler.GetOAuthTokenBasedOnCredentials());
	}
}