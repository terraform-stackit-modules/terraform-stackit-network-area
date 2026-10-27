package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestExamplesBasic(t *testing.T) {

	// Network areas are organization-scoped: this module needs STACKIT_ORGANIZATION_ID,
	// not (only) STACKIT_PROJECT_ID like the other modules.
	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/basic",
		Vars: map[string]interface{}{
			"organization_id": os.Getenv("STACKIT_ORGANIZATION_ID"),
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
