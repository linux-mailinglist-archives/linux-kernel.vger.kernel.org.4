Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6103714929
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjE2MNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjE2MNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:13:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A525DB;
        Mon, 29 May 2023 05:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685362402; x=1716898402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5md7DbVFXKJzY67OTXJwee5/al1KamlL2Bs37Sy9Ulo=;
  b=w2WMgFHfJG8qItFm995jMjr9Gt3wkaUeNYrK+qTOIIo129vBxv68Yvxh
   OxblKVFSVK/am0/a1CaPH1gqLf3WQMKog67uRDKbZDMenHIn3wIfWcwDC
   so56Yi6PEOAZ+dg3p0WQ4aUpif7UwhGqK52ezQBYv8QGUFehldoOShHgz
   v2fVhpROCtf50t82nT79EJolUNrLH+aWvWMATGlVS2z3MxfkdMPmwDDr+
   y70IkwYM0EUj5u3AeM0CJfwAUQKr7gzBvgmY2sNVXsE25V/MUxwi0CsJ7
   yLLjGOuB4stkViYGNdSjjXScD9nFAsa9VL2dGBkShosa0YtA2K4HXJ80C
   w==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="227436470"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 05:13:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 05:13:20 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 05:13:17 -0700
Date:   Mon, 29 May 2023 13:12:55 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] ARM: dts: at91: sama7g5: keep only
 microchip,sam9x60-pit64b compatible for pit64b
Message-ID: <20230529-boxcar-magma-ecce8cf747e4@wendy>
References: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
 <20230529062604.1498052-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R1SFB4Zdugmnpzbz"
Content-Disposition: inline
In-Reply-To: <20230529062604.1498052-2-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--R1SFB4Zdugmnpzbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Claudiu,

On Mon, May 29, 2023 at 09:26:01AM +0300, Claudiu Beznea wrote:
> SAM9X60 and SAMA7G5 PIT64Bs are 1 to 1 compatible. Thus, there is no
> need for specific compatible string on SAMA7G5.

Generally, soc-specific compatibles are something that we want people to
add, not remove!

Cheers,
Conor.

>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/boot/dts/sama7g5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.d=
tsi
> index 886b6209a71e..500b00508621 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -610,7 +610,7 @@ eic: interrupt-controller@e1628000 {
>  		};
> =20
>  		pit64b0: timer@e1800000 {
> -			compatible =3D "microchip,sama7g5-pit64b", "microchip,sam9x60-pit64b";
> +			compatible =3D "microchip,sam9x60-pit64b";
>  			reg =3D <0xe1800000 0x4000>;
>  			interrupts =3D <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&pmc PMC_TYPE_PERIPHERAL 70>, <&pmc PMC_TYPE_GCK 70>;
> @@ -618,7 +618,7 @@ pit64b0: timer@e1800000 {
>  		};
> =20
>  		pit64b1: timer@e1804000 {
> -			compatible =3D "microchip,sama7g5-pit64b", "microchip,sam9x60-pit64b";
> +			compatible =3D "microchip,sam9x60-pit64b";
>  			reg =3D <0xe1804000 0x4000>;
>  			interrupts =3D <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&pmc PMC_TYPE_PERIPHERAL 71>, <&pmc PMC_TYPE_GCK 71>;
> --=20
> 2.34.1
>=20

--R1SFB4Zdugmnpzbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSWxgAKCRB4tDGHoIJi
0t+sAP9b1fAG2shXh6XkwndHkKJExcRQb6/ZWd0pNkW+CpffRAEAhlCCUcoKdqOb
NlQK/6/nZLNE8smgroquBQyIBPiYwwE=
=S/TJ
-----END PGP SIGNATURE-----

--R1SFB4Zdugmnpzbz--
