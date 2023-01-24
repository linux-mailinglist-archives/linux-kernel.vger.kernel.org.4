Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF4D679025
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjAXFpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjAXFpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:45:19 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1F83B0F6;
        Mon, 23 Jan 2023 21:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674539089; x=1706075089;
  h=from:to:cc:subject:date:message-id;
  bh=zj5C/0Dm3eXkZ7JXMjfdfRw3WwpyZ0x3VqRQ7J5XMRU=;
  b=kO7m7BiwLV/wMjl83+xM/XPOEKxATvxL02t6digqRmo5QYmQiBc2vQ8i
   Y8er5OwvJ56Rf1mSo8pxui2kg4paQFGQPkold6AtPT5OFFQKlIsH9LVje
   R6XIiRK7kOeUmk1RN6RGtDrwoPL7K6wzhLZdFVd4wycjGu6e3KOaEI6FM
   EzgT6oM91oh7OQJAmimhna8ZbBi4ftZEKR0ZX4tiDx/kg2iyfXo338YP0
   TqhNVF//FkmTlkgQi2rwo15Dk+Jw6xoBC7WifY/ssAmufRjmx2gAOvZsN
   mZt244kvBxVQcceZKhQkAmtcdp8XSigidGM7KzgQmyT8w1uLNrZxqOoaz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="305895478"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="305895478"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 21:44:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="655307147"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="655307147"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2023 21:44:28 -0800
From:   rashmi.a@intel.com
To:     ulf.hansson@linaro.org, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org,
        mgross@linux.intel.com
Cc:     kris.pan@linux.intel.com, adrian.hunter@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        vasavi.v.itha@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v1 1/4] Revert "mmc: sdhci-of-arasan: Add intel Thunder Bay SOC support to the arasan eMMC driver"
Date:   Tue, 24 Jan 2023 11:14:24 +0530
Message-Id: <20230124054427.28808-1-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "A, Rashmi" <rashmi.a@intel.com>

This reverts commit 39013f09681341e8264dff633e70d43da84d579a.

Revert Thunder Bay specific code as the product got cancelled
and there are no end customers.

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

