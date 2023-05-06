Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DACC6F90B9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjEFJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjEFJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:01:25 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835849E8;
        Sat,  6 May 2023 02:01:22 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 985FE24E258;
        Sat,  6 May 2023 17:01:19 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 6 May
 2023 17:01:19 +0800
Received: from SD-Server.starfivetech.com (183.27.98.219) by
 EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Sat, 6 May 2023 17:01:18 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 3/3] riscv: dts: starfive: add tdm node and sound card
Date:   Sat, 6 May 2023 17:01:16 +0800
Message-ID: <20230506090116.9206-4-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230506090116.9206-1-walker.chen@starfivetech.com>
References: <20230506090116.9206-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.219]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the tdm controller node and sound card for the StarFive JH7110 SoC.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/Makefile         |  3 +
 .../jh7110-starfive-visionfive-2-wm8960.dtso  | 70 +++++++++++++++++++
 .../jh7110-starfive-visionfive-2.dtsi         | 40 +++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 21 ++++++
 4 files changed, 134 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-wm8960.dtso

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 170956846d49..644cc29b5be3 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -4,3 +4,6 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
 
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
+
+jh7110-starfive-visionfive-2-wm8960-dtbs := jh7110-starfive-visionfive-2-v1.3b.dtb jh7110-starfive-visionfive-2-wm8960.dtbo
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-wm8960.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-wm8960.dtso b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-wm8960.dtso
new file mode 100644
index 000000000000..67897f000883
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-wm8960.dtso
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Walker Chen <walker.chen@starfivetech.com>
+ *
+ * Requires ReSpeaker 2-Mics Pi HAT plugged in 40-pin GPIO header.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "starfive,visionfive-2-v1.3b", "starfive,jh7110";
+
+	wm8960_mclk: wm8960-mclk {
+		compatible = "fixed-clock";
+		clock-output-names = "wm8960_mclk";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,name = "Starfive-TDM-Sound-Card";
+		simple-audio-card,widgets = "Microphone", "Mic Jack",
+					    "Line", "Line In",
+					    "Line", "Line Out",
+					    "Speaker", "Speaker",
+					    "Headphone", "Headphone Jack";
+		simple-audio-card,routing = "Headphone Jack", "HP_L",
+					    "Headphone Jack", "HP_R",
+					    "Speaker", "SPK_LP",
+					    "Speaker", "SPK_LN",
+					    "LINPUT1", "Mic Jack",
+					    "LINPUT3", "Mic Jack",
+					    "RINPUT1", "Mic Jack",
+					    "RINPUT2", "Mic Jack";
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "dsp_a";
+			bitclock-master = <&dailink_master>;
+			frame-master = <&dailink_master>;
+
+			cpu {
+				sound-dai = <&tdm>;
+			};
+			dailink_master: codec {
+				sound-dai = <&wm8960>;
+				clocks = <&wm8960_mclk>;
+			};
+		};
+	};
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	wm8960: codec@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		wlf,shared-lrclk;
+		#sound-dai-cells = <0>;
+	};
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 1155b97b593d..19b5954ee72d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -214,6 +214,40 @@
 			slew-rate = <0>;
 		};
 	};
+
+	tdm0_pins: tdm0-pins {
+		tdm0-pins-tx {
+			pinmux = <GPIOMUX(44, GPOUT_SYS_TDM_TXD,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		tdm0-pins-rx {
+			pinmux = <GPIOMUX(61, GPOUT_HIGH,
+					      GPOEN_DISABLE,
+					      GPI_SYS_TDM_RXD)>;
+			input-enable;
+		};
+
+		tdm0-pins-sync {
+			pinmux = <GPIOMUX(63, GPOUT_HIGH,
+					      GPOEN_DISABLE,
+					      GPI_SYS_TDM_SYNC)>;
+			input-enable;
+		};
+
+		tdm0-pins-pcmclk {
+			pinmux = <GPIOMUX(38, GPOUT_HIGH,
+					      GPOEN_DISABLE,
+					      GPI_SYS_TDM_CLK)>;
+			input-enable;
+		};
+	};
 };
 
 &uart0 {
@@ -221,3 +255,9 @@
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
+
+&tdm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&tdm0_pins>;
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 866313570a7e..cfda6fb0d91b 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -366,6 +366,27 @@
 			status = "disabled";
 		};
 
+		tdm: tdm@10090000 {
+			compatible = "starfive,jh7110-tdm";
+			reg = <0x0 0x10090000 0x0 0x1000>;
+			clocks = <&syscrg JH7110_SYSCLK_TDM_AHB>,
+				 <&syscrg JH7110_SYSCLK_TDM_APB>,
+				 <&syscrg JH7110_SYSCLK_TDM_INTERNAL>,
+				 <&syscrg JH7110_SYSCLK_TDM_TDM>,
+				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
+				 <&tdm_ext>;
+			clock-names = "tdm_ahb", "tdm_apb",
+				      "tdm_internal", "tdm",
+				      "mclk_inner", "tdm_ext";
+			resets = <&syscrg JH7110_SYSRST_TDM_AHB>,
+				 <&syscrg JH7110_SYSRST_TDM_APB>,
+				 <&syscrg JH7110_SYSRST_TDM_CORE>;
+			dmas = <&dma 20>, <&dma 21>;
+			dma-names = "rx","tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		stgcrg: clock-controller@10230000 {
 			compatible = "starfive,jh7110-stgcrg";
 			reg = <0x0 0x10230000 0x0 0x10000>;
-- 
2.17.1

