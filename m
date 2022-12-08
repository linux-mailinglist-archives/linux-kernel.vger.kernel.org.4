Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC68646B53
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiLHJDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLHJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:03:07 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E484E40C;
        Thu,  8 Dec 2022 01:03:00 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1B5383200302;
        Thu,  8 Dec 2022 04:02:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Dec 2022 04:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670490177; x=1670576577; bh=vO
        E0b42Jq+mNUCPZXZivZcA/yk+EJG2ZWnOo817Aphg=; b=TmsYcJGXjCDKcakX1W
        xgSOl3NDEQng/ICxdUSpCMgAn3/ZVNMEsSo/Xhxs5p9DqiUSdioZ09xVtK3yOwJD
        DlER/XFA66EQQ+eYJjn8cqAsp4IPl2Gd8KeTenrjcINYO1RavJWTd8L6JpdEE6/m
        373FMC7uiSlffA/quk8GBQ2yfMDYK2BZ3m38XjP7Vgt9LaK/no/Eb3h7biOSkLQS
        HqbKQus4B08xaDKcSTztNQLRM6dzv1CrVc1fSvmQ/3v3beyAmQObFeiXHvZEZXva
        CgutkNLe4ki2EJbmfe9ePIdTsCqKbrewWnv+KZhnOQEGfen2uEGty4d/D28ufDzV
        fEmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670490177; x=1670576577; bh=vOE0b42Jq+mNU
        CPZXZivZcA/yk+EJG2ZWnOo817Aphg=; b=gI4cOhu9gSMpTX7Ob54rdlCLM9Rc+
        elIx6GzFeBG3/Pp5zhk3ZHc0FHdMG67cCBkHK2jmPJ3kFTFerBN89ROhLxfCN9RE
        q5s2MTeo3bGquGQmn6PxtSaNF14SkMqBGiMG+TtOqc6zK6ADLd0p55HutC9E/EN0
        3Jgu0IFRCVt8ZuHUuIxlCz/qweah+hRCU8W8R16ReK3OcIV+2JxDKn3qdirXvhbT
        wFEtEoYo6tKY/8B1KSvyXun+R93fEsflxaH89iuGLGdVEAnUiF4Jn2J1jSxy0Z19
        q3up+88cRbpZUlz5AWnocqe5qA8GsVfsx7w4KyEMYF0OnWUo2nEy9DvZA==
X-ME-Sender: <xms:QaiRY7E9zy35idAYZh4yN0zIbHvkcjeR7KrX5cipNTzH_6jZRpCetQ>
    <xme:QaiRY4VmzFffVqo9DDKjT4YmZ42DtZOWie8gBbsQacNL_RPDVipzvfcIV9yG2D2i7
    3WKzPybxh8z_yDXYw>
X-ME-Received: <xmr:QaiRY9J8H9Zmjy2F4JoGP8OWp2LfDFGpS27ptXQ8T2m-pegb4PlCeaU0yvZMJfnqSbj3Te-eO2d8-lDURKDLxbsVXQILSWKkow3GDG_UyBUQ6aPc2eN-TqGEJwaJAtLr2zDhwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:QaiRY5E9COitfUcLj0jXOSED9rtabKHCvPdp8_ryKWLxx3pDJqSSgg>
    <xmx:QaiRYxVBwu635sf__SkAs5bQHaJht3QWPCD2AAXRMhENrjENZvtOPw>
    <xmx:QaiRY0MwceWihwBIDHF643ou1Ja0lnIGLr1WtIL2wfaxYjNDzeZclw>
    <xmx:QaiRYyXHW6oqG7KLjVSWCvDabP6FUM0kdRSv1MRftAw9ouqKVq1V0w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 04:02:56 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v3 05/12] riscv: dts: allwinner: Add MangoPi MQ devicetree
Date:   Thu,  8 Dec 2022 03:02:30 -0600
Message-Id: <20221208090237.20572-6-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221208090237.20572-1-samuel@sholland.org>
References: <20221208090237.20572-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
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

Changes in v3:
 - Drop mmc aliases
 - Change LED_FUNCTION_BACKLIGHT to LED_FUNCTION_STATUS (the backlight
   regulator is disconnected by default, so this is a standalone LED)

Changes in v2:
 - New patch for v2

 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun20i-common-regulators.dtsi   |  35 +++++
 .../dts/allwinner/sun20i-d1s-mangopi-mq.dts   | 134 ++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index ff174996cdfd..f292e31bdb2c 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+subdir-y += allwinner
 subdir-y += sifive
 subdir-y += starfive
 subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
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
index 000000000000..de1adf2a2759
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
@@ -0,0 +1,35 @@
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
+
+&reg_ldoa {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	ldo-in-supply = <&reg_vcc_3v3>;
+};
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
new file mode 100644
index 000000000000..2ad00b38d50b
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
@@ -0,0 +1,134 @@
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
+&reg_ldob {
+	regulator-name = "vcc-dram";
+	regulator-always-on;
+	ldo-in-supply = <&reg_vcc_3v3>;
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

