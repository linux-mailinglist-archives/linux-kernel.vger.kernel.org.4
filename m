Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D287065B4C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjABQHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjABQGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:06:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A767B1CE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:06:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id az7so2285163wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1Ejzbo8UmM+RRLtZtfr7EYdzzjCFq6z/B+dE9yYQdY=;
        b=No9JDSz+Y49OM+b6tPmLzj2QweOdpcoFFSzCmvawoXirshFsqUnD1Xu4WetS/yw4+g
         duj9CTGizU20+ntjuDQkwl9Xn4j96loXaC/TAlUl6Bly7RTMhnJDJhr3AJXPPt0b2Mbd
         Kd9lWtgV1tEDU5itqxUBpEctnnJuFA9/2bhn3Xs/iT0f9E2y9e2Mf+Tpx/iOUDpF/eCL
         lxXjKSGGGmaqoCwNxUhLpSsGyPZc+1MjUM/WxcInVIqBnBNLnYqfNRnqs4VeQZWKv9Ee
         d4+lyppNlCY6L16djDwk9DkuIg5a3lE3LZwgTEpWayFrwEkbhjoAPCJazAJuI5bgiIbO
         VCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1Ejzbo8UmM+RRLtZtfr7EYdzzjCFq6z/B+dE9yYQdY=;
        b=cXJ56nz4QO/xrvi5Xg1AgIL563r3567LNDtocmfTEx8yuggGAtrW4MAr68NN0RTqPy
         lsjVmuenpDTpEoF7YBI+x/nTpwhchEUVsKraK09Bk98jp0cb/xlKZiK8FtqM8sZR1ngC
         pxpffFdhHcMmI5cs7SCAh5MbqNDtOQmrWd4nxUUSKUN1eX4FipRAyu8WqWz67sYSmv8E
         hx98MY0jM907E4P7xmFEFzdXKQhZUY9r/7OSOdeGUmVhdjdLttODTZsicQWqmbUGWcsR
         7hnuP0Fdqr+Iv6BqkE31XC9/XE2sHnMwsexdZOCPmp8E7IPiY/d58T4YHb1UBSjkcrvh
         uWEg==
X-Gm-Message-State: AFqh2kri9sp+BwVju7hPPNlVe6PZJxy55uJY5mFD+oiuygbxsmdRbLQ9
        5Sk91N/BEAe77PBe02Xf4Gmmkg==
X-Google-Smtp-Source: AMrXdXuxEvrUSXbBFM0DyHm6IYRAtChmYU0RMMViNTKnBuUwtbB5s46VQ+dmEa+IfKBdMhWFXw+0SA==
X-Received: by 2002:adf:f305:0:b0:277:2e27:61f6 with SMTP id i5-20020adff305000000b002772e2761f6mr20644263wro.31.1672675586952;
        Mon, 02 Jan 2023 08:06:26 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t5-20020a5d49c5000000b0028cf987d944sm11868020wrs.33.2023.01.02.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:06:26 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 02 Jan 2023 17:06:04 +0100
Subject: [PATCH v8 3/6] dt-bindings: mfd: mediatek: Add bindings for MT6357 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v8-3-560caaafee53@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4087; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=d4JaAPJCZ37xGAgh27tDIjEpQgF1gETvJTYcId5mtXE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjswD8YULwl172j+umCObsG7xMOMV26WGae1CSKyuG
 mG3nsiSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY7MA/AAKCRArRkmdfjHURWG8D/
 9p0CKHuKHFaz7McPKXm+lMJvfiKhELANAsYvy8A/CfqbGy5zVWoSFAm0kPcBizvBpwYTeNSPkYXvOo
 WIgzAGQRqKx5yRSSb81myBTEBUdkXzCb7e3E5/LxPD1kveOhw1+fiZxXT8mJcNUvSB5I6QeVFbHX+J
 AqDhu6ttct0LnBHJe7lGVzstSCqQ31I1Bp9uFmIu0wlLfWE1yBURQtYAMXOvEZsO8paa2/yJMYsdqR
 1U1g9CgelKCUvk0tZ9wXOuN8xq9tSNETwLGG70dHRZU3DNMgFoKvAzaipbq+Yi3B8/qoq4oR8UEbeF
 kp1O9YBdC5CFiwmtQr/NArGnEWohv0JS7VO74QPLRVm7XU2uIW6hCjuFgBiU7kbHuUG7m7CVcnYx5v
 oBAt4cs0XnyYIQOum6fmF5J0hvMMqIPVRVnstbKpWobLM4ww2L2pIOz9P1jfHTfzAXLdtQpIrcCWIy
 aaiuGPgCfezwOcMfWOkD/5AYiv1ZgdB2gyv5NHd8WtIgSmnl/eRnqahbyR1czWqqhwVBHBtU+Ixtgi
 Vwjh7osViGU3dys/o1FXnR7LuBZIO4aKU3rc1U5kFBYc4Rz4SFmv2UgzLO6AW18rxfP5a/MjGwiK9e
 vT6ycqVXSuHGo4lLZZnEp0bs7GJl07i2yjOdZs9W/pNJUHFFgYkGHvnlToiA==
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
new file mode 100644
index 000000000000..837a77013d57
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
@@ -0,0 +1,111 @@
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
+    $ref: /schemas/rtc/rtc.yaml#
+    description:
+      MT6357 Real Time Clock.
+    properties:
+      compatible:
+        const: mediatek,mt6357-rtc
+      start-year: true
+    required:
+      - compatible
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
