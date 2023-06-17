Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349117343D6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjFQU5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFQU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:57:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82448F;
        Sat, 17 Jun 2023 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687035415; x=1687640215; i=julian.ribbeck@gmx.de;
 bh=t7HmD3gluiyFcTE258+e9VTlqgNSUHj+xdesG9chbig=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fWaMiEhIRbpeXp98cs2McdR9U87oS7yZemChegpiFa6jQ0QKmPCXoyxDPUHAS6IYXuy0S8f
 jz660WR2ThFFJvXnhAyTlQexv8JNSxKkRcmDWErRsZaoreYpkMb1bdkpx96v2dsQ4E20SN93A
 ET6jnpnPmUJJL858kCngqM6mDqlKctNHAft9dHUZIB+qxJGEg7RxucVK3BHRCWutN9qZqesAQ
 3/x1N4ZtUlPSVu1rOytELMUDTNXwV686AvZaY3XlMMYTzlqctXSJk5lPSriW91Rlz1ZlVlo/a
 c/2A3m/gSFqdJsCRqAv1h6FtaWDu9VAAnYE4IE7sNxjvQSJW7inQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x1-yoga-arch.speedport.ip ([93.242.194.247]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mkpf3-1pgoTh362p-00mIO1; Sat, 17 Jun 2023 22:56:54 +0200
From:   Julian Ribbeck <julian.ribbeck@gmx.de>
To:     krzysztof.kozlowski@linaro.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        julian.ribbeck@gmx.de, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: [PATCH v2 1/2] ARM: dts: sun7i: Add Iteaduino Plus A20
Date:   Sat, 17 Jun 2023 22:55:17 +0200
Message-ID: <20230617205624.1178427-1-julian.ribbeck@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <e0e71b0c-086d-ce54-f4d3-6f594d8e5da6@linaro.org>
References: <e0e71b0c-086d-ce54-f4d3-6f594d8e5da6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iiVJPRJM3uFZmd/6C5jhGebn50DPJHjq2/fQpBvgyFbWBSEewwH
 fbuop9dDuu19LDK2/rsvIOHB0dE2NWm0M+Z8dBhIY23u4gJw6rUIeeiZanpSIVyJOokoWqV
 hy1gv657LBZEAlMTQt2lqofEJyBLuDxHul2BWJoiUC3rHUe9RMzDJrlKXMn56M+kw+uwAG6
 R7TyWpf0q0eEt6jXh37Zw==
UI-OutboundReport: notjunk:1;M01:P0:PhtFvfbfNgE=;+NDwu7NGthCIWNGXe/IMhDqUfUs
 MBbBBF+CbKf/0XD7tribnJJx2OGOwkVyly1hMd/dc9dsUeR58BWITAHHxPgBWi4SrEUFBaQiV
 k5MbtSQ4/C/Bp9ZTgXHb0EHW6GPqoWeB8laVuKr5cWLWFOEimGqlL9OT5oQ+PsP48Y80IfT29
 Gn6KyEv24LBQtXP898WCIsUN/mrEF/cB3ETTc0gU823wNg75McmsCoDBsKf72DK4Kezs2dRuM
 s5i8eVL8ArJXQlHyeJFXJpZlrrVoM3K64tBzyak/RU0f8fuWLVsBxRtPIBPp4o7B7NM6u9R+C
 vLptJhNIb91zjfNxKqblfynFdwjl50+s/rarC65hgGG2DDqv6dHCtAn+21yCmOYoVTM05nPik
 KhfFTmGn1NXlzu2ru1jn64pcCNUxYrPvPGmh4y4r5J6bciR92l4nRIMSNmuaDHCHqLR1tiUon
 VziXBRdoBQM9CXDlPrY4k47DIG+Do/aK01gmRZhlLLM1za8bknSLLPLiHaGgNPII/3SGR+JTf
 oiymWu1kWfc9IL/HC+EqF7bftTZUkXInDFnlMJk5EvBrsXqfp7EEICbR33CT3bdMI3j98Noe6
 kithDBs7PSj3ikESu46MVdOUa2xwEeHRCJbQr5Xxx1Qu5pvl6ge+LQXgLtbpj9ZOowZ0FfusJ
 GZAouYuLgYG7cVyoKltPFjmxlT8qp4u4UVtw/tvlxvdf3SCHIZjQQlc/Ru9PsEmYHOhbR6b6l
 eH6nruGDk7S9h45TMRy62Y9lZSqiROJryuyAA0qCGX6yjURCJ945OHuKUiSZlY2+LBQnu4VSK
 SJwG9UgT9S+KtvX3IEFyzKIEVx7/J6eGnNuTdBfOo+FY2VJicBwAsXpAqhhPyyVbpnwj8TDRr
 AxE1HRpJKriqunRT018/anF05uM9C3HUYNE5i4ioJ/qYeKdde323qaUdy273lYPegEVoyMs0R
 xg37ItlA/VsTkgboeld7ACIE6IQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iteaduino Plus A20 is very similar to Iteaduino Plus A10. In fact it
shares the same breakout board and the Itead Core A20 on top of it, is
only adapted to support the dual-core A20.

This commits enables the following hardware:

* HDMI Video output
* USB
* SATA (untested due to lack of hardware I could attach)
* Ethernet
* MMC storage
* UART
* USB OTG (untested, because I don't own an USB OTG cable/device)

Signed-off-by: Julian Ribbeck <julian.ribbeck@gmx.de>
=2D--
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/sun7i-a20-itead-iteaduino-plus.dts    | 114 ++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59829fc90315..3b6e284e4472 100644
=2D-- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1334,6 +1334,7 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
 	sun7i-a20-haoyu-marsboard.dtb \
 	sun7i-a20-hummingbird.dtb \
 	sun7i-a20-itead-ibox.dtb \
+	sun7i-a20-itead-iteaduino-plus.dtb \
 	sun7i-a20-i12-tvbox.dtb \
 	sun7i-a20-icnova-swac.dtb \
 	sun7i-a20-lamobo-r1.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts b/arch/a=
rm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts
new file mode 100644
index 000000000000..204c5f2c81c7
=2D-- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+
+/dts-v1/;
+#include "sun7i-a20.dtsi"
+#include "sunxi-itead-core-common.dtsi"
+#include "axp209.dtsi"
+
+/ {
+	model =3D "Itead Iteaduino Plus A20";
+	compatible =3D "itead,iteaduino-plus-a20", "allwinner,sun7i-a20";
+
+	hdmi-connector {
+		compatible =3D "hdmi-connector";
+		type =3D "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint =3D <&hdmi_out_con>;
+			};
+		};
+	};
+};
+
+&ac_power_supply {
+	status =3D "okay";
+};
+
+&ahci {
+	target-supply =3D <&reg_ahci_5v>;
+	status =3D "okay";
+};
+
+&axp209 {
+	interrupt-parent =3D <&nmi_intc>;
+	interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&battery_power_supply {
+	status =3D "okay";
+};
+
+&codec {
+	stauts =3D "okay";
+};
+
+&de {
+	status =3D "okay";
+};
+
+&emac {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&emac_pa_pins>;
+	phy-handle =3D <&phy1>;
+	status =3D "okay";
+};
+
+&emac_sram {
+	status =3D "okay";
+};
+
+&hdmi {
+	status =3D "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint =3D <&hdmi_con_in>;
+	};
+};
+
+&mdio {
+	status =3D "okay";
+
+	phy1: ethernet-phy@1 {
+		reg =3D <1>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply =3D <&reg_vcc3v3>;
+	bus-width =3D <4>;
+	cd-gpios =3D <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
+	status =3D "okay";
+};
+
+
+&otg_sram {
+	status =3D "okay";
+};
+
+&reg_ahci_5v {
+	status =3D "okay";
+};
+
+
+&reg_usb0_vbus {
+	status =3D "okay";
+};
+
+&usb_otg {
+	status =3D "okay";
+	dr_mode =3D "otg";
+};
+
+&usb_power_supply {
+	status =3D "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios =3D <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* P=
H4 */
+	usb0_vbus_det-gpios =3D <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /*=
 PH5 */
+	usb0_vbus_power-supply =3D <&usb_power_supply>;
+	usb0_vbus-supply =3D <&reg_usb0_vbus>;
+};
=2D-
2.41.0

