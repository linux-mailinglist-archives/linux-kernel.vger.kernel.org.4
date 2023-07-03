Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E590746355
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGCTcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGCTcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:32:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30931E62;
        Mon,  3 Jul 2023 12:32:05 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:88d9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ACA656606F85;
        Mon,  3 Jul 2023 20:32:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688412723;
        bh=hm6Oqy5VZrzjam2MNHj2pZd7QfzxyjY/WqW5sFRcPek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kH0k5LLHAio6G9bWp+fNR/mNY/yQ/BnQFjA+Fo0h+iRBUh6PKO1EvA5nc5j5z0mMi
         0W/OHed2j+AoBqkQf7gSMjyDsghaj5nfvIH38BT0YUzFcAzrJHjCsbX+nF8UtDmZp9
         CcqYjsKoh+oLPxcMoM/+tylLXy9u1ZD4NSJdGKib6tv7v8Km5KaU4Yox91MRFV+3wX
         g07nWLSvFCLvuycOV2MVeB3plTulfY4oU60ec6nK1vJblVfIosWjU1Mtd6N1sB2yZ7
         k6KD1Er1/qm0+mhGv8mPrcqiw+zn7/B1REECMGy5eiadFEMUsr01lt20tklXD2dhPR
         G25bKmHx/6a4g==
Message-ID: <85ad91de30fc61fe5b2b8633bebd53a358308a7d.camel@collabora.com>
Subject: Re: [PATCH v4,04/11] media: mediatek: vcodec: Removing useless
 debug log
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
Date:   Mon, 03 Jul 2023 15:31:52 -0400
In-Reply-To: <20230626035346.30654-5-yunfei.dong@mediatek.com>
References: <20230626035346.30654-1-yunfei.dong@mediatek.com>
         <20230626035346.30654-5-yunfei.dong@mediatek.com>
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
> Removing unresonable and useless debug log enter and leave
> in order to simply the log message.
>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  1 -
>  .../mediatek/vcodec/mtk_vcodec_util.h         |  6 -----
>  .../mediatek/vcodec/vdec/vdec_h264_if.c       |  4 ----
>  .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |  4 ----
>  .../vcodec/vdec/vdec_h264_req_multi_if.c      |  2 --
>  .../vcodec/vdec/vdec_hevc_req_multi_if.c      |  2 --
>  .../mediatek/vcodec/vdec/vdec_vp8_if.c        |  2 --
>  .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  2 --
>  .../platform/mediatek/vcodec/vdec_vpu_if.c    |  6 -----
>  .../mediatek/vcodec/venc/venc_h264_if.c       | 22 -------------------
>  .../mediatek/vcodec/venc/venc_vp8_if.c        | 22 -------------------
>  .../platform/mediatek/vcodec/venc_vpu_if.c    | 21 ++++--------------
>  12 files changed, 4 insertions(+), 90 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> index a56652e476c2..0db81e150b18 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> @@ -459,7 +459,6 @@ static void mtk_vcodec_enc_remove(struct platform_dev=
ice *pdev)
>  {
>  	struct mtk_vcodec_dev *dev =3D platform_get_drvdata(pdev);
> =20
> -	mtk_v4l2_debug_enter();
>  	destroy_workqueue(dev->encode_workqueue);
>  	if (dev->m2m_dev_enc)
>  		v4l2_m2m_release(dev->m2m_dev_enc);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/d=
rivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> index 827937bcb4b4..a356f42362e4 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> @@ -62,12 +62,6 @@ extern int mtk_vcodec_dbg;
>  		((struct mtk_vcodec_ctx *)(h)->ctx)->id, ##args)
>  #endif
> =20
> -#define mtk_v4l2_debug_enter()  mtk_v4l2_debug(3, "+")
> -#define mtk_v4l2_debug_leave()  mtk_v4l2_debug(3, "-")
> -
> -#define mtk_vcodec_debug_enter(h)  mtk_vcodec_debug(h, "+")
> -#define mtk_vcodec_debug_leave(h)  mtk_vcodec_debug(h, "-")
> -
>  void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned =
int reg_idx);
>  int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
>  void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> index 481655bb6016..24312a90afbb 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> @@ -156,8 +156,6 @@ static void free_predication_buf(struct vdec_h264_ins=
t *inst)
>  {
>  	struct mtk_vcodec_mem *mem =3D NULL;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	inst->vsi->pred_buf_dma =3D 0;
>  	mem =3D &inst->pred_buf;
>  	if (mem->va)
> @@ -311,8 +309,6 @@ static void vdec_h264_deinit(void *h_vdec)
>  {
>  	struct vdec_h264_inst *inst =3D (struct vdec_h264_inst *)h_vdec;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	vpu_dec_deinit(&inst->vpu);
>  	free_predication_buf(inst);
>  	free_mv_buf(inst);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if=
.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> index 4bc05ab5afea..dc6ee266f232 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> @@ -174,8 +174,6 @@ static void free_predication_buf(struct vdec_h264_sli=
ce_inst *inst)
>  {
>  	struct mtk_vcodec_mem *mem =3D &inst->pred_buf;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	inst->vsi_ctx.pred_buf_dma =3D 0;
>  	if (mem->va)
>  		mtk_vcodec_mem_free(inst->ctx, mem);
> @@ -322,8 +320,6 @@ static void vdec_h264_slice_deinit(void *h_vdec)
>  {
>  	struct vdec_h264_slice_inst *inst =3D h_vdec;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	vpu_dec_deinit(&inst->vpu);
>  	free_predication_buf(inst);
>  	free_mv_buf(inst);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_=
if.c
> index a7e8e3257b7f..3cb5b967f48a 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.=
c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.=
c
> @@ -444,8 +444,6 @@ static void vdec_h264_slice_deinit(void *h_vdec)
>  {
>  	struct vdec_h264_slice_inst *inst =3D h_vdec;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	vpu_dec_deinit(&inst->vpu);
>  	vdec_h264_slice_free_mv_buf(inst);
>  	vdec_msg_queue_deinit(&inst->ctx->msg_queue, inst->ctx);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_=
if.c
> index 1e6ab138b0bb..0bb5b54578e9 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.=
c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.=
c
> @@ -911,8 +911,6 @@ static void vdec_hevc_slice_deinit(void *h_vdec)
>  	struct vdec_hevc_slice_inst *inst =3D h_vdec;
>  	struct mtk_vcodec_mem *mem;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	vpu_dec_deinit(&inst->vpu);
>  	vdec_hevc_slice_free_mv_buf(inst);
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> index 5edbccc9ae68..fb5bc30b113b 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> @@ -601,8 +601,6 @@ static void vdec_vp8_deinit(void *h_vdec)
>  {
>  	struct vdec_vp8_inst *inst =3D (struct vdec_vp8_inst *)h_vdec;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	vpu_dec_deinit(&inst->vpu);
>  	free_working_buf(inst);
>  	kfree(inst);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.=
c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> index e1fe2603e92e..f7181f4a4d2a 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> @@ -421,8 +421,6 @@ static void vdec_vp8_slice_deinit(void *h_vdec)
>  {
>  	struct vdec_vp8_slice_inst *inst =3D h_vdec;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	vpu_dec_deinit(&inst->vpu);
>  	vdec_vp8_slice_free_working_buf(inst);
>  	kfree(inst);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drive=
rs/media/platform/mediatek/vcodec/vdec_vpu_if.c
> index df309e8e9379..60e5b70fa127 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> @@ -183,8 +183,6 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
>  	struct vdec_ap_ipi_init msg;
>  	int err;
> =20
> -	mtk_vcodec_debug_enter(vpu);
> -
>  	init_waitqueue_head(&vpu->wq);
>  	vpu->handler =3D vpu_dec_ipi_handler;
> =20
> @@ -223,8 +221,6 @@ int vpu_dec_start(struct vdec_vpu_inst *vpu, uint32_t=
 *data, unsigned int len)
>  	int i;
>  	int err =3D 0;
> =20
> -	mtk_vcodec_debug_enter(vpu);
> -
>  	if (len > ARRAY_SIZE(msg.data)) {
>  		mtk_vcodec_err(vpu, "invalid len =3D %d\n", len);
>  		return -EINVAL;
> @@ -252,8 +248,6 @@ int vpu_dec_get_param(struct vdec_vpu_inst *vpu, uint=
32_t *data,
>  	struct vdec_ap_ipi_get_param msg;
>  	int err;
> =20
> -	mtk_vcodec_debug_enter(vpu);
> -
>  	if (len > ARRAY_SIZE(msg.data)) {
>  		mtk_vcodec_err(vpu, "invalid len =3D %d\n", len);
>  		return -EINVAL;
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> index 10365c95ebbe..c821ed427537 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> @@ -298,8 +298,6 @@ static void h264_enc_free_work_buf(struct venc_h264_i=
nst *inst)
>  {
>  	int i;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	/* Except the SKIP_FRAME buffers,
>  	 * other buffers need to be freed by AP.
>  	 */
> @@ -309,8 +307,6 @@ static void h264_enc_free_work_buf(struct venc_h264_i=
nst *inst)
>  	}
> =20
>  	mtk_vcodec_mem_free(inst->ctx, &inst->pps_buf);
> -
> -	mtk_vcodec_debug_leave(inst);
>  }
> =20
>  static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst, bool is_=
34bit)
> @@ -321,8 +317,6 @@ static int h264_enc_alloc_work_buf(struct venc_h264_i=
nst *inst, bool is_34bit)
>  	u32 vpua, wb_size;
>  	int ret =3D 0;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	if (is_34bit)
>  		wb_34 =3D inst->vsi_34->work_bufs;
>  	else
> @@ -406,8 +400,6 @@ static int h264_enc_alloc_work_buf(struct venc_h264_i=
nst *inst, bool is_34bit)
>  		goto err_alloc;
>  	}
> =20
> -	mtk_vcodec_debug_leave(inst);
> -
>  	return ret;
> =20
>  err_alloc:
> @@ -452,8 +444,6 @@ static int h264_encode_sps(struct venc_h264_inst *ins=
t,
>  	int ret =3D 0;
>  	unsigned int irq_status;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	ret =3D vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_SPS, NULL, bs_buf,=
 NULL);
>  	if (ret)
>  		return ret;
> @@ -478,8 +468,6 @@ static int h264_encode_pps(struct venc_h264_inst *ins=
t,
>  	int ret =3D 0;
>  	unsigned int irq_status;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	ret =3D vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_PPS, NULL, bs_buf,=
 NULL);
>  	if (ret)
>  		return ret;
> @@ -531,7 +519,6 @@ static int h264_encode_frame(struct venc_h264_inst *i=
nst,
>  	struct venc_frame_info frame_info;
>  	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> =20
> -	mtk_vcodec_debug_enter(inst);
>  	mtk_vcodec_debug(inst, "frm_cnt =3D %d\n ", inst->frm_cnt);
> =20
>  	if (MTK_ENC_IOVA_IS_34BIT(ctx)) {
> @@ -614,8 +601,6 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
>  	inst->vpu_inst.id =3D is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
>  	inst->hw_base =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VEN=
C_SYS);
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	ret =3D vpu_enc_init(&inst->vpu_inst);
> =20
>  	if (MTK_ENC_IOVA_IS_34BIT(ctx))
> @@ -623,8 +608,6 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
>  	else
>  		inst->vsi =3D (struct venc_h264_vsi *)inst->vpu_inst.vsi;
> =20
> -	mtk_vcodec_debug_leave(inst);
> -
>  	if (ret)
>  		kfree(inst);
>  	else
> @@ -811,8 +794,6 @@ static int h264_enc_set_param(void *handle,
>  		break;
>  	}
> =20
> -	mtk_vcodec_debug_leave(inst);
> -
>  	return ret;
>  }
> =20
> @@ -821,14 +802,11 @@ static int h264_enc_deinit(void *handle)
>  	int ret =3D 0;
>  	struct venc_h264_inst *inst =3D (struct venc_h264_inst *)handle;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	ret =3D vpu_enc_deinit(&inst->vpu_inst);
> =20
>  	if (inst->work_buf_allocated)
>  		h264_enc_free_work_buf(inst);
> =20
> -	mtk_vcodec_debug_leave(inst);
>  	kfree(inst);
> =20
>  	return ret;
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> index 73ebc35d7c99..ddcdb565db17 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> @@ -141,16 +141,12 @@ static void vp8_enc_free_work_buf(struct venc_vp8_i=
nst *inst)
>  {
>  	int i;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	/* Buffers need to be freed by AP. */
>  	for (i =3D 0; i < VENC_VP8_VPU_WORK_BUF_MAX; i++) {
>  		if (inst->work_bufs[i].size =3D=3D 0)
>  			continue;
>  		mtk_vcodec_mem_free(inst->ctx, &inst->work_bufs[i]);
>  	}
> -
> -	mtk_vcodec_debug_leave(inst);
>  }
> =20
>  static int vp8_enc_alloc_work_buf(struct venc_vp8_inst *inst)
> @@ -159,8 +155,6 @@ static int vp8_enc_alloc_work_buf(struct venc_vp8_ins=
t *inst)
>  	int ret =3D 0;
>  	struct venc_vp8_vpu_buf *wb =3D inst->vsi->work_bufs;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	for (i =3D 0; i < VENC_VP8_VPU_WORK_BUF_MAX; i++) {
>  		if (wb[i].size =3D=3D 0)
>  			continue;
> @@ -206,8 +200,6 @@ static int vp8_enc_alloc_work_buf(struct venc_vp8_ins=
t *inst)
>  				 inst->work_bufs[i].size);
>  	}
> =20
> -	mtk_vcodec_debug_leave(inst);
> -
>  	return ret;
> =20
>  err_alloc:
> @@ -338,14 +330,10 @@ static int vp8_enc_init(struct mtk_vcodec_ctx *ctx)
>  	inst->vpu_inst.id =3D IPI_VENC_VP8;
>  	inst->hw_base =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VEN=
C_LT_SYS);
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	ret =3D vpu_enc_init(&inst->vpu_inst);
> =20
>  	inst->vsi =3D (struct venc_vp8_vsi *)inst->vpu_inst.vsi;
> =20
> -	mtk_vcodec_debug_leave(inst);
> -
>  	if (ret)
>  		kfree(inst);
>  	else
> @@ -364,8 +352,6 @@ static int vp8_enc_encode(void *handle,
>  	struct venc_vp8_inst *inst =3D (struct venc_vp8_inst *)handle;
>  	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	enable_irq(ctx->dev->enc_irq);
> =20
>  	switch (opt) {
> @@ -386,8 +372,6 @@ static int vp8_enc_encode(void *handle,
>  encode_err:
> =20
>  	disable_irq(ctx->dev->enc_irq);
> -	mtk_vcodec_debug_leave(inst);
> -
>  	return ret;
>  }
> =20
> @@ -437,8 +421,6 @@ static int vp8_enc_set_param(void *handle,
>  		break;
>  	}
> =20
> -	mtk_vcodec_debug_leave(inst);
> -
>  	return ret;
>  }
> =20
> @@ -447,16 +429,12 @@ static int vp8_enc_deinit(void *handle)
>  	int ret =3D 0;
>  	struct venc_vp8_inst *inst =3D (struct venc_vp8_inst *)handle;
> =20
> -	mtk_vcodec_debug_enter(inst);
> -
>  	ret =3D vpu_enc_deinit(&inst->vpu_inst);
> =20
>  	if (inst->work_buf_allocated)
>  		vp8_enc_free_work_buf(inst);
> =20
> -	mtk_vcodec_debug_leave(inst);
>  	kfree(inst);
> -
>  	return ret;
>  }
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drive=
rs/media/platform/mediatek/vcodec/venc_vpu_if.c
> index 09e7eaa25aab..63ebab28242c 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> @@ -55,8 +55,10 @@ static void vpu_enc_ipi_handler(void *data, unsigned i=
nt len, void *priv)
> =20
>  	vpu->signaled =3D 1;
>  	vpu->failure =3D (msg->status !=3D VENC_IPI_MSG_STATUS_OK);
> -	if (vpu->failure)
> -		goto failure;
> +	if (vpu->failure) {
> +		mtk_vcodec_err(vpu, "vpu enc status failure %d", vpu->failure);
> +		return;
> +	}
> =20
>  	switch (msg->msg_id) {
>  	case VPU_IPIMSG_ENC_INIT_DONE:
> @@ -73,9 +75,6 @@ static void vpu_enc_ipi_handler(void *data, unsigned in=
t len, void *priv)
>  		mtk_vcodec_err(vpu, "unknown msg id %x", msg->msg_id);
>  		break;
>  	}
> -
> -failure:
> -	mtk_vcodec_debug_leave(vpu);
>  }
> =20
>  static int vpu_enc_send_msg(struct venc_vpu_inst *vpu, void *msg,
> @@ -83,8 +82,6 @@ static int vpu_enc_send_msg(struct venc_vpu_inst *vpu, =
void *msg,
>  {
>  	int status;
> =20
> -	mtk_vcodec_debug_enter(vpu);
> -
>  	if (!vpu->ctx->dev->fw_handler) {
>  		mtk_vcodec_err(vpu, "inst dev is NULL");
>  		return -EINVAL;
> @@ -100,8 +97,6 @@ static int vpu_enc_send_msg(struct venc_vpu_inst *vpu,=
 void *msg,
>  	if (vpu->failure)
>  		return -EINVAL;
> =20
> -	mtk_vcodec_debug_leave(vpu);
> -
>  	return 0;
>  }
> =20
> @@ -110,8 +105,6 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
>  	int status;
>  	struct venc_ap_ipi_msg_init out;
> =20
> -	mtk_vcodec_debug_enter(vpu);
> -
>  	init_waitqueue_head(&vpu->wq_hd);
>  	vpu->signaled =3D 0;
>  	vpu->failure =3D 0;
> @@ -132,8 +125,6 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
>  		return -EINVAL;
>  	}
> =20
> -	mtk_vcodec_debug_leave(vpu);
> -
>  	return 0;
>  }
> =20
> @@ -345,8 +336,6 @@ int vpu_enc_deinit(struct venc_vpu_inst *vpu)
>  {
>  	struct venc_ap_ipi_msg_deinit out;
> =20
> -	mtk_vcodec_debug_enter(vpu);
> -
>  	memset(&out, 0, sizeof(out));
>  	out.msg_id =3D AP_IPIMSG_ENC_DEINIT;
>  	out.vpu_inst_addr =3D vpu->inst_addr;
> @@ -355,7 +344,5 @@ int vpu_enc_deinit(struct venc_vpu_inst *vpu)
>  		return -EINVAL;
>  	}
> =20
> -	mtk_vcodec_debug_leave(vpu);
> -
>  	return 0;
>  }

