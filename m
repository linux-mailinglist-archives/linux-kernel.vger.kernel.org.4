Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FBF6542CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiLVOWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbiLVOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:22:27 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E722872E;
        Thu, 22 Dec 2022 06:22:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c17so3085308edj.13;
        Thu, 22 Dec 2022 06:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oICMjrhWPQNlOjRYsHXcTIDJG/XY6KY3jXRiCxaOR5k=;
        b=mUGPHBW4QRXeFFV7FJDSbecBTqr1tslLU3yOCyBavt55l7X11d5hyqA9/Brcwvrees
         FNG4XOQ8HhLRxyfAxl6C/Dwhq66DzSxbDNpIXFwCVl9e0AYUo+aip7v5Cq+rGFqi7ISP
         RFCcozGWwpjAjP1ScW0zEwJiqnvI1lSg7+B7vsE2PwguQdwp+DovtF939ER5rNxLt5WT
         vNxiXo03obALBaRWG1brVYep0VA3Z6GeC/rHJ3ndxvnI3XfqhSvmkS8c/e+yEm/KM/DE
         7cxJRjifEcT5L1su9TCkWsRp1AWCvHHHYoBTdboLo/ucSWSJCEsWn9HdPeEfacD5Spx/
         caSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oICMjrhWPQNlOjRYsHXcTIDJG/XY6KY3jXRiCxaOR5k=;
        b=o8uPpxOwazKKn567RLDW8biuv5X9eUEhg9TLMUjYdcA+rXE13K+W79zaNg+8T4JxEB
         LyryUx9pyQTTxlTUZhBc6Gg+6GWK0wZsRG/dNGV71b6jOJYj2HO83VhFCciPwNlGfv2A
         aM3neWNAW7/vVZf6ezj4sxYrmpNQK78m2jJrJvNX1K7rSJWyIoXScfyyWUAY/sNJWDyy
         Vw7wLbDSBVUu1nHc+Y1TClbfajOv7de+L0KtRg1gPKOW02woqHPREQJ5b2qvhPJn5m+2
         qKWVQ2WXXWkOswyFobnVSXkIaMt/mkHrcOn+0Y5r01i1ijaf0aRpN3DgDP1a6gBsRZ3n
         W0vQ==
X-Gm-Message-State: AFqh2koxiFnC/M3YLOUpJFT5S4Un+m9Xkejrgc51o/V/QYEJt3+fR5eh
        psl1Al/H8DobjF+17o7/pzA=
X-Google-Smtp-Source: AMrXdXtEz8EfVtvD9kAV2temSw86S2imfQcIVy6XS9fb1KMtCwWpEnJA6CGg+F96FSZHVL2zWnWybg==
X-Received: by 2002:a05:6402:5254:b0:461:bf05:2be1 with SMTP id t20-20020a056402525400b00461bf052be1mr6593252edd.0.1671718937371;
        Thu, 22 Dec 2022 06:22:17 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id by13-20020a0564021b0d00b0046bd3b366f9sm428708edb.32.2022.12.22.06.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:22:16 -0800 (PST)
Message-ID: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Date:   Thu, 22 Dec 2022 15:22:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 01/17] dt-bindings: display: rockchip: convert
 rockchip-lvds.txt to YAML
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
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

Convert rockchip-lvds.txt to YAML.

Changed:
  Add power-domains property.
  Requirements between PX30 and RK3288

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changed V3:
  Filename matching compatible style
  Drop "Regulator phandle for "
  Specify properties and requirements per SoC
  Sort order and restyle

Changed V2:
  Fix title
---
 .../display/rockchip/rockchip,lvds.yaml       | 170 ++++++++++++++++++
 .../display/rockchip/rockchip-lvds.txt        |  92 ----------
 2 files changed, 170 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
new file mode 100644
index 000000000..03b002a05
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip,lvds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip low-voltage differential signal (LVDS) transmitter
+
+maintainers:
+  - Sandy Huang <hjc@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-lvds
+      - rockchip,rk3288-lvds
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pclk_lvds
+
+  avdd1v0-supply:
+    description: 1.0V analog power.
+
+  avdd1v8-supply:
+    description: 1.8V analog power.
+
+  avdd3v3-supply:
+    description: 3.3V analog power.
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the general register files syscon.
+
+  rockchip,output:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [rgb, lvds, duallvds]
+    description: This describes the output interface.
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: dphy
+
+  pinctrl-names:
+    const: lcdc
+
+  pinctrl-0: true
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port 0 for the VOP input.
+          The remote endpoint maybe vopb or vopl.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port 1 for either a panel or subsequent encoder.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - rockchip,grf
+  - rockchip,output
+  - ports
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,px30-lvds
+
+    then:
+      properties:
+        reg: false
+        clocks: false
+        clock-names: false
+        avdd1v0-supply: false
+        avdd1v8-supply: false
+        avdd3v3-supply: false
+
+      required:
+        - phys
+        - phy-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3288-lvds
+
+    then:
+      properties:
+        phys: false
+        phy-names: false
+
+      required:
+        - reg
+        - clocks
+        - clock-names
+        - avdd1v0-supply
+        - avdd1v8-supply
+        - avdd3v3-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3288-cru.h>
+
+    lvds: lvds@ff96c000 {
+      compatible = "rockchip,rk3288-lvds";
+      reg = <0xff96c000 0x4000>;
+      clocks = <&cru PCLK_LVDS_PHY>;
+      clock-names = "pclk_lvds";
+      avdd1v0-supply = <&vdd10_lcd>;
+      avdd1v8-supply = <&vcc18_lcd>;
+      avdd3v3-supply = <&vcca_33>;
+      pinctrl-names = "lcdc";
+      pinctrl-0 = <&lcdc_ctl>;
+      rockchip,grf = <&grf>;
+      rockchip,output = "rgb";
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lvds_in: port@0 {
+          reg = <0>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          lvds_in_vopb: endpoint@0 {
+            reg = <0>;
+            remote-endpoint = <&vopb_out_lvds>;
+          };
+          lvds_in_vopl: endpoint@1 {
+            reg = <1>;
+            remote-endpoint = <&vopl_out_lvds>;
+          };
+        };
+
+        lvds_out: port@1 {
+          reg = <1>;
+
+          lvds_out_panel: endpoint {
+            remote-endpoint = <&panel_in_lvds>;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
deleted file mode 100644
index aaf8c44cf..000000000
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
+++ /dev/null
@@ -1,92 +0,0 @@
-Rockchip RK3288 LVDS interface
-================================
-
-Required properties:
-- compatible: matching the soc type, one of
-	- "rockchip,rk3288-lvds";
-	- "rockchip,px30-lvds";
-
-- reg: physical base address of the controller and length
-	of memory mapped region.
-- clocks: must include clock specifiers corresponding to entries in the
-	clock-names property.
-- clock-names: must contain "pclk_lvds"
-
-- avdd1v0-supply: regulator phandle for 1.0V analog power
-- avdd1v8-supply: regulator phandle for 1.8V analog power
-- avdd3v3-supply: regulator phandle for 3.3V analog power
-
-- rockchip,grf: phandle to the general register files syscon
-- rockchip,output: "rgb", "lvds" or "duallvds", This describes the output interface
-
-- phys: LVDS/DSI DPHY (px30 only)
-- phy-names: name of the PHY, must be "dphy" (px30 only)
-
-Optional properties:
-- pinctrl-names: must contain a "lcdc" entry.
-- pinctrl-0: pin control group to be used for this controller.
-
-Required nodes:
-
-The lvds has two video ports as described by
-	Documentation/devicetree/bindings/media/video-interfaces.txt
-Their connections are modeled using the OF graph bindings specified in
-	Documentation/devicetree/bindings/graph.txt.
-
-- video port 0 for the VOP input, the remote endpoint maybe vopb or vopl
-- video port 1 for either a panel or subsequent encoder
-
-Example:
-
-lvds_panel: lvds-panel {
-	compatible = "auo,b101ean01";
-	enable-gpios = <&gpio7 21 GPIO_ACTIVE_HIGH>;
-	data-mapping = "jeida-24";
-
-	ports {
-		panel_in_lvds: endpoint {
-			remote-endpoint = <&lvds_out_panel>;
-		};
-	};
-};
-
-For Rockchip RK3288:
-
-	lvds: lvds@ff96c000 {
-		compatible = "rockchip,rk3288-lvds";
-		rockchip,grf = <&grf>;
-		reg = <0xff96c000 0x4000>;
-		clocks = <&cru PCLK_LVDS_PHY>;
-		clock-names = "pclk_lvds";
-		pinctrl-names = "lcdc";
-		pinctrl-0 = <&lcdc_ctl>;
-		avdd1v0-supply = <&vdd10_lcd>;
-		avdd1v8-supply = <&vcc18_lcd>;
-		avdd3v3-supply = <&vcca_33>;
-		rockchip,output = "rgb";
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			lvds_in: port@0 {
-				reg = <0>;
-
-				lvds_in_vopb: endpoint@0 {
-					reg = <0>;
-					remote-endpoint = <&vopb_out_lvds>;
-				};
-				lvds_in_vopl: endpoint@1 {
-					reg = <1>;
-					remote-endpoint = <&vopl_out_lvds>;
-				};
-			};
-
-			lvds_out: port@1 {
-				reg = <1>;
-
-				lvds_out_panel: endpoint {
-					remote-endpoint = <&panel_in_lvds>;
-				};
-			};
-		};
-	};
--
2.20.1

