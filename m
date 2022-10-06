Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558F65F6D37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiJFRqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiJFRpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:45:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7BEBC445;
        Thu,  6 Oct 2022 10:45:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k2so6258068ejr.2;
        Thu, 06 Oct 2022 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUBxrKTn0KBwv2ASstftMeX0Vji5z3CD2huvTjfWSDU=;
        b=dYaoh64eNVlgTzO+tH3Sg7fglmg+SIV+LynGlJE3o9wkZmP5YFBH7S14+1C0srDyhV
         5mAEPqkx50lVoW5Jp6WoRa8d1+tryJG+CcZGxdFiS5YlwTMzEgN3XE4E1T3lWyBs5Dj8
         lCEDjB1MNEvLE/GqvJ0nmrUJEld+sSRYLvIy9tJZF5fBlBV+h8O80t+bTuWRXH+sGVaG
         wPjQmyeAGAn0kbfqBzRItQQkSGwMlOTmr8jETLsguoAJ8EVq5T7daGeWxLioYjTu7S3f
         NJX3wJtSqTYMyTL1vqWSpngau2PyYHKO85EH8d0NQDLzNRxWTNAdS2NIa6h2FKyPSJ+3
         hb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUBxrKTn0KBwv2ASstftMeX0Vji5z3CD2huvTjfWSDU=;
        b=r7pB7SIT5PUemYhCNH0poePgkRohVUuF6o0BIIaPWoKqKtuVxrsDcttJ6DJ7T3S/B5
         qazVvswaxxIHGnWWSDRBcm3fIgW9zUw+IYdL2nMo2/kaf3kElc/HLFqGXPJchz5Yxql5
         pWx+9w9mMFWH+41LQCbMtdOF+vVOz/lF0UR7Ud45dbPX3IZVbCG0USd+forndSbCvByy
         yxgKASkUFdAeujfG0g6I6h/H8rLeaQAKd9Bf6UDQsG/uYPLLqEKzSZzgVNm9z2ZChoV0
         D0khiWbpoZONRxmWRstowCCsazCKO9M2UBxAd12+V0Gj2LQyQdKS2kVy0e+/Teu7Rk/U
         INyQ==
X-Gm-Message-State: ACrzQf3A/EQql1OpLLtB88Ulxawe3Zg7lBE3Z7TDqTL8qCfWMbspCCTc
        W8lWHgbM5ZJBdlN8N1Doj+8=
X-Google-Smtp-Source: AMsMyM4FsSy1bxT4XpwbN4WMINq4F7M3sFFHUL4e//iYrzg4ByLlQijA6u7kO+62OoEbYby247thxA==
X-Received: by 2002:a17:906:ef8f:b0:77e:44be:790 with SMTP id ze15-20020a170906ef8f00b0077e44be0790mr818930ejb.409.1665078348056;
        Thu, 06 Oct 2022 10:45:48 -0700 (PDT)
Received: from localhost.localdomain (83.24.77.202.ipv4.supernova.orange.pl. [83.24.77.202])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7cb57000000b00452878cba5bsm6105035edt.97.2022.10.06.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:45:47 -0700 (PDT)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     macroalpha@hotmail.com, Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: Add devicetree for Odroid Go Advance Black Edition
Date:   Thu,  6 Oct 2022 19:45:19 +0200
Message-Id: <20221006174519.46161-3-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221006174519.46161-1-maccraft123mc@gmail.com>
References: <20221006174519.46161-1-maccraft123mc@gmail.com>
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

This device is a revision of Odroid Go Advance, with added wifi card on
sdio interface and two trigger buttons.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3326-odroid-go2-v11.dts    | 104 ++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ef79a672804a..9fdbe7e83fc8 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-pi-s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3318-a95x-z2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2-v11.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts
new file mode 100644
index 000000000000..da48d070d9af
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Hardkernel Co., Ltd
+ * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
+ * Copyright (c) 2022 Maya Matuszczyk <maccraft123mc@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3326-odroid-go.dtsi"
+
+/ {
+	model = "ODROID-GO Advance Black Edition";
+	compatible = "hardkernel,rk3326-odroid-go2-v11", "rockchip,rk3326";
+
+	aliases {
+		mmc1 = &sdio;
+	};
+
+	gpio-keys {
+		button-sw20 {
+			gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
+			label = "TOP-LEFT 2";
+			linux,code = <BTN_TL2>;
+		};
+		button-sw21 {
+			gpios = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
+			label = "TOP-RIGHT 2";
+			linux,code = <BTN_TR2>;
+		};
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_pwrseq_pins>;
+		reset-gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&rk817 {
+	regulators {
+		vcc_wifi: LDO_REG9 {
+			regulator-name = "vcc_wifi";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+
+			regulator-state-mem {
+				regulator-on-in-suspend;
+				regulator-suspend-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+&sdio {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	vmmc-supply = <&vcc_wifi>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	esp8089: wifi@1 {
+		compatible = "esp,esp8089";
+		reg = <1>;
+	};
+};
+
+&pinctrl {
+	btns {
+		btn_pins: btn-pins {
+			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
+					<3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>,
+					<3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	wifi {
+		wifi_pwrseq_pins: wifi-pwrseq-pins {
+			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>,
+					<3 RK_PB6 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+	};
+};
-- 
2.38.0

