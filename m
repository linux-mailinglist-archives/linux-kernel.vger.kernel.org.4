Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288D57463B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGCULp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGCULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:11:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18765E47;
        Mon,  3 Jul 2023 13:11:41 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:88d9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 659ED6606F85;
        Mon,  3 Jul 2023 21:11:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688415099;
        bh=xH9M97URyDCaNz7KBqcRG7kNLNJmEMD44BmIGqr3US4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TsBj63eVlDsXzrtOgJW16iTuuBdW1ckHZRzykiTfw3hsiUUOBlAEG8sTJMjZEeVFl
         r493EZU2reixTYcPcNsLdgVCTN50F0VfG2C8KdPYA2gnkw2+r+IY+A+nc1GcnqW73W
         IxN2MnciO1UZ8EM6nv12wKFbKjg3RrB2189Elo3g1xsHoisjPN+AUY+RCqvd8g8Ajg
         P4RAGASvQtMMONwYYHpHP+cpyVRF9NzszfXpzY6j1NuGPsaUCHB84jrvZECtvYzch1
         SpXOQelELcSoC5ndDryLdItNA33aVTjIeJqeSma4tQikrfLO4WiJU0USwr34TQ63ZR
         1xirUIyEOdJvg==
Message-ID: <18dd8837ac53aee879d38bd0c4996d0c7c0797b7.camel@collabora.com>
Subject: Re: [PATCH v4,10/11] media: mediatek: vcodec: remove unused include
 header
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
Date:   Mon, 03 Jul 2023 16:11:29 -0400
In-Reply-To: <20230626035346.30654-11-yunfei.dong@mediatek.com>
References: <20230626035346.30654-1-yunfei.dong@mediatek.com>
         <20230626035346.30654-11-yunfei.dong@mediatek.com>
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
> remove unused include header for .c files
>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c         | 2 --
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c     | 2 --
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c      | 1 -
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c      | 1 -
>  .../media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c    | 2 --
>  .../media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c   | 2 --
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c         | 2 --
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c     | 2 --
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c          | 2 --
>  .../media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c   | 1 -
>  drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c      | 1 -
>  drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c  | 1 -
>  .../platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c      | 1 -
>  .../platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c      | 1 -
>  drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c       | 1 -
>  drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c   | 1 -
>  .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c   | 1 -
>  drivers/media/platform/mediatek/vcodec/vdec_drv_if.h            | 1 -
>  drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h         | 2 --
>  drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c            | 1 -
>  drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h            | 2 --
>  drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c      | 1 -
>  drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c       | 1 -
>  drivers/media/platform/mediatek/vcodec/venc_vpu_if.c            | 1 -
>  drivers/media/platform/mediatek/vcodec/venc_vpu_if.h            | 1 -
>  25 files changed, 34 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> index 0363fec572e5..5acb7dff18f2 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> @@ -11,8 +11,6 @@
> =20
>  #include "mtk_vcodec_dec_drv.h"
>  #include "mtk_vcodec_dec.h"
> -#include "mtk_vcodec_intr.h"
> -#include "mtk_vcodec_util.h"
>  #include "vdec_drv_if.h"
>  #include "mtk_vcodec_dec_pm.h"
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index 8e3aea9a3ab0..36970113d069 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -21,8 +21,6 @@
>  #include "mtk_vcodec_dec_hw.h"
>  #include "mtk_vcodec_dec_pm.h"
>  #include "mtk_vcodec_intr.h"
> -#include "mtk_vcodec_util.h"
> -#include "mtk_vcodec_fw.h"
> =20
>  static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dec_ctx *ctx, struc=
t mtk_vcodec_dec_dev *dev)
>  {
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> index 23c19efa3cf6..fa02fcf4e8c2 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> @@ -16,7 +16,6 @@
>  #include "mtk_vcodec_dec_hw.h"
>  #include "mtk_vcodec_dec_pm.h"
>  #include "mtk_vcodec_intr.h"
> -#include "mtk_vcodec_util.h"
> =20
>  static const struct of_device_id mtk_vdec_hw_match[] =3D {
>  	{
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
> index ed1f503a944e..edd3e6e2df85 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
> @@ -12,7 +12,6 @@
> =20
>  #include "mtk_vcodec_dec_hw.h"
>  #include "mtk_vcodec_dec_pm.h"
> -#include "mtk_vcodec_util.h"
> =20
>  int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vco=
dec_pm *pm)
>  {
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statef=
ul.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
> index 459e74a46737..11ca2c2fbaad 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
> @@ -5,8 +5,6 @@
>  #include <media/videobuf2-dma-contig.h>
> =20
>  #include "mtk_vcodec_dec.h"
> -#include "mtk_vcodec_intr.h"
> -#include "mtk_vcodec_util.h"
>  #include "mtk_vcodec_dec_pm.h"
>  #include "vdec_drv_if.h"
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statel=
ess.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> index 6268a39c2bb3..38b30c876ede 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> @@ -7,8 +7,6 @@
>  #include <linux/module.h>
> =20
>  #include "mtk_vcodec_dec.h"
> -#include "mtk_vcodec_intr.h"
> -#include "mtk_vcodec_util.h"
>  #include "mtk_vcodec_dec_pm.h"
>  #include "vdec_drv_if.h"
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> index 85dabb20fb11..8e44a051edda 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> @@ -11,8 +11,6 @@
>  #include <linux/pm_runtime.h>
> =20
>  #include "mtk_vcodec_enc.h"
> -#include "mtk_vcodec_intr.h"
> -#include "mtk_vcodec_util.h"
>  #include "venc_drv_if.h"
> =20
>  #define MTK_VENC_MIN_W	160U
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> index 0830708de32f..f1b4d5e8cd49 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> @@ -19,8 +19,6 @@
>  #include "mtk_vcodec_enc.h"
>  #include "mtk_vcodec_enc_pm.h"
>  #include "mtk_vcodec_intr.h"
> -#include "mtk_vcodec_util.h"
> -#include "mtk_vcodec_fw.h"
> =20
>  static const struct mtk_video_fmt mtk_video_formats_output[] =3D {
>  	{
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c b/dri=
vers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
> index 5c9f04574ad1..e59ce7c78742 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
> @@ -2,9 +2,7 @@
> =20
>  #include "mtk_vcodec_dec_drv.h"
>  #include "mtk_vcodec_enc_drv.h"
> -#include "mtk_vcodec_fw.h"
>  #include "mtk_vcodec_fw_priv.h"
> -#include "mtk_vcodec_util.h"
> =20
>  struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_f=
w_type type,
>  					   enum mtk_vcodec_fw_use fw_use)
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat=
_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
> index 96ed4bec169e..d272fef36cd1 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
> @@ -8,7 +8,6 @@
>  #include <linux/slab.h>
>  #include <media/videobuf2-dma-contig.h>
> =20
> -#include "../mtk_vcodec_util.h"
>  #include "../mtk_vcodec_dec.h"
>  #include "../mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> index 69914e26cd20..a8175f977ed2 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> @@ -8,7 +8,6 @@
>  #include <linux/slab.h>
> =20
>  #include "../vdec_drv_if.h"
> -#include "../mtk_vcodec_util.h"
>  #include "../mtk_vcodec_dec.h"
>  #include "../mtk_vcodec_intr.h"
>  #include "../vdec_vpu_if.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if=
.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> index 4eb98a705be4..4c5ef35199a1 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> @@ -6,7 +6,6 @@
>  #include <media/v4l2-h264.h>
>  #include <media/videobuf2-dma-contig.h>
> =20
> -#include "../mtk_vcodec_util.h"
>  #include "../mtk_vcodec_dec.h"
>  #include "../mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_=
if.c
> index 79eff921fc97..0f9f7b56882f 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.=
c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.=
c
> @@ -10,7 +10,6 @@
>  #include <media/v4l2-mem2mem.h>
>  #include <media/videobuf2-dma-contig.h>
> =20
> -#include "../mtk_vcodec_util.h"
>  #include "../mtk_vcodec_dec.h"
>  #include "../mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_=
if.c
> index 67a5f8b82eb8..2682f40d1361 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.=
c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.=
c
> @@ -8,7 +8,6 @@
>  #include <linux/slab.h>
>  #include <media/videobuf2-dma-contig.h>
> =20
> -#include "../mtk_vcodec_util.h"
>  #include "../mtk_vcodec_dec.h"
>  #include "../mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> index a8606f74ddc1..ceddcfd9135b 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> @@ -7,7 +7,6 @@
> =20
>  #include <linux/slab.h>
>  #include "../vdec_drv_if.h"
> -#include "../mtk_vcodec_util.h"
>  #include "../mtk_vcodec_dec.h"
>  #include "../mtk_vcodec_intr.h"
>  #include "../vdec_vpu_if.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.=
c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> index d3103b877b61..c85c849d2548 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> @@ -9,7 +9,6 @@
>  #include <media/videobuf2-dma-contig.h>
>  #include <uapi/linux/v4l2-controls.h>
> =20
> -#include "../mtk_vcodec_util.h"
>  #include "../mtk_vcodec_dec.h"
>  #include "../mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat=
_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index 106ee4daf00b..3e9458470484 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -9,7 +9,6 @@
>  #include <media/videobuf2-dma-contig.h>
>  #include <media/v4l2-vp9.h>
> =20
> -#include "../mtk_vcodec_util.h"
>  #include "../mtk_vcodec_dec.h"
>  #include "../mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drive=
rs/media/platform/mediatek/vcodec/vdec_drv_if.h
> index 7b41ce23158b..bfd297c96850 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
> @@ -9,7 +9,6 @@
>  #define _VDEC_DRV_IF_H_
> =20
>  #include "mtk_vcodec_dec.h"
> -#include "mtk_vcodec_util.h"
> =20
> =20
>  /**
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/dr=
ivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> index eeb5deb907ed..1d9beb9e4a14 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> @@ -12,8 +12,6 @@
>  #include <linux/slab.h>
>  #include <media/videobuf2-v4l2.h>
> =20
> -#include "mtk_vcodec_util.h"
> -
>  #define NUM_BUFFER_COUNT 3
> =20
>  struct vdec_lat_buf;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drive=
rs/media/platform/mediatek/vcodec/vdec_vpu_if.c
> index 7fe8e196cb45..82c3dc8c4127 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> @@ -8,7 +8,6 @@
>  #include "vdec_drv_if.h"
>  #include "vdec_ipi_msg.h"
>  #include "vdec_vpu_if.h"
> -#include "mtk_vcodec_fw.h"
> =20
>  static void handle_init_ack_msg(const struct vdec_vpu_ipi_init_ack *msg)
>  {
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h b/drive=
rs/media/platform/mediatek/vcodec/vdec_vpu_if.h
> index c9766c108209..fbb3f34a73f0 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
> @@ -7,8 +7,6 @@
>  #ifndef _VDEC_VPU_IF_H_
>  #define _VDEC_VPU_IF_H_
> =20
> -#include "mtk_vcodec_fw.h"
> -
>  struct mtk_vcodec_dec_ctx;
> =20
>  /**
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> index 41d463d40843..9127bceb0db4 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> @@ -11,7 +11,6 @@
>  #include <linux/slab.h>
> =20
>  #include "../mtk_vcodec_enc_drv.h"
> -#include "../mtk_vcodec_util.h"
>  #include "../mtk_vcodec_intr.h"
>  #include "../mtk_vcodec_enc.h"
>  #include "../mtk_vcodec_enc_pm.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> index dfd6833576f4..510f3b042670 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> @@ -10,7 +10,6 @@
>  #include <linux/slab.h>
> =20
>  #include "../mtk_vcodec_enc_drv.h"
> -#include "../mtk_vcodec_util.h"
>  #include "../mtk_vcodec_intr.h"
>  #include "../mtk_vcodec_enc.h"
>  #include "../mtk_vcodec_enc_pm.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drive=
rs/media/platform/mediatek/vcodec/venc_vpu_if.c
> index bfff16da0451..708db1bb32d4 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> @@ -5,7 +5,6 @@
>   */
> =20
>  #include "mtk_vcodec_enc_drv.h"
> -#include "mtk_vcodec_fw.h"
>  #include "venc_ipi_msg.h"
>  #include "venc_vpu_if.h"
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h b/drive=
rs/media/platform/mediatek/vcodec/venc_vpu_if.h
> index 71370ab98809..ede55fc3bd07 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
> +++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
> @@ -7,7 +7,6 @@
>  #ifndef _VENC_VPU_IF_H_
>  #define _VENC_VPU_IF_H_
> =20
> -#include "mtk_vcodec_fw.h"
>  #include "venc_drv_if.h"
> =20
>  /*

