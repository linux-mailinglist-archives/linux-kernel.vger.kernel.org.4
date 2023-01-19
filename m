Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF49674398
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjASUkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjASUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:40:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290789EE0F;
        Thu, 19 Jan 2023 12:40:27 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A682F660087C;
        Thu, 19 Jan 2023 20:40:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674160826;
        bh=pKKvSzEVhqAZVWboXnAR32Zg3yJ4mCGK7JdsQV41PG0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YambYvw0O/wkLxHpHPRgTZC7vh1xd4gpqQeHl7xITtH9YL4e/IRGOI4gZC5edlNbM
         a2eMGk4RXHyb7AhqPKm9wAl2PwhEWR5paXmIwjqAY5g3OIiHLn33+wGCuLl8bEFQdF
         hvPh0kNr6N67DNQY0Jx/WS2OcC7/dxz1QhuIv5iKPh0FcaosT11E2gu8hpgsZPf+l/
         XJz/oc9LfCWoijztaaj0b6vaRy2crmJi6fgMc4J42g4fr0knBhO/Gjnb6oBe8x1Dko
         fQjxYYXOFqMYKP+NZMJc7bYMw7KhsSpAZqviZ51YB+oNZucq5sSIyhlvpkWdJrjxb5
         GgcGzCv0B1GMQ==
Message-ID: <a1345b0c5a25f0f14659f5c02ab49dbcbb2ccdef.camel@collabora.com>
Subject: Re: [PATCH v2 1/2] media: add Sorenson Spark video format
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 19 Jan 2023 15:40:12 -0500
In-Reply-To: <fb29e0170fcbf258136566d59aaa904d0da559a9.1673513975.git.ming.qian@nxp.com>
References: <cover.1673513975.git.ming.qian@nxp.com>
         <fb29e0170fcbf258136566d59aaa904d0da559a9.1673513975.git.ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le jeudi 12 janvier 2023 =C3=A0 17:04 +0800, Ming Qian a =C3=A9crit=C2=A0:
> Sorenson Spark is an implementation of H.263 for use
> in Flash Video and Adobe Flash files.
> Sorenson Spark is an incomplete implementation of H.263.
> It differs mostly in header structure and ranges of the coefficients.
>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 5 +++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                        | 1 +
>  include/uapi/linux/videodev2.h                              | 1 +
>  3 files changed, 7 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> index 506dd3c98884..a0230f357680 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> @@ -88,6 +88,11 @@ Compressed Formats
>        - ``V4L2_PIX_FMT_H263``
>        - 'H263'
>        - H263 video elementary stream.
> +    * .. _V4L2-PIX-FMT-SPK:
> +
> +      - ``V4L2_PIX_FMT_SPK``
> +      - 'SPK0'
> +      - Sorenson Spark is an implementation of H.263 for use in Flash Vi=
deo and Adobe Flash files
>      * .. _V4L2-PIX-FMT-MPEG1:
> =20
>        - ``V4L2_PIX_FMT_MPEG1``
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 8e0a0ff62a70..9b5b04b8aa69 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1472,6 +1472,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  		case V4L2_PIX_FMT_HEVC_SLICE:	descr =3D "HEVC Parsed Slice Data"; brea=
k;
>  		case V4L2_PIX_FMT_FWHT:		descr =3D "FWHT"; break; /* used in vicodec *=
/
>  		case V4L2_PIX_FMT_FWHT_STATELESS:	descr =3D "FWHT Stateless"; break; /=
* used in vicodec */
> +		case V4L2_PIX_FMT_SPK:		descr =3D "Sorenson Spark"; break;
>  		case V4L2_PIX_FMT_CPIA1:	descr =3D "GSPCA CPiA YUV"; break;
>  		case V4L2_PIX_FMT_WNVA:		descr =3D "WNVA"; break;
>  		case V4L2_PIX_FMT_SN9C10X:	descr =3D "GSPCA SN9C10X"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 3c56b81424f3..262ef10cfa02 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -739,6 +739,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') =
/* Stateless FWHT (vicodec) */
>  #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 =
parsed slices */
>  #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC =
parsed slices */
> +#define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenso=
n Spark */
> =20
>  /*  Vendor-specific formats   */
>  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 Y=
UV */

