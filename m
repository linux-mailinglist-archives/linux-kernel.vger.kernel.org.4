Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC995B514F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 23:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIKVUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKVUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 17:20:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CFC18365;
        Sun, 11 Sep 2022 14:20:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id go34so15949495ejc.2;
        Sun, 11 Sep 2022 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=KVt9Uyft/E21p0hWag8KEVJdTkCMY+n74W7H1HgusJI=;
        b=oACUNPspfdMBHHKbJyj/sh6VnWNfkG+yN8hBMBC1qGV38/zgimguacYJXYS6IGbmyb
         h5oydXvdFFiqr1CLT8AEKcL6BiRlCcKm5lrUyJzMul0O7WMPf5Tv/SUkJ+EolUfTUvwG
         nlY9858p6MdhM4H4gIxvc97whUBSHSLELy4POmJe/cnCqJnDLXOEVRwadpvQbuypt4wt
         3EUtK+tjZyH/Ml1Z2w0dgeshpQuAApayFlvL8NvD1VDQKSkQB9LSZGqv27QRwyogqmaQ
         e2+xPX/22AHvWe/jmZEjLDreFuJhCsas0y403g6nDTLoymdPt22xNlA1MPY8y/ZlFqFh
         /Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=KVt9Uyft/E21p0hWag8KEVJdTkCMY+n74W7H1HgusJI=;
        b=nDlZpjej21DWFqwzkHz4jQJTgKwL6u5AwRJ6I0jGlCxDlwupWBMwVMIah5x9ueut97
         rTqsBrif6H7GLNGJe7BGWez1BGwYbDM95HClVKR9Lozb9jpF8fNLw7t0Brt1MEF1w+Kq
         Xynih68MhLSADYpPVXcHygUrpOHirK8ONILs7XhZRDpTpmalGeWUYphbyEtH0J+vr51p
         qkVhUlqSltDGZ3lrKyZZUv3P42rHUL8fL/3fomjeAYIuLkiZ1dY5x7DBo2XaFFVymTmz
         /R3dju1l6IljdgmiPwnd4L7J4SpH3bmOj9pPVHf1kYHapQWN5GdXlkdsdxpsAo6xKjAQ
         cQpg==
X-Gm-Message-State: ACgBeo28TG8yLndIFwx4KsNY3VnPk265s9g8OFXokxoBCF95YUk9mEw1
        G76ooMnFZRVRFjqNfJeFhvdc549Tpy4=
X-Google-Smtp-Source: AA6agR49ZY8ZeQPl1KfjMRig98o0lBzeHgAs3S20hN85CmuYt2HxrF4h53upXO3Y6Alsfu+RCkXthg==
X-Received: by 2002:a17:906:9c82:b0:6e1:1d6c:914c with SMTP id fj2-20020a1709069c8200b006e11d6c914cmr16376286ejc.769.1662931212202;
        Sun, 11 Sep 2022 14:20:12 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906539600b0072f4f4dc038sm3432711ejo.42.2022.09.11.14.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 14:20:11 -0700 (PDT)
Message-ID: <76d87f49-6a44-0a05-c9dc-af870fade924@gmail.com>
Date:   Sun, 11 Sep 2022 23:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] dt-bindings: clock: convert rockchip,rk3128-cru.txt to
 YAML
To:     heiko@sntech.de
Cc:     zhangqing@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert rockchip,rk3128-cru.txt to YAML.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3128-cru.txt    | 58 ---------------
 .../bindings/clock/rockchip,rk3128-cru.yaml   | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
deleted file mode 100644
index 6f8744fd3..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Rockchip RK3126/RK3128 Clock and Reset Unit
-
-The RK3126/RK3128 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: should be "rockchip,rk3126-cru" or "rockchip,rk3128-cru"
-  "rockchip,rk3126-cru" - controller compatible with RK3126 SoC.
-  "rockchip,rk3128-cru" - controller compatible with RK3128 SoC.
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Optional Properties:
-
-- rockchip,grf: phandle to the syscon managing the "general register files"
-  If missing pll rates are not changeable, due to the missing pll lock status.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/rk3128-cru.h headers and can be
-used in device tree sources. Similar macros exist for the reset sources in
-these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "ext_i2s" - external I2S clock - optional,
- - "gmac_clkin" - external GMAC clock - optional
-
-Example: Clock controller node:
-
-	cru: cru@20000000 {
-		compatible = "rockchip,rk3128-cru";
-		reg = <0x20000000 0x1000>;
-		rockchip,grf = <&grf>;
-
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart2: serial@20068000 {
-		compatible = "rockchip,serial";
-		reg = <0x20068000 0x100>;
-		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-		clock-frequency = <24000000>;
-		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
-		clock-names = "sclk_uart", "pclk_uart";
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
new file mode 100644
index 000000000..03e5d7f0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3128-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3126/RK3128 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3126/RK3128 clock controller generates and supplies clock to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3128-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"     - crystal input       - required
+    - "ext_i2s"    - external I2S clock  - optional
+    - "gmac_clkin" - external GMAC clock - optional
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3126-cru
+      - rockchip,rk3128-cru
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: xin24m
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the "general register files" (GRF),
+      if missing pll rates are not changeable, due to the missing pll
+      lock status.
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    cru: clock-controller@20000000 {
+      compatible = "rockchip,rk3128-cru";
+      reg = <0x20000000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1

