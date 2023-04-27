Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8414A6F0F15
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbjD0XgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344308AbjD0XgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:36:11 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0559273B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682638566; bh=Eyax2bKePMQ2l+ilv5VKF3wXpgbhV5+aqNkVo61NHn0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=R3C8m8nezvdXpCtLNyDtVpCy+btvFGmO9kA4FtkrMyhbGJWtlnSvjTfmK/5P7DnxzLgaTuH7aDtWTWnSG/80bYowH0PS1/m5b5QO4ximUSxdtR8vmp136B6LJXNlUrfLKK1eIIX+5SIdv9DpTivgiASvtcIauZy13VLPKLTtbX2/4WlQ1k9+KoVTTJElW7gNEVlA3sx2cUQgqmlBnVFnSGPSaoDNZli8KQTwPy9qcFC0DG1SPWCprxgUcy+elfYO2sR2sYRadRNjTiLoOPUWW2V96hgkqqMZfIG3EpmpV/CFdKIkKHagqcnv04xdiVV1KIQoxSxDMsamD18SF7P90A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682638566; bh=+WQH72n4J6AInZ2KIrKpj3gM3CbWQ64ag+uXlbnsm5H=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mEwmmvKx45rZ/C8VSice7L+lJkOtEFTIZkeurzruV5Rwc0dgUzBi67mVgo8x54In1PGH6b9d1xj5EN+D+HMnFFPJEWg+It/KKgbVE5+TzsfHaKUcJ8xtmJHzIzLwnF7ND6SSdc+pnq1Mlp5ylZgZUqqKtWrH4uwwT7MZ7l/IkGOItbCORtFgFbFTTHDYu1wP5de4R2RDJ9JeVoPiRvbObLxpYEXMW4B7iMCUot77Xv5lViKye7hzUyZytQ0Vi+JHvkOJfX5nhugiXLDrTuBPcR73vsMiOmlcr05Bcomoe6ivc66etpfygwZg9iGcP678Lxz/PbWxnhTyax22RMirkQ==
X-YMail-OSG: Prn9KpQVM1kIkUCe_1gXUjPEfUgBQylRwXI8Gm5YkyC2K2D_oWsyOUY3NmIX8_6
 EtezlFjzi0H0iBU4XrApA2a.k4_RujwI8Z4qL4nLBnN.Dw2WpzXhzOaJuOLikAFmCGQxh_KyByxo
 mmGc1utHaXkK3UbQXs.Jowb55YSchw3qmPszQG5kY2mrfBwKhtGyO0VLOEhnvQ3ZHkGRVSHFksNs
 l0Memw9B8aGDMHGhpEOxzh2IdKoMtylrP.XlVOu66zLfL87Gd96u7iH2OliRHQpqHsQPBWa4g_.r
 INXph9c9clGMWNJJbs_PMPoTh9Va6doLEOUCHBecgxL_QXH4ZssqaN51U4LF569dz7pMZgmqwYmg
 TewTHXD9xHAuaIBQRPQgxaXEqqB1M_Q1gdBVohKl7vhL.AdezWs.pCElnRaMShqZe7_qE.Je_ATM
 jWzOeBeEc0jU93oFblEmlo2SJpWUas_mgecp64GTIcTFKxaKT5dwHru2GlAkIinN4YlDVlDXw41K
 uFwcls1hVIZtMdef8kiCKtTycWwS256u5fUxDuwt6mAPDTbUQLCdeMay9xjDOF8lPAFVZlgXaWPh
 uqr.vkNN7Oi6FGIL0YbEONwP153kyBfvOcdSwYOgmt2ClnfSnzCAJ7GcaHb6HtnO7EjKWsBUGM.H
 a9o6vmVsAZVmfP9q6gIWwrZbfQHWotX6T5IxWVnFVpn_KQchFa9urPsDP80jDAHAkpvKvM2oGmSx
 Z9dd443Lz2cbEHbrhs4Fogy5Olcvq.jRdjMf8BJogCHLU4BGCN9qDkIQawLrn3MoeK2Ie4GYnReZ
 4PkNQx3CfFsmMymDM2R56rkdNf6ebWCoPbkXRpskCosenuUVH7_I7L6eLwAyLnZowsoK0Eb7UJPJ
 kP39KlUF6qtXu69iZj21wZQQ9CMLGVEkRvrLKn5cTOSBAs_SEzkmfutwZNXh.JEOR78q7U3.E.M.
 KWEqQzgftHzqft5igAX_bWAdA5WfjSZzvbgUR9uxwM60Gcr034nQte1td1bCWKyiFv9mrlHNoI4I
 mBHKB_.QyhFDCDlOtef5aY9_ydOggPLq50ChY.lTbH6skLoACiVW7MzZmCqhS3MCpGCBuayDkI9J
 j_16zVd0f8KiRuiL7wjipAJ0WG6RIxFjML1yoOzf5zhqg7mEwiKIJ8kfd5ExteiToo5JplOjdhvk
 j8cnS4UxJDJJrJG0kEn4H2FPXXKJPywTppEzx0j19Cl9OpBaPdlZt0ArEGhYtl1dyPtPh14OpA6K
 13gG5UlXkBmzvQ5Kme190ftdr3ZUg5uzvAs61vciK8yzgMNvO2BLanazdUcLftBMdEcZOeAYcD1.
 LK0rwkMrSkpPvilpMInkZJFAKUfkfLPfGH2Ac4kPaQH3P_3Eda64.EIUNJvue23AIEogPcOOJfFQ
 zQfgYckkfd.pRezOdBkiynablrElQVFZI30ACzDQ518a37Ong3a.Kf4HFBwKRRB96KGgB0SzN3WN
 p9moUWva2MJ8QIIvhi5C8XDkn5sL7GJRS9M_d_uy4VrD3vb2POOJKj1Hhq44qoIJjh4f7.HGJTBh
 BgzRXX6zlWjTDnnoenGs.O2McUPC6AukI24.v0W09dmOxTcfGYMnhP.YsSN1zo2NGVa3mzdi23LJ
 2Iu8QcCHNfeb0sk5UZT3AUGrw3udnEJKT6rlW6tLQQj.IK7jW.Oy7e7CzjohuXTTDZVBvceKRVFS
 vYfdxNFwlZS.kSUVSFe0nx2OYpFCuCAx5sbB_VquMMYYHblAFDPR_mk_YMBl209Ddp8D7xMPGl4h
 AdnmWNZq0nY120hhTgm5hl_2sHcWylkaVRM4f6WY_upb_TPVvK6t7rwkiEAEtyn3hkaA4.bvfaR0
 9d7Mzq5fKDnC5bQBwQ4dhL470El2w2WxjgXylbu03L6pIpH5PPPBrWUPEUZE0bsZ8wJBXDBsTtnU
 6S5AxWo03TfZGGe.p_N44NkYlfsuMCwbUd.n0M8RT_Zfnw5JsXkcsZJLGzsBGiAYWzHdxvWy8azl
 4o7zkZsVm1aWu4PjGY8oiqwVjg2qw_mmgUXryIoYc6m5lJPvNaSak_dISwDUXV_wzXBwCZuMHbog
 OtZFyEQT2FEM8O5mwzdt646R4.AKqH2I9.Ii2TD6IZfDyeqNWX3AIUyKsnGwLEcfkpcIxBH.espS
 DPpbZ.9RC3hjwmCjVR_ri43BnELBcPxBIrjdLQJYW1pCI6VVNeL1qi8sWbNNCGdJx46RDBBnLf7n
 DRSVM33Ay9mAbaqMJBeXBTtAv_yPYZDIbFZ4n_hGqhls3UPgPysUBzvjALWyAJbbyGgAWQd9fG0O
 4k.gr0sDQIGea0tDGEtzPjuDuH3O8dw--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 6d200f06-61ac-4d49-9de7-a5f911c864e1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Thu, 27 Apr 2023 23:36:06 +0000
Received: by hermes--production-ir2-74cd8fc864-d5c78 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b559be960ee93a958c6ba15207aea559;
          Thu, 27 Apr 2023 23:36:04 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
Date:   Fri, 28 Apr 2023 01:30:11 +0200
Message-Id: <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682636929.git.jahau@rocketmail.com>
References: <cover.1682636929.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
The patch is based on next-20230413.

The drivers for rt5033 (mfd) and rt5033-regulator are existing. Whereas the
the driver rt5033-charger is new in this patchset.

The extcon phandle is still there, as I didn't know what Rob meant by
"standard connector bindings".

Changes in v3:
 - Removed redundant "documentation" in the commit title.
 - Squashed regulator into the mfd binding.
 - Restored the regulator node names to uppercase because it is an existing
   driver.
 - In the charger binding replaced the vendor properties by "battery" node
   style. Accodringly updated the example in the mfd.

 .../bindings/mfd/richtek,rt5033.yaml          | 105 ++++++++++++++++++
 .../power/supply/richtek,rt5033-charger.yaml  |  63 +++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
new file mode 100644
index 000000000000..ee704914201f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
@@ -0,0 +1,105 @@
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@34 {
+            compatible = "richtek,rt5033";
+            reg = <0x34>;
+
+            interrupt-parent = <&msmgpio>;
+            interrupts = <62 IRQ_TYPE_EDGE_FALLING>;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&pmic_int_default>;
+
+            regulators {
+                safe_ldo_reg: SAFE_LDO {
+                    regulator-name = "SAFE_LDO";
+                    regulator-min-microvolt = <4900000>;
+                    regulator-max-microvolt = <4900000>;
+                    regulator-always-on;
+                };
+                ldo_reg: LDO {
+                    regulator-name = "LDO";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                };
+                buck_reg: BUCK {
+                    regulator-name = "BUCK";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                };
+            };
+
+            charger {
+                compatible = "richtek,rt5033-charger";
+                monitored-battery = <&battery>;
+                extcon = <&muic>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
new file mode 100644
index 000000000000..bf08e8db365e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt5033-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5033 PIMC Battery Charger
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
+  extcon:
+    description:
+      Phandle to the extcon device.
+    maxItems: 1
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
+        extcon = <&muic>;
+    };
-- 
2.39.2

