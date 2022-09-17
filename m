Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5945BBA27
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 21:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIQTmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 15:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQTmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 15:42:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4F52BB19;
        Sat, 17 Sep 2022 12:42:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so56380944ejc.1;
        Sat, 17 Sep 2022 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=CLQ627bvA6g1Nc29K4V1qYeubKsKhvm7FZqgOaOV0JU=;
        b=fpqOgsgO1oi0uxKU6EE/HhfV+NMAj7IoS7T6XWJtR0i3wUgpqqQPjSRsv3L6wQh+Tc
         7VWQqzEqrnw4SoMDCJKIZjI032Q1xwUGgN5c3qD3ddFWLZID4QGFlqrRJiE1ax4Wb11J
         ZEbz61w6d+iVmWEl6sAwOziW5AySYMrfixuth6EMf33vzZdGuWli7IudHCJoYtZLxW9T
         +Zte/QIEThUoMzwUJMwuWnJM3N1xmBQT6cPyl6ZT7hS7zVVjt7eBV3g9RACGc2tBC+NX
         AfRru1Bo1pz6NieDJop4iuhyvZEyol3vFhxlpt4xRXBg4ErM0piuorRgS6XMwXgcAkPi
         QCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=CLQ627bvA6g1Nc29K4V1qYeubKsKhvm7FZqgOaOV0JU=;
        b=Cm4W9f9tl+04c0sNMVoKpAtxLuhEAwz5P0z5TWTNMhBhQPjTyhv3sishqEEUiOlpnA
         VWS4/LO5J3I6mFR7R3RGeRz9d/eBQMsuMD+z28qAaEIYYoou9kSSA+Cu5WQDxlS/DyCg
         e8a5YEnfFMy3X5gvvF6hsmR4ZcZ8K0soKagEVu6DKneHIE49CztzAGE3WL+PfO5aYhGM
         3oaQv3fO6NiNlvRc1yA3S7kPW8VCCXdy0+q0CDsK8IEagg/hcr1izih3enPhXB1niS1E
         IkM512I1iu8qpcuFFZj598oCpkw8XMbQfp1vO4vCf7pVOXnAkPQpIEchQv64W1UvPD6B
         YVQw==
X-Gm-Message-State: ACrzQf0ui0ZmXHPZYNPNaR6IpkW2M3JsDNxdQAnYBW6K7VnVikcDg1Wz
        Qpf/RrH0TvS3QLc4cfbSm2U=
X-Google-Smtp-Source: AMsMyM7jLjrtYaOXMnxRLFhqP75wdZVPpFnUnEeOJGnJG/R+UWwRW2Ac4DoFjxqvQMVVIn8BzOEBjw==
X-Received: by 2002:a17:906:7c8f:b0:771:3912:3942 with SMTP id w15-20020a1709067c8f00b0077139123942mr7855927ejo.387.1663443727868;
        Sat, 17 Sep 2022 12:42:07 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w22-20020a17090633d600b0073d7e58b1bcsm12401924eja.157.2022.09.17.12.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 12:42:07 -0700 (PDT)
Message-ID: <614ccc3b-eb65-450e-d015-9c615a09a701@gmail.com>
Date:   Sat, 17 Sep 2022 21:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2] dt-bindings: clock: convert rockchip,rk3128-cru.txt to
 YAML
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert rockchip,rk3128-cru.txt to YAML.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
  Use SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  Add more clocks

---

Rockchip recently replied on other clock-patches to dual-license the
binding.

https://lore.kernel.org/all/510d1180-bc8e-7820-c772-ed7f35447087@rock-chips.com/
From Finley with an  @rock-chips.com address, so this should be ok.

Document history:

git log Documentation/devicetree/bindings/clock/*rk312*.txt

Author: Elaine Zhang <zhangqing@rock-chips.com>
    dt-bindings: add documentation for rk3126 clock
Author: Elaine Zhang <zhangqing@rock-chips.com>
    dt-bindings: add bindings for rk3128 clock controller
---
 .../bindings/clock/rockchip,rk3128-cru.txt    | 58 ---------------
 .../bindings/clock/rockchip,rk3128-cru.yaml   | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
deleted file mode 100644
index 6f8744fd301b..000000000000
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
index 000000000000..b77aec3a6f8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - xin24m
+        - ext_i2s
+        - gmac_clkin
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

