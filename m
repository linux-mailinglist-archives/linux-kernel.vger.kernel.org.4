Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A7163C46D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiK2P5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiK2P5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:57:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD43C6FC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x17so22789333wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSXTnduHdLJFDwTGMmcVf+k2uPaD9iDVF5vR3SER73c=;
        b=QtVk6qmdtAtN9rpdfZ2/pAciqRbRDoEiYB3ooWVfZVlh3OepQVbUKDb5jWo/SR3j7F
         nCeAsJsGke6CYtLDvNaR8qfMeyfpBZVKNfjcwLkfyK9bghW7ajhrQEYIlPv79lOL2Fyf
         AytTVcV2wcB3lierIGcB2QpLWDgrQqS6zM7chu/d+OLlqD08LSMkzZLZl9BRf8aaVqHQ
         ZNZcMzYGA+CS6p4Cfn7+3H5zIdIef8SvDXqjGyuB8mAyQNFq3XSdJdXKJOqooj4V4Ul/
         JMw8jofpAxkdvF455KEU6UJYUZx4H/gpkZfdaICe6y6BbMVHu0Zuul3vWyJXTra2MZWe
         4qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSXTnduHdLJFDwTGMmcVf+k2uPaD9iDVF5vR3SER73c=;
        b=zkAanFmzSlzVkXgTG0hpUU9E1W/FhsF6y5IwFPB3hCNuqJTpCDW230UQhOQjjiypaG
         tkjogVsofnuF16ekubRZ+MRpLwNKUW6PLnRODOuBCwWUX6kjcomrnABi/T+9FGaoM0CM
         qCAxcqJuHHXZXN18ktiv7Mv98jS/DmzwLAqlU7T3mSEXblHdyY0Jmd4T0RlwB/FlQMK8
         cMqytgDJ9lmyAtZ3LQttJWb525/wfSoRDu/sPAcD2ZWfjFn2EcEN1UXhr/0AKbIe8d48
         bYVZwJH6GUgEhnXaSIsGR9TobT0eHCfa1AvIqq973MfOvjTYrgcmBDCR7Y6oinD/sOnh
         mVrg==
X-Gm-Message-State: ANoB5pnrA+rqLMsYYpu7WQKwaXjiSM/3R4juyyw2rBU2/ZgFphqprrMM
        L96XqG7I7bHoY7knWU1lFGe5rQ==
X-Google-Smtp-Source: AA0mqf4uacuue8SxBU2/n5VuaK0VLmz26Fcifha/BcwVtAmZO1xI3UkUlxrmWSrK7lc4nP9MXIvqHg==
X-Received: by 2002:a5d:430e:0:b0:241:bfb6:c6da with SMTP id h14-20020a5d430e000000b00241bfb6c6damr24358546wrq.204.1669737428331;
        Tue, 29 Nov 2022 07:57:08 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f2-20020a7bc8c2000000b003cfb7c02542sm2601550wml.11.2022.11.29.07.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:57:08 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 29 Nov 2022 16:57:02 +0100
Subject: [PATCH v7 3/8] dt-bindings: soc: mediatek: convert pwrap documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v7-3-477e60126749@baylibre.com>
References: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9610; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=ua1+vGOjM+PtVPHzu6j0pM7CApCd3EgE4hX+baoA7J0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjhivP/IEw9FjmczIrkQUhROaTPxT7rC3e0dQjSI2u
 os4OD3mJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4YrzwAKCRArRkmdfjHURR/yD/
 9biCOQuAJkLcebzxkjttJzo3xe/46b4JtW9EYtKi1KBwIIBeoLZCBr+XPSElkvrI/FVb7nJjLs4W4C
 kw4nJCMIp7mWf59lVS9x6X962OIgqfe3/krd2LfE+SC+QQ4LHlWZC0wjnXmlV/bfVeZS7PGBnIR3QH
 W6zwS0TI+RpYOuIGgrJv7erbFwOU52OdIuLnStjkdLRedC+bIokONE+xl4GC1oNhxTLPA+HYZ0J2V9
 nsWQljwoBsM6wmIPhQy1u+XaWr0A+fKumVgrr+hOfAGF4AdPGF3fr0QLOvEPiXspokQnK1tlnyCmjw
 uWCDA2mZoYSi8d9rBnPZlYuLz/YAAEsa8YekSvND76OegKgrDmk/NDpSX8SKYQaZ9Yas0HBNZ3O3sR
 9vrAXeX45UzaGZv+DD6D9N5OVOHCVcd+VyRGg1G0Mg7v5uU0cH90esyTb7o4QhJ5ncuvoqaziP+kC/
 C4DsQb82nG805HmCqgZKujTtlVkV5JSjQJ5kHO8AqWht0lUfIiblSQCCJ+p3t7NeLc7OCjl2YxKWYk
 q03WfPVTvQ0jRGccVexXBGhMQ1KNW/SrS8OB1s7ggumFuJo8m6Qj7LnhEPbnyLenH0uDmoQ5JqjTY0
 ltTppleFr7pSvTJWmAc0z3Gve4c+xuzzrf6CYfT65WgC5aUEFV6JwTCxm0ZQ==
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
- Add syscon compatible const for mt8186 and mt8195 to match the DTS needs,
  which is missing from pwrap.txt.

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
index 0088442efca1..33b3d39d4ddd 100644
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
index 000000000000..3fefd634bc69
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
+        pwrap@1000f000 {
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
