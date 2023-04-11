Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0920C6DE051
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDKQB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjDKQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:01:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418E34ED6;
        Tue, 11 Apr 2023 09:01:23 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 83BCC66031E9;
        Tue, 11 Apr 2023 17:01:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681228881;
        bh=GPuBBOSRA5wCVbPAYkSCzya+oa0Nysghig9jCyrZUq8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S/KVvhWY0ks44waMOfNV/tWEuJVdN3t7YcSuShWxyNfusu12/f2f582HNLQ2/oCbA
         uODIWFSuxRoyamrp5g/EgqRQbipyHLw7S1YdQjceLW++k4jGrLVx8rn2LVcYI5AwGQ
         YztDpOZLVsZr3r8tGMt+wfjdv831T4ZVvdOYWXT+YkgtyKv4jBUH0mWtpAuC1YPCkH
         +9pkn4gtKZls0e1DUBX+ec0smJGh8Clii4eOpVmwlSGQq5PCpGboOLALiiFar4AfU0
         uWSSqaJkR+XvHsikHGrf2tn5+jcQDxAJrlv93duoOwSvSJn+F5Hl/Tq7KFYFLkV9Vc
         P2cEKXt8QtbgQ==
Message-ID: <d65a8a350a967e4a67636f0be8249e96d5be0d36.camel@collabora.com>
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
Date:   Tue, 11 Apr 2023 12:01:11 -0400
In-Reply-To: <2a39fb8f9fb658a12bda3779015e8cb2b976a965.camel@collabora.com>
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
         <20230330154043.1250736-4-benjamin.gaignard@collabora.com>
         <2a39fb8f9fb658a12bda3779015e8cb2b976a965.camel@collabora.com>
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

As we discussed in person:

Le mardi 11 avril 2023 =C3=A0 11:07 -0400, Nicolas Dufresne a =C3=A9crit=C2=
=A0:
> Le jeudi 30 mars 2023 =C3=A0 17:40 +0200, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> > NV12_10LE40_4L4 is the 10-bits per component version of
> > NV12_4L4 pixel format.

NV12_10LE40 is a name I made up for GStreamer, but this is originally named=
 NV15
by Rockchip, and was accepted under this name as DRM_FORMAT_NV15 in the gra=
phic
subsystem. So we agreed that for Linux, it will be more consistant to use t=
he
NV15 naming, renaming this one to NV15_4L4, with the plus side that its sho=
rter.
The linear form of this format was already proposed a while back along with=
 the
pending RK HEVC driver. We will include the base format doc in here, and re=
-
factor it in later branches.

> >=20
> >=20
> >=20
> >=20
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> >  Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst | 4 ++++
> >  drivers/media/v4l2-core/v4l2-common.c                       | 1 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c                        | 1 +
> >  include/uapi/linux/videodev2.h                              | 1 +
> >  4 files changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rs=
t b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > index f1d5bb7b806d..8805213a75f8 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > @@ -270,6 +270,7 @@ of the luma plane.
> >  .. _V4L2-PIX-FMT-NV12MT:
> >  .. _V4L2-PIX-FMT-NV12MT-16X16:
> >  .. _V4L2-PIX-FMT-NV12-4L4:
> > +.. _V4L2-PIX-FMT-NV12-10LE40-4L4:
> >  .. _V4L2-PIX-FMT-NV12-16L16:
> >  .. _V4L2-PIX-FMT-NV12-32L32:
> >  .. _V4L2-PIX-FMT-NV12M-8L128:
> > @@ -306,6 +307,9 @@ tiles linearly in memory. The line stride and image=
 height must be
> >  aligned to a multiple of 4. The layouts of the luma and chroma planes =
are
> >  identical.
> > =20
> > +``V4L2_PIX_FMT_NV12_10LE40_4L4`` is similar to ``V4L2_PIX_FMT_NV12_4L4=
``
> > +and stores 10 bits pixels in 4x4 tiles.
>=20
> I think this is not enough, as it does not describe the NV12_10E40 pixel
> packing. We don't have that as a linear format yet in V4L2 (unlike
> DRM_FORMAT_NV15 on DRM side). So I'd suggest to drop the usual bit packin=
g table
> here for now. Please ping Sebastien Fricke, as he got that for (along wit=
h
> NV12_10LE40 base format) documented in his RKVDEC HEVC decoder work.
>=20
> >=20
> > +
> >  ``V4L2_PIX_FMT_NV12_16L16`` stores pixels in 16x16 tiles, and stores
> >  tiles linearly in memory. The line stride and image height must be
> >  aligned to a multiple of 16. The layouts of the luma and chroma planes=
 are
> > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2=
-core/v4l2-common.c
> > index 9cb0895dea1c..7f46c45982d6 100644
> > --- a/drivers/media/v4l2-core/v4l2-common.c
> > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > @@ -278,6 +278,7 @@ const struct v4l2_format_info *v4l2_format_info(u32=
 format)
> > =20
> >  		/* Tiled YUV formats */
> >  		{ .format =3D V4L2_PIX_FMT_NV12_4L4, .pixel_enc =3D V4L2_PIXEL_ENC_Y=
UV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .bpp_di=
v =3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
> > +		{ .format =3D V4L2_PIX_FMT_NV12_10LE40_4L4, .pixel_enc =3D V4L2_PIXE=
L_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 5, 10, 0, 0 },=
 .bpp_div =3D { 4, 4, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
>=20
> As you will be doing v6, can you initiallized the forgotten "block" param=
eters ?
>=20
>=20
> >  		{ .format =3D V4L2_PIX_FMT_P010_4L4, .pixel_enc =3D V4L2_PIXEL_ENC_Y=
UV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 2, 4, 0, 0 }, .bpp_di=
v =3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
> > =20
> >  		/* YUV planar formats, non contiguous variant */
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index d2b905ba5240..5a0c5b3a6b0f 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1351,6 +1351,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc =
*fmt)
> >  	case V4L2_PIX_FMT_NV12_4L4:	descr =3D "Y/UV 4:2:0 (4x4 Linear)"; brea=
k;
> >  	case V4L2_PIX_FMT_NV12_16L16:	descr =3D "Y/UV 4:2:0 (16x16 Linear)"; =
break;
> >  	case V4L2_PIX_FMT_NV12_32L32:   descr =3D "Y/UV 4:2:0 (32x32 Linear)"=
; break;
> > +	case V4L2_PIX_FMT_NV12_10LE40_4L4: descr =3D "10-bit YUV 4:2:0 (4x4 L=
inear)"; break;
> >  	case V4L2_PIX_FMT_P010_4L4:	descr =3D "10-bit Y/UV 4:2:0 (4x4 Linear)=
"; break;
> >  	case V4L2_PIX_FMT_NV12M:	descr =3D "Y/UV 4:2:0 (N-C)"; break;
> >  	case V4L2_PIX_FMT_NV21M:	descr =3D "Y/VU 4:2:0 (N-C)"; break;
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 8cdc7967cdea..93e300111ca1 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -664,6 +664,7 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_NV12_4L4 v4l2_fourcc('V', 'T', '1', '2')   /* 12 =
 Y/CbCr 4:2:0  4x4 tiles */
> >  #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12 =
 Y/CbCr 4:2:0 16x16 tiles */
> >  #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12 =
 Y/CbCr 4:2:0 32x32 tiles */
> > +#define V4L2_PIX_FMT_NV12_10LE40_4L4 v4l2_fourcc('V', 'T', '1', '5')
> >  #define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y=
/CbCr 4:2:0 10-bit 4x4 macroblocks */
> >  #define V4L2_PIX_FMT_NV12_8L128       v4l2_fourcc('A', 'T', '1', '2') =
/* Y/CbCr 4:2:0 8x128 tiles */
> >  #define V4L2_PIX_FMT_NV12_10BE_8L128  v4l2_fourcc_be('A', 'X', '1', '2=
') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
>=20

