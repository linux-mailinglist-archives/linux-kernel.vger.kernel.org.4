Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685A669234C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjBJQaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjBJQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:30:12 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ECD70723
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:30:11 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id w3so6339158qts.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JDBS6d/Lda34jyocIqJwGH9bwG6KCV2tTN3mIxJDJKA=;
        b=fphBx+ZJPy4yJfySDl/CrDn0mgzZORtzvFApv24FyvHqJLtyyN87YTL7CUCfloqPmt
         ri+JOQ3PdMzmCvoroOJ/HTrKSeiTSDPkEcXGQrMHHLmsZbA4nJZQHIeeM8fWztpwFNku
         PH/4YDkVEO7heB9ghtjwNvxwMIewUmAKiYT5tNhYQ4kj2+bdbexDzo0jpEbeWJ2Mtk1g
         EIJsPL59TcYoJ1UNdzjacE57YzDDn1POerQDPxH/QjNuNwBPvyQnbSY5d5nr+YcAChiS
         kAiYWC3XAlIZkf0mm9y/DZ+N3jIj6g7Io8fGRLuWcsye/8KiTqw+8ELRE5lt15tD0GFq
         BxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDBS6d/Lda34jyocIqJwGH9bwG6KCV2tTN3mIxJDJKA=;
        b=5o/NhlE+68X1TPR2MvVQ4yuvJ/7mSI0Gg6kpfLjTBHyUkHWBJ+M1unyMT0mbBpn+Ti
         2mV6AfjH3Vs7hU4NJW3I6Qwq9i75UDe6unJEHJQzSFIZ/m82bv1TuTJ6OrsCGg3LKp3G
         7g/5unhGv39G2oPp46pLawmeRt+DDn38T18uJxnD7Qrdqmkzkk1dUPvVJ5dNXpxc0SIF
         3vuLG6RqIZDCk8p6JXElQ+9p4A9Byr719eLaghYLMFjZastBtHgnI7gKKUm/oqfUEpEr
         szFR/F27JJHtE6bAhseOdpGMyNLcDt1dx+0vYk7fwzh5eGmQ3VVMh0S+MtrKUQpBO6Vr
         d6OA==
X-Gm-Message-State: AO0yUKXThW5Pc6cTm6QoxIj4B96LXFaNuDNPfZ+9nztP+GTKR00HpOfy
        /v32yY4z5u44Hhuu3AZDU1AyQA==
X-Google-Smtp-Source: AK7set+yZ3GsVnetj/5WXI/D1fmnG8DYfT0tkn2Spe2TNzEukmng+pk+eG71qpLKqsQIMRxYeDF/FQ==
X-Received: by 2002:a05:622a:15d1:b0:3b8:6868:2ab4 with SMTP id d17-20020a05622a15d100b003b868682ab4mr26545138qty.49.1676046610260;
        Fri, 10 Feb 2023 08:30:10 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id p6-20020ac84086000000b003b9a573aec6sm3622098qtl.70.2023.02.10.08.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:30:09 -0800 (PST)
Message-ID: <36a613ab96fc0145025788a333c30f92bb9c7519.camel@ndufresne.ca>
Subject: Re: [PATCH v2 05/10] media: Add BGR24_12 video format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 10 Feb 2023 11:30:08 -0500
In-Reply-To: <8c74b48e728ecb075a4a65b9771610c9cbe27294.1675230665.git.ming.qian@nxp.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
         <8c74b48e728ecb075a4a65b9771610c9cbe27294.1675230665.git.ming.qian@nxp.com>
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
> BGR24_12 is a reversed RGB format with 12 bits per component like BGR24,
> expanded to 16bits.
> Data in the 12 high bits, zeros in the 4 low bits,
> arranged in little endian order.

I would like to suggest BGR48_12

Nicolas

>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-rgb.rst    | 35 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>  include/uapi/linux/videodev2.h                |  3 ++
>  4 files changed, 40 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst b/Docum=
entation/userspace-api/media/v4l/pixfmt-rgb.rst
> index 30f51cd33f99..da29ba69c2d9 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
> @@ -763,6 +763,41 @@ nomenclature that instead use the order of component=
s as seen in a 24- or
>      \normalsize
> =20
> =20
> +More Than 8 Bits Per Component
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +These formats store an RGB triplet in six or eighth bytes, with more tha=
n 8 bits per component.
> +expand the bits per component to 16 bits, data in the high bits, zeros i=
n the low bits,
> +arranged in little endian order.
> +
> +.. raw:: latex
> +
> +    \small
> +
> +.. flat-table:: RGB Formats With More Than 8 Bits Per Component
> +    :header-rows:  1
> +    :stub-columns: 0
> +
> +    * - Identifier
> +      - Code
> +      - Byte 1-0
> +      - Byte 3-2
> +      - Byte 5-4
> +      - Byte 7-6
> +    * .. _V4L2-PIX-FMT-BGR24-12:
> +
> +      - ``V4L2_PIX_FMT_BGR24_12``
> +      - 'B312'
> +
> +      - B\ :sub:`15-4`
> +      - G\ :sub:`15-4`
> +      - R\ :sub:`15-4`
> +      -
> +
> +.. raw:: latex
> +
> +    \normalsize
> +
>  Deprecated RGB Formats
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index b3ad02f8cf11..024190f82cf1 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -252,6 +252,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 f=
ormat)
>  		{ .format =3D V4L2_PIX_FMT_RGB565,  .pixel_enc =3D V4L2_PIXEL_ENC_RGB,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =3D =
1, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_RGB555,  .pixel_enc =3D V4L2_PIXEL_ENC_RGB,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =3D =
1, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_BGR666,  .pixel_enc =3D V4L2_PIXEL_ENC_RGB,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 4, 0, 0, 0 }, .hdiv =3D =
1, .vdiv =3D 1 },
> +		{ .format =3D V4L2_PIX_FMT_BGR24_12, .pixel_enc =3D V4L2_PIXEL_ENC_RGB=
, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 6, 0, 0, 0 }, .hdiv =3D=
 1, .vdiv =3D 1 },
> =20
>  		/* YUV packed formats */
>  		{ .format =3D V4L2_PIX_FMT_YUYV,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 1 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 711d1b0a8184..329515786abb 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1298,6 +1298,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  	case V4L2_PIX_FMT_BGRX32:	descr =3D "32-bit XBGR 8-8-8-8"; break;
>  	case V4L2_PIX_FMT_RGBA32:	descr =3D "32-bit RGBA 8-8-8-8"; break;
>  	case V4L2_PIX_FMT_RGBX32:	descr =3D "32-bit RGBX 8-8-8-8"; break;
> +	case V4L2_PIX_FMT_BGR24_12:	descr =3D "12-bit Depth BGR"; break;
>  	case V4L2_PIX_FMT_GREY:		descr =3D "8-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y4:		descr =3D "4-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y6:		descr =3D "6-bit Greyscale"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 3eb188581b83..ab52a605e6c0 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -577,6 +577,9 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_ARGB32  v4l2_fourcc('B', 'A', '2', '4') /* 32  ARGB=
-8-8-8-8  */
>  #define V4L2_PIX_FMT_XRGB32  v4l2_fourcc('B', 'X', '2', '4') /* 32  XRGB=
-8-8-8-8  */
> =20
> +/* RGB formats (6 or 8 bytes per pixel) */
> +#define V4L2_PIX_FMT_BGR24_12    v4l2_fourcc('B', '3', '1', '2') /* 48  =
BGR 12-bit per component */
> +
>  /* Grey formats */
>  #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Grey=
scale     */
>  #define V4L2_PIX_FMT_Y4      v4l2_fourcc('Y', '0', '4', ' ') /*  4  Grey=
scale     */

