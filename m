Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90564748319
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGELmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGELmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:42:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F051731
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:42:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso10251926e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688557321; x=1691149321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztBlDQIHDZqo7V/c8oOFDJdI7xBDmCnELF9YeTbIz60=;
        b=Q8tXp0mhYJzKf5i1KzTXxvIFYOyLggu5Fu4qg2b33Mimz5fUhOkQ7l6dvMoMDLrn4x
         mEfiOAI5Hnt0u2KQ2TJFFII2NLMDZp4Ph3qUq6ixyhZ4d17WAwOniuHAEF16AbG9eF7z
         WkMXWhI68Lt87wd5/MYHFN7S4oltrqjUeKGQvBsfTXdFMh2hMYktd5xqpmYiQTdAvpnn
         K0R5a8UVR39qGemYegwzZitbIDMAl+75kn6CKzZlUMzL5n5sbhTRHcex2/E661vaIP3i
         UlfcC9++L16sPmU6PTCYIHau8VHj5FarUEu2CcaiScbOgYbBsKFEIUqF0uaSP3qcglYr
         1+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557321; x=1691149321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztBlDQIHDZqo7V/c8oOFDJdI7xBDmCnELF9YeTbIz60=;
        b=az30TTLIb520L1ZjXIzGoG2F5SOTWdRm3kOAuSuaOcMPFsbMmj4DEbn3PzTSCLoFdQ
         I6WjCXIQYmPtvJvP1dyFgFxXQpw3LdnPye7FEm+OmbP3iopeSK+VYJj9sqE1UxnyGkW0
         f+QkpsBaIftWsJ2ZNvCr/PP8lrGsVXw4G0JiURXFRbf2w1P+vQhzXDSLUj5OsGFuFH7B
         4w6/p5lVIN9E56FH+vhQOAk9wwdb1dnjx3PintG3bWbWgF1GPfDLb/T0B3tcIJkWtMjV
         g4xJgVANzapdlkywOIUhGC7CXJApZtK8OL0EmVVZwW5bC079RKEh+UBCRTyPWfK+Fz0Y
         vmAw==
X-Gm-Message-State: ABy/qLax9/GF2Fuya93lOhzqPPRuNSNR/0mzamo81QE4zyQV1h6HZhDz
        O7aLb9uOLV/PbNc7q7hyKv7rP1v+JobJ2DWvzfmWOtZ1
X-Google-Smtp-Source: APBJJlFfHWocgLHVuVZbV3+nPaMumekJ4wwZv2jTSVYFQ2xEyMcAxxdjissZ09VM/5ZLW2XbfWQlbg==
X-Received: by 2002:ac2:4f14:0:b0:4f8:442c:de25 with SMTP id k20-20020ac24f14000000b004f8442cde25mr13134816lfr.5.1688557321290;
        Wed, 05 Jul 2023 04:42:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b003fb416d732csm1916808wmk.6.2023.07.05.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:42:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 05 Jul 2023 13:41:53 +0200
Subject: [PATCH v2 3/3] dt-bindings: soc: amlogic: document System Control
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-b4-amlogic-bindings-convert-take2-v2-3-22be915ddc3b@linaro.org>
References: <20230705-b4-amlogic-bindings-convert-take2-v2-0-22be915ddc3b@linaro.org>
In-Reply-To: <20230705-b4-amlogic-bindings-convert-take2-v2-0-22be915ddc3b@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5263;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lo56oO+Etmog3EY8Ab68Gwiv0DuAkQD0UTqVY8iJak8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkpVcEzTgg38yYhlrcvBrJImMVYRN+3f/3J0kcgWuW
 ZPWGsaSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKVXBAAKCRB33NvayMhJ0btUD/
 oDjPeA6DC4ldn8SQo55OJ4RbzqijHA8iJBqsNsf5BF/6fExPobnO3MpbGmbMnhygBi7vQkMqT+ORZ4
 9FNXdys90CyDsjHIOSpqciM7zmQCgt3TnStENGygchJZQpanFGQBIL2SVVcCxC5ebbccP7P11vq5NK
 6WC9jxQY7b579pwBUAdObAML7Y6dP0aC3yhlYmdTcEs6mkacmK4iZuGgXfm/IC62pztQSS6upoC/rn
 CJP+xqlF7pfIX4g/FbUuiKHgKmZLGwFq/bUCCMbJLJ3/e6xQXzg9tHk+i+1RKTSfHqonIgZjnPreYV
 +GJzrmBvQek8LE/gcQT3amCl/zgUMCBrvMyb68pfiSEsyeDhT/Sgr8psL5aOxLZ7EkzDVA60iyAt+n
 IMW4W2tnyqpWEZ2PItTRV9U/Hs2Q6tWSv/jg5LC+y4jIR0AhHE57ItVcI3zuK7FdEnfTnLhaC8AH/d
 Ou95md7fxstFAkksCXlXfJ2/jY9lMGchie+ZFZT/voRrQXEI4XUom9vbGDPlwWiLtdGWRcUeKPJUuv
 NWNk70fqkeZ8ekbziosrAn8PeRNRwVXlJ/ylbOEWXdh8KU9O53+8H/vVPWJT1PhoF24EaAoQWAd5Bx
 cwtktKCJBJCnHHZKkcBcfwqjYdvnwZRZ3oeLlOBh5si/5ULMxDbQflgIq0iA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the System Control registers regions found on all Amlogic
SoC families and it's clock, power, pinctrl and phy subnodes.

The regions has various independent registers tied to other
hardware devices, thus the syscon compatible.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 160 +++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
new file mode 100644
index 000000000000..16977e4e4357
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson System Control registers
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - amlogic,meson-gx-hhi-sysctrl
+          - amlogic,meson-gx-ao-sysctrl
+          - amlogic,meson-axg-hhi-sysctrl
+          - amlogic,meson-axg-ao-sysctrl
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clock-controller:
+    type: object
+
+  power-controller:
+    $ref: /schemas/power/amlogic,meson-ee-pwrc.yaml
+
+  pinctrl:
+    type: object
+
+  phy:
+    type: object
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gx-hhi-sysctrl
+            - amlogic,meson-axg-hhi-sysctrl
+    then:
+      properties:
+        clock-controller:
+          $ref: /schemas/clock/amlogic,gxbb-clkc.yaml#
+
+      required:
+        - power-controller
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gx-ao-sysctrl
+            - amlogic,meson-axg-ao-sysctrl
+    then:
+      properties:
+        clock-controller:
+          $ref: /schemas/clock/amlogic,gxbb-aoclkc.yaml#
+
+        power-controller: false
+        phy: false
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gx-hhi-sysctrl
+    then:
+      properties:
+        phy: false
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-axg-hhi-sysctrl
+    then:
+      properties:
+        phy:
+          oneOf:
+            - $ref: /schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml
+            - $ref: /schemas/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+
+required:
+  - compatible
+  - reg
+  - clock-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    bus@c883c000 {
+        compatible = "simple-bus";
+        reg = <0xc883c000 0x2000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0xc883c000 0x2000>;
+
+        sysctrl: system-controller@0 {
+            compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
+            reg = <0 0x400>;
+
+            clock-controller {
+                compatible = "amlogic,gxbb-clkc";
+                #clock-cells = <1>;
+                clocks = <&xtal>;
+                clock-names = "xtal";
+            };
+
+            power-controller {
+                compatible = "amlogic,meson-gxbb-pwrc";
+                #power-domain-cells = <1>;
+                amlogic,ao-sysctrl = <&sysctrl_AO>;
+
+                resets = <&reset_viu>,
+                         <&reset_venc>,
+                         <&reset_vcbus>,
+                         <&reset_bt656>,
+                         <&reset_dvin>,
+                         <&reset_rdma>,
+                         <&reset_venci>,
+                         <&reset_vencp>,
+                         <&reset_vdac>,
+                         <&reset_vdi6>,
+                         <&reset_vencl>,
+                         <&reset_vid_lock>;
+                reset-names = "viu", "venc", "vcbus", "bt656", "dvin",
+                              "rdma", "venci", "vencp", "vdac", "vdi6",
+                              "vencl", "vid_lock";
+                clocks = <&clk_vpu>, <&clk_vapb>;
+                clock-names = "vpu", "vapb";
+            };
+        };
+    };
+
+    bus@c8100000 {
+        compatible = "simple-bus";
+        reg = <0xc8100000 0x100000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0xc8100000 0x100000>;
+
+        sysctrl_AO: system-controller@0 {
+            compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
+            reg = <0 0x100>;
+
+            clock-controller {
+                compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
+                #clock-cells = <1>;
+                #reset-cells = <1>;
+                clocks = <&xtal>, <&clk81>;
+                clock-names = "xtal", "mpeg-clk";
+            };
+        };
+    };

-- 
2.34.1

