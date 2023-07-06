Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270BE749FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjGFOxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjGFOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:52:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE45E1FCA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:52:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso8416195e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688655158; x=1691247158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCHzxbE1tjKBR243NKKB0jh3lIoMBebnovktMIwTJXM=;
        b=h9JMtcl66g/4tPGm7btANV5d1c+uRCxtqlOgJCJxN2ei8gg3iQOFHiAA7bMLWMBK45
         664r8b3taGi2y1IGgyGwQ8uvpw/X43E0vMG6BWHDhe0hM5iF161O7x8IklEKRJX4jV59
         IVnvgyCQfmNv3WcqlidCbyGrymOEK/uhamRFno1ChvbpCp77b+XpJp0jWS2KhpFfJ1Lb
         FEXg0imh0tSoSVwJVSwdYBBASfYM1W/mQi6QJmcmuXUdB1vI7ekV5SoJ03InHMKQxF/8
         UUAJAW4ppfd17yaLzq1aDqVkcyIpxS/HBfayeeUxHXydL7kleW39suk8BxDhlN3V/CSr
         TVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655158; x=1691247158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCHzxbE1tjKBR243NKKB0jh3lIoMBebnovktMIwTJXM=;
        b=Rq0ywgqHQUXLl43hDJBmpUmNYGRKxOv1jw5m1Fdpql+aqgLpe4nGi6gu3R8jYKaL0L
         f3pvRmtxJb3oRZzZh3g8taUMz/CzcbLy4E+I31L9dh1JyybQlhvV9sFuB/sfWIoeY+TH
         W/Jh46kG7CJ9KV3o44oE0hpqBeRRCAyvJLgbs8MHCBMiqt3wrBOG5Ul9B5FXdB2Qg0T/
         ZpU9LPubldUkWV6HQ+zcZ9QCKArM3E53v1DIohIGFB4NQvzdYdPNPtUbbMn7KkVyGisz
         YnLrsQnjizPXEZSJS3dAh6FpJlqmrWyswuEoT09omPxZ2VOn3TY265D2ggCvx5t/bGiL
         q4vQ==
X-Gm-Message-State: ABy/qLYOxmujPQOiiRZevLWRIinmMlP+vbmA3p21sBzUxbyv4Hpc9/+Y
        E1tLyYLq9xahEK3SoONsofILAA==
X-Google-Smtp-Source: APBJJlHL40/tnp4tA32KZoqJjBFDGDLXJfQj0Jucmj1iI+1GdOHNjUuvwAkYSfcyf0NZ2uV11eVrww==
X-Received: by 2002:a1c:7410:0:b0:3fa:984d:7e9f with SMTP id p16-20020a1c7410000000b003fa984d7e9fmr1547546wmc.6.1688655158350;
        Thu, 06 Jul 2023 07:52:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm5371070wmi.23.2023.07.06.07.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:52:37 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Jul 2023 16:52:33 +0200
Subject: [PATCH v3 2/3] dt-bindings: clock: amlogic: convert
 amlogic,gxbb-aoclkc.txt to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230706-b4-amlogic-bindings-convert-take2-v3-2-f63de6f12dcc@linaro.org>
References: <20230706-b4-amlogic-bindings-convert-take2-v3-0-f63de6f12dcc@linaro.org>
In-Reply-To: <20230706-b4-amlogic-bindings-convert-take2-v3-0-f63de6f12dcc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5324;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ADzNxsLZVUxAZGHQV6SIC+lyehu2X1Yd3uQQxNSVb9U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkptUyeY4kIEpNhbeZYiASH2BaNo4jhbR+2TfJEz83
 n1pmjQaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKbVMgAKCRB33NvayMhJ0YlRD/
 9hh+MaaIHwPRWr36uZnokNXvrdmMWHunis+f39l0fFem5BH207RC0YhWf7twGA5uDeg7+9rtaETSLp
 Bi/l4VM+Jm/71uooqDfuPL3GqVaeT2KG4QXJL/G9SVzFV1gk0XNrX/ICt1j1wyAIBE7c1RB2h/9LjI
 techukyzYATpCj2JQA85dA/x/3epx5G+9MM2h5CHcoZEuxnLozh/AEK1mmvIP+jk6S0eJB0objvMdp
 p5B8c0GHZ9q0jJ9p38QUlhYFARnyEYa70SMV5C91wVi2LgeeAdbhw60c3xzijHSdx793IjAMAP3Y9s
 h+vz4dLNMjvItnKm0TuMM2O0NdCYLgmipN1U8gnx7Hop8kSwSeyAExF7voD9yvAYYCFCEni/0tF1pU
 5SEJ2+aAPvjCo+lQTc0VwRggAuqoFGv7dOe/WveCpwzjz6PmP4Kt36K31X+bVy8s1gDiE2Pj/r3rau
 9M8SVIFAhFOfFgieYv17guQiKpgMnzZ5imKDFmxyW58Z+v7vlTX85b80J8MPaiU/ZeULgX4nUHTRAX
 HsGMspiIs9ORvHrwlhj71mueNz+nCNALr9JU0xvRN7Fsj3aLSe+TNDBelCkum3dxqRyfIaGyL7kiZX
 vfR3gjGTLEF6H/IYStQ7J2zGVFLnKkXd5gO0sl64fbVJyPRkokQV044SBo3g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Amlogic Always-On Clock Controller bindings to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/clock/amlogic,gxbb-aoclkc.txt         | 64 ----------------
 .../bindings/clock/amlogic,gxbb-aoclkc.yaml        | 85 ++++++++++++++++++++++
 2 files changed, 85 insertions(+), 64 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
deleted file mode 100644
index c41f0be5d438..000000000000
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-* Amlogic GXBB AO Clock and Reset Unit
-
-The Amlogic GXBB AO clock controller generates and supplies clock to various
-controllers within the Always-On part of the SoC.
-
-Required Properties:
-
-- compatible: value should be different for each SoC family as :
-	- GXBB (S905) : "amlogic,meson-gxbb-aoclkc"
-	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
-	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
-	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
-	- G12A (S905X2, S905D2, S905Y2) : "amlogic,meson-g12a-aoclkc"
-	followed by the common "amlogic,meson-gx-aoclkc"
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "xtal"     : the platform xtal
-  * "mpeg-clk" : the main clock controller mother clock (aka clk81)
-  * "ext-32k-0"  : external 32kHz reference #0 if any (optional)
-  * "ext-32k-1"  : external 32kHz reference #1 if any (optional - gx only)
-  * "ext-32k-2"  : external 32kHz reference #2 if any (optional - gx only)
-
-- #clock-cells: should be 1.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/gxbb-aoclkc.h header and can be
-used in device tree sources.
-
-- #reset-cells: should be 1.
-
-Each reset is assigned an identifier and client nodes can use this identifier
-to specify the reset which they consume. All available resets are defined as
-preprocessor macros in the dt-bindings/reset/gxbb-aoclkc.h header and can be
-used in device tree sources.
-
-Parent node should have the following properties :
-- compatible: "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd"
-- reg: base address and size of the AO system control register space.
-
-Example: AO Clock controller node:
-
-ao_sysctrl: sys-ctrl@0 {
-	compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
-	reg =  <0x0 0x0 0x0 0x100>;
-
-	clkc_AO: clock-controller {
-		compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-		clocks = <&xtal>, <&clkc CLKID_CLK81>;
-		clock-names = "xtal", "mpeg-clk";
-	};
-
-Example: UART controller node that consumes the clock and reset generated
-  by the clock controller:
-
-	uart_AO: serial@4c0 {
-		compatible = "amlogic,meson-uart";
-		reg = <0x4c0 0x14>;
-		interrupts = <0 90 1>;
-		clocks = <&clkc_AO CLKID_AO_UART1>;
-		resets = <&clkc_AO RESET_AO_UART1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml
new file mode 100644
index 000000000000..25daf313172a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,gxbb-aoclkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Always-On Clock Controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,meson-gxbb-aoclkc
+              - amlogic,meson-gxl-aoclkc
+              - amlogic,meson-gxm-aoclkc
+              - amlogic,meson-axg-aoclkc
+          - const: amlogic,meson-gx-aoclkc
+      - enum:
+          - amlogic,meson-axg-aoclkc
+          - amlogic,meson-g12a-aoclkc
+
+  clocks:
+    minItems: 2
+    maxItems: 5
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: xtal 
+      - const: mpeg-clk
+      - const: ext-32k-0
+      - const: ext-32k-1
+      - const: ext-32k-2
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-g12a-aoclkc
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 3
+
+        clock-names:
+          minItems: 2
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gxl-aoclkc
+            - amlogic,meson-gxm-aoclkc
+            - amlogic,meson-axg-aoclkc
+
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          maxItems: 2
+
+additionalProperties: false

-- 
2.34.1

