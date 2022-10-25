Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04EB60CFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiJYPDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJYPDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:03:07 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD71ABA2E;
        Tue, 25 Oct 2022 08:03:05 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DDA81C0003;
        Tue, 25 Oct 2022 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666710184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gHB07rwCP5LAp4+eGWzJmc9PH06Hl/WaV00j/1veN+g=;
        b=DY+Yef9+ehdc35GpuwjadD3ZZiO/HDEOKtL8GWhLQeaWMUZuTLxrpoWUPi7OLYsIlNUWZV
        zqcbS3AEpIo6YndoKXDD9wFNQw3xyAXMLOZ8OR+E2+sYMNz2XK8dq+3vpXJw8hlLZdLyKZ
        gPcfjkVHZUDJUfekCzUaZK+PFwPlrJT+ufuY66kQRe0HV+c4em+Kl+p+4H3EmuMz8vUibd
        Rn2+QReWa/HQ+vKP1TwkAjwqN6i+EQjjpkpPmNBY47B3vH5BTcUjxFl8YUewEIS+8z0T1D
        szZdxB1jHpEn0XaUct44s7MtRwFqPCpIiUJbm1i+i73/0yyCTqJ+/6/EqhiRtg==
Date:   Tue, 25 Oct 2022 17:03:01 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, mchehab@kernel.org, gregkh@linuxfoundation.org,
        wens@csie.org, samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] media: cedrus: Remove cedrus_codec enum
Message-ID: <Y1f6pUZwoDVHFCU7@aptenodytes>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
 <20221024201515.34129-8-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zH+NmU6EKRT85VpY"
Content-Disposition: inline
In-Reply-To: <20221024201515.34129-8-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zH+NmU6EKRT85VpY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Mon 24 Oct 22, 22:15, Jernej Skrabec wrote:
> Last user of cedrus_codec enum is cedrus_engine_enable() but this
> argument is completely redundant. Same information can be obtained via
> source pixel format. Let's remove this argument and enum.
>=20
> No functional changes intended.

Looks good to me!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

See a suggestion below but out of the scope of this patch.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.h       |  8 --------
>  drivers/staging/media/sunxi/cedrus/cedrus_h264.c  |  2 +-
>  drivers/staging/media/sunxi/cedrus/cedrus_h265.c  |  2 +-
>  drivers/staging/media/sunxi/cedrus/cedrus_hw.c    | 12 ++++++------
>  drivers/staging/media/sunxi/cedrus/cedrus_hw.h    |  2 +-
>  drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c |  2 +-
>  drivers/staging/media/sunxi/cedrus/cedrus_vp8.c   |  2 +-
>  7 files changed, 11 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.h
> index 0b082b1fae22..5904294f3108 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -35,14 +35,6 @@
>  #define CEDRUS_CAPABILITY_VP8_DEC	BIT(4)
>  #define CEDRUS_CAPABILITY_H265_10_DEC	BIT(5)
> =20
> -enum cedrus_codec {
> -	CEDRUS_CODEC_MPEG2,
> -	CEDRUS_CODEC_H264,
> -	CEDRUS_CODEC_H265,
> -	CEDRUS_CODEC_VP8,
> -	CEDRUS_CODEC_LAST,
> -};
> -
>  enum cedrus_irq_status {
>  	CEDRUS_IRQ_NONE,
>  	CEDRUS_IRQ_ERROR,
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h264.c
> index c92dec21c1ac..dfb401df138a 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> @@ -518,7 +518,7 @@ static int cedrus_h264_setup(struct cedrus_ctx *ctx, =
struct cedrus_run *run)
>  	struct cedrus_dev *dev =3D ctx->dev;
>  	int ret;
> =20
> -	cedrus_engine_enable(ctx, CEDRUS_CODEC_H264);
> +	cedrus_engine_enable(ctx);
> =20
>  	cedrus_write(dev, VE_H264_SDROT_CTRL, 0);
>  	cedrus_write(dev, VE_H264_EXTRA_BUFFER1,
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h265.c
> index 7a438cd22c34..5d3da50ce46a 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -471,7 +471,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, =
struct cedrus_run *run)
>  	}
> =20
>  	/* Activate H265 engine. */
> -	cedrus_engine_enable(ctx, CEDRUS_CODEC_H265);
> +	cedrus_engine_enable(ctx);
> =20
>  	/* Source offset and length in bits. */
> =20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.c
> index c3387cd1e80f..fa86a658fdc6 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -31,7 +31,7 @@
>  #include "cedrus_hw.h"
>  #include "cedrus_regs.h"
> =20
> -int cedrus_engine_enable(struct cedrus_ctx *ctx, enum cedrus_codec codec)
> +int cedrus_engine_enable(struct cedrus_ctx *ctx)
>  {
>  	u32 reg =3D 0;
> =20
> @@ -42,18 +42,18 @@ int cedrus_engine_enable(struct cedrus_ctx *ctx, enum=
 cedrus_codec codec)
>  	reg |=3D VE_MODE_REC_WR_MODE_2MB;
>  	reg |=3D VE_MODE_DDR_MODE_BW_128;
> =20
> -	switch (codec) {
> -	case CEDRUS_CODEC_MPEG2:
> +	switch (ctx->src_fmt.pixelformat) {
> +	case V4L2_PIX_FMT_MPEG2_SLICE:
>  		reg |=3D VE_MODE_DEC_MPEG;
>  		break;
> =20
>  	/* H.264 and VP8 both use the same decoding mode bit. */
> -	case CEDRUS_CODEC_H264:
> -	case CEDRUS_CODEC_VP8:
> +	case V4L2_PIX_FMT_H264_SLICE:
> +	case V4L2_PIX_FMT_VP8_FRAME:
>  		reg |=3D VE_MODE_DEC_H264;

Could be nice to declare VE_MODE_DEC_VP8 with the same bit or to rename it
VE_MODE_DEC_H264_VP8. There's no particular reason why H264 should prevail
over VP8.

Cheers,

Paul

>  		break;
> =20
> -	case CEDRUS_CODEC_H265:
> +	case V4L2_PIX_FMT_HEVC_SLICE:
>  		reg |=3D VE_MODE_DEC_H265;
>  		break;
> =20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.h
> index 7c92f00e36da..6f1e701b1ea8 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> @@ -16,7 +16,7 @@
>  #ifndef _CEDRUS_HW_H_
>  #define _CEDRUS_HW_H_
> =20
> -int cedrus_engine_enable(struct cedrus_ctx *ctx, enum cedrus_codec codec=
);
> +int cedrus_engine_enable(struct cedrus_ctx *ctx);
>  void cedrus_engine_disable(struct cedrus_dev *dev);
> =20
>  void cedrus_dst_format_set(struct cedrus_dev *dev,
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/=
staging/media/sunxi/cedrus/cedrus_mpeg2.c
> index c1128d2cd555..10e98f08aafc 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> @@ -66,7 +66,7 @@ static int cedrus_mpeg2_setup(struct cedrus_ctx *ctx, s=
truct cedrus_run *run)
>  	quantisation =3D run->mpeg2.quantisation;
> =20
>  	/* Activate MPEG engine. */
> -	cedrus_engine_enable(ctx, CEDRUS_CODEC_MPEG2);
> +	cedrus_engine_enable(ctx);
> =20
>  	/* Set intra quantisation matrix. */
>  	matrix =3D quantisation->intra_quantiser_matrix;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c b/drivers/st=
aging/media/sunxi/cedrus/cedrus_vp8.c
> index f7714baae37d..969677a3bbf9 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> @@ -662,7 +662,7 @@ static int cedrus_vp8_setup(struct cedrus_ctx *ctx, s=
truct cedrus_run *run)
>  	int header_size;
>  	u32 reg;
> =20
> -	cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
> +	cedrus_engine_enable(ctx);
> =20
>  	cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8);
> =20
> --=20
> 2.38.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--zH+NmU6EKRT85VpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmNX+qUACgkQ3cLmz3+f
v9HEGQf/ZLAOK1r93LJu8pBAqG4xFejKX4hjPCieCPjI3OYk9648ETOzKG7/QMaJ
XZHEagh2o0nnEyv0FUagiV23eXOxmJZnKB3RSM/ynADLDUC+Y+cbpCO2Wqzrd73f
jXyeKO9rfZEF9a2epU8C0xiLcUIFBUoIaeV1JAXLmFKHYyvmybT+rk9SfssUVWkH
/QaNEBuS0T1H1BzYiJiAUOfzykILgxgVOY29a7AZqA/uPp3J5Y21CC/FKJAAkQlb
7f8ZAmvUUlv3HY6lQs4p7f8T/OrZQgZWx5RdlHEwfS08n8erjnhAqpCgnualaVyh
4Ogqr+i5vJRtR0EosNuXiM5Rz8IWxQ==
=QAXg
-----END PGP SIGNATURE-----

--zH+NmU6EKRT85VpY--
