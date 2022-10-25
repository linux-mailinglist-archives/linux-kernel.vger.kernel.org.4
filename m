Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4165960CFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiJYPFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiJYPFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:05:24 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7684F1AD;
        Tue, 25 Oct 2022 08:05:20 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 60DB16000C;
        Tue, 25 Oct 2022 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666710319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJw8Rlc47CepdpF/VUPGYP+SOmVKJurWX4ajQaE7REY=;
        b=grWlZpU8307qXCEDcJutgnVQSJwJRRphWXN8Z3ZsFVhHmFy3DpnBYnAP+xqX9NHXFjPxmX
        9e3XIOA4t6xPQPwJuPxYvrHZIkL70Dv71yk9Fe1FD6tcaWFAQV7DP6itcLLuMPZdofaAs9
        S3lTb2r91dhdbTVb0UkiRTazglsOuvcx0eQGbpGzijWjmqyQ2C4EY0pyGXEUTGonEQfO25
        gLU2QvnHtKbaXKzAS3quf1isDVI30jZOoDXKLMiTSk8N5Kwq2vjRufAMocf9TSWI5qsDm5
        o/wtEjz80htAYOBEYgfeiry6C4zQ2QufMr/fSc1FjaYdwL9wu/zJ9GaM+s+iFg==
Date:   Tue, 25 Oct 2022 17:05:16 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, mchehab@kernel.org, gregkh@linuxfoundation.org,
        wens@csie.org, samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] media: cedrus: prefer untiled capture format
Message-ID: <Y1f7LCVwRgT9FHDe@aptenodytes>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
 <20221024201515.34129-9-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w+BAvZwxLTv8gd/o"
Content-Disposition: inline
In-Reply-To: <20221024201515.34129-9-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w+BAvZwxLTv8gd/o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Mon 24 Oct 22, 22:15, Jernej Skrabec wrote:
> While all generations of display engine on Allwinner SoCs support
> untiled format, only first generation supports tiled format.  Let's
> move untiled format up, so it can be picked before tiled one. If
> Cedrus variant doesn't support untiled format, tiled will still be
> picked as default format.

Makes sense to me. Of course the order shouldn't matter to smart-enough
userspace but it doesn't hurt to serve the most generic case first.

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_video.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/=
staging/media/sunxi/cedrus/cedrus_video.c
> index 3591bf9d7d9c..f9f723ea3f79 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> @@ -56,13 +56,13 @@ static struct cedrus_format cedrus_formats[] =3D {
>  		.capabilities	=3D CEDRUS_CAPABILITY_VP8_DEC,
>  	},
>  	{
> -		.pixelformat	=3D V4L2_PIX_FMT_NV12_32L32,
> +		.pixelformat	=3D V4L2_PIX_FMT_NV12,
>  		.directions	=3D CEDRUS_DECODE_DST,
> +		.capabilities	=3D CEDRUS_CAPABILITY_UNTILED,
>  	},
>  	{
> -		.pixelformat	=3D V4L2_PIX_FMT_NV12,
> +		.pixelformat	=3D V4L2_PIX_FMT_NV12_32L32,
>  		.directions	=3D CEDRUS_DECODE_DST,
> -		.capabilities	=3D CEDRUS_CAPABILITY_UNTILED,
>  	},
>  };
> =20
> --=20
> 2.38.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--w+BAvZwxLTv8gd/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmNX+ywACgkQ3cLmz3+f
v9FCUwf/V3Ng/xfoDLZGeEjzDHQU3ZtEXX1RMo0WULubg8BMamTlPR4tbDQTBW56
ipFZ0EtzlcdwnQHAhA+3HAu6CTfp+MwxLeeWEr4luVFSX+LuMU22Mclz9Ji7/vwh
OMcQ5fcCJDrYZE0Lc6Y6EzQozjt9q/m7dNG2joUKQzm9Futr6RTUOjUvZ5RgrR3q
8HMZKxxnVxgirPAIMl1h0y57hKWx+C/0L/TGrDeEzjcNxoZYcBuXCUNhdl9lXMFY
MNQq430Jsb4LYuu3bTjtDXYRBGGHOwyjrNsyhWtM8/djejO+FiP48NLQtbL72cIK
CT9U2hRl24cMNSB5oe2ZTZ4pmnGoqw==
=UyBL
-----END PGP SIGNATURE-----

--w+BAvZwxLTv8gd/o--
