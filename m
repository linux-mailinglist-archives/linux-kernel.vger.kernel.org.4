Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0457E6D4403
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjDCMCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjDCMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:02:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AACFB45E;
        Mon,  3 Apr 2023 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680523364; x=1712059364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=o982tW+jHj7V4/Bt5CyFb5tsFY5IHREbXzW8U1BjIE8=;
  b=TYgxgoltqEIbH+LzKm1LHV1lo9tSau4nbYvI049W2MmbUsw4Tuz9Ib3E
   3+IDxmokxWKN5TRBnl3goj7Cqpsmc57Rb2BIILx+juwbkhlkW/3XeyqA9
   Ra4VBFZlrwE7imEMm+0Iwb5ZSDRYVWlK1PBxEFlUSNcDN5HeusIGH95/b
   Gu2xlgi9KJyROgVoLAuVA4ycwgFSWJglFdzBnyXWBrCXuW+owTcghYmd7
   XqRoPvrrXkE9VdQWC3oJ0lpz+SLy5RfssSMJaLtdth4MPYmV1UZoyx+O3
   cbQTjZV3cEYoMkRmSNoXsmJBm1uS8HUDVxK2/KHgx+r8vKI+5nrEg/4xc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="330449281"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="330449281"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 05:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="775158723"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="775158723"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2023 05:02:40 -0700
From:   lakshmi.sowjanya.d@intel.com
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        furong.zhou@intel.com, kris.pan@intel.com, pandith.n@intel.com,
        kenchappa.demakkanavar@intel.com, lakshmi.sowjanya.d@intel.com
Subject: [PATCH v1 2/2] dt-bindings: pinctrl: Remove bindings for Intel Thunderbay pinctrl driver
Date:   Mon,  3 Apr 2023 17:32:35 +0530
Message-Id: <20230403120235.939-2-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230403120235.939-1-lakshmi.sowjanya.d@intel.com>
References: <20230403120235.939-1-lakshmi.sowjanya.d@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Remove Thunder Bay specific code as the product got cancelled
and there are no end customers or users.

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 .../pinctrl/intel,pinctrl-thunderbay.yaml     | 120 ------------------
 MAINTAINERS                                   |   5 -
 2 files changed, 125 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml b/Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml
deleted file mode 100644
index f001add16814..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml
+++ /dev/null
@@ -1,120 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pinctrl/intel,pinctrl-thunderbay.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Intel Thunder Bay pin controller
-
-maintainers:
-  - Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
-
-description: |
-  Intel Thunder Bay SoC integrates a pin controller which enables control
-  of pin directions, input/output values and configuration
-  for a total of 67 pins.
-
-properties:
-  compatible:
-    const: intel,thunderbay-pinctrl
-
-  reg:
-    maxItems: 1
-
-  gpio-controller: true
-
-  '#gpio-cells':
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
-  interrupts:
-    description:
-      Specifies the interrupt lines to be used by the controller.
-    maxItems: 2
-
-  interrupt-controller: true
-
-  '#interrupt-cells':
-    const: 2
-
-patternProperties:
-  '^gpio@[0-9a-f]*$':
-    type: object
-    additionalProperties: false
-
-    description:
-      Child nodes can be specified to contain pin configuration information,
-      which can then be utilized by pinctrl client devices.
-      The following properties are supported.
-
-    properties:
-      pins:
-        description: |
-          The name(s) of the pins to be configured in the child node.
-          Supported pin names are "GPIO0" up to "GPIO66".
-
-      bias-disable: true
-
-      bias-pull-down: true
-
-      bias-pull-up: true
-
-      drive-strength:
-        description: Drive strength for the pad.
-        enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
-
-      bias-bus-hold:
-        type: boolean
-
-      input-schmitt-enable:
-        type: boolean
-
-      slew-rate:
-        description: GPIO slew rate control.
-                      0 - Slow
-                      1 - Fast
-        enum: [0, 1]
-
-additionalProperties: false
-
-required:
-  - compatible
-  - reg
-  - gpio-controller
-  - '#gpio-cells'
-  - gpio-ranges
-  - interrupts
-  - interrupt-controller
-  - '#interrupt-cells'
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/interrupt-controller/irq.h>
-    // Example 1
-    pinctrl0: gpio@0 {
-        compatible = "intel,thunderbay-pinctrl";
-        reg = <0x600b0000 0x88>;
-        gpio-controller;
-        #gpio-cells = <0x2>;
-        gpio-ranges = <&pinctrl0 0 0 67>;
-        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-        interrupt-controller;
-        #interrupt-cells = <2>;
-    };
-
-    // Example 2
-    pinctrl1: gpio@1 {
-        compatible = "intel,thunderbay-pinctrl";
-        reg = <0x600c0000 0x88>;
-        gpio-controller;
-        #gpio-cells = <0x2>;
-        gpio-ranges = <&pinctrl1 0 0 53>;
-        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-        interrupt-controller;
-        #interrupt-cells = <2>;
-    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..bae5e92d1ff2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16566,11 +16566,6 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/pinctrl/pinctrl-single.c
 
-PIN CONTROLLER - THUNDERBAY
-M:	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
-S:	Supported
-F:	drivers/pinctrl/pinctrl-thunderbay.c
-
 PIN CONTROLLER - SUNPLUS / TIBBO
 M:	Dvorkin Dmitry <dvorkin@tibbo.com>
 M:	Wells Lu <wellslutw@gmail.com>
-- 
2.17.1

