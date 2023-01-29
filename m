Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290CA67FE88
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjA2L0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjA2L03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:26:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF427DA0;
        Sun, 29 Jan 2023 03:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674991580; bh=iE0ml3o/oeykLX0bNAtwyLIVpBJx2KBOrIqSvWHF1do=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GynCDDkKmhcGUaN9MK8UWc3dy7lPbOBSqhzOGjfgcIoHE0M6t19yd1V9UiuxNAdLZ
         HBkWIIM52j29IhfV2evtTxIZlK6KKZzzCgvHB20EEPdoj/W3AyrgKOQpEMo6MV01G6
         OdT808lSMIr6oJI1acGmK0+r+j55GEnWXbypa6f0CUqOckH6Ph9hrSgQZ9kMKQlHpw
         Sw4X+eM4gQotvXIMfru2zc0+ulyhGehEc5n2+0Q+FIm/6UPoWeYxD1W/KoKuT6KDjP
         Al+fiy1kp2/ojkzPZlRhqfxymOFNY4XA7CNOux4Y9HcJVRuXWLGfNahEqB0s4IroAa
         4YQC5ZDIIBs5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6qp-1otNaB1pvf-00pbQZ; Sun, 29
 Jan 2023 12:26:20 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: wpcm450: Add nuvoton,shm = <&shm> to FIU node
Date:   Sun, 29 Jan 2023 12:26:11 +0100
Message-Id: <20230129112611.1176517-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oE5K8PVURUUYTJFsmav1i8mDxxB09kKS7hWEFYnsvBPy3yMxFww
 ZLeShVJgizXDtn7hol9iccrI9YaMJQVBMtV1gtiwVNniZ8sblVFMZV5QX8UvH/4/iaBm6KR
 9lT9qtS+kNGQWA5N8zthoSQc+eHMbhWSOwlZGCeZ4DCkBmEBEWjFHU7bnbKGWz7kjasYK0o
 8qOfFFXgOw4dPe15BUXaA==
UI-OutboundReport: notjunk:1;M01:P0:BK9mXZXVw0E=;nPW1XgAKKaWHZmKKlrsRPgtnXG8
 9te/AMCjG66kvLGJK0YdotC4OTHYMS+S8vsSMnVvK2nwjnUXRWEpLtnr+wFiEIEXnxpMcTsDQ
 KuWtmYp62qU+Ya5KntZSkhpp095pZAqwQplw6YeBvF2ndfMz8KcmLeVuHnc5EsIJSlb/aK6iZ
 GP/Q1oksf7qJ4X4YSCtCt+HbZdbEVee31tXUUTWoH2UbTMqxUFDBpTyD2SnPsFDRXU2e5coOK
 4slVuzSVzJkEBaqBHd9eneu1+9frBoRMgUBOMMF5l2OUEHaVznFtDWB2wbIDYg+7EbNCT+gAV
 i4BVI1pRssqy38Pg8qPnXZWjPFCc7olOyzYtsudcNSazxvMB4iH986q0oewUVSHKRFYUnBjFn
 B11zhHBoEMFB11ADNTZgkAMG0PNDjHvsT9xyjZW/uP0ckz0MdyfGZ+j+NZ0x/Oo31jrB9JUf/
 o/pY2SDdNV7dhjCSIXIKTiETnTAZaBIQM1sPZlc2Yb/xXoFus/0GZBHECkBR58dXTNr5EUkZa
 e7iUr+/xlzIo2q73kzCAAbDzets+zdDz/y8wRgc2gqKrp4/i9R7Xe75aajN5YKoKMdNs6VgKi
 Mg2s1PtFgXKn9LzRdhAiX3CG3RPoYtMbhBrc1vMbLs10j31UkhZVamHqeIwEc9UjIHwrfqRKl
 S4ZnLq0tN4NHLTy2yN1WksvpyNq3Le1Z8HPhB+tKXaMBs3vgDKl1+y6J/HhoBQyWY7M0rFqny
 fdeKTANd5wN/KoIR0fFZnFNME73jmtarImVAlOu3T/Q9q8GeCcaNOltMlNKL1LdmWdYmzpVRC
 P4GklNg83Lbno2J5leRHKavVZ67Hq++3BpUrQQFWdm/pJDXrVjBPuV9zIHcdTyTyWGX48Dj53
 3B6UL0fF3Xvt7SFNw5y3P/gsyuNYR/exAaDbqYrC5DhFw0JC67eePvx5stWHOgpBY8tJ2k4s3
 DYnb/1ZC79fXOe7v35eT8qJij1U=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Flash Interface Unit (FIU) should have a reference to the Shared
Memory controller (SHM) so that flash access from the host (x86 computer
managed by the WPCM450 BMC) can be blocked during flash access by the
FIU driver.

Fixes: 38abcb0d68767 ("ARM: dts: wpcm450: Add FIU SPI controller node")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index 299fcbba3089b..fda2f13093f98 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -478,6 +478,7 @@ fiu: spi-controller@c8000000 {
 			reg =3D <0xc8000000 0x1000>, <0xc0000000 0x4000000>;
 			reg-names =3D "control", "memory";
 			clocks =3D <&clk WPCM450_CLK_FIU>;
+			nuvoton,shm =3D <&shm>;
 			status =3D "disabled";
 		};

=2D-
2.39.0

