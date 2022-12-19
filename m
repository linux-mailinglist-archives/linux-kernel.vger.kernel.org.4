Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B4650BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiLSMdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiLSMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:32:56 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66314E0CD;
        Mon, 19 Dec 2022 04:32:42 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n20so21206200ejh.0;
        Mon, 19 Dec 2022 04:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRTqsLI2b2YsvDdVO9/6yWrmQPlgT8dFZzpQy/bIyGI=;
        b=gtCrkkbTEllDZdO0wm7gMlkgONZX8jVL2tQZ9WWGYA8ovSVR8fmpVW3gYvPUkv+6wK
         lfnZooWVg5rRyt0wlnaXJK/KM7DDFj+p+P9g/gvQgYjMXm+zQunkPjhH9EfDunLwhmIj
         VniDcAnzI+1N5j9fKoK/SXQnhXB6ivq+n42manNhfRv4YMVzMZCqKxcHMW2/NcwJeFOF
         1d4Hp8m/iDRmhDyOAsDvUebpEbM0vQ4jzTsSrRTrSVUDqexF12cSGPNybnjP7Riwj4MI
         0+SXvoA16GX0O5RXsE7Kl8436VwtIuNlrp1yLI2jxU6iEgorPlmi5EX4eG3icoPXqrgE
         fC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IRTqsLI2b2YsvDdVO9/6yWrmQPlgT8dFZzpQy/bIyGI=;
        b=5dXcgDqeJ3lnrPqoE4Mdhpgz2ntIabxiX+w9lWfHf5sTCug1OK0uQV62r9f2FH3IFz
         wGmpz7fvY/NRKZGQ6gk7zVS/9wbezOr3TTqlENzFHXtrkGllVfbeQfbVUczJWOBbV02b
         DtVYtJp6GiTv55/N04oTicd9bGRtL/Ju7yXviUmCSBgXYPX0gHObdsY0tFiO3XwlInOV
         8QkbqUjufXNqoNxnR9WOffIBgDP8AYufeMOmKiqMpacv43c4eKxRIZZ42yY18hMBP31j
         hQQoxWm451aM3ZueINEXkpC2rLGUSzsl/UYyduHZ9xJgF9JP5lJSUl1tnoLXpgD0gD2/
         WjWQ==
X-Gm-Message-State: ANoB5pnYmJKiIYlDmBas+gvjnUIdWWr90FFOoHiREXx9NBuWwRyouy6X
        2gdAC3AYw7zGoOIDGzvx0Zg=
X-Google-Smtp-Source: AA0mqf7750vDn7poUjTOipnHyBAqDup3nqcg4fWWOss4Du/caQ3c+ynRsmG+gfPVQjefoPjeepAlVQ==
X-Received: by 2002:a17:906:1984:b0:7c0:8c83:79b8 with SMTP id g4-20020a170906198400b007c08c8379b8mr35895700ejd.53.1671453160787;
        Mon, 19 Dec 2022 04:32:40 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c13-20020a0564021f8d00b0046b471596e6sm4315928edc.57.2022.12.19.04.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 04:32:40 -0800 (PST)
Message-ID: <fd51df66-147d-d40f-913e-385625a71984@gmail.com>
Date:   Mon, 19 Dec 2022 13:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3] dt-bindings: display: rockchip: convert rockchip-lvds.txt
 to YAML
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
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

Convert rockchip-lvds.txt to YAML.

Changed:
  Add power-domains property.
  Requirements between PX30 and RK3288

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
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

