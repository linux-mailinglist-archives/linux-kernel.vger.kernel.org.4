Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C97703E81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245371AbjEOUTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245301AbjEOUSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:18:43 -0400
Received: from sonic310-11.consmr.mail.ir2.yahoo.com (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B3A132AB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181881; bh=PH47Hq7/S8NqOww8hP8w5e2nE3GA6cTmgI+LCsNt/lw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ahosl3irSEK+8Yf3ViIDOkJZzaodMbFpi6Tw52duT/T4UfvZmP3iH6qwbZNnaOXoySbEgSp8BaDN95BXIjmS7aw4j5oHcX6Ap1X0nEVlnbmzmayPY9ieDRVWINDXDfLH/AWsTDNTSuSVzU7ZPW0bAB8EsT2dn/w7aX41+NlEeJTZ3sV4ZnXvTWNcWpCc7IPZper819MX8mPMacsWjIeCZ6N0vfPVKP2Z0U1whPS7RW+Mk6PD9ptPyzClslJDjxQBvPecljoYLQVit3gSSi1Hw6r+PtwbSyDpkjKYgiJzD6I5GBx2/n2aerpqZDFFHrZ7voeSA2IJ0UhB1YEA5+jfFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181881; bh=0Plgg6qWOoVkz/yqfdS4d7tWO1+QOLo8jFpFZC+Z5rb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pT3dmhoKENHVlGsrHcqnJhfJ9fgBFaNWq5ePvGd3P246/gcv29xnZRn6sd8fq7N16hiTb2wsvLkOwFUirrporqnJmr8eSf5Rxy68sbXJRfoxV/JpRo/g3lHYgYg8gncdHvkA0SJgeF7Jq+2JBRtJobSsQ4h/iWY0Ue3Xjim3x7jKa6YDTbRkgU/ta+hx8DP1cFTW3QUaObMFBXeJl6tQIjpNbt7+LSVdlehA9rNj0EJLeN7MCzcEaqKWBG+ziXThHlEr/hvKRHLBgbT7b3RBurdJpyGGPlpewlGtl3ndOVrW1zrQ/lJx2ZowmEZcBlJHplKIvInSc1bXRl0duWC74Q==
X-YMail-OSG: SAgfoq0VM1kwQM1Mef7SRjqJn87QzRWzX_Yxbq780VUSrE33UeDp9.nG0YzQ39a
 rpaJVBA8tjqQT_d5k2HtMtBdwEFcqwnCFapa0rGvivM0RoV_bgL4UOsA70GZ1k5b99qn2ZtqGUkF
 v.e7GsIdQd2WHE2FymewxAdzT3zoINtC_eFtvnm9DIQxmqJaCHUISZMIs9oqC5cznfBs.pA.fCwQ
 2uFc49EzYHBu7Y2pyTdJ_O7132owUb6nl4l1U6UHBNpBQpZJIRwzxSF3CDsc9amLT76x02grkuFj
 ykK23NwAbKSff3Y4FegxR5LW_AhguDk2aXvHsVvl3ShmmufTj8L8nx98pEIOKLGNQtKI__BcaqUy
 Hkbd9.Smzv.KVySa6cdnWEQDB3WlyszuFERxYLqtZh9n5VTwkeZSvduu.bMVxEmiu7vKs9r9o6zv
 9Ga.VwMqV_MybnULWNvqrIPqUoi9S_IcJ3nsQiDBkZZTc2wbV5rGCg_CRkiJ_My0VPiSw5Seu5a9
 XM_goEgmaBgtqDdp3H0F3dQp3cRpeOUvMrEPoioOBIVBVxbJtvceA5ssbzSzeO95PZbVqaymGPOe
 LqeyBO6gi0qguO9wwpuAWK7sb8I1Ilru0oA8qBWrrJ1bInfZgRjae9NUNk0wITN3L4Eh6c5uFKO9
 F3tKA5oHXIVL0W19MoPY1qg7yQvZ6FmLrdYLHlETPlBP4uOPY7RXpwP4YotgriAAWhsEkBnmiaCY
 nPlMN1xGuN8rv7isxpVzYSYnBO_spNNj7Pcc..q9Mbvwx9vzpvtTHTiNXcRWisyOK9SxD7_F_fi1
 n7VF4kXIMMJL4cVbZ2VvMbVjV18_r0QABiVZlP9TPBsPANzLpGj2m.OHW8CKTeB7lUyt3uJ22wIy
 g.SG39uLuzTVgcYPXcmO75X.F2WM92wvI6o1ZyArWkLT2NMPMUfFHpp8paPJapcFzFnDJPFHCcL0
 R6PTyvPDDTfxryuUbgIMxRD123C8r1qivIurs7VAm7Kba92Pt0QE0eGjAyzElCAHmenx9E0RMebY
 I0jLqFpZHrdNBsDkDzH776nlbUIwUMv5wzyJGXbTym.ADCW5QXIIMkYXOckFY0mO8N_ht9Avwo6X
 NFNz.9f8EJn5jv1MgKnu7qASe4xgJ6YClabQyUvWGDewJkjNP13iBa5jAkjNeWPOIROq4nrdGHxA
 E5STaTWRW3AocL3iJlxKc3k0cxH_nF6ROXRzHtXhq3eU.F2DLqv86mZTb5wFMqdCjePwY7NRS1Yh
 SkNBKpQXBdrvQwi.z65Y8OZ1E8LFprlA2s8HDYce1iX4wsK_zyu8MOGxL7rhnp8D5CARSjrgSR_P
 jP0KaKPA4gs7_SPY4PmSItSph2V7.pnH2CrIPB0FMwPUlMRUQe2w_3Kb1FnhuY9NRvUBgFcPfI_f
 DzacYl4g7yOtRHp1Hj4OYC3gY2cRNWlC_YC0xjnXJWaClceGhY3BqU5Jt95Z50j3GYRdaKmWZoVw
 _TrNONIzx6MUpnNZDWh0cUl5GEAbXqP1SoXZ0QtwK5Crqb5l_MsOlyzn1q34SgsS_t0Bc5bG6.kR
 pe5DvPnYKvrqUPP_4JOyNTfloNIbd8QsMuuWmxfV1cyMVjPI0unkHKe6HC9CJ7YPzNYuqwA80amM
 FdlkiGrF1BdZPcRcJ1ex14V1QOvOI3NURMctr1jxsPlC4AfrnAsu8GxmbM7Yu7.XLacxQJ9PsnnC
 F.zIWzz4TngnGCheeZA4991rqRipSo6YmSKzGMqe7HjeEHZQrDx9oWXYcw_hxVGzegRu1_pMr0O6
 tXnp8b01ZucsBUZvJCRlGsDJlM.SMBJlSPWCYDQ3ofbjWIPiftTVk0xFDR2IbGI_TUx74IFfPRy1
 pbtskOGzeYa59tbD6aXVPFZV590mbUKn0vj8aZn3_yy5PFAIy608c701TB1LfhmQiQH5n7oYQeAC
 jqX9bh7RHmWYmOnNBxG_zleTIxr8QZKmDafGSu2gl7rwPSJ87DhV_rk5OuZ5qzFNk_AYJFNfESBR
 O_i18dt9.llXQN6FolTFZzWQ8BC9ZpCRxH.yEE1r34.rUVZ37_2_yNN6b4MItpeaz.oyP5O1BxWz
 X_XAFhidJFjKx2Z2T1LsLatXUauE0WpD1EFKJCXJnK7U77tHzVeotxu089IWUblQAxWxGBXTFj7M
 me2YL2C6ue_wQ6VXbwhbQNz.EC0IlqH.OLhRnQjdnfJbUZZTraYn1GVsmJMXDjHiUkPswQfVzdOr
 50ptj1q5yhTDQdirdqkEsUUFn9GGtIL9Y0UwkK_ex9H_YPGgsUmTq6_iiKRZo3wi.cO16y0SZ.wR
 7OIdrrq5wJEFCU1r2XyQriUwif1p1
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 80f32848-3f08-4cf1-8e5e-ad35d3e9bc3e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:18:01 +0000
Received: by hermes--production-ir2-7867f454fc-8nkq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cb456a1ee9275492b492c35f2e11856e;
          Mon, 15 May 2023 20:17:56 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 10/10] dt-bindings: Add rt5033 mfd, regulator and charger
Date:   Mon, 15 May 2023 22:17:12 +0200
Message-Id: <20230515201712.30124-11-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201712.30124-7-jahau@rocketmail.com>
References: <20230515201712.30124-7-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding documentation for rt5033 multifunction device, voltage
regulator and battery charger.

Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mfd/richtek,rt5033.yaml          | 138 ++++++++++++++++++
 .../power/supply/richtek,rt5033-charger.yaml  |  65 +++++++++
 2 files changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
new file mode 100644
index 000000000000..386b1a50158a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/richtek,rt5033.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5033 Power Management Integrated Circuit
+
+maintainers:
+  - Jakob Hauser <jahau@rocketmail.com>
+
+description:
+  RT5033 is a multifunction device which includes battery charger, fuel gauge,
+  flash LED current source, LDO and synchronous Buck converter for portable
+  applications. It is interfaced to host controller using I2C interface. The
+  battery fuel gauge uses a separate I2C bus.
+
+properties:
+  compatible:
+    const: richtek,rt5033
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    description:
+      The regulators of RT5033 have to be instantiated under a sub-node named
+      "regulators". For SAFE_LDO voltage there is only one value of 4.9 V. LDO
+      voltage ranges from 1.2 V to 3.0 V in 0.1 V steps. BUCK voltage ranges
+      from 1.0 V to 3.0 V in 0.1 V steps.
+    type: object
+    patternProperties:
+      "^(SAFE_LDO|LDO|BUCK)$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+    additionalProperties: false
+
+  charger:
+    type: object
+    $ref: /schemas/power/supply/richtek,rt5033-charger.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    battery: battery {
+        compatible = "simple-battery";
+        precharge-current-microamp = <450000>;
+        constant-charge-current-max-microamp = <1000000>;
+        charge-term-current-microamp = <150000>;
+        precharge-upper-limit-microvolt = <3500000>;
+        constant-charge-voltage-max-microvolt = <4350000>;
+    };
+
+    extcon {
+        usb_con: connector {
+            compatible = "usb-b-connector";
+            label = "micro-USB";
+            type = "micro";
+        };
+    };
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0>;
+
+            fuel-gauge@35 {
+                compatible = "richtek,rt5033-battery";
+                reg = <0x35>;
+
+                interrupt-parent = <&msmgpio>;
+                interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
+
+                pinctrl-names = "default";
+                pinctrl-0 = <&fg_alert_default>;
+
+                power-supplies = <&rt5033_charger>;
+            };
+        };
+
+        i2c@1 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <1>;
+
+            pmic@34 {
+                compatible = "richtek,rt5033";
+                reg = <0x34>;
+
+                interrupt-parent = <&msmgpio>;
+                interrupts = <62 IRQ_TYPE_EDGE_FALLING>;
+
+                pinctrl-names = "default";
+                pinctrl-0 = <&pmic_int_default>;
+
+                regulators {
+                    safe_ldo_reg: SAFE_LDO {
+                        regulator-name = "SAFE_LDO";
+                        regulator-min-microvolt = <4900000>;
+                        regulator-max-microvolt = <4900000>;
+                        regulator-always-on;
+                    };
+                    ldo_reg: LDO {
+                        regulator-name = "LDO";
+                        regulator-min-microvolt = <2800000>;
+                        regulator-max-microvolt = <2800000>;
+                    };
+                    buck_reg: BUCK {
+                        regulator-name = "BUCK";
+                        regulator-min-microvolt = <1200000>;
+                        regulator-max-microvolt = <1200000>;
+                    };
+                };
+
+                rt5033_charger: charger {
+                    compatible = "richtek,rt5033-charger";
+                    monitored-battery = <&battery>;
+                    richtek,usb-connector = <&usb_con>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
new file mode 100644
index 000000000000..5b3edd79a523
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt5033-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5033 PMIC Battery Charger
+
+maintainers:
+  - Jakob Hauser <jahau@rocketmail.com>
+
+description:
+  The battery charger of the multifunction device RT5033 has to be instantiated
+  under sub-node named "charger" using the following format.
+
+properties:
+  compatible:
+    const: richtek,rt5033-charger
+
+  monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the monitored battery according to battery.yaml. The battery
+      node needs to contain five parameters.
+
+      precharge-current-microamp:
+      Current of pre-charge mode. The pre-charge current levels are 350 mA
+      to 650 mA programmed by I2C per 100 mA.
+
+      constant-charge-current-max-microamp:
+      Current of fast-charge mode. The fast-charge current levels are 700 mA
+      to 2000 mA programmed by I2C per 100 mA.
+
+      charge-term-current-microamp:
+      This property is end of charge current. Its level ranges from 150 mA
+      to 600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and
+      600 mA in 100 mA steps.
+
+      precharge-upper-limit-microvolt:
+      Voltage of pre-charge mode. If the battery voltage is below the pre-charge
+      threshold voltage, the charger is in pre-charge mode with pre-charge
+      current. Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
+
+      constant-charge-voltage-max-microvolt:
+      Battery regulation voltage of constant voltage mode. This voltage levels
+      from 3.65 V to 4.4 V by I2C per 0.025 V.
+
+  richtek,usb-connector:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to a USB connector according to usb-connector.yaml. The connector
+      should be a child of the extcon device.
+
+required:
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    charger {
+        compatible = "richtek,rt5033-charger";
+        monitored-battery = <&battery>;
+        richtek,usb-connector = <&usb_con>;
+    };
-- 
2.39.2

