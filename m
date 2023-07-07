Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A246674B881
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjGGVHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGGVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:07:33 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECBB2701;
        Fri,  7 Jul 2023 14:07:15 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7869bcee569so86365439f.0;
        Fri, 07 Jul 2023 14:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764035; x=1691356035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5ZfCjJKzY2MaRBcREgAL2YyH2jMaEbxPu3Qk3ZLyVc=;
        b=EFwgBUqQM7RBuMaXTfRgmh/vGuKHwkGtb1KebsTftRFyCfXd9i06zzEwHtEF55T4bL
         Il7nN2Woe1421sG0bppQusf2m4Va5/JESAWJn1ioy02TXdzQF3oXeHsmneqH/qZiW3gy
         7fU/zaGLyfyhSrwUhIQzaKmHZIj+tk74EOCOFQy5Id/4HOF3jxYI+Z1EfwY2w4knn/4i
         mQDrMWQhjWEo/f5d497m4of1dJgCfHsVlYLaTfII6EwEeNM5rz8IUc2+4uzeFbcDnLHD
         Vi79yJsMCXkVtuAe2c4trnspST2IuvQFqQxoJQTwUfjEgNerdWi918vGN3JjbffFfK1U
         vbvQ==
X-Gm-Message-State: ABy/qLaNgDy4DK1eIY/FO7I/0sM5mDhooQBvu3PJF2Wt4b/UlOueEI47
        tJeOGqZvfbX7BeJuwmU0LUtsy6vzUA==
X-Google-Smtp-Source: APBJJlF50Cr959QZ4ozRIJVi+JUKZGlsU73N95mY4+UI42bbpOzuIeWVBuq8MTn014rQxidfp6PYaQ==
X-Received: by 2002:a5d:9451:0:b0:783:72b9:ed67 with SMTP id x17-20020a5d9451000000b0078372b9ed67mr6278929ior.10.1688764034964;
        Fri, 07 Jul 2023 14:07:14 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w24-20020a6bf018000000b0076c7a2f0f41sm1571577ioc.46.2023.07.07.14.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:07:14 -0700 (PDT)
Received: (nullmailer pid 869315 invoked by uid 1000);
        Fri, 07 Jul 2023 21:07:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Wei Xu <xuwei5@hisilicon.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: hisilicon,cpuctrl: Merge "hisilicon,hix5hd2-clock" into parent binding
Date:   Fri,  7 Jul 2023 15:07:00 -0600
Message-Id: <20230707210700.869060-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "hisilicon,hix5hd2-clock" is simple enough to just add it into its
parent node binding, "hisilicon,cpuctrl".

This fixes a warning that "hisilicon,hix5hd2-clock" is missing a schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm/hisilicon/controller/cpuctrl.yaml     | 20 +++++++++++++
 .../bindings/clock/hix5hd2-clock.txt          | 30 -------------------
 2 files changed, 20 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/hix5hd2-clock.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
index 528dad4cde3c..4fc208d3995e 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
@@ -29,6 +29,26 @@ properties:
 
   ranges: true
 
+patternProperties:
+  "^clock@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: hisilicon,hix5hd2-clock
+
+      reg:
+        maxItems: 1
+
+      "#clock-cells":
+        const: 1
+
+    required:
+      - compatible
+      - reg
+      - "#clock-cells"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/clock/hix5hd2-clock.txt b/Documentation/devicetree/bindings/clock/hix5hd2-clock.txt
deleted file mode 100644
index 4733e58e491b..000000000000
--- a/Documentation/devicetree/bindings/clock/hix5hd2-clock.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Hisilicon Hix5hd2 Clock Controller
-
-The hix5hd2 clock controller generates and supplies clock to various
-controllers within the hix5hd2 SoC.
-
-Required Properties:
-
-- compatible: should be "hisilicon,hix5hd2-clock"
-- reg: Address and length of the register set
-- #clock-cells: Should be <1>
-
-Each clock is assigned an identifier and client nodes use this identifier
-to specify the clock which they consume.
-
-All these identifier could be found in <dt-bindings/clock/hix5hd2-clock.h>.
-
-Examples:
-	clock: clock@f8a22000 {
-		compatible = "hisilicon,hix5hd2-clock";
-		reg = <0xf8a22000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	uart0: uart@f8b00000 {
-		compatible = "arm,pl011", "arm,primecell";
-		reg = <0xf8b00000 0x1000>;
-		interrupts = <0 49 4>;
-		clocks = <&clock HIX5HD2_FIXED_83M>;
-		clock-names = "apb_pclk";
-	};
-- 
2.40.1

