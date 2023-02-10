Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7594C692406
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjBJRHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjBJRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:07:41 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F70279B33;
        Fri, 10 Feb 2023 09:07:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg26so4339645wmb.0;
        Fri, 10 Feb 2023 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+tC+3M79LSCIIw5j8lDKYBrOpewHeq1xIre2CyKVA0=;
        b=TSvLq/yg83aGHSy29gBUVTTw8fyHTID5dLAVCWzS8+XE1Aheh+pwONXyZjNuVCF0gi
         +FUJcET3VPMjufgd17yOq1uwwv5tzTefspOSMXEZDWk4HNU5V9FGE5FglYQRzr2HNqU1
         +k3wUQGH62K+0HW+3Rz1EMlm5T7oZY84J+oW5nqvP07wqnaQMvu9N0kC4x/cf+v4tiJH
         X04eN40qHjjZ9MNPEBCGKufOQnT2xoU+/a/BUIHUionClPb1Z9kyuC+FZCVp8d435gCz
         PfJdih+ZYs15D77erJ/AyM7zp0cpLUN/thyjk643G349BnTphFhERpzuY+3TFkW4TuI4
         ucAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+tC+3M79LSCIIw5j8lDKYBrOpewHeq1xIre2CyKVA0=;
        b=sv3TvD5ejAYDUFQXc5xJ3UI2emq/zrXslqqJZtA4472krkNVTZ0oPNMgjdchQk+52H
         dO9wukfOWMcMjU6urM4XTcNSNHGph3ABtPqPnVW4jm7pMtVr436Em7Ka/gJmML1K3Cwy
         nMIIBHA0P64o1UbwZhWCqnP3tck+ZEuCHt7UTpjl6uVq18Hr3IFOjB0BAtYIGaByBiMT
         rC2Ni0ZW6KF/G68a2uQG1plTUMEcMmBosL4De2l0wbrCWqpc0QdmdDdODoPvUNWw2KXD
         jSGyhpTPEcVrvwK+yaU2K3Rn/KUd5SLNi2OLRQkPPTZ2SeSopYKjkn/rE2UF8IaaquWL
         sTQg==
X-Gm-Message-State: AO0yUKVtaL2HdzEkhTzSG7P5kt2LxaQrzJDQQEFzKu3f2qj8N3uSdu4T
        gu3nE+l121EI9IGGuvS1TGg=
X-Google-Smtp-Source: AK7set+xFtoXhPW9GlnW+yzOi2G6h5E1IL8vgMQscZINpwWEiNTlw9KCHDpYZcfVbdLisQesB7NQMw==
X-Received: by 2002:a05:600c:4496:b0:3dc:de85:5007 with SMTP id e22-20020a05600c449600b003dcde855007mr13352560wmo.21.1676048854683;
        Fri, 10 Feb 2023 09:07:34 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c188700b003cffd3c3d6csm5351531wmp.12.2023.02.10.09.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:07:34 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Ferass El Hafidi <vitali64pmemail@protonmail.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: gxbb-kii-pro: add initial audio support
Date:   Fri, 10 Feb 2023 17:07:21 +0000
Message-Id: <20230210170721.1285914-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210170721.1285914-1-christianshewitt@gmail.com>
References: <20230210170721.1285914-1-christianshewitt@gmail.com>
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

Add initial support for HDMI and S/PDIF audio output.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../boot/dts/amlogic/meson-gxbb-kii-pro.dts   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index 435ae2aa404e..a09340e9f73a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -9,11 +9,19 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "videostrong,kii-pro", "amlogic,meson-gxbb";
 	model = "Videostrong KII Pro";
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -35,6 +43,58 @@ button-reset {
 			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "KII-PRO";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
+	pinctrl-0 = <&spdif_out_y_pins>;
+	pinctrl-names = "default";
 };
 
 &ethmac {
-- 
2.34.1

