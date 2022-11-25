Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D0D638D43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiKYPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiKYPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:11:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0963E0B1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g12so7162292wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WfPFIvXQkUy4+HZsCcjoOy5HXh/OR2xwCOtqD43AE4=;
        b=w1SA1ZGNoJjU/F7vhzubxvZtSsnxd1ZwkoI7EfV/TKpuOm5638uSKo9CbCktX28O51
         +wsAkEKOvNcbEzW897EPDQqoFdTCz0saDTVeThjteBmSYXn5MHj8fiWn0e4Q1EZ7LM7x
         jrkCahK4ICAgxMTRYNXA93+jEQnAv7rHTBpVWYvItytfe7F8C8gLDLOC2FMLK6w6prUj
         EGw2LBxg8r7DIZVXe8/ajGuhcfyQbFMhUuAbU0XUrNrE0155jxzOcdLJzaH7+BQYoSe+
         6XEDeyKQ1J3YsAwUkSpdMpAWQZs+TvrLLFtoCugWaahiJYycTptgorVCeYSFOwI7TsFl
         l+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WfPFIvXQkUy4+HZsCcjoOy5HXh/OR2xwCOtqD43AE4=;
        b=orBop8eWRzTLDzt4sIibO74+uSb9fmCVn4CAJ7OUyLEC/ypDvzaK8P66FuNMkoyXCe
         xaoXbPYNhnFFldK5GkvLibDacxvrHN/jAH9Nyn25Ax3G8y6T9FtkWrtkRVV4EbX1Pnpw
         vCsxu7uEFq6Afl0zJZJuiY0/LTMhXl5aBABb5X4sGU5Wod4PskKfeeIPRzVYuvpVeMHO
         5e6m/ZUzCqkOWrO+TJZEXX/UlKuZukseZ/gtdmpUJrXzTRo+iI4/EsIVaHxBNqpvHOs9
         JDP8JTibQhafOt/Wau9WWvVnnvCtdSMqAdB+kaIjqryGlAWJZJOmUbdg365H9oNJktSK
         TFBQ==
X-Gm-Message-State: ANoB5pnk6O9HSAM4d0tA62LoMxEqqQ1Rk/nB0GaPoGPemhARN4hQoSBq
        1JfDcHcgr8Ar48bgsW29zYOkxw==
X-Google-Smtp-Source: AA0mqf4jxSywcBqwD02kLxE1mauRD2tbT4mXFuMK2P6OZ3jYffHhwCnVXNLquJaHNL8fzoH3Foy1fA==
X-Received: by 2002:a5d:6409:0:b0:241:f7ae:b1dd with SMTP id z9-20020a5d6409000000b00241f7aeb1ddmr7131169wru.138.1669389087744;
        Fri, 25 Nov 2022 07:11:27 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id w10-20020a05600c474a00b003b435c41103sm11565885wmo.0.2022.11.25.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:11:27 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 25 Nov 2022 16:10:17 +0100
Subject: [PATCH v6 06/10] dt-bindings: mfd: mediatek: Add bindings for MT6357 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v6-6-4f589756befa@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3860; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=hsHJv7tXwGtDI1+UamHOo/TefFAouJ5xvx7nyDsqMfU=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjgNsX/pZnd9dSqEQRhOJBuPEJnpnh/RqRO18ivjZi
 9fbakmCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4DbFwAKCRArRkmdfjHURVZQEA
 DDNYSSMiJ3lzTJ50OXfaQgj/FSv3bSM7tetVpMTLXk4uizebewWfqZ/8gek76u6K6I3kiTea8srWbl
 4DaXtUAP7PI9rTS7MhX8PG5FaKbElkLXTL8pCa5KhRlFnB52tpHhMVgh17PsbMkNbL5u2fAqn1WspR
 qqMIBASLied/bQ9ix5YDJ2Uq28bPqBR7/ooxMb1dXh6wSXvRY6Pea+ZUcCjtLCeVtOZEfCBeAHKJrJ
 uxafx2C5sHdhlh/4Nqa2iO9uDLD8/OGfJ5LsUQJxyl45C2RxrnQq27GJLWJD+vCdObuJJG7iyGLquZ
 L73uTAYMtLIbzFPEIe0okMQIrVRlXwcEzsHMW7SyKAzPSNggx49IvO/8g6B6ybz+dYq+/4HVv6gixl
 2AxrNBUX9OeceSG4ix2GcKi0AGgo6m4LW3uptSnWWBki9bEoCVqgJ1HjjTgFsKnoczc65JTH6WKPG0
 gd/x5CoyhwhE0zOTXGGUZNiFDuwLYsXya6y6I660rtlsSG7fOSh4l10A7PWzAHuGL/TfH5+Rj7T7pR
 IohWUhVIjvcf+qMQFfrLUMHvAu/yUGUlglxftIKaQ1HNo7Q5PGZHekCoYGChCBFqMYxRRedz9st/4p
 kWfOoNAXjTyLZbrWLC77sffUr9yPxplF4Rk0FgKVFbWBeP65fODCyFAsp0EQ==
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
