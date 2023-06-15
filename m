Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF17731025
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbjFOHHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244490AbjFOHG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:06:26 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D4D2962;
        Thu, 15 Jun 2023 00:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686812425; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HxGSyn8024JvxM9iE2pitobZ0wCSrDUNgSMdruJ/srxzjs6iSRKhzAkby7Y0OetjUD
    q5CxT8cuy6GcovrEL37zQPBv0oC0vxdarAFfZxH8iRG69EftQENfNCkdFCgWG0QK2Jyb
    UVi6AR1F9VQHfFjMf4aTswXNi50gej+ZYNxqLNUwzAf6VKpRqb9kPYH6Gk+/pCULWG8Y
    I7hR3UT/Rqboo9JDF9SgyjNby2cmGIZ5GEctdXwu2lqcxOfv+FZDyqZzdKpmLHApVAbX
    +pyf2Ug+M5dtVqm84fWSX3RdzTB5nxnstLdYeUf+mfE2pcbL1UjlA49fZAZC7GuK0WFP
    Gv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812425;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=nqYC2aoHjaFYIB8A5bxnY0eGOB/K80yE07iesPu9ias=;
    b=Yi8xLRKtt+UFPVaad5mNfmgx1t6PAt+3YRV7XhF5m1QKYHgHTO8YS5sP62HyE2qSLb
    Z8gRr5KK4cvCL0s5S2YYM3oL1QiA8CKpFmi1vF8EMT2NZavAyWb7LOWuRIKQ3DeARWA5
    qewaPni/Dv0kD+2fd83tqHx541h383JIRTHIGrjeWdkvP8JrfA06L2x3r3q7WtAQH0Dh
    +rR6WWn/td44d97m6LEz6YSCmPk5x/bGAO/XOwKVuqH4Y/jXiJIctULdApbooLnSvvK5
    imkEuDPp+La2MGGfN7Z2TekC4K+5JpLJ1VScSxFg+9GxEjwotW9+W0NG7k3KD1bVAATi
    XKoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812425;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=nqYC2aoHjaFYIB8A5bxnY0eGOB/K80yE07iesPu9ias=;
    b=ZzxwyVVSC5AS2Ynu5YjGX4VBIRJOZ3XCXXgR0p7ZmXiIH5WXkL4fY90z/ViR4KRCDD
    iQy7D2tfKZoLsT8KTl6Pj8qcQIUWUs2W2qV6FaDotcGoAoM6ZAAxBXfC8DVylStxlxJ7
    DSq5lwHaQKBjrocOfQFhRC59duwrcgfSBVwmVVRA5+PTr9A64QGIAmqC7PEGG8D+XxSG
    2JGfp0an3CNVItSZ28QFsngkTNbq5oTXY35Xs/d906wcwqdMMiG+CwKbS6wSBaSwqeCT
    jaC+LUkwR+7KGU6v1aC2Ot1IYBEsQlPpYhkjrI4l9TBVPfYnZx/TBhSMPXEnh1gVgBnV
    AwUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686812425;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=nqYC2aoHjaFYIB8A5bxnY0eGOB/K80yE07iesPu9ias=;
    b=yI8oiLuTQJu2pUQUvkVL7zsXdIzI0wLF7PVeglekQ17n+na5DSjkrQek3zNn01CE4l
    R5pvzE+GNH+tv2RDisBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeonQ="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5F70P23K
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 09:00:25 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 2/9] MIPS: DTS: CI20: Fix ACT8600 regulator node names
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230604145642.200577-3-paul@crapouillou.net>
Date:   Thu, 15 Jun 2023 09:00:25 +0200
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <8FC21AA8-AD08-433A-868B-78A58D9A0F9A@goldelico.com>
References: <20230604145642.200577-1-paul@crapouillou.net>
 <20230604145642.200577-3-paul@crapouillou.net>
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
> The Device Tree was using invalid node names for the ACT8600 =
regulators.
> To be fair, it is not the original committer's fault, as the
> documentation did gives invalid names as well.

s/did gives /did give /

>=20
> In theory, the fix should have been to modify the driver to accept the
> alternative names. However, even though the act8865 driver spits
> warnings, the kernel seemed to work fine with what is currently
> supported upstream. For that reason, I think it is okay to just update
> the DTS.
>=20
> I removed the "regulator-name" too, since they really didn't bring any
> information. The node names are enough.

For me this patch breaks boot on my CI20 V2a - but I don't see why.
Maybe the driver or something else relies on regulator names indirectly?

Last and only signs of activity:

U-Boot 2013.10-rc3-00096-gef995a1-dirty (Apr 13 2019 - 19:15:18)

Board: ci20 (r2) (Ingenic XBurst JZ4780 SoC)
DRAM:  1 GiB
NAND:  8192 MiB
MMC:   jz_mmc msc1: 0
*** Warning - bad CRC, using default environment

In:    eserial4
Out:   eserial4
Err:   eserial4
Net:   dm9000
Hit any key to stop autoboot:  0=20
4357173 bytes read in 724 ms (5.7 MiB/s)
## Booting kernel from Legacy Image at 88000000 ...
   Image Name:   Linux-6.4.0-rc6+
   Image Type:   MIPS Linux Kernel Image (gzip compressed)
   Data Size:    4357109 Bytes =3D 4.2 MiB
   Load Address: 80100000
   Entry Point:  80718080
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

[    0.070854] jz4780-nemc 13410000.nemc: /nemc@13410000/efuse@d0 =
requests invalid bank 0
[    0.078858] jz4780-nemc 13410000.nemc: /nemc@13410000/efuse@d0 has no =
addresses
[    0.109013] jz4740-rtc 10003000.rtc: hctosys: unable to read the =
hardware clock
[    0.199104] dm9000 16000000.dm9000: read wrong id 0x00000a46

--- hangs ---

>=20
> Fixes: 73f2b940474d ("MIPS: CI20: DTS: Add I2C nodes")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> arch/mips/boot/dts/ingenic/ci20.dts | 27 ++++++++-------------------
> 1 file changed, 8 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts =
b/arch/mips/boot/dts/ingenic/ci20.dts
> index e76953dce2e7..5361606c5e13 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -237,59 +237,49 @@ &i2c0 {
> 	act8600: act8600@5a {
> 		compatible =3D "active-semi,act8600";
> 		reg =3D <0x5a>;
> -		status =3D "okay";
>=20
> 		regulators {
> -			vddcore: SUDCDC1 {
> -				regulator-name =3D "DCDC_REG1";
> +			vddcore: DCDC1 {
> 				regulator-min-microvolt =3D <1100000>;
> 				regulator-max-microvolt =3D <1100000>;
> 				regulator-always-on;
> 			};
> -			vddmem: SUDCDC2 {
> -				regulator-name =3D "DCDC_REG2";
> +			vddmem: DCDC2 {
> 				regulator-min-microvolt =3D <1500000>;
> 				regulator-max-microvolt =3D <1500000>;
> 				regulator-always-on;
> 			};
> -			vcc_33: SUDCDC3 {
> -				regulator-name =3D "DCDC_REG3";
> +			vcc_33: DCDC3 {
> 				regulator-min-microvolt =3D <3300000>;
> 				regulator-max-microvolt =3D <3300000>;
> 				regulator-always-on;
> 			};
> -			vcc_50: SUDCDC4 {
> -				regulator-name =3D "SUDCDC_REG4";
> +			vcc_50: SUDCDC_REG4 {
> 				regulator-min-microvolt =3D <5000000>;
> 				regulator-max-microvolt =3D <5000000>;
> 				regulator-always-on;
> 			};
> -			vcc_25: LDO_REG5 {
> -				regulator-name =3D "LDO_REG5";
> +			vcc_25: LDO5 {
> 				regulator-min-microvolt =3D <2500000>;
> 				regulator-max-microvolt =3D <2500000>;
> 				regulator-always-on;
> 			};
> -			wifi_io: LDO_REG6 {
> -				regulator-name =3D "LDO_REG6";
> +			wifi_io: LDO6 {
> 				regulator-min-microvolt =3D <2500000>;
> 				regulator-max-microvolt =3D <2500000>;
> 				regulator-always-on;
> 			};
> -			vcc_28: LDO_REG7 {
> -				regulator-name =3D "LDO_REG7";
> +			cim_io_28: LDO7 {
> 				regulator-min-microvolt =3D <2800000>;
> 				regulator-max-microvolt =3D <2800000>;
> 				regulator-always-on;
> 			};
> -			vcc_15: LDO_REG8 {
> -				regulator-name =3D "LDO_REG8";
> +			cim_io_15: LDO8 {
> 				regulator-min-microvolt =3D <1500000>;
> 				regulator-max-microvolt =3D <1500000>;
> 				regulator-always-on;
> 			};
> 			vrtc_18: LDO_REG9 {
> -				regulator-name =3D "LDO_REG9";
> 				/* Despite the datasheet stating 3.3V
> 				 * for REG9 and the driver expecting =
that,
> 				 * REG9 outputs 1.8V.
> @@ -303,7 +293,6 @@ vrtc_18: LDO_REG9 {
> 				regulator-always-on;
> 			};
> 			vcc_11: LDO_REG10 {
> -				regulator-name =3D "LDO_REG10";
> 				regulator-min-microvolt =3D <1200000>;
> 				regulator-max-microvolt =3D <1200000>;
> 				regulator-always-on;
> --=20
> 2.39.2
>=20

