Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B043748314
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGELmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGELmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:42:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12131735
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:42:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so10004321e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688557319; x=1691149319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaNHukNnVjDsPaAH2UItJR4RWTnzSz8CQM5za4d01xc=;
        b=eoGCbKtPXzvda15F0EFg+vTluEi6TZEBd+7pMT4pGkWtwQrRjqNWhEKo/FVA3KMbG0
         dkaVNTuimNtL4VUMmRIOTCirIG6TfXDlU/o28TFeU4WvdK5p55xIsA/p6BnptPWtPQp2
         FfxGBhI301mJkHqaLL++z2vQVn+47JZ4hrnH+eax+PTHgL9a7hVl2d54/kx/K5hVSeOc
         SbYoAhKEydcYnE5/x3oLPJ+xDYfu47dlEOJBB++GKvxnLjYfPXKX4E6lnaYCSzj40mzK
         6ocdqZTXkGQHfsws1AfbSQPr02sGs4lEIacNxoq2+mvtjasMQnfDfmEijIHi9qpCM/Yg
         jRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557319; x=1691149319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaNHukNnVjDsPaAH2UItJR4RWTnzSz8CQM5za4d01xc=;
        b=f1ZxIAB72WGvqX5bYIBrFOIJr3Uk7z698uTTGYo1sXPDiutjFu+Cg/0g58zWU+ZkWt
         xu6xhQaXRnmUiUtUQ9Q/47mAxyw5VI/OLQybIwe2I2HcvwXkTK3x16YVbpKCdC5stCCk
         RDKY9XvtYnjO1Tfb9kTBwvESAsEg18327QdrjMJaiP2xZxcppGtMIxvi62jkxcVLPyk8
         12pbsNvfP0/gecqValfgW+LnUrRDS8+drtTVUdk+uPXJmqU5ew3xrjx9XLgGbGEoM96f
         LTOIZLclB3bF7UqZ4nXFidbej6xyBjIni9R1A49hhO8SgW/7smcW0mUwowbcJu1xDUj4
         HgvA==
X-Gm-Message-State: ABy/qLbyXXZD7JySs+MmjtiyEI8sO6YAN8vXqZSlyOwLBIh6wF9E7iAK
        BNp/RP5bSCxkww/h/8rTY3pOLgIjVDVRgL9qvFTCEGKe
X-Google-Smtp-Source: APBJJlFvQ35NSEFVi2NIkEQ1WNt56GRkE1nTH8Ny1kcUH3mWK3BNQT6Ii7cKXFgw3UkumO+kXtU5eg==
X-Received: by 2002:a05:6512:3256:b0:4fb:9f93:365f with SMTP id c22-20020a056512325600b004fb9f93365fmr11125377lfr.38.1688557319123;
        Wed, 05 Jul 2023 04:41:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b003fb416d732csm1916808wmk.6.2023.07.05.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:41:58 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 05 Jul 2023 13:41:51 +0200
Subject: [PATCH v2 1/3] dt-bindings: clock: amlogic: convert
 amlogic,gxbb-clkc.txt to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-b4-amlogic-bindings-convert-take2-v2-1-22be915ddc3b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3423;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6blIrzyVDZas5IcZi9A41vegPBQeeY36EiPBXllpWCM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkpVcDIG9EJRq/VdZ54P4MlMspaLByJsDrCw/YRGwx
 4SNHHPOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKVXAwAKCRB33NvayMhJ0c2fEA
 DAnzgI58asWhl7TlJS6OIvn/cirsOIIi/YaI5uM2uvix525ka7MBOSs7U4ASlxEnSPzlntuVNZ4Zib
 UtIfG5fKqlc6ru4wDUX9Yog9yegd7m3Smqatdw7fdxyNvWX+Z7j8j9roPCF3WRG46TryfAVcpA4rwy
 x2nShrNgHcJg6j7h+SlJQqpfYKqz5n4+kNgfUjHMt5/KKvMn+XoTS2Mrae3zlgRq0v0shKH959T0QA
 9QcAPMwcsPrrF8gqYOzTFUJbgPlHIxRupUCXZqdiWFhmQW/k4kBxF3DVIbXSJ4gFMupbzpfUrlSm08
 GbmHrhpzeWn7eUrt5ghPigCVVQdCqF8bu2BSqKcJq/KalvC8vN0aW7Yvo2+ic9L6IO6rerg6P2BPHN
 xZernKG7WIgYFL/BqdaewH/9CMXfqPCtXh77LL096DBhuZo0RZbH1NDEreaN21tf8Lt39ofM1hliSq
 Okrm9OCUCmnoFFiYqXd82KkJu3DH87zzJxBlVqVC6RFZEEO5ZmsLpZyBg6XNc+P9VHuI6G2UjNqVQU
 9CdBnQMTLYoPzcoNJDciiyKOx0x/mVwjzA5iT/FUiH2ay/AuKqJ6JmiofC+L4gBtZ8w2zAr1Qyioul
 mj+E+h9jjFxXd6uWKyGp+r3sLEOcmvSis7LdqN2EimfU1wWOl3y+erBpB8Ew==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Amlogic Clock Controller bindings to dt-schema.

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

