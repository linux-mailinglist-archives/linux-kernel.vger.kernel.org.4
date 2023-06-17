Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8773429F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbjFQR15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346366AbjFQR1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:27:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014DEE52;
        Sat, 17 Jun 2023 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687022863; x=1687627663; i=julian.ribbeck@gmx.de;
 bh=4rrE9fbrtibQKxhrqH1MY7aY9tEVOUx8M44gNqot0uE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=McwMx4UkIqlLpFGrHfK7pqcIosuDDGZ+Lh3tfwchMNZ9pYDNHiWhrZm91WrXFCid0ju0p97
 F7d0ZJa/bfRyDi6lxWAyUDW6gSEQdVL5IoNpH5F/8ZcNWIEvXrzBWyg8HL0X/Ygd1erKTVqxU
 W2ULxza8RgoafQiQXtjiGv9GbvlLmW+yY83AhfznRI1qqlWHl1m5Hai4VGjjasyIfUtLYN7nH
 gFDebgEj0SaSoT5chwqOCOWgsHyLIpjQ7DVAoOZ2LpfcrBHbgpyO6lD2rm2k+gqx6a/WsyR0s
 xZCAvJkt6wD8HeuGoxIlr6LjY/g0TjE8qiqWIi66leHNz3UgeSFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x1-yoga-arch.speedport.ip ([93.242.194.247]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MysVs-1pxjvZ1n8c-00vyRR; Sat, 17 Jun 2023 19:27:43 +0200
From:   Julian Ribbeck <julian.ribbeck@gmx.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Julian Ribbeck <julian.ribbeck@gmx.de>
Subject: [PATCH] ARM: dts: sun7i: Add Iteaduino Plus A20
Date:   Sat, 17 Jun 2023 19:27:35 +0200
Message-ID: <20230617172735.1098591-1-julian.ribbeck@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nCL+sr8yW5ABMCO80uxx558sAlW0aZ8z/IBe/BbgnErlAM7g6T0
 BmR27XqDoCI72fiRogdw7vsD1NLe2Qv7ITxISfJxE0yEnaf/pwZ2UTk3peMGDcWo+g3eQIH
 lHEPa1rfhrhtze7u+8yCSKLq9GR7zNh6+eeafHLDUY7Ea9ttFlNB4Ts2jmISstvMxWvDW9p
 2edyGUOJeIuP1W1kyPVSw==
UI-OutboundReport: notjunk:1;M01:P0:ZNgCLGI9FBQ=;bKBLSChUJONOroUJNG9dxqPql6w
 fTNDdBDN4vHWZcOuRhVBDc+bWKPlL4xf0s760PKk/P5T2gG1IyuAKwlCtsAMlUJ9S36U0QUgS
 hTNxMzHNuVbeqPXeov5oCWAdslnVhWa0oQGuQIoB783rNOGRTzkMI0biuXbsD3tYs9oeLDbaJ
 ILutUG9sIKIAk/iCCNUdrchfWDdbvy0QB8TBjmCPNgiXNwMhQa5hTuiDXKRWRn6OOJVHLc9uU
 Z/ejAcryDv9ahNPVIQE9ZS9UF/IwcEa1VVZGCfsjJ7KLX6gyn6YxKiIeBsMu2tlIpEW3iM38X
 wERdao0xw9qnKgt49Apd40wCedd1ldhzPKJJBI+7GJCrZMucAfLpOthVoJj/NCaS2P3NrDRGF
 extsnD0R5Q9Z4BKAEbrBGIzQIt67LhwxmaFhcY8UXKUCBMr/dPfnAt7eXPXP9kIjrmY6NaMWb
 tCD6XWBjVdFN1/wH//BFUMbsZoHme/69yQpgZipPoJ2C2nIBZYXYqxKk5r2QDPHW9s/s8kZNX
 0t2OxB8A0zhDCEgq9mowODTv7ViSwngdOC3RmAFnJpFu++Hc5m093X7QVLRKuS57SKJdfXfW0
 4RlaI8TLHMFQQZgk/6zQRmQbWeiVQ3agp9mQHswoMElL/cJ+Q9ii/IleEfccAo4NUn9vSKEMY
 RvD0V2J1XwPoYPh3Le8G2uCHjP103H51jIh42hHjaQbTdRd6GRivW15IA3hVBKAZs04Dqc2En
 2a+FIpeh3zlU8bPz2ZEUdpYaOL/Fe9ocXnx0xuNVKaS02j0tRNd4NweGBssDwhlqFhhwjlQ6v
 Tu+3OoJtkyCsS0ieFEvvnJtOG8ezwxXC2ZR4meCXBlUTZ2kcbaXSKpL93knav1DP8A1clR4aX
 XdT8KpN7E4WMVbVSZfmLCVJbFPM+7AGM0jNz5wDLoj4wf8nDvgr63ZzOb6clN8GVS1lOx4V1+
 GLQDWGYkLLpHl8RlOMkAdu5YPLw=
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
 .../dts/sun7i-a20-itead-iteaduino-plus.dts    | 109 ++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59829fc90315..1d5ab086f8de 100644
=2D-- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1334,6 +1334,7 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
 	sun7i-a20-haoyu-marsboard.dtb \
 	sun7i-a20-hummingbird.dtb \
 	sun7i-a20-itead-ibox.dtb \
+	sun7i-a20-itead-iteaduino-plus.dts \
 	sun7i-a20-i12-tvbox.dtb \
 	sun7i-a20-icnova-swac.dtb \
 	sun7i-a20-lamobo-r1.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts b/arch/a=
rm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts
new file mode 100644
index 000000000000..8d94db5520af
=2D-- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts
@@ -0,0 +1,109 @@
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
+	interrupts =3D <0>;
+};
+
+&battery_power_supply {
+	status =3D "okay";
+};
+
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
+	status =3D "otg";
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

