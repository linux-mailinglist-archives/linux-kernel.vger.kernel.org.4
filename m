Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711C5638D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKYPMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiKYPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:11:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BC81CB21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:28 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s5so7210521wru.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFLpoKOjjafPrfMvZwJR0cikHQtMiBmS0YHJBgB8k3A=;
        b=Oa3XK1Awha+MfM4z1MyjpmDvL6US7UxH/bpAz9TrdTL4aHAHrIjgJA7Cfixm+/n0sg
         qsJrA6eXIdayf+W6K2aaGTOnYP4dE076b96CJZuYj57EMVgd53QdVN1tUMn8Owc4W5q9
         jVr7LArK/KGmFN4O79LQz8sUzge1z0WhaH7a8JpH6YLvw0021fgS2O0jagFD4SU5EE8t
         6OY4WHcNVuXMnF1p7IBCwEiaLbAM7m/M45/A3rvXj2ImyeXGmDD0wF5vvPjKWUVI2MZ6
         0eHkUyV2r2aHNQwikxynxi8uBoipMc9IqRf02GNLNkKzwwZQDW1JTo6BxeJDJUtGiEvn
         jcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFLpoKOjjafPrfMvZwJR0cikHQtMiBmS0YHJBgB8k3A=;
        b=qYpyv0riIV+awdnxVANeY6oCn2o/lo88Ql+XxhZjn+IMi3w98XQVad/BeMRukenUlx
         R5EbpWTvCz7CvHQjuqhWkUsVPfo1Xq2gAgvJ04H9GhFWl9s/zM/K3PipQRLZ3loYtz4R
         6uStHSI1afJTNl0HTP/idHR9xoZhmc/+AK/g4l5FHnuVGZP547l6OWXKEecxBlAqnW8B
         0oZ43WE+m9qUzKTnGXQCnfDV4aRjufAgROk/mEsPZ81EcCWxYPxAb+0XD5H7ztSjY8Mv
         DiwPjOTTzhZZ/eXDJjzwP1uGd/q7B5LQeV55G9iO1Je3CwoWkhF7ENYCW3ImmXdb4MNs
         Td4A==
X-Gm-Message-State: ANoB5pkmslYdFf1Mv7M7ZDJbh4FrbDJvxHtAileugfh4hUO0irUO33x7
        W/0rgqiLBvQ9WnCMXG45XljX9A==
X-Google-Smtp-Source: AA0mqf7x166PwYc0AK1minps2ypKHTl4Drd2limM2an+XZCN8kqT5R585FRzD5cV/FU3ubAiz+wk8Q==
X-Received: by 2002:a05:6000:128c:b0:236:e512:1a9e with SMTP id f12-20020a056000128c00b00236e5121a9emr14907787wrx.416.1669389086581;
        Fri, 25 Nov 2022 07:11:26 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id w10-20020a05600c474a00b003b435c41103sm11565885wmo.0.2022.11.25.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:11:26 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 25 Nov 2022 16:10:16 +0100
Subject: [PATCH v6 05/10] dt-bindings: soc: mediatek: convert pwrap documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v6-5-4f589756befa@baylibre.com>
References: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9574; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=lGcU/tLnBFuf2FChwx+BufI9cy58Bma4z2fSLbd1Gq8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjgNsXrE+qken7Fg4GdIMw699mOYmNxNcxMzRrKYcW
 DqDHHiGJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4DbFwAKCRArRkmdfjHURdcfD/
 4yUBxuy8lZAuqNkA98FGpztVt3vWRQg+DjKN+vKmyIg+em2/axvFo80WIiVPVkzWCXPRP3HLhGcUvt
 vyDGcS69fXg8EWL0G1pZHl2fmweNpTq0L1nFRpV1jpfeDNPmH9TBGO2MVkJ33q1Mi8Jc/7AGb3pCJ1
 SZn7D7nkmcKjcac0cLWe4YBpnD7wtCb6OXGb+8VOPZtD4J7B/jJwzmVJluC6cBA6JTrtlQ9ImNC0m+
 rhpCLu0m7w2uKvO1GSQO/lK2LoVEgYiEXvnx5gQtrqZ6cpFanYRx4RW7ZCNG4mnj4NExLHhJlL97Jr
 WBCx5niS8fGHK3SAWrYnbYrx4zM3NVvWkCsy26CNo8Em0InrrS1c4XZqvnP9fU3Qrf/rf/QUMtVIk4
 8+vjaee5dLm2nCrEsYhDq3bLybbhaKfWgQgqdlHhlAHpeUrycQaQ2PY+to2wW870uE/bIjBPyWtygp
 XAGZIgl1UMhQCYQY3qANQYw/1rWZQZ/tX57qSIkhZz71SD4y2dS1ABdQFo33l2JAWRWy4hi3ZLn1+B
 QzCZ9XbYdETYL8ZMl8U5Mvaz/m0KlyJ0Z+erc7+CKyJZFdBWW7jza/EWDVmjG6awoT6bF9uLy5dbyk
 LKLTCDU8a0iLr1YIRW6ooy0xG5JvMAbxt/pNkWaUGkgqxH6wRTicTb7jg6aA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Convert soc/mediatek/pwrap.txt to soc/mediatek/mediatek,pwrap.yaml
- Add syscon compatible const for mt8186 and mt8195 to match the DTS needs.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/leds/leds-mt6323.txt       |   2 +-
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   2 +-
 .../bindings/soc/mediatek/mediatek,pwrap.yaml      | 147 +++++++++++++++++++++
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |  75 -----------
 4 files changed, 149 insertions(+), 77 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
index 45bf9f7d85f3..73353692efa1 100644
--- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
+++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
@@ -9,7 +9,7 @@ MT6323 PMIC hardware.
 For MT6323 MFD bindings see:
 Documentation/devicetree/bindings/mfd/mt6397.txt
 For MediaTek PMIC wrapper bindings see:
-Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
 
 Required properties:
 - compatible : Must be "mediatek,mt6323-led"
diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 79aaf21af8e9..3bee4a42555d 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -13,7 +13,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
 It is interfaced to host controller using SPI interface by a proprietary hardware
 called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
 See the following for pwarp node definitions:
-../soc/mediatek/pwrap.txt
+../soc/mediatek/mediatek,pwrap.yaml
 
 This document describes the binding for MFD device and its sub module.
 
diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
new file mode 100644
index 000000000000..3969871eaced
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mediatek,pwrap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek PMIC Wrapper
+
+maintainers:
+  - Flora Fu <flora.fu@mediatek.com>
+  - Alexandre Mergnat <amergnat@baylibre.com>
+
+description:
+  On MediaTek SoCs the PMIC is connected via SPI. The SPI master interface
+  is not directly visible to the CPU, but only through the PMIC wrapper
+  inside the SoC. The communication between the SoC and the PMIC can
+  optionally be encrypted. Also a non standard Dual IO SPI mode can be
+  used to increase speed.
+
+  IP Pairing
+
+  On MT8135 the pins of some SoC internal peripherals can be on the PMIC.
+  The signals of these pins are routed over the SPI bus using the pwrap
+  bridge. In the binding description below the properties needed for bridging
+  are marked with "IP Pairing". These are optional on SoCs which do not support
+  IP Pairing
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-pwrap
+              - mediatek,mt6765-pwrap
+              - mediatek,mt6779-pwrap
+              - mediatek,mt6797-pwrap
+              - mediatek,mt6873-pwrap
+              - mediatek,mt7622-pwrap
+              - mediatek,mt8135-pwrap
+              - mediatek,mt8173-pwrap
+              - mediatek,mt8183-pwrap
+              - mediatek,mt8186-pwrap
+              - mediatek,mt8188-pwrap
+              - mediatek,mt8195-pwrap
+              - mediatek,mt8365-pwrap
+              - mediatek,mt8516-pwrap
+      - items:
+          - enum:
+              - mediatek,mt8186-pwrap
+              - mediatek,mt8195-pwrap
+          - const: syscon
+
+  reg:
+    minItems: 1
+    items:
+      - description: PMIC wrapper registers
+      - description: IP pairing registers
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: pwrap
+      - const: pwrap-bridge
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    items:
+      - description: SPI bus clock
+      - description: Main module clock
+      - description: System module clock
+      - description: Timer module clock
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: spi
+      - const: wrap
+      - const: sys
+      - const: tmr
+
+  resets:
+    minItems: 1
+    items:
+      - description: PMIC wrapper reset
+      - description: IP pairing reset
+
+  reset-names:
+    minItems: 1
+    items:
+      - const: pwrap
+      - const: pwrap-bridge
+
+  pmic:
+    type: object
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+
+dependentRequired:
+  resets: [reset-names]
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8365-pwrap
+    then:
+      properties:
+        clocks:
+          minItems: 4
+
+        clock-names:
+          minItems: 4
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/mt8135-resets.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pwrap@1000d000 {
+            compatible = "mediatek,mt8135-pwrap";
+            reg = <0 0x1000f000 0 0x1000>,
+                  <0 0x11017000 0 0x1000>;
+            reg-names = "pwrap", "pwrap-bridge";
+            interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk26m>, <&clk26m>;
+            clock-names = "spi", "wrap";
+            resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
+                     <&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
+            reset-names = "pwrap", "pwrap-bridge";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
deleted file mode 100644
index 8424b93c432e..000000000000
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ /dev/null
@@ -1,75 +0,0 @@
-MediaTek PMIC Wrapper Driver
-
-This document describes the binding for the MediaTek PMIC wrapper.
-
-On MediaTek SoCs the PMIC is connected via SPI. The SPI master interface
-is not directly visible to the CPU, but only through the PMIC wrapper
-inside the SoC. The communication between the SoC and the PMIC can
-optionally be encrypted. Also a non standard Dual IO SPI mode can be
-used to increase speed.
-
-IP Pairing
-
-on MT8135 the pins of some SoC internal peripherals can be on the PMIC.
-The signals of these pins are routed over the SPI bus using the pwrap
-bridge. In the binding description below the properties needed for bridging
-are marked with "IP Pairing". These are optional on SoCs which do not support
-IP Pairing
-
-Required properties in pwrap device node.
-- compatible:
-	"mediatek,mt2701-pwrap" for MT2701/7623 SoCs
-	"mediatek,mt6765-pwrap" for MT6765 SoCs
-	"mediatek,mt6779-pwrap" for MT6779 SoCs
-	"mediatek,mt6797-pwrap" for MT6797 SoCs
-	"mediatek,mt6873-pwrap" for MT6873/8192 SoCs
-	"mediatek,mt7622-pwrap" for MT7622 SoCs
-	"mediatek,mt8135-pwrap" for MT8135 SoCs
-	"mediatek,mt8173-pwrap" for MT8173 SoCs
-	"mediatek,mt8183-pwrap" for MT8183 SoCs
-	"mediatek,mt8186-pwrap" for MT8186 SoCs
-	"mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap" for MT8188 SoCs
-	"mediatek,mt8195-pwrap" for MT8195 SoCs
-	"mediatek,mt8365-pwrap" for MT8365 SoCs
-	"mediatek,mt8516-pwrap" for MT8516 SoCs
-- interrupts: IRQ for pwrap in SOC
-- reg-names: "pwrap" is required; "pwrap-bridge" is optional.
-  "pwrap": Main registers base
-  "pwrap-bridge": bridge base (IP Pairing)
-- reg: Must contain an entry for each entry in reg-names.
-- clock-names: Must include the following entries:
-  "spi": SPI bus clock
-  "wrap": Main module clock
-  "sys": System module clock (for MT8365 SoC)
-  "tmr": Timer module clock (for MT8365 SoC)
-- clocks: Must contain an entry for each entry in clock-names.
-
-Optional properities:
-- reset-names: Some SoCs include the following entries:
-  "pwrap"
-  "pwrap-bridge" (IP Pairing)
-- resets: Must contain an entry for each entry in reset-names.
-- pmic: Using either MediaTek PMIC MFD as the child device of pwrap
-  See the following for child node definitions:
-  Documentation/devicetree/bindings/mfd/mt6397.txt
-  or the regulator-only device as the child device of pwrap, such as MT6380.
-  See the following definitions for such kinds of devices.
-  Documentation/devicetree/bindings/regulator/mt6380-regulator.txt
-
-Example:
-	pwrap: pwrap@1000f000 {
-		compatible = "mediatek,mt8135-pwrap";
-		reg = <0 0x1000f000 0 0x1000>,
-			<0 0x11017000 0 0x1000>;
-		reg-names = "pwrap", "pwrap-bridge";
-		interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
-		resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
-				<&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
-		reset-names = "pwrap", "pwrap-bridge";
-		clocks = <&clk26m>, <&clk26m>;
-		clock-names = "spi", "wrap";
-
-		pmic {
-			compatible = "mediatek,mt6397";
-		};
-	};

-- 
b4 0.10.1
