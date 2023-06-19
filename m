Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2164E735E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjFSUSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjFSUSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AFBE72;
        Mon, 19 Jun 2023 13:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D42A460EAE;
        Mon, 19 Jun 2023 20:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFB9C433C8;
        Mon, 19 Jun 2023 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687205911;
        bh=HhghJ0yctP0ql16cZYZqxzheR0DW80MolXe2adxh4PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFJ28e8C/9xbrFv+nFHoy99cXRAzDYp/c1J1kHsrsr0fK0UZGoFs1GeQTFLH5GFBe
         LGYTdHv/yg8aDWvwuBCREEXjxpv/EyT7i08ksdgAFpWcP+8l9Rjx++O88/5udK+kZJ
         Hknr4Rkn9Go5AsgmBzjjfpsqtuoKiT57cVyAxVeR/jJESFWk5NwbXME3/XHfa4JmV+
         TgcKts6kxfDCyi67QVuFaEJi8tD2hJ2EIiTYe6AyAyDLvpsB5BUcgVp3PX5VS4R0Ej
         6/oKCF9bnEFeuC2anUCBG7v60rG1tJuj+gGt39p8EDCWvnjMrQDoUW975N2KrNHxla
         o3kP7IsfJdEPw==
Date:   Mon, 19 Jun 2023 21:18:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 4/6] dt-bindings: display: stm32-ltdc: add optional
 st,fb-bpp property
Message-ID: <20230619-ion-decree-c63d2eb11e83@spud>
References: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
 <20230619165525.1035243-5-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wB3prgNFdxLAzRiP"
Content-Disposition: inline
In-Reply-To: <20230619165525.1035243-5-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wB3prgNFdxLAzRiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Jun 19, 2023 at 06:55:23PM +0200, Dario Binacchi wrote:
> Boards that use the STM32F{4,7} series have limited amounts of RAM. The
> added property allows to size, within certain limits, the memory footprint
> required by the framebuffer.

Hmm, this sounds quite a lot like "software policy", since the actual
display doesn't have these limitations. Rob, Krzysztof?

>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>=20
> (no changes since v1)

Really?
https://lore.kernel.org/all/?q=3Ddfn:st,stm32-ltdc.yaml%20

You sure this shouldn't be "new in v4"?

>  .../devicetree/bindings/display/st,stm32-ltdc.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml=
 b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> index d6ea4d62a2cf..1c3a3653579f 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> @@ -42,6 +42,12 @@ properties:
>        - for internal dpi input of the MIPI DSI host controller.
>        Note: These 2 endpoints cannot be activated simultaneously.
> =20
> +  st,fb-bpp:

Is there not a more understandable property name than this?
Maybe I just had to think about it because fbdev stuff aint something
I've worked with...

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      bit depth of framebuffer (8, 16 or 32)
> +    maxItems: 1

Why not make it an enum, since there are only 4 values?

Cheers,
Conor.

> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.32.0
>=20

--wB3prgNFdxLAzRiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJC4EQAKCRB4tDGHoIJi
0oPpAP92h4xspKGtI1yHs7XjwoYCJXDpWoGzANgb0IX7QDSxWQEA+mwt+9KLghOY
jMdSLkmbkdR8P3BWLJOmAnP6AsLtKQQ=
=IYJt
-----END PGP SIGNATURE-----

--wB3prgNFdxLAzRiP--
