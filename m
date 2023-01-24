Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16BB67902E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjAXFpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjAXFp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:45:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC81D3B3F1;
        Mon, 23 Jan 2023 21:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674539096; x=1706075096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mRV+dnA3SRMEAqJffKv61NWDnzHInh5cxWCpGNICJYg=;
  b=I5Wwf46i/dUHaiMxvKjnSlfKKGdvjlscdRLW1abpc7XDvEaLoejGMmGg
   ZDJyucxMtSq8ssuAfrcu5tvggpqzSKaF+s/CtmvmN8zIjD4VmBxnaBZDo
   W3RCBJyYdRK6bZatVtbYEhIVSVVuL5qarpx9ug+DTI0rztvRJuhaL+Xfd
   tIZO+UaTo7zv1Qvqzw5K1Uu0mRmF/EiFb28gc0s9SswaKRXUjAb12lS8W
   G1Zc47V0dhAPgzy2ARepBSf22rLPbKmktlNqB0QKe47Cn8Ob5BeMn+8hy
   bu74TvcFnFb9ch2Bht+boEYL3OJ6vTu59KR31FBsCoBgCBvxa+fW5uR3F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="305895486"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="305895486"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 21:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="655307165"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="655307165"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2023 21:44:35 -0800
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
Subject: [PATCH v1 2/4] Revert "dt-bindings: mmc: Add bindings for Intel Thunder Bay SoC"
Date:   Tue, 24 Jan 2023 11:14:25 +0530
Message-Id: <20230124054427.28808-2-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230124054427.28808-1-rashmi.a@intel.com>
References: <20230124054427.28808-1-rashmi.a@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "A, Rashmi" <rashmi.a@intel.com>

This reverts commit ab991c05c42853f0b6110022db9bf30fcc6323dd.

Revert Thunder Bay specific code as the product got cancelled
and there are no end customers.

Signed-off-by: A, Rashmi <rashmi.a@intel.com>
Reviewed-by: Hunter, Adrian <adrian.hunter@intel.com>wq
---
 .../devicetree/bindings/mmc/arasan,sdhci.yaml | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 4053de758db6..0d5d21dd30bb 100644
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

