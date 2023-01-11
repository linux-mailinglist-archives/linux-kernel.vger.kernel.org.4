Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8326B665DED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjAKObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjAKObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:31:23 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0514081
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:28:27 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id v81so7269517vkv.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M1hk39DcijWIOLVjHqGnFGHD0/V+Kbmdll+haGVgDXU=;
        b=ggTM38SWb/dsCtjN7w1lCPj4Sji21TLmFlZZEPbWuONPPRYpxAj8nJy+m2mrAN3QrV
         XjLlM4x82wN3Ghx0Bdk2a7Eh2NBgQyl9Ub3eo/w6UIQeKTv7PBMS9wr58AFILohtnqos
         S1cjV+eWruo8LyVEUDVRzJ8FCaNb0JIA9yIhAmKvgsJIfiihoeGrUdJFDNEFaBB6A1mA
         RrtpMAX6k3sn4D8y7DLQuoR/W2MAHKK5WA7AFTgjgQcDRHic2+ixX/DdO+5RzSixlvbo
         T93TvS7jHBcLzGMvU6aokoT2iuyy2kG8D3hCDXpnds95vzRqOINViWBI5utdYXWVsb4q
         VIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1hk39DcijWIOLVjHqGnFGHD0/V+Kbmdll+haGVgDXU=;
        b=En0N+UZ395CU5q2pxNvcdmUk2A92yfIvrBPWleClPyuiC5Df42gui9WaQzXREcHvT1
         viBrP0H1wh+KQ+wvcj5GFNIZXADu8d5Oy8zj5eaGZKOkFZmz++pspO2Z4yVdxGMKw8J7
         LJwq+FSvGd6H2xMZiMlZbpxWjbzGpVvE0ppxzKnhhaYwcHjCbe2/8WIRDsOmPmBxVwYN
         guCyOwppawei/GBD/nOj2L/ymDNafqg8gV633VEVY83KLzpTD5CIyjmvAWoUI/aYB88Z
         uRzyVjg1xOqGQGRxPiayH1Pfec5aKzGuglpuniIkkiLJtMPhuWNYXi0qLAM1qVRaYQQ9
         mn4A==
X-Gm-Message-State: AFqh2kp2fiyISB/6uTSaXeE4X+wLAuWOPJszdMW4RsHGmtbTSFoUtEby
        b2KkPDozTd0/QUi7ZeHfk4T4pQ==
X-Google-Smtp-Source: AMrXdXs3OJQO6WWQxGZkZo3kWdSwCu9lal2oLWcDAW2dK//APxZnYDP9qU+Udh89pNtiVu5F71OeVg==
X-Received: by 2002:a1f:6012:0:b0:3d5:a227:6e46 with SMTP id u18-20020a1f6012000000b003d5a2276e46mr23034394vkb.5.1673447306420;
        Wed, 11 Jan 2023 06:28:26 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b00705377347b9sm9241693qkp.70.2023.01.11.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 06:28:25 -0800 (PST)
Message-ID: <88e1772841b84a786f4864a6540e03c2e7cd744b.camel@ndufresne.ca>
Subject: Re: [PATCH 1/2] media: add RealMedia format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, ming.zhou@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 11 Jan 2023 09:28:24 -0500
In-Reply-To: <969b6905c945a1cf0986a2188290ddf3c52c5511.1671525379.git.ming.qian@nxp.com>
References: <cover.1671525379.git.ming.qian@nxp.com>
         <969b6905c945a1cf0986a2188290ddf3c52c5511.1671525379.git.ming.qian@nxp.com>
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

Hi Ming,

sorry for the late reply ...

Le mardi 20 d=C3=A9cembre 2022 =C3=A0 16:39 +0800, Ming Qian a =C3=A9crit=
=C2=A0:
> RealMedia is a proprietary multimedia container format
> created by RealNetworks with the filename extension .rm.
> RealMedia is generally used in conjunction with RealVideo and RealAudio,
> while also being used for streaming content over the Internet.
>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-compressed.rst     | 11 +++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                  |  1 +
>  include/uapi/linux/videodev2.h                        |  1 +
>  3 files changed, 13 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> index 8794b92fde36..31ba2c00091e 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> @@ -237,6 +237,17 @@ Compressed Formats
>          Metadata associated with the frame to decode is required to be p=
assed
>          through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
>  	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
> +    * .. _V4L2-PIX-FMT-RV:
> +
> +      - ``V4L2_PIX_FMT_RV``
> +      - 'RealMedia'
> +      - RealMedia is a proprietary multimedia container format
> +        created by RealNetworks with the filename extension .rm.
> +        RealMedia is generally used in conjunction with RealVideo and Re=
alAudio,
> +        while also being used for streaming content over the Internet.
> +        Typically these streams are in CBR (constant bitrate),
> +        but a container for VBR (variable bitrate) streams
> +        named RMVB (RealMedia variable bitrate) has been developed.

I'm a bit confused with the description here. It describes the RealMedia (R=
M)
container format, but what you wanted is a RealVideo encoding (RV).

A quick search into FFMpeg (the only Open Source software decoder I could f=
ind),
the RealVideo comes in 4 incompatible flavours, RV10/RV20/RV30/RV40 also kn=
own
as  RealVideo 1 / G2 / 8 / 9+10. I think the format here should be a RealVi=
deo
format, and it should specify the flavours you want to support (probably on=
ly
RV40).

regards,
Nicolas

> =20
>  .. raw:: latex
> =20
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 9b5b04b8aa69..a4d12eea7fc5 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1473,6 +1473,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  		case V4L2_PIX_FMT_FWHT:		descr =3D "FWHT"; break; /* used in vicodec *=
/
>  		case V4L2_PIX_FMT_FWHT_STATELESS:	descr =3D "FWHT Stateless"; break; /=
* used in vicodec */
>  		case V4L2_PIX_FMT_SPK:		descr =3D "Sorenson Spark"; break;
> +		case V4L2_PIX_FMT_RV:		descr =3D "RealMedia"; break;
>  		case V4L2_PIX_FMT_CPIA1:	descr =3D "GSPCA CPiA YUV"; break;
>  		case V4L2_PIX_FMT_WNVA:		descr =3D "WNVA"; break;
>  		case V4L2_PIX_FMT_SN9C10X:	descr =3D "GSPCA SN9C10X"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 262ef10cfa02..a7a7969ae4f8 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -740,6 +740,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 =
parsed slices */
>  #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC =
parsed slices */
>  #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenso=
n Spark */
> +#define V4L2_PIX_FMT_RV       v4l2_fourcc('R', 'V', '0', '0') /* RealMed=
ia */
> =20
>  /*  Vendor-specific formats   */
>  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 Y=
UV */

