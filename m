Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6397463B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGCULP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGCULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:11:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535A7E7C;
        Mon,  3 Jul 2023 13:11:10 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:88d9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A24846606F85;
        Mon,  3 Jul 2023 21:11:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688415069;
        bh=QsWmngxpO2lX8BoPrdzImKUh6ZfldvuIGfNK2479/4g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eOvXh7lofZ3ufRaXxHkOOMCrvE9OpytXe82KeK+E2ePtxPtnDl1gGsry+aOqoyRgO
         e2CtPn3Z8HcQYLxzt3Kmp1Nk2ftXA6ArEkbkCSbOw/aebUHyD2iUj0yimit2M8rN7q
         zwsqQszdWCfFDQhhlj5TYKWK8zWyjULDhlgD7OgiBENNkNzE98KrZht65w1aLElj98
         H7kSy1iociMdQMKGljTc4G7FvlsVoasMOwqdNwrfANRc0NNsruDJpUhKYhzmE7yv7s
         qK0PzoUTZjzjvkO4jxkFTfBX3/yqdZGf2ATQOlonkvo/57z4dMgoI+jo46gAeYJMgj
         +mw8+nJn8TpoQ==
Message-ID: <8979514b025a60133c18a14be08df1aff3d091d2.camel@collabora.com>
Subject: Re: [PATCH v4,09/11] media: mediatek: vcodec: fix unreasonable
 parameter definition and style
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
Date:   Mon, 03 Jul 2023 16:10:58 -0400
In-Reply-To: <20230626035346.30654-10-yunfei.dong@mediatek.com>
References: <20230626035346.30654-1-yunfei.dong@mediatek.com>
         <20230626035346.30654-10-yunfei.dong@mediatek.com>
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

Le lundi 26 juin 2023 =C3=A0 11:53 +0800, Yunfei Dong a =C3=A9crit=C2=A0:
> Fix unreasonable coding style.
> Fix unreasonable parameter definition.
>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h   | 4 ++--
>  .../media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h   | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
> index a18ba8f32d41..1a0375dd5b6d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
> @@ -19,7 +19,7 @@
>  #define IS_VDEC_INNER_RACING(capability) ((capability) & MTK_VCODEC_INNE=
R_RACING)
> =20
>  /*
> - * struct mtk_vdec_format_types - Structure used to get supported
> + * enum mtk_vdec_format_types - Structure used to get supported
>   *		  format types according to decoder capability
>   */
>  enum mtk_vdec_format_types {
> @@ -258,7 +258,7 @@ struct mtk_vcodec_dec_dev {
>  	const struct mtk_vcodec_dec_pdata *vdec_pdata;
> =20
>  	struct mtk_vcodec_fw *fw_handler;
> -	unsigned long id_counter;
> +	u64 id_counter;
> =20
>  	/* decoder hardware mutex lock */
>  	struct mutex dec_mutex[MTK_VDEC_HW_MAX];
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
> index a88ef9078848..4804d8531a4e 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
> @@ -32,13 +32,13 @@
>   */
>  struct mtk_vcodec_enc_pdata {
>  	bool uses_ext;
> -	unsigned long min_bitrate;
> -	unsigned long max_bitrate;
> +	u64 min_bitrate;
> +	u64 max_bitrate;
>  	const struct mtk_video_fmt *capture_formats;
>  	size_t num_capture_formats;
>  	const struct mtk_video_fmt *output_formats;
>  	size_t num_output_formats;
> -	int core_id;
> +	u8 core_id;
>  	bool uses_34bit;
>  };
> =20
> @@ -208,7 +208,7 @@ struct mtk_vcodec_enc_dev {
>  	const struct mtk_vcodec_enc_pdata *venc_pdata;
> =20
>  	struct mtk_vcodec_fw *fw_handler;
> -	unsigned long id_counter;
> +	u64 id_counter;
> =20
>  	/* encoder hardware mutex lock */
>  	struct mutex enc_mutex;

