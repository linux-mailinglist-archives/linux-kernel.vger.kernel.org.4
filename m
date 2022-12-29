Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B275165929A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 23:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiL2WqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 17:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiL2Wp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:45:56 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E0C2BF1;
        Thu, 29 Dec 2022 14:45:55 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 963BD320039A;
        Thu, 29 Dec 2022 17:45:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Dec 2022 17:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672353954; x=1672440354; bh=PX
        x4B1NSIilOzh33vZmfVaL9m9brucnpq6fUhPzxVlc=; b=LpOu1RQWbjSpJ/1W5M
        KB6ZfKNg6gkp93mmJhl4WBuBi9CxcWfprEK6pHDSXiL7jR5mpCFeoBhEkhMqGF+j
        LAeUn2gfMXOB8vn1ypefQvm2/iWenC31hGYiRgKwIQYA4aX2pJhLIyo30rzxynhx
        vhEFKm2L2KY0reDi0KPFsxpUr74Bm+whJ29GthMWOor5IrWBLx+ss+g/9XpCTCRW
        iFgh97tsLy2iqyxpQkJJR6GShuTfFD/UrVRc2IqKiwHvawaWgLOMhLy1xStmt7Q/
        988DPg9sF3SyMfQ4+4GBoLdyVNiOEHdI8Gh+pJmD9G8nKGMkGHdGUAuqa0YVsfIQ
        S0yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672353954; x=1672440354; bh=PXx4B1NSIilOz
        h33vZmfVaL9m9brucnpq6fUhPzxVlc=; b=p5lYUwZGRwu81OEKlZoYLzUnLQrhC
        aqw8oUuOZkxpveTOiceM8A+ayeF9JWpS/WR4AUeubEhiM24amFJveQVw7MkdqFhl
        43N0pIHJay4Ll3iXymUzibkTPdegfUQHPoD++FLLMeRfl5HyvHItGZ81+H/NNoEP
        cGJKzLBDxpGrs/SVnh8Jq/WDCHSlt1VqrWB8V8DjDgoeTKwBIWqBq8NSFoWeGkmH
        lWGZ0CIR0z8d/Rbh3XUCcEqHj617rvmy+PGDpYNwXwqh1NHdWRT5Uw+R9HTfws7Z
        CNvRBTIgj27ORo7ILiyUtDCRYB6U72y2NuG/aYfewWXteOpmw2j5U4DAQ==
X-ME-Sender: <xms:ohiuYxMw6-GZQnEVIVHB37bIqrZftthNGL956jcPn35Zd8Cwvs3iwA>
    <xme:ohiuYz-mzpE6WhVKSvfrMpTziRyt8mCrjbjyYB7N_32Z03TwX3Woiv7f7CTwUvZ1z
    lXxfo4CyEsK22ZSqA>
X-ME-Received: <xmr:ohiuYwS7zZmTgh6HrkzuCPk9qf0uT6SB493u8gBIP1Hs8Qri_l79hkVG710xcCsXJ7pabgzUy1SS902ML8bToM7DPce580qLBZBtQqGUcns-8w1DV2InBYnbPfqHRFiUXBCEIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieehgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ohiuY9ukMXdORqeEiJ20AV6mExsrqomQEZHVM_Vx0mqBV6iZl2hL0w>
    <xmx:ohiuY5e3Z3oxLsKPEOfCMNyjphfNt36sHfukndBZNY40IWMcAAqMHQ>
    <xmx:ohiuY51xNf-x5iHpIzfWZRCVah3vmDub-m6dAdUnl-yFtdCGA6BoRg>
    <xmx:ohiuYzs-uolwmg3PuAuArwxqyB56HIUOZ93CmNpOyKWCu9_r-ACeYg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 17:45:53 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/2] ARM: dts: sun8i: A33: Add iNet U70B Rev 01
Date:   Thu, 29 Dec 2022 16:45:47 -0600
Message-Id: <20221229224547.25225-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221229224547.25225-1-samuel@sholland.org>
References: <20221229224547.25225-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a white-label 7" tablet board based on the A33 SoC. It features
a generic 1024x600 DPI panel, raw NAND for storage, and a Realtek 8723CS
Wi-Fi/Bluetooth chip.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun8i-a33-inet-u70b-rev01.dts    | 172 ++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a33-inet-u70b-rev01.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c014f4fc53c0..e4e985d5a66c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1349,6 +1349,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a33-et-q8-v1.6.dtb \
 	sun8i-a33-ga10h-v1.1.dtb \
 	sun8i-a33-inet-d978-rev2.dtb \
+	sun8i-a33-inet-u70b-rev01.dtb \
 	sun8i-a33-ippo-q8h-v1.2.dtb \
 	sun8i-a33-olinuxino.dtb \
 	sun8i-a33-q8-tablet.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a33-inet-u70b-rev01.dts b/arch/arm/boot/dts/sun8i-a33-inet-u70b-rev01.dts
new file mode 100644
index 000000000000..ac108a632659
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a33-inet-u70b-rev01.dts
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+
+/dts-v1/;
+
+#include "sun8i-a33.dtsi"
+#include "sun8i-reference-design-tablet.dtsi"
+
+/ {
+	model = "iNet U70B Rev 01";
+	compatible = "inet-tek,inet-u70b-rev01", "allwinner,sun8i-a33";
+
+	aliases {
+		ethernet0 = &rtl8723cs;
+	};
+
+	panel: panel {
+		compatible = "panel-dpi";
+		backlight = <&backlight>;
+		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+		power-supply = <&reg_dc1sw>;
+
+		panel-timing {
+			clock-frequency = <51000000>;
+			hactive = <1024>;
+			vactive = <600>;
+			hfront-porch = <162>;
+			hback-porch = <158>;
+			hsync-len = <20>;
+			vback-porch = <25>;
+			vfront-porch = <10>;
+			vsync-len = <3>;
+			hsync-active = <1>;
+			vsync-active = <1>;
+		};
+
+		port {
+			panel_in_tcon0: endpoint {
+				remote-endpoint = <&tcon0_out_panel>;
+			};
+		};
+	};
+
+	speaker_amp: audio-amplifier {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+		sound-name-prefix = "Speaker Amp";
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&codec {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
+&de {
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	accelerometer@18 {
+		compatible = "bosch,bma250";
+		reg = <0x18>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 10 IRQ_TYPE_EDGE_RISING>; /* PH10 / EINT10 */
+	};
+};
+
+&mmc1 {
+	pinctrl-0 = <&mmc1_pg_pins>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	non-removable;
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_dldo2>;
+	status = "okay";
+
+	rtl8723cs: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_LEVEL_LOW>; /* PL7 */
+	};
+};
+
+&nfc {
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		allwinner,rb = <0>;
+	};
+};
+
+&r_uart {
+	status = "disabled";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi-io";
+};
+
+&simplefb_lcd {
+	status = "okay";
+};
+
+&sound {
+	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
+	simple-audio-card,widgets = "Headphone", "Headphone Jack",
+				    "Microphone", "Internal Microphone",
+				    "Speaker", "Internal Speaker";
+	simple-audio-card,routing = "Headphone Jack", "HP",
+				    "Internal Speaker", "Speaker Amp OUTL",
+				    "Internal Speaker", "Speaker Amp OUTR",
+				    "Speaker Amp INL", "HP", /* PHONEOUT ??? */
+				    "Speaker Amp INR", "HP", /* PHONEOUT ??? */
+				    "Left DAC", "DACL",
+				    "Right DAC", "DACR",
+				    "ADCL", "Left ADC",
+				    "ADCR", "Right ADC",
+				    "MIC1", "Internal Microphone",
+				    "MIC2", "Headset Microphone",
+				    "Headset Microphone", "HBIAS",
+				    "Internal Microphone", "MBIAS";
+	status = "okay";
+};
+
+&tcon0 {
+	pinctrl-0 = <&lcd_rgb666_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_panel: endpoint {
+		remote-endpoint = <&panel_in_tcon0>;
+	};
+};
+
+&touchscreen {
+	reg = <0x40>;
+	compatible = "silead,gsl1680";
+	avdd-supply = <&reg_ldo_io1>;
+	touchscreen-size-x = <1024>;
+	touchscreen-size-y = <600>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pg_pins>, <&uart1_cts_rts_pg_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723cs-bt";
+		device-wake-gpios = <&r_pio 0 10 GPIO_ACTIVE_LOW>; /* PL10 */
+		enable-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		host-wake-gpios = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
+	};
+};
-- 
2.37.4

