Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA972EAB5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbjFMSSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjFMSSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34700184;
        Tue, 13 Jun 2023 11:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E90060BEE;
        Tue, 13 Jun 2023 18:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E74BC433D9;
        Tue, 13 Jun 2023 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680312;
        bh=lN/ZqEmXoki934P40qYc//rkr2yO0dmQOJ7AK2ooq30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jgy4stFumTxUdZD3TISLjanSJ3rLeuCRdBjXcIzFmcMJ1vLDfpUmiVEpGuOdsAyPy
         cDGDV5HIown4NpxhUHUFErIA4N5Hc0wnb3w4Gh4IxHemp1dlja9ll4WGS+6zfSfyQH
         51Lm7f2heGaKgcFTJfsbUgMguKDgsrZQTBBSRyI9h731UTVJJdl9pyiWqMrvlZCcLU
         3xNDJxFDwpBY00edPwX4mmFJJ80kMHL/IThrWA/j/mvXdAyJv/2twyxHFI5X72Fbth
         WCIJ+mYScLjgBbcoX5tvdWSmjD8FX/by3gOjMvaGPRUXz+PE1kQoBrqAqLVCSJbzNh
         OM40TivsF7kuw==
Date:   Tue, 13 Jun 2023 19:18:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Manikandan Muralidharan <manikandan.m@microchip.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, sam@ravnborg.org,
        bbrezillon@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
Subject: Re: [PATCH 1/9] dt-bindings: mfd: Add bindings for SAM9X7 LCD
 controller
Message-ID: <20230613-scouting-barricade-56cadb14657c@spud>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-2-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QP2yCaGkKPXhdEsL"
Content-Disposition: inline
In-Reply-To: <20230613070426.467389-2-manikandan.m@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QP2yCaGkKPXhdEsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 12:34:18PM +0530, Manikandan Muralidharan wrote:
> Add new compatible string for the XLCD controller on SAM9X7 SoC.

You should probably indicate here why this is not compatible with the
existing SoCs that are supported. To hazard a guess, it is the HLCDC IP
(I forget the exact letters!)?
If so,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Docu=
mentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> index 5f8880cc757e..7c77b6bf4adb 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> @@ -8,6 +8,7 @@ Required properties:
>     "atmel,sama5d3-hlcdc"
>     "atmel,sama5d4-hlcdc"
>     "microchip,sam9x60-hlcdc"
> +   "microchip,sam9x7-xlcdc"
>   - reg: base address and size of the HLCDC device registers.
>   - clock-names: the name of the 3 clocks requested by the HLCDC device.
>     Should contain "periph_clk", "sys_clk" and "slow_clk".
> --=20
> 2.25.1
>=20

--QP2yCaGkKPXhdEsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIiy8QAKCRB4tDGHoIJi
0hGuAP94zGUWctEgLEspsssm28IRoOSAft6tLnIjHxmCnaTNsgEAgdQpLSpwU9NG
J6BI+l1yq7iXhBSLceaDwg6K2mtCUgE=
=0h02
-----END PGP SIGNATURE-----

--QP2yCaGkKPXhdEsL--
