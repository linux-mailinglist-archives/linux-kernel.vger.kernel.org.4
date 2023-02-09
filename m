Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1ED690AA1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjBINlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBINlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:41:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA547413
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:41:42 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1537431wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGW2oT94HK6ngpZmBKHolnNTHtBBlnG2dCVlzG6CWeE=;
        b=Qledw9xPLq/PvO+4IvdhHggxZshP/QGS+twZn4DOnVjLBXRpws8wY3UzjQhwfiMu79
         JWq3NT4amqXdro2bvg24B6Cf+b6Iijvzbmdy61S/HZdaYpP/89NIBjQ3bX3A0t0P71Bs
         MJ2R49zCyJBkDiASjvFg7g4WVnjFqH3VBZ92ljgajD5R4dLyMCL/IfAzBgYD+ycYRxm6
         exNEAZVJiFPPoylgypSxcFv6sZY2pp+xVqoIFD4G2NFwy9py+nbEaCv6M+YcH0TAAwGF
         WLRviEUCziru4V1XyMKO13ycJ6cRFj1nyzRlIN/PBD5QGmtofk2kmwIS8PGyJIsebDOr
         q9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGW2oT94HK6ngpZmBKHolnNTHtBBlnG2dCVlzG6CWeE=;
        b=WDq0S0bDLGP2z7s8WBhANOh7LMtT4TV73DVtjV5dlsi/RZuUPKdpHpePaNR3A/S9kw
         vdpaDw/v/FzV8Pj6sBxGfO7FGV9o74eQmpZ1YMxxVOQiZtLJzYKnAaOymq8NBH0zmF1U
         EbJIKUEUejZzj6QxPQqOH7DVjFuvHaFIeLMs2J58vFzf+P/LtwqXl69ycPW9pVGAjFM4
         m6Mze3vkqtYYe34oDM16+4ZjJdmQ55o88c+WtyHtrK+ZBxXPDhXtI1BUvBxkm7JnF177
         Zg6hoRY/IItUwckIVthG2bZlx938VMsNNS3cD2dHpAoTIQybXLEy1eSddP5PjuHwaxL0
         xaeg==
X-Gm-Message-State: AO0yUKWZw9CMzuHf127V/sxt6NwJD2SmTmOiitksDZQrtrXWA1LkfDJw
        MU396NSEMr6kKYD9tU/SrmqDTA==
X-Google-Smtp-Source: AK7set8tF+m+2BDy4Jqj9n4mBkHnqUS7RpYgJU7ApYsJuiqWKroRaqouDy7YBCcw28uEE1HvKDcWAQ==
X-Received: by 2002:a05:600c:3416:b0:3df:50eb:7ca6 with SMTP id y22-20020a05600c341600b003df50eb7ca6mr10258428wmp.15.1675950101385;
        Thu, 09 Feb 2023 05:41:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003dfe549da4fsm4946991wmi.18.2023.02.09.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:41:41 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Feb 2023 14:41:38 +0100
Subject: [PATCH 2/6] dt-bindings: soc: amlogic: convert clk-measure.txt to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230209-b4-amlogic-bindings-convert-take2-v1-2-c4fe9049def9@linaro.org>
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Amlogic Internal Clock Measurer bindings to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../soc/amlogic/amlogic,meson-gx-clk-measure.yaml  | 40 ++++++++++++++++++++++
 .../bindings/soc/amlogic/clk-measure.txt           | 21 ------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
new file mode 100644
index 000000000000..77c281153010
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-clk-measure.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Internal Clock Measurer
+
+description:
+  The Amlogic SoCs contains an IP to measure the internal clocks.
+  The precision is multiple of MHz, useful to debug the clock states.
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-gx-clk-measure
+      - amlogic,meson8-clk-measure
+      - amlogic,meson8b-clk-measure
+      - amlogic,meson-axg-clk-measure
+      - amlogic,meson-g12a-clk-measure
+      - amlogic,meson-sm1-clk-measure
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clock-measure@8758 {
+        compatible = "amlogic,meson-gx-clk-measure";
+        reg = <0x8758 0x10>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
deleted file mode 100644
index 3dd563cec794..000000000000
--- a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Amlogic Internal Clock Measurer
-===============================
-
-The Amlogic SoCs contains an IP to measure the internal clocks.
-The precision is multiple of MHz, useful to debug the clock states.
-
-Required properties:
-- compatible: Shall contain one of the following :
-			"amlogic,meson-gx-clk-measure" for GX SoCs
-			"amlogic,meson8-clk-measure" for Meson8 SoCs
-			"amlogic,meson8b-clk-measure" for Meson8b SoCs
-			"amlogic,meson-axg-clk-measure" for AXG SoCs
-			"amlogic,meson-g12a-clk-measure" for G12a SoCs
-			"amlogic,meson-sm1-clk-measure" for SM1 SoCs
-- reg: base address and size of the Clock Measurer register space.
-
-Example:
-	clock-measure@8758 {
-		compatible = "amlogic,meson-gx-clk-measure";
-		reg = <0x0 0x8758 0x0 0x10>;
-	};

-- 
2.34.1

