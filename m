Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F4A6DDEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjDKPIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDKPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:08:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED6846AF;
        Tue, 11 Apr 2023 08:08:11 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 892B966031E9;
        Tue, 11 Apr 2023 16:07:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681225673;
        bh=6zKv/B9nW6uWwaqGl/JJ7oB3ZhsSn8JqW0mMaLgTfqA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SJm2ufHSgzgGbKc/ZwC/VZ/eHHouqoBs+YGkHZmSyOBT5tlah2F+t+/KVlHiTeVpn
         PkNs/8cZhynqBdjTlKpFQ+eZyMD+4jSwlTelDJ5wyyMtEf1GU1OeYD4TzF13J5jO7u
         TGMBncIrFY2fl4eEonoO4Bge20NsOG7MNWKVmQfy+mm42IgkvPQnxi8AGcfKMSHZTe
         YKS2gaCwDbdcelPWKlqs7pioNNocJOZutFl5Tbu0Q+HX8SsZUJnZ7uIVgjZG9H0QwV
         ay/+9pPKFmADOWOTwjkYT7oauKGGMaXaIy+DzV7XV4df4lhyyk7rycw5cnA9zT18Ds
         ZDGKywXEm0xpQ==
Message-ID: <2a39fb8f9fb658a12bda3779015e8cb2b976a965.camel@collabora.com>
Subject: Re: [PATCH v5 03/13] media: Add NV12_10LE40_4L4 pixel format
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Tue, 11 Apr 2023 11:07:43 -0400
In-Reply-To: <20230330154043.1250736-4-benjamin.gaignard@collabora.com>
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
         <20230330154043.1250736-4-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 30 mars 2023 =C3=A0 17:40 +0200, Benjamin Gaignard a =C3=A9crit=C2=
=A0:
> NV12_10LE40_4L4 is the 10-bits per component version of
> NV12_4L4 pixel format.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst | 4 ++++
>  drivers/media/v4l2-core/v4l2-common.c                       | 1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c                        | 1 +
>  include/uapi/linux/videodev2.h                              | 1 +
>  4 files changed, 7 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index f1d5bb7b806d..8805213a75f8 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -270,6 +270,7 @@ of the luma plane.
>  .. _V4L2-PIX-FMT-NV12MT:
>  .. _V4L2-PIX-FMT-NV12MT-16X16:
>  .. _V4L2-PIX-FMT-NV12-4L4:
> +.. _V4L2-PIX-FMT-NV12-10LE40-4L4:
>  .. _V4L2-PIX-FMT-NV12-16L16:
>  .. _V4L2-PIX-FMT-NV12-32L32:
>  .. _V4L2-PIX-FMT-NV12M-8L128:
> @@ -306,6 +307,9 @@ tiles linearly in memory. The line stride and image h=
eight must be
>  aligned to a multiple of 4. The layouts of the luma and chroma planes ar=
e
>  identical.
> =20
> +``V4L2_PIX_FMT_NV12_10LE40_4L4`` is similar to ``V4L2_PIX_FMT_NV12_4L4``
> +and stores 10 bits pixels in 4x4 tiles.

I think this is not enough, as it does not describe the NV12_10E40 pixel
packing. We don't have that as a linear format yet in V4L2 (unlike
DRM_FORMAT_NV15 on DRM side). So I'd suggest to drop the usual bit packing =
table
here for now. Please ping Sebastien Fricke, as he got that for (along with
NV12_10LE40 base format) documented in his RKVDEC HEVC decoder work.

>=20
> +
>  ``V4L2_PIX_FMT_NV12_16L16`` stores pixels in 16x16 tiles, and stores
>  tiles linearly in memory. The line stride and image height must be
>  aligned to a multiple of 16. The layouts of the luma and chroma planes a=
re
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index 9cb0895dea1c..7f46c45982d6 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -278,6 +278,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 f=
ormat)
> =20
>  		/* Tiled YUV formats */
>  		{ .format =3D V4L2_PIX_FMT_NV12_4L4, .pixel_enc =3D V4L2_PIXEL_ENC_YUV=
, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
> +		{ .format =3D V4L2_PIX_FMT_NV12_10LE40_4L4, .pixel_enc =3D V4L2_PIXEL_=
ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 5, 10, 0, 0 }, .=
bpp_div =3D { 4, 4, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },

As you will be doing v6, can you initiallized the forgotten "block" paramet=
ers ?


>  		{ .format =3D V4L2_PIX_FMT_P010_4L4, .pixel_enc =3D V4L2_PIXEL_ENC_YUV=
, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 2, 4, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
> =20
>  		/* YUV planar formats, non contiguous variant */
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index d2b905ba5240..5a0c5b3a6b0f 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1351,6 +1351,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  	case V4L2_PIX_FMT_NV12_4L4:	descr =3D "Y/UV 4:2:0 (4x4 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_16L16:	descr =3D "Y/UV 4:2:0 (16x16 Linear)"; br=
eak;
>  	case V4L2_PIX_FMT_NV12_32L32:   descr =3D "Y/UV 4:2:0 (32x32 Linear)"; =
break;
> +	case V4L2_PIX_FMT_NV12_10LE40_4L4: descr =3D "10-bit YUV 4:2:0 (4x4 Lin=
ear)"; break;
>  	case V4L2_PIX_FMT_P010_4L4:	descr =3D "10-bit Y/UV 4:2:0 (4x4 Linear)";=
 break;
>  	case V4L2_PIX_FMT_NV12M:	descr =3D "Y/UV 4:2:0 (N-C)"; break;
>  	case V4L2_PIX_FMT_NV21M:	descr =3D "Y/VU 4:2:0 (N-C)"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 8cdc7967cdea..93e300111ca1 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -664,6 +664,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_NV12_4L4 v4l2_fourcc('V', 'T', '1', '2')   /* 12  Y=
/CbCr 4:2:0  4x4 tiles */
>  #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12  Y=
/CbCr 4:2:0 16x16 tiles */
>  #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12  Y=
/CbCr 4:2:0 32x32 tiles */
> +#define V4L2_PIX_FMT_NV12_10LE40_4L4 v4l2_fourcc('V', 'T', '1', '5')
>  #define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y/C=
bCr 4:2:0 10-bit 4x4 macroblocks */
>  #define V4L2_PIX_FMT_NV12_8L128       v4l2_fourcc('A', 'T', '1', '2') /*=
 Y/CbCr 4:2:0 8x128 tiles */
>  #define V4L2_PIX_FMT_NV12_10BE_8L128  v4l2_fourcc_be('A', 'X', '1', '2')=
 /* Y/CbCr 4:2:0 10-bit 8x128 tiles */

