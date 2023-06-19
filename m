Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E8F7359F7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjFSOpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjFSOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:45:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3BFE68;
        Mon, 19 Jun 2023 07:45:25 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:c623::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D288466032CE;
        Mon, 19 Jun 2023 15:45:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687185924;
        bh=hMxYZEHuqdQTchNPqYUihBTKgBAUhNkJXyW2NZFnC8k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RMy+7HQeROmdt9VEkW5/WpbMJxrb70MmRmqb3R3dwD3xeKivEANvh8MtSY+ddqD6C
         K2ZadfhOzb3km8+pBtja520shhFejYxIrGLafatiZi+VhUaAtSSCjRuTkS35vfOWic
         /FAv6ZLfMx0LNW0ztaeS0dtaGfS2gidkor9nwX7RDiRwWuEn9+OkWaUxN8MIpChXNO
         cdaPJcOuM0nCy/8l+Ssxzx7QtmMuQcfE/LPK7u9Koduq+Q1+xrpEsN6prC9XFs/rxi
         aweomCmnmd3bTQzJKjDjb7VNYZXUjFut9mSTV8HUMfsarOvyFZfGOsnIMgvNWVnjix
         LIL/FIbvqGezQ==
Message-ID: <177fc30731bf7eae91d984ab0788036cf169e69c.camel@collabora.com>
Subject: Re: [PATCH v3,02/11] media: mediatek: vcodec: align fw interface
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?ISO-8859-1?Q?N=EDcolas?= "F . R . A . Prado" 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Mon, 19 Jun 2023 10:45:13 -0400
In-Reply-To: <20230617103255.20239-3-yunfei.dong@mediatek.com>
References: <20230617103255.20239-1-yunfei.dong@mediatek.com>
         <20230617103255.20239-3-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 17 juin 2023 =C3=A0 18:32 +0800, Yunfei Dong a =C3=A9crit=C2=A0:
> Align scp and vpu firmware interface, remove the depedency for
> 'struct mtk_vcodec_dev' and 'struct mtk_vcodec_ctx'. It will be
> much easier to separate video encoder and decoder.
>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/mediatek/vcodec/mtk_vcodec_fw.c   |  7 +++----
>  .../media/platform/mediatek/vcodec/mtk_vcodec_fw.h   |  3 +--
>  .../platform/mediatek/vcodec/mtk_vcodec_fw_priv.h    | 11 +++++------
>  .../platform/mediatek/vcodec/mtk_vcodec_fw_scp.c     |  9 ++++++---
>  .../platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c     | 12 ++++++++----
>  5 files changed, 23 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c b/dri=
vers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
> index 556e54aadac9..be9159acacf8 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
> @@ -5,15 +5,14 @@
>  #include "mtk_vcodec_util.h"
>  #include "mtk_vcodec_drv.h"
> =20
> -struct mtk_vcodec_fw *mtk_vcodec_fw_select(struct mtk_vcodec_dev *dev,
> -					   enum mtk_vcodec_fw_type type,
> +struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_f=
w_type type,
>  					   enum mtk_vcodec_fw_use fw_use)
>  {
>  	switch (type) {
>  	case VPU:
> -		return mtk_vcodec_fw_vpu_init(dev, fw_use);
> +		return mtk_vcodec_fw_vpu_init(priv, fw_use);
>  	case SCP:
> -		return mtk_vcodec_fw_scp_init(dev);
> +		return mtk_vcodec_fw_scp_init(priv, fw_use);
>  	default:
>  		mtk_v4l2_err("invalid vcodec fw type");
>  		return ERR_PTR(-EINVAL);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h b/dri=
vers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
> index 16824114657f..d8cfbec323d5 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
> @@ -25,8 +25,7 @@ struct mtk_vcodec_fw;
>  typedef void (*mtk_vcodec_ipi_handler) (void *data,
>  	unsigned int len, void *priv);
> =20
> -struct mtk_vcodec_fw *mtk_vcodec_fw_select(struct mtk_vcodec_dev *dev,
> -					   enum mtk_vcodec_fw_type type,
> +struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_f=
w_type type,
>  					   enum mtk_vcodec_fw_use fw_use);
>  void mtk_vcodec_fw_release(struct mtk_vcodec_fw *fw);
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
> index b41e66185cec..3438a4917344 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
> @@ -12,6 +12,7 @@ struct mtk_vcodec_fw {
>  	const struct mtk_vcodec_fw_ops *ops;
>  	struct platform_device *pdev;
>  	struct mtk_scp *scp;
> +	enum mtk_vcodec_fw_use fw_use;
>  };
> =20
>  struct mtk_vcodec_fw_ops {
> @@ -28,22 +29,20 @@ struct mtk_vcodec_fw_ops {
>  };
> =20
>  #if IS_ENABLED(CONFIG_VIDEO_MEDIATEK_VCODEC_VPU)
> -struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(struct mtk_vcodec_dev *dev,
> -					     enum mtk_vcodec_fw_use fw_use);
> +struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec=
_fw_use fw_use);
>  #else
>  static inline struct mtk_vcodec_fw *
> -mtk_vcodec_fw_vpu_init(struct mtk_vcodec_dev *dev,
> -		       enum mtk_vcodec_fw_use fw_use)
> +mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use fw_use)
>  {
>  	return ERR_PTR(-ENODEV);
>  }
>  #endif /* CONFIG_VIDEO_MEDIATEK_VCODEC_VPU */
> =20
>  #if IS_ENABLED(CONFIG_VIDEO_MEDIATEK_VCODEC_SCP)
> -struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)=
;
> +struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec=
_fw_use fw_use);
>  #else
>  static inline struct mtk_vcodec_fw *
> -mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
> +mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use fw_use)
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
> index d8e66b645bd8..9a2472442c6f 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
> @@ -53,18 +53,21 @@ static const struct mtk_vcodec_fw_ops mtk_vcodec_rpro=
c_msg =3D {
>  	.release =3D mtk_vcodec_scp_release,
>  };
> =20
> -struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
> +struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec=
_fw_use fw_use)
>  {
>  	struct mtk_vcodec_fw *fw;
> +	struct mtk_vcodec_dev *dev =3D priv;
> +	struct platform_device *plat_dev;
>  	struct mtk_scp *scp;
> =20
> -	scp =3D scp_get(dev->plat_dev);
> +	plat_dev =3D dev->plat_dev;
> +	scp =3D scp_get(plat_dev);
>  	if (!scp) {
>  		mtk_v4l2_err("could not get vdec scp handle");
>  		return ERR_PTR(-EPROBE_DEFER);
>  	}
> =20
> -	fw =3D devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
> +	fw =3D devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
>  	fw->type =3D SCP;
>  	fw->ops =3D &mtk_vcodec_rproc_msg;
>  	fw->scp =3D scp;
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> index cfc7ebed8fb7..46a028031133 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> @@ -77,10 +77,11 @@ static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_=
msg =3D {
>  	.release =3D mtk_vcodec_vpu_release,
>  };
> =20
> -struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(struct mtk_vcodec_dev *dev,
> -					     enum mtk_vcodec_fw_use fw_use)
> +struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec=
_fw_use fw_use)
>  {
>  	struct platform_device *fw_pdev;
> +	struct mtk_vcodec_dev *dev =3D priv;
> +	struct platform_device *plat_dev;
>  	struct mtk_vcodec_fw *fw;
>  	enum rst_id rst_id;
> =20
> @@ -94,19 +95,22 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(struct m=
tk_vcodec_dev *dev,
>  		break;
>  	}
> =20
> -	fw_pdev =3D vpu_get_plat_device(dev->plat_dev);
> +	plat_dev =3D dev->plat_dev;
> +	fw_pdev =3D vpu_get_plat_device(plat_dev);
>  	if (!fw_pdev) {
>  		mtk_v4l2_err("firmware device is not ready");
>  		return ERR_PTR(-EINVAL);
>  	}
> +
>  	vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_handler, dev, rst_id)=
;
> =20
> -	fw =3D devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
> +	fw =3D devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
>  	if (!fw)
>  		return ERR_PTR(-ENOMEM);
>  	fw->type =3D VPU;
>  	fw->ops =3D &mtk_vcodec_vpu_msg;
>  	fw->pdev =3D fw_pdev;
> +	fw->fw_use =3D fw_use;
> =20
>  	return fw;
>  }

