Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3065E92F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjAEKoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjAEKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:43:47 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73AD44C4C;
        Thu,  5 Jan 2023 02:43:45 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 83AEE100006;
        Thu,  5 Jan 2023 10:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672915424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Yr/nUbSQezXweJY6bNFYpcWO7a/X5IplQE9MKPs4FA=;
        b=VV0/JX2BvGgdlR6xh7CnwhWQPLPXUZS7ei0be0XNMWNdFOAVpZSHgxJhNhoQ/IPYSjnxx3
        PyUMV6Vpx1pV3K0VmNuHxaLFxL164X7pyeKKH8BC3JETfM47AywMB3nzzpcDu8yEpq4rUu
        Q7jPb/MhV98WU4WoV7HpYjin0iel2BcZwhRutDK/e4mv5VVIWysy5RIXNLELSheoQBgrUa
        PU7oL2J3HmADqcWdjJvN/MKrd2Bsmfy0/+HLA7mbbaJ8P0okGGNFYyLZ96uK2RT5xkaYjG
        xsb4qYQ4WqN6uibTtsbQ42bTu6y+6FCGW4xckOZpqeMnfIonag3EeY0OioS0Tg==
Date:   Thu, 5 Jan 2023 11:43:37 +0100
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
Subject: Re: [PATCH 1/4] media: dt-bindings: cedrus: Allow power domain
 references
Message-ID: <Y7ap2dZdCHLNzzHb@aptenodytes>
References: <20221231164628.19688-1-samuel@sholland.org>
 <20221231164628.19688-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nKy3H2Xqe6ArZJHS"
Content-Disposition: inline
In-Reply-To: <20221231164628.19688-2-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nKy3H2Xqe6ArZJHS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Sat 31 Dec 22, 10:46, Samuel Holland wrote:
> The Allwinner D1 SoC contains a separate power domain for its video
> engine, controlled via the "PPU" power controller. Allow the
> power-domains property so this can be represented in the devicetree.

I've been looking around for information regarding the PPU and couldn't find
anything about it. Do you have some reference where it is mentionned?

I do see a power domain driver (apparently for the GPU) on recent allwinner
kernel releases but that seems to be for arm64 chips only.

Cheers,

Paul

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  .../bindings/media/allwinner,sun4i-a10-video-engine.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-=
video-engine.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i=
-a10-video-engine.yaml
> index 541325f900a1..d5be7f604e8c 100644
> --- a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-e=
ngine.yaml
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-e=
ngine.yaml
> @@ -63,6 +63,9 @@ properties:
>        CMA pool to use for buffers allocation instead of the default
>        CMA pool.
> =20
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.37.4
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--nKy3H2Xqe6ArZJHS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmO2qdkACgkQ3cLmz3+f
v9FJkQgAodwHy0mR+AhNUcLpqjFBfhELdfQ6y6YJnDwkiGJJZDkXxAX7rpsAFGYu
6CAoynkF3ve1u9SlMGMQtM4WNpCEX2sPMeAW1ljuTAdeNWIaalSMQS71fDEATuaZ
MqxyQiO02r/9lqcWDGa9C3gkk3cQbIvfC/zK1tu3Gs2WUYOCFPerJUsmBKoucGdE
Z+NHigkZJmHRQ7XDkhMzmcSoiSvDbKS7/pOC9O8A7icca6kdWudk/diC9MYkUYLD
70Os3PUqUYB7e9llTG+sxpv5CQpSLe7uGvUx6e7cqNR59GZk8Tcy8gqcwitRxQkJ
3bbS8sFAgj+6MhX/J02sf6SCFfnkmQ==
=L1ge
-----END PGP SIGNATURE-----

--nKy3H2Xqe6ArZJHS--
