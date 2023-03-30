Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A904B6CFD84
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjC3H6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC3H61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:58:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F41D10A;
        Thu, 30 Mar 2023 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680163106; x=1711699106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A06o++GEZF1cEl6Qfofe3vUwyO2hA9xPd0Uh8TRXZRI=;
  b=2ns5yjDBXih4YtRAqmIczfMIXCEPZXehGtpQQ07i758R5eEiWJS6eWhv
   KTB9XLQyqYB1R/+c9TJVhW7rj5TG3wlBop/wG7o6/0/KTdCLtfT6ya/oq
   b472lfRt/aqrBOUkXEhX4k791avDi5Uv3U30mDAMN8HIQRzjpFoRjc9rJ
   5fExxBoKevyiZlsTCXMsY9wovr/h20EhAH8OCacun5YveYR5RD1qUVhOh
   oZjpNt4ZSCPY4DASb/ORuKYCquiTcB7zAoVcU1MyE0h1Yfah7MWGd23rn
   23hoHpY/3Z/RD1BlHEJuXjn2HqimDwoqi6A985ua7NDNtgRwvken9R+73
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="asc'?scan'208";a="218651809"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2023 00:58:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 00:58:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 30 Mar 2023 00:58:23 -0700
Date:   Thu, 30 Mar 2023 08:58:09 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <walker.chen@starfivetech.com>
CC:     Walker Chen <walker.chen@starfivetech.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: add tdm node and sound card
Message-ID: <af015701-f1ff-4b1e-9b1b-c635fc684ce6@spud>
References: <20230329153320.31390-1-walker.chen@starfivetech.com>
 <20230329153320.31390-4-walker.chen@starfivetech.com>
 <d455a90a-7e63-2254-75cb-70cb26ae7483@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QNdQWFvvxmlEs8o1"
Content-Disposition: inline
In-Reply-To: <d455a90a-7e63-2254-75cb-70cb26ae7483@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--QNdQWFvvxmlEs8o1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 09:43:10AM +0200, Krzysztof Kozlowski wrote:
> On 29/03/2023 17:33, Walker Chen wrote:
> > Add the tdm controller node and sound card for the StarFive JH7110 SoC.

> > +		compatible =3D "fixed-clock";
> > +		clock-output-names =3D "wm8960_mclk";
> > +		#clock-cells =3D <0>;
> > +	};
> > +
> >  	i2srx_bclk_ext: i2srx-bclk-ext-clock {
> >  		compatible =3D "fixed-clock";
> >  		clock-output-names =3D "i2srx_bclk_ext";
> > @@ -375,6 +381,27 @@
> >  			status =3D "disabled";
> >  		};
> > =20
> > +		tdm: tdm@10090000 {
> > +			compatible =3D "starfive,jh7110-tdm";
> > +			reg =3D <0x0 0x10090000 0x0 0x1000>;
> > +			clocks =3D <&syscrg JH7110_SYSCLK_TDM_AHB>,
> > +				 <&syscrg JH7110_SYSCLK_TDM_APB>,
> > +				 <&syscrg JH7110_SYSCLK_TDM_INTERNAL>,
> > +				 <&syscrg JH7110_SYSCLK_TDM_TDM>,
> > +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
> > +				 <&tdm_ext>;
> > +			clock-names =3D "tdm_ahb", "tdm_apb",
> > +				      "tdm_internal", "tdm",
> > +				      "mclk_inner", "tdm_ext";
> > +			resets =3D <&syscrg JH7110_SYSRST_TDM_AHB>,
> > +				 <&syscrg JH7110_SYSRST_TDM_APB>,
> > +				 <&syscrg JH7110_SYSRST_TDM_CORE>;
> > +			dmas =3D <&dma 20>, <&dma 21>;
> > +			dma-names =3D "rx","tx";
> > +			#sound-dai-cells =3D <0>;
> > +			status =3D "disabled";
> > +		};
> > +
> >  		stgcrg: clock-controller@10230000 {
> >  			compatible =3D "starfive,jh7110-stgcrg";
> >  			reg =3D <0x0 0x10230000 0x0 0x10000>;
> > @@ -601,5 +628,12 @@
> >  			#reset-cells =3D <1>;
> >  			power-domains =3D <&pwrc JH7110_PD_VOUT>;
> >  		};
> > +
> > +		sound0: snd-card0 {
>=20
> 1. Why card0?
> 2. Where is this node located? In MMIO bus? Run some basic checks on
> your DTS before submitting upstream.
> dtbs_check
> dtbs W=3D1
>=20
> 3. Why this is even in the DTSI? This really looks wrong.

Excuse me for not following here, but Walker, could you point me at
where in the schematic for the VisionFive 2 that this wm8960 actually
is?
I know ~nothing about audio, but good old Google tells me that this is a
dedicated codec chip and I was looking at [1] and could not easily find
it on the schematic.

Thanks,
Conor.

1 https://doc-en.rvspace.org/VisionFive2/PDF/SCH_RV002_V1.2A_20221216.pdf

--QNdQWFvvxmlEs8o1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCVBBAAKCRB4tDGHoIJi
0vwwAP9ZaSwYSns7mnKRth/7zaYJio+DGrk7Decdat0PRkCAKgD/V+oWJQb4k4XP
/cV4orJwQtUvav3dglridCNAmArKkQQ=
=3gLi
-----END PGP SIGNATURE-----

--QNdQWFvvxmlEs8o1--
