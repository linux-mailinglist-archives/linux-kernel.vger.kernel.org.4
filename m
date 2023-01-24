Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D961679039
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjAXFp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjAXFpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:45:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075C1367CD;
        Mon, 23 Jan 2023 21:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674539120; x=1706075120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LKVw2yOOeRpF1A8gySOnDNhea0uoF/YrAVMAwjlZ9Dw=;
  b=YOSVq4k2FspkTQL6fGOFPIKeFKq2UeiaOkjsg0g41Jzc7A/LvqSgOw8V
   RbafKtmqoB1OWUHMqQiDNfJu40s7Jwg1cfYvoXhRgHmR7NrnLoZMbsq6i
   1LJLofVdLqlK5oqacOtPSxxfjbgohpWGfchGCL6v+WRZesGY1EjHjM7WE
   AGIcNF8ZiZRMkRzuKOUM+47zEkGnkUiKo5YVnttAIdWiDe42K/bk7iUi8
   G/jebS/gB/UZqUv9eXbsEkpWu3SjxuIKRSVcMGoykmu6We7yOSKCPxvl/
   8eZiPVILD8K72UFLpPe/qC0gXfXKB6u6yexqafqIOfzYTtCHzBKfVsDWK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="305895530"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="305895530"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 21:44:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="655307231"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="655307231"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2023 21:44:48 -0800
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
Subject: [PATCH v1 4/4] Revert "dt-bindings: phy: intel: Add Thunder Bay eMMC PHY bindings"
Date:   Tue, 24 Jan 2023 11:14:27 +0530
Message-Id: <20230124054427.28808-4-rashmi.a@intel.com>
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

This reverts commit efb6935dd786a9d213ee542ed77d47ece700357c.

Revert Thunder Bay specific code as the product got cancelled
and there are no end customers.

Signed-off-by: A, Rashmi <rashmi.a@intel.com>
Reviewed-by: Hunter, Adrian <adrian.hunter@intel.com>
---
 .../phy/intel,phy-thunderbay-emmc.yaml        | 45 -------------------
 MAINTAINERS                                   |  7 ---
 2 files changed, 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml b/Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
deleted file mode 100644
index 361ffc35b16b..000000000000
--- a/Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
+++ /dev/null
@@ -1,45 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/phy/intel,phy-thunderbay-emmc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Intel Thunder Bay eMMC PHY
-
-maintainers:
-  - Srikandan Nandhini <nandhini.srikandan@intel.com>
-
-properties:
-  compatible:
-    const: intel,thunderbay-emmc-phy
-
-  "#phy-cells":
-    const: 0
-
-  reg:
-    maxItems: 1
-
-  clocks:
-    maxItems: 1
-
-  clock-names:
-    items:
-      - const: emmcclk
-
-required:
-  - "#phy-cells"
-  - compatible
-  - reg
-  - clocks
-
-additionalProperties: false
-
-examples:
-  - |
-    mmc_phy@80440800 {
-        #phy-cells = <0x0>;
-        compatible = "intel,thunderbay-emmc-phy";
-        reg = <0x80440800 0x100>;
-        clocks = <&emmc>;
-        clock-names = "emmcclk";
-    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 123216b76534..e9ca0b6364b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10550,13 +10550,6 @@ F:	drivers/crypto/keembay/keembay-ocs-hcu-core.c
 F:	drivers/crypto/keembay/ocs-hcu.c
 F:	drivers/crypto/keembay/ocs-hcu.h
 
-INTEL THUNDER BAY EMMC PHY DRIVER
-M:	Nandhini Srikandan <nandhini.srikandan@intel.com>
-M:	Rashmi A <rashmi.a@intel.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
-F:	drivers/phy/intel/phy-intel-thunderbay-emmc.c
-
 INTEL MANAGEMENT ENGINE (mei)
 M:	Tomas Winkler <tomas.winkler@intel.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.17.1

