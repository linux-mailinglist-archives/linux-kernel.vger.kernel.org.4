Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C1692346
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjBJQ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjBJQ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:28:51 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C769270710
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:28:49 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id k28so3856542qve.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aIir4r1Z5AXqzTFwSPdNjO47USyhkRHqNfoRceUz/qY=;
        b=UC/m8BPJUUN0Z+f9PC8E6k8GHRi4d4jBLAzg+CpvQyxFN2idFgbBkt8w0x0AhIY9N7
         E8iRM28Uf25bweRH3P+wMAhEe0jq/5UC1n78FzvlyTAtq+NJkv9lZRk98NsKoOqNcBlT
         e4QkdqL3WWNa9eUiE+fzm/9DuIHJ5sZKbvAWYLZYbJHeN1tfhnuYGNfX1iNiYSD2Dz0M
         0yxYyKWm2ae4K8msVEC3CT1QsAQyBGyW9Hn5YBmjRLKDAhDwgxyMRjC4ziA9fi0DXuwv
         TCJgC65uho8BbsxBkpdRaV3VCLxcfZD08CJ78gYxNycrN1++3fMLzs6Z+UUtuXQekTPY
         RLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIir4r1Z5AXqzTFwSPdNjO47USyhkRHqNfoRceUz/qY=;
        b=EI6p0ACU4SHjIBM3HlbL0WfGMN2UC1mTcjyxIm4AE4csHJ5kkXnF9kmywEiE9xGRqS
         VyKm6lPzdQmNedzkD5sjJrbvpv5EsfMiSYb0WzHpuEkGk74s4dhGsDqJrPbttjauy5Sa
         gEdtz6GrvECFTZlo4JgHdakRwwmFdQVHdHFVVFtmfA2qsaM7h4zheepfsO9ENgJtnlx6
         m2NdZ5C4qA5L3tL3WSODBSGCA9eLQle3vJJDn3vJApmLBu3kTDqSVHSEE+FGJwpSMa0Z
         7aQDiWFDRIFtp1vGZWVK/jDd1ZrBpmLJ+0o5Gz+9NNiv85uBLr8sL/k60vyd9Eai5Ku7
         tfPg==
X-Gm-Message-State: AO0yUKVh220PYYWaD6UFl0IqBw50aq7hbOyPwML/xyjr66JmWR0GJuVg
        0UbynVqCOlBT+Y4muxdlXpjzOA==
X-Google-Smtp-Source: AK7set/VMyDaNvjoSGk3p9JkOb7BgeXG6eyazoACkk4OwJ3RCVF1GnpF7QAC9Rrq23yIDyfxTtmGyg==
X-Received: by 2002:a05:6214:f24:b0:56c:214e:2042 with SMTP id iw4-20020a0562140f2400b0056c214e2042mr17416254qvb.42.1676046528831;
        Fri, 10 Feb 2023 08:28:48 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id v66-20020a37dc45000000b006fba0a389a4sm3886781qki.88.2023.02.10.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:28:48 -0800 (PST)
Message-ID: <950e020b969f25e9795ee3ad3e2265c4b3427407.camel@ndufresne.ca>
Subject: Re: [PATCH v2 03/10] media: Add YUYV_12 video format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 10 Feb 2023 11:28:46 -0500
In-Reply-To: <116656d22cd244ed0c1df74a1968518d4ab51c23.1675230665.git.ming.qian@nxp.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
         <116656d22cd244ed0c1df74a1968518d4ab51c23.1675230665.git.ming.qian@nxp.com>
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
> YUYV_12 is a YUV format with 12-bits per component like YUYV,
> expanded to 16bits.
> Data in the 12 high bits, zeros in the 4 low bits,
> arranged in little endian order.

In following patches, you use a interesting naming convention:

  <comp order><word size>_<depth>

I think for this type of format this method works well. So I would like to
suggest calling this one:

  V4L2_PIX_FMT_YUYV64_12

Let me know what you think ?


>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../media/v4l/pixfmt-packed-yuv.rst           | 42 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>  include/uapi/linux/videodev2.h                |  1 +
>  4 files changed, 45 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> index bf283a1b5581..bb7169b2cc8d 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> @@ -341,6 +341,48 @@ components horizontally by 2, storing 2 pixels in 4 =
bytes.
> =20
>      \normalsize
> =20
> +The next lists the packed YUV 4:2:2 formats with more than 8 bits per co=
mponent.
> +expand the bits per component to 16 bits, data in the high bits, zeros i=
n the low bits,
> +arranged in little endian order. storing 2 pixels in 8 bytes.
> +
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. tabularcolumns:: |p{3.4cm}|p{1.2cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8c=
m}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|
> +
> +.. flat-table:: Packed YUV 4:2:2 Formats (more than 8bpc)
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
> +      - Byte 13-12
> +      - Byte 15-14
> +    * .. _V4L2-PIX-FMT-YUYV-12:
> +
> +      - ``V4L2_PIX_FMT_YUYV_12``
> +      - 'Y212'
> +
> +      - Y'\ :sub:`0`
> +      - Cb\ :sub:`0`
> +      - Y'\ :sub:`1`
> +      - Cr\ :sub:`0`
> +      - Y'\ :sub:`2`
> +      - Cb\ :sub:`2`
> +      - Y'\ :sub:`3`
> +      - Cr\ :sub:`2`
> +
> +.. raw:: latex
> +
> +    \normalsize
> +
>  **Color Sample Location:**
>  Chroma samples are :ref:`interstitially sited<yuv-chroma-centered>`
>  horizontally.
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index a5e8ba370d33..3a882fb71227 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -258,6 +258,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 f=
ormat)
>  		{ .format =3D V4L2_PIX_FMT_YVYU,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_UYVY,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_VYUY,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 1 },
> +		{ .format =3D V4L2_PIX_FMT_YUYV_12, .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 4, 0, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 1 },
> =20
>  		/* YUV planar formats */
>  		{ .format =3D V4L2_PIX_FMT_NV12,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =3D =
2, .vdiv =3D 2 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 0ee730aa6cc7..928acb9d13ec 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1342,6 +1342,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  	case V4L2_PIX_FMT_YUV420:	descr =3D "Planar YUV 4:2:0"; break;
>  	case V4L2_PIX_FMT_HI240:	descr =3D "8-bit Dithered RGB (BTTV)"; break;
>  	case V4L2_PIX_FMT_M420:		descr =3D "YUV 4:2:0 (M420)"; break;
> +	case V4L2_PIX_FMT_YUYV_12:	descr =3D "12-bit Depth YUYV 4:2:2"; break;
>  	case V4L2_PIX_FMT_NV12:		descr =3D "Y/UV 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV21:		descr =3D "Y/VU 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV16:		descr =3D "Y/UV 4:2:2"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 3d8f89bff33c..01fd233ff681 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -618,6 +618,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_YUVA32  v4l2_fourcc('Y', 'U', 'V', 'A') /* 32  YUVA=
-8-8-8-8  */
>  #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX=
-8-8-8-8  */
>  #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV =
4:2:0 2 lines y, 1 line uv interleaved */
> +#define V4L2_PIX_FMT_YUYV_12     v4l2_fourcc('Y', '2', '1', '2') /* 32  =
YUYV 12-bit per component */
> =20
>  /* two planes -- one Y, one Cr + Cb interleaved  */
>  #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/Cb=
Cr 4:2:0  */

