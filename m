Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1A4692351
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBJQaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjBJQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:30:52 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C4977B87
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:30:50 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j5so1659110qvi.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q+rDWbI3qt2mpHyVb9o2ZX8jZyfebWMiWm5kHC7DGWk=;
        b=YU782TRTFsp2Q/0vJphqestm0jyZQjYDozRrMXkg5AoHF5aLEf62Xgxt5JVCg3U3Kw
         nECcST1K4IVw/U7c8V9xeSlvBa3PqoUGXcmMpKZgfoF7yuL8KzdR5jiF86jLV9p9/ZCK
         vO9hEXo+JwBlkNM7cq6vo5USP0Pa/xf22pOryOO3qomJ2MjECQLt5NToBBuzPsmbWaNO
         w7msp3b5Lbec/JI/j6ZLlsJai6nz3511Ypu1bQGF/wifsR8voafkaMymhNZmVpo8vzfD
         PhgLyQETN9/yA5KfD4YaE5ReHO8pwLfq0Db6hZRwURiup+Ydau5l1cHIkeLZTyFLrjXa
         kA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+rDWbI3qt2mpHyVb9o2ZX8jZyfebWMiWm5kHC7DGWk=;
        b=mg00D2+XymLaECfNBTKCJpkI29vsYOQAIqvo4PFB5NBTTbxZAahsb9+klAfPOVhdC/
         udP5QE7UjvzO/cWF8CBAWD3mgZV7X0NXUl1GvIt6NMN8nyXQ4meZ3RjMRN3gb75PttxF
         tR5xUEL22BBiFsgMkXvOI21wBOFb8tNr4V73ETAVR6XFzYz+2cA7l5kyevG9gge/mrzn
         mfMGun+ubJuFfLWmFzWQYll2M3ouyjll4bqE7vp0E5r/ySwkllwqMGgH9lvS4UrWL4Ay
         q7vCggONm7LTMtzO0IZ0U1jSeDSGvzg2lCVY6+wsrgCMh1lkYqZqJpqPoPt+/vC6zQes
         aJQw==
X-Gm-Message-State: AO0yUKVihUSUXHNo/mY77ntNR9LblMZh4ij7hK4U7zSJjiIdyMedggCI
        L3qOoZ+aZ89mJfXLZUhKdiw+8w==
X-Google-Smtp-Source: AK7set/DhDd6YIzQ3syBsIVk6+NbyfqhgCDnHYAUvcwKFoB4G6j666apC9J8ul3iLZPSkG6RRgfRzg==
X-Received: by 2002:a05:6214:2aab:b0:56b:ef97:10e0 with SMTP id js11-20020a0562142aab00b0056bef9710e0mr24220373qvb.46.1676046650021;
        Fri, 10 Feb 2023 08:30:50 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id m66-20020a378a45000000b006f7ee901674sm3838280qkd.2.2023.02.10.08.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:30:49 -0800 (PST)
Message-ID: <fb0cbea01cdb9dc526b458f234eec656300983fb.camel@ndufresne.ca>
Subject: Re: [PATCH v2 06/10] media: Add ABGR32_12 video format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 10 Feb 2023 11:30:48 -0500
In-Reply-To: <e09312997dbc544a69d687fba213c096bcdfc3e9.1675230665.git.ming.qian@nxp.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
         <e09312997dbc544a69d687fba213c096bcdfc3e9.1675230665.git.ming.qian@nxp.com>
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
> ABGR32_12 is a reversed RGB format with alpha channel last,
> 12 bits per component like ABGR32,
> expanded to 16bits.
> Data in the 12 high bits, zeros in the 4 low bits,
> arranged in little endian order.

I would like to suggest ABGR64_12

Nicolas

>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  Documentation/userspace-api/media/v4l/pixfmt-rgb.rst | 9 +++++++++
>  drivers/media/v4l2-core/v4l2-common.c                | 1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c                 | 1 +
>  include/uapi/linux/videodev2.h                       | 1 +
>  4 files changed, 12 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst b/Docum=
entation/userspace-api/media/v4l/pixfmt-rgb.rst
> index da29ba69c2d9..cb60ffe8f860 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
> @@ -793,6 +793,15 @@ arranged in little endian order.
>        - G\ :sub:`15-4`
>        - R\ :sub:`15-4`
>        -
> +    * .. _V4L2-PIX-FMT-ABGR32-12:
> +
> +      - ``V4L2_PIX_FMT_ABGR32_12``
> +      - 'B412'
> +
> +      - B\ :sub:`15-4`
> +      - G\ :sub:`15-4`
> +      - R\ :sub:`15-4`
> +      - A\ :sub:`15-4`
> =20
>  .. raw:: latex
> =20
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index 024190f82cf1..4b3302a07f83 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -253,6 +253,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 f=
ormat)
>  		{ .format =3D V4L2_PIX_FMT_RGB555,  .pixel_enc =3D V4L2_PIXEL_ENC_RGB,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =3D =
1, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_BGR666,  .pixel_enc =3D V4L2_PIXEL_ENC_RGB,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 4, 0, 0, 0 }, .hdiv =3D =
1, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_BGR24_12, .pixel_enc =3D V4L2_PIXEL_ENC_RGB=
, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 6, 0, 0, 0 }, .hdiv =3D=
 1, .vdiv =3D 1 },
> +		{ .format =3D V4L2_PIX_FMT_ABGR32_12, .pixel_enc =3D V4L2_PIXEL_ENC_RG=
B, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 8, 0, 0, 0 }, .hdiv =
=3D 1, .vdiv =3D 1 },
> =20
>  		/* YUV packed formats */
>  		{ .format =3D V4L2_PIX_FMT_YUYV,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 1 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 329515786abb..0f772e19890b 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1299,6 +1299,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  	case V4L2_PIX_FMT_RGBA32:	descr =3D "32-bit RGBA 8-8-8-8"; break;
>  	case V4L2_PIX_FMT_RGBX32:	descr =3D "32-bit RGBX 8-8-8-8"; break;
>  	case V4L2_PIX_FMT_BGR24_12:	descr =3D "12-bit Depth BGR"; break;
> +	case V4L2_PIX_FMT_ABGR32_12:	descr =3D "12-bit Depth BGRA"; break;
>  	case V4L2_PIX_FMT_GREY:		descr =3D "8-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y4:		descr =3D "4-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y6:		descr =3D "6-bit Greyscale"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index ab52a605e6c0..757ab14e7a6e 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -579,6 +579,7 @@ struct v4l2_pix_format {
> =20
>  /* RGB formats (6 or 8 bytes per pixel) */
>  #define V4L2_PIX_FMT_BGR24_12    v4l2_fourcc('B', '3', '1', '2') /* 48  =
BGR 12-bit per component */
> +#define V4L2_PIX_FMT_ABGR32_12   v4l2_fourcc('B', '4', '1', '2') /* 64  =
BGRA 12-bit per component */
> =20
>  /* Grey formats */
>  #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Grey=
scale     */

