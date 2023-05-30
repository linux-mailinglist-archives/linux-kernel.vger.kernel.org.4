Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DDA715738
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjE3HkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjE3HjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:39:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093E1A2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:38:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30ad99fa586so3827179f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685432311; x=1688024311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1EX8zFqVSXgr77NNt22wgtrby3wVjCcq3AV7vqu9KU=;
        b=qaLjv7cUcme+r5WIhM+7tjxJn/naDNKiPeRYaKPoxelqInlCh3H6ZtUwUGCOsByQN+
         8wZLpqoA6dRf25Eh3ke+8QbdrPmVuDr7di34QWuDUarVRBuCFURKJGRRDPomwITIekE1
         QBjMhNEc6xaPb9mYgxhYB6zXEW0QA5FmgEUfEIFVuoUtwJEHlKHzxrUJvc9iDp/QceOL
         JZBUcfDfju2nCJaWKvhIhtC6o1Q1sD8gvr34Aamy89cbQ/csil5VNk2Qe6Cz/m1QkqMe
         vUmweY1X1stXL1hRi4rgY+0zu7AzPWXfttsVQEZdCArl/kXhIIPz6Nz9VtGvB7fNWaH+
         Yjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432311; x=1688024311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1EX8zFqVSXgr77NNt22wgtrby3wVjCcq3AV7vqu9KU=;
        b=ksMSpLt/tt0KIAgIZWqrrfsozl+eG8nD0V/LpscVHvdMc9VAb4t994hPBBwemxbKws
         ihK0+MNo+0tqAkF0rTWyAxImnM77tozIPhs+n91uRHyh23aqGLBoAOpf6m495SM3bhKR
         rm+xRJEkYhtBP6zyrzlEd3dR1PurKf/uKIUAVYG3Aen4/EYwNhyZaZDaoXPAB6TEayIm
         LG3LrEC/EHea3stYAopHRiHbL95AJWUyzT5X+fl1sBwRDZSsq5dFPLQDOfHFOqJ9wz4p
         xUZNV+plHCd1qu40wxdznNe9TvIe3YT2/Pcdmy71ASzsJx41dMWOWLY4Pp5Ie7Q6sa7E
         GpzA==
X-Gm-Message-State: AC+VfDyLfq1RHX3Pv0s5YDaMxtMvImEwR5v2DmX/UiiFlvhroTkEr1xn
        1jVEx9MWAARdBAOHsxuWdR4Isw==
X-Google-Smtp-Source: ACHHUZ7FZgOwvMMqpJDCHJajVUqI+7sSUv6P9yE34kYA0YB1sx9cM4jm+VuamHoiOoA4S3hz+1C3Pw==
X-Received: by 2002:a05:6000:ce:b0:30a:eada:8b9b with SMTP id q14-20020a05600000ce00b0030aeada8b9bmr847345wrx.41.1685432311177;
        Tue, 30 May 2023 00:38:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d4a04000000b003079c402762sm2312013wrq.19.2023.05.30.00.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:38:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 30 May 2023 09:38:16 +0200
Subject: [PATCH v5 15/17] DONOTMERGE: arm64: meson: khadas-vim3l: add DSI
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-15-56eb7a4d5b8e@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     "Lukas F. Hartmann" <lukas@mntre.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3821;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=V+HaYnTuv4vcDBK+f0uefqR8qZNKRB03xg8yBzcvNP8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkdafjZ6babQ9HnVxpzEUksfB80sCD2jl7oBkWoD61
 dUdz5IOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHWn4wAKCRB33NvayMhJ0WfaD/
 0USCjacxd0zCYYit6EVReHwJTzJ/KraWYQzWBGEh0waFZqBVxeFTbCGWCfyICAzivOFmZTm8ddyv7/
 Z03i9HU1X+y03y/jJpR6+4fp7GkdS2o373ZYo3NLlDEn8Zm0wGLP3AztJ8VHngVsNduXS249Z5GbgQ
 io6gekHXvHCaAstk4foYEJOtN5oL9H/eKDmf+Z+7KU+KoDe9JwpV/mXWILxmD6DW62FoocExL4Bsko
 VdEUUpi9Dz/s5CUu/gmc3FUpQUGORCaJGN5ihVIyg2IP9i8v7dUKP/7kA/mtkxraU6pyPVISseTPCm
 vs0m4HfJnG/YmxpFY3+hBIRGh+7ow3IhEa6c/saA4oG6K1zNjs9cmnkmcTgC0b+zj/1yg+YHjVBSKk
 /qlji8S+MYhHmaAZnsRJxI/C91zGOX+BIVSZ5Z9+P09SV5GdaTb322oEHOz8ifGMMubRhJ/sQZx5Pt
 yKCt4eymoUvegO2TYM/B5Whr/ykeBC+wy834E4u64rXS2nfTMVh3HmJtUDda5+5xIsX0wen0yoChar
 hpzJjPwHZTUulFhBCUuQ1ZEi5peRP32jWpNtpEaB4hA/3b1f+7fJI61KUHc897G3Z3iSBb2w+MW/Ec
 x9IM16DhU3LAei1C3sz885zcxZJNffbdpLLdtuV7bt/gzjs7qhEQ+nKM99kA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add nodes to support the Khadas TS050 panel on the
Khadas VIM3 & VIM3L boards.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 76 ++++++++++++++++++++++
 .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts    |  2 +-
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index 16dd409051b4..81c3057143b4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -98,7 +98,7 @@ &pwm_ab {
 };
 
 &pwm_AO_cd {
-	pinctrl-0 = <&pwm_ao_d_e_pins>;
+	pinctrl-0 = <&pwm_ao_c_6_pins>, <&pwm_ao_d_e_pins>;
 	pinctrl-names = "default";
 	clocks = <&xtal>;
 	clock-names = "clkin1";
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index c9705941e4ab..0c50a32bb0c0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -40,6 +40,14 @@ button-function {
 		};
 	};
 
+	panel_backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm_AO_cd 0 25000 0>;
+		brightness-levels = <0 255>;
+		num-interpolated-steps = <255>;
+		default-brightness-level = <200>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -359,6 +367,23 @@ rtc: rtc@51 {
 	};
 };
 
+&i2c3 {
+	status = "okay";
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+
+	touch-controller@38 {
+		compatible = "edt,edt-ft5206";
+		reg = <0x38>;
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <66 IRQ_TYPE_EDGE_FALLING>; /* GPIOA_5 */
+		reset-gpio = <&gpio_expander 6 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <1920>;
+		status = "okay";
+	};
+};
+
 &ir {
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
@@ -366,6 +391,57 @@ &ir {
 	linux,rc-map-name = "rc-khadas";
 };
 
+&mipi_dsi {
+	status = "okay";
+
+	assigned-clocks = <&clkc CLKID_GP0_PLL>,
+			  <&clkc CLKID_MIPI_DSI_PXCLK_SEL>,
+			  <&clkc CLKID_MIPI_DSI_PXCLK>,
+			  <&clkc CLKID_CTS_ENCL_SEL>,
+			  <&clkc CLKID_VCLK2_SEL>;
+	assigned-clock-parents = <0>,
+				 <&clkc CLKID_GP0_PLL>,
+				 <0>,
+				 <&clkc CLKID_VCLK2_DIV1>,
+				 <&clkc CLKID_GP0_PLL>;
+	assigned-clock-rates = <960000000>,
+			       <0>,
+			       <960000000>,
+			       <0>,
+			       <0>;
+
+	panel@0 {
+		compatible = "khadas,ts050";
+		reset-gpios = <&gpio_expander 0 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&gpio_expander 1 GPIO_ACTIVE_HIGH>;
+		power-supply = <&vcc_3v3>;
+		backlight = <&panel_backlight>;
+		width-mm = <64>;
+		height-mm = <118>;
+		reg = <0>;
+
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
+			};
+		};
+	};
+};
+
+&mipi_analog_dphy {
+	status = "okay";
+};
+
+&mipi_dphy {
+	status = "okay";
+};
+
+&mipi_dsi_panel_port {
+	mipi_out_panel: endpoint {
+		remote-endpoint = <&mipi_in_panel>;
+	};
+};
+
 &pcie {
 	reset-gpios = <&gpio GPIOA_8 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index 9c0b544e2209..cb52a55ab70a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -76,7 +76,7 @@ &cpu3 {
 };
 
 &pwm_AO_cd {
-	pinctrl-0 = <&pwm_ao_d_e_pins>;
+	pinctrl-0 = <&pwm_ao_c_6_pins>, <&pwm_ao_d_e_pins>;
 	pinctrl-names = "default";
 	clocks = <&xtal>;
 	clock-names = "clkin1";

-- 
2.34.1

