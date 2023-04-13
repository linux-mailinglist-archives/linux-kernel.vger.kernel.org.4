Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253786E0BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDMLBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDMLBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:01:14 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E734EF2;
        Thu, 13 Apr 2023 04:01:12 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5CCDE1C0AB2; Thu, 13 Apr 2023 13:01:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681383671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=apZhhGBQhdkiFMWOLelnLl8+7l2Y6+X2pZSEP4YMu+I=;
        b=rZzUNTsrNCsltIwEbZCyo+sXY38t0cLbcxcbeAgoK7QI/Jh/QArot3l2klCAqV1mQ7IiRy
        t8bAgp2GLFUVHBKrCSvBEDf1oHh5Z9uZgfeNNuHoI1WEyJI7dJ7KQxu3+wnavrtJ0GXcFq
        5vBfbycHhHgj9d6k28peOl0ixu8CtzI=
Date:   Thu, 13 Apr 2023 13:01:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 6/7] leds: leds-mt6323: Add support for MT6331 leds
Message-ID: <ZDfg9r820Si8SWWm@duo.ucw.cz>
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
 <20230412153310.241046-7-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vTIJGh4LUCkrhRWR"
Content-Disposition: inline
In-Reply-To: <20230412153310.241046-7-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vTIJGh4LUCkrhRWR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add the register offsets for MT6331. The hwspec is the same as MT6323.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/leds/leds-mt6323.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
> index 182256ec1924..5d95dbd9a761 100644
> --- a/drivers/leds/leds-mt6323.c
> +++ b/drivers/leds/leds-mt6323.c
> @@ -531,6 +531,17 @@ static const struct mt6323_regs mt6323_registers =3D=
 {
>  	.isink_en_ctrl =3D 0x356,
>  };
> =20
> +static const struct mt6323_regs mt6331_registers =3D {
> +	.top_ckpdn =3D (const u16[]){ 0x138, 0x13e, 0x144 },
> +	.num_top_ckpdn =3D 3,
> +	.top_ckcon =3D (const u16[]){ 0x14c, 0x14a },
> +	.num_top_ckcon =3D 2,
> +	.isink_con =3D (const u16[]){ 0x40c, 0x40e, 0x410, 0x412, 0x414 },
> +	.num_isink_con =3D 5,
> +	.isink_max_regs =3D 4, /* ISINK[0..3] */
> +	.isink_en_ctrl =3D 0x43a,
> +};
> +
>  static const struct mt6323_hwspec mt6323_spec =3D {
>  	.max_period =3D 10000,
>  	.max_leds =3D 4,
> @@ -543,8 +554,14 @@ static const struct mt6323_data mt6323_pdata =3D {
>  	.spec =3D &mt6323_spec,
>  };
> =20
> +static const struct mt6323_data mt6331_pdata =3D {
> +	.regs =3D &mt6331_registers,
> +	.spec =3D &mt6323_spec,
> +};
> +
>  static const struct of_device_id mt6323_led_dt_match[] =3D {
>  	{ .compatible =3D "mediatek,mt6323-led", .data =3D &mt6323_pdata},
> +	{ .compatible =3D "mediatek,mt6331-led", .data =3D &mt6331_pdata },
>  	{},

" " before } is missing.

But that's really detail.

Acked-by: Pavel Machek <pavel@ucw.cz>
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--vTIJGh4LUCkrhRWR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDfg9gAKCRAw5/Bqldv6
8iDfAKCSHnJFYz1+A79tL9Yjp90ncmbgzACdEdtwdDkgDt1/F4e9lTd32n2lBUM=
=FN7H
-----END PGP SIGNATURE-----

--vTIJGh4LUCkrhRWR--
