Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D0565E86D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjAEJ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjAEJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:57:46 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25C4FD69;
        Thu,  5 Jan 2023 01:57:45 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 28043240006;
        Thu,  5 Jan 2023 09:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672912664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fvlr13b/Y1zYrl0g6v6iiZSrz3z4wdfH46B86FopFgY=;
        b=bGFNyQgMOLa121tXbFw3UGtXKhyimGOJTGqPtIn0Zpza2B9v6CVZOisJhs8fU8PtN97H1T
        EIONvHQRx0RhFpaZDcb6AM0N8vJASsRY56gCTPuit6GdyRUOhHsVRg02icK01TiDovfS/U
        osrUkvFffeNLYng5Qw68nej0PExTc1rTeK90WbUQkq79joH0Riu90L/iFHx/aSrDmYEgsx
        cDfkQOLik+dGzV0DsgrrWRmV//5X94+WvFJ1TFXG+PNAA2v3i0FnxtkCBxnPFs9pyt/+ty
        faZl0Dsnd7Xxq6ZvnuRmzMAhbFkjclPT5BT27vM1rjKWYwGIcY6wpELw9ejRHw==
Date:   Thu, 5 Jan 2023 10:57:27 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/4] media: dt-bindings: cedrus: Make allwinner,sram
 optional
Message-ID: <Y7afB98vPc56bDhm@aptenodytes>
References: <20221231164628.19688-1-samuel@sholland.org>
 <20221231164628.19688-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jljho90DVYkk8si4"
Content-Disposition: inline
In-Reply-To: <20221231164628.19688-3-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jljho90DVYkk8si4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Sat 31 Dec 22, 10:46, Samuel Holland wrote:
> Allwinner SoCs can remap some bits of peripheral SRAM to a contiguous
> range of addresses for use by early boot software. Usually the video
> engine's SRAM is used for this purpose, so its mapping must be switched
> back before the hardware can be used.
>=20
> However, the D1 and related SoCs use the DSP SRAM for this purpose. As a
> result, the video engine SRAM is not switchable, and there is no need
> for an allwinner,sram reference in the devicetree.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>=20
>  .../bindings/media/allwinner,sun4i-a10-video-engine.yaml         | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-=
video-engine.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i=
-a10-video-engine.yaml
> index d5be7f604e8c..74363b242fff 100644
> --- a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-e=
ngine.yaml
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-e=
ngine.yaml
> @@ -73,7 +73,6 @@ required:
>    - clocks
>    - clock-names
>    - resets
> -  - allwinner,sram
> =20
>  additionalProperties: false
> =20
> --=20
> 2.37.4
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--jljho90DVYkk8si4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmO2nwcACgkQ3cLmz3+f
v9Ggugf9HSS2KhNLgkevts5teZksFM4RMyoOoDlpVlPoHJ9dDgeTfdMcoN7vPA9r
YRKtDEyWUVX96YV/RmzVDWGazmbd46/khL5p8HhGHUjphTNVKm6/Ou5V91xBzgmN
lDL7m8hE2LE/LPIa6EOiIAdOwmI0UVcvp2ltKhZibVKZ3gDtovUQmEftYuQmNAF6
Z+iMSZEu2b0N+p1llPTxPwjHjruZknkYhRy3GEZcQEFTPUMIb5u39WjqA8TY1C7o
54aAxAgd0v/T/iELJYHlal4LodbLczu4/OJdHIj1bludFs/cZQwHV+51prwnTlCD
dHwTRJ6b3eLdlvq+km+n8zehF1FLTw==
=4H5j
-----END PGP SIGNATURE-----

--jljho90DVYkk8si4--
