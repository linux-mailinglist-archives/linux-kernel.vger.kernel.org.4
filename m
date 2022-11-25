Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D70638D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiKYPLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiKYPLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:11:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FC13D902
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso6503664wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EaP34wv8cHsMbN5b2lelNoPsr3chehdl/q6+cIBNPQg=;
        b=a00aeEiqNLdfaP8pJJMTlm1st+CBVpharXXE5efjNd2t+tAUicUKf/ATqv/wQf4KtM
         5isOcb82wBidTFJ/PIPU1/e6lKXxwVog19esAb8AekyIsE9jXXMMnjT/TBt2tbe/A2Y3
         ymLxUZHqE83wczl7D157EExhyny7uqe2+9uakjDnwUK0qj6DyVxsf7HrXjvDaLcMWAiQ
         eo2oIh2nJZeNKGr9m725hWaapJZptybryEs2KFHTdVByGChUXuU3WMhvQ1JzMzmu7mKX
         5yIMjmdRbC4onl01PEXEyZDl6L6mi1L0Wduyr/WNO88SDp3u8bmLuIpZ4OQhMBk+7f/g
         NZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaP34wv8cHsMbN5b2lelNoPsr3chehdl/q6+cIBNPQg=;
        b=H3x8t54rSaG4CGHuT8g/zfaR0GsZlzG4QT5VCGQJQvVSav5wixnT6qglofJcUS1wlv
         ytcMxbHFXdBNPBGa6Rauf0njbBcq39qWr8Rpz7OYgLFWtJzeVS8oXF6mwoc1aQtT5CaO
         ZFS6kkfFJwBkrKvaJzDjOH/2QyecvyQkcNiz1Oj9is4tpV36hDF04JpmFZswujoXaz1e
         hU0euhy8yL92B8P7S4UCpiH7uUJywxeFQfkNdjeiZjZRvsL8c7jT4LRQ99qzbwJLgKtu
         7zy6cvRddZMue6cPd8R/J6FJzti+w39E0hKkBVZUlnPt+Jt7MljQes0nQXsiWMv+r1Iy
         XpZg==
X-Gm-Message-State: ANoB5pkIZhgAq3APG4Ng1t/HOloeVCszJ4GsILANOFVQUAke9clZWiOp
        c8/M7iAxuE9uEDt2m+iZ8BYqdQ==
X-Google-Smtp-Source: AA0mqf7dcJLl74CAaap1sCd5Hcm4X7ZYFAQ7k75impAxJ2nhLCoKmK4mcDwYRq6oPcj/HAQ7JXaQ2g==
X-Received: by 2002:a05:600c:3d8b:b0:3d0:545:a0 with SMTP id bi11-20020a05600c3d8b00b003d0054500a0mr17157532wmb.123.1669389085313;
        Fri, 25 Nov 2022 07:11:25 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id w10-20020a05600c474a00b003b435c41103sm11565885wmo.0.2022.11.25.07.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:11:24 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 25 Nov 2022 16:10:15 +0100
Subject: [PATCH v6 04/10] regulator: dt-bindings: Add binding schema for mt6357
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v6-4-4f589756befa@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11440;
 i=amergnat@baylibre.com; h=from:subject:message-id;
 bh=y+MiriLy7hAWFi7TI2kfD8KqIfIYGSLRk1pCtSC2vQw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjgNsX6//zoBpr5oyYTNAos+h38wGLdiC8i63x0Vz4
 VEYdOJmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4DbFwAKCRArRkmdfjHURb8VD/
 0SsXN0bcyn8GquzvUjms7TA0ZXjPNqCOYo/8CW9hr+Wp6id+9npjhRUc3KcVJTvJWxraUeGicgbpSB
 gEktBlQKhzFFqqKQ2eoHOWGeK276+q6u5qCKEfcbzmZTIfoU7DsGdyCbvQ3+2NZszHmh4XUDDvyLhf
 Pbi9S7myzSiuheIqrpvOXIbAnQkLlK7aJept4z5gx87F/NsDyfd3TzMzVkI/b+AVzB3/H08tvwPNzJ
 IW5Lst1FlMeiC8EvQ1FbUfAn+8cHjSBVAjUO32pnAfNmmg3elkOGSsUXOVyrBUQiZlOpIE4LN4NPbr
 ttePExE7mKpbACFnaZvLc7iTfl3iRivw08xC9U5xA1RbEmEqhFmaGuvRJUEC4PzLl+6fkg9R+OIHh7
 K4T2eG0pxrhiBDA+WceZGU+Ng2F/jJWuogNGOViffxHfvDe+w1+HpEn7NoYXroSddylaq1hJxHq/hr
 FXQRJfpPbi4AmFH5Oe78ZRFcxs530KIGRCC2l3yH2ApqA0gHB/pZrXFIKaO/93ibtmMz7P4L3wAS8B
 vXy7eDOyX1xcMuiqlvztObihURyskXuxv5cubBJ9NFltiYPr1suKBWzNWkGw0dZuFc4K3h15S0nD7A
 ma5+uFM9VJo+ULDHEsdGs7DEjHhbhK8IGbB3PQo2aWVVQKq8BUGQShWJ83UQ==
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

From: Fabien Parent <fparent@baylibre.com>

Add YAML schema for the MediaTek MT6357 regulators.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../regulator/mediatek,mt6357-regulator.yaml       | 294 +++++++++++++++++++++
 1 file changed, 294 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
new file mode 100644
index 000000000000..6327bb2f6ee0
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
@@ -0,0 +1,294 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6357-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6357 Regulators
+
+maintainers:
+  - Chen Zhong <chen.zhong@mediatek.com>
+  - Fabien Parent <fabien.parent@linaro.org>
+  - Alexandre Mergnat <amergnat@baylibre.com>
+
+description: |
+  The MT6357 PMIC provides 5 BUCK and 29 LDO.
+  Regulators and nodes are named according to the regulator type:
+  - buck-<name>
+  - ldo-<name>.
+  MT6357 regulators node should be sub node of the MT6397 MFD node.
+
+patternProperties:
+  "^buck-v(core|modem|pa|proc|s1)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single BUCK regulator.
+
+    required:
+      - regulator-name
+      - regulator-min-microvolt
+      - regulator-max-microvolt
+
+  "^ldo-v(camio18|aud28|aux18|io18|io28|rf12|rf18|cn18|cn28|fe28)$":
+    type: object
+    $ref: fixed-regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single fixed LDO regulator.
+
+    required:
+      - regulator-name
+      - regulator-min-microvolt
+      - regulator-max-microvolt
+
+  "^ldo-v(efuse|ibr|ldo28|mch|cama|camd|cn33-bt|cn33-wifi)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single LDO regulator.
+
+    required:
+      - regulator-name
+      - regulator-min-microvolt
+      - regulator-max-microvolt
+
+  "^ldo-v(xo22|emc|mc|sim1|sim2|sram-others|sram-proc|dram|usb33)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single LDO regulator.
+
+    required:
+      - regulator-name
+      - regulator-min-microvolt
+      - regulator-max-microvolt
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      regulators {
+        mt6357_vproc_reg: buck-vproc {
+          regulator-name = "vproc";
+          regulator-min-microvolt = <518750>;
+          regulator-max-microvolt = <1312500>;
+          regulator-ramp-delay = <6250>;
+          regulator-enable-ramp-delay = <220>;
+          regulator-always-on;
+        };
+        mt6357_vcore_reg: buck-vcore {
+          regulator-name = "vcore";
+          regulator-min-microvolt = <518750>;
+          regulator-max-microvolt = <1312500>;
+          regulator-ramp-delay = <6250>;
+          regulator-enable-ramp-delay = <220>;
+          regulator-always-on;
+        };
+        mt6357_vmodem_reg: buck-vmodem {
+          regulator-name = "vmodem";
+          regulator-min-microvolt = <500000>;
+          regulator-max-microvolt = <1193750>;
+          regulator-ramp-delay = <6250>;
+          regulator-enable-ramp-delay = <220>;
+        };
+        mt6357_vs1_reg: buck-vs1 {
+          regulator-name = "vs1";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <2200000>;
+          regulator-ramp-delay = <12500>;
+          regulator-enable-ramp-delay = <220>;
+          regulator-always-on;
+        };
+        mt6357_vpa_reg: buck-vpa {
+          regulator-name = "vpa";
+          regulator-min-microvolt = <500000>;
+          regulator-max-microvolt = <3650000>;
+          regulator-ramp-delay = <50000>;
+          regulator-enable-ramp-delay = <220>;
+        };
+        mt6357_vfe28_reg: ldo-vfe28 {
+          compatible = "regulator-fixed";
+          regulator-name = "vfe28";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vxo22_reg: ldo-vxo22 {
+          regulator-name = "vxo22";
+          regulator-min-microvolt = <2200000>;
+          regulator-max-microvolt = <2400000>;
+          regulator-enable-ramp-delay = <110>;
+        };
+        mt6357_vrf18_reg: ldo-vrf18 {
+          compatible = "regulator-fixed";
+          regulator-name = "vrf18";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-enable-ramp-delay = <110>;
+        };
+        mt6357_vrf12_reg: ldo-vrf12 {
+          compatible = "regulator-fixed";
+          regulator-name = "vrf12";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <1200000>;
+          regulator-enable-ramp-delay = <110>;
+        };
+        mt6357_vefuse_reg: ldo-vefuse {
+          regulator-name = "vefuse";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vcn33_bt_reg: ldo-vcn33-bt {
+          regulator-name = "vcn33-bt";
+          regulator-min-microvolt = <3300000>;
+          regulator-max-microvolt = <3500000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vcn33_wifi_reg: ldo-vcn33-wifi {
+          regulator-name = "vcn33-wifi";
+          regulator-min-microvolt = <3300000>;
+          regulator-max-microvolt = <3500000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vcn28_reg: ldo-vcn28 {
+          compatible = "regulator-fixed";
+          regulator-name = "vcn28";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vcn18_reg: ldo-vcn18 {
+          compatible = "regulator-fixed";
+          regulator-name = "vcn18";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vcama_reg: ldo-vcama {
+          regulator-name = "vcama";
+          regulator-min-microvolt = <2500000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vcamd_reg: ldo-vcamd {
+          regulator-name = "vcamd";
+          regulator-min-microvolt = <1000000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vcamio_reg: ldo-vcamio18 {
+          compatible = "regulator-fixed";
+          regulator-name = "vcamio";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vldo28_reg: ldo-vldo28 {
+          regulator-name = "vldo28";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <3000000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vsram_others_reg: ldo-vsram-others {
+          regulator-name = "vsram-others";
+          regulator-min-microvolt = <518750>;
+          regulator-max-microvolt = <1312500>;
+          regulator-ramp-delay = <6250>;
+          regulator-enable-ramp-delay = <110>;
+          regulator-always-on;
+        };
+        mt6357_vsram_proc_reg: ldo-vsram-proc {
+          regulator-name = "vsram-proc";
+          regulator-min-microvolt = <518750>;
+          regulator-max-microvolt = <1312500>;
+          regulator-ramp-delay = <6250>;
+          regulator-enable-ramp-delay = <110>;
+          regulator-always-on;
+        };
+        mt6357_vaux18_reg: ldo-vaux18 {
+          compatible = "regulator-fixed";
+          regulator-name = "vaux18";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vaud28_reg: ldo-vaud28 {
+          compatible = "regulator-fixed";
+          regulator-name = "vaud28";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vio28_reg: ldo-vio28 {
+          compatible = "regulator-fixed";
+          regulator-name = "vio28";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vio18_reg: ldo-vio18 {
+          compatible = "regulator-fixed";
+          regulator-name = "vio18";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-enable-ramp-delay = <264>;
+          regulator-always-on;
+        };
+        mt6357_vdram_reg: ldo-vdram {
+          regulator-name = "vdram";
+          regulator-min-microvolt = <1100000>;
+          regulator-max-microvolt = <1200000>;
+          regulator-enable-ramp-delay = <3300>;
+        };
+        mt6357_vmc_reg: ldo-vmc {
+          regulator-name = "vmc";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-enable-ramp-delay = <44>;
+        };
+        mt6357_vmch_reg: ldo-vmch {
+          regulator-name = "vmch";
+          regulator-min-microvolt = <2900000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-enable-ramp-delay = <44>;
+        };
+        mt6357_vemc_reg: ldo-vemc {
+          regulator-name = "vemc";
+          regulator-min-microvolt = <2900000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-enable-ramp-delay = <44>;
+          regulator-always-on;
+        };
+        mt6357_vsim1_reg: ldo-vsim1 {
+          regulator-name = "vsim1";
+          regulator-min-microvolt = <1700000>;
+          regulator-max-microvolt = <3100000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vsim2_reg: ldo-vsim2 {
+          regulator-name = "vsim2";
+          regulator-min-microvolt = <1700000>;
+          regulator-max-microvolt = <3100000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+        mt6357_vibr_reg: ldo-vibr {
+          regulator-name = "vibr";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-enable-ramp-delay = <44>;
+        };
+        mt6357_vusb33_reg: ldo-vusb33 {
+          regulator-name = "vusb33";
+          regulator-min-microvolt = <3000000>;
+          regulator-max-microvolt = <3100000>;
+          regulator-enable-ramp-delay = <264>;
+        };
+      };
+    };
+...

-- 
b4 0.10.1
