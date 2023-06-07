Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51227267D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjFGRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjFGRzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956951FD7;
        Wed,  7 Jun 2023 10:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 281C764247;
        Wed,  7 Jun 2023 17:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2736C433EF;
        Wed,  7 Jun 2023 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686160552;
        bh=29SYvOZXQNlr7Jr5ID50ihTnKJ/30DgxM1zuyOrmLa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s53HjWM6tRGYhopxJXf5xHVpWQ35vPpD7M+rna8uG1krUw5veuA74HKrPNICzCscv
         yjVccLgS27xbUNla31Ky5Y/Wsworey4HJ8GlmoN2K407Lkfm3dDwjOmWdiGangH4K6
         Ipo0OlpdNfaJwXOBTxzs0+hESG1qpc3b/pru12FC0AG1/EZ/OiLJIptX3Dlqo+IY/4
         CWHQi+4mPdUxp2Mj/DKOJnRKF41Dy9kM7i1Vb0xN8NfUES0958RW8B3HBmQMkPLvWf
         mWTgfuQA923bk5D0pBHD1kIQ6dLX5ZxQzEipypVndG0Ehli7MRhCbQFKmmXjZwH58m
         jar/OygRKcidg==
Date:   Wed, 7 Jun 2023 18:55:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/8] dt-bindings: display: panel: mipi-dbi-spi: add
 shineworld lh133k compatible
Message-ID: <20230607-speech-blandness-2f0ea0582ad7@spud>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qyLg4k8TFFwTgrn4"
Content-Disposition: inline
In-Reply-To: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qyLg4k8TFFwTgrn4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 01:55:00PM +0200, Leonard G=F6hrs wrote:
> The Shineworld LH133K is a 1.3" 240x240px RGB LCD with a MIPI DBI
> compatible SPI interface.
> The initialization procedure is quite basic with the exception of
> requiring inverted colors.
> A basic mipi-dbi-cmd[1] script to get the display running thus looks
> like this:
>=20
>     $ cat shineworld,lh133k.txt
>     command 0x11 # exit sleep mode
>     delay 120
>=20
>     # The display seems to require display color inversion, so enable it.
>     command 0x21 # INVON
>=20
>     # Enable normal display mode (in contrast to partial display mode).
>     command 0x13 # NORON
>     command 0x29 # MIPI_DCS_SET_DISPLAY_ON
>=20
>     $ mipi-dbi-cmd shineworld,lh133k.bin shineworld,lh133k.txt
>=20
> [1]: https://github.com/notro/panel-mipi-dbi
>=20
> Signed-off-by: Leonard G=F6hrs <l.goehrs@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml   | 1 +
>  Documentation/devicetree/bindings/vendor-prefixes.yaml          | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-d=
bi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-db=
i-spi.yaml
> index 9b701df5e9d28..c07da1a9e6288 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.=
yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.=
yaml
> @@ -67,6 +67,7 @@ properties:
>      items:
>        - enum:
>            - sainsmart18
> +          - shineworld,lh133k
>        - const: panel-mipi-dbi-spi
> =20
>    write-only:

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 82d39ab0231b0..b0afa421bc4a5 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1189,6 +1189,8 @@ patternProperties:
>      description: SHIFT GmbH
>    "^shimafuji,.*":
>      description: Shimafuji Electric, Inc.
> +  "^shineworld,.*":
> +    description: ShineWorld Innovations
>    "^shiratech,.*":
>      description: Shiratech Solutions
>    "^si-en,.*":

AFAIU, these are supposed to be split into separate patches.
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--qyLg4k8TFFwTgrn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIDEowAKCRB4tDGHoIJi
0k2cAQDI/4hOMEiGa8q1y/zPmn3PxYzF3DgRWnwN4grkP6gGoAEAt7HNiYR6pU+y
c2j8t8/xfY2bNykAofT/VJbKcAFxtAw=
=OoDt
-----END PGP SIGNATURE-----

--qyLg4k8TFFwTgrn4--
