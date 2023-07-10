Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C023774D4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjGJLuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjGJLug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:50:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D7E3;
        Mon, 10 Jul 2023 04:50:32 -0700 (PDT)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c8:b70a:ae01:f690:3e44:90e:2421])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67A976607001;
        Mon, 10 Jul 2023 12:50:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688989831;
        bh=DR7uiuLvS/1UwwlyDPNnRUlzzR9ZrApORlGUcB+k/VI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/9kK0r1PJpPmyXoADG9UmEEqenk4JI6jazuDCwTVjz+z4wdl7MZ8ms6f3XdMJhSu
         bpEMHR9viwxR+uOWdAWSFVDUwYCkgrVUstsZlRo+WCTJkLE0kPEwhqJxWMoYq7uhW3
         xmdyQ2QfuBeTYnHNXtRvmbAF6Va67eRopb0zIRpr6b8dF/JFFRsvfn/Fh8kDdrTKry
         lcoJxg5jXICvFEXbtE2J7DilQvdTCTmRY6708yEXd8GbnpDDv8xBQPSQd5aZMk2pvb
         5pvCZutYXKqFDcbIw6goP6c6/a9KvqjI9SLBk3mD/J5cBIqdNRoqA9fOTM2hUlR1hE
         75b+5PT/6PHtA==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>,
        Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Add Radxa ROCK 4SE
Date:   Mon, 10 Jul 2023 12:50:25 +0100
Message-Id: <20230710115025.507439-4-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710115025.507439-1-chris.obbard@collabora.com>
References: <20230710115025.507439-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board-specific devicetree file for the RK3399T-based Radxa ROCK 4SE
board. This board offers similar peripherals in a similar form-factor to
the existing ROCK Pi 4B but uses the cost-optimised RK3399T processor
(which has different OPP table than the RK3399) and other minimal hardware
changes.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

Changes in v2:
- Set proper interrupt type for brcmf.

 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-rock-4se.dts     | 65 +++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index b7fb908eb92d..7ab29cbe71c4 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -58,6 +58,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-4c-plus.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-4se.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts
new file mode 100644
index 000000000000..7cfc198bbae7
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
+ * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
+ */
+
+/dts-v1/;
+#include "rk3399-rock-pi-4.dtsi"
+#include "rk3399-t-opp.dtsi"
+
+/ {
+	model = "Radxa ROCK 4SE";
+	compatible = "radxa,rock-4se", "rockchip,rk3399";
+
+	aliases {
+		mmc2 = &sdio0;
+	};
+};
+
+&pinctrl {
+	usb2 {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&sdio0 {
+	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_l>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&rk808 1>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
+		max-speed = <1500000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+		vbat-supply = <&vcc3v3_sys>;
+		vddio-supply = <&vcc_1v8>;
+	};
+};
+
+&vcc5v0_host {
+	enable-active-high;
+	gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&vcc5v0_host_en>;
+};
-- 
2.40.1

