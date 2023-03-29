Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F1A6CD3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjC2IEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjC2IEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:04:35 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3123040CF;
        Wed, 29 Mar 2023 01:04:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32T84LCN066906;
        Wed, 29 Mar 2023 03:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680077061;
        bh=CKF/L9tscayI5JpJptLNCE1LfLUy3gGKS1hSJp9uQTA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xnmZJVSP5FsoxjxlYkCDkAWgRP4UFFZHFbHRbuwcaq9n43N4dzk/oa3s/Ucbqcnoq
         h0X8gTfJtsZRieB+NEUmcwo6t79nK2Ce4bk8URqu54gLZR99/kGjGbOp5x2kIfbCyg
         s6C9dpr3rh6YX2CwoADz9we7oKAMH4c03TvHwAlQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32T84Lsi089656
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 03:04:21 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 03:04:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 03:04:21 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32T84K1j015948;
        Wed, 29 Mar 2023 03:04:21 -0500
Date:   Wed, 29 Mar 2023 13:34:21 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
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
Message-ID: <d7j5kcfufwebqs2dvjx37yxyptpx74fdnsvxfpczznfvnaiqeh@dxurdqxpanjx>
References: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
 <20230313-mcasp_upstream-v8-3-4408134eb2f3@ti.com>
 <20230328133225.edi4eynptt5e4oul@headset>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p5vaf5h5yzeew3b3"
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

--p5vaf5h5yzeew3b3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

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

Sorry, please disregard this patch, I went over the schematics again and=20
found that I made a mistake here.

On SK-AM62-LP the audio codec gets the 1.8V from PMIC and not from a=20
dedicated on-board regulator. On SK-AM62 we do have a dedicated on-board=20
regulator for that.

Will fix this in next version.

Thanks,
Jai

>=20
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

--p5vaf5h5yzeew3b3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmQj8QIACgkQQ96R+SSa
cUWOxRAAu81bwSHvwZBh0XyuQOd8HKA2OEIiVqqHiPC75FOibDvdbckuLRmd7zxa
RRjh2Ke4s9/efJHL2RVGWYCwlRAAAW+Rg1o1w/Hwc3yMYBrb+ZSHvIkfwLgLySYq
+Txv60UQ7notwdgm2NGxxR2nmXXA7X/4MW7VozhObgJXvYpim6kbl0mK4ujbl/DX
ALCcMTKsx5ZeNVtmyVSAS7idqY0HRHRgNBIOCKqQha4oyRK00klavxBLp4ivS4UW
udwVMBcLeU6HdrFVqlEVcUu3jns232ian4NxkW5PMXotTdkMb0GqMq/pJJw5PGm5
UTvkXmVNuAhdzg4a5En7URm26jYf5n8d4eaDeLez8ioOAJQNKRUftHxvJM2nEoNr
EUsVBAtSVuuvEIF+NlpgQz7u/pQWXvC5hNkw+bVGcVhsIWLbLZRshAwU9WRVrQyd
lhzKSxAjXToS+AzVpC2QPg+5Jm2K6GKwB2i2fnW6k5CpUGx/eWWRxv4JqgAjmZwB
pG3LxtMfOTj2XAD6iC8wQ/mleqUmq9UjtWLGs3MXE2dUGi0fR6qMEDgLZoes4s5/
u5j0ri9pjrQaPE/51Qv4DFbk3pYt+EbcKWfyogkmJr956yBbR/x0t47iCdxh9H2o
a0w8i5DwlXF9ya6v8QDRvmXZFvEpGglaqM0clNDLrQ0vEAV6CnM=
=Dim+
-----END PGP SIGNATURE-----

--p5vaf5h5yzeew3b3--
