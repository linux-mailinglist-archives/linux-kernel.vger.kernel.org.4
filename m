Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4606D6A65
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjDDRXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjDDRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7BB4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fi11so10093359edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zfA4Ngq7HtermIaAG4T9GwFqQ9ZHFS3NDC9yUzF95k=;
        b=BmMTIYygMDz6GY2jOY5yj2MN6CC5PM16BRn80b1Itff+otfH1qEd58xS+gUDG79/TS
         2VW8HHMcY6+YjHuehgzxg6slW+K2LgDlVKioRJm/75hAPTj/IZ2XPYqv8O9uup0ie6cT
         rn5a1Cx7U+KeXUMXgKCnsB+JcIFYcFHL2s6ryNcq9Z9seQYuD3Bc7NSeWsQdvEJDds0o
         NJ57dvdlX/orHre27yK1DIsSJMu/ITmJMft/NAtdB0X8yDO5L7Qm7MV9wk1AMN+/R1Up
         XRFOzmopje16dtp7CtS2Q8rYrhjkv3VS6UEccEi2iVqpclUVzQSksp+ttRdHSwxaWPUF
         Wgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zfA4Ngq7HtermIaAG4T9GwFqQ9ZHFS3NDC9yUzF95k=;
        b=iZHt9mfgWy437BSfyv4OhQdwkl7LFBLQmtRoHujaZyuYlcdEFWDiW/5JTzaXBmoVEc
         PSNr2Qr9aoN/3Gdiv3E2oMs85apj1egs7v/e/QbqLkyVgA6eCl3ud20dreV5Ipivmt2j
         b7tjkKcYfGwGanyV7UB8HGZUnqQ9Il0BEkIDf574QtPuC8KpPVOMY9miQ3AqzIUXt93M
         jjsj16rNQzQiaM5RGhMxxkwHfl6y3AJJlEI+NfrzfXIk0hebWDAqUIzf6bBIhxKoEKxS
         zWos5tV++caw+hipmAANJZ3wT6VuRrxKsf885uW6TtEI76tRDKXCewB8mX90vxtwJJox
         zecw==
X-Gm-Message-State: AAQBX9feHkncc9R7m5afBW2tE1rrzJUmAldBlrBpW0hRFYvmcHb93RJG
        9FnYAHRLRahy/DFUm2Fzzl6ICw==
X-Google-Smtp-Source: AKy350YIBC/CmKWxKauOjlMHan3AgNmWHOfzPlILmkuvYC+55t/Nwbikruk0qkG/Goo6vOpuKm58Uw==
X-Received: by 2002:a17:906:817:b0:947:726e:f43a with SMTP id e23-20020a170906081700b00947726ef43amr350124ejd.23.1680628947420;
        Tue, 04 Apr 2023 10:22:27 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/40] dt-bindings: nvmem: convert amlogic-efuse.txt to dt-schema
Date:   Tue,  4 Apr 2023 18:21:13 +0100
Message-Id: <20230404172148.82422-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

Convert the  Amlogic Meson GX eFuse bindings to dt-schema.

Take in account the used variant with amlogic,meson-gx-efuse.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../nvmem/amlogic,meson-gxbb-efuse.yaml       | 57 +++++++++++++++++++
 .../bindings/nvmem/amlogic-efuse.txt          | 48 ----------------
 2 files changed, 57 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
new file mode 100644
index 000000000000..e49c2754ff55
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/amlogic,meson-gxbb-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson GX eFuse
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: amlogic,meson-gxbb-efuse
+      - items:
+          - const: amlogic,meson-gx-efuse
+          - const: amlogic,meson-gxbb-efuse
+
+  clocks:
+    maxItems: 1
+
+  secure-monitor:
+    description: phandle to the secure-monitor node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - clocks
+  - secure-monitor
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse: efuse {
+        compatible = "amlogic,meson-gxbb-efuse";
+        clocks = <&clk_efuse>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        secure-monitor = <&sm>;
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
diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
deleted file mode 100644
index f7b3ed74db54..000000000000
--- a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-= Amlogic Meson GX eFuse device tree bindings =
-
-Required properties:
-- compatible: should be "amlogic,meson-gxbb-efuse"
-- clocks: phandle to the efuse peripheral clock provided by the
-	  clock controller.
-- secure-monitor: phandle to the secure-monitor node
-
-= Data cells =
-Are child nodes of eFuse, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	efuse: efuse {
-		compatible = "amlogic,meson-gxbb-efuse";
-		clocks = <&clkc CLKID_EFUSE>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		secure-monitor = <&sm>;
-
-		sn: sn@14 {
-			reg = <0x14 0x10>;
-		};
-
-		eth_mac: eth_mac@34 {
-			reg = <0x34 0x10>;
-		};
-
-		bid: bid@46 {
-			reg = <0x46 0x30>;
-		};
-	};
-
-	sm: secure-monitor {
-		compatible = "amlogic,meson-gxbb-sm";
-	};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-For example:
-
-	eth_mac {
-		...
-		nvmem-cells = <&eth_mac>;
-		nvmem-cell-names = "eth_mac";
-	};
-- 
2.25.1

