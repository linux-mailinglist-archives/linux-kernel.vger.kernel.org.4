Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4FF73100A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbjFOHBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244415AbjFOHB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:01:29 -0400
X-Greylist: delayed 72 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 00:01:27 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D44E69;
        Thu, 15 Jun 2023 00:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686812484; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Vb8J5hlpBpDscIpZvCg4fL5GPQw0Jyrxhg14slnomTWlIc3o0MkYNnPFi4//7BLF/U
    Z87v+Z/xFtz1JOad3BNjoWKAf3hQm+L2xesOn+eSqObdSlF36OyeSVC4xa+fQe4F5oik
    oSyBqasUqr04O80qhGV9r4gbtdYHKaWsnMH5HwUI3jS4Kb/zc+nuk6WNIC+9X+WtVCSB
    24661gIQO1TIoSP/qUl2Ef5jPBnxDdyESalX5NrOzCa7yIy+V8QwCKV96sQFXbWzu0oA
    HGpSvMwJyBZTHGt0qf7Zh6Mia3WyhCLh1CE+Yt/Uw7uNTN1fVMv/KvXx/YcRPU2fyoha
    ZqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812484;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=oqU6vtEUqUneCaoXlYhx1C1KT91EWd18pV4a4GHvvcA=;
    b=CTtNwddp5loY/hLr+MJV+VEOS0YgFg49FuuIcFaw50jKQGhBeVIUzj7fRG+J8NBrCA
    QnbNtqPeo4m+DjDbvZvVlpVzG4fxVHJpKNpg5l9eiTHeEvkdgl9sbwu3bOmVH2Fm/I5D
    +kfSEuivU4Q2MlbK5U5cz0pmxh1Q3XEHxNF+NsEprjV72lGZBR2mHXelL9Tfadn19vC1
    AZdhyQqpTMnnJRyAuJh9GRUbnFoe7t81QIwa6MpbtJQVZhlBgJWzb7W8FgqR/kTgKm3T
    WHPKQ/XX3x9b7/Xbm1E6qBkJRPFbfA1Oe1iMKRuQvVMZU9XlbXjk7aE/7S9mywChVFR0
    UMiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812484;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=oqU6vtEUqUneCaoXlYhx1C1KT91EWd18pV4a4GHvvcA=;
    b=NV/Jsex/nrPXZNb8IVjgwHQVO3+srUudwRsrfUBsVUZVvk+mFLwS5H8KSWsLyonsJ6
    wr3C6V/z5cMIK79jVHwCPQ/s1ztjDHZuizz+pn0UTCMmYDq18cev1OjEpphrwDMZc/Tb
    fnUG2vqOLhV+4mwBjSdKh5/4DUjlqo65tSO8x5hR0CSfKWhPv7g61wGIBuJKSj2iflew
    yRH4CRTWKkMR4tFu9+mPCB6W0/m8W6x0fFOj3503p2gSEfwPM5OtaaDg30XuSRZFW7dq
    yZpmmKhrI/3KZmH5R3hehPjSwa5ndoFCqsu3D8vGKiY8MRenhKN3x5Kg7yj422OhHSIW
    +yDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686812484;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=oqU6vtEUqUneCaoXlYhx1C1KT91EWd18pV4a4GHvvcA=;
    b=QNzWB98CX3cvsRij7QRdmJvBW3fbWxnEeWk5UTVcdpGIaYc/VWSkTnm2V0AsSHdpd7
    fezuBSQDOHbZYLspxuCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeonQ="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5F71O23n
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 09:01:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 7/9] MIPS: DTS: CI20: Enable support for WiFi / Bluetooth
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230604145642.200577-8-paul@crapouillou.net>
Date:   Thu, 15 Jun 2023 09:01:23 +0200
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <0855AAAC-72E8-4A2D-8B30-C00986915AAB@goldelico.com>
References: <20230604145642.200577-1-paul@crapouillou.net>
 <20230604145642.200577-8-paul@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 04.06.2023 um 16:56 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Wire the WiFi/Bluetooth chip properly in the Device Tree.
>=20
> - Provide it with the correct regulators and clocks;
> - Change the MMC I/O bus to 1.8V which seems to be enough;
> - Change the MMC I/O bus frequency to 25 MHz as 50 MHz causes errors;
> - Fix the Bluetooth powerdown GPIO being inverted and add reset GPIO;
> - Convert host-wakeup-gpios to IRQ.
>=20
> With these changes, the WiFi works properly with the latest firmware
> provided by linux-firmware. The Bluetooth does not work very well =
here,
> as I cannot get my wireless keyboard to pair; but it does detect it, =
and
> it does see the key presses when I type the pairing code.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> arch/mips/boot/dts/ingenic/ci20.dts | 88 ++++++++++++++++++++++++-----
> 1 file changed, 73 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts =
b/arch/mips/boot/dts/ingenic/ci20.dts
> index bdbd064c90e1..cec0caa2350c 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -97,10 +97,15 @@ ir: ir {
> 		gpios =3D <&gpe 3 GPIO_ACTIVE_LOW>;
> 	};
>=20
> -	wlan0_power: fixedregulator-1 {
> +	bt_power: fixedregulator-1 {
> 		compatible =3D "regulator-fixed";
>=20
> -		regulator-name =3D "wlan0_power";
> +		regulator-name =3D "bt_power";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-settling-time-us =3D <1400>;
> +
> +		vin-supply =3D <&vcc_50>;
>=20
> 		gpio =3D <&gpb 19 0>;
> 		enable-active-high;
> @@ -116,6 +121,40 @@ otg_power: fixedregulator-2 {
> 		gpio =3D <&gpf 15 0>;
> 		enable-active-high;
> 	};
> +
> +	wifi_power: fixedregulator-4 {
> +		compatible =3D "regulator-fixed";
> +
> +		regulator-name =3D "wifi_power";
> +
> +		/*
> +		 * Technically it's 5V, the WiFi chip has its own =
internal
> +		 * regulators; but the MMC/SD subsystem won't accept =
such a
> +		 * value.
> +		 */
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-settling-time-us =3D <150000>;
> +
> +		vin-supply =3D <&bt_power>;
> +	};
> +
> +	vcc_33v: fixedregulator-5 {

why is this defined here? It is used earlier in [3/9] and not directly =
related to WiFi / Bluetooth

So please move into [3/9] or even before [3/9] as a separate patch.

> +		compatible =3D "regulator-fixed";
> +
> +		regulator-name =3D "vcc_33v";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	wifi_pwrseq: pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		reset-gpios =3D <&gpf 7 GPIO_ACTIVE_LOW>;
> +
> +		clocks =3D <&rtc_dev>;
> +		clock-names =3D "ext_clock";
> +	};
> };
>=20
> &ext {
> @@ -161,24 +200,33 @@ &mmc0 {
> 	pinctrl-0 =3D <&pins_mmc0>;
>=20
> 	cd-gpios =3D <&gpf 20 GPIO_ACTIVE_LOW>;
> +	vmmc-supply =3D <&vcc_33v>;
> +	vqmmc-supply =3D <&vcc_33v>;
> };
>=20
> &mmc1 {
> 	status =3D "okay";
>=20
> 	bus-width =3D <4>;
> -	max-frequency =3D <50000000>;
> +	max-frequency =3D <25000000>;
> +	mmc-pwrseq =3D <&wifi_pwrseq>;
> +	vmmc-supply =3D <&wifi_power>;
> +	vqmmc-supply =3D <&wifi_io>;
> 	non-removable;
>=20
> 	pinctrl-names =3D "default";
> 	pinctrl-0 =3D <&pins_mmc1>;
>=20
> -	brcmf: wifi@1 {
> -/*		reg =3D <4>;*/
> -		compatible =3D "brcm,bcm4330-fmac";
> -		vcc-supply =3D <&wlan0_power>;
> -		device-wakeup-gpios =3D <&gpd 9 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios =3D <&gpf 7 GPIO_ACTIVE_LOW>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	wifi@1 {
> +		compatible =3D "brcm,bcm4329-fmac";
> +		reg =3D <1>;
> +
> +		interrupt-parent =3D <&gpd>;
> +		interrupts =3D <9 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-names =3D "host-wake";
> 	};
> };
>=20
> @@ -205,11 +253,20 @@ &uart2 {
>=20
> 	bluetooth {
> 		compatible =3D "brcm,bcm4330-bt";
> -		reset-gpios =3D <&gpf 8 GPIO_ACTIVE_HIGH>;
> -		vcc-supply =3D <&wlan0_power>;
> +
> +		vbat-supply =3D <&bt_power>;
> +		vddio-supply =3D <&wifi_io>;
> +
> +		interrupt-parent =3D <&gpf>;
> +		interrupts =3D <6 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names =3D "host-wakeup";
> +
> +		clocks =3D <&rtc_dev>;
> +		clock-names =3D "lpo";
> +
> +		reset-gpios =3D <&gpf 8 GPIO_ACTIVE_LOW>;
> 		device-wakeup-gpios =3D <&gpf 5 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios =3D <&gpf 6 GPIO_ACTIVE_HIGH>;
> -		shutdown-gpios =3D <&gpf 4 GPIO_ACTIVE_LOW>;
> +		shutdown-gpios =3D <&gpf 4 GPIO_ACTIVE_HIGH>;
> 	};
> };
>=20
> @@ -270,8 +327,9 @@ vcc_25: LDO5 {
> 				regulator-always-on;
> 			};
> 			wifi_io: LDO6 {
> -				regulator-min-microvolt =3D <2500000>;
> -				regulator-max-microvolt =3D <2500000>;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-settling-time-us =3D <150000>;
> 				inl-supply =3D <&vcc_33v>;
> 			};
> 			cim_io_28: LDO7 {
> --=20
> 2.39.2
>=20

