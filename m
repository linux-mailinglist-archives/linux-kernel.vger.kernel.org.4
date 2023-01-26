Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7038767C418
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 05:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjAZE6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 23:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjAZE5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 23:57:48 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5651BD8;
        Wed, 25 Jan 2023 20:57:45 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 95A575C013C;
        Wed, 25 Jan 2023 23:57:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 25 Jan 2023 23:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674709064; x=1674795464; bh=Ap
        1Qz7Te/uXkN1sNZQoZSEgQeAlWB8MwV78PVRtTsT0=; b=iCeLe+tHvYLjvSTWpX
        2xOFEmw+yG3ohh2vzQmUVs1S6WgRvYmhVzp30Hhu0OxuIyqRgV8KNaR9e8lqZj5Y
        7CnqNqtAntjr+/TUV2Ltraj4NK7tm/v2WsGxkI32NIbLYkNNbt1kyvCVYf5E2EoH
        P9RTgtAgnG3hVryaPCXCDQeYnmhCIi5HGlk/wn8ZXLFz1RUAmyPHFnPAJX9NdRPu
        UJRtKYAvXs+EM0nK7ET5IYXzB3no95kdm5cybfe3NECBsNKg6+M97SoFnAg5fZol
        /GkttkkwE3XH+SXMi2jiXTjWbDKDhKfDWuJOovmMJ10mQhtD22CPMDkGZ3r8Yk8B
        cyWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674709064; x=1674795464; bh=Ap1Qz7Te/uXkN
        1sNZQoZSEgQeAlWB8MwV78PVRtTsT0=; b=cuee5MUlNsBx8HRziLYaZ2PLTZAFK
        9b3p8RXOcSJm2SMjLvlXL1w+rcUyVU6vBYT84aIBhzFwoKxmlG1Ex1Pz1fJcxZfF
        vikBrVy/PePDa2tV4SEU0ReWdRClJTkSEvrsRyIsIj8iOPTjjfTO9pkXfS+M+5hq
        rTBqpMyAuq48JWcqJOkiVQibkcsiUhtjd37ewrG/Ka+ut6r4m0LflSrYYJP99bgh
        rOFfOIF3TySh4E7xjS3rQSNC2vVPFP/SUh7hBXochzGY7iS1SJlHxRSubD+xC4Ux
        6mBPJzZdfq6FNKIWcWiHLqkce6iZvIluZC6kLb0Bmj+TI3MkrkXidBIMQ==
X-ME-Sender: <xms:SAjSY8vyJdVW7PpFSoTKZdigjM14WtKnjgs568wq1H-KyekuaeRrdg>
    <xme:SAjSY5feZP7Ki4issCvy_Of5jMf3eeU0YdXn_9gtWOYaK45iksh0643Ek9LkdNb0D
    FMMcDb5Bowx6AMphQ>
X-ME-Received: <xmr:SAjSY3zIgg0NE6FHVIjdkZ1_qPCfpl5bIU7JKqFrtyJd1oktGDg40USg0vrQCJHjEkeDvo6vcmNlcuT5FBBzNsEU2MN21UEdgIeER5AEqqVUnPjN0aG9c11O0jTTfl9bMkAzYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:SAjSY_MwAuBHGW3Qa0KVVAdsvhOi6aveMKh5s_4POi7dB8Yf-G6o6Q>
    <xmx:SAjSY8_tMG-ta8qYFfsK-MqIAxEbQ1Pv7QfJtAe54qEFdTm2FZQBjw>
    <xmx:SAjSY3XXN4uzidcvihcI5-4B0loWNJw54Nax-skcW05Utv3l8vGyFA>
    <xmx:SAjSY_cn00JZ2fvKSqaWCWQPK_3m7KOraY58hweq0q5kmOnKMrr74Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 23:57:43 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     linux-riscv@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v5 05/11] riscv: dts: allwinner: Add MangoPi MQ devicetree
Date:   Wed, 25 Jan 2023 22:57:32 -0600
Message-Id: <20230126045738.47903-6-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230126045738.47903-1-samuel@sholland.org>
References: <20230126045738.47903-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MangoPi MQ is a tiny SBC built around the Allwinner D1s. Its
onboard peripherals include two USB Type-C ports (1 device, 1 host)
and RTL8189FTV WLAN.

A MangoPi MQ-R variant of the board also exists. The MQ-R has a
different form factor, but the onboard peripherals are the same.

Most D1 and D1s boards use a similar power tree, with the 1.8V rail
powered by the SoC's internal LDOA, analog domains powered by ALDO,
and the rest of the board powered by always-on fixed regulators. To
avoid duplication, factor out the regulator information that is
common across boards.

The board also exposes GPIO Port E via a FPC connector, which can
support either a camera or an RMII Ethernet PHY. The additional
regulators supply that connector.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v5:
 - Drop the configuration for LDOA and LDOB

Changes in v3:
 - Drop mmc aliases
 - Change LED_FUNCTION_BACKLIGHT to LED_FUNCTION_STATUS (the backlight
   regulator is disconnected by default, so this is a standalone LED)

Changes in v2:
 - New patch for v2

 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun20i-common-regulators.dtsi   |  28 ++++
 .../dts/allwinner/sun20i-d1s-mangopi-mq.dts   | 128 ++++++++++++++++++
 4 files changed, 159 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 0c97d673b775..f0d9f89054f8 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+subdir-y += allwinner
 subdir-y += sifive
 subdir-y += starfive
 subdir-y += canaan
diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
new file mode 100644
index 000000000000..2f2792594f7d
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1s-mangopi-mq.dtb
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
new file mode 100644
index 000000000000..9b03fca2444c
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+/ {
+	reg_vcc: vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_vcc_3v3: vcc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_vcc>;
+	};
+};
+
+&pio {
+	vcc-pb-supply = <&reg_vcc_3v3>;
+	vcc-pc-supply = <&reg_vcc_3v3>;
+	vcc-pd-supply = <&reg_vcc_3v3>;
+	vcc-pe-supply = <&reg_vcc_3v3>;
+	vcc-pf-supply = <&reg_vcc_3v3>;
+	vcc-pg-supply = <&reg_vcc_3v3>;
+};
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
new file mode 100644
index 000000000000..e6d924f671fd
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/dts-v1/;
+
+#include "sun20i-d1s.dtsi"
+#include "sun20i-common-regulators.dtsi"
+
+/ {
+	model = "MangoPi MQ";
+	compatible = "widora,mangopi-mq", "allwinner,sun20i-d1s";
+
+	aliases {
+		ethernet0 = &rtl8189ftv;
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 3 22 GPIO_ACTIVE_LOW>; /* PD22 */
+		};
+	};
+
+	reg_avdd2v8: avdd2v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd2v8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_vcc_3v3>;
+	};
+
+	reg_dvdd: dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "dvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&reg_vcc_3v3>;
+	};
+
+	reg_vcc_core: vcc-core {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-core";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&reg_vcc>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 12 GPIO_ACTIVE_LOW>; /* PG12 */
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vcc_core>;
+};
+
+&dcxo {
+	clock-frequency = <24000000>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	disable-wp;
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mmc1 {
+	bus-width = <4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	rtl8189ftv: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pe-supply = <&reg_avdd2v8>;
+};
+
+&uart3 {
+	pinctrl-0 = <&uart3_pb_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc>;
+	status = "okay";
+};
-- 
2.37.4

