Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C830619CFD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiKDQTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiKDQTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:19:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B2628704;
        Fri,  4 Nov 2022 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667578748; bh=5nTOWHVLx+MZr7NjLvj6ZC6mnVnRo8KPzHbjhk46sVU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pF0UJd52/aoFrY9j6aW5ecjl4zTwGWbLjZdGdE5a2s3toZv4u+cabdtZBkk5O1oDJ
         fTjBSuliX+AQe0TzgqrBoCCIMTfBXi50hRMgJ9RyyIo+7+po6iuK1ebUkdePSimxEl
         WrDQB5ROVK3VWHEIN2xpLOK746BkidAW4A0u19Mt9ooBlQnQTBGFrFBPXV3eGoHX3C
         LO036qKbFjUNYv/R1saX769DfDsgt6QF17QJtW3OeRjx+RoHP/X/c4s9fm25bQEWhM
         5VwR373Am3wu21GW/3yPhKlk0FLGekFFUepaVz94peSjPnqNnP3Thk7D8NDz6pFLNI
         AD3hoS8XL+cPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt75H-1pAi5F2ik5-00tXrC; Fri, 04
 Nov 2022 17:19:08 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v5 4/6] ARM: dts: wpcm450: Add clock controller node
Date:   Fri,  4 Nov 2022 17:18:48 +0100
Message-Id: <20221104161850.2889894-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221104161850.2889894-1-j.neuschaefer@gmx.net>
References: <20221104161850.2889894-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6GvRklvuiyAtWqrEnqxNuJ2Hc85LbGEBI/GCoPGar4I+bEWfCpu
 i0tKTbICpY+FZVhd472ngdn11RIAaonUb0UVXfgtUIoWPuuxsPTn8E59MMQWpo+2o/t6dQ2
 XTqCnuyfrC2rYN4rlb0YPgzBt8Q1/+IMxuM2Qktm3/3AXPyj9Sxq4nshOqwU4exHo8FigD4
 oVALzHtdq9oBvvqyDsCpw==
UI-OutboundReport: notjunk:1;M01:P0:3f2zS5TzCt4=;IAeV4M4Oen9SP2XuT03OCcXQkfT
 EReOc8Rd+WPVqYjTKIzmrx+94zn5TMR407ldOXqk9l4ZwbLyflmVeDq0R+yC/RGTGYjTsc78V
 EUzbCcDgR8BLLFJN9ivjmvefdxYRv6plJSSWFqLYxOJRovK3SdWYSqAJ+wTo9t54NPSdZ/6or
 w2T35/DGf7VcU9M445YwXr/+9h6WvKjz2vlTXJpq23yoC2S4CM+oFS0MVfdDa2JbYLkNmw81L
 FeDupeOwxuGWUKzkB+9+ER2WR7c6WyG7Sjet/PfNOMMUM9t3Uw1m/HyfcsZHZ6IaHtjfcX2Y3
 jCm9omGRPoUyCjIBmUEHrtjcssj9fansfrPLFK8NYTbBFnkmu9uB5YRq9vHkB5sH6twX56qro
 hdbQcyS+EO8h/WdL89foTy+VImi913I8LLeHkot2xipqZ8U5bweH4MwvDInjQNNzcIo1cInwy
 3cJRTVS1K9Mzt/h14OnyNJi0S4IgYm64n0+yglOdotM67pnkZLspYJh2lwfKZVjyeCq+mtX+9
 xfF/oS0BbOJk2ye/fO7HYlQuUYl+ImEstolMKVxmYRaqoBtvqG40Oqqo4BxoTs5JS5ptjXqRg
 zetpCutRxARXJ50ohSJL4bQymyo9/X+pepcGfk4oQM2GQfYZK5gbHh5lDQ3zH1WIgYKIZWkQo
 BmqS7yX8awToAF2usdBXeU72J2N64UX1hyraGq+FI4m730XrkZpEHWj9xcK0qxiVFv9YNk6Tg
 21581uGlpdbYqdFbT3uW2EyLpcqe8Y19NZrAa3NnxDvUspj7mCe28m2qZ/YsX1KMeR+RsquKx
 Dj2KSQZLVPxXa5zfxBRe2O7/LZAbs/NzAkccAuAdpWvJvBnstVouKuWlDt4ZjxEiCXdPl+2AO
 Z44UsehWDpz4TJB9m66pkMSZZLJgPkpePJwT7tLsXkUUXNveepZqNE4OwQDhHJ24S6v7mwt07
 XYHl5SHqlqVEWWrRaVJ+03+VhJ0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This declares the clock controller and the necessary 48 Mhz reference
clock in the WPCM450 device. Switching devices over to the clock
controller is intentionally done in a separate patch to give time for
the clock controller driver to land.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v4-5:
- no changes

v3:
- Change clock-output-names and clock-names from "refclk" to "ref"

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-6-j.neuschaefer@gmx.n=
et/
- no changes
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index b9b669cd632f1..332cc222c7dc5 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -37,6 +37,14 @@ clk24m: clock-24mhz {
 		#clock-cells =3D <0>;
 	};

+	refclk: clock-48mhz {
+		/* 48 MHz reference oscillator */
+		compatible =3D "fixed-clock";
+		clock-output-names =3D "ref";
+		clock-frequency =3D <48000000>;
+		#clock-cells =3D <0>;
+	};
+
 	soc {
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
@@ -49,6 +57,15 @@ gcr: syscon@b0000000 {
 			reg =3D <0xb0000000 0x200>;
 		};

+		clk: clock-controller@b0000200 {
+			compatible =3D "nuvoton,wpcm450-clk";
+			reg =3D <0xb0000200 0x100>;
+			clocks =3D <&refclk>;
+			clock-names =3D "ref";
+			#clock-cells =3D <1>;
+			#reset-cells =3D <1>;
+		};
+
 		serial0: serial@b8000000 {
 			compatible =3D "nuvoton,wpcm450-uart";
 			reg =3D <0xb8000000 0x20>;
=2D-
2.35.1

