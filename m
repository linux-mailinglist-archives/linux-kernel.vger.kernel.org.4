Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81A06BA7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCOG3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCOG3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:29:22 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BBA60AB8;
        Tue, 14 Mar 2023 23:29:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F6T8IA095166;
        Wed, 15 Mar 2023 01:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678861748;
        bh=yxe3ti58WqVJaW+zMRXIOiM5AQ3EUbOUVooNJTq4Xwk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Q5ouiBQFKJ7v5ShqZ7oarf6xIhVHn+fKqs02bEFxtvHelMkO1cqn+tHgkXJjRQ//p
         qgKq9pRn8SV+mO9G+UZidGi8kviouLVA0U0J2qQeLOh/YIZWg4jggRDpD6Ysu1oFI8
         S0fGGUi47K9O+UeTP9oQKDWbhMFALSEhYEB11//Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F6T8Z5129435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 01:29:08 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 01:29:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 01:29:08 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F6T7AC046378;
        Wed, 15 Mar 2023 01:29:08 -0500
Date:   Wed, 15 Mar 2023 11:59:08 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] arm64: dts: ti: k3-am62a7-sk: Enable audio on
 AM62A
Message-ID: <20230315062908.gms3h3llook4z2tg@uda0497096>
References: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
 <20230313-mcasp_upstream-v5-6-d6844707aa8a@ti.com>
 <dbc03a80-a1d2-1458-a0b8-f3038db3caf3@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tqcxlnxpd74hcokz"
Content-Disposition: inline
In-Reply-To: <dbc03a80-a1d2-1458-a0b8-f3038db3caf3@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--tqcxlnxpd74hcokz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jayesh,

Thanks for the comments on the series.

On Mar 15, 2023 at 10:02:24 +0530, Jayesh Choudhary wrote:
>=20
>=20
> On 13/03/23 20:19, Jai Luthra wrote:
> > Add nodes for audio codec and sound card, enable the audio serializer
> > (McASP1) under use and update pinmux.
> >=20
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 77 ++++++++++++++++++++++++=
+++++++++
> >   1 file changed, 77 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/=
dts/ti/k3-am62a7-sk.dts
> > index 063e69e45163..1775ed154aff 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > @@ -122,6 +122,41 @@ led-0 {
> >   			default-state =3D "off";
> >   		};
> >   	};
> > +
> > +	tlv320_mclk: clk-0 {
> > +		#clock-cells =3D <0>;
> > +		compatible =3D "fixed-clock";
> > +		clock-frequency =3D <12288000>;
> > +	};
> > +
> > +	codec_audio: sound {
> > +		compatible =3D "simple-audio-card";
> > +		simple-audio-card,name =3D "AM62Ax-SKEVM";
> > +		simple-audio-card,widgets =3D
> > +			"Headphone",	"Headphone Jack",
> > +			"Line",	"Line In",
> > +			"Microphone",	"Microphone Jack";
> > +		simple-audio-card,routing =3D
> > +			"Headphone Jack",	"HPLOUT",
> > +			"Headphone Jack",	"HPROUT",
> > +			"LINE1L",		"Line In",
> > +			"LINE1R",		"Line In",
> > +			"MIC3R",		"Microphone Jack",
> > +			"Microphone Jack",	"Mic Bias";
> > +		simple-audio-card,format =3D "dsp_b";
> > +		simple-audio-card,bitclock-master =3D <&sound_master>;
> > +		simple-audio-card,frame-master =3D <&sound_master>;
> > +		simple-audio-card,bitclock-inversion;
> > +
> > +		simple-audio-card,cpu {
> > +			sound-dai =3D <&mcasp1>;
> > +		};
> > +
> > +		sound_master: simple-audio-card,codec {
> > +			sound-dai =3D <&tlv320aic3106>;
> > +			clocks =3D <&tlv320_mclk>;
> > +		};
> > +	};
> >   };
> >   &main_pmx0 {
> > @@ -200,6 +235,15 @@ AM62AX_IOPAD(0x130, PIN_INPUT, 0) /* (AB17) RGMII1=
_TXC */
> >   			AM62AX_IOPAD(0x12c, PIN_INPUT, 0) /* (W16) RGMII1_TX_CTL */
> >   		>;
> >   	};
> > +
> > +	main_mcasp1_pins_default: main-mcasp1-pins-default {
> > +		pinctrl-single,pins =3D <
> > +			AM62AX_IOPAD(0x090, PIN_INPUT, 2) /* (L19) GPMC0_BE0n_CLE.MCASP1_AC=
LKX */
> > +			AM62AX_IOPAD(0x098, PIN_INPUT, 2) /* (R18) GPMC0_WAIT0.MCASP1_AFSX =
*/
> > +			AM62AX_IOPAD(0x08c, PIN_OUTPUT, 2) /* (K19) GPMC0_WEn.MCASP1_AXR0 */
> > +			AM62AX_IOPAD(0x084, PIN_INPUT, 2) /* (L18) GPMC0_ADVn_ALE.MCASP1_AX=
R2 */
> > +		>;
> > +	};
> >   };
> >   &main_i2c0 {
> > @@ -234,6 +278,19 @@ exp1: gpio@22 {
> >   				   "MCASP1_FET_SEL", "UART1_FET_SEL",
> >   				   "PD_I2C_IRQ", "IO_EXP_TEST_LED";
> >   	};
> > +
> > +	tlv320aic3106: audio-codec@1b {
> > +		#sound-dai-cells =3D <0>;
> > +		compatible =3D "ti,tlv320aic3106";
> > +		reg =3D <0x1b>;
> > +		ai3x-micbias-vg =3D <1>;		/* 2.0V */
> > +		status =3D "okay";
>=20
> No need for status property here I guess????

Will fix.

>=20
> > +
> > +		/* Regulators */
> > +		AVDD-supply =3D <&vcc_3v3_sys>;
> > +		IOVDD-supply =3D <&vcc_3v3_sys>;
> > +		DRVDD-supply =3D <&vcc_3v3_sys>;
>=20
> DVDD 1.8V supply here looks missing???

Sorry I missed to add a note in the commit message, will add in v6.

DVDD 1.8V is supplied by the PMIC (TPS6593x-Q1) on the SK, the driver=20
and dt-bindings for it are still being worked on:
https://lore.kernel.org/all/20230216114410.183489-1-jpanis@baylibre.com/

The codec can be enabled without it for now, as it only uses the=20
regulators to calculate the OCMV, which I will supply manually to the=20
codec through DT in v6.

>=20
> Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
>=20
> > +	};
> >   };
> >   &sdhci1 {
> > @@ -302,3 +359,23 @@ cpsw3g_phy0: ethernet-phy@0 {
> >   		ti,min-output-impedance;
> >   	};
> >   };
> > +
> > +&mcasp1 {
> > +	status =3D "okay";
> > +	#sound-dai-cells =3D <0>;
> > +
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&main_mcasp1_pins_default>;
> > +
> > +	op-mode =3D <0>;          /* MCASP_IIS_MODE */
> > +	tdm-slots =3D <2>;
> > +
> > +	serial-dir =3D <  /* 0: INACTIVE, 1: TX, 2: RX */
> > +	       1 0 2 0
> > +	       0 0 0 0
> > +	       0 0 0 0
> > +	       0 0 0 0
> > +	>;
> > +	tx-num-evt =3D <32>;
> > +	rx-num-evt =3D <32>;
> > +};
> >=20

--tqcxlnxpd74hcokz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmQRZbMACgkQQ96R+SSa
cUWZPw//etXu0RmsV61gujO5HWKf+EuQB6BceQjGvnKUfMXLI5rgja/rAv1/eCzU
+nWnmDB28lnjzceiVajdpujzDU+Mu7TsHv/ZAcFou934VjKCZa73pVESzdPUCudq
80jFNty52TZqnPVunzX/QOTODA3WeIJ1K5Jub9VzQZuhiytvhDGdxr8DhSjY3gpd
jdBjQmJxFnAtieSQzvJBoMFrO84R3YXTcH/wi8qK04dAt6H24hu5XO/KPVxLBTFL
6WuSmzSrxPr8F1IyaBwkFIwUaHQFfCi2T0ITmAUacpxhfAWHPC0o6THg5B9JnGS6
wrNvHfWs5i6k07YPbg2EpgQcrJXbGtoR43l5dsReUSXhd2IBEorxGGgiN+yf3XKs
+zXSYoemgl9SkPXstZXgwE/EMkbh2YJe3pAodCQN+k150fuRkZ9NBxeBlKEDxfBH
843/Uf29Y9wl6NAiiBBgMULF29prgxaLoUXlkUyAEx0uxk6VZTbSUq0D7UuutIB9
iSXZRMTis1Ba6OaMShcJBbBU92jJpdY1luBIiXeXv9+o2TBZTfb94QK7qFveU5Xu
SxUYDfVruR1xCoq2G4bDCFJlnRWOH8NVEYGMmEYySlA3EUMHUwSDhZf28EdF+75H
8tZ9xsovKMmXRKl2KAhwaqTQhHYPxIlUlWlCgK5RcIT8tigRBvc=
=7wdq
-----END PGP SIGNATURE-----

--tqcxlnxpd74hcokz--
