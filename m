Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A244D6BCEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCPMGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCPMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:06:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2FC6424;
        Thu, 16 Mar 2023 05:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678968385; x=1710504385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6rBESeZoUuzvAaQxJVei2uSeyWpzwOtmPdchwrLHNMk=;
  b=iYMAEcZOa1lxRtxHtvTFCwD1IPhdrDXCcZqnCsFVDJ1V6Y+D58HHxjx3
   baiSc8Nh3JQT4xHzUrQSBNJrgn9rBXU26vzgMs201+IS8M2VK9kSeFxUS
   HfxcT4sFSUo9wna+EgHipuGM25sQMQMxx+pRuJOBPVPoARJj8I0bSxNls
   zmB7RSIfr8ieFBXigFu+onysr+XFj9Oc6B4hbQ0Zu3A9z/tlR0ZCJ65ma
   ZL4+KYWEAxaKQgfPkb7B+apEYHZjl55chcZPs3p2a85uxzpeEsz+NUSGo
   YN+NuOwjn2JgLPi6CLE5veR0gAd1cGyDnSKVjCHXQpZnWSKxQbWnZI71f
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="365657090"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="365657090"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 05:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="768911732"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="768911732"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2023 05:06:14 -0700
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
Subject: [PATCH v2 4/4] dt-bindings: phy: intel: Remove Thunder Bay eMMC PHY bindings
Date:   Thu, 16 Mar 2023 17:35:49 +0530
Message-Id: <20230316120549.21486-5-rashmi.a@intel.com>
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
Acked-by: Rob Herring <robh@kernel.org>
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
index a3b14ec33830..17882b1e1de3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10442,13 +10442,6 @@ F:	drivers/crypto/keembay/keembay-ocs-hcu-core.c
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

