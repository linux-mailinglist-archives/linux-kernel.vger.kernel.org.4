Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB385B5D93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiILPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiILPp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:45:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F22E9E4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:45:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h8so9054964wrf.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=AwjmfBqQK+8fOTNrupWWLWrq7H4lwl+sJc5XKH+WJS4=;
        b=kQtSlpCHsRAkcG4lYBeBAEcKakhgia3M9s0bKWIFCDL5h9+JjY/8ujExEPjN+b8keZ
         mGjl3X6PC5AnzcbfnTNJ328ycJbp5P2JedUXnSabdkehinHnZqbMJ1Rkmk+/Qo7dweE2
         jCLdgn49raNe5bhWAjmWltYwM2boF3oUyNm8stVf6m7l9iu5H/5f6yPhRsMSLMqd22xS
         J5ga9Hr2qf4CaVOXkvBU2ZjWm3xSkOb+Mg+1+cEA9gKUTP7uqRv7OAK+te4raoJyinxa
         sgi0a5+yv45M2YWvPMw7EwkQmlwaglAXHmqIm9D2EeLEvij5W3S4JMplI0oHSIC3Nkkk
         Mc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=AwjmfBqQK+8fOTNrupWWLWrq7H4lwl+sJc5XKH+WJS4=;
        b=bSRppEeokhS35C7FmtzrUW/zw1ULtY+Ql5vLRrn3j5qsFT1IUEdXVlPuqjKqnD1eAi
         2aJoRnyCgoU3oG9v2bugX8C0jirpH+OlWsMLhzwlhrcF99zsJcuHAsgQiXLFSTLcpGb3
         SlR0GIXJOQPi5U5tntIUfijjLx6x5GHBlZ3jyq4iPEKani/dnsVWj1Q+XNktjLDBLOQz
         KT5z1u6C8iOVDhcrZcZsE1o+52QM35gHUF3u/Ds7esA0uaS+QJhVCbe96LNLai7xJp35
         fae4s/a3Cmn1GZAc/cC8wt+2bA75ETNsc7cEJJCMP6k9TZwnpoyMFu1gA/f6/QfGqLod
         Ehtw==
X-Gm-Message-State: ACgBeo0NivLgKRMlFUouZ41kNiQZeLddgooUctrGveLNelFg2A25Ouzg
        bPddUFEi6rcR+FVkY7Kuh+gtWg==
X-Google-Smtp-Source: AA6agR4M5GXma4pcjaqpUOwYcxT6xeDiFg8Mp7VcsvW08P/chbsqnwETAcapyzgBMQFEsZclvzL3wg==
X-Received: by 2002:a5d:68c6:0:b0:228:74b6:2b07 with SMTP id p6-20020a5d68c6000000b0022874b62b07mr15214144wrw.60.1662997524395;
        Mon, 12 Sep 2022 08:45:24 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c020b00b003b4868eb6bbsm5213664wmi.23.2022.09.12.08.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:45:23 -0700 (PDT)
Message-ID: <b5f4e1cc04ba35d92839932d431726fd42f24320.camel@ndufresne.ca>
Subject: Re: [PATCH V2] [media] v4l2: Add AV1 pixel format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Shi Hao <hao.shi@amlogic.com>, laurent.pinchart@ideasonboard.com,
        nanxin.qin@amlogic.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, hans.verkuil@cisco.com,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        sakari.ailus@linux.intel.com, ribalda@chromium.org,
        stanimir.varbanov@linaro.org, hui.zhang@amlogic.com,
        lele.xiang@amlogic.com
Date:   Mon, 12 Sep 2022 16:45:22 +0100
In-Reply-To: <20220830014032.1245359-1-hao.shi@amlogic.com>
References: <20220830014032.1245359-1-hao.shi@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shi,

thanks for the patches, check inline for some comments. Generally speaking,=
 we
don't usually add formats ahead of time unless we have a good rationale to =
do
so. Should be expect a companion series against the amlogic decoder driver =
that
enables this ?

Le mardi 30 ao=C3=BBt 2022 =C3=A0 09:40 +0800, Shi Hao a =C3=A9crit=C2=A0:
> From: "hao.shi" <hao.shi@amlogic.com>
>=20
> Add AV1 compressed pixel format. It is the more common format.
>=20
> Signed-off-by: Hao Shi <hao.shi@amlogic.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-compressed.rst        | 9 +++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                     | 1 +
>  include/uapi/linux/videodev2.h                           | 1 +
>  3 files changed, 11 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> index 506dd3c98884..5bdeeebdf9f5 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> @@ -232,6 +232,15 @@ Compressed Formats
>          Metadata associated with the frame to decode is required to be p=
assed
>          through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
>  	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
> +    * .. _V4L2-PIX-FMT-AV1:
> +
> +      - ``V4L2_PIX_FMT_AV1``
> +      - 'AV1'
> +      - AV1 Access Unit. The decoder expects one Access Unit per buffer.

I believe this is using a MPEG LA terminology. Did you mean a Temporal Unit=
 (TU)
? In AV1 a TU represent 1 displayable picture, just like AU in H.264 (if yo=
u
ignore interlaced video).

> +        The encoder generates one Access Unit per buffer. This format is
> +        adapted for stateful video decoders. AV1 (AOMedia Video 1) is an
> +        open video coding format. It was developed as a successor to VP9
> +        by the Alliance for Open Media (AOMedia).
> =20
>  .. raw:: latex
> =20
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index c314025d977e..fc0f43228546 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  		case V4L2_PIX_FMT_MT21C:	descr =3D "Mediatek Compressed Format"; break=
;
>  		case V4L2_PIX_FMT_QC08C:	descr =3D "QCOM Compressed 8-bit Format"; bre=
ak;
>  		case V4L2_PIX_FMT_QC10C:	descr =3D "QCOM Compressed 10-bit Format"; br=
eak;
> +		case V4L2_PIX_FMT_AV1:		descr =3D "AV1"; break;
>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 01e630f2ec78..c5ea9f38d807 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -738,6 +738,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') =
/* Stateless FWHT (vicodec) */
>  #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 =
parsed slices */
>  #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC =
parsed slices */
> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 */
> =20
>  /*  Vendor-specific formats   */
>  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 Y=
UV */
>=20
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868

