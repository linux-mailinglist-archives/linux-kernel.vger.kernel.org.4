Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31AD749FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjGFOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjGFOwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:52:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A081BFF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:52:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fba545d743so9066035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688655157; x=1691247157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tgt1p8sy0oGunSDCWV0j5lPoQeDljE/MaOAC6lCXXgE=;
        b=FSkN26OeMBfVG3OuXyOtDkoQeDhpUvfGaNAABofoNK7Rvh5J69YzgOu7oxqqtPSl5b
         8BgvNQvbnMu/DtNqB35n0x7VupnpmoijDrs6zugjm/AUQOagR53bZaKFqW2bYfE1aZh+
         q4TVzds20S9m1Je/C8vcO94SNWalmYRm1+XRqh+078X3XDnjS14E/qbHKcimel4r/R89
         Esy+3vYiDCUlm5kw0PjdgjU2h+Qsie2JQz3+4KjwGymb3phVvTRdcZQQ+i0mVrmaQEjc
         bD+yniiGA1dKflaR7wdibhBt22I78e4IUik9k45X8ogvOqAdgvLnj7rU6VEGcNWXEU2s
         Nosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655157; x=1691247157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tgt1p8sy0oGunSDCWV0j5lPoQeDljE/MaOAC6lCXXgE=;
        b=TjbzCG02zh4TiPjntv1OAWqq+sqEiIRmYNS0c9aL2YOS39es0DOWHbpLkwnLpPfAFJ
         tOUKjWpP5EmKu96ZRNJ8+TlsmNVURY5gWTbK8iQ5GUSQXMzVJuG/fRszIwU45bOURqJt
         hIeorGi2+Jld+ma6KQdj9vhbgHIKrWKgesHCW0jylDwK+6o45oPuBgRPmMBBXVIQ26Qi
         sCHrlcbhJ4n5SazHwkuBbbul4k2LYbbWQrjgRbYSAFRuFH9f+aAwRROzc8jV8PsfKwsf
         1GJ6mHhqF9MRBH0GL+pCHeufYSalZxzP4aqvXGHu3JUUpP8uOj78xcLyx2AAa4iNiFpX
         DPzw==
X-Gm-Message-State: ABy/qLagMACrDOt1+LX1JxIljmDA70EjT4mpT0J07uQNnpg6KekmPmvO
        zd2GhqI/TV4mpumNaQU0UYuyCQ==
X-Google-Smtp-Source: APBJJlEIWFEjg5OfUYqYD4cgNfDb9ALlIk0LdkS/Yfpr7j0OZ3FTsa6wPhr3QTnoI/WNpei7s7s1Yg==
X-Received: by 2002:a7b:c458:0:b0:3fa:98f8:225f with SMTP id l24-20020a7bc458000000b003fa98f8225fmr1676602wmi.26.1688655157421;
        Thu, 06 Jul 2023 07:52:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm5371070wmi.23.2023.07.06.07.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:52:37 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Jul 2023 16:52:32 +0200
Subject: [PATCH v3 1/3] dt-bindings: clock: amlogic: convert
 amlogic,gxbb-clkc.txt to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230706-b4-amlogic-bindings-convert-take2-v3-1-f63de6f12dcc@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3467;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zRbK49pvWYMA+yYmekkxJvgW5BT1+BkF4rrA/iqBPJ8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkptUy3qMpVJpV/xABo+DQ9rAzAWItvRphGtwtZ6TL
 TjSEOtWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKbVMgAKCRB33NvayMhJ0cZ1D/
 9GL9++c0NqGj8oDicL66WEM3LQ/Fu3DHbB36o/XX9lxzQwHwCHs9Z9G8m3CuUI4ZpRhLansQffZoOu
 IIz4tcfe9Vpq/MVvzpUnQYgaY4W2nOjj7kXPxt5WoIe2CewrmcXnQlf+GIheImLJk52oPSLPrA4G9U
 UTzxG6+Xg1qJayntdoERXTbwvd0EHuhhIV3EvVPu5ayr8o8HdVMqp3SkYb236QUOLEx0O5rtaFRAlq
 cHbZ7D5WI6ZckhFAX7zW3oszRre8nepqxGrvCcGVCZlvY7iGDjSxXzFj2leOMuz9eGqnwEePjm3Bxb
 AmaYruNjrqte4PTciOvZ811KrEozqcWCFxjnAFHXag9dLBCZm7FFCFOrnYiTnTwMlddVDKJjfZkYJH
 /H6ZWms6vDWTHQZOredTDpsx9Cg/7CUyjrgDC19VztnPtx1jfYv7ELaYpsq9OCJ/FA8KiuIyM4Tsv5
 Qon8H34gqN18Si+22N6v2epAP/NdEMW1lExdnaS5owEj7+b3Ec/Nytc46PdZ8wSR51109EYP82Kob3
 v9HQs0fK8dtt37xYA8gdMeevOYzccYf25AQ64bzYMKO/vbAp9YSHhIqqKIgDnQUAo/KbSPJRtP6CZq
 8R6p89lGF14w0CM2hsAKAs/YNFFbag2XClz3FSo5g/ngyc2IpnFjxGOsPz2A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Amlogic Clock Controller bindings to dt-schema.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/clock/amlogic,gxbb-clkc.txt           | 53 ----------------------
 .../bindings/clock/amlogic,gxbb-clkc.yaml          | 37 +++++++++++++++
 2 files changed, 37 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
deleted file mode 100644
index 7ccecd5c02c1..000000000000
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-* Amlogic GXBB Clock and Reset Unit
-
-The Amlogic GXBB clock controller generates and supplies clock to various
-controllers within the SoC.
-
-Required Properties:
-
-- compatible: should be:
-		"amlogic,gxbb-clkc" for GXBB SoC,
-		"amlogic,gxl-clkc" for GXL and GXM SoC,
-		"amlogic,axg-clkc" for AXG SoC.
-		"amlogic,g12a-clkc" for G12A SoC.
-		"amlogic,g12b-clkc" for G12B SoC.
-		"amlogic,sm1-clkc" for SM1 SoC.
-- clocks : list of clock phandle, one for each entry clock-names.
-- clock-names : should contain the following:
-  * "xtal": the platform xtal
-
-- #clock-cells: should be 1.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/gxbb-clkc.h header and can be
-used in device tree sources.
-
-Parent node should have the following properties :
-- compatible: "syscon", "simple-mfd, and "amlogic,meson-gx-hhi-sysctrl" or
-              "amlogic,meson-axg-hhi-sysctrl"
-- reg: base address and size of the HHI system control register space.
-
-Example: Clock controller node:
-
-sysctrl: system-controller@0 {
-	compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
-	reg = <0 0 0 0x400>;
-
-	clkc: clock-controller {
-		#clock-cells = <1>;
-		compatible = "amlogic,gxbb-clkc";
-		clocks = <&xtal>;
-		clock-names = "xtal";
-	};
-};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart_AO: serial@c81004c0 {
-		compatible = "amlogic,meson-uart";
-		reg = <0xc81004c0 0x14>;
-		interrupts = <0 90 1>;
-		clocks = <&clkc CLKID_CLK81>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.yaml
new file mode 100644
index 000000000000..63246f1cb539
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,gxbb-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Clock Controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - amlogic,gxbb-clkc
+      - amlogic,gxl-clkc
+      - amlogic,axg-clkc
+      - amlogic,g12a-clkc
+      - amlogic,g12b-clkc
+      - amlogic,sm1-clkc
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: xtal
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false

-- 
2.34.1

