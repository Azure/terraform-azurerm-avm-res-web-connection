# terraform-azurerm-avm-res-web-connection

This is the API Connection resource module for the Azure Verified Modules library. It leverages the AzureRM provider and sets a number of initial defaults to minimize the overall inputs for simple configurations.

> [!IMPORTANT]
> This module follows the semantic versioning and versions prior to `1.0.0` should be considered pre-release versions. Please review the release notes prior to updating previous deployments to use this version.
>
> All module **MUST** be published as a pre-release version (e.g., `0.1.0`, `0.1.1`, `0.2.0`, etc.) until the AVM framework becomes GA.
>
> However, it is important to note that this **DOES NOT** mean that the modules cannot be consumed and utilized. They **CAN** be leveraged in all types of environments (dev, test, prod etc.). Consumers can treat them just like any other IaC module and raise issues or feature requests against them as they learn from the usage of the module. Consumers should also read the release notes for each version, if considering updating to a more recent version of a module to see if there are any considerations or breaking changes etc.
