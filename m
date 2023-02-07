Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1CD68CFEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBGG7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBGG7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:59:12 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCE836FD6;
        Mon,  6 Feb 2023 22:59:10 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0ECDEC0000F1;
        Mon,  6 Feb 2023 22:59:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0ECDEC0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675753150;
        bh=L8FjIj2PvnLyFNjHP94aaulweaiuak35VPThzhtkhrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+My1POIgZ9/M2tu2sNE7lT4LwpbIT9xv98+LdjIc6yckhaiVe5StYh5a2xsPnME2
         3E5fLK21yxp0E6hqpzwYxFn0i9iUBjLATHFMYzjdcC93lED+ZLrQcM48F5edHBrvg8
         B5nZd/Tm6X0tk7UGmbR1+xMKU7gefnqTnYj5DMGs=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 0D28C18041CAC6;
        Mon,  6 Feb 2023 22:59:10 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 54340101B35; Mon,  6 Feb 2023 22:58:59 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/15] dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
Date:   Mon,  6 Feb 2023 22:58:12 -0800
Message-Id: <20230207065826.285013-2-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230207065826.285013-1-william.zhang@broadcom.com>
References: <20230207065826.285013-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the preparation for updates on the bcm63xx hsspi driver. Convert
the text based bindings to json-schema per new dts requirement.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
- Add reviewed-by tag
- Move spi-controller.yaml reference line down after required field so
  next patch does not need to move this line

Changes in v2:
- Add the missing reference to spi-controller which fix the
  dt_binding_check error.
- Use SPI intead of spi in the description.

 .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 55 +++++++++++++++++++
 .../bindings/spi/spi-bcm63xx-hsspi.txt        | 33 -----------
 2 files changed, 55 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
new file mode 100644
index 000000000000..3c646997e399
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM6328 High Speed SPI controller
+
+maintainers:
+  - Jonas Gorski <jonas.gorski@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm6328-hsspi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI master reference clock
+      - description: SPI master pll clock
+
+  clock-names:
+    items:
+      - const: hsspi
+      - const: pll
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@10001000 {
+        compatible = "brcm,bcm6328-hsspi";
+        reg = <0x10001000 0x600>;
+        interrupts = <29>;
+        clocks = <&clkctl 9>, <&hsspi_pll>;
+        clock-names = "hsspi", "pll";
+        num-cs = <2>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt b/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
deleted file mode 100644
index 37b29ee13860..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Binding for Broadcom BCM6328 High Speed SPI controller
-
-Required properties:
-- compatible: must contain of "brcm,bcm6328-hsspi".
-- reg: Base address and size of the controllers memory area.
-- interrupts: Interrupt for the SPI block.
-- clocks: phandles of the SPI clock and the PLL clock.
-- clock-names: must be "hsspi", "pll".
-- #address-cells: <1>, as required by generic SPI binding.
-- #size-cells: <0>, also as required by generic SPI binding.
-
-Optional properties:
-- num-cs: some controllers have less than 8 cs signals. Defaults to 8
-  if absent.
-
-Child nodes as per the generic SPI binding.
-
-Example:
-
-	spi@10001000 {
-		compatible = "brcm,bcm6328-hsspi";
-		reg = <0x10001000 0x600>;
-
-		interrupts = <29>;
-
-		clocks = <&clkctl 9>, <&hsspi_pll>;
-		clock-names = "hsspi", "pll";
-
-		num-cs = <2>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-- 
2.37.3

