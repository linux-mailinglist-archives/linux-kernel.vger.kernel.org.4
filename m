Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CEA6BCEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCPMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCPMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:06:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780DBB7D9A;
        Thu, 16 Mar 2023 05:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678968368; x=1710504368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=AAkIyD03JWq98B5q2PySf/dtvQYYtxwz6wy6gqs1xJw=;
  b=nBzlkq+0otQ8i85QyY5MeQdY88CntIiREIx+oDx6/vG4Qa+SUSoiVKSh
   y1GLwpRX8JpJ29pbFqQZWPAXY6l2rmcpXBSSSqlrc+Gs7CXM1DNF/HyCV
   PjMfB0N2y8fa+9SQWVRZjZu0f1voRCksHTy2B5Sn06UnJ2CzWjpXGb+24
   rqoBPG6aRA2Qlgdbrpmqxw5qghrfp2xOHLjqf8xMKoXPS+4OXE1K9SkCS
   H3yAzHdO6iSAvN0euObhtv94FKfkteXYuLLJ7EVLDrljAqwfPRd9t5/zb
   pdIOUpd6qwi8dDW97APZPk0Jg/Xhz3ANptmlOlG0cX/8aZJZ6mtMHKBB7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="365657025"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="365657025"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 05:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="768911674"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="768911674"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2023 05:06:01 -0700
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
Subject: [PATCH v2 2/4] dt-bindings: mmc: Remove bindings for Intel Thunder Bay SoC"
Date:   Thu, 16 Mar 2023 17:35:47 +0530
Message-Id: <20230316120549.21486-3-rashmi.a@intel.com>
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
 .../devicetree/bindings/mmc/arasan,sdhci.yaml | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 8296c34cfa00..e8e8b48dc5e5 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -88,12 +88,6 @@ properties:
         description:
           For this device it is strongly suggested to include
           arasan,soc-ctl-syscon.
-      - items:
-          - const: intel,thunderbay-sdhci-5.1   # Intel Thunder Bay eMMC PHY
-          - const: arasan,sdhci-5.1
-        description:
-          For this device it is strongly suggested to include
-          clock-output-names and '#clock-cells'.
 
   reg:
     maxItems: 1
@@ -309,22 +303,3 @@ examples:
                    <&scmi_clk KEEM_BAY_PSS_SD0>;
           arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
     };
-
-  - |
-    #define EMMC_XIN_CLK
-    #define EMMC_AXI_CLK
-    #define TBH_PSS_EMMC_RST_N
-    mmc@80420000 {
-          compatible = "intel,thunderbay-sdhci-5.1", "arasan,sdhci-5.1";
-          interrupts = <GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>;
-          reg = <0x80420000 0x400>;
-          clocks = <&scmi_clk EMMC_XIN_CLK>,
-                   <&scmi_clk EMMC_AXI_CLK>;
-          clock-names = "clk_xin", "clk_ahb";
-          phys = <&emmc_phy>;
-          phy-names = "phy_arasan";
-          assigned-clocks = <&scmi_clk EMMC_XIN_CLK>;
-          clock-output-names = "emmc_cardclock";
-          resets = <&rst_pss1 TBH_PSS_EMMC_RST_N>;
-          #clock-cells = <0x0>;
-    };
-- 
2.17.1

