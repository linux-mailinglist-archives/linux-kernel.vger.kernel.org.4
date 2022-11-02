Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834C7616D67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKBTGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiKBTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:06:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A8C4D;
        Wed,  2 Nov 2022 12:06:25 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19A4366028F8;
        Wed,  2 Nov 2022 19:06:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667415984;
        bh=cAWS2o7ezo8lcFTLvtHcfgbNs2i5XRzG1MatYzmAa7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PG6t0H5cZwbo4xAkZShlrqbnZL965LVlR0PxoTqsItZVoxk392J3IfLeTwAR2CUBa
         oW87ZVKbApzTsorMEeKZ+frpqCI/dhiUzqosZU7yjd/VVfdX6XEp7hNzj1QTmuOuFw
         N/SLnt4MC244GyHTMFkq+sbuTCAzTtSsgBgWJsMKQtzwemJVfe5V6tVvNVk6W4REWR
         /e8a7AwBxNKFaNGuuMqirgaLtbdyKOn2iQInzq0Y03umd4TPduhnvdnMw5rl4R4p1p
         W/d4TgHvZCa1hOt1hfZaOyC6HQCvGlXi4oeDICIbV1EY4rWTX4DIvjrtCfki+zNss9
         acIOQT9ZOYtSg==
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
Subject: [PATCH v3 2/5] arm64: dts: mediatek: asurada: Add display backlight
Date:   Wed,  2 Nov 2022 15:06:08 -0400
Message-Id: <20221102190611.283546-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102190611.283546-1-nfraprado@collabora.com>
References: <20221102190611.283546-1-nfraprado@collabora.com>
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

Add the display backlight for the Asurada platform. It relies on the
display PWM controller, so also enable and configure this component.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

(no changes since v1)

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index fafca7428539..666021ca4d4f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -23,6 +23,16 @@ memory@40000000 {
 		reg = <0 0x40000000 0 0x80000000>;
 	};
 
+	backlight_lcd0: backlight-lcd0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 500000>;
+		power-supply = <&ppvar_sys>;
+		enable-gpios = <&pio 152 0>;
+		brightness-levels = <0 1023>;
+		num-interpolated-steps = <1023>;
+		default-brightness-level = <576>;
+	};
+
 	pp1000_dpbrdg: regulator-1v0-dpbrdg {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1000_dpbrdg";
@@ -838,6 +848,17 @@ pins-pcie-en-pp3300-wlan {
 		};
 	};
 
+	pwm0_pins: pwm0-default-pins {
+		pins-pwm {
+			pinmux = <PINMUX_GPIO40__FUNC_DISP_PWM>;
+		};
+
+		pins-inhibit {
+			pinmux = <PINMUX_GPIO152__FUNC_GPIO152>;
+			output-high;
+		};
+	};
+
 	scp_pins: scp-pins {
 		pins-vreq-vao {
 			pinmux = <PINMUX_GPIO195__FUNC_SCP_VREQ_VAO>;
@@ -899,6 +920,13 @@ &pmic {
 	interrupts-extended = <&pio 214 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&pwm0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+};
+
 &scp {
 	status = "okay";
 
-- 
2.38.1

