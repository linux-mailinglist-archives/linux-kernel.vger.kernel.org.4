Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082237359E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjFSOnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjFSOnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:43:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A390;
        Mon, 19 Jun 2023 07:43:08 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:c623::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5D38F66003B0;
        Mon, 19 Jun 2023 15:43:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687185786;
        bh=NfyaBn5JAp0LRehVuBFB0gPIXq905Ui+DV13yqPSrqs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B9ORFWW4fvQrn/ukiy/D9J2R4/DACD7XnYVyUFccjvabpmC9fO/o+Zbnsclx4XKoQ
         CSNnUG7DWJSc+XljNKYBoV2dNjfMIbhfEnrwR1LoPFlkR/vQPKfGeZ/ejHcv6HIcIE
         8YUA+6K9MW8kLopMoFdY1AHzfvszraoaqI6qiN/b6EpdWhg/nOj6RHiSHaLBd+SzWL
         zjGULMzkmst3l+Wru4+aINsnQ9LcPOpBfQh88kPGeaUWXs2V5pyY8hRW92SkSDBcTs
         HdiXcqxTwZKBpFRVQbgMEFCmw2/2GsAtX/ZVCWULZ1oEPAN0FRWC2NdLTr/jLDl1Qy
         sxqy+c1Uyz6qw==
Message-ID: <2de61884821d707ce1372fffdbeccc20c28e4d03.camel@collabora.com>
Subject: Re: [PATCH v3,01/11] media: mediatek: vcodec: remove unused
 parameter
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
Date:   Mon, 19 Jun 2023 10:42:57 -0400
In-Reply-To: <20230617103255.20239-2-yunfei.dong@mediatek.com>
References: <20230617103255.20239-1-yunfei.dong@mediatek.com>
         <20230617103255.20239-2-yunfei.dong@mediatek.com>
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
> remove unused parameter in struct mtk_vcodec_dev.
>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 2 --
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h     | 6 ------
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c | 2 --
>  3 files changed, 10 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index d41f2121b94f..03721eda2769 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -336,8 +336,6 @@ static int mtk_vcodec_probe(struct platform_device *p=
dev)
>  		goto err_core_workq;
>  	}
> =20
> -	init_waitqueue_head(&dev->queue);
> -
>  	vfd_dec =3D video_device_alloc();
>  	if (!vfd_dec) {
>  		mtk_v4l2_err("Failed to allocate video device");
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> index f17d67e781c9..e3230a4d7b8e 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> @@ -448,10 +448,7 @@ struct mtk_vcodec_enc_pdata {
>   * @decode_workqueue: decode work queue
>   * @encode_workqueue: encode work queue
>   *
> - * @int_cond: used to identify interrupt condition happen
> - * @int_type: used to identify what kind of interrupt condition happen
>   * @dev_mutex: video_device lock
> - * @queue: waitqueue for waiting for completion of device commands
>   *
>   * @dec_irq: decoder irq resource
>   * @enc_irq: h264 encoder irq resource
> @@ -496,10 +493,7 @@ struct mtk_vcodec_dev {
> =20
>  	struct workqueue_struct *decode_workqueue;
>  	struct workqueue_struct *encode_workqueue;
> -	int int_cond;
> -	int int_type;
>  	struct mutex dev_mutex;
> -	wait_queue_head_t queue;
> =20
>  	int dec_irq;
>  	int enc_irq;
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> index 5df0a22ff3b5..a56652e476c2 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> @@ -311,8 +311,6 @@ static int mtk_vcodec_probe(struct platform_device *p=
dev)
>  		goto err_res;
>  	}
> =20
> -	init_waitqueue_head(&dev->queue);
> -
>  	/* allocate video device for encoder and register it */
>  	vfd_enc =3D video_device_alloc();
>  	if (!vfd_enc) {

