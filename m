Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A9689E64
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjBCPgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjBCPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:36:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E206F217;
        Fri,  3 Feb 2023 07:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1675438571;
        bh=P9k19nklnfp8zjyr98WNbqWJ3pcfo/IFbSsgLrUsy0k=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=T6h+QaHdfOlZU59CWJmZFrYc/pPROYjzeEQGH3qQYBFuEoVY/ngJkBaE18nek+RXE
         km1dHXLzOS6M9uRcPhF+IKIrn0mi6pFDNW2ZQKk9naknHdGZyYaABfRdsc07bNGM+O
         b5FI4a+ij1HKdqrIDJN7Euf04jY8fP8Vu/psEEdBoMdjoTkH0v9HtJS+VJ6o/5d00w
         2xIW3jv/2ojoMg0JUI61qgcDfXmGxPu2dJRv5A/14SduMQQ5A6+cNVFgGmGdCRaVVv
         sfOIlGQC32vcPcsCu7YO1W9bkHrXT2/ZCjCJFDmBnwfKjxjaJEubQ/O7RfGwhEoFQz
         L6JPNCpF2NO6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.79.254]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fIW-1pHvhR0GK2-007Er5; Fri, 03
 Feb 2023 16:36:11 +0100
Date:   Fri, 03 Feb 2023 16:36:09 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     arinc9.unal@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Re: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20230201185656.17164-5-arinc.unal@arinc9.com>
References: <20230201185656.17164-1-arinc.unal@arinc9.com> <20230201185656.17164-5-arinc.unal@arinc9.com>
Message-ID: <AC473057-266B-4403-9270-8007E0EC257C@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fq66cXMQ7PDgT5kGmMVa//WAyfmtO+lqAVvGSRCIkiotxM+5zae
 hpCM7/ymJTzxKiIsmZ6UpbzfhYiXdfLtEdDtKgf8FmprazS7xUlB0ORoHEy+s03zkrWMg49
 1oyG9cbnZ6tnVwWKSCh7rRQrOL/DDf1xem5g/86ZdiwtxAYzu0vzfO5YA+4NOPYLXIWnixt
 AWKrr7bLrNMzZPbjoaPdA==
UI-OutboundReport: notjunk:1;M01:P0:OaLRXKJrZrY=;m3lYOpzBzjojWR5/McbyO4NliuO
 dhiQB6ATa4YIR3JTXFewyWafUnlOQiKIj2kNswENbzcshkDKsXHa6aD/9OT+hIgRrojAHUTXf
 YoZkfV04uYiK7r9xWPq9Agc+Nv5yLbq6xw2uKENExfi23fgsm+nVUwDbyiX8cuBM3j/E9Slls
 B88+YamCV/kz/+6ac+8Ti/Wg5ORaBRsrWp+7YR8bv6h2c/JlEgOZsgaPqt8qAei+h0Fb6LA5B
 xueYNgIDSQFXT190ALitKA1qhi6hY9JF6CQmhIpt78kHNQWXvGt1pesA33mn+MqHxb4NKmfix
 fEx+OJzicpd33qnFny2ME9GNvbM03NuBF/jNREVsgXiu8JrVrTKVU/x+pI8jeXoeEpOyWmlgA
 15M5TVFh7YUyHQZjjSxmm8JekrbfPFaYgi7TC+nEHHGJ05OFgK5ryIWhV3TQCHEdfOP2jQFGZ
 02Ol/9+36vZvfl7jHzManClEeN649f1wKji1HAOu9hajTCGtX2d1luUSipoevRFrif81S/srB
 SEsvD1fJxvCcTCYCRBipCzExbD1K1eTdH5iujGs9aIj86g2eGGrrj3jbP1gonO29h57HAMi1T
 P59e0g4J87y4enBerz7snXXgN46HCEWQTzgxoj6AswddqORuutUyzj2crN8E5MuBtoSXW3ahr
 75k3rZty7T9zpiPyIQOuqLYGqLHuebsNCNWLO8n/n5v25wY/q4RvDxr2yd6vHaDPjfZanZAQG
 T2hqT3LXCPJ6QwBDNGaIQaRbyqLwsUtn6SYQEWVuJhgDTh8wN+nWs8wzsTE+6rbBG8zdECSQZ
 OINg5bFPOJgs90g641uqpRQ8nx1h3TPgEiPEieHR2KCfZmATBEx5/Al85Xsa1Ow2JFJLzRPYg
 89T4V7YvtMn4axskqaQsKqLinIBqNubiovPCNt5pVKZcbryiAkLY7ia1ABr25CKlkLCIaLYuv
 kX90uF0ipN6FMh9GqDzAYbS2Ljw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 1=2E Februar 2023 19:56:55 MEZ schrieb arinc9=2Eunal@gmail=2Ecom:
>From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc=2Eunal@arinc9=2Ecom>
>
>Mux the MT7530 switch's phy0 to gmac5 which is wired to the SoC's gmac1=
=2E
>This achieves 2 Gbps total bandwidth to the CPU using the second RGMII=2E
>
>With this, the interface name to access phy0 changes from wan to eth1=2E
>
>Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc=2Eunal@arinc9=2Ecom>
>---
> arch/arm/boot/dts/mt7623n-bananapi-bpi-r2=2Edts | 15 ++++++++++-----
> 1 file changed, 10 insertions(+), 5 deletions(-)
>
>diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2=2Edts b/arch/arm/b=
oot/dts/mt7623n-bananapi-bpi-r2=2Edts
>index dc9b4f99eb8b=2E=2E64700253fd35 100644
>--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2=2Edts
>+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2=2Edts
>@@ -182,6 +182,12 @@ fixed-link {
> 	};
> };
>=20
>+&gmac1 {
>+	status =3D "okay";
>+	phy-mode =3D "rgmii";
>+	phy-handle =3D <&ethphy0>;
>+};
>+
> &eth {
> 	status =3D "okay";
>=20
>@@ -189,6 +195,10 @@ mdio-bus {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
>+		ethphy0: ethernet-phy@0 {
>+			reg =3D <0>;
>+		};
>+
> 		switch@1f {
> 			compatible =3D "mediatek,mt7530";
> 			reg =3D <0x1f>;
>@@ -200,11 +210,6 @@ ports {
> 				#address-cells =3D <1>;
> 				#size-cells =3D <0>;
>=20
>-				port@0 {
>-					reg =3D <0>;
>-					label =3D "wan";
>-				};
>-
> 				port@1 {
> 					reg =3D <1>;
> 					label =3D "lan0";

Hi

I still see Problem with "renaming" the wan from users PoV=2E I got anothe=
r way of using second gmac for wan some time ago using vlan-aware bridge (h=
ave not tested with recent kernel versions)=2E

Maybe this works for you too? If yes imho it will be a better way=2E

https://github=2Ecom/frank-w/BPI-Router-Linux/commit/c92b648bac996b34dc75a=
4fff15d7fb429bfe74b

Have same for r64/mt7622 in my tree=2E=2E=2E

It should use eth1 for wan-traffic too but is full userspace configuration=
 without breaking userspace for users not wanting it=2E
regards Frank
