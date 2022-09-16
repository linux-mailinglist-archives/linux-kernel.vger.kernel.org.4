Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141E35BADA8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiIPM5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIPM5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:57:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA997DF73;
        Fri, 16 Sep 2022 05:57:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dv25so49180626ejb.12;
        Fri, 16 Sep 2022 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=FPivNq8LA76OgVX/HGykbL4ESvdAU89Ntka6IiSXkYo=;
        b=HBsACQgSMQBsakYq42c1Lv38FfOXxMq3p+Z6+hRYfwC7oBr1VXDysFxw+nQ5o3PjZ7
         gY9Ck3X3axZHsWb+BFwrSxw8Nx6uv9wC3V81WM4GFJvIawxUyLIGqEnid9LsQZEIxPKU
         lhC1CtR6hoJNqZOW2P6ybCltWZB5Hq1k3aWs8YR5KeL8m8BfflQLz5d89z7nX4EXDZkw
         6T5a8vyxE5xrZ3+KlOLXI0iUm2929EeY+OCuJf0l7Rsw7Bn8+fZ8bOskIyTWvQMD08n5
         MNFcj+m4IUGPgZ4/Az5dJSUczOFL/bmglIHi28fo8YZF6eNcwuqhF/ur9RuSd2ympMDW
         I5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FPivNq8LA76OgVX/HGykbL4ESvdAU89Ntka6IiSXkYo=;
        b=riqEJiNIXs4N+Qvoigs0zlmL16MSMf/dPe5FIeBohpEhro+rNO2OH+HS19+hnGR07D
         Q+GcsIQgp12MzpRPOjdb7KVBNrjIM2r6xu/86uKXtzAaLnHc+fqUfY4JGiRPiSgJcr3j
         wW4h8/fIuBCyzPi0DRMTFLVZa/ZhGUGGyPyyVc7cf1eOBZbQd7YeQFTxTt3bjKrW90Es
         tAZDRVjV6Zgt6++mGQ5sPdgX8wdBW3vr5LVwvcWb94L4vUed9aKr4rKKhLRacI6n0QKL
         4cO54s5KzeBoXRGIGMkKWZiZdv+CHqPvT1AFz9COXqG/Cdk+KJkmSGnVM9hIAYL7Sh8W
         mHhg==
X-Gm-Message-State: ACrzQf26U/abdom8B/54PwwvzSQfkm+9s2Gv4Y7s9qSJEYJRrarX8mOO
        nKG5VLU7x95c8aOtNApsmrTEgrk7lE6CQyG5
X-Google-Smtp-Source: AMsMyM5Zuin/kS49IbfvTjiXKhRSfJApkxZsCrk6nGuqKkHN3aUGrpD6bFwOyOA77ua6yBoWvmRacA==
X-Received: by 2002:a17:907:2da6:b0:730:8b30:e517 with SMTP id gt38-20020a1709072da600b007308b30e517mr3410476ejc.291.1663333063044;
        Fri, 16 Sep 2022 05:57:43 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.gmail.com with ESMTPSA id x6-20020a05640226c600b00445c0ab272fsm13719661edd.29.2022.09.16.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:57:42 -0700 (PDT)
Date:   Fri, 16 Sep 2022 12:52:55 +0000
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: rockchip: k3566-quartz64-a: fix names
 entries, refactor
Message-ID: <YyRxp7pDCyikNLGc@lab.hqhome163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix esisting "No underscores in node names" general rule, and prepare for
new board versions.

Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  2 +-
 ...-quartz64-a.dts => rk3566-quartz64-a.dtsi} | 27 ++++++++-----------
 .../dts/rockchip/rk3566-quartz64-a.usb3.dts   |  9 +++++++
 3 files changed, 21 insertions(+), 17 deletions(-)
 rename arch/arm64/boot/dts/rockchip/{rk3566-quartz64-a.dts => rk3566-quartz64-a.dtsi} (97%)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.usb3.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ef79a672804a..97ec6c156346 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -59,7 +59,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
-dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.usb3.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtsi
similarity index 97%
rename from arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
rename to arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtsi
index d943559b157c..ac3da5b2c1b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtsi
@@ -28,7 +28,7 @@ gmac1_clkin: external-gmac1-clock {
 		#clock-cells = <0>;
 	};
 
-	fan: gpio_fan {
+	fan: fan {
 		compatible = "gpio-fan";
 		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
 		gpio-fan,speed-map = <0    0
@@ -38,7 +38,7 @@ fan: gpio_fan {
 		#cooling-cells = <2>;
 	};
 
-	hdmi-con {
+	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
 
@@ -116,7 +116,7 @@ simple-audio-card,codec {
 		};
 	};
 
-	vcc12v_dcin: vcc12v_dcin {
+	vcc12v_dcin: vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -139,7 +139,7 @@ vbus: vbus {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
-	vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
+	vcc3v3_pcie_p: vcc3v3-p {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
@@ -151,7 +151,7 @@ vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
 		vin-supply = <&vcc_3v3>;
 	};
 
-	vcc5v0_usb: vcc5v0_usb {
+	vcc5v0_usb: vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -165,7 +165,7 @@ vcc5v0_usb: vcc5v0_usb {
 	 * the host ports are sourced from vcc5v0_usb
 	 * the otg port is sourced from vcc5v0_midu
 	 */
-	vcc5v0_usb20_host: vcc5v0_usb20_host {
+	vcc5v0_usb20_host: vcc5v0-usb20-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
@@ -177,7 +177,7 @@ vcc5v0_usb20_host: vcc5v0_usb20_host {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
-	vcc5v0_usb20_otg: vcc5v0_usb20_otg {
+	vcc5v0_usb20_otg: vcc5v0-usb20-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
@@ -187,7 +187,7 @@ vcc5v0_usb20_otg: vcc5v0_usb20_otg {
 		vin-supply = <&dcdc_boost>;
 	};
 
-	vcc3v3_sd: vcc3v3_sd {
+	vcc3v3_sd: vcc3v3-sd {
 		compatible = "regulator-fixed";
 		enable-active-low;
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
@@ -201,7 +201,7 @@ vcc3v3_sd: vcc3v3_sd {
 	};
 
 	/* sourced from vbus and vcc_bat+ via rk817 sw5 */
-	vcc_sys: vcc_sys {
+	vcc_sys: vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -212,7 +212,7 @@ vcc_sys: vcc_sys {
 	};
 
 	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
-	vcc_wl: vcc_wl {
+	vcc_wl: vcc-wl {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_wl";
 		regulator-always-on;
@@ -249,7 +249,7 @@ &cpu3 {
 
 &cpu_thermal {
 	trips {
-		cpu_hot: cpu_hot {
+		cpu_hot: cpu-hot {
 			temperature = <55000>;
 			hysteresis = <2000>;
 			type = "active";
@@ -788,11 +788,6 @@ &usb_host0_xhci {
 	status = "okay";
 };
 
-/* usb3 controller is muxed with sata1 */
-&usb_host1_xhci {
-	status = "okay";
-};
-
 &usb2phy0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.usb3.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.usb3.dts
new file mode 100644
index 000000000000..1739c00ea9e9
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.usb3.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3566-quartz64-a.dtsi"
+
+&usb_host1_xhci {
+	status = "okay";
+};
-- 
2.34.1

