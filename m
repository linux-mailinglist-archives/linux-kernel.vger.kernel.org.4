Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F234067AB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjAYITC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjAYISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:18:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC794470BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:18:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h12so12201835wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42S+VqN9LTbh+aZs3DUPyk7eOYyO/WSy+YOH5CCdRvI=;
        b=VBXlWo7Ifpvo9JGRHEWseLgXSjcbd2zUjutSZIUi6oDlIXUxeie+fG4ndxcVLIbIku
         EGMoKMLRAetrDWiwayZ7a+tYVgytrfzYqhT+8OsYA7/aly7t0S3LhtiXVvO6BY2L4LcZ
         g/OhoAraGklYtGWV+LYq9EC5k9J5AEO3vtiplqwCMYNHTt5jCa8Boke5bGqIe2SCjm5p
         pSi4+vbh7zPno77KHuPirfLacIxGsvhQT0NCk//7Af4ZgdJbE1vcw958oAdia42wGzRU
         1RFffO429hgs2MfdIvLBsN9fijC4PkYlVxJVEsM4tNe2oHS82NUSweqQikwqjheQmLWd
         GN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42S+VqN9LTbh+aZs3DUPyk7eOYyO/WSy+YOH5CCdRvI=;
        b=UFLtbYt2ZK7nM1lo8Fx39yeFYO6o4XmSIxCaJf+wVMvznC5vNQ2xOl9mLsdIx3TQ4S
         gA83bmwFYG3eb0gGlXLqF8J1tGX3qEXqeBCAj4GpVD7wcMQkevxoBe5y2mGW+X90d6PU
         C/oEeKM/jh/NEwBWblK2doP/ov+0ZpYAjgqZ7J4wn+hZQleqQVO1JBlyyx3+XaRjR/7O
         12bP8ZBgIUC2lfw7HscppSxjOwcPssLwrw3lJKNG1V9Y9Tu/Yfn073cQdSOgexlE1MJ5
         2rhtnOlDA99WTbEfy6FUR7VZ2V56CGtArsukx0IM/jaA3gHMMvqGoRPyFi5Vg8CxFl+q
         sceQ==
X-Gm-Message-State: AO0yUKUo15ynnk+hKZ9tmtjLhXn8vnKj8kYT/6swcQlenPBzUtBJcqR/
        KrjsG1o/wmdTb7zGonFA78/2rA==
X-Google-Smtp-Source: AK7set+nHS1ERfeA5HSjZOAP4XMGZ78LShDv+DbrqPS3vDyLLz1iDEMiepScfodZRBJld8itp5pHGQ==
X-Received: by 2002:adf:e745:0:b0:2bf:bae4:a369 with SMTP id c5-20020adfe745000000b002bfbae4a369mr1183513wrn.10.1674634725326;
        Wed, 25 Jan 2023 00:18:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p7-20020adff207000000b002bdff778d87sm3770343wro.34.2023.01.25.00.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 00:18:44 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Jan 2023 09:18:39 +0100
Subject: [PATCH v2 3/3] arm64: dts: meson-g12b-odroid: Add initial support
 for Hardkernel ODROID-N2L
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-topic-odroid-n2l-upstream-initial-v2-3-8d3fea6d403d@linaro.org>
References: <20230122-topic-odroid-n2l-upstream-initial-v2-0-8d3fea6d403d@linaro.org>
In-Reply-To: <20230122-topic-odroid-n2l-upstream-initial-v2-0-8d3fea6d403d@linaro.org>
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
index 000000000000..70919f40d597
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
+#include "meson-g12b-odroid.dtsi"
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
+	phy-supply = <&usb_pwr_en>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&usb_pwr_en>;
+};

-- 
2.34.1

