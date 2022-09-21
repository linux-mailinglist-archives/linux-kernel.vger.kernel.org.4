Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002185BF8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiIUISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiIUISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:18:40 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BE5269;
        Wed, 21 Sep 2022 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663748319;
  x=1695284319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w8KzUewuszzBRNR3DKM4RdYTDxQmFGm6YO23DI5b+0I=;
  b=VhvAd0iQ0k9meYOd0nOV2nS4IsRzKvqGJEDfN+FrtAJy+hsU7wS1l4FH
   vV2aONp+hkhhF9VEJMcRupyD4RfL47VepVNY+O3rPS61wpQaIzlXoh2hF
   7eVGy2ojneOt0AR/SQmz52yiC5Oq2gAoXd0dloQSLKYQE705b/44H9YTa
   QinJ3NN2/2LJOq4T4GvIJkXrzW5zo4bVFQcPugnwvo4F72xizOh0SoJbU
   LvOHsgNvKyD/+5GrvHs13vnoVeBq38rh4iGPVYsZo7/HzYHats3kklDhK
   nd03bbwdG72oTpI2FnjdFaB9AvcCTXlCYYjUHPlMVEmPrvHQ4p0jw5v+V
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: sound: ti,ts3a227e: convert to yaml
Date:   Wed, 21 Sep 2022 10:18:32 +0200
Message-ID: <20220921081834.22009-2-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220921081834.22009-1-astrid.rost@axis.com>
References: <20220921081834.22009-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert from ts3a227e.txt to yaml.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 .../bindings/sound/ti,ts3a227e.yaml           | 65 +++++++++++++++++++
 .../devicetree/bindings/sound/ts3a227e.txt    | 30 ---------
 2 files changed, 65 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ts3a227e.txt

diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
new file mode 100644
index 000000000000..327d204cf957
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,ts3a227e.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TS3A227E
+  Autonomous Audio Accessory Detection and Configuration Switch
+
+maintainers:
+  - Dylan Reid <dgreid@chromium.org>
+
+description: |
+  The TS3A227E detect headsets of 3-ring and 4-ring standards and
+  switches automatically to route the microphone correctly. It also
+  handles key press detection in accordance with the Android audio
+  headset specification v1.0.
+
+properties:
+  compatible:
+    enum:
+      - ti,ts3a227e
+
+  reg:
+    const: 0x3b
+
+  interrupts:
+    maxItems: 1
+
+  ti,micbias:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Intended MICBIAS voltage (datasheet section 9.6.7).
+    enum:
+      - 0 # 2.1 V
+      - 1 # 2.2 V
+      - 2 # 2.3 V
+      - 3 # 2.4 V
+      - 4 # 2.5 V
+      - 5 # 2.6 V
+      - 6 # 2.7 V
+      - 7 # 2.8 V
+    default: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec: audio-controller@3b {
+            compatible = "ti,ts3a227e";
+            reg = <0x3b>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/ts3a227e.txt b/Documentation/devicetree/bindings/sound/ts3a227e.txt
deleted file mode 100644
index 21ab45bc7e8f..000000000000
--- a/Documentation/devicetree/bindings/sound/ts3a227e.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Texas Instruments TS3A227E
-Autonomous Audio Accessory Detection and Configuration Switch
-
-The TS3A227E detect headsets of 3-ring and 4-ring standards and
-switches automatically to route the microphone correctly.  It also
-handles key press detection in accordance with the Android audio
-headset specification v1.0.
-
-Required properties:
-
- - compatible:		Should contain "ti,ts3a227e".
- - reg:			The i2c address. Should contain <0x3b>.
- - interrupts:		Interrupt number for /INT pin from the 227e
-
-Optional properies:
- - ti,micbias:   Intended MICBIAS voltage (datasheet section 9.6.7).
-      Select 0/1/2/3/4/5/6/7 to specify MICBIAS voltage
-      2.1V/2.2V/2.3V/2.4V/2.5V/2.6V/2.7V/2.8V
-      Default value is "1" (2.2V).
-
-Examples:
-
-	i2c {
-		ts3a227e@3b {
-			compatible = "ti,ts3a227e";
-			reg = <0x3b>;
-			interrupt-parent = <&gpio>;
-			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		};
-	};
-- 
2.20.1

