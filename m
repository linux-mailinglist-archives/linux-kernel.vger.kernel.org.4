Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70866429CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiLENof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiLENoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:44:00 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E91DF05;
        Mon,  5 Dec 2022 05:43:25 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 94B6DFF80A;
        Mon,  5 Dec 2022 13:42:52 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Samuel Holland <samuel@sholland.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Angus Ainslie <angus@akkea.ca>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Andy Gross <agross@kernel.org>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        David Jander <david@protonic.nl>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 9/9] arm64: dts: rockchip: fix touchscreen reset GPIO polarity
Date:   Mon,  5 Dec 2022 14:40:38 +0100
Message-Id: <20221103-upstream-goodix-reset-v3-9-0975809eb183@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103-upstream-goodix-reset-v3-0-0975809eb183@theobroma-systems.com>
References: <20221103-upstream-goodix-reset-v3-0-0975809eb183@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The reset line is active low for the Goodix touchscreen controller so
let's fix the polarity in the Device Tree node.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts          | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index c1bbd555f5f5b..2087dc7299446 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -420,7 +420,7 @@ touchscreen@14 {
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
 		irq-gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
-		reset-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_LOW>;
 		VDDIO-supply = <&vcc3v3_lcd>;
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 78157521e9449..e63491fb443be 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -588,7 +588,7 @@ touch: touchscreen@5d {
 		AVDD28-supply = <&vcc3v0_touch>;
 		VDDIO-supply = <&vcc3v0_touch>;
 		irq-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_LOW>;
 		status = "disabled";
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 674792567fa6e..234531aaa430a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -495,7 +495,7 @@ touchscreen0: goodix@14 {
 		irq-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&touch_int &touch_rst>;
-		reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
 		VDDIO-supply = <&vcc3v3_lcd0_n>;
 	};
 };

-- 
b4 0.10.1
