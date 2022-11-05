Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0818961DD80
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiKES75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiKES7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:59:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F4E55;
        Sat,  5 Nov 2022 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667674765; bh=5lcj5iz3Izvi0n9n+T38OcP3BYJYODxFPQTR7ucDIiE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ukqrb2I4cNKZhLTaa0ZHbYr1o3BP0sP7HsJy53KHHe23tW60EztLdqwc1kLuGGNz6
         LNmPU+gDxWqnn0qx6SQduszrDao4U9bW46nNWoVYM3HZIfWAeC3ggoO/Lq4XBtFbqm
         Zb6y2Je8pnjDAt/0zE7f8PWOtV8Pngwe/+7qoiUC62QezjxVwoB7zTCHNJoS1mggA3
         nXhA3zHKf4/h7asSjls2CnIu1ziNr2F1XEqAM1yOJ3ssTsgMdiSkILQm5tyIU99jfF
         JcAZ+ZwfVYxji3q8iRdYbUOa4owcHC+Dzp5ZmtltxyLDn1iAQCb0wg9SzXZVCmUkoR
         yfMJS8+2UT6AA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1pRZ563gnU-00ck71; Sat, 05
 Nov 2022 19:59:24 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 5/8] ARM: dts: wpcm450: Add FIU SPI controller node
Date:   Sat,  5 Nov 2022 19:59:08 +0100
Message-Id: <20221105185911.1547847-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CRar9ivUzCsj49qmjSPQqicgToyrxgj4f3IEg3FyzRlYqRIlXZc
 QE5AaQx6SFWqlBCzK7A0KBDJ30lM8CbktVojH8nGNDcdJfmS6rhZH7j12pUg1+51Bt5FFih
 AjK2gVZf3bNcwypSPW42cjgG2y8ijYg4r2oF/veWkdBY2fp4pU9xS/Lirk4Cy/vc013eCiU
 NelRJOl++C9eX4U1HdNYw==
UI-OutboundReport: notjunk:1;M01:P0:f8EehY0JCzw=;S7sM7wxvJNtt9sMfxlbJ8MIhnBr
 NGIBM5nXSeHgU+AKI4nURc1AXiBsVn9B4v/ss85+/5qG2IPQQ6vvHXYGFjUedCqR4sNqznOfD
 MdvO1PVYTs7VzPun0g7vPTb8WNONuVRD6u/XDlkNkReYrCU8BWqKSRPmldVHYIYjweCiJQa4B
 CKosZeYnyJYyZzqLJLQZbR1e3KPgvlPt5dfzVkg2yPSUTUl8kinEtLymrqq3PVIVq6m49A0iw
 kW2VkW3xi05qaH15sqelp3jC2VMS+Dm5vFAzsqJKnAI5d/PdPKoguDK/rkEq7MTyemrY7oxfR
 hDXCrOvLqn520qHuSG44jlmNOtwcQe+8LwB5eXdlWlCLiwUQ7LAWdcjv5hCP1dbLsjGuCV05x
 SuxJjak9JKnAhQoD4ouNlzgOmdzcu82vUpMe5SWaOjgbIRJt86amZQFcp4t6BLvyronbfP8Z+
 gn7H3MHVhtGL+W7feonATIvAhnyIgU9HlNQDRWSA9ON5haKP0HurSsKRZS9sy+nDtFRuvO7Qm
 XWl93jzhzF4uTspuG4s0Q5mfDNbBjg1DnaieJzm/hDHeehJ+GCcP1VRQOHNSDQYF/IQ6MS9ay
 E1IbMiqIgOLAhgbFlvIZ0y78GdqIUWPTDpfI6xJCy/mgQNn+/GiGHB1n8dua3PTa5Y1KsgndW
 xDCqzCAsGt0eJwRGN7nOe2Vf0w4I3soxJSG1peQzwGiWZG/dgiLED7OE3wxVEH1+ZRN14DPU6
 y/qeXDwh7UJ+iy7H5glm9iCKP7usQrw/P2588O9kGrBjcKc0i7Q0YqBiIl45Rp8cVxzVm0LxG
 jLd6ZuP8I815OyYNlkizaRieTzVujxi80Io8fXdozUw1CBOWLqh4nPI548TuWmM9Qdb/4BaJR
 6uzKRiKdEVBQEXkm5nYfU4M4H5St8kc5aCqFSzH5C0JdFNK7DOgL9Z/e0RRaEvIpUx6s+B917
 tm3mSbG9dGXS30EQYt/yFVm/fXk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPI controller (FIU, Flash Interface Unit) to the WPCM450
devicetree, according to the newly defined binding, as well as the SHM
(shared memory interface) syscon.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

This patch depends on the series:

	[PATCH v5 0/6] Nuvoton WPCM450 clock and reset driver
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index 439f9047ad651..299fcbba3089b 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -470,5 +470,21 @@ hg7_pins: mux-hg7 {
 				function =3D "hg7";
 			};
 		};
+
+		fiu: spi-controller@c8000000 {
+			compatible =3D "nuvoton,wpcm450-fiu";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0xc8000000 0x1000>, <0xc0000000 0x4000000>;
+			reg-names =3D "control", "memory";
+			clocks =3D <&clk WPCM450_CLK_FIU>;
+			status =3D "disabled";
+		};
+
+		shm: syscon@c8001000 {
+			compatible =3D "nuvoton,wpcm450-shm", "syscon";
+			reg =3D <0xc8001000 0x1000>;
+			reg-io-width =3D <1>;
+		};
 	};
 };
=2D-
2.35.1

