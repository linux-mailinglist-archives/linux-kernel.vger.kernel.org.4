Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5122678960
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjAWVTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjAWVTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:19:52 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962727D5F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:19:51 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h24so7516927qta.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jOlbvAaShmf8Gl0ikXZ8hcDrUygNc3QeMBJOc96K2us=;
        b=erejwlCP2bmW0Ojwl2h58WxbHPnNj9a09So+KJi+0zQdpBL1zVGGSdZ3IRhnAaFr1Q
         xgn8ZkCBIfQbE8uRg3Iqrj8mAmxNW+wtKK1sARsgdFXI/77oVKGS5OWOk7ok3zCGV+PY
         skpTPQqIAWhvLq39H8AIp1OfzJlWrCVr0zG1Eejm8pKMhE1bOf2MfYNPIxWRR44PMJ77
         7kTxgVgsl2xJdvC7leeh2Pig6uBKvj9BJ1QQWg2De8esjahcX8h3lPfyKU72hG2+K7vX
         lr2yIt75ysB3yRR6Pj9D1FY7fdNrOBiNv0FOQmH4F1An2LlUoCBz+UxPOxt93UwOSZht
         TEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOlbvAaShmf8Gl0ikXZ8hcDrUygNc3QeMBJOc96K2us=;
        b=ckxZhxCvwcS4sASzWntDOnKnu3L8bAaHZ453lPXGPMVn3dPWWO4OSPEcb+z9POMeBM
         QuFZ0C2tB9HJzgUvy06L//RSYiEr9NOvEh93HlfITuJpyf41tKGIT7ln9m2aEJxzzs5k
         /FQUgrz3YR8Aq/rY6voKjAZjTkb99OdxYfIAFVFiOfUZIFV+WSHPNjuq7Qkfr//PiOpY
         pl0KmTwocrXFO9KAhTClaCOooK3Sb7kZ+mBAhDeRy5W+BWUjZ59lpY3kqTCotZy8+xhe
         d7PpoL3bw+IvDk2gyVeUAiajWHAK/Vdz61k7TQLSc4eel9WVo2EcP2BF6UBgOZYz7yqb
         0zmQ==
X-Gm-Message-State: AFqh2kq8CT8LbKxdEdAS9/OAp9x08b517pV4kKx1+dbmbskPinR+gvTf
        c3nkGoA9WJ/AWYLSRx9M/Zn1NQ==
X-Google-Smtp-Source: AMrXdXsFa36HI7xanlHnzBtlzgwjn6luzlEWTBad7meoAEpQFxTrFcwyQDYekdABtweTxRliH/IA9Q==
X-Received: by 2002:a05:622a:1f16:b0:3b6:369f:c219 with SMTP id ca22-20020a05622a1f1600b003b6369fc219mr41496552qtb.56.1674508790662;
        Mon, 23 Jan 2023 13:19:50 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id 196-20020a3708cd000000b006fcab4da037sm218913qki.39.2023.01.23.13.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:19:50 -0800 (PST)
Message-ID: <13021588108e4e0c0c0c30723e867211fb913fe9.camel@ndufresne.ca>
Subject: Re: [PATCH] media: verisilicon: HEVC: Only propose 10 bits
 compatible pixels formats
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Mon, 23 Jan 2023 16:19:48 -0500
In-Reply-To: <20230113101604.261429-1-benjamin.gaignard@collabora.com>
References: <20230113101604.261429-1-benjamin.gaignard@collabora.com>
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

Le vendredi 13 janvier 2023 =C3=A0 11:16 +0100, Benjamin Gaignard a =C3=A9c=
rit=C2=A0:
> When decoding a 10bits bitstreams HEVC driver should only expose
> 10bits pixel formats.
> To fulfill this requirement it is needed to call hantro_reset_raw_fmt()
> when bit depth change and to correctly set match_depth in pixel formats
> enumeration.
>=20
> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Tested with 8bit tiled / P010 linear, as that's what we have in GStreamer
upstream and it fixed the badly selected format issue. No fluster hack was =
used.

Fluster score was: 141 / 147

Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/verisilicon/hantro_drv.c   | 35 +++++++++++++++++--
>  .../media/platform/verisilicon/hantro_v4l2.c  |  2 +-
>  .../media/platform/verisilicon/hantro_v4l2.h  |  1 +
>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 ++
>  4 files changed, 36 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 8cb4a68c9119..78ea05294004 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -274,8 +274,6 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  		if (sps->bit_depth_luma_minus8 !=3D 0 && sps->bit_depth_luma_minus8 !=
=3D 2)
>  			/* Only 8-bit and 10-bit are supported */
>  			return -EINVAL;
> -
> -		ctx->bit_depth =3D sps->bit_depth_luma_minus8 + 8;
>  	} else if (ctrl->id =3D=3D V4L2_CID_STATELESS_VP9_FRAME) {
>  		const struct v4l2_ctrl_vp9_frame *dec_params =3D ctrl->p_new.p_vp9_fra=
me;
> =20
> @@ -286,6 +284,32 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  	return 0;
>  }
> =20
> +static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct hantro_ctx *ctx;
> +
> +	ctx =3D container_of(ctrl->handler,
> +			   struct hantro_ctx, ctrl_handler);
> +
> +	vpu_debug(1, "s_ctrl: id =3D %d, val =3D %d\n", ctrl->id, ctrl->val);
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_STATELESS_HEVC_SPS:
> +		const struct v4l2_ctrl_hevc_sps *sps =3D ctrl->p_new.p_hevc_sps;
> +		int bit_depth =3D sps->bit_depth_luma_minus8 + 8;
> +
> +		if (ctx->bit_depth !=3D bit_depth) {
> +			ctx->bit_depth =3D bit_depth;
> +			hantro_reset_raw_fmt(ctx);
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
>  {
>  	struct hantro_ctx *ctx;
> @@ -328,6 +352,11 @@ static const struct v4l2_ctrl_ops hantro_ctrl_ops =
=3D {
>  	.try_ctrl =3D hantro_try_ctrl,
>  };
> =20
> +static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops =3D {
> +	.s_ctrl =3D hantro_hevc_s_ctrl,
> +	.try_ctrl =3D hantro_try_ctrl,
> +};
> +
>  static const struct v4l2_ctrl_ops hantro_jpeg_ctrl_ops =3D {
>  	.s_ctrl =3D hantro_jpeg_s_ctrl,
>  };
> @@ -470,7 +499,7 @@ static const struct hantro_ctrl controls[] =3D {
>  		.codec =3D HANTRO_HEVC_DECODER,
>  		.cfg =3D {
>  			.id =3D V4L2_CID_STATELESS_HEVC_SPS,
> -			.ops =3D &hantro_ctrl_ops,
> +			.ops =3D &hantro_hevc_ctrl_ops,
>  		},
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index 2c7a805289e7..0025e049dd26 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -398,7 +398,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  		hantro_set_fmt_out(ctx, fmt);
>  }
> =20
> -static void
> +void
>  hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>  {
>  	const struct hantro_fmt *raw_vpu_fmt;
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.h
> index 64f6f57e9d7a..f642560aed93 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.h
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
> @@ -21,6 +21,7 @@
>  extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>  extern const struct vb2_ops hantro_queue_ops;
> =20
> +void hantro_reset_raw_fmt(struct hantro_ctx *ctx);
>  void hantro_reset_fmts(struct hantro_ctx *ctx);
>  int hantro_get_format_depth(u32 fourcc);
>  const struct hantro_fmt *
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/=
media/platform/verisilicon/imx8m_vpu_hw.c
> index b390228fd3b4..f850d8bddef6 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -152,6 +152,7 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_=
fmts[] =3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.match_depth =3D true,
>  		.postprocessed =3D true,
>  		.frmsize =3D {
>  			.min_width =3D FMT_MIN_WIDTH,
> @@ -165,6 +166,7 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_=
fmts[] =3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_P010,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.match_depth =3D true,
>  		.postprocessed =3D true,
>  		.frmsize =3D {
>  			.min_width =3D FMT_MIN_WIDTH,

