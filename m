Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C540F7109A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbjEYKO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbjEYKOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:14:46 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46AB19A;
        Thu, 25 May 2023 03:14:36 -0700 (PDT)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 51D553425C2;
        Thu, 25 May 2023 13:14:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=s6mCwGnOWAViyfGfD/
        82jKHpnnAdTLWiVtAF3qnYzeY=; b=h71apisK3pwpK8MocDcr02L3b3iHXLzD8v
        +0SsmUg/sGgUe7Ex8j0X/vWlA6tCw6tJ9CzCBluHGdW1SvzXeVoeKDvca47t3T9k
        apevU6V3JszX+KK4nZ1im6NKNTzJQC/26Et3AOn+IVLGi8Isje3PcPV66zBtizIK
        nOZiZ7cvI=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 45FCD3423E9;
        Thu, 25 May 2023 13:14:35 +0300 (MSK)
Received: from xpad.Home (172.22.2.87) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Thu, 25 May
 2023 13:14:34 +0300
From:   Vladimir Barinov <v.barinov@yadro.com>
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Vladimir Barinov <v.barinov@yadro.com>, <linux@yadro.com>
Subject: [PATCH v2 2/2] dt-bindings: leds: Document Awinic AW2026 bindings
Date:   Thu, 25 May 2023 13:14:28 +0300
Message-ID: <20230525101428.2037061-1-v.barinov@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525101341.2036563-1-v.barinov@yadro.com>
References: <20230525101341.2036563-1-v.barinov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.2.87]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Awinic AW2026 binding documentation

Signed-off-by: Vladimir Barinov <v.barinov@yadro.com>
---
Changes in version 2:
- fixed typos in patch header 2016 -> 2026
- fixed typo in example section that break dt_binding_check

 .../bindings/leds/awinic,aw2026.yaml          | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw2026.yaml

diff --git a/Documentation/devicetree/bindings/leds/awinic,aw2026.yaml b/Documentation/devicetree/bindings/leds/awinic,aw2026.yaml
new file mode 100664
index 000000000000..abacf746677b
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/awinic,aw2026.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/awinic,aw2026.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW2026 3-channel LED Driver
+
+maintainers:
+  - Vladimir Barinov <v.barinov@yadro.com>
+
+description: |
+  The AW2026 is a 3-channel LED driver with I2C interface. It can control
+  LED brightness with PWM output. It supports hardware blinking and
+  hardware patterns.
+
+properties:
+  compatible:
+    const: awinic,aw2026
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  awinic,led-max-microamp:
+    description:
+      Maximum current at LED output
+    enum:
+      [3000, 6375, 12750, 25500]
+
+  vcc-supply:
+    description: Regulator providing power to the "VBAT" pin.
+
+patternProperties:
+  "^led@[0-2]$":
+    type: object
+    $ref: common.yaml#
+
+    properties:
+      reg:
+        description: Index of the LED.
+        minimum: 0
+        maximum: 2
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@64 {
+            compatible = "awinic,aw2026";
+            reg = <0x64>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            awinic,led-max-microamp = <6375>;
+            vcc-supply = <&vcc_3v3_s0>;
+
+            led@0 {
+                    reg = <0>;
+                    function = LED_FUNCTION_INDICATOR;
+                    color = <LED_COLOR_ID_RED>;
+            };
+
+            led@1 {
+                    reg = <1>;
+                    function = LED_FUNCTION_INDICATOR;
+                    color = <LED_COLOR_ID_BLUE>;
+            };
+
+            led@2 {
+                    reg = <2>;
+                    function = LED_FUNCTION_INDICATOR;
+                    color = <LED_COLOR_ID_GREEN>;
+            };
+        };
+    };
+...
-- 
2.34.1


