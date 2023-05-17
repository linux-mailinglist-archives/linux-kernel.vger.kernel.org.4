Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156167069F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjEQNdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjEQNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:33:23 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B513A;
        Wed, 17 May 2023 06:33:22 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A72B65FD42;
        Wed, 17 May 2023 16:33:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684330400;
        bh=ywVAWUW9jbvz+vfZY+snT7ksvWRteTwJF8+dCOusnpE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=b6v6AwBVkVNi64/YeYKUac+FF20aZtFI2HiB/cTaDT8NOLJ/ESyouM3CaqnxViWmq
         MN/6+oH+Iji2LX5Bz/ZCmid3FILW1qjRUAyMy+M4SEiOXO6xQ5isSqEnpuNe47HjIb
         /3m0Xk2MAwNhfVcCfbxd/QHp+2iVfsX2dNAaf2d17lzOs057uJ63/puybGBXo4P1CM
         YRhIM81sweKkOEMEP6DegVJIfJ0iBk3uJHITBSesT0hfYKSaY6yiz/o9T2QtFL7qCz
         VbRm7cpsy/Ke9a0kVV975BjQIX+1WStPBMn0Ca87cJg+N8NFQBdx3s2hF35BuTiIpp
         LP6rHqUID3tuw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 17 May 2023 16:33:20 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v15 3/6] dt-bindings: clock: meson: add A1 PLL clock controller bindings
Date:   Wed, 17 May 2023 16:33:06 +0300
Message-ID: <20230517133309.9874-4-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230517133309.9874-1-ddrokosov@sberdevices.ru>
References: <20230517133309.9874-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/17 11:04:00 #21328336
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation and dt bindings for Amlogic A1 PLL clock
controller.
Also include new A1 clock controller dt bindings to MAINTAINERS.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 58 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   | 20 +++++++
 3 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
new file mode 100644
index 000000000000..5c6fa620a63c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A1 PLL Clock Control Unit
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Jerome Brunet <jbrunet@baylibre.com>
+  - Jian Hu <jian.hu@jian.hu.com>
+  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
+
+properties:
+  compatible:
+    const: amlogic,a1-pll-clkc
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: input fixpll_in
+      - description: input hifipll_in
+
+  clock-names:
+    items:
+      - const: fixpll_in
+      - const: hifipll_in
+
+required:
+  - compatible
+  - '#clock-cells'
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@7c80 {
+            compatible = "amlogic,a1-pll-clkc";
+            reg = <0 0x7c80 0 0x18c>;
+            #clock-cells = <1>;
+            clocks = <&clkc_periphs_fixpll_in>,
+                     <&clkc_periphs_hifipll_in>;
+            clock-names = "fixpll_in", "hifipll_in";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 39ff1a717625..8438bc9bd636 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1895,6 +1895,7 @@ L:	linux-amlogic@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/amlogic*
 F:	drivers/clk/meson/
+F:	include/dt-bindings/clock/a1*
 F:	include/dt-bindings/clock/gxbb*
 F:	include/dt-bindings/clock/meson*
 
diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
new file mode 100644
index 000000000000..01fb8164ac29
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Jian Hu <jian.hu@amlogic.com>
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#ifndef __A1_PLL_CLKC_H
+#define __A1_PLL_CLKC_H
+
+#define CLKID_FIXED_PLL		1
+#define CLKID_FCLK_DIV2		6
+#define CLKID_FCLK_DIV3		7
+#define CLKID_FCLK_DIV5		8
+#define CLKID_FCLK_DIV7		9
+#define CLKID_HIFI_PLL		10
+
+#endif /* __A1_PLL_CLKC_H */
-- 
2.36.0

