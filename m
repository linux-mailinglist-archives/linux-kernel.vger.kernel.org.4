Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12155F702F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiJFVZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiJFVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:25:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC82A50DC;
        Thu,  6 Oct 2022 14:25:39 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CDF20660231F;
        Thu,  6 Oct 2022 22:25:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665091538;
        bh=dXF4O4gpDnjt0O5eIiuVLOMCgRI/gmY9KdHbdkGVZ3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUD8hw3DmVqJhDC4Io8seOVm10K/f+Z6vxROh99D/QSplerbbCjYnYGkkUCO1ETaK
         xtEYx0e/O3RSL6TwWdH9hUewsd65TwGAGpf4BLkUkcwAQdG5dNybJMzfJink0loOws
         6mZsYWCJ0lPfBLSh9MhlXSQjijPNSkQlYgxuOIZ7kE5QKgmjGtZMNWKwpB1SteWTgd
         gXXRf46tZCISp+KHlHQtEzi6+e7HKDnblxWN3oks1HrTdrbgfcSk7Nine58hqjSU1y
         vf8RTumusWH2jEuwzP+93tWY8HRHSR3Qq5AXVgUB2dDfsOzu/vH02gPWkPHrkQ6Q7S
         x7Uk0M6vYM/Og==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/5] arm64: dts: mediatek: asurada: Enable internal display
Date:   Thu,  6 Oct 2022 17:25:26 -0400
Message-Id: <20221006212528.103790-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006212528.103790-1-nfraprado@collabora.com>
References: <20221006212528.103790-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asurada platform has an ANX7625 bridge connecting the DSI's output
to the internal eDP panel. Add and enable these devices in order to get
a usable internal display.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

(no changes since v1)

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 666021ca4d4f..ace44827de17 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -198,6 +198,14 @@ wifi_restricted_dma_region: wifi@c0000000 {
 	};
 };
 
+&dsi0 {
+	status = "okay";
+};
+
+&dsi_out {
+	remote-endpoint = <&anx7625_in>;
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -246,6 +254,53 @@ &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins>;
+
+	anx_bridge: anx7625@58 {
+		compatible = "analogix,anx7625";
+		reg = <0x58>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&anx7625_pins>;
+		enable-gpios = <&pio 41 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 42 GPIO_ACTIVE_HIGH>;
+		vdd10-supply = <&pp1000_mipibrdg>;
+		vdd18-supply = <&pp1800_mipibrdg>;
+		vdd33-supply = <&pp3300_mipibrdg>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				anx7625_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				anx7625_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+
+		aux-bus {
+			panel: panel {
+				compatible = "edp-panel";
+				power-supply = <&pp3300_mipibrdg>;
+				backlight = <&backlight_lcd0>;
+
+				port {
+					panel_in: endpoint {
+						remote-endpoint = <&anx7625_out>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &i2c7 {
@@ -256,6 +311,10 @@ &i2c7 {
 	pinctrl-0 = <&i2c7_pins>;
 };
 
+&mipi_tx0 {
+	status = "okay";
+};
+
 &mmc0 {
 	status = "okay";
 
@@ -587,6 +646,20 @@ &pio {
 			  "AUD_DAT_MISO0",
 			  "AUD_DAT_MISO1";
 
+	anx7625_pins: anx7625-default-pins {
+		pins-out {
+			pinmux = <PINMUX_GPIO41__FUNC_GPIO41>,
+				 <PINMUX_GPIO42__FUNC_GPIO42>;
+			output-low;
+		};
+
+		pins-in {
+			pinmux = <PINMUX_GPIO6__FUNC_GPIO6>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
 	cr50_int: cr50-irq-default-pins {
 		pins-gsc-ap-int-odl {
 			pinmux = <PINMUX_GPIO171__FUNC_GPIO171>;
-- 
2.37.3

