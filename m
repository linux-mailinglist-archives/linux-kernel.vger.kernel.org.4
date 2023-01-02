Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFAB65B4BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjABQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbjABQGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:06:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C3FB1C5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:06:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d4so18688388wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOc5nXUkixqx+y2eCbGI5mLqw2/4q4AeizPZGq7MRBY=;
        b=2C8OFXUDDxkqv1zMr4TvartgULsNOhJ5KAMeWwyA1BrNpn6ddN8q0kRIKv57GX8TPL
         /8UZqS8Qy+b/CK51m+Yc+ALNh6DpIHPqFb4QbU3W/8IKlR+XDu57uwQMqR6X7TY2qpoi
         l/NJjRZ2bHRBwb042zyl0nSFb1+coUUwHY+sdldEuqxkMGERKQUxzfPwZyzHA+8ED2dl
         +hMt1ZK81whHz5zUBF0i+R6uKA8WjE6VnJrM1ZuVPkNysckMlCMsr56USrNA3qIWBIbH
         TtsdE3to36eKrcmxdWO2qL5j2DV3xAOcdrkS8VcKBbO6vrt0DzYtYElOYE6YiXnjTtMW
         0hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOc5nXUkixqx+y2eCbGI5mLqw2/4q4AeizPZGq7MRBY=;
        b=HSfE5KAqcZS8EIWEa5Su4WrDdrV8s8jIGOV9HJVCxVhOOaegte5eKgjAfQUUSoIHrs
         chota0pZlFFYQOI8+tljtgxoGpm75QCsFGPA1sfEwWj2P6f6yp4bbx/7y8uNcfSvgzzp
         pWbCIscGq7pEYZMXDN41kSXZ0xm4ScX4329tn1UctGOMJVHxhh655FNAm+1lVkJ3LyTO
         9EbCMR4F0C5O5ACRDwnJLaoX2YJdOwwB2qcTxsnruIBv0EOc/gsDB6rK57gY8FTPYhi3
         CQAInqqKa/HTU9CjcRmbCxXzPnEB3tLShsowckUMszycCDPDcQdfueI3BRY4LMEKm9Pv
         q+kw==
X-Gm-Message-State: AFqh2koju+PwG5y7oO0mjEhRCtW1pF+EARtJTjXBObDcTCMoiQiTri9W
        d/JXlgaPB5getAttfhxHFJBNgg==
X-Google-Smtp-Source: AMrXdXtuZkkvqONbTAmUfWL3sObnBYzI2V24P0UWTvs68UNlQASgeUJTHrhVSHhS2/HgRP45P8M0Gg==
X-Received: by 2002:a5d:56cb:0:b0:28d:66c4:3102 with SMTP id m11-20020a5d56cb000000b0028d66c43102mr8789095wrw.12.1672675585449;
        Mon, 02 Jan 2023 08:06:25 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t5-20020a5d49c5000000b0028cf987d944sm11868020wrs.33.2023.01.02.08.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:06:25 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 02 Jan 2023 17:06:03 +0100
Subject: [PATCH v8 2/6] dt-bindings: soc: mediatek: convert pwrap documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v8-2-560caaafee53@baylibre.com>
References: <20221005-mt6357-support-v8-0-560caaafee53@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v8-0-560caaafee53@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-rtc@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9638; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=cmlhRK9tSjWgidRT4HuJWIvfUhJuoLCgeyaF1sxatFI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjswD8DrlqU16WurDTNSI1yXZd9D9Tyv2DXNbLdaSb
 d6nrYwaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY7MA/AAKCRArRkmdfjHURfF+EA
 CdnPiZBrRy/0Vu/8fKF4U+XiZIjKSa+SBfI/+Oqezdytm0rS+u+wGk397vTzsf7941u/5ZeZXRsFfI
 Hs27h35v4aC93l5/oMoc5UIYby5xN1O9wgoDKzXettFxaV/3dgtlblnYleXigsQiIfjfEsVJcRxpwn
 eLBqhdiNzrl0uKe/qDNrqTB1hi6ORrOoBZjvYWGDwW0EiBXhlFEQfQhF6ZyMhD4CbDbBNyQYLsjxXB
 qucTHgQvldFhxwRoMDHzrDxyp+YOPjL0CPpWMjdXOD3yqFpfd34LKIiaeNDlwWQvcJ6FtDZXyNhWWO
 c7iLYG5MyO3xCqQMOwH/XVME++HIGnhUAXWEFq0TAoFLc5ZhbMFAmfCQ9/iirF/kBJ7dFqaHDBsNxF
 e1v0lv3hernhK97GU+6xJ7j6ACRRtAtUtTTAF/tPIWT3RtulJAExsYPgH22BVZU6rSiYOmQjE4t5qk
 wg/5fwmay+DzEZUw70NrPWl7MWt+MxhAxc0X+O26EX514I+tTNgbkrwoPXauWOrTi9YPq2i0tDKNkl
 dXVEPpIU9/mQRlk+i8MgRScDz9DLt+noWZj+oy1KYMtmX+meEKylWsLIIpD31pf/WBeFTcKyUxmebf
 WxUZM7lwB0wMABT83ZOB70D1z7mlC3NvN6nu/4PnBvMHpfDNxywi1zRZPNOA==
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

Reviewed-by: Rob Herring <robh@kernel.org>
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
index 12e4b4260b40..000000000000
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
-  "sys": Optional system module clock
-  "tmr": Optional timer module clock
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
