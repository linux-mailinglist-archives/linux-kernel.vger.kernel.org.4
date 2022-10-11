Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B795FB84A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJKQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJKQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:29:48 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89112F036;
        Tue, 11 Oct 2022 09:29:46 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id u19-20020a4a9e93000000b004757198549cso10445061ook.0;
        Tue, 11 Oct 2022 09:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqpo7N9AbT0RGrhImIieGDVa4hsFpKgESHXQ8QIN+fQ=;
        b=InbK4D29gg7j3EpPYyVlxhqDEKbpzzGpR2RSzXyThQrkvIK08o4QYEElZ7ZGjI1Mvr
         3KLIPtbIU7Y9bzEsdGyEfdR7O7c3FzrJarzRFbTWY2zTqCR4Zc61UNbKa9QNsrIHKP4j
         zcDFJOlbSCzVDUvI+bDLJs01MyzG9agvOWrqhZ+SQz79JRIo2cdNMF95VlbjuwqyfAoz
         sJy5og7QwCLnjMkalJUmFr7vPnu97r5AbCjF1Lut8/Ict6IdDtJWGKngbvf3uq9XRklO
         AMbU3jReQ/49NvlVMByn/iDSCCcUl9nRADyuerR5p0tZSLGDkSXeSl4yfHKluthcuKjS
         DNAg==
X-Gm-Message-State: ACrzQf2sX+eqcOoDoczBGZEVY6T/YY3XWl4/i3y4HgzoIx7T8BUnyH2d
        AeDMwRCSNm5zSZ6n2I8B9v86zL3aHA==
X-Google-Smtp-Source: AMsMyM6j8/ozSofZ+EmWAZmg/pPilAn8Mcf/AbHws7NpbRGd8HSMGgaSKjybBjzmHihtdG6gy2hEIg==
X-Received: by 2002:a05:6830:922:b0:659:ef01:7e29 with SMTP id v34-20020a056830092200b00659ef017e29mr11190531ott.209.1665505784712;
        Tue, 11 Oct 2022 09:29:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s63-20020acac242000000b0035173c2fddasm5591834oif.51.2022.10.11.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:29:43 -0700 (PDT)
Received: (nullmailer pid 3025544 invoked by uid 1000);
        Tue, 11 Oct 2022 16:29:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Convert pwm-clock to DT schema
Date:   Tue, 11 Oct 2022 11:29:18 -0500
Message-Id: <20221011162919.3025038-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the pwm-clock binding to DT schema format. A straight-forward
conversion.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/pwm-clock.txt   | 26 -----------
 .../devicetree/bindings/clock/pwm-clock.yaml  | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/pwm-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/pwm-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/pwm-clock.txt b/Documentation/devicetree/bindings/clock/pwm-clock.txt
deleted file mode 100644
index 83db876b3b90..000000000000
--- a/Documentation/devicetree/bindings/clock/pwm-clock.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Binding for an external clock signal driven by a PWM pin.
-
-This binding uses the common clock binding[1] and the common PWM binding[2].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/pwm/pwm.txt
-
-Required properties:
-- compatible : shall be "pwm-clock".
-- #clock-cells : from common clock binding; shall be set to 0.
-- pwms : from common PWM binding; this determines the clock frequency
-  via the period given in the PWM specifier.
-
-Optional properties:
-- clock-output-names : From common clock binding.
-- clock-frequency : Exact output frequency, in case the PWM period
-  is not exact but was rounded to nanoseconds.
-
-Example:
-	clock {
-		compatible = "pwm-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-		clock-output-names = "mipi_mclk";
-		pwms = <&pwm2 0 40>; /* 1 / 40 ns = 25 MHz */
-	};
diff --git a/Documentation/devicetree/bindings/clock/pwm-clock.yaml b/Documentation/devicetree/bindings/clock/pwm-clock.yaml
new file mode 100644
index 000000000000..f88ecb2995e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/pwm-clock.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/pwm-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: An external clock signal driven by a PWM pin.
+
+maintainers:
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+properties:
+  compatible:
+    const: pwm-clock
+
+  '#clock-cells':
+    const: 0
+
+  clock-frequency:
+    description: Exact output frequency, in case the PWM period is not exact
+      but was rounded to nanoseconds.
+
+  clock-output-names:
+    maxItems: 1
+
+  pwms:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+  - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    clock {
+        compatible = "pwm-clock";
+        #clock-cells = <0>;
+        clock-frequency = <25000000>;
+        clock-output-names = "mipi_mclk";
+        pwms = <&pwm2 0 40>; /* 1 / 40 ns = 25 MHz */
+    };
+...
-- 
2.35.1

