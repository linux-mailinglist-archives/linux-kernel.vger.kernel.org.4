Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517C26BCEF0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCPMGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCPMGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:06:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8493165A6;
        Thu, 16 Mar 2023 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678968363; x=1710504363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=oX16MPASgVn0QBxsOY4PclCdLg+myX80w1viNZawLes=;
  b=m2okKEhYmoazmBPZR3lfbLro4iO6jFBSPR2r35c5li8W0yJME+Zu4QcL
   ep5MfntWyxCEGe9nCIytqHUo6C69jKZ2Vit0TxB5i2ceJ1fMxMNDjXWko
   IPu515ejTEj5bV1fgpg1b36sPCLNYZEOiHzBEcxklwG6Au+rq1wPy0Wpx
   untbc2UBzkSXfY7HVqA246I2g7BCIjlgwix/A/8/bWg7K8d7t3e7SGVuW
   iS6hjnjCjThuZjyevM+AqXt+C2RjD7RfqLABmHNqME63lJLq52+590LqD
   GVSK3RdDIStCErlYWwujMzNAtlwjIGKPxTljTE+DCd0cvkqcW5N9W10Uw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="365656998"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="365656998"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 05:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="768911596"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="768911596"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2023 05:05:55 -0700
From:   rashmi.a@intel.com
To:     ulf.hansson@linaro.org, michal.simek@xilinx.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, kishon@kernel.org,
        yuancan@huawei.com, andriy.shevchenko@linux.intel.com,
        linux-phy@lists.infradead.org, mgross@linux.intel.com
Cc:     kris.pan@linux.intel.com, adrian.hunter@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        vasavi.v.itha@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v2 1/4] mmc: sdhci-of-arasan: Remove Intel Thunder Bay SOC support
Date:   Thu, 16 Mar 2023 17:35:46 +0530
Message-Id: <20230316120549.21486-2-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230316120549.21486-1-rashmi.a@intel.com>
References: <20230316120549.21486-1-rashmi.a@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "A, Rashmi" <rashmi.a@intel.com>

Remove Thunder Bay specific code as the product got cancelled
and there are no end customers or users.

Signed-off-by: A, Rashmi <rashmi.a@intel.com>
Reviewed-by: Hunter, Adrian <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 89c431a34c43..fbafc87266aa 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -193,13 +193,6 @@ static const struct sdhci_arasan_soc_ctl_map intel_lgm_sdxc_soc_ctl_map = {
 	.hiword_update = false,
 };
 
-static const struct sdhci_arasan_soc_ctl_map thunderbay_soc_ctl_map = {
-	.baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
-	.clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
-	.support64b = { .reg = 0x4, .width = 1, .shift = 24 },
-	.hiword_update = false,
-};
-
 static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
 	.baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
 	.clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
@@ -465,15 +458,6 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
-static const struct sdhci_pltfm_data sdhci_arasan_thunderbay_pdata = {
-	.ops = &sdhci_arasan_cqe_ops,
-	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
-		SDHCI_QUIRK2_STOP_WITH_TC |
-		SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
-};
-
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -1150,12 +1134,6 @@ static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
 	.clk_ops = &arasan_clk_ops,
 };
 
-static const struct sdhci_arasan_of_data sdhci_arasan_thunderbay_data = {
-	.soc_ctl_map = &thunderbay_soc_ctl_map,
-	.pdata = &sdhci_arasan_thunderbay_pdata,
-	.clk_ops = &arasan_clk_ops,
-};
-
 static const struct sdhci_pltfm_data sdhci_keembay_emmc_pdata = {
 	.ops = &sdhci_arasan_cqe_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
@@ -1289,10 +1267,6 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "intel,keembay-sdhci-5.1-sdio",
 		.data = &intel_keembay_sdio_data,
 	},
-	{
-		.compatible = "intel,thunderbay-sdhci-5.1",
-		.data = &sdhci_arasan_thunderbay_data,
-	},
 	/* Generic compatible below here */
 	{
 		.compatible = "arasan,sdhci-8.9a",
@@ -1716,8 +1690,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
 	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
-	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio") ||
-	    of_device_is_compatible(np, "intel,thunderbay-sdhci-5.1")) {
+	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
 		sdhci_arasan_update_clockmultiplier(host, 0x0);
 		sdhci_arasan_update_support64b(host, 0x0);
 
-- 
2.17.1

