Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E2173C9C2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 10:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjFXIv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 04:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjFXIv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 04:51:27 -0400
Received: from 8.mo562.mail-out.ovh.net (8.mo562.mail-out.ovh.net [46.105.60.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09B8E5F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 01:51:24 -0700 (PDT)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
        by mo562.mail-out.ovh.net (Postfix) with ESMTPS id 11A5522F95;
        Sat, 24 Jun 2023 08:42:35 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <conor+dt@kernel.org>; Sat, 24 Jun 2023 08:42:34 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.108.20.150])
        by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id ADDB82011E4;
        Sat, 24 Jun 2023 08:42:34 +0000 (UTC)
Received: from traphandler.com (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 24 Jun
 2023 10:42:34 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 4/5] dt-bindings: leds: Add binding for a multicolor group of LEDs
Date:   Sat, 24 Jun 2023 10:42:16 +0200
Message-ID: <20230624084217.3079205-5-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230624084217.3079205-1-jjhiblot@traphandler.com>
References: <20230624084217.3079205-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 12428246121859529169
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegjedgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnheptddtffevleejteelieejhfffvedtffeljeehjeeigfejledufedvveejuddtjefhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepughirhgvtghtohhruddruggvrhhprdhmrghilhdqohhuthdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to group multiple monochromatic LEDs into a multicolor
LED, e.g. RGB LEDs.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/leds/leds-group-multicolor.yaml  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
new file mode 100644
index 000000000000..8ed059a5a724
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-group-multicolor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Multi-color LED built with monochromatic LEDs
+
+maintainers:
+  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
+
+description: |
+  This driver combines several monochromatic LEDs into one multi-color
+  LED using the multicolor LED class.
+
+properties:
+  compatible:
+    const: leds-group-multicolor
+
+  leds:
+    description:
+      An aray of monochromatic leds
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+required:
+  - leds
+
+allOf:
+  - $ref: leds-class-multicolor.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
+    monochromatic-leds {
+        compatible = "gpio-leds";
+
+        led0: led-0 {
+            gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
+            color = <LED_COLOR_ID_RED>;
+        };
+
+        led1: led-1 {
+            gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
+            color = <LED_COLOR_ID_GREEN>;
+        };
+
+        led2: led-2 {
+            gpios = <&mcu_pio 2 GPIO_ACTIVE_HIGH>;
+            color = <LED_COLOR_ID_BLUE>;
+        };
+    };
+
+    multi-led {
+        compatible = "leds-group-multicolor";
+        color = <LED_COLOR_ID_RGB>;
+        function = LED_FUNCTION_INDICATOR;
+        leds = <&led0>, <&led1>, <&led2>;
+    };
+
+...
-- 
2.34.1

