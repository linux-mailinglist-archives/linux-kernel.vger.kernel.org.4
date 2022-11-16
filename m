Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393C362BE17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiKPMeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKPMdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:33:44 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58D63EF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o4so29549392wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WfPFIvXQkUy4+HZsCcjoOy5HXh/OR2xwCOtqD43AE4=;
        b=anNTidUNH1tj7TSR3clk5+n+38GOcvy75BhyNV4cdzvdYCHO+HjxLuMWpobowQTKl7
         5hn8Kc80R4O41z4pkcIFDTyT/Xe5TywiKOyyVYG7dYSAmqltXZMm8MkZn/xaE0QTJoUh
         MmF26D9T/EllHHu5S1HHlvKkCf0UMqC0KLHgePQ5mBG+AfP21jaE/Ujzo6Qg6zE9HD6l
         MUU1HdXrBre0hKK6DKi5EXvfTU1Qftnn0XOG/snntBrLtRwNf8V+yFDy1/8oPRL7Vv+m
         B8IhSsZqb51dMoEjFvy+TJKlkoT+3ToyB0es21BKO7LpQsKa9VmDpKzDlKnGpLbM6RRG
         g24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WfPFIvXQkUy4+HZsCcjoOy5HXh/OR2xwCOtqD43AE4=;
        b=qAaxc5xW4DI5dUktYIvZsqJ2dO9fb8bk9e5UhtQGVICoZ3fdODmpkKsdgyrCMq72wP
         mFuCimb5ca18oJ44MhyZwFtQRmpy+mKN1S8PQXO0xEU8k/P9r3vWzUjSYCnasNc/beaN
         oyfVjxVqThz9q3VdaX2G4cj+lSDWOICygDJuFqY73d5AMPI/G6zMKsQ3vLgM9W7qF5cZ
         Tik2Q53G11FcetkNBTymw728BQFLdQxJtiDXv6ImzE8Lto+Te2Gd817hIzPcJgKDYP4V
         lK5J8LN8+RBDq+qSG6VmFLaZs72FUPuKfB1Czs5RbVBPOd45cy3QHhngOPOsBFAscoB+
         4ZKQ==
X-Gm-Message-State: ANoB5pkdhLpbxE7aCfosTd7THp4Ikc0VZCvZ7f20ECN768b7xOiyVRj2
        NLrjGczIzHTj1bHgZzDYeoG4NQ==
X-Google-Smtp-Source: AA0mqf4n12wK9CCjIppl1FRYfRcSBS8fD+DvVYKOSREQwCcJOaNYMr8B9PHKzuyxxGfSFSxyAEYNeg==
X-Received: by 2002:a5d:4531:0:b0:22d:6ad5:bc0f with SMTP id j17-20020a5d4531000000b0022d6ad5bc0fmr14196682wra.115.1668602021629;
        Wed, 16 Nov 2022 04:33:41 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id z13-20020adff1cd000000b0024166413a4fsm15051607wro.37.2022.11.16.04.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:33:41 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 16 Nov 2022 13:32:59 +0100
Subject: [PATCH v5 05/10] dt-bindings: mfd: mediatek: Add bindings for MT6357 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v5-5-8210d955dd3d@baylibre.com>
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
To:     Flora Fu <flora.fu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3860; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=hsHJv7tXwGtDI1+UamHOo/TefFAouJ5xvx7nyDsqMfU=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjdNieQ9Fl8OeMeICUpSLnSuM0BD70OdMnojNX0qWc
 u07fbgGJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY3TYngAKCRArRkmdfjHURRraEA
 CEv/D0minFKV62jMF/0IbHr5ntv/eeMRm66nA1uv3+YuR42+mewSDq4Vo0dy7QQCNQGbV0QwPhi2/S
 nTd3BnqZoW377jskDvs+ot8b3jttwmF5cGW2TxYwbI472zCPrQgLgT7s+JfIxThZTX6zUxV0D8d9Sk
 K3kDc0ICCh0Maqo6afqLLQqyEWbTSigEibrsb2WlITYLLNLFXPj9Q/7dMmbv9MKnu8M3jSvslMP4j7
 CbWnpV2AQY8RHd0ccoE5QC4cbtGyJbAnRWudzqVeL+KiRnYJ9PPD7Mrbh4ckGExA8e0D3LzaCPm0Mc
 WgMpSgnfjh0W9vUopCM0PyDrX5ggfZUNPSNGUjO2vmn2leQDzGYWGVu56pIYr1U6sjRv17qiYnrpa3
 Ozfrk01f3yyhAXwncQkaRgTl/g+G/djr9oii5HeZIOuT9dxY/UBGSma9W482wfBsBQZqnFizBigdNa
 nWgOV+lc5i5nwbv6AzeVr1TKGXAA83EHEV+E33OKfy/Ap1pZupTvTxrPhTfBa0Lao93vbQrZyWGUIr
 XeI9FRzmHBDftKRuoJRpBDyt1BIgpVahsa0bw/ET3HnG1FlskktWvtzDSeUlnhWFim+zObQnfPlz1I
 DFfmhMEwubzKjwUW0afVN5dWVKt8xvb7B705IWg0AU2F3yLbYmrEIYF2pXtQ==
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

Currently, almost all MT63XX PMIC are documented mfd/mt6397.txt.
Unfortunately, the PMICs haven't always similar HW sub-features.
To have a better human readable schema, I chose to make one PMIC schema
to match the exact HW capabilities instead of convert mt6397.txt to
mediatek,mt63xx.yaml and put a bunch of properties behind
"if contain ... then ..."

- add interrupt property
- change property refs to match with new yaml documentation

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   | 105 +++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
new file mode 100644
index 000000000000..2aa8025d1e24
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mediatek,mt6357.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6357 PMIC
+
+maintainers:
+  - Flora Fu <flora.fu@mediatek.com>
+  - Alexandre Mergnat <amergnat@baylibre.com>
+
+description: |
+  MT6357 is a power management system chip containing 5 buck
+  converters and 29 LDOs. Supported features are audio codec,
+  USB battery charging, fuel gauge, RTC
+
+  This is a multifunction device with the following sub modules:
+  - Regulator
+  - RTC
+  - Keys
+
+  It is interfaced to host controller using SPI interface by a proprietary hardware
+  called PMIC wrapper or pwrap. This MFD is a child device of pwrap.
+  See the following for pwrap node definitions:
+  Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
+
+properties:
+  compatible:
+    const: mediatek,mt6357
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  regulators:
+    type: object
+    $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml
+    description:
+      List of MT6357 BUCKs and LDOs regulators.
+
+  rtc:
+    type: object
+    $ref: /schemas/rtc/mediatek,mt6397-rtc.yaml
+    description:
+      MT6357 Real Time Clock.
+
+  keys:
+    type: object
+    $ref: /schemas/input/mediatek,pmic-keys.yaml
+    description:
+      MT6357 power and home keys.
+
+required:
+  - compatible
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pwrap {
+        pmic {
+            compatible = "mediatek,mt6357";
+
+            interrupt-parent = <&pio>;
+            interrupts = <145 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            regulators {
+                mt6357_vproc_reg: buck-vproc {
+                    regulator-name = "vproc";
+                    regulator-min-microvolt = <518750>;
+                    regulator-max-microvolt = <1312500>;
+                    regulator-ramp-delay = <6250>;
+                    regulator-enable-ramp-delay = <220>;
+                    regulator-always-on;
+                };
+
+                // ...
+
+                mt6357_vusb33_reg: ldo-vusb33 {
+                    regulator-name = "vusb33";
+                    regulator-min-microvolt = <3000000>;
+                    regulator-max-microvolt = <3100000>;
+                    regulator-enable-ramp-delay = <264>;
+                };
+            };
+
+            rtc {
+                compatible = "mediatek,mt6357-rtc";
+            };
+
+            keys {
+                compatible = "mediatek,mt6357-keys";
+            };
+        };
+    };

-- 
b4 0.10.1
