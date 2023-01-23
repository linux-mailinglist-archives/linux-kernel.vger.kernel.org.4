Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8182677D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjAWOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjAWOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:07:27 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7EFEFBE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:07:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k16so9106376wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOM0Eca2wLNLwVsrAjP09UxooHgz6p8OfLw7rL5X5RE=;
        b=bVU3+Al8QxVsFwVCHkUFLhDWbuDNlqbxUzTw1D3By6AchA9E8T+GGJ6uzveQyfnfoq
         XgRU+rhbBPYZthKcPhpxSdKPaW6nr+auaSAxrwstZ3G/c8jYxTyBamVL70TVV3+Ev0tR
         AgXS00F2CKZKFClcByjGHAlqZwFrN08uwYhlJ5OphlkrrAdC0EZ0wdNbAUDj7RTVslEt
         ZXICyxosTtRtUZbbGBwLxTAiH+P4D8+R384ttkiv7U2IZSSGgzEd6mwa/6+docnZvTyu
         64zv7F7P3hudWgIU2obGAywKQzevx/a9/sfDbbbE4w/adrloA76vVnonpvMUeIzy+IMK
         z6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOM0Eca2wLNLwVsrAjP09UxooHgz6p8OfLw7rL5X5RE=;
        b=CcWGxAYjWrhxA66xU8uRYKRYKyYD+tXPp1Fw2AmRkL/UmPBvIEDz/RpurgwvvHk0Di
         D+HvtQ6FmtRrLZeUOFd2Coj4F+qCXeH5I8uqa4BFxvBw7JBWN9Vrq49osjiy0uBzazaE
         JBSdMq0+NgnJKc8nfzffP71e2HvHVfENO6XM+//3ncH3u1DUqAhE1vE1ej4p71g2IEFQ
         C3HFX9oNqtlsNUnw1XxeKtCdV1kuBR5FENAOmOhLDhIzDxFlel9XAbeW7Z8w4OWaAsTx
         3qkZPBBj8n4ngAuQ5lb3Pw7Gx4QE4e+NsxDbjzBkBttOimzT4OFyrwoHVqQWBrig82+n
         1Bmg==
X-Gm-Message-State: AFqh2krhiNIkNl6wBiEz5piygRpI09r9f43FQYEdkAP3lwIrwpBAByJt
        PxBkoePVs5K2llV0Q+zFzw1MzQ==
X-Google-Smtp-Source: AMrXdXuHiQuGMgKBjg9uilstTFklfplMnjDxoxTUpmVxq7Bo136vGl2AQyJYrjcdxwfn+HwOy1SKUA==
X-Received: by 2002:a05:600c:502c:b0:3db:30d:deac with SMTP id n44-20020a05600c502c00b003db030ddeacmr24040411wmr.1.1674482844912;
        Mon, 23 Jan 2023 06:07:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003c6bbe910fdsm13841655wmo.9.2023.01.23.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:07:24 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 23 Jan 2023 15:07:18 +0100
Subject: [PATCH 3/3] arm64: dts: meson-g12b-odroid: Add initial support for
 Hardkernel ODROID-N2L
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-topic-odroid-n2l-upstream-initial-v1-3-1ce5e08039d0@linaro.org>
References: <20230122-topic-odroid-n2l-upstream-initial-v1-0-1ce5e08039d0@linaro.org>
In-Reply-To: <20230122-topic-odroid-n2l-upstream-initial-v1-0-1ce5e08039d0@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Dongjin Kim <tobetter@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODROID-N2L is a variant SBC in small form factor and some peripherals
are removed from ODROID-N2PLUS based on S922X SoC.

- On-board ethernet is removed
- On-board RTC is removed
- USB 3.0 hub is removed, so one USB 2.0 and one USB 3.0 host ports
  are available
- Huge heatsink is replaced with 40x40mm heatsink, 5V active heatsink
  is recommended or a tall passive sink is optional
- 3.5mm earjack is removed
- IR remote receiver is removed
- MIPI DSI port is added new but not yet supported

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2l.dts     | 125 +++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 97b42e2100e0..04114e8c9992 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-go-ultra.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-ugoos-am6.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-kii-pro.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
new file mode 100644
index 000000000000..3d8f41d63ec6
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Dongjin Kim <tobetter@gmail.com>
+ */
+
+/dts-v1/;
+
+/* The Amlogic S922X Rev. C supports the same OPPs as the A311D variant */
+#include "meson-g12b-a311d.dtsi"
+#include "meson-g12b-odroid-n2.dtsi"
+
+/ {
+	compatible = "hardkernel,odroid-n2l", "amlogic,s922x", "amlogic,g12b";
+	model = "Hardkernel ODROID-N2L";
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "ODROID-N2L";
+		audio-aux-devs = <&tdmout_b>, <&tdmin_a>, <&tdmin_b>,
+				 <&tdmin_c>, <&tdmin_lb>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"TDMIN_A IN 4", "TDM_B Loopback",
+				"TDMIN_B IN 4", "TDM_B Loopback",
+				"TDMIN_C IN 4", "TDM_B Loopback",
+				"TDMIN_LB IN 1", "TDM_B Loopback",
+				"TODDR_A IN 0", "TDMIN_A OUT",
+				"TODDR_B IN 0", "TDMIN_A OUT",
+				"TODDR_C IN 0", "TDMIN_A OUT",
+				"TODDR_A IN 1", "TDMIN_B OUT",
+				"TODDR_B IN 1", "TDMIN_B OUT",
+				"TODDR_C IN 1", "TDMIN_B OUT",
+				"TODDR_A IN 2", "TDMIN_C OUT",
+				"TODDR_B IN 2", "TDMIN_C OUT",
+				"TODDR_C IN 2", "TDMIN_C OUT",
+				"TODDR_A IN 6", "TDMIN_LB OUT",
+				"TODDR_B IN 6", "TDMIN_LB OUT",
+				"TODDR_C IN 6", "TDMIN_LB OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		dai-link-3 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link-4 {
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link-5 {
+			sound-dai = <&toddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-6 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-7 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&eth_phy {
+	status = "disabled";
+};
+
+&vddcpu_a {
+	regulator-min-microvolt = <680000>;
+	regulator-max-microvolt = <1040000>;
+
+	pwms = <&pwm_ab 0 1500 0>;
+};
+
+&vddcpu_b {
+	regulator-min-microvolt = <680000>;
+	regulator-max-microvolt = <1040000>;
+
+	pwms = <&pwm_AO_cd 1 1500 0>;
+};
+
+&usb2_phy0 {
+	vbus-supply = <&usb_pwr_en>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&usb_pwr_en>;
+};

-- 
2.34.1

