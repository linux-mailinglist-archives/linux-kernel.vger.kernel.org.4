Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7516CC166
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjC1Nvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjC1Nvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:51:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2E21A5;
        Tue, 28 Mar 2023 06:51:50 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SDpflv045366;
        Tue, 28 Mar 2023 08:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680011501;
        bh=6hAV4inCrrJCYNeuaSEf119wT6c2CersccstDiIV3b8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=p0V0Bdbq0amoH/D5D1JsUyitRiihYcXYLzrs2A8ddEOMwOFjhBZZUlvSPPT/ExNJ2
         q6ME89g9EQtT3yzU32oCtCx9/bxiF4GTwNNq5rOATTu1AnQtKOx9ISeU1pGuDCrr0u
         TYN+0UIcFMkl0q/13VhzIKObwQbBVi5eEZg5LLqw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SDpfvR099789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 08:51:41 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 08:51:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 08:51:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SDpe4H018730;
        Tue, 28 Mar 2023 08:51:40 -0500
Date:   Tue, 28 Mar 2023 19:21:40 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v8 3/6] arm64: dts: ti: k3-am625-sk: Enable audio on AM62
 SK
Message-ID: <7qaud2s3xise6fttg4sgh57tokssxhc4wjxppi3ejofi7yjmy7@i2j24ycqxspr>
References: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
 <20230313-mcasp_upstream-v8-3-4408134eb2f3@ti.com>
 <20230328133225.edi4eynptt5e4oul@headset>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uyz5qo2zrbmtre75"
Content-Disposition: inline
In-Reply-To: <20230328133225.edi4eynptt5e4oul@headset>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--uyz5qo2zrbmtre75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nishanth,

On Mar 28, 2023 at 08:32:25 -0500, Nishanth Menon wrote:
> On 18:59-20230328, Jai Luthra wrote:
> > Add nodes for audio codec and sound card, enable the audio serializer
> > (McASP1) under use from SK-AM62 E2 [1] onwards and update pinmux.
> >=20
> > Keep all audio related nodes in the common dtsi as they are exactly the
> > same between SK-AM62 and SK-AM62-LP.
> >=20
> > Link: https://www.ti.com/lit/zip/sprr448 [1]
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts       | 11 ++++
> >  arch/arm64/boot/dts/ti/k3-am625-sk.dts         | 11 ++++
> >  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 77 ++++++++++++++++++=
++++++++
> >  3 files changed, 99 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot=
/dts/ti/k3-am62-lp-sk.dts
> > index b2ca19e3042e..5ed6b1abe87d 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> > @@ -70,6 +70,17 @@ vddshv_sdio: regulator-4 {
> >  		states =3D <1800000 0x0>,
> >  			 <3300000 0x1>;
> >  	};
> > +
> > +	vcc_1v8: regulator-5 {
> > +		/* output of TPS62824DMQ */
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "vcc_1v8";
> > +		regulator-min-microvolt =3D <1800000>;
> > +		regulator-max-microvolt =3D <1800000>;
> > +		vin-supply =3D <&vcc_3v3_sys>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +	};
> >  };
> > =20
> >  &main_pmx0 {
> > diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/d=
ts/ti/k3-am625-sk.dts
> > index cdc0858dd1b2..2b861681e548 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> > @@ -87,6 +87,17 @@ vdd_sd_dv: regulator-4 {
> >  		states =3D <1800000 0x0>,
> >  			 <3300000 0x1>;
> >  	};
> > +
> > +	vcc_1v8: regulator-5 {
> > +		/* output of TPS6282518DMQ */
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "vcc_1v8";
> > +		regulator-min-microvolt =3D <1800000>;
> > +		regulator-max-microvolt =3D <1800000>;
> > +		vin-supply =3D <&vcc_3v3_sys>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +	};
> >  };
>=20
> If the regulators are common, maybe we should first move the regulators
> to common dtsi?
>=20

The part number of this particular regulator is different in the=20
schematics for the two boards.

For rest of the regulators I did not check, but I see the PMIC=20
(TPS65219x) is present on SK-AM62-LP but missing on SK-AM62.

Thanks,
Jai

> > =20
> >  &main_pmx0 {
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm6=
4/boot/dts/ti/k3-am62x-sk-common.dtsi
> > index 54318a07d50c..2500cb9ba323 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> > @@ -81,6 +81,41 @@ led-0 {
> >  			default-state =3D "off";
> >  		};
> >  	};
> > +
> > +	tlv320_mclk: clk-0 {
> > +		#clock-cells =3D <0>;
> > +		compatible =3D "fixed-clock";
> > +		clock-frequency =3D <12288000>;
> > +	};
> > +
> > +	codec_audio: sound {
> > +		compatible =3D "simple-audio-card";
> > +		simple-audio-card,name =3D "AM62x-SKEVM";
> > +		simple-audio-card,widgets =3D
> > +			"Headphone",	"Headphone Jack",
> > +			"Line",		"Line In",
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
> >  };
> > =20
> >  &main_pmx0 {
> > @@ -175,6 +210,15 @@ main_usb1_pins_default: main-usb1-pins-default {
> >  			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18/E16) USB1_DRVVBUS */
> >  		>;
> >  	};
> > +
> > +	main_mcasp1_pins_default: main-mcasp1-pins-default {
> > +		pinctrl-single,pins =3D <
> > +			AM62X_IOPAD(0x090, PIN_INPUT, 2) /* (M24) GPMC0_BE0N_CLE.MCASP1_ACL=
KX */
> > +			AM62X_IOPAD(0x098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
> > +			AM62X_IOPAD(0x08c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEN.MCASP1_AXR0 */
> > +			AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR=
2 */
> > +		>;
> > +	};
> >  };
> > =20
> >  &wkup_uart0 {
> > @@ -205,6 +249,19 @@ &main_i2c1 {
> >  	pinctrl-names =3D "default";
> >  	pinctrl-0 =3D <&main_i2c1_pins_default>;
> >  	clock-frequency =3D <400000>;
> > +
> > +	tlv320aic3106: audio-codec@1b {
> > +		#sound-dai-cells =3D <0>;
> > +		compatible =3D "ti,tlv320aic3106";
> > +		reg =3D <0x1b>;
> > +		ai3x-micbias-vg =3D <1>;	/* 2.0V */
> > +
> > +		/* Regulators */
> > +		AVDD-supply =3D <&vcc_3v3_sys>;
> > +		IOVDD-supply =3D <&vcc_3v3_sys>;
> > +		DRVDD-supply =3D <&vcc_3v3_sys>;
> > +		DVDD-supply =3D <&vcc_1v8>;
> > +	};
> >  };
> > =20
> >  &sdhci0 {
> > @@ -272,3 +329,23 @@ &usb1 {
> >  	pinctrl-names =3D "default";
> >  	pinctrl-0 =3D <&main_usb1_pins_default>;
> >  };
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
> > --=20
> > 2.40.0
> >=20
>=20
> --=20
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D

--uyz5qo2zrbmtre75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmQi8OwACgkQQ96R+SSa
cUUjdhAAjTb9vMWlMkd2Jw/ifSibvvWccEAxgqPTLjbDXKrCmuDxkzJvLLvC2YhO
SfMJLEI5ZuqmsRR8NobxELz+r5EF5lrH0FKO0TXPC2zOHUxzRMBxVbIxYq6xhp3J
yeOl6+5Jv0zQDxtsfb8XwgNkK7iZkkwXBluHBD76Ka+hiXrH8LPmSNN9n7SEMH50
qCKBk46iU0DGGNFMaNSgVZOXY+pkBbzlZ5E96eg8IFJBIDGglR6p8Ie56ddsJkBT
eO14UcKxzPGlPI0b3/ZLxgzYmB0bnk/1MIzKoZ650sqS5uz6ZmrO4ICIOkMl5CIV
QqgWAJpBYdwuudCd1IXDiOrOclg6Qbr7Mh0HAasxnKMTyLRblHt61vV6wCJ/HI5S
jQYSP3ub9llGuHAipKlTtLwfrg1TtTPRfiED8WnEpPthgIrxTB1Sd/PHb03bHhe/
oeHmRM0YaLnCaz5BDlLexiHNmh3ncNV/LpOyLBTwraJmdO/HKVNa+AW+oWiSBWc1
7co5eep307gTpEAOqFDw1QB29rYYAgbj9GGnQS9gOnEyzpbBmmj48j3pBBrZVjSc
NkBTWXDl1h7xMqLnPZAMyR5koGKSrO0/7jotG5BVSRzm8ZWUnGPjkeTWUBR4buez
NTxCRmqpfM9HARwBm8rG29rd4ENKE9mpSoGZlgth/jYt1OebRWA=
=UjbL
-----END PGP SIGNATURE-----

--uyz5qo2zrbmtre75--
