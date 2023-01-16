Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5B566D065
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjAPUrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjAPUrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:47:19 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB527D78
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 12:47:18 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id j9so2851491qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 12:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=auTQc7ls171FtB9Rdx/AnXWuASX8tEkcbzG+L/Ndly4=;
        b=aN1JZAowCcPnqXMuFHUgpfYS+p0a8c8JGxCVQULJl7zIBYhubq/5B+7M42XVKzYjTU
         R8f6bBFeDZkOEt2SjkA5jFMAlrXGIc9jvP+JT5hJm743XSo09G92NQpg2a3RZoILq38k
         JchvWT9JeAnlETFdZ4QMnHA2fycGEWsr3eAAU1i1hn3AoLNw0o3bQPdr6tf+XS24wYCM
         A7rzh2BBCdtrYVXIbzkytAfAkIVCmkS9Pd5pE0oe46MRJ+lxlWYmx6ZqbPrjhacn3yQt
         OyLsRkhRglSVOcCAOPzHzZws1qVU+1kDh8PvLOOzua8G5BrQy0OTJ6d9vZnCJKkDNiqM
         ALqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auTQc7ls171FtB9Rdx/AnXWuASX8tEkcbzG+L/Ndly4=;
        b=XSH/gPhDaToTmdoYIutEGJeBS01qC8y+0mYHBlnHGLb7obeBQMP/uDzWr0g2YBH6CT
         8xR4oP4afRoNR+3UnTfbYSLWUECrPjtHQhB7KnkAn/z6F2WQMCCWf2WGez3zhEPVLnFY
         qu3YFY0aH9asZarr3JnbirZNIOMW8ZPDAGivnaL7yJ8JBu8Rczv0sZ+P4rwMiglUHZYa
         SOfs5Sw8ZMdL9oaVyurJ9pNt6LCb0ltyayMm7YE35m5+C93UikDAOkmmVw+4WIafDK43
         Vg7/BZlWYl/fHsXYDODLrXpEbmTxA6Dv11KOSU6pwZ+dMyxsW7MyEZ4VdCd58R0qOYYg
         qZaQ==
X-Gm-Message-State: AFqh2krZIczV14gh2XiQ//3Hpyod8GdqxDHzGWyuhYiFP0F17DZsZ0+d
        9zxmNMArPq2M+2pDo6WC8cpsfg==
X-Google-Smtp-Source: AMrXdXs7mDuV9/YX/70BnnuzjQchqMN7J1FcatwXKxjN3Co9yiD6c5WjTiHbKGHDVuzWzCKNMnNuZA==
X-Received: by 2002:a05:622a:4a83:b0:3b4:7e41:daa8 with SMTP id fw3-20020a05622a4a8300b003b47e41daa8mr702301qtb.28.1673902037214;
        Mon, 16 Jan 2023 12:47:17 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id br31-20020a05620a461f00b006fa2cc1b0fbsm18713536qkb.11.2023.01.16.12.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:47:16 -0800 (PST)
Message-ID: <d06c0c48d69af6acede89cf5a911180f48b3f266.camel@ndufresne.ca>
Subject: Re: [PATCH v3 1/2] media: add RealVideo format RV30 and RV40
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 16 Jan 2023 15:47:14 -0500
In-Reply-To: <8cbe08de42af1ecf0df39970d57742445fd0d488.1673582851.git.ming.qian@nxp.com>
References: <cover.1673582851.git.ming.qian@nxp.com>
         <8cbe08de42af1ecf0df39970d57742445fd0d488.1673582851.git.ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 13 janvier 2023 =C3=A0 12:13 +0800, Ming Qian a =C3=A9crit=C2=
=A0:
> RealVideo, or also spelled as Real Video, is a suite of proprietary
> video compression formats developed by RealNetworks -
> the specific format changes with the version.
> RealVideo codecs are identified by four-character codes.
> RV30 and RV40 are RealNetworks' proprietary H.264-based codecs.
>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../media/v4l/pixfmt-compressed.rst           | 21 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  2 ++
>  include/uapi/linux/videodev2.h                |  2 ++
>  3 files changed, 25 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> index a0230f357680..50ac095c1f16 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> @@ -237,6 +237,27 @@ Compressed Formats
>          Metadata associated with the frame to decode is required to be p=
assed
>          through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
>  	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
> +    * .. _V4L2-PIX-FMT-RV30:
> +
> +      - ``V4L2_PIX_FMT_RV30``
> +      - 'RV30'
> +      - RealVideo, or also spelled as Real Video, is a suite of propriet=
ary
> +        video compression formats developed by RealNetworks -
> +        the specific format changes with the version.
> +        RealVideo codecs are identified by four-character codes.
> +        RV30 corresponds to RealVideo 8, suspected to based largely on a=
n early draft of H.264

to *be* based on.

Just a style comment too, but the flow could be improved while fixing this =
typo.
Lines in this paragraph seems very uneven.

> +    * .. _V4L2-PIX-FMT-RV40:
> +
> +      - ``V4L2_PIX_FMT_RV40``
> +      - 'RV40'
> +      - RV40 represents RealVideo 9 and RealVideo 10.
> +        RealVideo 9, suspected to be based on H.264,
> +        RealVideo 10, aka RV9 EHQ, This refers to
> +        an improved encoder for the RV9 format
> +        that is fully backwards compatible with RV9 players -
> +        the format and decoder did not change,
> +        only the encoder did.
> +        As a result, it uses the same FourCC.

It feels this one could be wider ? But again, this is cosmetic at this poin=
t.
For the API changes, assuming fixed typo and improved style:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> =20
>  .. raw:: latex
> =20
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 9b5b04b8aa69..0546b00d3fc9 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1473,6 +1473,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  		case V4L2_PIX_FMT_FWHT:		descr =3D "FWHT"; break; /* used in vicodec *=
/
>  		case V4L2_PIX_FMT_FWHT_STATELESS:	descr =3D "FWHT Stateless"; break; /=
* used in vicodec */
>  		case V4L2_PIX_FMT_SPK:		descr =3D "Sorenson Spark"; break;
> +		case V4L2_PIX_FMT_RV30:		descr =3D "RealVideo 8"; break;
> +		case V4L2_PIX_FMT_RV40:		descr =3D "RealVideo 9 & 10"; break;
>  		case V4L2_PIX_FMT_CPIA1:	descr =3D "GSPCA CPiA YUV"; break;
>  		case V4L2_PIX_FMT_WNVA:		descr =3D "WNVA"; break;
>  		case V4L2_PIX_FMT_SN9C10X:	descr =3D "GSPCA SN9C10X"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 262ef10cfa02..b121154a6e24 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -740,6 +740,8 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 =
parsed slices */
>  #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC =
parsed slices */
>  #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenso=
n Spark */
> +#define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVid=
eo 8 */
> +#define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVid=
eo 9 & 10 */
> =20
>  /*  Vendor-specific formats   */
>  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 Y=
UV */

