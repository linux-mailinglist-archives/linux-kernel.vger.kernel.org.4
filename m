Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1696B62F780
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbiKROeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242411AbiKROdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:33:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B164551
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:33:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o30so3754920wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=os18iIH40bbHxRjQCRqddwrzdnwc6I4uEJqYH2KW3Ak=;
        b=lJkfDmBKCzja3AXdIe++widX8f6gelPNh/0y1AaE6UoXgCvbnqGe4Q2GTBmMoezOA7
         UwtxeNVmLjuKTePTBAJ6UYIs3erJSdky2WJ4mziNHtotJ4r8lZKLs5Cev/peAc9QyuFZ
         g1bDFZ2LDOoXlpwAs6L90H1YxEh0n3juUQWASZn/xGaoT2GQZWyI6fKWcS12qvGMdoIY
         bUNfweLRh1LDprvbOnwhIkJFJEBN77lDXVu/QZHK9IOBKKX06rTZHKsENp15XnM92fel
         sSMouQOYt2KeZ9JANMrM/znKckpEa2swmbX37FCcHmLlfhTrIi9Y5D+VaO5h15QrXr78
         0k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os18iIH40bbHxRjQCRqddwrzdnwc6I4uEJqYH2KW3Ak=;
        b=6hPaJqpw7VvSZB8UlsWMpKT4wSlfMD7hupO5nVHmLptwzsO+ZR4cPmbSardM8k8B/j
         tH/lWTpezyX18QciySi56cbDZliqipiTr4XpGlQfwT/VrlgADVo9RRwGb1KvbLsiXm3w
         4R/dUPB4XnNycqA0BevE2KYAMEjKD72+KnAezV6Ip32ZBnY0VwqG2aqITA70VBqJTTl6
         UuavV6HZn4yPgU3+KPexEym2uXKTxaEADMBgR7U8BV0HxwwrbJnQTGcysEuncnCJS9lZ
         X7daOdIPrSGiQaTCc9P2bo3KmidH/fzGzHTZhht+g0Fw1ywRZ6PqvOgeBkK9HhdJ3edD
         NCVA==
X-Gm-Message-State: ANoB5pmssL4B/nex7PRsUAwN1d1ALdEYgu+eb87O07pFuUyHmeicdeh1
        XHdz5ls9KhHZInPPwP/m4SLL1w==
X-Google-Smtp-Source: AA0mqf7X30WBLQ26Ln7KuaxzIEh5l7ZHE8X2TACFtKnF9q0ankWSiqWiouUvFBJBNOtLyJaem7IlQw==
X-Received: by 2002:a05:600c:3110:b0:3cf:b07a:cd56 with SMTP id g16-20020a05600c311000b003cfb07acd56mr8325908wmo.143.1668782015225;
        Fri, 18 Nov 2022 06:33:35 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j21-20020a05600c1c1500b003cfb7c02542sm5436726wms.11.2022.11.18.06.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:33:34 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 15:33:29 +0100
Subject: [PATCH 03/12] dt-bindings: nvmem: convert amlogic-meson-mx-efuse.txt to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v1-3-3f025599b968@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Amlogic Meson6 eFuse bindings to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/nvmem/amlogic,meson6-efuse.yaml       | 64 ++++++++++++++++++++++
 .../bindings/nvmem/amlogic-meson-mx-efuse.txt      | 22 --------
 2 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
new file mode 100644
index 000000000000..232d68d7fbcb
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/amlogic,meson6-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson6 eFuse
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson6-efuse
+      - amlogic,meson8-efuse
+      - amlogic,meson8b-efuse
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: core
+
+  secure-monitor:
+    description: phandle to the secure-monitor node
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse: efuse@0 {
+        compatible = "amlogic,meson6-efuse";
+        reg = <0x0 0x2000>;
+        clocks = <&clk_efuse>;
+        clock-names = "core";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        sn: sn@14 {
+            reg = <0x14 0x10>;
+        };
+
+        eth_mac: mac@34 {
+            reg = <0x34 0x10>;
+        };
+
+        bid: bid@46 {
+            reg = <0x46 0x30>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
deleted file mode 100644
index a3c63954a1a4..000000000000
--- a/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Amlogic Meson6/Meson8/Meson8b efuse
-
-Required Properties:
-- compatible: depending on the SoC this should be one of:
-	- "amlogic,meson6-efuse"
-	- "amlogic,meson8-efuse"
-	- "amlogic,meson8b-efuse"
-- reg: base address and size of the efuse registers
-- clocks: a reference to the efuse core gate clock
-- clock-names: must be "core"
-
-All properties and sub-nodes as well as the consumer bindings
-defined in nvmem.txt in this directory are also supported.
-
-
-Example:
-	efuse: nvmem@0 {
-		compatible = "amlogic,meson8-efuse";
-		reg = <0x0 0x2000>;
-		clocks = <&clkc CLKID_EFUSE>;
-		clock-names = "core";
-	};

-- 
b4 0.10.1
