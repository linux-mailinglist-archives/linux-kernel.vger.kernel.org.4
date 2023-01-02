Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A43F65B5B3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjABRLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbjABRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:11:01 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD5755BE;
        Mon,  2 Jan 2023 09:10:52 -0800 (PST)
Received: from toolbox.int.toradex.com ([104.59.205.51]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LynwX-1oi6Hf01zj-0166VZ;
 Mon, 02 Jan 2023 18:10:32 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 2/5] arm64: dts: fsl-imx8qm-device.dtsi: add io-channel-cells to adc nodes
Date:   Mon,  2 Jan 2023 18:10:19 +0100
Message-Id: <20230102171023.33853-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102171023.33853-1-marcel@ziswiler.com>
References: <20230102171023.33853-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BF6hlveHaNGnK+Rxx9ph72YkG8TkykKQ5KeCyFLo5XKfGpekZcR
 haP6Zhbsf6zZZwNYcFenxnxQvMLCTGHsPGiNCPZhvkW9a9maxg9AJ9F+YWqVYpZcQ/NZ1vk
 24s4kvfKy2VelrpLH9alQx0//8T+uB7ZLxb+ioVb+pfHSjBEadU7mxCHxPMnXfkYjcKk5th
 DUIqrRjue45+pFoVSadrw==
UI-OutboundReport: notjunk:1;M01:P0:d0DKF2BZQEI=;SJDQj5TmV+2O5SLdhNo7Vlz/MX5
 bm9+3l+fki/Awn7DY/FiDXcsJzOctneZheHV6zRbMQCjXPZfy/gRpb2xB4yY/eN519yIZ9tt+
 DZj4ZvNJvDWFqh/WM02dss2uM8jde/9ujNvHAvInBySfZRy2Vt4WnDVcOTafpHg0h4gnUR3mI
 0cKBhPRW+EBI9atNyH7eU1lEV4bU1Abx/OEL/t1b+URbdwJJVzE4VfLuo83jAaqRYshenwxyp
 FNaJzOuZtERS+9lVEu78VV98HkoVxhdJShLD9D9/wOSIyH7RcfssHRTsbIArpP/0S83ZhCWUl
 cqEKDtGVkN92DxL39oM3jWW/yuCkGZimy33YfBmoHozkFLo07BoxA3dCYbE/Xlhg+W/5OOEVy
 e4ovE/VZklMPEO613uWs0k7P4Hnu0tOwnXMAZ7waCd7AsPKkDJeQ24hVjE/OxRkB5s9gjh3l9
 ugxiH178qCbuwMEPrhJM6hoW9uuvGmY281SEHejeSDKRNZgHY7TQ+R0wFaf7YaDE5GS1B7ag0
 NTrqZnAMYHfKCyl5Qn5j5Ea9XMWxtbdOuQVDV6eCFxL26Qv/GCFRC2nKKqPWRIOmetZqdxByO
 /aoyooDho3JI5OL9yN5X/bWGIwFEEgNSCEaGsTnPEFT3Ui3ACT7Hj40apafw899fcAlaZBISc
 l+OOXYvIIPmy6W7iL2CrbLDRt3/qrSufnXL/XamlrA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

This commit adds io-channel-cells property to the ADC nodes. This
property is required in order for an IIO consumer driver to work.
Especially required for Apalis iMX8 QM, as the touchscreen driver
uses ADC channels with the ADC driver based on IIO framework.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index a943a1e2797f..6e5ef8b69bf8 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -270,6 +270,7 @@ i2c3: i2c@5a830000 {
 
 	adc0: adc@5a880000 {
 		compatible = "nxp,imx8qxp-adc";
+		#io-channel-cells = <1>;
 		reg = <0x5a880000 0x10000>;
 		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
@@ -284,6 +285,7 @@ adc0: adc@5a880000 {
 
 	adc1: adc@5a890000 {
 		compatible = "nxp,imx8qxp-adc";
+		#io-channel-cells = <1>;
 		reg = <0x5a890000 0x10000>;
 		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-- 
2.35.1

