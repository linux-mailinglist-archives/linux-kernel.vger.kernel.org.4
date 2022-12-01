Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316F963ED4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLAKLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiLAKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:10:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7424A2E6A1;
        Thu,  1 Dec 2022 02:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669889401; bh=tGPjIDXyTd+H8djbh6OUy4p3OsA16M1haSIo6FaTyMU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Alb/ZJ8WhW9ykDMXO+bdlz0NqVt3oOx6rmyy+7xpWTtfcIVbiln3HJIiad9cIaK+X
         oDZ5dYJvLfjepgmKILZiRln3RdLlwadure1cb7SmsIK/EwN34SGSb1akVG8kK9cg+a
         K/TFBy+RUY+HBxpZcHFUdbSLTfty6ec58BA+n+59/FJPNUgvQNwaC0FTxLfiJZN+nT
         DGaEnvKLhWOAmaql/LnbfiMzdCmHAIL9gZJBveCBtyD+3S9bAJaiV8PZZ/ZfW6+gIJ
         v5uJ7eV54a3vUMOhwrIiGEQxv0WNUfUUIOiUfsX9qybcmvpxbdEYPIvvHKTXIoRr4o
         go1n39n31N88A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1oZHF70HUa-00lWnA; Thu, 01
 Dec 2022 11:10:01 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: pxa2xx: Remove bogus interrupt-parent; line
Date:   Thu,  1 Dec 2022 11:09:53 +0100
Message-Id: <20221201100953.701963-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ao0HOwbnXk8aNFcaa9LImKCqz3uIIpnoue7zex6Oftxop8Wry/W
 cT7uDj/8FszYRMDICTl34T+Ae8cIU7cNDcgUbNrcJt/7kuYfatjp0c+f5NT13KjfOUDRhN9
 L19a/RCbo37M97vzrf/AtloayNzQWx19rNj426f2UR0PTH6JxTV5O8FhTaFtzJj6gELUJF7
 3VSABUwsjyFF1eZ3Lkrhg==
UI-OutboundReport: notjunk:1;M01:P0:BxrIIchcItc=;NodVPmYQiTj++PIm9TRvHKsM7xU
 bFUtBHbinhPgND1laM+i1cNo2fhp4Rm/WOo000FW/XCt+1FROe/K+VykiowmtxyAHfWoVZaA1
 OP3exAqxBWco3el1R8PRQ4eavS/H4YSlOITtubE/Q1K5RClM+93HKDVEn4stl8AFGL+DVWu/C
 2g8gYk9LTb7yOhmdFRPLjFDdIZf03hF0wQkcNAIzVV3LlfC7zl3GwUbVLg7TOWi+upZ6KwdZ5
 8V2jFJaSLyEjIMvibLcuwdOlzevoluLXKO5fobs9RLMVUIEZfVNq3QZgXWKhaV35ohVklQflq
 ja6zeo1nxbVaNYO82eiTM7ZNLK+sHWO30sLq6zzHG0L9KXiGGwbmWv2wVAjpkV5jMhNJA8d+A
 V9ED28KSVyH21uCFveBYUNKOZosxS6j+tFB6EXxOv3AMHDil9u+B/vKN74IX5TlvEYWloqR6a
 r4QDmzGMY2omGFVMmUNFtTYEKSP2MFze8IoszCA2LEXLB/Az+SbCysh4J5uzx+rNQSWUsP1HJ
 ZeHvDWbyMlyABODeMfS6WIPsJ41pvKqIAUMLxYZD8CPyInyFMBNwNO+cwuJut0HpY458XYBFR
 TvWyE5aa5QA9Hm0CtlpWpAbFmhwWdy/zBvPESpePwMOpr/cz9+aLb7DJL7sM4Q+DD5tJfLdVi
 enQtYlsMjN3uxgTPRgX9JK5pFkwltkiuqu3c6izQjXLPtf0+KwWIyDS4pQ2mnv3gpsS4Ve119
 Ec/epCG4CsIOnhT06BesrIMZlukjJAac2uUw1V5Fbns+XMgxE+D+F8S7sVdC5BKeHUYGSJhJ3
 sDR2bvDA+IPmWhftjbYseghGlBlSHPqKEZgTPDXkbJI9TEsU/aYhiFBnJpjJli647qs/OaGfl
 crZQw57XUA/FJyhvH/GntWQtAF46iPdRyyupo88zulaA7CjBbMEYMAIkwiPI9HAiTBIukImVG
 Z+D1Vw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifying interrupt-parent without a value (in other words, as a bool)
doesn't really mean anything. Remove one such property in the PXA2xx DT,
at /pxabus/interrupt-controller@40d00000.

This patch was tested to cause no detrimental effect on PXA255.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/dts/pxa2xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index 1332183f87456..d2c97e1a4478e 100644
=2D-- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -58,7 +58,6 @@ pxairq: interrupt-controller@40d00000 {
 			#interrupt-cells =3D <1>;
 			compatible =3D "marvell,pxa-intc";
 			interrupt-controller;
-			interrupt-parent;
 			marvell,intc-nr-irqs =3D <32>;
 			reg =3D <0x40d00000 0xd0>;
 		};
=2D-
2.35.1

