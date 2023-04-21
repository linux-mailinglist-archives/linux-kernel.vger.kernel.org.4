Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD16EAFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDUQvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjDUQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E210E15465;
        Fri, 21 Apr 2023 09:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61C05651EE;
        Fri, 21 Apr 2023 16:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331CFC433D2;
        Fri, 21 Apr 2023 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682095848;
        bh=4PKiSD8pwG5uc1Vw6yZ0oSBjtuD6XwS0DlNSSbfnKsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQ66G6XLulYion85rTrndH58L6seuTd2gccaZxnRqVC7s5BKVG9Nucg0IqbjAiiYE
         B0WzG5jIAcz+yu4cC/Xeo+HpWlT4p38/C+5iZmxhRnZitiN61hbZ90vrp4B8vPJ2vr
         hCnpO6o9y5yqZDQm7ijcMOGsiJ8OZFDN9cqWLDW1ccOxU5JndF9vyg64QN9tEjUKnm
         vAg9J+zSj1CLG3wNb25N270+W9JgA6sYjpY6lSScGFmhNhVvYoImAw70yCdvpxLS1q
         8dC2FiNCMZTb46KYFMuHd3gRwNrlpzNEQEelBPPWfklg8fbkNbb0oGYC9pezM9OErr
         CSzESswaimKfA==
Date:   Fri, 21 Apr 2023 17:50:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: add tdm node and sound card
Message-ID: <20230421-dropper-upstage-200ae7e47092@spud>
References: <20230420024118.22677-1-walker.chen@starfivetech.com>
 <20230420024118.22677-5-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="F4ErV7BKuepPeVJv"
Content-Disposition: inline
In-Reply-To: <20230420024118.22677-5-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F4ErV7BKuepPeVJv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Walker,

On Thu, Apr 20, 2023 at 10:41:18AM +0800, Walker Chen wrote:
> Add the tdm controller node and sound card for the StarFive JH7110 SoC.

Is this one of these waveshare things + a visionfive 2?
https://www.waveshare.com/wm8960-audio-hat.htm

I'm a bit lost as to why this needs a whole new board, should it not
just be an overlay that you can apply to the existing dts?

Taking this to an extreme, should I expect to see a new devicetree for
everything RPi hat that you decide to use with a VisionFive 2?

Also, it'd be nice to provide a Link: to where someone can find more
info on this combination of items. Google for "wm8960 visionfive 2"
gives me nothing, nor does "starfive audio card" etc.

Thanks,
Conor.

> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
>  .../starfive/jh7110-starfive-audio-card.dts   | 67 +++++++++++++++++++
>  .../jh7110-starfive-visionfive-2.dtsi         | 40 +++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 21 ++++++
>  4 files changed, 129 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-audio-ca=
rd.dts
>=20
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/=
starfive/Makefile
> index 170956846d49..cb22cb7f66b0 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7100-starfive-visionfi=
ve-v1.dtb
> =20
>  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.2a.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.3b.dtb
> +dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-audio-card.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-audio-card.dts =
b/arch/riscv/boot/dts/starfive/jh7110-starfive-audio-card.dts
> new file mode 100644
> index 000000000000..967d9aa7d1e1
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-audio-card.dts
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Device Tree for JH7110 + Simple Audio Card
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + */
> +
> +/dts-v1/;
> +#include "jh7110-starfive-visionfive-2-v1.3b.dts"
> +
> +/ {
> +	model =3D "StarFive VisionFive 2 Audio Board";
> +	compatible =3D "starfive,visionfive-2-audio", "starfive,jh7110";
> +
> +	wm8960_mclk: wm8960-mclk {
> +		compatible =3D "fixed-clock";
> +		clock-output-names =3D "wm8960_mclk";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <24576000>;
> +	};
> +
> +	sound {
> +		compatible =3D "simple-audio-card";
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		simple-audio-card,name =3D "Starfive-TDM-Sound-Card";
> +		simple-audio-card,widgets =3D "Microphone", "Mic Jack",
> +					    "Line", "Line In",
> +					    "Line", "Line Out",
> +					    "Speaker", "Speaker",
> +					    "Headphone", "Headphone Jack";
> +		simple-audio-card,routing =3D "Headphone Jack", "HP_L",
> +					    "Headphone Jack", "HP_R",
> +					    "Speaker", "SPK_LP",
> +					    "Speaker", "SPK_LN",
> +					    "LINPUT1", "Mic Jack",
> +					    "LINPUT3", "Mic Jack",
> +					    "RINPUT1", "Mic Jack",
> +					    "RINPUT2", "Mic Jack";
> +
> +		simple-audio-card,dai-link@0 {
> +			reg =3D <0>;
> +			format =3D "dsp_a";
> +			bitclock-master =3D <&dailink_master>;
> +			frame-master =3D <&dailink_master>;
> +
> +			cpu {
> +				sound-dai =3D <&tdm>;
> +			};
> +			dailink_master: codec {
> +				sound-dai =3D <&wm8960>;
> +				clocks =3D <&wm8960_mclk>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	wm8960: codec@1a {
> +		compatible =3D "wlf,wm8960";
> +		reg =3D <0x1a>;
> +		wlf,shared-lrclk;
> +		#sound-dai-cells =3D <0>;
> +	};
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 1155b97b593d..19b5954ee72d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -214,6 +214,40 @@
>  			slew-rate =3D <0>;
>  		};
>  	};
> +
> +	tdm0_pins: tdm0-pins {
> +		tdm0-pins-tx {
> +			pinmux =3D <GPIOMUX(44, GPOUT_SYS_TDM_TXD,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-pull-up;
> +			drive-strength =3D <2>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate =3D <0>;
> +		};
> +
> +		tdm0-pins-rx {
> +			pinmux =3D <GPIOMUX(61, GPOUT_HIGH,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_TDM_RXD)>;
> +			input-enable;
> +		};
> +
> +		tdm0-pins-sync {
> +			pinmux =3D <GPIOMUX(63, GPOUT_HIGH,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_TDM_SYNC)>;
> +			input-enable;
> +		};
> +
> +		tdm0-pins-pcmclk {
> +			pinmux =3D <GPIOMUX(38, GPOUT_HIGH,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_TDM_CLK)>;
> +			input-enable;
> +		};
> +	};
>  };
> =20
>  &uart0 {
> @@ -221,3 +255,9 @@
>  	pinctrl-0 =3D <&uart0_pins>;
>  	status =3D "okay";
>  };
> +
> +&tdm {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&tdm0_pins>;
> +	status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 866313570a7e..cfda6fb0d91b 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -366,6 +366,27 @@
>  			status =3D "disabled";
>  		};
> =20
> +		tdm: tdm@10090000 {
> +			compatible =3D "starfive,jh7110-tdm";
> +			reg =3D <0x0 0x10090000 0x0 0x1000>;
> +			clocks =3D <&syscrg JH7110_SYSCLK_TDM_AHB>,
> +				 <&syscrg JH7110_SYSCLK_TDM_APB>,
> +				 <&syscrg JH7110_SYSCLK_TDM_INTERNAL>,
> +				 <&syscrg JH7110_SYSCLK_TDM_TDM>,
> +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
> +				 <&tdm_ext>;
> +			clock-names =3D "tdm_ahb", "tdm_apb",
> +				      "tdm_internal", "tdm",
> +				      "mclk_inner", "tdm_ext";
> +			resets =3D <&syscrg JH7110_SYSRST_TDM_AHB>,
> +				 <&syscrg JH7110_SYSRST_TDM_APB>,
> +				 <&syscrg JH7110_SYSRST_TDM_CORE>;
> +			dmas =3D <&dma 20>, <&dma 21>;
> +			dma-names =3D "rx","tx";
> +			#sound-dai-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
>  		stgcrg: clock-controller@10230000 {
>  			compatible =3D "starfive,jh7110-stgcrg";
>  			reg =3D <0x0 0x10230000 0x0 0x10000>;
> --=20
> 2.17.1
>=20

--F4ErV7BKuepPeVJv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEK+4wAKCRB4tDGHoIJi
0kG0AQDuslhSfus6Zt85o7IMCS+mMyQXVs1NlLzVWZNXKs04vwEA/pHxG8wU7sZB
UakVjfxinK085SBifNYIPGOW+JKClg8=
=e/iM
-----END PGP SIGNATURE-----

--F4ErV7BKuepPeVJv--
