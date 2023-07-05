Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA42748316
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjGELmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGELmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:42:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44761730
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:42:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so5364815e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688557320; x=1691149320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gQlDSngFOwPPUISUlBVLwpxXVmpFtUqiaGlXaZpOTw=;
        b=v4fawfHscxtp8ZsT3tpLY7hNhhx8GSsW8Na9ltQEbjX2vKqxLPA1zzoYdOkt9XbU1l
         GwAJkzPkMD3RXPp66ucMpFJwtYWY/X9e9ggSb43tE5bI/Ly8yCTdruNE3PuRnpxedCTs
         I0kD7vMzwbhc+1AxlpnFhNBUaK+/INT1jaXz8YT81WN9nBlCo2cWeWB6bZBWaK2rUHgE
         WAl7UGD6ubRHpCqzqJ4X3tlssCZYjs8EBVR/NE+gpe9GOCr24/T502WtCc0fCJKWVimE
         XnzF0N6Ej3AejQxNgNus5UiI9k8YsgB0Lvmt0vWdU26i5XFqE9NqOdhtE/cUrFxLnHSL
         yJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557320; x=1691149320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gQlDSngFOwPPUISUlBVLwpxXVmpFtUqiaGlXaZpOTw=;
        b=UwbT6x67+8cN545qOoBBZxgRViAo7X86nPXR7GXn0L5CQpERGs0ssZqKfYtAPTlT5q
         mNz7hYy0ySPi9sblelaEjAKR+J7laY7Votq6CkiupdrbJsns95hcrOUNVLoAPZKe3BKV
         XLedvUhI65ndi3qEGKonG7vB4LvUowNer86saVMw18qkNJfyw95U+RQeb2TSOWXu3TcC
         8LuMWa2h+BArPT6yLTGR+xIzZDrbhFmo1sZkbmhTcYe8A7w4DSAWvH3Eie6kJF+LoUlv
         o9vMpPmoy52l8gtnEd02Ce9uUVsMCcNk6Xl2xaTNkK90athOkNX+wV1opRuIOFj72I+9
         4cbA==
X-Gm-Message-State: ABy/qLZQyc6rSrqnYaFS1tOg2c0wf9MwFsi/7H+X5kX4TqDiQn+i/YWI
        BFBBQdMaaVGq+VhcCmbJsnQM70PkQgxRN7oLN5SFUCtE
X-Google-Smtp-Source: APBJJlHhvkXC0knRiPmGbihVFfIpUMgphxgM1NpomrfQajY9dKVXPnbE0I4STbUyZqmVmDI1RKduUA==
X-Received: by 2002:a7b:c8d3:0:b0:3f4:2a69:409 with SMTP id f19-20020a7bc8d3000000b003f42a690409mr2101902wml.11.1688557320234;
        Wed, 05 Jul 2023 04:42:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b003fb416d732csm1916808wmk.6.2023.07.05.04.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:41:59 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 05 Jul 2023 13:41:52 +0200
Subject: [PATCH v2 2/3] dt-bindings: clock: amlogic: convert
 amlogic,gxbb-aoclkc.txt to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-b4-amlogic-bindings-convert-take2-v2-2-22be915ddc3b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5696;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=90IENEZBGraleyfH5zMrD+1Aq1pySzcYXHESwDVRm5E=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkpVcDr3AXSM8KlYrEhr9cojI1jnMDm/uDsLVB7de5
 tbH4L8iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKVXAwAKCRB33NvayMhJ0V5tD/
 984cvGo8wVrNKMbVeYEmQnEKYhwus0ji+FCkkDLp35GvhdcGgQUBQGiWamtvP6QsQyqnvPuUglbEtC
 wSOiftVH+MifknlCiJaMXqJZlwn/PDPXWknt1aHDwVQK4YGNyhMpKhvW0swQ+8W1u2edtphTmrGD7E
 4j4hCOu/jbKcoK9vRmXXZtZSBtEibBInrPNoiE6+VQF8AzkWheAXBEDujy3ABM0a7TI0oJO+g9Y4lQ
 0+3pR5yc69p0ASbRzz+sQ/ogzPvdjWubsVebSDVQXfaC36MXxMIUA7UR974heu98zc7t67GXRJBpCR
 itWDIx8Qv35kSfR0/UXeOJ7FLjc/dVLrD60zoqrhWJNBJkgC96Zn9eRHDpaTq7GzH+HGStU09nlqdf
 7kr15eT2Mv5GC3ASET476WCpmYu3sRidKX8GXQvB7U4NFDLhq4osnNZfdVlxEYdg8UBV75f7zCCx7j
 fcmC2ikj/6dbzra/+A/ERdttYaBG7xjdxKuMm9XwCPYo/Q03TT/sDzdBJ0104GzkGtkHM3xSI5BJvQ
 1kKSExC35G29iRklEHd1VzveoVyHEhFVGjtnYfG9gt7aeFazFlydmB5hbG+GgYOARz5u+9Ja3h8AHR
 KpuvdE6ivOiE/d854mXAsiRRFl7PReZQCcPMKLI0KNH84+X0WgEyRFfaZaBw==
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

Convert the Amlogic Always-On Clock Controller bindings to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  64 -------------
 .../bindings/clock/amlogic,gxbb-aoclkc.yaml        | 101 +++++++++++++++++++++
 2 files changed, 101 insertions(+), 64 deletions(-)

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
index 000000000000..0adcfbcf5c85
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml
@@ -0,0 +1,101 @@
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
+    maxItems: 5
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
+            - amlogic,meson-gxbb-aoclkc
+
+    then:
+      properties:
+        clock-names:
+          minItems: 2
+          items:
+            - const: xtal 
+            - const: mpeg-clk
+            - const: ext-32k-0
+            - const: ext-32k-1
+            - const: ext-32k-2
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-g12a-aoclkc
+
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+
+        clock-names:
+          minItems: 2
+          items:
+            - const: xtal 
+            - const: mpeg-clk
+            - const: ext-32k-0
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
+          items:
+            - const: xtal 
+            - const: mpeg-clk
+
+additionalProperties: false

-- 
2.34.1

