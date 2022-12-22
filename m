Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ABB6542E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiLVO0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiLVO0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:26:33 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BCB10FC6;
        Thu, 22 Dec 2022 06:26:31 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id t17so5324133eju.1;
        Thu, 22 Dec 2022 06:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gW1/jKASy/dqoUo1+IoY1GOe6slGbC7iNfS7dQCoHa8=;
        b=oQfQc5C+Y/yHo7qep+yb34cr7QFdvqKZFnoJwV3zpbaq2I23e93oQRVd/dB9jLkWO1
         qKs0MV9Zzde+IHDgXjE0nUA3avMLUann2hqT2BG6nFYtIzGwmkKa4J7a0GXgOtY06pY2
         4v2rKKLHuBvFMqhJORBeFhJTx34c7/j8vM26scCMF9ir+Rk+ScS33aIAZbssp4Owidng
         XnoDgfK0KUvgROb3EbZvEM9ZoDbK4YZpHhaeyv71qFhAljGtn0mAy3kNxZa30mj6sNIE
         TtFUdkp0gfGk4TTI9tsPubbXgx/y1Ol6KLvF7yxJJS8C40WQDowGXmdmEMkshqENHN/b
         Yggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gW1/jKASy/dqoUo1+IoY1GOe6slGbC7iNfS7dQCoHa8=;
        b=ldNXsIkA4oLujXnCnPwM93zT3h4YR9foHXR5zODaDaa6h3pV+iPpabhbEz8OIaSg5H
         Ky+drRNAs7pTrZ/jGNOUcDua7yq27ecYOcMY9qgygjwPi67YMqUa6inq+xVWBlv4TSNn
         2ms4bZ0KYuegEU25M8Je+zTmxD0er/fnSLzS6CgV4HsspOF1d6VAhgwkNKvzuYaGvszg
         eVbNz7jbQGwViZZKHbsuAqnCazkb/BKlHFno9qcm/+CIcyXwPH4sUykMtgCoLXYXunyS
         BmBtXkNtlkrBIEQ6Dg24LJezfvC2cU27W3/ViGJpAeqbz3vieIw6WLIMgF8FYUUsLizy
         zd8Q==
X-Gm-Message-State: AFqh2ko1I3n8MVjVBE140fJdH7QDJ1PTPugHw8pNy5RtTUgOPStBKzDz
        iqgbErpz6aNB6JnJ8YgRuM0=
X-Google-Smtp-Source: AMrXdXt5nWXarIXQUAhJJSBfW55uS6pZyVRA/D1pYXQIoxDY53hZhCWczlOJSWd3LRtyB+JhGKnriQ==
X-Received: by 2002:a17:907:d311:b0:829:5e3f:3c92 with SMTP id vg17-20020a170907d31100b008295e3f3c92mr6306751ejc.73.1671719190095;
        Thu, 22 Dec 2022 06:26:30 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0073c10031dc9sm303336ejd.80.2022.12.22.06.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:26:29 -0800 (PST)
Message-ID: <d6dc8453-4807-0a5d-15bf-6dcf80dcd0fe@gmail.com>
Date:   Thu, 22 Dec 2022 15:26:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 05/17] dt-bindings: display: rockchip: convert
 dw_mipi_dsi_rockchip.txt to yaml
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
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Content-Language: en-US
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
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

Convert dw_mipi_dsi_rockchip.txt to yaml.

Changed:
  file name
  requirements

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V6:
  Remove clock-master property
  Fix $ref
---
 .../display/rockchip/dw_mipi_dsi_rockchip.txt |  94 ----------
 .../rockchip/rockchip,dw-mipi-dsi.yaml        | 166 ++++++++++++++++++
 2 files changed, 166 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
deleted file mode 100644
index 9a223df85..000000000
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-Rockchip specific extensions to the Synopsys Designware MIPI DSI
-================================
-
-Required properties:
-- #address-cells: Should be <1>.
-- #size-cells: Should be <0>.
-- compatible: one of
-	"rockchip,px30-mipi-dsi", "snps,dw-mipi-dsi"
-	"rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi"
-	"rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi"
-	"rockchip,rk3568-mipi-dsi", "snps,dw-mipi-dsi"
-- reg: Represent the physical address range of the controller.
-- interrupts: Represent the controller's interrupt to the CPU(s).
-- clocks, clock-names: Phandles to the controller's pll reference
-  clock(ref) when using an internal dphy and APB clock(pclk).
-  For RK3399, a phy config clock (phy_cfg) and a grf clock(grf)
-  are required. As described in [1].
-- rockchip,grf: this soc should set GRF regs to mux vopl/vopb.
-- ports: contain a port node with endpoint definitions as defined in [2].
-  For vopb,set the reg = <0> and set the reg = <1> for vopl.
-- video port 0 for the VOP input, the remote endpoint maybe vopb or vopl
-- video port 1 for either a panel or subsequent encoder
-
-Optional properties:
-- phys: from general PHY binding: the phandle for the PHY device.
-- phy-names: Should be "dphy" if phys references an external phy.
-- #phy-cells: Defined when used as ISP phy, should be 0.
-- power-domains: a phandle to mipi dsi power domain node.
-- resets: list of phandle + reset specifier pairs, as described in [3].
-- reset-names: string reset name, must be "apb".
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/media/video-interfaces.txt
-[3] Documentation/devicetree/bindings/reset/reset.txt
-
-Example:
-	mipi_dsi: mipi@ff960000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
-		reg = <0xff960000 0x4000>;
-		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_MIPI_24M>, <&cru PCLK_MIPI_DSI0>;
-		clock-names = "ref", "pclk";
-		resets = <&cru SRST_MIPIDSI0>;
-		reset-names = "apb";
-		rockchip,grf = <&grf>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			mipi_in: port@0 {
-				reg = <0>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				mipi_in_vopb: endpoint@0 {
-					reg = <0>;
-					remote-endpoint = <&vopb_out_mipi>;
-				};
-				mipi_in_vopl: endpoint@1 {
-					reg = <1>;
-					remote-endpoint = <&vopl_out_mipi>;
-				};
-			};
-
-			mipi_out: port@1 {
-				reg = <1>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				mipi_out_panel: endpoint {
-					remote-endpoint = <&panel_in_mipi>;
-				};
-			};
-		};
-
-		panel {
-			compatible ="boe,tv080wum-nl0";
-			reg = <0>;
-
-			enable-gpios = <&gpio7 3 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&lcd_en>;
-			backlight = <&backlight>;
-
-			port {
-				panel_in_mipi: endpoint {
-					remote-endpoint = <&mipi_out_panel>;
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
new file mode 100644
index 000000000..8e8a40879
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-mipi-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip specific extensions to the Synopsys Designware MIPI DSI
+
+maintainers:
+  - Sandy Huang <hjc@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - rockchip,px30-mipi-dsi
+          - rockchip,rk3288-mipi-dsi
+          - rockchip,rk3399-mipi-dsi
+          - rockchip,rk3568-mipi-dsi
+      - const: snps,dw-mipi-dsi
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    oneOf:
+      - minItems: 2
+        items:
+          - const: ref
+          - const: pclk
+          - const: phy_cfg
+          - const: grf
+      - const: pclk
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      This SoC uses GRF regs to switch between vopl/vopb.
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: dphy
+
+  "#phy-cells":
+    const: 0
+    description:
+      Defined when in use as ISP phy.
+
+  power-domains:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - rockchip,grf
+
+allOf:
+  - $ref: /schemas/display/bridge/snps,dw-mipi-dsi.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,px30-mipi-dsi
+              - rockchip,rk3568-mipi-dsi
+
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          maxItems: 1
+
+      required:
+        - phys
+        - phy-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3288-mipi-dsi
+
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3399-mipi-dsi
+
+    then:
+      properties:
+        clocks:
+          minItems: 4
+
+        clock-names:
+          minItems: 4
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3288-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mipi_dsi: dsi@ff960000 {
+      compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
+      reg = <0xff960000 0x4000>;
+      interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_MIPI_DSI0>;
+      clock-names = "ref", "pclk";
+      resets = <&cru SRST_MIPIDSI0>;
+      reset-names = "apb";
+      rockchip,grf = <&grf>;
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mipi_in: port@0 {
+          reg = <0>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          mipi_in_vopb: endpoint@0 {
+            reg = <0>;
+            remote-endpoint = <&vopb_out_mipi>;
+          };
+          mipi_in_vopl: endpoint@1 {
+            reg = <1>;
+            remote-endpoint = <&vopl_out_mipi>;
+          };
+        };
+
+        mipi_out: port@1 {
+          reg = <1>;
+
+          mipi_out_panel: endpoint {
+            remote-endpoint = <&panel_in_mipi>;
+          };
+        };
+      };
+    };
--
2.20.1

