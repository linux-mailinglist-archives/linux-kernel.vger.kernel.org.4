Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0986DFA93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDLPu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDLPux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:50:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D3C9F;
        Wed, 12 Apr 2023 08:50:51 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01F4766003AD;
        Wed, 12 Apr 2023 16:50:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681314650;
        bh=Kr9eM4ReoDsZ1oycbBSjm3l4Wp1MoPhLd/UTlYKD7wU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GABNZrmSHIk9bW8tWQDh3CriS+FqgNTfa8bmif4IQoYn/C9AXgjxfLUyIeQ1oQQqq
         o4aau2aQ/T7bTkNC33E0twXnSxBIEkm/n7H5c+BDEPtbnfmN64rrsv23Liwnw7C0vx
         9q6PB3zFvB+bx0ti58gtFCYtDsi4cTwuhw+Ryt1XbjZVzrOenWhPQW30broN7bzbVN
         5mccKheI/4EQfphrh4nVzRLx7Svf/OetRaL8sDcV2WVU/sbTsbZFQKVPp2OVZVPfk+
         9l4dmMSd/92/pChg0ry9GMLTVws89UVtQUYbfpAasFFi1abq00qB1BwRYgdPA0GVQU
         xMRwcRH0saMWQ==
Message-ID: <0dbdaef5940481b52ec33dacb6a1fe9ad4d0271c.camel@collabora.com>
Subject: Re: [PATCH v6 12/13] media: verisilicon: Enable AV1 decoder on
 rk3588
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Wed, 12 Apr 2023 11:50:39 -0400
In-Reply-To: <2f946887-6d4b-782b-d186-13b184207be3@xs4all.nl>
References: <20230412115652.403949-1-benjamin.gaignard@collabora.com>
         <20230412115652.403949-13-benjamin.gaignard@collabora.com>
         <2f946887-6d4b-782b-d186-13b184207be3@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 12 avril 2023 =C3=A0 14:43 +0200, Hans Verkuil a =C3=A9crit=C2=
=A0:
> Hi Benjamin,
>=20
> On 12/04/2023 13:56, Benjamin Gaignard wrote:
> > Add rk3588 AV1 decoder to Hantro variant.
> > The hardware support image from 64x64 up to 7680x4320
> > by steps of 16 pixels.
> >=20
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>=20
> Nicolas reviewed this patch in v5. Is there a reason that tag was dropped=
,
> or did you just forget? If it is the latter, then I can add it back.
>=20
>=20

I see that NV12_10LE40_4L4 is now NV15_4L4 as agreed, and don't see any oth=
er
changes.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>=20
> Just checking.
>=20
> This series now passes my tests.
>=20
> Regards,
>=20
> 	Hans
>=20
> > ---
> >  .../media/platform/verisilicon/hantro_drv.c   |   1 +
> >  .../media/platform/verisilicon/hantro_hw.h    |   6 +
> >  .../platform/verisilicon/rockchip_vpu_hw.c    | 134 ++++++++++++++++++
> >  3 files changed, 141 insertions(+)
> >=20
> > diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/=
media/platform/verisilicon/hantro_drv.c
> > index 71bd68e63859..aef1de20fc5e 100644
> > --- a/drivers/media/platform/verisilicon/hantro_drv.c
> > +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> > @@ -713,6 +713,7 @@ static const struct of_device_id of_hantro_match[] =
=3D {
> >  	{ .compatible =3D "rockchip,rk3399-vpu", .data =3D &rk3399_vpu_varian=
t, },
> >  	{ .compatible =3D "rockchip,rk3568-vepu", .data =3D &rk3568_vepu_vari=
ant, },
> >  	{ .compatible =3D "rockchip,rk3568-vpu", .data =3D &rk3568_vpu_varian=
t, },
> > +	{ .compatible =3D "rockchip,rk3588-av1-vpu", .data =3D &rk3588_vpu981=
_variant, },
> >  #endif
> >  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
> >  	{ .compatible =3D "nxp,imx8mm-vpu-g1", .data =3D &imx8mm_vpu_g1_varia=
nt, },
> > diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/m=
edia/platform/verisilicon/hantro_hw.h
> > index e3d303cea7f6..7f33f7b07ce4 100644
> > --- a/drivers/media/platform/verisilicon/hantro_hw.h
> > +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> > @@ -403,11 +403,13 @@ extern const struct hantro_variant rk3328_vpu_var=
iant;
> >  extern const struct hantro_variant rk3399_vpu_variant;
> >  extern const struct hantro_variant rk3568_vepu_variant;
> >  extern const struct hantro_variant rk3568_vpu_variant;
> > +extern const struct hantro_variant rk3588_vpu981_variant;
> >  extern const struct hantro_variant sama5d4_vdec_variant;
> >  extern const struct hantro_variant sunxi_vpu_variant;
> > =20
> >  extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
> >  extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
> > +extern const struct hantro_postproc_ops rockchip_vpu981_postproc_ops;
> > =20
> >  extern const u32 hantro_vp8_dec_mc_filter[8][6];
> > =20
> > @@ -444,6 +446,10 @@ void hantro_hevc_ref_init(struct hantro_ctx *ctx);
> >  dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
> >  int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_=
t addr);
> > =20
> > +int rockchip_vpu981_av1_dec_init(struct hantro_ctx *ctx);
> > +void rockchip_vpu981_av1_dec_exit(struct hantro_ctx *ctx);
> > +int rockchip_vpu981_av1_dec_run(struct hantro_ctx *ctx);
> > +void rockchip_vpu981_av1_dec_done(struct hantro_ctx *ctx);
> > =20
> >  static inline unsigned short hantro_vp9_num_sbs(unsigned short dimensi=
on)
> >  {
> > diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/dri=
vers/media/platform/verisilicon/rockchip_vpu_hw.c
> > index 8de6fd2e8eef..816ffa905a4b 100644
> > --- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> > +++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> > @@ -13,9 +13,13 @@
> >  #include "hantro_g1_regs.h"
> >  #include "hantro_h1_regs.h"
> >  #include "rockchip_vpu2_regs.h"
> > +#include "rockchip_vpu981_regs.h"
> > =20
> >  #define RK3066_ACLK_MAX_FREQ (300 * 1000 * 1000)
> >  #define RK3288_ACLK_MAX_FREQ (400 * 1000 * 1000)
> > +#define RK3588_ACLK_MAX_FREQ (300 * 1000 * 1000)
> > +
> > +#define ROCKCHIP_VPU981_MIN_SIZE 64
> > =20
> >  /*
> >   * Supported formats.
> > @@ -74,6 +78,37 @@ static const struct hantro_fmt rockchip_vpu1_postpro=
c_fmts[] =3D {
> >  	},
> >  };
> > =20
> > +static const struct hantro_fmt rockchip_vpu981_postproc_fmts[] =3D {
> > +	{
> > +		.fourcc =3D V4L2_PIX_FMT_NV12,
> > +		.codec_mode =3D HANTRO_MODE_NONE,
> > +		.match_depth =3D true,
> > +		.postprocessed =3D true,
> > +		.frmsize =3D {
> > +			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,
> > +			.max_width =3D FMT_UHD_WIDTH,
> > +			.step_width =3D MB_DIM,
> > +			.min_height =3D ROCKCHIP_VPU981_MIN_SIZE,
> > +			.max_height =3D FMT_UHD_HEIGHT,
> > +			.step_height =3D MB_DIM,
> > +		},
> > +	},
> > +	{
> > +		.fourcc =3D V4L2_PIX_FMT_P010,
> > +		.codec_mode =3D HANTRO_MODE_NONE,
> > +		.match_depth =3D true,
> > +		.postprocessed =3D true,
> > +		.frmsize =3D {
> > +			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,
> > +			.max_width =3D FMT_UHD_WIDTH,
> > +			.step_width =3D MB_DIM,
> > +			.min_height =3D ROCKCHIP_VPU981_MIN_SIZE,
> > +			.max_height =3D FMT_UHD_HEIGHT,
> > +			.step_height =3D MB_DIM,
> > +		},
> > +	},
> > +};
> > +
> >  static const struct hantro_fmt rk3066_vpu_dec_fmts[] =3D {
> >  	{
> >  		.fourcc =3D V4L2_PIX_FMT_NV12,
> > @@ -277,6 +312,48 @@ static const struct hantro_fmt rk3399_vpu_dec_fmts=
[] =3D {
> >  	},
> >  };
> > =20
> > +static const struct hantro_fmt rockchip_vpu981_dec_fmts[] =3D {
> > +	{
> > +		.fourcc =3D V4L2_PIX_FMT_NV12_4L4,
> > +		.codec_mode =3D HANTRO_MODE_NONE,
> > +		.match_depth =3D true,
> > +		.frmsize =3D {
> > +			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,
> > +			.max_width =3D FMT_UHD_WIDTH,
> > +			.step_width =3D MB_DIM,
> > +			.min_height =3D ROCKCHIP_VPU981_MIN_SIZE,
> > +			.max_height =3D FMT_UHD_HEIGHT,
> > +			.step_height =3D MB_DIM,
> > +		},
> > +	},
> > +	{
> > +		.fourcc =3D V4L2_PIX_FMT_NV15_4L4,
> > +		.codec_mode =3D HANTRO_MODE_NONE,
> > +		.match_depth =3D true,
> > +		.frmsize =3D {
> > +			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,
> > +			.max_width =3D FMT_UHD_WIDTH,
> > +			.step_width =3D MB_DIM,
> > +			.min_height =3D ROCKCHIP_VPU981_MIN_SIZE,
> > +			.max_height =3D FMT_UHD_HEIGHT,
> > +			.step_height =3D MB_DIM,
> > +		},
> > +	},
> > +	{
> > +		.fourcc =3D V4L2_PIX_FMT_AV1_FRAME,
> > +		.codec_mode =3D HANTRO_MODE_AV1_DEC,
> > +		.max_depth =3D 2,
> > +		.frmsize =3D {
> > +			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,
> > +			.max_width =3D FMT_UHD_WIDTH,
> > +			.step_width =3D MB_DIM,
> > +			.min_height =3D ROCKCHIP_VPU981_MIN_SIZE,
> > +			.max_height =3D FMT_UHD_HEIGHT,
> > +			.step_height =3D MB_DIM,
> > +		},
> > +	},
> > +};
> > +
> >  static irqreturn_t rockchip_vpu1_vepu_irq(int irq, void *dev_id)
> >  {
> >  	struct hantro_dev *vpu =3D dev_id;
> > @@ -331,6 +408,24 @@ static irqreturn_t rockchip_vpu2_vepu_irq(int irq,=
 void *dev_id)
> >  	return IRQ_HANDLED;
> >  }
> > =20
> > +static irqreturn_t rk3588_vpu981_irq(int irq, void *dev_id)
> > +{
> > +	struct hantro_dev *vpu =3D dev_id;
> > +	enum vb2_buffer_state state;
> > +	u32 status;
> > +
> > +	status =3D vdpu_read(vpu, AV1_REG_INTERRUPT);
> > +	state =3D (status & AV1_REG_INTERRUPT_DEC_RDY_INT) ?
> > +		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
> > +
> > +	vdpu_write(vpu, 0, AV1_REG_INTERRUPT);
> > +	vdpu_write(vpu, AV1_REG_CONFIG_DEC_CLK_GATE_E, AV1_REG_CONFIG);
> > +
> > +	hantro_irq_done(vpu, state);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static int rk3036_vpu_hw_init(struct hantro_dev *vpu)
> >  {
> >  	/* Bump ACLK to max. possible freq. to improve performance. */
> > @@ -346,6 +441,13 @@ static int rk3066_vpu_hw_init(struct hantro_dev *v=
pu)
> >  	return 0;
> >  }
> > =20
> > +static int rk3588_vpu981_hw_init(struct hantro_dev *vpu)
> > +{
> > +	/* Bump ACLKs to max. possible freq. to improve performance. */
> > +	clk_set_rate(vpu->clocks[0].clk, RK3588_ACLK_MAX_FREQ);
> > +	return 0;
> > +}
> > +
> >  static int rockchip_vpu_hw_init(struct hantro_dev *vpu)
> >  {
> >  	/* Bump ACLK to max. possible freq. to improve performance. */
> > @@ -498,6 +600,14 @@ static const struct hantro_codec_ops rk3568_vepu_c=
odec_ops[] =3D {
> >  	},
> >  };
> > =20
> > +static const struct hantro_codec_ops rk3588_vpu981_codec_ops[] =3D {
> > +	[HANTRO_MODE_AV1_DEC] =3D {
> > +		.run =3D rockchip_vpu981_av1_dec_run,
> > +		.init =3D rockchip_vpu981_av1_dec_init,
> > +		.exit =3D rockchip_vpu981_av1_dec_exit,
> > +		.done =3D rockchip_vpu981_av1_dec_done,
> > +	},
> > +};
> >  /*
> >   * VPU variant.
> >   */
> > @@ -529,10 +639,18 @@ static const char * const rk3066_vpu_clk_names[] =
=3D {
> >  	"aclk_vepu", "hclk_vepu"
> >  };
> > =20
> > +static const struct hantro_irq rk3588_vpu981_irqs[] =3D {
> > +	{ "vdpu", rk3588_vpu981_irq },
> > +};
> > +
> >  static const char * const rockchip_vpu_clk_names[] =3D {
> >  	"aclk", "hclk"
> >  };
> > =20
> > +static const char * const rk3588_vpu981_vpu_clk_names[] =3D {
> > +	"aclk", "hclk", "aclk_vdpu_root", "hclk_vdpu_root"
> > +};
> > +
> >  /* VDPU1/VEPU1 */
> > =20
> >  const struct hantro_variant rk3036_vpu_variant =3D {
> > @@ -678,3 +796,19 @@ const struct hantro_variant px30_vpu_variant =3D {
> >  	.clk_names =3D rockchip_vpu_clk_names,
> >  	.num_clocks =3D ARRAY_SIZE(rockchip_vpu_clk_names)
> >  };
> > +
> > +const struct hantro_variant rk3588_vpu981_variant =3D {
> > +	.dec_offset =3D 0x0,
> > +	.dec_fmts =3D rockchip_vpu981_dec_fmts,
> > +	.num_dec_fmts =3D ARRAY_SIZE(rockchip_vpu981_dec_fmts),
> > +	.postproc_fmts =3D rockchip_vpu981_postproc_fmts,
> > +	.num_postproc_fmts =3D ARRAY_SIZE(rockchip_vpu981_postproc_fmts),
> > +	.postproc_ops =3D &rockchip_vpu981_postproc_ops,
> > +	.codec =3D HANTRO_AV1_DECODER,
> > +	.codec_ops =3D rk3588_vpu981_codec_ops,
> > +	.irqs =3D rk3588_vpu981_irqs,
> > +	.num_irqs =3D ARRAY_SIZE(rk3588_vpu981_irqs),
> > +	.init =3D rk3588_vpu981_hw_init,
> > +	.clk_names =3D rk3588_vpu981_vpu_clk_names,
> > +	.num_clocks =3D ARRAY_SIZE(rk3588_vpu981_vpu_clk_names)
> > +};
>=20
>=20

