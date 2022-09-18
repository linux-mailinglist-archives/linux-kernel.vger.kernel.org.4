Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF85BBE60
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiIRO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiIRO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:29:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3BA65C9;
        Sun, 18 Sep 2022 07:29:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y17so54036431ejo.6;
        Sun, 18 Sep 2022 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=FveU6nkoo+81cQCfrUzlLL5Yuhu16gBocdqQxDEMQCg=;
        b=BjP83lXkZjyctfT4Np2yzmqYCVKRXxOheLYomYNmMgc8IhvR9Xi8NRF02psi6zyRd5
         SVQ/RB60dZ5K5qRIE5XrEDuvSRBmOUAYJfJWLMvg4DYoxas+31zMn0MpBOyKne2V2hSv
         EHiXc1PkJcwGqGbwbyn+PEyRxqluJDlxdcfFuHoWrGljanCkrW4Fu37J566t2uFD4o4G
         KxEO1VjyJ0OM0kt+hsl1tSIDJtX0WjSMad0gkVWHfvmImMfOTv3mzkCfF6NR9mSA8a49
         Y+LAdYbFJGUR82P5RnkO5TA6Q3FXy22t7PjowGD86kVIlsqIKGh94UuGx2ov72170M57
         YCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=FveU6nkoo+81cQCfrUzlLL5Yuhu16gBocdqQxDEMQCg=;
        b=57mmMi6mnX4mjKoAw6ZcygYmnkdo4J8TEcoNT3zeYwgJ1vc1MaR4ZXY/SVqem5Lyz3
         x3MGN82GwvCKBmGQ0n4L521LBDvGxof7csvMUByX64V4DOlq94YULnpJa1XUtwf9oY/i
         ej25FMs2EnjuRKPOMkMzRr9sP2mGAoXTuc5xi9A6nFj47gF74T/HvFZmeq+Zof44G6+Z
         9PntOZEUE35TAUfu6iFBNPOfXYgfWu7cKsbcV229oAjL2/D2y2uxfDkRIdpjfeoN38PD
         4gxQJ1yRxy0p3NImZs/dYfxFC+/FKiCq4sB7F5bPTx+MlndnUJasm41PpqDkCeGVkyH9
         BxIg==
X-Gm-Message-State: ACrzQf2/unm9DXvQPadV+fSOlgR3Cb2FpBIFzJiTq+nSVWXy2BT6rzuH
        96k5qUbuCLoxj1panmOxxb4=
X-Google-Smtp-Source: AMsMyM7QTZ+2BOwNQu7fsiBYvlATBN/hD+pJTQiXqKGORiTZFqY5hh9qjZPO+ns5wlWpD7gRqFySWA==
X-Received: by 2002:a17:907:2d0d:b0:77c:d528:70b8 with SMTP id gs13-20020a1709072d0d00b0077cd52870b8mr9559188ejc.681.1663511383259;
        Sun, 18 Sep 2022 07:29:43 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709063b5300b0074134543f82sm13961670ejf.90.2022.09.18.07.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 07:29:42 -0700 (PDT)
Message-ID: <4e69a06d-7b53-ab48-1e50-2b29ff3a54e6@gmail.com>
Date:   Sun, 18 Sep 2022 16:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3] dt-bindings: clock: convert rockchip,rk3128-cru.txt to
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

Changed V3:
  Fix xin24m clock-names position

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
 .../bindings/clock/rockchip,rk3128-cru.txt    | 58 --------------
 .../bindings/clock/rockchip,rk3128-cru.yaml   | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 58 deletions(-)
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
index 000000000000..b3d9c8eca989
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
@@ -0,0 +1,76 @@
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
+    items:
+      - const: xin24m
+      - enum:
+          - ext_i2s
+          - gmac_clkin
+      - enum:
+          - ext_i2s
+          - gmac_clkin
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

