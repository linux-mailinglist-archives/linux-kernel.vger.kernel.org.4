Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3949E6921EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjBJPUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjBJPUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:20:40 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869437404C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:20:38 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c2so6080630qtw.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JriAq8Gi/1ZAZCHSiwYn6iWy1YzYFzfCzvtM0f9TK/4=;
        b=Ak8uumyyGZ2WCdR3YOxToX/neUD8YY5KeeCoEm8dnW9/UtQRR8eAR6ZhvglL1jim6C
         EBeIk4aYLtWCVW4VTKNqB4KCJkX/ftlPsHBY4jIAgelx5ReOzxf0BeOn8WlP6oT6kft+
         vKP/BIOjz6a8myuyIrp29bVs3v0mFSonTyB/t5T4Jo/OOcTRYN00jSTKoDJiSfYHzFHz
         RStxXyJqix26zvAjfsRPnEy5l8eu4pXBa7XejghyWx0hBZ9636/Nh0HvIChOGmaxI9JC
         WQyoLzWVmgQot++KyMR00pKHkjN+PdvUfJwd+kNbBMtBMDrh/Fay22iK1t7UYo6o2QVr
         uISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JriAq8Gi/1ZAZCHSiwYn6iWy1YzYFzfCzvtM0f9TK/4=;
        b=rT6p3km52l8BNsm5AgTVHVAnMvL7NZh5YcZBt5irLDlJb1tugR3HkwVvo9gtvWMHql
         KjT8jhQXSHeko161lzZOV0cNaSuaFo85UJ0ZuZINOUvyoI6Gre/hinG51/J7efe7vzva
         YeI9wIequyDPOIMyWR884qXtt+lqflSoMEoqguzuXfFVA7R9Z3xyP3J+YvuzE5ku46o3
         LH/t6lyH0eN+PI/gypdqiZSimQfHnftH7NWztGsIXwvqecgfwyuvkCoQksq/8C3ZWj0Y
         evioEVAVaPkguI5Rfgq93cWy7P0SlvG7nE+a46StY21B0F3d5P5swwu6SVS0iLx6AoYD
         2MkQ==
X-Gm-Message-State: AO0yUKUDco/g+V2oU2P8KmHxdmWGyAKLI+jcwAh1eFN4poNq2QWAg6Vk
        SyGchqmf4QdvKEyzB8FxgJAVjA==
X-Google-Smtp-Source: AK7set8Hgjc+RtD9vvQpcaHf6vyuZwqRm3G5h1zIyMGrK/eaeebkthVn4A7HBOu+ycP2s1p7nd2JFQ==
X-Received: by 2002:ac8:5c01:0:b0:3bb:7c6b:9cce with SMTP id i1-20020ac85c01000000b003bb7c6b9ccemr14400068qti.30.1676042437609;
        Fri, 10 Feb 2023 07:20:37 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id 74-20020a37044d000000b007343fceee5fsm3764005qke.8.2023.02.10.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:20:36 -0800 (PST)
Message-ID: <d62cae23114b44f956d7e080b98dcbca630f7215.camel@ndufresne.ca>
Subject: Re: [PATCH v2 04/10] media: Add YUV24_12 video format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 10 Feb 2023 10:20:35 -0500
In-Reply-To: <70b55bc46cd3cce59637d384013785c9efe444db.1675230665.git.ming.qian@nxp.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
         <70b55bc46cd3cce59637d384013785c9efe444db.1675230665.git.ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 01 f=C3=A9vrier 2023 =C3=A0 14:02 +0800, Ming Qian a =C3=A9crit=
=C2=A0:
> YUV24_12 is a YUV format with 12-bits per component like YUV24,
> expanded to 16bits.
> Data in the 12 high bits, zeros in the 4 low bits,
> arranged in little endian order.

In YUV24, 24 is derived from 8x3, but here we have 16x3. So if naming is me=
ant
to be accurate, shouldn't this be YUV48_12 ?

>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../media/v4l/pixfmt-packed-yuv.rst           | 28 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>  include/uapi/linux/videodev2.h                |  1 +
>  4 files changed, 31 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> index bb7169b2cc8d..a098c5e8e609 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> @@ -257,6 +257,34 @@ the second byte and Y'\ :sub:`7-0` in the third byte=
.
>      - The padding bits contain undefined values that must be ignored by =
all
>        applications and drivers.
> =20
> +The next lists the packed YUV 4:4:4 formats with more than 8 bits per co=
mponent.
> +expand the bits per component to 16 bits, data in the high bits, zeros i=
n the low bits,
> +arranged in little endian order. storing 1 pixels in 6 bytes.
> +
> +.. flat-table:: Packed YUV 4:4:4 Image Formats (more than 8bpc)
> +    :header-rows: 1
> +    :stub-columns: 0
> +
> +    * - Identifier
> +      - Code
> +      - Byte 1-0
> +      - Byte 3-2
> +      - Byte 5-4
> +      - Byte 7-6
> +      - Byte 9-8
> +      - Byte 11-10
> +
> +    * .. _V4L2-PIX-FMT-YUV24-12:
> +
> +      - ``V4L2_PIX_FMT_YUV24_12``
> +      - 'Y312'
> +
> +      - Y'\ :sub:`0`
> +      - Cb\ :sub:`0`
> +      - Cr\ :sub:`0`
> +      - Y'\ :sub:`1`
> +      - Cb\ :sub:`1`
> +      - Cr\ :sub:`1`
> =20
>  4:2:2 Subsampling
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index 3a882fb71227..b3ad02f8cf11 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -259,6 +259,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 f=
ormat)
>  		{ .format =3D V4L2_PIX_FMT_UYVY,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_VYUY,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_YUYV_12, .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 4, 0, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 1 },
> +		{ .format =3D V4L2_PIX_FMT_YUV24_12, .pixel_enc =3D V4L2_PIXEL_ENC_YUV=
, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 6, 0, 0, 0 }, .hdiv =3D=
 1, .vdiv =3D 1 },
> =20
>  		/* YUV planar formats */
>  		{ .format =3D V4L2_PIX_FMT_NV12,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 2 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 928acb9d13ec..711d1b0a8184 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1343,6 +1343,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  	case V4L2_PIX_FMT_HI240:	descr =3D "8-bit Dithered RGB (BTTV)"; break;
>  	case V4L2_PIX_FMT_M420:		descr =3D "YUV 4:2:0 (M420)"; break;
>  	case V4L2_PIX_FMT_YUYV_12:	descr =3D "12-bit Depth YUYV 4:2:2"; break;
> +	case V4L2_PIX_FMT_YUV24_12:	descr =3D "12-bit Depth YUV 4:4:4"; break;
>  	case V4L2_PIX_FMT_NV12:		descr =3D "Y/UV 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV21:		descr =3D "Y/VU 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV16:		descr =3D "Y/UV 4:2:2"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 01fd233ff681..3eb188581b83 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -619,6 +619,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX=
-8-8-8-8  */
>  #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV =
4:2:0 2 lines y, 1 line uv interleaved */
>  #define V4L2_PIX_FMT_YUYV_12     v4l2_fourcc('Y', '2', '1', '2') /* 32  =
YUYV 12-bit per component */
> +#define V4L2_PIX_FMT_YUV24_12    v4l2_fourcc('Y', '3', '1', '2') /* 48  =
YUV 4:4:4 12-bit per component */
> =20
>  /* two planes -- one Y, one Cr + Cb interleaved  */
>  #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/Cb=
Cr 4:2:0  */

