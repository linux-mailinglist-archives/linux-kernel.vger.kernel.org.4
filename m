Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E177A6662DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjAKSfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjAKSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:35:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5131005C;
        Wed, 11 Jan 2023 10:35:16 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d30so19980441lfv.8;
        Wed, 11 Jan 2023 10:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp1sOF8ngdpO8Gze+a9HDRnyky/d5MXRdBa+hgAZWjE=;
        b=nwBfdFCN74hmamqn5uTT6DqKYCdaP+PQXwuMT/R2WwxMMYbO+Sn7mM5Rt/aPimQclE
         aPVxJBS03GdtVQvvtEfB8JHdpzie3qhGJeb+bKzQjU2kFE0iJmOXlm0ur++c3o+0KLfZ
         HQnf8tBRl1PnNtV5pFf+SF0ELjNmtRLF7pxvqqTbtjpmL4BuArULPK2Z/OQn+TuVsoFz
         GO4JoEdWGhPpEtTlOUKsyc9oKWXuBwpuctYaX8A9+Ds9yOywxMCvP0kkNGR+kTToV9j/
         KW0gy75l8yaB3FDOXmmnQEYU76Q8tiymL+4pjXpd/h8naWAZiIeiiseYOZWPKoQvngeu
         hMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fp1sOF8ngdpO8Gze+a9HDRnyky/d5MXRdBa+hgAZWjE=;
        b=T96ai2JGl4opWk+FU7wrnG1eatp4If/Xr1ft6BsgX9hXBbtZTbhzR0wQ1ki1L4muuN
         p/IQo9mx4t3Gqk2rjMN17sKB+QNPpgh5K8Wc4FKAfaeJwgNG+27q/g6AbfSvCuvLrw7h
         6NF+pz56eanlsVw4mi6UpqUANDEG8YJwW5zGqplWj2e3GVNXaQPY7AUdhBab8NDYzGKN
         3B/bsFFjaV4k7/2ErF7lAHHHQqE+6wYDoueuH1rUE3JqiDumNJBcilkrzPZUKY2kS3Yw
         OLro+hdC34pHY7fz0M6+tjxKiWPhDGBM4hHWBpAkWDxSB0rDZNas8tnisSLrpoR4Y3R0
         dCVQ==
X-Gm-Message-State: AFqh2kqQXj8NNYIetTWeA1MMX/NpSSbMFyMzfyonrglG6YuXB2OjhVxm
        xaa3raPVTndBDpy1gJG7T6bTzCcj6yj45g==
X-Google-Smtp-Source: AMrXdXvpC3qUv6qekugrxfoha94O4qIbbttTcvnts1TboJ49oZN6CqMIPS7SpJS55YJBwG6JZ2DaHQ==
X-Received: by 2002:a05:6512:108f:b0:4a4:68b8:c2e4 with SMTP id j15-20020a056512108f00b004a468b8c2e4mr23692376lfg.59.1673462115112;
        Wed, 11 Jan 2023 10:35:15 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512358500b004cb35b31b96sm2837826lfr.257.2023.01.11.10.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 10:35:14 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Add display backlight
Date:   Wed, 11 Jan 2023 20:35:01 +0200
Message-Id: <20230111183502.706151-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Uses ti,lp8556 backlight with clk-pwm.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
This patch was part of the series
https://lore.kernel.org/linux-arm-msm/20230106114403.275865-1-matti.lehtimaki@gmail.com/
which already had the other patches applied.

Changes in v2:
  - Add empty line between subnodes
  - Move pwm node to correct place
  - Reorder pinctrl properties
---
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
index 15b9590ba07b..91b860e24681 100644
--- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
@@ -80,6 +80,55 @@ key-volume-up {
 		};
 	};
 
+	i2c-backlight {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 20 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 21 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+		pinctrl-0 = <&backlight_i2c_default_state>;
+		pinctrl-names = "default";
+
+		i2c-gpio,delay-us = <4>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		backlight@2c {
+			compatible = "ti,lp8556";
+			reg = <0x2c>;
+
+			dev-ctrl = /bits/ 8 <0x80>;
+			init-brt = /bits/ 8 <0x3f>;
+			pwm-period = <100000>;
+
+			pwms = <&backlight_pwm 0 100000>;
+			pwm-names = "lp8556";
+
+			rom-a0h {
+				rom-addr = /bits/ 8 <0xa0>;
+				rom-val = /bits/ 8 <0x44>;
+			};
+
+			rom-a1h {
+				rom-addr = /bits/ 8 <0xa1>;
+				rom-val = /bits/ 8 <0x6c>;
+			};
+
+			rom-a5h {
+				rom-addr = /bits/ 8 <0xa5>;
+				rom-val = /bits/ 8 <0x24>;
+			};
+		};
+	};
+
+	backlight_pwm: pwm {
+		compatible = "clk-pwm";
+		#pwm-cells = <2>;
+		clocks = <&mmcc CAMSS_GP0_CLK>;
+		pinctrl-0 = <&backlight_pwm_default_state>;
+		pinctrl-names = "default";
+	};
+
 	reg_tsp_1p8v: regulator-tsp-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "tsp_1p8v";
@@ -418,6 +467,18 @@ accel_int_default_state: accel-int-default-state {
 		bias-disable;
 	};
 
+	backlight_i2c_default_state: backlight-i2c-default-state {
+		pins = "gpio20", "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	backlight_pwm_default_state: backlight-pwm-default-state {
+		pins = "gpio33";
+		function = "gp0_clk";
+	};
+
 	muic_int_default_state: muic-int-default-state {
 		pins = "gpio67";
 		function = "gpio";
-- 
2.34.1

