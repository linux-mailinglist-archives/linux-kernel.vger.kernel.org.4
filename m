Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15416ECA34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjDXKVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjDXKU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:56 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8223740C8;
        Mon, 24 Apr 2023 03:20:47 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 2D61A5EC9B;
        Mon, 24 Apr 2023 12:36:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-DO2DGfwZ;
        Mon, 24 Apr 2023 12:36:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328975;
        bh=MHtC+x7Nk6zDHQMz3E9EYKvVN3fdjWz35RMA8IIFDBY=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=eF/fuaAg2Wixu16rA5g6MPxzwXI/YlqSBbShJHYZXPqHnBXY6Ijv+a3Sq/GJcoWse
         DyqPRLRYSjoDb/m4JtWXXI1KvvPH2dp6+kSsxRFIrluL12X3XvyDkh5z2nUiZZCvt+
         2LTRB+DDWCWASQXAJHY15EYzflynR46urzY9Asjg=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 42/43] ARM: dts: ep93xx: Add EDB9302 DT
Date:   Mon, 24 Apr 2023 15:34:58 +0300
Message-Id: <20230424123522.18302-43-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Missing parts:
- USB

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/boot/dts/ep93xx-edb9302.dts | 150 +++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 arch/arm/boot/dts/ep93xx-edb9302.dts

diff --git a/arch/arm/boot/dts/ep93xx-edb9302.dts b/arch/arm/boot/dts/ep93xx-edb9302.dts
new file mode 100644
index 000000000000..4ca915384ba9
--- /dev/null
+++ b/arch/arm/boot/dts/ep93xx-edb9302.dts
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+/*
+ * Device Tree file for Cirrus Logic EDB9302 board based on EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "cirrus,edb9302", "cirrus,ep9301";
+	model = "cirrus,edb9302";
+
+	chosen {
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	soc {
+		flash@60000000 {
+			compatible = "cfi-flash";
+			reg = <0x60000000 0x1000000>;
+			bank-width = <2>;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "EDB93XX";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,convert-channels = <2>;
+		simple-audio-card,convert-sample-format = "s32_le";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s>;
+			system-clock-direction-out;
+			frame-master;
+			bitclock-master;
+			dai-sample-format = "s32_le";
+			dai-channels = <2>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
+	};
+};
+
+&pinctrl {
+	compatible = "cirrus,ep9301-pinctrl";
+};
+
+&gpio0 {
+	gpio-ranges = <&pinctrl 0 153 1>,
+		      <&pinctrl 1 152 1>,
+		      <&pinctrl 2 151 1>,
+		      <&pinctrl 3 148 1>,
+		      <&pinctrl 4 147 1>,
+		      <&pinctrl 5 146 1>,
+		      <&pinctrl 6 145 1>,
+		      <&pinctrl 7 144 1>;
+};
+
+&gpio1 {
+	gpio-ranges = <&pinctrl 0 143 1>,
+		      <&pinctrl 1 142 1>,
+		      <&pinctrl 2 141 1>,
+		      <&pinctrl 3 140 1>,
+		      <&pinctrl 4 165 1>,
+		      <&pinctrl 5 164 1>,
+		      <&pinctrl 6 163 1>,
+		      <&pinctrl 7 160 1>;
+};
+
+&gpio2 {
+	gpio-ranges = <&pinctrl 0 115 1>;
+	/delete-property/ status;
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+};
+
+&gpio4 {
+	gpio-ranges = <&pinctrl 0 97 2>;
+	/delete-property/ status;
+};
+
+&gpio5 {
+	gpio-ranges = <&pinctrl 1 170 1>,
+		      <&pinctrl 2 169 1>,
+		      <&pinctrl 3 168 1>;
+};
+
+&gpio6 {
+	gpio-ranges = <&pinctrl 0 87 2>;
+	/delete-property/ status;
+};
+
+&gpio7 {
+	gpio-ranges = <&pinctrl 2 199 4>;
+	/delete-property/ status;
+};
+
+&spi0 {
+	cs-gpios = <&gpio0 6 GPIO_ACTIVE_LOW
+		    &gpio0 7 GPIO_ACTIVE_LOW>;
+	use_dma;
+	/delete-property/ status;
+
+	codec: cs4271@0 {
+		compatible = "cirrus,cs4271";
+		#sound-dai-cells = <0>;
+		reg = <0>;
+		spi-max-frequency = <6000000>;
+		spi-cpol;
+		spi-cpha;
+		reset-gpio = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	eeprom: at25f1024@1 {
+		compatible = "atmel,at25";
+		reg = <1>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&adc {
+	/delete-property/ status;
+};
+
+&eth0 {
+	copy_addr;
+	phy_id = <1>;
+};
+
+&uart0 {
+	/delete-property/ status;
+};
+
+&uart1 {
+	/delete-property/ status;
+};
+
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s_on_ac97_pins>;
+	/delete-property/ status;
+};
-- 
2.39.2

