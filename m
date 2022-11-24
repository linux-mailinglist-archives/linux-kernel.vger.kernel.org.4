Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A93E6375CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKXKBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKXKBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:01:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A372F3B1;
        Thu, 24 Nov 2022 02:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669284079; bh=/9FLyEj0n+MtWEUQoIkaa/u0bNRlgIDP3h/BXKUCiKE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Vqt+iezXMd5oCrYIPMXCWThYVsfWSeR554qJKc0wqV2PVFpz0HTXb7MU1e/KvMiBL
         VbqTW3vqDYzy+aQNoDnoyNmB+DQQZhGCI5WWBwf7Wk5lGrkSe4AakFLbpz3aYX+GvD
         9cZy9erDwlNKE6oDYgeGYOSqIgKu+WFKmQuffFBV+n4+sWNx8ZNqAWIgSJ14OG0XiR
         kVP30V1rer1ch9jr0XQlbtfg/7drmI9PRbmC79MO1ohKpb6eWH1Z6d9C9LgoVMXTbL
         +wWWGvBI0nA3DUZdd1yQuYPlHo44DdQyjdvSCx9PSnmqw7pW1Tx8O61VHoYzrT9uu5
         NW3aMIWMwJeXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1opeam0Oyt-008Wfq; Thu, 24
 Nov 2022 11:01:19 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: pxa2xx: Don't mention &pwri2c where it doesn't exist
Date:   Thu, 24 Nov 2022 11:01:12 +0100
Message-Id: <20221124100112.4172513-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Ot0OMkcsI4e0y6ae0wMYriPlY4QX5twMZ+8eHAvrmRPa6fXQ5l
 pAXyEmVKQUVRuQDTtyRDb2SfEmO6blPrZoX6wWhuDshJ23pbJ6eHEYCoxIdu4V4z8fEtnuU
 EvsL5++SjRPYehyaevrA9rvvRa7bOMyRVOyJx9DZGjSj9fMFqeYatd9LqlrZCtc8Kolym+8
 3lvvU7PksHWdjOQqPgGDA==
UI-OutboundReport: notjunk:1;M01:P0:OqxOPpzUce4=;OCZyzyIV20RALRJbTrwMFo0RsGw
 Xl2sv39ADMu48CYJzu1OorDysyDb16YAWCK7slqoh3/sVd3h5SNp9BOnzVCkrTyOdI0LHIb6/
 k1LJFO0z7RGNJ0HdeNsRimasxCxkAeBES1aCZuwVzSZ6Kwp3LdMBE1wqhRGuOSsrElcHep4Gs
 lfuaJ+CBaji344vBBTSterseeGuZuaNJZZSUxJLSH+lQavyoVpzJYiTF4tQieIV7zz6T/qAhY
 vBFYt+haqK63O5sdf01U6m7qJ8FA3hmoME826bp4NxkcefyOkJy3qb0eqTWTzN6rVfz5y0UYh
 V/UzZ0erjcuTqNaCTIbprWpORNjSdjlKVUCs+zn5UE7aV208SMwdavMKRsMNtEvF3KFI7VX53
 8fo5Znrrihyzu6PvyZrlJW5vtDEJ2QplrY9jjxyLT8yv3gyXidGY8HFbGG6tN0gTFE6e0H25P
 UPyORXtJfgXzjvF0n+qBXFtt3TTKEJbo2tWNvadvCKQYkP2RVmC5RnDNPpe+N+sbNXFXHXIfL
 AQjNOCYsq1V+v84hF8KvozcZVnY8tPXN4U8+rIw3zRK59qfY7MYysD3C/zph7Ymx+w6f3fZsS
 LVydhWLeWVAR2xxc4wYOALYzQogoeaD9Zt8d0IrD7pvzZFZQ4FYdcGpyLI+SLDm93M76VgJzk
 EgOcVPVoZb7Ma3k51Ge04jzd3WPcYjfz08LKDk61o/KRWRhfj0nl6rml0VpgCuTl1nzq3hfyc
 URZ3cM9ShFQx5FCpzbIYkeQ6PmgGcv0+6n3fOrliwUzxbR3RY94JY3gmt0ALKcAGKiWC3DvUY
 fPrJXMk7I1ulvWbdRmlyg2/8lBKdgzswLDkSRSQkq+C9DGjPk8Y5f+ggTmYUnR6NIyO7o4qqL
 cdAqbft3BlBmUyuaUuGiIihGdkuKezFvIpek5otseJxexOji9tiBLFUTR6r62evQjVvemgkgo
 UbXN3g==
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pwri2c node does not exist in all PXA2xx SoCs (specifically not
in PXA25x), and thus isn't defined in pxa2xx.dtsi. It is, however,
currently mentioned in /aliases, causing an error when building a
devicetree that doesn't define it.

Move the mention of &pwri2c in /aliases to the files that define it
(pxa27x.dtsi and pxa3xx.dtsi), to avoid the error mentioned above.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/dts/pxa27x.dtsi | 5 +++++
 arch/arm/boot/dts/pxa2xx.dtsi | 3 +--
 arch/arm/boot/dts/pxa3xx.dtsi | 5 +++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index a2cbfb3be6090..1f217eceabbf7 100644
=2D-- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -7,6 +7,11 @@ / {
 	model =3D "Marvell PXA27x familiy SoC";
 	compatible =3D "marvell,pxa27x";

+	aliases {
+		i2c0 =3D &pwri2c;
+		i2c1 =3D &pxai2c1;
+	};
+
 	pxabus {
 		pdma: dma-controller@40000000 {
 			compatible =3D "marvell,pdma-1.0";
diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index 84154c43fe654..1332183f87456 100644
=2D-- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -38,8 +38,7 @@ aliases {
 		serial1 =3D &btuart;
 		serial2 =3D &stuart;
 		serial3 =3D &hwuart;
-		i2c0 =3D &pwri2c;
-		i2c1 =3D &pxai2c1;
+		i2c0 =3D &pxai2c1;
 	};

 	cpus {
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index f9c216f918653..57ff0a63e9acd 100644
=2D-- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -117,6 +117,11 @@ / {
 	model =3D "Marvell PXA3xx familiy SoC";
 	compatible =3D "marvell,pxa3xx";

+	aliases {
+		i2c0 =3D &pwri2c;
+		i2c1 =3D &pxai2c1;
+	};
+
 	pxabus {
 		pdma: dma-controller@40000000 {
 			compatible =3D "marvell,pdma-1.0";
=2D-
2.35.1

