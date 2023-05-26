Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78015711AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbjEZAEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEZAEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:04:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40199C;
        Thu, 25 May 2023 17:04:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PNsGSO016759;
        Thu, 25 May 2023 19:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=jTAjC6w0E17uXA85LdmOi45eFKPWHp+38y4g2iSpRbI=;
 b=AU6Y79geaGg5Yvu+0Jq8EYuHNyypmkff5CSfpRdViBtqIMmrfZTwyybbZnqg6BjtZBpC
 B/o3BgO8yqExeq/l36iNVOjHbjXSabXpcWY5trJ7iNMyhHA50VooPgiPyyL+hbnFWjqj
 VfZMeN1/9oiQCqZ4N7fSZ+iS0YYrtj8O1kNdsfiC/VTt8B9m5/6ZNgluai4zFwl0/6Mp
 FKwl8RM8EzNI0xYZaBMeYD4np2d053FYd3QGDsBTSYX8Hr+v7MYESfIwFonWBFLyoCuT
 L+Hf5PdjYJiCA+qn6UVV6F+bXE1gcy5ijSv8oHbHMaQpiM5RnhS/lwfCQZ7Dkos7n9u/ 2g== 
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm7qhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 19:04:36 -0500
Received: from ausex02.ad.cirrus.com (141.131.37.96) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 19:04:35 -0500
Received: from ftrev.crystal.cirrus.com (141.131.38.212) by
 anon-ausex02.ad.cirrus.com (141.131.37.96) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 19:04:35 -0500
From:   Fred Treven <fred.treven@cirrus.com>
To:     Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lee@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: input: cirrus,cs40l26: Support for CS40L26
Date:   Thu, 25 May 2023 19:04:27 -0500
Message-ID: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SfDZn0Lm3-5hMH6U450QRAmUFsbFaJpk
X-Proofpoint-GUID: SfDZn0Lm3-5hMH6U450QRAmUFsbFaJpk
X-Proofpoint-Spam-Reason: orgsafe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce required basic devicetree parameters for the
initial commit of CS40L26.

Signed-off-by: Fred Treven <fred.treven@cirrus.com>
---
 .../devicetree/bindings/input/cirrus,cs40l26.yaml  | 102 +++++++++++++++++++++
 MAINTAINERS                                        |  10 ++
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cirrus,cs40l26.yaml

diff --git a/Documentation/devicetree/bindings/input/cirrus,cs40l26.yaml b/Documentation/devicetree/bindings/input/cirrus,cs40l26.yaml
new file mode 100644
index 000000000000..9cbc964ebded
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cirrus,cs40l26.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cirrus,cs40l26.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS40L26 Boosted Haptic Amplifier
+
+maintainers:
+  - Fred Treven <fred.treven@cirrus.com>
+
+description:
+  CS40L26 is a Boosted Haptic Driver with Integrated DSP and Waveform Memory
+  with Advanced Closed Loop Algorithms and LRA protection
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs40l26a
+      - cirrus,cs40l26b
+      - cirrus,cs40l27a
+      - cirrus,cs40l27b
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  VA-supply:
+    description: Regulator for VA analog voltage
+
+  VP-supply:
+    description: Regulator for VP peak voltage
+
+  cirrus,bst-ipk-microamp:
+    description:
+      Maximum amount of current that can be drawn by the device's boost converter.
+    multipleOf: 50000
+    minimum: 1600000
+    maximum: 4800000
+    default: 4500000
+
+  cirrus,bst-ctl-microvolt:
+    description: Maximum target voltage to which DSP may increase the VBST supply.
+    multipleOf: 50000
+    minimum: 2550000
+    maximum: 11000000
+    default: 11000000
+
+  cirrus,bst-exploratory-mode-disable:
+    description:
+      Disable boost exploratory mode.
+
+      In exploratory mode the analog maximum peak current limit of 4.5 A
+      (tolerance of + 160 mA) will be applied. This is required for the
+      device to successfully detect a boost inductor short.
+
+      Boost exploratory mode allows the device to overshoot the set boost peak
+      current limit (i.e. if current peak limit is set to 2.5 A to protect the
+      battery inductor, the current limit will be opened up to 4.5 A for
+      several milliseconds at boost startup).
+      This has potential to damage the boost inductor.
+
+      Disabling this mode will prevent this from happening; it will also
+      prevent the device from detecting boost inductor short errors.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cs40l26@58 {
+        compatible = "cirrus,cs40l26a";
+        reg = <0x58>;
+        interrupt-parent = <&gpio>;
+        interrupts = <57 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio 54 GPIO_ACTIVE_LOW>;
+        VA-supply = <&dummy_vreg>;
+        VP-supply = <&dummy_vreg>;
+        cirrus,bst-ctl-microvolt = <2600000>;
+        cirrus,bst-ipk-microamp = <1650000>;
+        cirrus,bst-exploratory-mode-disable;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b073facf399..d72ed4957b0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4926,6 +4926,16 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/cirrus/ep93xx_eth.c
 
+CIRRUS LOGIC HAPTICS DRIVER
+M:	Fred Treven <fred.treven@cirrus.com>
+M:	Ben Bright <ben.bright@cirrus.com>
+M:	James Ogletree <james.ogletree@cirrus.com>
+L:	patches@opensource.cirrus.com
+S:	Supported
+W:	https://github.com/CirrusLogic/linux-drivers/wiki
+T:	git https://github.com/CirrusLogic/linux-drivers.git
+F:	Documentation/devicetree/bindings/input/cirrus,cs40l26.yaml
+
 CIRRUS LOGIC LOCHNAGAR DRIVER
 M:	Charles Keepax <ckeepax@opensource.cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
-- 
2.7.4

