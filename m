Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6296778B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjAWKKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjAWKKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:10:20 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09996E393
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:10:08 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y1so5755647wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRiMwFjCYTBiVehS5Zjzxk4QhzySk5Q8XvQ2DTwvGYo=;
        b=I8MMPFh1TcWsNd+WWe0k3fRxXgSCZ5bzuKgp1jF0Oscrp5+wIJdNqG+oCnhILfT2C7
         AMfhxG4J1w38PSAjeX8Ng26VvukBrp2AUraxmRu/TjlcbKRUbUk6QdKPkju8/0J3GcEg
         EtNMesusXeLgEhK4ffFf2VEUmacT+9ALA16WCi6o6JAc4mwqlaXhIPe19L/rF24jGCb3
         jy7uXjrKQo23Nc6dXu/RbsbVK9jJC11rWLLmYq4mJhRSUidzaCSsvEnRBoZK1+BCnKFR
         t9KV/fGbXrmSSZNQt2Xkx6SEhxnRcmWkTxOGOWiulPtkS8LZZgPmF+8K4dMq+u/lm7y/
         OV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRiMwFjCYTBiVehS5Zjzxk4QhzySk5Q8XvQ2DTwvGYo=;
        b=SWgQYZzLBvKnStQny9xWaZOoDMcFSaJADjTKlVigDPrP4Utv8e7uukGmsJLZR66Uk2
         erssBxV2RG+id9hBg7gFfh9XkJcyzQrCI5Wvem4xFT1OWS8t9H9nwpliwMhtxdPOvpxq
         ZzRz8GB9RcBGKlSHAlSBOsnvh1bTNR/Zh1WTN/NpDzafly0xIgGVY0y4fCHtR9DOaiNW
         cITFWrFTho1PZgroyaHqHVU52TLmuRUr1P8Uw1tPr33Rbg97tM6fHu1OzdYOXB8KOVtw
         5pZQfr4LsfNCHi34jbn1oZ7bWDftpkWVcPDkXkPygUdoq2vN0PdYb+Gl8a2k+JwKKEbd
         Wu3Q==
X-Gm-Message-State: AFqh2kp+UxH0wFh16I+cdDRqMwqSohzq+64iwiOH1JbwsoIbJHjnN9DB
        mbljFIJdHP7a9vVT+xvZT+87nQ==
X-Google-Smtp-Source: AMrXdXsz9ZThuuglWyEkoHYSIAJZtH6Em5vfGy2znOZDNstmWHfHemnhc3HoFov4CDVgw14dH69ABA==
X-Received: by 2002:a5d:4f90:0:b0:2bd:d542:e01e with SMTP id d16-20020a5d4f90000000b002bdd542e01emr21607229wru.10.1674468607166;
        Mon, 23 Jan 2023 02:10:07 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b002bdec340a1csm22670403wrz.110.2023.01.23.02.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:10:06 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 23 Jan 2023 11:10:02 +0100
Subject: [PATCH v3 5/7] dt-bindings: timer: convert
 timer/amlogic,meson6-timer.txt to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v3-5-e28dd31e3bed@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

Convert the Amlogic Meson6 SoCs Timer Controller bindings to dt-schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/timer/amlogic,meson6-timer.txt        | 22 ---------
 .../bindings/timer/amlogic,meson6-timer.yaml       | 54 ++++++++++++++++++++++
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
deleted file mode 100644
index a9da22bda912..000000000000
--- a/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Amlogic Meson6 SoCs Timer Controller
-
-Required properties:
-
-- compatible : should be "amlogic,meson6-timer"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : The four interrupts, one for each timer event
-- clocks : phandles to the pclk (system clock) and XTAL clocks
-- clock-names : must contain "pclk" and "xtal"
-
-Example:
-
-timer@c1109940 {
-	compatible = "amlogic,meson6-timer";
-	reg = <0xc1109940 0x14>;
-	interrupts = <GIC_SPI 10 IRQ_TYPE_EDGE_RISING>,
-		     <GIC_SPI 11 IRQ_TYPE_EDGE_RISING>,
-		     <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>,
-		     <GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
-	clocks = <&xtal>, <&clk81>;
-	clock-names = "xtal", "pclk";
-};
diff --git a/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.yaml b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.yaml
new file mode 100644
index 000000000000..8381a5404ef7
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/amlogic,meson6-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson6 SoCs Timer Controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+properties:
+  compatible:
+    const: amlogic,meson6-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+    description: per-timer event interrupts
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: xtal
+      - const: pclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    timer@c1109940 {
+        compatible = "amlogic,meson6-timer";
+        reg = <0xc1109940 0x14>;
+        interrupts = <GIC_SPI 10 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 11 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&xtal>, <&clk81>;
+        clock-names = "xtal", "pclk";
+    };

-- 
2.34.1

