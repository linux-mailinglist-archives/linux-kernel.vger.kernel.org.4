Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247455BE920
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiITOfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiITOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:35:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C415A0F;
        Tue, 20 Sep 2022 07:35:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h130-20020a1c2188000000b003b4cadadce7so5699644wmh.3;
        Tue, 20 Sep 2022 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+SuwuJGOg5KYd3WZxjux+NETV48IOgrGaRTD+kqFOac=;
        b=T31GHaV6hRYu6t3ABhfgwPr8thM+xw3K6xfdFTO/nuL27pQ/9IbuyRoK+RhPpg8dl0
         WeATDwRRoFm8h8dSlGJ19Zif0EBzDVeBu2HWmS0w4cdeUoJ0SmIiY8NMdoN9sK1QnOHw
         rYTY/MH4pTXsH1MH5TA2DUrUrGzXOgWMC9WiJgzLF11ghavW9C1S0E/aFMps3Wuvhmih
         R6XILSL1MjysD5YowPkAvg9IZrZKQwEO5KSqm6EQaQOP0MLhwHoxJMPw/t3CSsW2XQ2n
         PbZmSZkeC+q1Tmp+DkvIxnThwl0kN5nP2PcSyrpLyyfXWpy8+RcqOk/m2fL7iqOCw5qU
         3mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+SuwuJGOg5KYd3WZxjux+NETV48IOgrGaRTD+kqFOac=;
        b=keOzohmMQ/eyXVHMm4xuVSO40I7uME+g9Afge4tq3bbMm0CzhOWYBfy+68h1/9ElGx
         51GlBMelq2zv+xz+zKTna3JKuqOgRyAps2Ys2SRTY0Q/vglzNkWnbw5KwN5uTxfGunkE
         SrKoa7u1EQFMx2nYltQVx7wPIkMdeIzJX9GANJSekf5QdIBsVAym2VO1jeVg9kzAX8yy
         AyoRC1B6pt9Lk622RMuHGQLcQjAL2pyHTAU+fK+UXEkZpSJKUenefk/C+j82pwRXtfek
         nV9Jf6b3SNuZBiNiHZB2USQcYnZImtbAIu6/n6YP7HPdoPqLGSjhoMzQETmtEpcRg6g4
         LEnw==
X-Gm-Message-State: ACrzQf3Wz21fORCqqvT821vGc2PH60c1IXPttYZbNS75DDYaAH3PQ+BM
        3PAOWpQQPUPzkihesRvBklo=
X-Google-Smtp-Source: AMsMyM7Qp41zb/aighXcTiRczuHKL26S02RSou6pBtVxadl2Tgx5gVWBRb7XnaigW16nV9LESOTBPg==
X-Received: by 2002:a05:600c:33a8:b0:3b4:874c:f48f with SMTP id o40-20020a05600c33a800b003b4874cf48fmr2582646wmp.131.1663684500449;
        Tue, 20 Sep 2022 07:35:00 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id y11-20020adffa4b000000b0021e43b4edf0sm226250wrr.20.2022.09.20.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:34:59 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Enable HDMI and GPU on quartz64-b
Date:   Tue, 20 Sep 2022 16:34:46 +0200
Message-Id: <20220920143446.633956-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.37.3
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

This enables the GPU and HDMI output (including HDMI audio) on
the PINE64 Quartz64 Model B single board computer.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index 0f623198970f..77b179cd20e7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3566.dtsi"
 
 / {
@@ -28,6 +29,17 @@ gmac1_clkin: external-gmac1-clock {
 		#clock-cells = <0>;
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -183,6 +195,33 @@ &gmac1m1_clkinout
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&hdmi {
+	avdd-0v9-supply = <&vdda0v9_image>;
+	avdd-1v8-supply = <&vcca1v8_image>;
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -456,6 +495,10 @@ &i2c5 {
 	status = "disabled";
 };
 
+&i2s0_8ch {
+	status = "okay";
+};
+
 &i2s1_8ch {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s1m0_sclktx
@@ -677,3 +720,20 @@ &usb_host0_ehci {
 &usb_host0_ohci {
 	status = "okay";
 };
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
-- 
2.37.3

