Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD46B60FC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCKVVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCKVVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:21:23 -0500
Received: from smtp17.i.mail.ru (smtp17.i.mail.ru [95.163.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2077430D;
        Sat, 11 Mar 2023 13:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=2jjmBpgJVDgNkqH/Dt2oDwlCYbqysQKz4ZJwnIsVz24=;
        t=1678569681;x=1678659681; 
        b=eXflvDR9BR90NKJRMRGLXe20ZCxcVHTG2rSnacsC3BwUCu5fFJNWXH4yNZwrf/ZAC285p0BTaf8/kpQZQ0MpmHlaE9oXrdzZHNvNyeW1tJ5a31sl7L42nAeftLf+UbybXCkN/HDhp3F65I4jixY2uK0Z1Y4clAy4P/xfetFOexo=;
Received: by smtp17.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pb6eV-001tiu-8A; Sun, 12 Mar 2023 00:21:19 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        danila@jiaxyga.com
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add SM7150 pinctrl binding
Date:   Sun, 12 Mar 2023 00:21:13 +0300
Message-Id: <20230311212114.108870-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230311212114.108870-1-danila@jiaxyga.com>
References: <20230311212114.108870-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp17.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9BCEC41593EBD83576FA8562510AE13CA6D4ABF869C94C230182A05F53808504027764881E8CC549D68BF1CB958650AE861105DAA6C71BAE0617A87B2DD5C25AB
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B96787714ECCE2DBEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379F6495389D012EA98638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8B43A700F333CE5F90B51F4520A6D2EE2117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC59F0E22272DBA2DBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735204B6963042765DA4BF04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEFAD5A440E159F97D452896749CDDA0A6D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE31DAA61796BF5227B2D242C3BD2E3F4C6C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C2FFDA4F57982C5F42E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FD2A95C73FD1EFF4535872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5165EA9199965AC4A5B2740467A995743A13185AF877A31EE4EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34806D3522FB05EB395A21EFB13B1DC3D4FEDDA6475EF484AFD1CA49E73CE04563CF6072D5B5B7C84D1D7E09C32AA3244C3EBC642E8F0B41DD52266DD90ACCAF47A90944CA99CF22E3C2E5D8217768D59A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEg2t1XEOuWHLQag83ofuJA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498116D2F3E63D051AB5B62A94EF3A8759D50FF161D18A8DF111643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding Documentation details for Qualcomm SM7150
TLMM device

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../bindings/pinctrl/qcom,sm7150-tlmm.yaml    | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml
new file mode 100644
index 000000000000..a57d44efe5bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm7150-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM7150 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Danila Tikhonov <danila@jiaxyga.com>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SM7150 SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm7150-tlmm
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: west
+      - const: north
+      - const: south
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+  "#interrupt-cells": true
+  gpio-controller: true
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 60
+
+  gpio-line-names:
+    maxItems: 119
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sm7150-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sm7150-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sm7150-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-8])$"
+            - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk,
+                      sdc2_cmd, sdc2_data, ufs_reset ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, adsp_ext, agera_pll, aoss_cti, atest_char, atest_tsens,
+                atest_tsens2, atest_usb1, atest_usb2, cam_mclk, cci_async,
+                cci_i2c, cci_timer0, cci_timer1, cci_timer2, cci_timer3,
+                cci_timer4, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1, ddr_pxi2,
+                ddr_pxi3, edp_hot, edp_lcd, gcc_gp1, gcc_gp2, gcc_gp3, gp_pdm0,
+                gp_pdm1, gp_pdm2, gps_tx, jitter_bist, ldo_en, ldo_update,
+                m_voc, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
+                mdp_vsync3, mss_lte, nav_pps_in, nav_pps_out, pa_indicator,
+                pci_e, phase_flag, pll_bist, pll_bypassnl, pll_reset, pri_mi2s,
+                pri_mi2s_ws, prng_rosc, qdss, qdss_cti, qlink_enable,
+                qlink_request, qua_mi2s, qup00, qup01, qup02, qup03, qup04,
+                qup10, qup11, qup12, qup13, qup14, qup15, sd_write, sdc40,
+                sdc41, sdc42, sdc43, sdc4_clk, sdc4_cmd, sec_mi2s, ter_mi2s,
+                tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tsif1_clk, tsif1_data,
+                tsif1_en, tsif1_error, tsif1_sync, tsif2_clk, tsif2_data,
+                tsif2_en, tsif2_error, tsif2_sync, uim1_clk, uim1_data,
+                uim1_present, uim1_reset, uim2_clk, uim2_data, uim2_present,
+                uim2_reset, uim_batt, usb_phy, vfr_1, vsense_trigger,
+                wlan1_adc0, wlan1_adc1, wlan2_adc0, wlan2_adc1, wsa_clk,
+                wsa_data ]
+
+      bias-pull-down: true
+      bias-pull-up: true
+      bias-disable: true
+      drive-strength: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tlmm: pinctrl@3500000 {
+        compatible = "qcom,sm7150-tlmm";
+        reg = <0x03500000 0x300000>,
+              <0x03900000 0x300000>,
+              <0x03d00000 0x300000>;
+        reg-names = "west", "north", "south";
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-ranges = <&tlmm 0 0 120>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        wakeup-parent = <&pdc>;
+
+        gpio-wo-state {
+            pins = "gpio1";
+            function = "gpio";
+        };
+
+        uart-w-state {
+            rx-pins {
+                pins = "gpio44";
+                function = "qup12";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio45";
+                function = "qup12";
+                bias-disable;
+            };
+        };
+    };
+...
-- 
2.39.2

