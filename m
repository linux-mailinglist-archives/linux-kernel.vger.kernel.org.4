Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4466E3866
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjDPMum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjDPMui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:50:38 -0400
Received: from sonic311-30.consmr.mail.ir2.yahoo.com (sonic311-30.consmr.mail.ir2.yahoo.com [77.238.176.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74CD269E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681649435; bh=ry1wdbINkSV09xVX5t7wSbuuNoW3ImeInKe2pM61If4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Booa5Zq1c31RmSx4IxxAajr8qh23zdTe5Ey891xiJtQh6vvKujBID6m/nwGVBp3oTx2ZvncDPt7EytughQAevY/NPfuG04SwkPJ1xjT0lPX0jz8tsx7yxyxKVEdaoy2oactEO/3AxEShWMVdaIz3X0PrFS10spLuhYrb1BdKp8y8gl6YeWKxFP2oiApEPuQqMjcukVEjLn0YD6hgSywRqI8c35hG15Pu2At1Jpt5Ft3hiNp7X1+0hoDd/vlbEszAj0nOoGwT40eb+I+ftIsGhj8229hY+vT3jhHpobJxzLxQF/4SoPkkoK2fV5zTvP6VMa6f67Y6xKgHGBaXfnW2og==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681649435; bh=JZsoKNWI4cnMSZae9t0cYKAZRwaD4i8FPqcyhb7fhe8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qhYCbiqTlJl0EVUw5QtXfyq3xB1g7qlKJn9qMVZZFw3+9erKrFLXi/e4Fxj7hMgRctMKhLivc590+iC24248OpnUFXK9x6tsPbMg5PmdbM9zKoM8cRrT9vfMk2YJrdpIlDI449hhogoH4vfz/vq5NtffYANtmNpuYVhct4eXoOfheA1LJmN57cUvlJ0Ov9EP2CzC2LPacFEdE4Pn4bkHAsP2HpxDLAhIhovN31Mni9iWob2w7PkoCvZ2cUgn/Q8pmluRhYiHlkqefF7/TjwO+LUVNEtzXxVJhloC8qsYCvMxdRG9kl1ThqcNLdrghf3wO2HHxwS/1tqN6CKeGcgQ8A==
X-YMail-OSG: uMj2UUMVM1m1Tq3bH_fanHXbh4FRSZokE4.ULpVOdVqKRY6KvKvxK5WbH6bq_7_
 BTvg2X9aIpDmsbftx2MT9TWJHtPmw6NaTSXapsrjuyTOXkgN3EzrzN5TQcwwAyyKI_LVFwPOGOo3
 lFcvWI_cZ.P0J2dCn.r221JdtWuBeUQiFEM1sXgoBOqC72PcCzepVDzIT9GG9IaqqNsOfq89g5RZ
 Lw0Vwfan.iVyqg5GieuzyUsLrmIsHgIpKq3a7vuXaRsXznXmxLcmLdZtv.p3YYB2h0YtFUDD4fta
 a7MusQK5uKkMCSJsgGPg69Nk1eLx0AEpOGsg0Pg5_LVXXh7o62hBvwLKfAq3la4V31wnXupFQCkR
 lqb4ATZ80.Ecgp8HqjbeTyLyNrhko7dADnGAfn7.n.gKgn57YTArKF1dLLsCSqnf7EWgWED5_ZmW
 y_gitdkvrr944L2emy8WagLycalRNz8hJ_P6Vp2uKrACV6TpUWGF.IxuZSz1cjnA1yNrt06eJBVf
 IJc6ZWlYc79jz03fKcciqNGdlPxwF3k21NRQ6Z79S3cuWKuUxVZNe7xeb.c7BWiFTJypFgwjKaLt
 NrRb6646CtswMxSSnRzJcXhatMxoRt7L1p.frmrjOcGCZY7KvnPbdbTBMc6MNlnzFBYvzWkj6LKg
 GO7JfnOyU2HNXZwNzaxi.wgYq0xlRRT5uS_rODnYEiUM6tJvaHc2F1yXK5EQSE6q0_oVbxFWoSRB
 Mx9TAxQhPS08w1rUL6x_t15dUk1TS6_LKpFTH3efSsYBzvpauMu4zAzUp6lmagQm1oXFC_o.LNs3
 LBBjy9aU7USIrYk0NT2VhDkIWpPAWmLT26XpPCVE0rl4t3wj9jHXjimWpJZIaiaz2XV47dba_LPS
 xuyrUqkAeZFeIIETa8X5NrdCgLKjB4pbALGPbEGM62fU5JD17aUqyS6GeAkswbr0NQ.ldARVwDS6
 if96jml3JbWm6Fxc41ONCyot0hWyL1vmGmo_AmtzLnjFequSKv1VFc.G2e4iww0.v0ZlhTIdLwV6
 Svq1s2DxQzENOy5vpEGgUBo5ytHQ3d4ei5.qacx8ONPO6nRw_1TDCcJUrmbXCDNyXRPDOKR41euw
 FPCT_bCvv2yBf7njmneXx8rcMmNg_lkxGtPHRTe3RZ_J6JlN_oC8fPdsejwjnQce1x9ZlaTjJ2Nj
 hKUjEACgRT5VBEJdOEzWmq.7qjUIPcc46sBxail_4ePgoqjobSCfFkdOZIK.CfRgelbHWB3zLtvL
 oFjHXvyQhSDmLYvVcRAidiaBy5pb.DvClP71N1CMcdPG5U02.l7Fe62RblDVRWEUnhStz4PYb_Ja
 anBgBE_gD_TvdNVfbjXHGhezgagoKYpnF0ycYqqlHF6jWKsDp_hxVYpdA76jimNaxR_TBfRp1vUW
 3Ut5fvAhdHiwsjddorYqLp1AuLSo5u9fuDScvTmpmwe0L1TrlRyXSuEfsbo94Ob5QBZLGVONmQ12
 T5ZgAu9M7WIY9QKJHTVZ_C9d5GoyO.ySW5Ti7CCW5_lRRDIReY5F2.hj1CGwzq08Q.4hRDZ6nhNC
 2N7ALIbQ1kZw6cgHcbTPRD.y.G3Ws1Vus.h96xtNo5KwRIZCeLTmrQsSBqZwzPIQUhruI7ig7R1C
 z_A4K8bQjhvP5dKhPIHFoOjmNRk7lSCp76sCxuztqPeiuY4WUB5fYOhxGVDfyUxSqlqubBgqUPo5
 MaJ1T1CkbcAbk8EDdiAZRriaP_mxNfObNrBfGBLDDlh3EPWzJ01aRl_2uicDsY8S12q1O.lZwlFz
 71otxDUs0sdfathHEBHvDqnnm7Z7sAFnqr73sNuQaIum3bZuuEWm4Z7wEPQKUL.b6ZUVBNykpdfz
 w.kPKMUIMZMOOGgEl2MQ.YnutK2skxh9REancbLR8yumMrub0qClQmR3Mr7AD4El7C4F49KxAvce
 7NGOPb653JbcHyO6IpCZVb79VFMU1RvHZFPCDe2p0ll1ge236Jxyh.kOvDlH03AVdwjG0QXRtYkl
 C8JbcwhHADeFlD.2MqiBeTVaetrHo_tRbbRrwcmWpYhabWpPsKser6EcFF8oLeFbBzpVI.616tDN
 y5.e2281.JTq2a5MpA3frgpdyb9ky9WF_nV6ec3.X7LDJbahmGjwrxlV9FOOA3DBQhX42ZbBMcv4
 b8bOURSOU2oen8Hvsy7Hycmeikl2kv98LH3laSAUAJNqYGqdX8q17ns_jUxCeWsmb0qiNatWctM6
 LVZK2DMECP8.mDmsI7pUFCqjpXeosAhFsjoXPUMOWuvDiz..sCPnUziN9vD2QVSO5J18GwlKAFJC
 ct93pLndcPmJ4Fnv5rlTQa0knerfSuFDKVKM2uA5WKLVZ6EsVSV3oBw--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: c8ccb835-27b9-4f7b-a2f5-b718b209afcc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Apr 2023 12:50:35 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e1e6b4a18b1a30b9efb33afa6a04eb6c;
          Sun, 16 Apr 2023 12:50:34 +0000 (UTC)
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
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 9/9] dt-bindings: Add documentation for rt5033 mfd, regulator and charger
Date:   Sun, 16 Apr 2023 14:44:36 +0200
Message-Id: <9275af790e6e21b5cf661a2444effe4caf2be02e.1681646904.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681646904.git.jahau@rocketmail.com>
References: <cover.1681646904.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
The patch is based on linux-next (tag "next-20230413").

 .../bindings/mfd/richtek,rt5033.yaml          | 90 +++++++++++++++++++
 .../power/supply/richtek,rt5033-charger.yaml  | 76 ++++++++++++++++
 .../regulator/richtek,rt5033-regulator.yaml   | 24 +++++
 3 files changed, 190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
new file mode 100644
index 000000000000..158036a57291
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
@@ -0,0 +1,90 @@
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
+    type: object
+    $ref: /schemas/regulator/richtek,rt5033-regulator.yaml#
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
+                safe_ldo_reg: safe_ldo {
+                    regulator-name = "safe_ldo";
+                    regulator-min-microvolt = <4900000>;
+                    regulator-max-microvolt = <4900000>;
+                    regulator-always-on;
+                };
+                ldo_reg: ldo {
+                    regulator-name = "ldo";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                };
+                buck_reg: buck {
+                    regulator-name = "buck";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                };
+            };
+
+            charger {
+                compatible = "richtek,rt5033-charger";
+                richtek,pre-microamp = <450000>;
+                richtek,fast-microamp = <1000000>;
+                richtek,eoc-microamp = <150000>;
+                richtek,pre-threshold-microvolt = <3500000>;
+                richtek,const-microvolt = <4350000>;
+                extcon = <&muic>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
new file mode 100644
index 000000000000..439e0b7962f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
@@ -0,0 +1,76 @@
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
+  richtek,pre-microamp:
+    description:
+      Current of pre-charge mode. The pre-charge current levels are 350 mA to
+      650 mA programmed by I2C per 100 mA.
+    maxItems: 1
+
+  richtek,fast-microamp:
+    description:
+      Current of fast-charge mode. The fast-charge current levels are 700 mA
+      to 2000 mA programmed by I2C per 100 mA.
+    maxItems: 1
+
+  richtek,eoc-microamp:
+    description:
+      This property is end of charge current. Its level ranges from 150 mA to
+      600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and 600 mA
+      in 100 mA steps.
+    maxItems: 1
+
+  richtek,pre-threshold-microvolt:
+    description:
+      Voltage of pre-charge mode. If the battery voltage is below the pre-charge
+      threshold voltage, the charger is in pre-charge mode with pre-charge current.
+      Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
+    maxItems: 1
+
+  richtek,const-microvolt:
+    description:
+      Battery regulation voltage of constant voltage mode. This voltage levels from
+      3.65 V to 4.4 V by I2C per 0.025 V.
+    maxItems: 1
+
+  extcon:
+    description:
+      Phandle to the extcon device.
+    maxItems: 1
+
+required:
+  - richtek,pre-microamp
+  - richtek,fast-microamp
+  - richtek,eoc-microamp
+  - richtek,pre-threshold-microvolt
+  - richtek,const-microvolt
+
+additionalProperties: false
+
+examples:
+  - |
+    charger {
+        compatible = "richtek,rt5033-charger";
+        richtek,pre-microamp = <450000>;
+        richtek,fast-microamp = <1000000>;
+        richtek,eoc-microamp = <150000>;
+        richtek,pre-threshold-microvolt = <3500000>;
+        richtek,const-microvolt = <4350000>;
+        extcon = <&muic>;
+    };
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
new file mode 100644
index 000000000000..66c8a0692e10
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt5033-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5033 PIMC Voltage Regulator
+
+maintainers:
+  - Jakob Hauser <jahau@rocketmail.com>
+
+description:
+  The regulators of RT5033 have to be instantiated under a sub-node named
+  "regulators". For "safe_ldo" voltage there is only one value of 4.9 V. "ldo"
+  voltage ranges from 1.2 V to 3.0 V in 0.1 V steps. "buck" voltage ranges from
+  1.0 V to 3.0 V in 0.1 V steps.
+
+patternProperties:
+  "^(safe_ldo|ldo|buck)$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+additionalProperties: false
-- 
2.39.2

