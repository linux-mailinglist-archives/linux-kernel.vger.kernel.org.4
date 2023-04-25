Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E7C6EE635
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjDYQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjDYQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:58:05 -0400
Received: from new-shark9.inbox.lv (new-shark9.inbox.lv [194.152.32.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF9C19AE;
        Tue, 25 Apr 2023 09:57:41 -0700 (PDT)
Received: from shark4.inbox.lv (shark4 [10.0.1.84])
        by new-shark9.inbox.lv (Postfix) with ESMTP id 3D33448052F;
        Tue, 25 Apr 2023 19:57:36 +0300 (EEST)
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id 2A91AC019F;
        Tue, 25 Apr 2023 19:57:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv;
        s=p20220324; t=1682441856; x=1682443656;
        bh=N4QLC3QqIvchn657Wxt7eP3a7y150FC3JaximBoSfDU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:X-ESPOL:
         From:Date:To:Cc:Message-ID:Subject:Reply-To;
        b=EeygvSMQ9SRP1XDZrZrXfOjx8/0PT3DWWEn0JS8+szCPpWraKWuGIiCBXVCZBeTzT
         kiUN3YmSg83XsHGMgMPYeWbJeP1r9lKP+6cXCkhPVs5zk0hgArdXKLTZyipEJEtLke
         WHGVykwdMQLvU+jgiSgvOz2oNN4qiaHME974/z58=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 22246C019B;
        Tue, 25 Apr 2023 19:57:36 +0300 (EEST)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id o76Iws7qvmcN; Tue, 25 Apr 2023 19:57:35 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 9FCDDC018A;
        Tue, 25 Apr 2023 19:57:35 +0300 (EEST)
From:   Karl Chan <exkcmailist@inbox.lv>
To:     linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, "Karl Chan" <exkcmailist@inbox.lv>
Subject: [PATCH v5 2/2] arm64: dts: meson-gxl: add support for Xiaomi Mi box 3
Date:   Wed, 26 Apr 2023 00:56:24 +0800
Message-Id: <20230425165624.11999-3-exkcmailist@inbox.lv>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425165624.11999-1-exkcmailist@inbox.lv>
References: <20230425165624.11999-1-exkcmailist@inbox.lv>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: EZeEAiZdmGU1y83GUJgOlO7lx8rRIlciuy/6x7gy6nVYqsqhvtp3bm2LGYXtBwu+bg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Karl Chan"  <exkcmailist@inbox.lv>

The Xiaomi Mi box 3 is a TV box based on the Amlogic S905X chipset.
There are two variants:
- 2 GiB/8GIB
- 1 GiB/4GIB

Both variants come with:
- 802.11a/b/g/n/ac wifi (BCM4345)
- HDMI , AV (CVBS) and S/PDIF optical output
- 1x USB

Signed-off-by: Karl Chan <exkcmailist@inbox.lv>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s905x-xiaomi-mibox3.dts | 138 ++++++++++++++++++
 list                                          |   1 +
 3 files changed, 140 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-xiaomi-mibox3.dts
 create mode 100644 list

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index ccf1ba57fa87..774e7c3638bb 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-xiaomi-mibox3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-gt1-ultimate.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-mecool-kiii-pro.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-xiaomi-mibox3.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-xiaomi-mibox3.dts
new file mode 100644
index 000000000000..acc4b12ffe0f
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-xiaomi-mibox3.dts
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2016 Endless Computers, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ * Copyright (c) 2023 Karl Chan <exkcmailist@inbox.lv>
+ */
+
+/dts-v1/;
+
+#include "meson-gxl-s905x-p212.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
+
+/ {
+	compatible = "xiaomi,mibox3", "amlogic,s905x", "amlogic,meson-gxl";
+	model = "Xiaomi Mi Box 3";
+
+	dio2133: analog-amplifier {
+		compatible = "simple-audio-amplifier";
+		sound-name-prefix = "AU2";
+		VCC-supply = <&hdmi_5v>;
+		enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
+	};
+
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "XIAOMI-MIBOX3";
+		audio-aux-devs = <&dio2133>;
+		audio-widgets = "Line", "Lineout";
+		audio-routing = "Lineout", "AU2 OUTL",
+				"Lineout", "AU2 OUTR";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
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
+};
+
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
+
+&ethmac {
+	status = "disabled";
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&hdmi_5v>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+/* This UART is brought out to the uart pad on upper left of the pcb */
+&uart_AO {
+	status = "okay";
+};
+
-- 
2.40.0

