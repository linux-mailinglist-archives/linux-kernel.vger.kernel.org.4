Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382DC677554
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjAWG6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjAWG6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:58:45 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C781969B;
        Sun, 22 Jan 2023 22:58:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so9856133wml.3;
        Sun, 22 Jan 2023 22:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jozt3nQctk8Eo5do1n4x1ginSjY5JtMF4xErYTakExE=;
        b=aW2LoBd/6dqWV6Ju41BCj8IXkH30jX61wgv6knKyFecFONSzz6ZsA+irtg4Jf1lMg+
         xXAWr4BxOkSZ/gtX1sEYckJsuZ460KcFp7uvVAH8V/XYxa7q1bNhs36hO81/ym7xvm3g
         OEbwvnuNJy9+m4/2MmhDihlAeZYN/sxfeIPTLcqcqcXf7OTNo22ekQNybY1uytHm/H0k
         kU5P3TRIGJv60LiIzPivj8JWJyBFyMSngmnymllNkYQaqpWrweQdsyYhummuclai1ntp
         ri6O/buuRfcperivsxICXjkiSq+qumXLflQY0meRljysgTSjlPaamsSfZNYYx2erLEi/
         VgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jozt3nQctk8Eo5do1n4x1ginSjY5JtMF4xErYTakExE=;
        b=NS1YCzTLzOlNRwyo2yGHZlor7PM66Z1NPvWNR3+4cn7pgC4u0f3IgnAysob7DxU3f2
         KHY0cUh0OVEoaPPct9c77PEF/FDzCrgSBFeGQTo77OHreLNImECvPzeajt17TYyuXrIs
         6GxQ/6ndLc4UB4ZCyb38A7fKoenz2IRYo0bTdcUnf/qZsAantMDt7BD4HCN2R4usqZgv
         kMuvtRagIoqj3aLa+/LY7YCFy7aUr0nKv5+Rz0eX55c4klAZaWZEGv2C9feSv65eSTud
         zLM3dC4FrnGeXCOTFuaDjpIvYPns9UHmXwQZgPLVW+P2nsIkbTKyCvHbQtzuGUusxtgV
         gFFg==
X-Gm-Message-State: AFqh2krdoTNGb2tBSPAtPjwfCtRgmU2E4H1UDaMN8uMnTJFj8eklbHb4
        wmSbDWP45hbaQyvnx3hVsTg=
X-Google-Smtp-Source: AMrXdXvZ0o4+Uavz11cmkN1mn0HBaFEV/CsnWMmmt45ArHZ+GJ1XMu5eTnT79iN6DN64MsXPnT4Ivg==
X-Received: by 2002:a7b:cc14:0:b0:3da:50b0:e96a with SMTP id f20-20020a7bcc14000000b003da50b0e96amr22923957wmh.29.1674457119128;
        Sun, 22 Jan 2023 22:58:39 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id hg8-20020a05600c538800b003d974076f13sm9710625wmb.3.2023.01.22.22.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 22:58:38 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add audio playback to S905X-P212 dts
Date:   Mon, 23 Jan 2023 06:58:34 +0000
Message-Id: <20230123065834.2670125-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the HDMI and Analogue i2s audio outputs.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index 2602940c2077..c2bc7cec476d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -7,11 +7,19 @@
 /dts-v1/;
 
 #include "meson-gxl-s905x-p212.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "amlogic,p212", "amlogic,s905x", "amlogic,meson-gxl";
 	model = "Amlogic Meson GXL (S905X) P212 Development Board";
 
+	dio2133: analog-amplifier {
+		compatible = "simple-audio-amplifier";
+		sound-name-prefix = "AU2";
+		VCC-supply = <&hdmi_5v>;
+		enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
+	};
+
 	cvbs-connector {
 		compatible = "composite-video-connector";
 
@@ -32,6 +40,68 @@ hdmi_connector_in: endpoint {
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "S905X-P212";
+		audio-aux-devs = <&dio2133>;
+		audio-widgets = "Line", "Lineout";
+		audio-routing = "AU2 INL", "ACODEC LOLN",
+				"AU2 INR", "ACODEC LORN",
+				"Lineout", "AU2 OUTL",
+				"Lineout", "AU2 OUTR";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+
+			codec-1 {
+				sound-dai = <&aiu AIU_ACODEC CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_ACODEC CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&acodec>;
+			};
+		};
+	};
+};
+
+&acodec {
+	AVDD-supply = <&vddio_ao18>;
+	status = "okay";
+};
+
+&aiu {
+	status = "okay";
 };
 
 &cec_AO {
-- 
2.34.1

