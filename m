Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07FF61DD79
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 19:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiKES7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 14:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiKES7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:59:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209322AE1;
        Sat,  5 Nov 2022 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667674766; bh=bK1RUXAe+xpxxpGUjTTgd1x6zwE6ztff1lqUp39rxNQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gy03nHyEDASlmMOM28yBL3RQ4FCZJnUx4G1ivYXgWT0gF+FylMDp8YzFzeWUUYCr2
         p3mlP+9WXVAvGUy0QQtc4rtgm5FbBFLLzRLmkVoO1h0yAiTmosw3hGQHfhmr6yjMRr
         FkpxXNbXj7QYj89/ZsDIp/aQM51btLzTrgxI645ZzaAFM9u5gslUIrd2bj+X1Z3wrX
         CjhC6r1l5QrNRHd7OgMRVOXwDM45iAA5QGNTCaVrg1snGTJmADjGnbW/EBF0EUXuHu
         dvTrSE1Uvwzr1l+usJbgsUYd2gR/cM7xQYZjRZ7Qcmj/pTb06avNokiYjpNusRTuRc
         z6dIa0G9efSVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.44.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3He-1op9LK1TeS-00FPgw; Sat, 05
 Nov 2022 19:59:26 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 6/8] ARM: dts: wpcm450-supermicro-x9sci-ln4f: Add SPI flash
Date:   Sat,  5 Nov 2022 19:59:09 +0100
Message-Id: <20221105185911.1547847-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FZU0RXgcUNGQI/fiMCkh0UXPBADSKhLECE8zLUwxtzD6QQYaUX1
 qF/e4enn/IXaBQeQO766lveS0QEfFavPwpY03jbtfdeGVozY/ciEUkF/B5I46RfSJMeey1S
 dEg9k2/zA+OClMPTfA1RzImkg5Y3FqJnQabRCOiFSsZF/KQMLwixLJi09R60XlszJkZO8vY
 3pPld68pPgH5l/Vxfi4vA==
UI-OutboundReport: notjunk:1;M01:P0:2VwYnSXCeMo=;7BAaka/fpvRGgAWjY1Gv6Aadw4m
 kkbfhU43cVx9601VeNjAMuIINK1PSYnH/36qg6AbeRm6NYuZW5+u5XR6yqf3KurydPTDGQ4E0
 TVoqpC03N1SEPLZbpITQIpT5y1lj7hmaQofwUlsb8VRXjn2hxQFJ0mB4agnXiU5TMBy56D7+G
 hNpgkyAb5TTJpuZ9CQ/boVyPYP1f6Bj81ACoPizhHdFfnKgb+kJV6QVRWaSElpSjLsQPUUVnP
 t0DqojkAW1/b/d7Z//onZwYAhu9DTAU5oG5wc1AcNLJuv0DU/O8aExcuC/LdrehkkDy37sVY6
 sMajYmW8cPcO8M3gDUW4YKu3tjVo1A1y37jluVIzvsmSfnkMWwDL0vB2Vsa+hLnbi1dik5feR
 DTnTYAZCh4XYun1ChTrio7Evg1xSX5sOz4cRwwXq4axZQ0/4Qaz2nBoJHHqPm3DsXrqZWUaoE
 DErpINkUvuC03XHPkQ1FLY/cZIHMkrk02eiT9JjFQ89EV5cLaAv4TLgIuJif+qf6xX0Ik+WRc
 NuoMih3e+mw8sceweC5BOWnQa3oa6GvoLwyR7VqK6VtAObQ5rfRdyP4ApF6Xa2ZZITQFR1aGz
 FN6+SyhNHSHTscHz7L22BZw0cEVXpPzQiQ9th8/0vhANOX+ScIu+20QLSB4Q1IZgKhYoU/pri
 COXHOlbs3MnJPixQU+WitLrt5DLl0Wq8E/u5wqTO5xDCzsXSUbt5zaT/G/R2qTmvmFDFusNuh
 EW2mPDe+XE3lIHTr4N/ipd5bjYQJO6IdDNEN3DejyH0IZ+YbiW8dquS+yyRA7mgt9jrNery0C
 t9V2L2NIhLuVza7woT6xlzYNqeJCALPOcZtbDSwkPBHkihbXOTgDLU+khXIlSkhcSJlMCFYDu
 LjnPM0DSu9DwQO/msUgODx0xK+dhUFoWQ8rwO5k/vKlhpDuAJZpcKP0he2mgvyZZ/0y5wMIgQ
 LAArtPgvZh+6qxOfdTteSJugGV0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the BMC firmware flash to the devicetree, so that it can be accessed
from Linux.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts b=
/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
index d4472ffdac928..b78c116cbc18e 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
+++ b/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
@@ -58,6 +58,15 @@ heartbeat {
 	};
 };

+&fiu {
+	status =3D "okay";
+
+	flash@0 {
+		reg =3D <0>;
+		compatible =3D "jedec,spi-nor";
+	};
+};
+
 &gpio0 {
 	gpio-line-names =3D
 		/* 0 */ "", "host-reset-control-n", "", "", "", "", "", "",
=2D-
2.35.1

