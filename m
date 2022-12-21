Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C73C65340B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiLUQbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiLUQbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:31:01 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1D424098
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:30:54 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id c14so10682847qvq.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBRXLS3nSt+N5xcQVFi1/7nCs+femxk6z9geEHLL9HQ=;
        b=iEA3FEM0usIluhLcwm08S5s4MNJtGhq6JazYbKxPAmkuYZ2ZH6OW5fLlGMXI2A8HZM
         YLz6r6Agb/Dm62qyFGa1BnipjIfXzgaRMuHWE6s6VXP5MiZKvQhvMUBfrZzvtrQ9Mnz0
         FuXV1xtTQ3NGQO+w1uIE2FuS/1UV8qFoTCnb/vaK5JYeSP/RCUVvrW9HGmwFNcWxOenD
         6HEOj3HDfbnlhr+FSAKrqm4y+mFJSz6b/m9EFG1Mr8G0zQ82i9141wI3qRBKkjyXasvp
         EWYmtbtQNRdkaWKUZhJ48lUvNAwarjXLur4LR8Q71MjjcFCCx2k/teVkWV2/DvJ1xprN
         SlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBRXLS3nSt+N5xcQVFi1/7nCs+femxk6z9geEHLL9HQ=;
        b=P79B4k8NxxwfMp4skolUvR6SbGjzTpYxM4RFpLwenZ6iut3G2uaXIjG/On5eJ5/XjR
         /+UoxooLh+mAGVj2AKRlN4nOJZdeDqPJ3RDzgYhDkDmiTRcYIMjTMyG3xM3k5p8nm/KS
         QWNpHeq3OERfwan2owq1c1BCc0J9tddCm/FHiXulD3aSkGMMnrm5pLq5oKp3bqcc19Mc
         ej+UGxVF0Xc/vbWlJBWVda4japtTYKltzXSbh4lu1p2sod4t0u4lZpqGo8WRVofsxrwt
         RG10bpVaVbIzAV8RjG6PllyKXJ8IQZaKE7G1jBefQFZnMw0gG9eo5LADQJCOnIQIjAsF
         MFkg==
X-Gm-Message-State: AFqh2krI/STYzPctWFu+MJgJI9z9pB7bNRf+uCArsYTMO4Zz3xwLHsU3
        PB7p3I0gxCmO6Cthga8LYjiZpA==
X-Google-Smtp-Source: AMrXdXvh3mUoxjjeWrGoMutUVMSDI+jfrDIvq0ezMgc6aCy8g0d/OxKnYm1k6i59obGXTnPINLxI0w==
X-Received: by 2002:a05:6214:380b:b0:523:8f54:2704 with SMTP id ns11-20020a056214380b00b005238f542704mr3671409qvb.4.1671640252884;
        Wed, 21 Dec 2022 08:30:52 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id t18-20020a05620a451200b006b5cc25535fsm7305696qkp.99.2022.12.21.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 08:30:52 -0800 (PST)
Message-ID: <4afdce546b2f10cf97e12f8325232483efeea1ce.camel@ndufresne.ca>
Subject: Re: [PATCH v1 7/9] media: verisilicon: Add Rockchip AV1 decoder
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Wed, 21 Dec 2022 11:30:50 -0500
In-Reply-To: <be1ff517-765d-c97f-8cce-3f359cd0015c@collabora.com>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
         <20221219155616.848690-8-benjamin.gaignard@collabora.com>
         <092f76873a914c52c5157a21401be6cf78e3f188.camel@ndufresne.ca>
         <be1ff517-765d-c97f-8cce-3f359cd0015c@collabora.com>
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

Le mardi 20 d=C3=A9cembre 2022 =C3=A0 15:49 +0100, Benjamin Gaignard a =C3=
=A9crit=C2=A0:
> Le 19/12/2022 =C3=A0 22:56, Nicolas Dufresne a =C3=A9crit=C2=A0:
> > Le lundi 19 d=C3=A9cembre 2022 =C3=A0 16:56 +0100, Benjamin Gaignard a =
=C3=A9crit=C2=A0:
> > > Implement AV1 stateless decoder for rockchip VPU981.
> > > It decode 8 and 10 bits AV1 bitstreams.
> > > AV1 scaling feature is done by the postprocessor.
> > Can you clarify ? I knew the filmgrain was, but didn't expect spatial s=
caling to
> > need it. On this aspect, I don't see any new code to let Hantro driver =
know that
> > the postproc is needed. The frame header value should be taken into acc=
ount in
> > hantro_needs_postproc() (a per codec ops would be nice).
>=20
> 2 tests (av1-1-b8-03-sizedown and av1-1-b8-03-sizeup) are only working if=
 the postprocessor
> is used. Given their names I assume it is related to scaling.

I can take care of investigating what these stream do, and how the postproc
could save them. These are not SVC, so there is no reference scaling. But I
think to find exactly what they do to comment more.

> Force postprocessing is not an easy task in Hantro driver and this series=
 is already big enough.
>=20
> What I have prototype to solve this problem is to add a "need_postproc" f=
ield in context structure
> but I still have issues around pixel format negotiation to solve before r=
elease it.
>=20
> >=20
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > ---
> > >   drivers/media/platform/verisilicon/Makefile   |    1 +
> > >   .../media/platform/verisilicon/hantro_hw.h    |   64 +-
> > >   .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2067 ++++++++++++++=
+++
> > >   .../verisilicon/rockchip_vpu981_regs.h        |  477 ++++
> > >   4 files changed, 2607 insertions(+), 2 deletions(-)
> > >   create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu9=
81_hw_av1_dec.c
> > >   create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu9=
81_regs.h
> > >=20
> > > diff --git a/drivers/media/platform/verisilicon/Makefile b/drivers/me=
dia/platform/verisilicon/Makefile
> > > index d2b2679c00eb..c9a9806ab8c5 100644
> > > --- a/drivers/media/platform/verisilicon/Makefile
> > > +++ b/drivers/media/platform/verisilicon/Makefile
> > > @@ -18,6 +18,7 @@ hantro-vpu-y +=3D \
> > >   		rockchip_vpu2_hw_h264_dec.o \
> > >   		rockchip_vpu2_hw_mpeg2_dec.o \
> > >   		rockchip_vpu2_hw_vp8_dec.o \
> > > +		rockchip_vpu981_hw_av1_dec.o \
> > >   		rockchip_av1_entropymode.o \
> > >   		hantro_jpeg.o \
> > >   		hantro_h264.o \
> > > diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers=
/media/platform/verisilicon/hantro_hw.h
> > > index e395aeeae2f4..3c0a995998a5 100644
> > > --- a/drivers/media/platform/verisilicon/hantro_hw.h
> > > +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> > > @@ -37,6 +37,9 @@
> > >  =20
> > >   #define NUM_REF_PICTURES	(V4L2_HEVC_DPB_ENTRIES_NUM_MAX + 1)
> > >  =20
> > > +#define AV1_REF_LIST_SIZE	8
> > This is the same as V4L2_AV1_TOTAL_REFS_PER_FRAME. AV1_TOTAL_REFS_PER_F=
RAME is
> > how this is called in the spec.
>=20
> ok
>=20
> >=20
> > > +#define AV1_MAX_FRAME_BUF_COUNT	(V4L2_AV1_TOTAL_REFS_PER_FRAME + 1)
> > > +
> > >   struct hantro_dev;
> > >   struct hantro_ctx;
> > >   struct hantro_buf;
> > > @@ -250,23 +253,80 @@ struct hantro_vp9_dec_hw_ctx {
> > >   };
> > >  =20
> > >   /**
> > > - * hantro_av1_dec_hw_ctx
> > > + * struct hantro_av1_dec_ctrls
> > > + * @sequence:		AV1 Sequence
> > > + * @tile_group_entry:	AV1 Tile Group entry
> > > + * @frame:		AV1 Frame Header OBU
> > > + * @film_grain:		AV1 Film Grain
> > > + */
> > > +struct hantro_av1_dec_ctrls {
> > > +	const struct v4l2_ctrl_av1_sequence *sequence;
> > > +	const struct v4l2_ctrl_av1_tile_group_entry *tile_group_entry;
> > > +	const struct v4l2_ctrl_av1_frame *frame;
> > > +	const struct v4l2_ctrl_av1_film_grain *film_grain;
> > > +};
> > > +
> > > +struct hantro_av1_frame_ref {
> > > +	int width;
> > > +	int height;
> > > +	u64 timestamp;
> > > +	enum v4l2_av1_frame_type frame_type;
> > > +	int ref_count;
> > > +	u32 order_hint;
> > > +	u32 order_hints[V4L2_AV1_NUM_REF_FRAMES];
> > > +	int gm_mode;
> > > +	struct vb2_v4l2_buffer *vb2_ref;
> > > +};
> > > +
> > > +/**
> > > + * struct hantro_av1_dec_hw_ctx
> > > + * @db_data_col:	db tile col data buffer
> > > + * @db_ctrl_col:	db tile col ctrl buffer
> > > + * @cdef_col:		cdef tile col buffer
> > > + * @sr_col:		sr tile col buffer
> > > + * @lr_col:		lr tile col buffer
> > > + * @global_model:	global model buffer
> > > + * @tile_info:		tile info buffer
> > > + * @segment:		segmentation info buffer
> > > + * @prob_tbl:		probability table
> > > + * @prob_tbl_out:	probability table output
> > > + * @tile_buf:		tile buffer
> > > + * @ctrls:		V4L2 controls attached to a run
> > > + * @frame_refs:		reference frames info slots
> > > + * @ref_frame_sign_bias: array of sign bias
> > > + * @num_tile_cols_allocated: number of allocated tiles
> > >    * @cdfs:		current probabilities structure
> > >    * @cdfs_ndvc:		current mv probabilities structure
> > >    * @default_cdfs:	default probabilities structure
> > >    * @default_cdfs_ndvc:	default mv probabilties structure
> > >    * @cdfs_last:		stored probabilities structures
> > >    * @cdfs_last_ndvc:	stored mv probabilities structures
> > > + * @current_frame_index: index of the current in frame_refs array
> > >    */
> > >   struct hantro_av1_dec_hw_ctx {
> > > +	struct hantro_aux_buf db_data_col;
> > > +	struct hantro_aux_buf db_ctrl_col;
> > > +	struct hantro_aux_buf cdef_col;
> > > +	struct hantro_aux_buf sr_col;
> > > +	struct hantro_aux_buf lr_col;
> > > +	struct hantro_aux_buf global_model;
> > > +	struct hantro_aux_buf tile_info;
> > > +	struct hantro_aux_buf segment;
> > > +	struct hantro_aux_buf prob_tbl;
> > > +	struct hantro_aux_buf prob_tbl_out;
> > > +	struct hantro_aux_buf tile_buf;
> > > +	struct hantro_av1_dec_ctrls ctrls;
> > > +	struct hantro_av1_frame_ref frame_refs[AV1_MAX_FRAME_BUF_COUNT];
> > > +	uint32_t ref_frame_sign_bias[AV1_REF_LIST_SIZE];
> > > +	unsigned int num_tile_cols_allocated;
> > >   	struct av1cdfs *cdfs;
> > >   	struct mvcdfs  *cdfs_ndvc;
> > >   	struct av1cdfs default_cdfs;
> > >   	struct mvcdfs  default_cdfs_ndvc;
> > >   	struct av1cdfs cdfs_last[NUM_REF_FRAMES];
> > >   	struct mvcdfs  cdfs_last_ndvc[NUM_REF_FRAMES];
> > > +	int current_frame_index;
> > >   };
> > > -
> > >   /**
> > >    * struct hantro_postproc_ctx
> > >    *
> > > diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av=
1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
> > > new file mode 100644
> > > index 000000000000..a183e4f35e00
> > > --- /dev/null
> > > +++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
> > > @@ -0,0 +1,2067 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2021, Collabora
> > > + *
> > > + * Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > + */
> > > +
> > > +#include <media/v4l2-mem2mem.h>
> > > +#include "hantro.h"
> > > +#include "hantro_v4l2.h"
> > > +#include "rockchip_vpu981_regs.h"
> > > +
> > > +#define AV1_DEC_MODE		17
> > > +#define GM_GLOBAL_MODELS_PER_FRAME	7
> > > +#define GLOBAL_MODEL_TOTAL_SIZE	(6 * 4 + 4 * 2)
> > > +#define GLOBAL_MODEL_SIZE	ALIGN(GM_GLOBAL_MODELS_PER_FRAME * GLOBAL_=
MODEL_TOTAL_SIZE, 2048)
> > > +#define AV1_MAX_TILES		128
> > > +#define AV1_TILE_INFO_SIZE	(AV1_MAX_TILES * 16)
> > > +#define AV1DEC_MAX_PIC_BUFFERS	24
> > > +#define AV1_REF_SCALE_SHIFT	14
> > > +#define AV1_INVALID_IDX		-1
> > > +#define MAX_FRAME_DISTANCE	31
> > > +#define AV1_PRIMARY_REF_NONE	7
> > > +#define AV1_TILE_SIZE		ALIGN(32 * 128, 4096)
> > > +/*
> > > + * These 3 values aren't defined enum v4l2_av1_segment_feature becau=
se
> > > + * they are not part of the specification
> > > + */
> > > +#define V4L2_AV1_SEG_LVL_ALT_LF_Y_H	2
> > > +#define V4L2_AV1_SEG_LVL_ALT_LF_U	3
> > > +#define V4L2_AV1_SEG_LVL_ALT_LF_V	4
> > > +
> > > +#define CLIP3(l, h, v)      ((v) < (l) ? (l) : ((v) > (h) ? (h) : (v=
)))
> > include/linux/minmax.h:#define clamp(val, lo, hi) min((typeof(val))max(=
val, lo), hi)
>=20
> ok I will remove it
>=20
> >=20
> > > +
> > > +#define SUPERRES_SCALE_BITS 3
> > > +#define SCALE_NUMERATOR 8
> > > +#define SUPERRES_SCALE_DENOMINATOR_MIN (SCALE_NUMERATOR + 1)
> > > +
> > > +#define RS_SUBPEL_BITS 6
> > > +#define RS_SUBPEL_MASK ((1 << RS_SUBPEL_BITS) - 1)
> > > +#define RS_SCALE_SUBPEL_BITS 14
> > > +#define RS_SCALE_SUBPEL_MASK ((1 << RS_SCALE_SUBPEL_BITS) - 1)
> > > +#define RS_SCALE_EXTRA_BITS (RS_SCALE_SUBPEL_BITS - RS_SUBPEL_BITS)
> > > +#define RS_SCALE_EXTRA_OFF (1 << (RS_SCALE_EXTRA_BITS - 1))
> > > +
> > > +#define IS_INTRA(type) ((type =3D=3D V4L2_AV1_KEY_FRAME) || (type =
=3D=3D V4L2_AV1_INTRA_ONLY_FRAME))
> > > +
> > > +#define LST_BUF_IDX (V4L2_AV1_REF_LAST_FRAME - V4L2_AV1_REF_LAST_FRA=
ME)
> > > +#define LST2_BUF_IDX (V4L2_AV1_REF_LAST2_FRAME - V4L2_AV1_REF_LAST_F=
RAME)
> > > +#define LST3_BUF_IDX (V4L2_AV1_REF_LAST3_FRAME - V4L2_AV1_REF_LAST_F=
RAME)
> > > +#define GLD_BUF_IDX (V4L2_AV1_REF_GOLDEN_FRAME - V4L2_AV1_REF_LAST_F=
RAME)
> > > +#define BWD_BUF_IDX (V4L2_AV1_REF_BWDREF_FRAME - V4L2_AV1_REF_LAST_F=
RAME)
> > > +#define ALT2_BUF_IDX (V4L2_AV1_REF_ALTREF2_FRAME - V4L2_AV1_REF_LAST=
_FRAME)
> > > +#define ALT_BUF_IDX (V4L2_AV1_REF_ALTREF_FRAME - V4L2_AV1_REF_LAST_F=
RAME)
> > > +
> > > +#define DIV_LUT_PREC_BITS 14
> > > +#define DIV_LUT_BITS 8
> > > +#define DIV_LUT_NUM BIT(DIV_LUT_BITS)
> > > +#define WARP_PARAM_REDUCE_BITS 6
> > > +#define WARPEDMODEL_PREC_BITS 16
> > > +
> > > +#define AV1_DIV_ROUND_UP_POW2(value, n)			\
> > > +({							\
> > > +	typeof(n) _n  =3D n;				\
> > > +	typeof(value) _value =3D value;			\
> > > +	(_value + (BIT(_n) >> 1)) >> _n;		\
> > > +})
> > > +
> > > +#define AV1_DIV_ROUND_UP_POW2_SIGNED(value, n)				\
> > > +({									\
> > > +	typeof(n) _n_  =3D n;						\
> > > +	typeof(value) _value_ =3D value;					\
> > > +	(((_value_) < 0) ? -AV1_DIV_ROUND_UP_POW2(-(_value_), (_n_))	\
> > > +		: AV1_DIV_ROUND_UP_POW2((_value_), (_n_)));		\
> > > +})
> > > +
> > > +struct rockchip_av1_film_grain {
> > > +	uint8_t scaling_lut_y[256];
> > > +	uint8_t scaling_lut_cb[256];
> > > +	uint8_t scaling_lut_cr[256];
> > > +	int16_t cropped_luma_grain_block[4096];
> > > +	int16_t cropped_chroma_grain_block[1024 * 2];
> > > +};
> > > +
> > > +static const short div_lut[DIV_LUT_NUM + 1] =3D {
> > > +	16384, 16320, 16257, 16194, 16132, 16070, 16009, 15948, 15888, 1582=
8, 15768,
> > > +	15709, 15650, 15592, 15534, 15477, 15420, 15364, 15308, 15252, 1519=
7, 15142,
> > > +	15087, 15033, 14980, 14926, 14873, 14821, 14769, 14717, 14665, 1461=
4, 14564,
> > > +	14513, 14463, 14413, 14364, 14315, 14266, 14218, 14170, 14122, 1407=
5, 14028,
> > > +	13981, 13935, 13888, 13843, 13797, 13752, 13707, 13662, 13618, 1357=
4, 13530,
> > > +	13487, 13443, 13400, 13358, 13315, 13273, 13231, 13190, 13148, 1310=
7, 13066,
> > > +	13026, 12985, 12945, 12906, 12866, 12827, 12788, 12749, 12710, 1267=
2, 12633,
> > > +	12596, 12558, 12520, 12483, 12446, 12409, 12373, 12336, 12300, 1226=
4, 12228,
> > > +	12193, 12157, 12122, 12087, 12053, 12018, 11984, 11950, 11916, 1188=
2, 11848,
> > > +	11815, 11782, 11749, 11716, 11683, 11651, 11619, 11586, 11555, 1152=
3, 11491,
> > > +	11460, 11429, 11398, 11367, 11336, 11305, 11275, 11245, 11215, 1118=
5, 11155,
> > > +	11125, 11096, 11067, 11038, 11009, 10980, 10951, 10923, 10894, 1086=
6, 10838,
> > > +	10810, 10782, 10755, 10727, 10700, 10673, 10645, 10618, 10592, 1056=
5, 10538,
> > > +	10512, 10486, 10460, 10434, 10408, 10382, 10356, 10331, 10305, 1028=
0, 10255,
> > > +	10230, 10205, 10180, 10156, 10131, 10107, 10082, 10058, 10034, 1001=
0, 9986,
> > > +	9963,  9939,  9916,  9892,  9869,  9846,  9823,  9800,  9777,  9754=
,  9732,
> > > +	9709,  9687,  9664,  9642,  9620,  9598,  9576,  9554,  9533,  9511=
,  9489,
> > > +	9468,  9447,  9425,  9404,  9383,  9362,  9341,  9321,  9300,  9279=
,  9259,
> > > +	9239,  9218,  9198,  9178,  9158,  9138,  9118,  9098,  9079,  9059=
,  9039,
> > > +	9020,  9001,  8981,  8962,  8943,  8924,  8905,  8886,  8867,  8849=
,  8830,
> > > +	8812,  8793,  8775,  8756,  8738,  8720,  8702,  8684,  8666,  8648=
,  8630,
> > > +	8613,  8595,  8577,  8560,  8542,  8525,  8508,  8490,  8473,  8456=
,  8439,
> > > +	8422,  8405,  8389,  8372,  8355,  8339,  8322,  8306,  8289,  8273=
,  8257,
> > > +	8240,  8224,  8208,  8192,
> > > +};
> > > +
> > > +static int rockchip_vpu981_get_frame_index(struct hantro_ctx *ctx, i=
nt ref)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	u64 timestamp;
> > > +	int i, idx =3D frame->ref_frame_idx[ref];
> > > +
> > > +	if (idx >=3D AV1_MAX_FRAME_BUF_COUNT || idx < 0)
> > > +		return AV1_INVALID_IDX;
> > > +
> > > +	timestamp =3D frame->reference_frame_ts[idx];
> > > +	for (i =3D 0; i < AV1_MAX_FRAME_BUF_COUNT; i++) {
> > > +		if (av1_dec->frame_refs[i].ref_count =3D=3D 0)
> > > +			continue;
> > > +		if (av1_dec->frame_refs[i].timestamp =3D=3D timestamp)
> > > +			return i;
> > > +	}
> > nit: Mediatek optimize this with a map
> >=20
> > > +
> > > +	return AV1_INVALID_IDX;
> > > +}
> > > +
> > > +static int rockchip_vpu981_get_order_hint(struct hantro_ctx *ctx, in=
t ref)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	int idx =3D rockchip_vpu981_get_frame_index(ctx, ref);
> > > +
> > > +	if (idx !=3D AV1_INVALID_IDX)
> > > +		return av1_dec->frame_refs[idx].order_hint;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int rockchip_vpu981_av1_dec_frame_ref(struct hantro_ctx *ctx,
> > > +					     u64 timestamp)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < AV1_MAX_FRAME_BUF_COUNT; i++) {
> > > +		if (av1_dec->frame_refs[i].ref_count =3D=3D 0) {
> > > +			int j;
> > > +
> > > +			av1_dec->frame_refs[i].width =3D
> > > +			    frame->frame_width_minus_1 + 1;
> > > +			av1_dec->frame_refs[i].height =3D
> > > +			    frame->frame_height_minus_1 + 1;
> > > +			av1_dec->frame_refs[i].timestamp =3D timestamp;
> > > +			av1_dec->frame_refs[i].frame_type =3D frame->frame_type;
> > > +			av1_dec->frame_refs[i].order_hint =3D frame->order_hint;
> > > +			av1_dec->frame_refs[i].gm_mode =3D
> > > +				frame->global_motion.type[V4L2_AV1_REF_LAST_FRAME + i];
> > > +			if (!av1_dec->frame_refs[i].vb2_ref)
> > > +				av1_dec->frame_refs[i].vb2_ref =3D hantro_get_dst_buf(ctx);
> > > +
> > > +			for (j =3D 0; j < V4L2_AV1_NUM_REF_FRAMES; j++)
> > > +				av1_dec->frame_refs[i].order_hints[j] =3D frame->order_hints[j];
> > > +
> > > +			av1_dec->frame_refs[i].ref_count++;
> > This ref_count is only ever 0 and 1. Would be nicer if it was some bool=
ean, like
> > "valid", or "active".
>=20
> I will change it to "bool used;"
>=20
> >=20
> > > +			av1_dec->current_frame_index =3D i;
> > > +			return i;
> > > +		}
> > > +	}
> > > +
> > > +	return AV1_INVALID_IDX;
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_frame_unref(struct hantro_ctx *c=
tx, int idx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +
> > > +	if (idx < 0)
> > > +		return;
> > > +
> > > +	av1_dec->frame_refs[idx].ref_count--;
> > > +
> > > +	if (av1_dec->frame_refs[idx].ref_count < 0)
> > > +		pr_warn("AV1 reference frames refcounting error (idx %d)\n", idx);
> > Looks like a bug_on case, only driver programming issue could cause thi=
s.
>=20
> I have never hit it, I will remove it.
>=20
> >=20
> >=20
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_clean_refs(struct hantro_ctx *ct=
x)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +
> > > +	int ref, idx;
> > > +
> > > +	for (idx =3D 0; idx < AV1_MAX_FRAME_BUF_COUNT; idx++) {
> > > +		u64 timestamp =3D av1_dec->frame_refs[idx].timestamp;
> > > +		bool used =3D false;
> > > +
> > > +		if (av1_dec->frame_refs[idx].ref_count =3D=3D 0)
> > > +			continue;
> > > +
> > > +		for (ref =3D 0; ref < V4L2_AV1_TOTAL_REFS_PER_FRAME; ref++) {
> > > +			if (ctrls->frame->reference_frame_ts[ref] =3D=3D timestamp)
> > > +				used =3D true;
> > > +		}
> > > +
> > > +		if (!used)
> > > +			rockchip_vpu981_av1_dec_frame_unref(ctx, idx);
> > > +	}
> > > +}
> > > +
> > > +static size_t rockchip_vpu981_av1_dec_luma_size(struct hantro_ctx *c=
tx)
> > > +{
> > > +	return ctx->dst_fmt.width * ctx->dst_fmt.height * ctx->bit_depth / =
8;
> > > +}
> > > +
> > > +static size_t rockchip_vpu981_av1_dec_chroma_size(struct hantro_ctx =
*ctx)
> > > +{
> > > +	size_t cr_offset =3D rockchip_vpu981_av1_dec_luma_size(ctx);
> > > +
> > > +	return ALIGN((cr_offset * 3) / 2, 64);
> > > +}
> > > +
> > > +void rockchip_vpu981_av1_dec_tiles_free(struct hantro_ctx *ctx)
> > > +{
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +
> > > +	if (av1_dec->db_data_col.cpu)
> > > +		dma_free_coherent(vpu->dev, av1_dec->db_data_col.size,
> > > +				  av1_dec->db_data_col.cpu,
> > > +				  av1_dec->db_data_col.dma);
> > > +	av1_dec->db_data_col.cpu =3D NULL;
> > > +
> > > +	if (av1_dec->db_ctrl_col.cpu)
> > > +		dma_free_coherent(vpu->dev, av1_dec->db_ctrl_col.size,
> > > +				  av1_dec->db_ctrl_col.cpu,
> > > +				  av1_dec->db_ctrl_col.dma);
> > > +	av1_dec->db_ctrl_col.cpu =3D NULL;
> > > +
> > > +	if (av1_dec->cdef_col.cpu)
> > > +		dma_free_coherent(vpu->dev, av1_dec->cdef_col.size,
> > > +				  av1_dec->cdef_col.cpu, av1_dec->cdef_col.dma);
> > > +	av1_dec->cdef_col.cpu =3D NULL;
> > > +
> > > +	if (av1_dec->sr_col.cpu)
> > > +		dma_free_coherent(vpu->dev, av1_dec->sr_col.size,
> > > +				  av1_dec->sr_col.cpu, av1_dec->sr_col.dma);
> > > +	av1_dec->sr_col.cpu =3D NULL;
> > > +
> > > +	if (av1_dec->lr_col.cpu)
> > > +		dma_free_coherent(vpu->dev, av1_dec->lr_col.size,
> > > +				  av1_dec->lr_col.cpu, av1_dec->lr_col.dma);
> > > +	av1_dec->lr_col.cpu =3D NULL;
> > > +}
> > > +
> > > +static int rockchip_vpu981_av1_dec_tiles_reallocate(struct hantro_ct=
x *ctx)
> > > +{
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	unsigned int num_tile_cols =3D 1 << ctrls->tile_group_entry->tile_c=
ol;
> > > +	unsigned int height =3D ALIGN(ctrls->frame->frame_height_minus_1 + =
1, 64);
> > > +	unsigned int height_in_sb =3D height / 64;
> > > +	unsigned int stripe_num =3D ((height + 8) + 63) / 64;
> > > +	size_t size;
> > > +
> > > +	if (num_tile_cols <=3D av1_dec->num_tile_cols_allocated)
> > > +		return 0;
> > > +
> > > +	rockchip_vpu981_av1_dec_tiles_free(ctx);
> > > +
> > > +	size =3D ALIGN(height * 12 * ctx->bit_depth / 8, 128) * num_tile_co=
ls;
> > > +	av1_dec->db_data_col.cpu =3D dma_alloc_coherent(vpu->dev, size,
> > > +						      &av1_dec->db_data_col.dma,
> > > +						      GFP_KERNEL);
> > > +	if (!av1_dec->db_data_col.cpu)
> > > +		goto buffer_allocation_error;
> > > +	av1_dec->db_data_col.size =3D size;
> > > +
> > > +	size =3D ALIGN(height * 2 * 16 / 4, 128) * num_tile_cols;
> > No bit_depth scaling ?
>=20
> No, MPP code doesn't scale this one depending in bit_depth.
>=20
> >=20
> > > +	av1_dec->db_ctrl_col.cpu =3D dma_alloc_coherent(vpu->dev, size,
> > > +						      &av1_dec->db_ctrl_col.dma,
> > > +						      GFP_KERNEL);
> > > +	if (!av1_dec->db_ctrl_col.cpu)
> > > +		goto buffer_allocation_error;
> > > +	av1_dec->db_ctrl_col.size =3D size;
> > > +
> > > +	size =3D ALIGN(height_in_sb * 44 * ctx->bit_depth * 16 / 8, 128) * =
num_tile_cols;
> > > +	av1_dec->cdef_col.cpu =3D dma_alloc_coherent(vpu->dev, size,
> > > +						   &av1_dec->cdef_col.dma,
> > > +						   GFP_KERNEL);
> > > +	if (!av1_dec->cdef_col.cpu)
> > > +		goto buffer_allocation_error;
> > > +	av1_dec->cdef_col.size =3D size;
> > > +
> > > +	size =3D ALIGN(height_in_sb * (3040 + 1280), 128) * num_tile_cols;
> > > +	av1_dec->sr_col.cpu =3D dma_alloc_coherent(vpu->dev, size,
> > > +						 &av1_dec->sr_col.dma,
> > > +						 GFP_KERNEL);
> > > +	if (!av1_dec->sr_col.cpu)
> > > +		goto buffer_allocation_error;
> > > +	av1_dec->sr_col.size =3D size;
> > > +
> > > +	size =3D ALIGN(stripe_num * 1536 * ctx->bit_depth / 8, 128) * num_t=
ile_cols;
> > > +	av1_dec->lr_col.cpu =3D dma_alloc_coherent(vpu->dev, size,
> > > +						 &av1_dec->lr_col.dma,
> > > +						 GFP_KERNEL);
> > > +	if (!av1_dec->lr_col.cpu)
> > > +		goto buffer_allocation_error;
> > > +	av1_dec->lr_col.size =3D size;
> > > +
> > > +	av1_dec->num_tile_cols_allocated =3D num_tile_cols;
> > > +	return 0;
> > > +
> > > +buffer_allocation_error:
> > > +	rockchip_vpu981_av1_dec_tiles_free(ctx);
> > > +	return -ENOMEM;
> > > +}
> > > +
> > > +void rockchip_vpu981_av1_dec_exit(struct hantro_ctx *ctx)
> > > +{
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +
> > > +	if (av1_dec->global_model.cpu)
> > > +		dma_free_coherent(vpu->dev, av1_dec->global_model.size,
> > > +				  av1_dec->global_model.cpu,
> > > +				  av1_dec->global_model.dma);
> > > +	av1_dec->global_model.cpu =3D NULL;
> > > +
> > > +	if (av1_dec->tile_info.cpu)
> > > +		dma_free_coherent(vpu->dev, av1_dec->tile_info.size,
> > > +				  av1_dec->tile_info.cpu,
> > > +				  av1_dec->tile_info.dma);
> > > +	av1_dec->tile_info.cpu =3D NULL;
> > > +
> > > +	if (av1_dec->prob_tbl.cpu)
> > > +		dma_free_coherent(vpu->dev, av1_dec->prob_tbl.size,
> > > +				  av1_dec->prob_tbl.cpu, av1_dec->prob_tbl.dma);
> > > +	av1_dec->prob_tbl.cpu =3D NULL;
> > > +
> > > +	if (av1_dec->prob_tbl_out.cpu)
> > > +		dma_free_coherent(vpu->dev, av1_dec->prob_tbl_out.size,
> > > +				  av1_dec->prob_tbl_out.cpu,
> > > +				  av1_dec->prob_tbl_out.dma);
> > > +	av1_dec->prob_tbl_out.cpu =3D NULL;
> > > +
> > > +	if (av1_dec->tile_buf.cpu)
> > > +		dma_free_coherent(vpu->dev, av1_dec->tile_buf.size,
> > > +				  av1_dec->tile_buf.cpu, av1_dec->tile_buf.dma);
> > > +	av1_dec->tile_buf.cpu =3D NULL;
> > > +
> > > +	rockchip_vpu981_av1_dec_tiles_free(ctx);
> > > +}
> > > +
> > > +int rockchip_vpu981_av1_dec_init(struct hantro_ctx *ctx)
> > > +{
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +
> > > +	memset(av1_dec, 0, sizeof(*av1_dec));
> > > +
> > > +	av1_dec->global_model.cpu =3D dma_alloc_coherent(vpu->dev, GLOBAL_M=
ODEL_SIZE,
> > > +						       &av1_dec->global_model.dma,
> > > +						       GFP_KERNEL);
> > > +	if (!av1_dec->global_model.cpu)
> > > +		return -ENOMEM;
> > > +	av1_dec->global_model.size =3D GLOBAL_MODEL_SIZE;
> > > +
> > > +	av1_dec->tile_info.cpu =3D dma_alloc_coherent(vpu->dev, AV1_MAX_TIL=
ES,
> > > +						    &av1_dec->tile_info.dma,
> > > +						    GFP_KERNEL);
> > > +	if (!av1_dec->tile_info.cpu)
> > > +		return -ENOMEM;
> > > +	av1_dec->tile_info.size =3D AV1_MAX_TILES;
> > > +
> > > +	av1_dec->prob_tbl.cpu =3D dma_alloc_coherent(vpu->dev,
> > > +						   ALIGN(sizeof(struct av1cdfs), 2048),
> > > +						   &av1_dec->prob_tbl.dma,
> > > +						   GFP_KERNEL);
> > > +	if (!av1_dec->prob_tbl.cpu)
> > > +		return -ENOMEM;
> > > +	av1_dec->prob_tbl.size =3D ALIGN(sizeof(struct av1cdfs), 2048);
> > > +
> > > +	av1_dec->prob_tbl_out.cpu =3D dma_alloc_coherent(vpu->dev,
> > > +						       ALIGN(sizeof(struct av1cdfs), 2048),
> > > +						       &av1_dec->prob_tbl_out.dma,
> > > +						       GFP_KERNEL);
> > > +	if (!av1_dec->prob_tbl_out.cpu)
> > > +		return -ENOMEM;
> > > +	av1_dec->prob_tbl_out.size =3D ALIGN(sizeof(struct av1cdfs), 2048);
> > > +	av1_dec->cdfs =3D &av1_dec->default_cdfs;
> > > +	av1_dec->cdfs_ndvc =3D &av1_dec->default_cdfs_ndvc;
> > > +
> > > +	rockchip_av1_set_default_cdfs(av1_dec->cdfs, av1_dec->cdfs_ndvc);
> > > +
> > > +	av1_dec->tile_buf.cpu =3D dma_alloc_coherent(vpu->dev,
> > > +						   AV1_TILE_SIZE,
> > > +						   &av1_dec->tile_buf.dma,
> > > +						   GFP_KERNEL);
> > > +	if (!av1_dec->tile_buf.cpu)
> > > +		return -ENOMEM;
> > > +	av1_dec->tile_buf.size =3D AV1_TILE_SIZE;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int rockchip_vpu981_av1_dec_prepare_run(struct hantro_ctx *ct=
x)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +
> > > +	ctrls->sequence =3D hantro_get_ctrl(ctx, V4L2_CID_STATELESS_AV1_SEQ=
UENCE);
> > > +	if (WARN_ON(!ctrls->sequence))
> > > +		return -EINVAL;
> > > +
> > > +	ctrls->tile_group_entry =3D
> > > +	    hantro_get_ctrl(ctx, V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY);
> > > +	if (WARN_ON(!ctrls->tile_group_entry))
> > > +		return -EINVAL;
> > > +
> > > +	ctrls->frame =3D hantro_get_ctrl(ctx, V4L2_CID_STATELESS_AV1_FRAME)=
;
> > > +	if (WARN_ON(!ctrls->frame))
> > > +		return -EINVAL;
> > > +
> > > +	ctrls->film_grain =3D
> > > +	    hantro_get_ctrl(ctx, V4L2_CID_STATELESS_AV1_FILM_GRAIN);
> > > +
> > > +	return rockchip_vpu981_av1_dec_tiles_reallocate(ctx);
> > > +}
> > > +
> > > +static inline int rockchip_vpu981_av1_dec_get_msb(u32 n)
> > > +{
> > > +	if (n =3D=3D 0)
> > > +		return 0;
> > > +	return 31 ^ __builtin_clz(n);
> > > +}
> > > +
> > > +static short rockchip_vpu981_av1_dec_resolve_divisor_32(u32 d, short=
 *shift)
> > > +{
> > > +	int f;
> > > +	uint64_t e;
> > > +
> > > +	*shift =3D rockchip_vpu981_av1_dec_get_msb(d);
> > > +	/* e is obtained from D after resetting the most significant 1 bit.=
 */
> > > +	e =3D d - ((u32)1 << *shift);
> > > +	/* Get the most significant DIV_LUT_BITS (8) bits of e into f */
> > > +	if (*shift > DIV_LUT_BITS)
> > > +		f =3D AV1_DIV_ROUND_UP_POW2(e, *shift - DIV_LUT_BITS);
> > > +	else
> > > +		f =3D e << (DIV_LUT_BITS - *shift);
> > > +	if (f > DIV_LUT_NUM)
> > > +		return -1;
> > > +	*shift +=3D DIV_LUT_PREC_BITS;
> > > +	/* Use f as lookup into the precomputed table of multipliers */
> > > +	return div_lut[f];
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_get_shear_params(const uint32_t =
*params,
> > > +	int64_t *alpha, int64_t *beta, int64_t *gamma, int64_t *delta)
> > > +{
> > > +	const int *mat =3D params;
> > > +	short shift;
> > > +	short y;
> > > +	long long gv, dv;
> > > +
> > > +	if (mat[2] <=3D 0)
> > > +		return;
> > > +
> > > +	*alpha =3D clamp_val(mat[2] - (1 << WARPEDMODEL_PREC_BITS), S16_MIN=
, S16_MAX);
> > > +	*beta =3D clamp_val(mat[3], S16_MIN, S16_MAX);
> > > +
> > > +	y =3D rockchip_vpu981_av1_dec_resolve_divisor_32(abs(mat[2]), &shif=
t) * (mat[2] < 0 ? -1 : 1);
> > > +
> > > +	gv =3D ((long long)mat[4] * (1 << WARPEDMODEL_PREC_BITS)) * y;
> > > +
> > > +	*gamma =3D clamp_val((int)AV1_DIV_ROUND_UP_POW2_SIGNED(gv, shift), =
S16_MIN, S16_MAX);
> > > +
> > > +	dv =3D ((long long)mat[3] * mat[4]) * y;
> > > +	*delta =3D clamp_val(
> > > +		mat[5] -
> > > +		(int)AV1_DIV_ROUND_UP_POW2_SIGNED(dv, shift) - (1 << WARPEDMODEL_P=
REC_BITS),
> > > +		S16_MIN, S16_MAX);
> > > +
> > > +	*alpha =3D AV1_DIV_ROUND_UP_POW2_SIGNED(*alpha, WARP_PARAM_REDUCE_B=
ITS)
> > > +		 * (1 << WARP_PARAM_REDUCE_BITS);
> > > +	*beta =3D AV1_DIV_ROUND_UP_POW2_SIGNED(*beta, WARP_PARAM_REDUCE_BIT=
S)
> > > +		* (1 << WARP_PARAM_REDUCE_BITS);
> > > +	*gamma =3D AV1_DIV_ROUND_UP_POW2_SIGNED(*gamma, WARP_PARAM_REDUCE_B=
ITS)
> > > +		 * (1 << WARP_PARAM_REDUCE_BITS);
> > > +	*delta =3D AV1_DIV_ROUND_UP_POW2_SIGNED(*delta, WARP_PARAM_REDUCE_B=
ITS)
> > > +		* (1 << WARP_PARAM_REDUCE_BITS);
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_global_model(struct hantro_c=
tx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	const struct v4l2_av1_global_motion *gm =3D &frame->global_motion;
> > > +	uint8_t *dst =3D av1_dec->global_model.cpu;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	int ref_frame, i;
> > > +
> > > +	memset(dst, 0, GLOBAL_MODEL_SIZE);
> > > +	for (ref_frame =3D 0; ref_frame < V4L2_AV1_REFS_PER_FRAME; ++ref_fr=
ame) {
> > > +		int64_t alpha =3D 0, beta =3D 0, gamma =3D 0, delta =3D 0;
> > > +
> > > +		for (i =3D 0; i < 6; ++i) {
> > > +			if (i =3D=3D 2)
> > > +				*(int32_t *)dst =3D
> > > +					gm->params[V4L2_AV1_REF_LAST_FRAME + ref_frame][3];
> > > +			else if (i =3D=3D 3)
> > > +				*(int32_t *)dst =3D
> > > +					gm->params[V4L2_AV1_REF_LAST_FRAME + ref_frame][2];
> > > +			else
> > > +				*(int32_t *)dst =3D
> > > +					gm->params[V4L2_AV1_REF_LAST_FRAME + ref_frame][i];
> > > +			dst +=3D 4;
> > > +		}
> > > +
> > > +		if (gm->type[V4L2_AV1_REF_LAST_FRAME + ref_frame] <=3D V4L2_AV1_WA=
RP_MODEL_AFFINE)
> > > +			rockchip_vpu981_av1_dec_get_shear_params(
> > > +					&gm->params[V4L2_AV1_REF_LAST_FRAME + ref_frame][0],
> > > +					&alpha, &beta, &gamma, &delta);
> > > +
> > > +		*(int16_t *)dst =3D alpha;
> > > +		dst +=3D 2;
> > > +		*(int16_t *)dst =3D beta;
> > > +		dst +=3D 2;
> > > +		*(int16_t *)dst =3D gamma;
> > > +		dst +=3D 2;
> > > +		*(int16_t *)dst =3D delta;
> > > +		dst +=3D 2;
> > > +	}
> > > +
> > > +	hantro_write_addr(vpu, AV1_GLOBAL_MODEL, av1_dec->global_model.dma)=
;
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_tile_info(struct hantro_ctx =
*ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	struct v4l2_av1_tile_info tile_info =3D ctrls->frame->tile_info;
> > > +	const struct v4l2_ctrl_av1_tile_group_entry *group_entry =3D
> > > +	    ctrls->tile_group_entry;
> > > +	int context_update_y =3D
> > > +	    tile_info.context_update_tile_id / tile_info.tile_cols;
> > > +	int context_update_x =3D
> > > +	    tile_info.context_update_tile_id % tile_info.tile_cols;
> > > +	int context_update_tile_id =3D
> > > +	    context_update_x * tile_info.tile_rows + context_update_y;
> > > +	uint8_t *dst =3D av1_dec->tile_info.cpu;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	int tile0, tile1;
> > > +
> > > +	memset(dst, 0, av1_dec->tile_info.size);
> > > +
> > > +	for (tile0 =3D 0; tile0 < tile_info.tile_cols; tile0++) {
> > > +		for (tile1 =3D 0; tile1 < tile_info.tile_rows; tile1++) {
> > > +			int tile_id =3D tile1 * tile_info.tile_cols + tile0;
> > > +			uint32_t start, end;
> > > +			uint32_t y0 =3D
> > > +			    tile_info.height_in_sbs_minus_1[tile1] + 1;
> > > +			uint32_t x0 =3D tile_info.width_in_sbs_minus_1[tile0] + 1;
> > > +
> > > +			// tile size in SB units (width,height)
> > > +			*dst++ =3D x0;
> > > +			*dst++ =3D 0;
> > > +			*dst++ =3D 0;
> > > +			*dst++ =3D 0;
> > > +			*dst++ =3D y0;
> > > +			*dst++ =3D 0;
> > > +			*dst++ =3D 0;
> > > +			*dst++ =3D 0;
> > > +
> > > +			// tile start position
> > > +			start =3D group_entry[tile_id].tile_offset - group_entry[0].tile_=
offset;
> > > +			*dst++ =3D start & 255;
> > > +			*dst++ =3D (start >> 8) & 255;
> > > +			*dst++ =3D (start >> 16) & 255;
> > > +			*dst++ =3D (start >> 24) & 255;
> > > +
> > > +			// # of bytes in tile data
> > > +			end =3D start + group_entry[tile_id].tile_size;
> > > +			*dst++ =3D end & 255;
> > > +			*dst++ =3D (end >> 8) & 255;
> > > +			*dst++ =3D (end >> 16) & 255;
> > > +			*dst++ =3D (end >> 24) & 255;
> > > +		}
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_multicore_expect_context_update,
> > > +			 !!(context_update_x =3D=3D 0));
> > > +	hantro_reg_write(vpu, &av1_tile_enable, !!((tile_info.tile_cols > 1=
)
> > > +						   || (tile_info.tile_rows > 1)));
> > > +	hantro_reg_write(vpu, &av1_num_tile_cols_8k, tile_info.tile_cols);
> > > +	hantro_reg_write(vpu, &av1_num_tile_rows_8k, tile_info.tile_rows);
> > > +	hantro_reg_write(vpu, &av1_context_update_tile_id,
> > > +			 context_update_tile_id);
> > > +	hantro_reg_write(vpu, &av1_tile_transpose, 1);
> > > +	if (context_update_tile_id) {
> > > +		hantro_reg_write(vpu, &av1_dec_tile_size_mag,
> > > +				 tile_info.tile_size_bytes);
> > > +	} else
> > > +		hantro_reg_write(vpu, &av1_dec_tile_size_mag, 3);
> > > +
> > > +	hantro_write_addr(vpu, AV1_TILE_BASE, av1_dec->tile_info.dma);
> > > +}
> > > +
> > > +static int rockchip_vpu981_av1_dec_get_relative_dist(struct hantro_c=
tx *ctx,
> > > +						     int a, int b)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	int bits =3D ctrls->sequence->order_hint_bits - 1;
> > > +	int diff, m;
> > > +
> > > +	if (!ctrls->sequence->order_hint_bits)
> > > +		return 0;
> > > +
> > > +	diff =3D a - b;
> > > +	m =3D 1 << bits;
> > > +	diff =3D (diff & (m - 1)) - (diff & m);
> > > +
> > > +	return diff;
> > > +}
> > I think I've seen this one in MTK. Will be nice to make a v4l2-av1.h ev=
entually
> > and share this. Can happen afterward though, to avoid make this too com=
plex.
>=20
> I will keep that in mind.
>=20
> >=20
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_frame_sign_bias(struct hantr=
o_ctx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	const struct v4l2_ctrl_av1_sequence *sequence =3D ctrls->sequence;
> > > +	int i;
> > > +
> > > +	if (!sequence->order_hint_bits || IS_INTRA(frame->frame_type)) {
> > > +		for (i =3D 0; i < AV1_REF_LIST_SIZE; i++)
> > > +			av1_dec->ref_frame_sign_bias[i] =3D 0;
> > > +
> > > +		return;
> > > +	}
> > > +	// Identify the nearest forward and backward references.
> > > +	for (i =3D 0; i < AV1_REF_LIST_SIZE - 1; i++) {
> > > +		if (rockchip_vpu981_get_frame_index(ctx, i) >=3D 0) {
> > > +			int rel_off =3D
> > > +			    rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +								      rockchip_vpu981_get_order_hint
> > > +								      (ctx, i),
> > > +								      frame->order_hint);
> > > +			av1_dec->ref_frame_sign_bias[i + 1] =3D (rel_off <=3D 0) ? 0 : 1;
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +static bool
> > > +rockchip_vpu981_av1_dec_set_ref(struct hantro_ctx *ctx, int ref, int=
 idx,
> > > +				int width, int height)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	struct hantro_decoded_buffer *dst;
> > > +	dma_addr_t luma_addr, chroma_addr, mv_addr =3D 0;
> > > +	size_t cr_offset =3D rockchip_vpu981_av1_dec_luma_size(ctx);
> > > +	size_t mv_offset =3D rockchip_vpu981_av1_dec_chroma_size(ctx);
> > > +	int cur_width =3D frame->frame_width_minus_1 + 1;
> > > +	int cur_height =3D frame->frame_height_minus_1 + 1;
> > > +	int scale_width =3D
> > > +	    ((width << AV1_REF_SCALE_SHIFT) + cur_width / 2) / cur_width;
> > > +	int scale_height =3D
> > > +	    ((height << AV1_REF_SCALE_SHIFT) + cur_height / 2) / cur_height=
;
> > > +
> > > +	switch (ref) {
> > > +	case 0:
> > > +		hantro_reg_write(vpu, &av1_ref0_height, height);
> > > +		hantro_reg_write(vpu, &av1_ref0_width, width);
> > > +		hantro_reg_write(vpu, &av1_ref0_ver_scale, scale_width);
> > > +		hantro_reg_write(vpu, &av1_ref0_hor_scale, scale_height);
> > > +		break;
> > > +	case 1:
> > > +		hantro_reg_write(vpu, &av1_ref1_height, height);
> > > +		hantro_reg_write(vpu, &av1_ref1_width, width);
> > > +		hantro_reg_write(vpu, &av1_ref1_ver_scale, scale_width);
> > > +		hantro_reg_write(vpu, &av1_ref1_hor_scale, scale_height);
> > > +		break;
> > > +	case 2:
> > > +		hantro_reg_write(vpu, &av1_ref2_height, height);
> > > +		hantro_reg_write(vpu, &av1_ref2_width, width);
> > > +		hantro_reg_write(vpu, &av1_ref2_ver_scale, scale_width);
> > > +		hantro_reg_write(vpu, &av1_ref2_hor_scale, scale_height);
> > > +		break;
> > > +	case 3:
> > > +		hantro_reg_write(vpu, &av1_ref3_height, height);
> > > +		hantro_reg_write(vpu, &av1_ref3_width, width);
> > > +		hantro_reg_write(vpu, &av1_ref3_ver_scale, scale_width);
> > > +		hantro_reg_write(vpu, &av1_ref3_hor_scale, scale_height);
> > > +		break;
> > > +	case 4:
> > > +		hantro_reg_write(vpu, &av1_ref4_height, height);
> > > +		hantro_reg_write(vpu, &av1_ref4_width, width);
> > > +		hantro_reg_write(vpu, &av1_ref4_ver_scale, scale_width);
> > > +		hantro_reg_write(vpu, &av1_ref4_hor_scale, scale_height);
> > > +		break;
> > > +	case 5:
> > > +		hantro_reg_write(vpu, &av1_ref5_height, height);
> > > +		hantro_reg_write(vpu, &av1_ref5_width, width);
> > > +		hantro_reg_write(vpu, &av1_ref5_ver_scale, scale_width);
> > > +		hantro_reg_write(vpu, &av1_ref5_hor_scale, scale_height);
> > > +		break;
> > > +	case 6:
> > > +		hantro_reg_write(vpu, &av1_ref6_height, height);
> > > +		hantro_reg_write(vpu, &av1_ref6_width, width);
> > > +		hantro_reg_write(vpu, &av1_ref6_ver_scale, scale_width);
> > > +		hantro_reg_write(vpu, &av1_ref6_hor_scale, scale_height);
> > > +		break;
> > > +	default:
> > > +		pr_warn("AV1 invalid reference frame index\n");
> > > +	}
> > > +
> > > +	dst =3D vb2_to_hantro_decoded_buf(&av1_dec->frame_refs[idx].vb2_ref=
->vb2_buf);
> > > +	luma_addr =3D hantro_get_dec_buf_addr(ctx, &dst->base.vb.vb2_buf);
> > > +	chroma_addr =3D luma_addr + cr_offset;
> > > +	mv_addr =3D luma_addr + mv_offset;
> > > +
> > > +	hantro_write_addr(vpu, AV1_REFERENCE_Y(ref), luma_addr);
> > > +	hantro_write_addr(vpu, AV1_REFERENCE_CB(ref), chroma_addr);
> > > +	hantro_write_addr(vpu, AV1_REFERENCE_MV(ref), mv_addr);
> > > +
> > > +	return (scale_width !=3D (1 << AV1_REF_SCALE_SHIFT))
> > > +		|| (scale_height !=3D (1 << AV1_REF_SCALE_SHIFT));
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_sign_bias(struct hantro_ctx =
*ctx,
> > > +						  int ref, int val)
> > > +{
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +
> > > +	switch (ref) {
> > > +	case 0:
> > > +		hantro_reg_write(vpu, &av1_ref0_sign_bias, val);
> > > +		break;
> > > +	case 1:
> > > +		hantro_reg_write(vpu, &av1_ref1_sign_bias, val);
> > > +		break;
> > > +	case 2:
> > > +		hantro_reg_write(vpu, &av1_ref2_sign_bias, val);
> > > +		break;
> > > +	case 3:
> > > +		hantro_reg_write(vpu, &av1_ref3_sign_bias, val);
> > > +		break;
> > > +	case 4:
> > > +		hantro_reg_write(vpu, &av1_ref4_sign_bias, val);
> > > +		break;
> > > +	case 5:
> > > +		hantro_reg_write(vpu, &av1_ref5_sign_bias, val);
> > > +		break;
> > > +	case 6:
> > > +		hantro_reg_write(vpu, &av1_ref6_sign_bias, val);
> > > +		break;
> > > +	default:
> > > +		pr_warn("AV1 invalid sign bias index\n");
> > > +		break;
> > > +	}
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_segmentation(struct hantro_c=
tx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	const struct v4l2_av1_segmentation *seg =3D &frame->segmentation;
> > > +	uint32_t segval[V4L2_AV1_MAX_SEGMENTS][V4L2_AV1_SEG_LVL_MAX] =3D { =
0 };
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	uint8_t segsign =3D 0, preskip_segid =3D 0, last_active_seg =3D 0, =
i, j;
> > > +
> > > +	if (!!(seg->flags & V4L2_AV1_SEGMENTATION_FLAG_ENABLED)
> > > +	    && (frame->primary_ref_frame < V4L2_AV1_REFS_PER_FRAME)) {
> > > +		int idx =3D rockchip_vpu981_get_frame_index(ctx, frame->primary_re=
f_frame);
> > > +
> > > +		if (idx >=3D 0) {
> > > +			dma_addr_t luma_addr, chroma_addr, mv_addr =3D 0;
> > > +			size_t cr_offset =3D rockchip_vpu981_av1_dec_luma_size(ctx);
> > > +			size_t mv_offset =3D rockchip_vpu981_av1_dec_chroma_size(ctx);
> > > +
> > > +			luma_addr =3D
> > > +				hantro_get_dec_buf_addr(ctx,
> > > +							&av1_dec->frame_refs[idx].vb2_ref->vb2_buf);
> > > +			chroma_addr =3D luma_addr + cr_offset;
> > > +			mv_addr =3D luma_addr + mv_offset;
> > > +
> > > +			hantro_write_addr(vpu, AV1_SEGMENTATION, mv_addr);
> > > +			hantro_reg_write(vpu, &av1_use_temporal3_mvs, 1);
> > > +		}
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_segment_temp_upd_e,
> > > +			 !!(seg->flags & V4L2_AV1_SEGMENTATION_FLAG_TEMPORAL_UPDATE));
> > > +	hantro_reg_write(vpu, &av1_segment_upd_e,
> > > +			 !!(seg->flags & V4L2_AV1_SEGMENTATION_FLAG_UPDATE_MAP));
> > > +	hantro_reg_write(vpu, &av1_segment_e,
> > > +			 !!(seg->flags & V4L2_AV1_SEGMENTATION_FLAG_ENABLED));
> > > +
> > > +	hantro_reg_write(vpu, &av1_error_resilient,
> > > +			 !!(frame->flags & V4L2_AV1_FRAME_FLAG_ERROR_RESILIENT_MODE));
> > > +
> > > +	if (IS_INTRA(frame->frame_type)
> > > +	    || !!(frame->flags & V4L2_AV1_FRAME_FLAG_ERROR_RESILIENT_MODE))=
 {
> > > +		hantro_reg_write(vpu, &av1_use_temporal3_mvs, 0);
> > > +	}
> > > +
> > > +	if (!!(seg->flags & V4L2_AV1_SEGMENTATION_FLAG_ENABLED)) {
> > > +		int s;
> > > +
> > > +		for (s =3D 0; s < V4L2_AV1_MAX_SEGMENTS; s++) {
> > > +			if (seg->feature_enabled[s] &
> > > +			    V4L2_AV1_SEGMENT_FEATURE_ENABLED(V4L2_AV1_SEG_LVL_ALT_Q)) {
> > > +				segval[s][V4L2_AV1_SEG_LVL_ALT_Q] =3D
> > > +				    CLIP3(0, 255,
> > > +					abs(seg->feature_data[s][V4L2_AV1_SEG_LVL_ALT_Q]));
> > > +				segsign |=3D
> > > +					(seg->feature_data[s][V4L2_AV1_SEG_LVL_ALT_Q] < 0) << s;
> > > +			}
> > > +
> > > +			if (seg->feature_enabled[s] &
> > > +			    V4L2_AV1_SEGMENT_FEATURE_ENABLED(V4L2_AV1_SEG_LVL_ALT_LF_Y_V)=
)
> > > +				segval[s][V4L2_AV1_SEG_LVL_ALT_LF_Y_V] =3D
> > > +					CLIP3(-63, 63,
> > > +					abs(seg->feature_data[s][V4L2_AV1_SEG_LVL_ALT_LF_Y_V]));
> > > +
> > > +			if (seg->feature_enabled[s] &
> > > +			    V4L2_AV1_SEGMENT_FEATURE_ENABLED(V4L2_AV1_SEG_LVL_ALT_LF_Y_H)=
)
> > > +				segval[s][V4L2_AV1_SEG_LVL_ALT_LF_Y_H] =3D
> > > +				    CLIP3(-63, 63,
> > > +					abs(seg->feature_data[s][V4L2_AV1_SEG_LVL_ALT_LF_Y_H]));
> > > +
> > > +			if (seg->feature_enabled[s] &
> > > +			    V4L2_AV1_SEGMENT_FEATURE_ENABLED(V4L2_AV1_SEG_LVL_ALT_LF_U))
> > > +				segval[s][V4L2_AV1_SEG_LVL_ALT_LF_U] =3D
> > > +				    CLIP3(-63, 63,
> > > +					abs(seg->feature_data[s][V4L2_AV1_SEG_LVL_ALT_LF_U]));
> > > +
> > > +			if (seg->feature_enabled[s] &
> > > +			    V4L2_AV1_SEGMENT_FEATURE_ENABLED(V4L2_AV1_SEG_LVL_ALT_LF_V))
> > > +				segval[s][V4L2_AV1_SEG_LVL_ALT_LF_V] =3D
> > > +				    CLIP3(-63, 63,
> > > +					abs(seg->feature_data[s][V4L2_AV1_SEG_LVL_ALT_LF_V]));
> > > +
> > > +			if (frame->frame_type && seg->feature_enabled[s] &
> > > +			    V4L2_AV1_SEGMENT_FEATURE_ENABLED(V4L2_AV1_SEG_LVL_REF_FRAME))
> > > +				segval[s][V4L2_AV1_SEG_LVL_REF_FRAME]++;
> > > +
> > > +			if (seg->feature_enabled[s] &
> > > +			    V4L2_AV1_SEGMENT_FEATURE_ENABLED(V4L2_AV1_SEG_LVL_REF_SKIP))
> > > +				segval[s][V4L2_AV1_SEG_LVL_REF_SKIP] =3D 1;
> > > +
> > > +			if (seg->feature_enabled[s] &
> > > +			    V4L2_AV1_SEGMENT_FEATURE_ENABLED(V4L2_AV1_SEG_LVL_REF_GLOBALM=
V))
> > > +				segval[s][V4L2_AV1_SEG_LVL_REF_GLOBALMV] =3D 1;
> > > +		}
> > > +	}
> > > +
> > > +	for (i =3D 0; i < V4L2_AV1_MAX_SEGMENTS; i++) {
> > > +		for (j =3D 0; j < V4L2_AV1_SEG_LVL_MAX; j++) {
> > > +			if (seg->feature_enabled[i]
> > > +			    & V4L2_AV1_SEGMENT_FEATURE_ENABLED(j)) {
> > > +				preskip_segid |=3D (j >=3D V4L2_AV1_SEG_LVL_REF_FRAME);
> > > +				last_active_seg =3D max(i, last_active_seg);
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_last_active_seg, last_active_seg);
> > > +	hantro_reg_write(vpu, &av1_preskip_segid, preskip_segid);
> > > +
> > > +	hantro_reg_write(vpu, &av1_seg_quant_sign, segsign);
> > > +
> > > +	/* Write QP, filter level, ref frame and skip for every segment */
> > > +	hantro_reg_write(vpu, &av1_quant_seg0,
> > > +			 segval[0][V4L2_AV1_SEG_LVL_ALT_Q]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta0_seg0,
> > > +			 segval[0][V4L2_AV1_SEG_LVL_ALT_LF_Y_V]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta1_seg0,
> > > +			 segval[0][V4L2_AV1_SEG_LVL_ALT_LF_Y_H]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta2_seg0,
> > > +			 segval[0][V4L2_AV1_SEG_LVL_ALT_LF_U]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta3_seg0,
> > > +			 segval[0][V4L2_AV1_SEG_LVL_ALT_LF_V]);
> > > +	hantro_reg_write(vpu, &av1_refpic_seg0,
> > > +			 segval[0][V4L2_AV1_SEG_LVL_REF_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_skip_seg0,
> > > +			 segval[0][V4L2_AV1_SEG_LVL_REF_SKIP]);
> > > +	hantro_reg_write(vpu, &av1_global_mv_seg0,
> > > +			 segval[0][V4L2_AV1_SEG_LVL_REF_GLOBALMV]);
> > > +
> > > +	hantro_reg_write(vpu, &av1_quant_seg1,
> > > +			 segval[1][V4L2_AV1_SEG_LVL_ALT_Q]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta0_seg1,
> > > +			 segval[1][V4L2_AV1_SEG_LVL_ALT_LF_Y_V]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta1_seg1,
> > > +			 segval[1][V4L2_AV1_SEG_LVL_ALT_LF_Y_H]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta2_seg1,
> > > +			 segval[1][V4L2_AV1_SEG_LVL_ALT_LF_U]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta3_seg1,
> > > +			 segval[1][V4L2_AV1_SEG_LVL_ALT_LF_V]);
> > > +	hantro_reg_write(vpu, &av1_refpic_seg1,
> > > +			 segval[1][V4L2_AV1_SEG_LVL_REF_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_skip_seg1,
> > > +			 segval[1][V4L2_AV1_SEG_LVL_REF_SKIP]);
> > > +	hantro_reg_write(vpu, &av1_global_mv_seg1,
> > > +			 segval[1][V4L2_AV1_SEG_LVL_REF_GLOBALMV]);
> > > +
> > > +	hantro_reg_write(vpu, &av1_quant_seg2,
> > > +			 segval[2][V4L2_AV1_SEG_LVL_ALT_Q]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta0_seg2,
> > > +			 segval[2][V4L2_AV1_SEG_LVL_ALT_LF_Y_V]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta1_seg2,
> > > +			 segval[2][V4L2_AV1_SEG_LVL_ALT_LF_Y_H]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta2_seg2,
> > > +			 segval[2][V4L2_AV1_SEG_LVL_ALT_LF_U]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta3_seg2,
> > > +			 segval[2][V4L2_AV1_SEG_LVL_ALT_LF_V]);
> > > +	hantro_reg_write(vpu, &av1_refpic_seg2,
> > > +			 segval[2][V4L2_AV1_SEG_LVL_REF_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_skip_seg2,
> > > +			 segval[2][V4L2_AV1_SEG_LVL_REF_SKIP]);
> > > +	hantro_reg_write(vpu, &av1_global_mv_seg2,
> > > +			 segval[2][V4L2_AV1_SEG_LVL_REF_GLOBALMV]);
> > > +
> > > +	hantro_reg_write(vpu, &av1_quant_seg3,
> > > +			 segval[3][V4L2_AV1_SEG_LVL_ALT_Q]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta0_seg3,
> > > +			 segval[3][V4L2_AV1_SEG_LVL_ALT_LF_Y_V]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta1_seg3,
> > > +			 segval[3][V4L2_AV1_SEG_LVL_ALT_LF_Y_H]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta2_seg3,
> > > +			 segval[3][V4L2_AV1_SEG_LVL_ALT_LF_U]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta3_seg3,
> > > +			 segval[3][V4L2_AV1_SEG_LVL_ALT_LF_V]);
> > > +	hantro_reg_write(vpu, &av1_refpic_seg3,
> > > +			 segval[3][V4L2_AV1_SEG_LVL_REF_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_skip_seg3,
> > > +			 segval[3][V4L2_AV1_SEG_LVL_REF_SKIP]);
> > > +	hantro_reg_write(vpu, &av1_global_mv_seg3,
> > > +			 segval[3][V4L2_AV1_SEG_LVL_REF_GLOBALMV]);
> > > +
> > > +	hantro_reg_write(vpu, &av1_quant_seg4,
> > > +			 segval[4][V4L2_AV1_SEG_LVL_ALT_Q]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta0_seg4,
> > > +			 segval[4][V4L2_AV1_SEG_LVL_ALT_LF_Y_V]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta1_seg4,
> > > +			 segval[4][V4L2_AV1_SEG_LVL_ALT_LF_Y_H]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta2_seg4,
> > > +			 segval[4][V4L2_AV1_SEG_LVL_ALT_LF_U]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta3_seg4,
> > > +			 segval[4][V4L2_AV1_SEG_LVL_ALT_LF_V]);
> > > +	hantro_reg_write(vpu, &av1_refpic_seg4,
> > > +			 segval[4][V4L2_AV1_SEG_LVL_REF_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_skip_seg4,
> > > +			 segval[4][V4L2_AV1_SEG_LVL_REF_SKIP]);
> > > +	hantro_reg_write(vpu, &av1_global_mv_seg4,
> > > +			 segval[4][V4L2_AV1_SEG_LVL_REF_GLOBALMV]);
> > > +
> > > +	hantro_reg_write(vpu, &av1_quant_seg5,
> > > +			 segval[5][V4L2_AV1_SEG_LVL_ALT_Q]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta0_seg5,
> > > +			 segval[5][V4L2_AV1_SEG_LVL_ALT_LF_Y_V]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta1_seg5,
> > > +			 segval[5][V4L2_AV1_SEG_LVL_ALT_LF_Y_H]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta2_seg5,
> > > +			 segval[5][V4L2_AV1_SEG_LVL_ALT_LF_U]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta3_seg5,
> > > +			 segval[5][V4L2_AV1_SEG_LVL_ALT_LF_V]);
> > > +	hantro_reg_write(vpu, &av1_refpic_seg5,
> > > +			 segval[5][V4L2_AV1_SEG_LVL_REF_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_skip_seg5,
> > > +			 segval[5][V4L2_AV1_SEG_LVL_REF_SKIP]);
> > > +	hantro_reg_write(vpu, &av1_global_mv_seg5,
> > > +			 segval[5][V4L2_AV1_SEG_LVL_REF_GLOBALMV]);
> > > +
> > > +	hantro_reg_write(vpu, &av1_quant_seg6,
> > > +			 segval[6][V4L2_AV1_SEG_LVL_ALT_Q]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta0_seg6,
> > > +			 segval[6][V4L2_AV1_SEG_LVL_ALT_LF_Y_V]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta1_seg6,
> > > +			 segval[6][V4L2_AV1_SEG_LVL_ALT_LF_Y_H]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta2_seg6,
> > > +			 segval[6][V4L2_AV1_SEG_LVL_ALT_LF_U]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta3_seg6,
> > > +			 segval[6][V4L2_AV1_SEG_LVL_ALT_LF_V]);
> > > +	hantro_reg_write(vpu, &av1_refpic_seg6,
> > > +			 segval[6][V4L2_AV1_SEG_LVL_REF_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_skip_seg6,
> > > +			 segval[6][V4L2_AV1_SEG_LVL_REF_SKIP]);
> > > +	hantro_reg_write(vpu, &av1_global_mv_seg6,
> > > +			 segval[6][V4L2_AV1_SEG_LVL_REF_GLOBALMV]);
> > > +
> > > +	hantro_reg_write(vpu, &av1_quant_seg7,
> > > +			 segval[7][V4L2_AV1_SEG_LVL_ALT_Q]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta0_seg7,
> > > +			 segval[7][V4L2_AV1_SEG_LVL_ALT_LF_Y_V]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta1_seg7,
> > > +			 segval[7][V4L2_AV1_SEG_LVL_ALT_LF_Y_H]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta2_seg7,
> > > +			 segval[7][V4L2_AV1_SEG_LVL_ALT_LF_U]);
> > > +	hantro_reg_write(vpu, &av1_filt_level_delta3_seg7,
> > > +			 segval[7][V4L2_AV1_SEG_LVL_ALT_LF_V]);
> > > +	hantro_reg_write(vpu, &av1_refpic_seg7,
> > > +			 segval[7][V4L2_AV1_SEG_LVL_REF_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_skip_seg7,
> > > +			 segval[7][V4L2_AV1_SEG_LVL_REF_SKIP]);
> > > +	hantro_reg_write(vpu, &av1_global_mv_seg7,
> > > +			 segval[7][V4L2_AV1_SEG_LVL_REF_GLOBALMV]);
> > > +}
> > > +
> > > +static bool rockchip_vpu981_av1_dec_is_lossless(struct hantro_ctx *c=
tx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	const struct v4l2_av1_segmentation *segmentation =3D &frame->segmen=
tation;
> > > +	const struct v4l2_av1_quantization *quantization =3D &frame->quanti=
zation;
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < V4L2_AV1_MAX_SEGMENTS; i++) {
> > > +		int qindex =3D quantization->base_q_idx;
> > > +
> > > +		if (segmentation->feature_enabled[i] &
> > > +		    V4L2_AV1_SEGMENT_FEATURE_ENABLED(V4L2_AV1_SEG_LVL_ALT_Q)) {
> > > +			qindex +=3D segmentation->feature_data[i][V4L2_AV1_SEG_LVL_ALT_Q]=
;
> > > +		}
> > > +		qindex =3D CLIP3(0, 255, qindex);
> > > +
> > > +		if (qindex
> > > +		    || quantization->delta_q_y_dc
> > > +		    || quantization->delta_q_u_dc
> > > +		    || quantization->delta_q_u_ac
> > > +		    || quantization->delta_q_v_dc || quantization->delta_q_v_ac)
> > > +			return false;
> > > +	}
> > > +	return true;
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_loopfilter(struct hantro_ctx=
 *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	const struct v4l2_av1_loop_filter *loop_filter =3D &frame->loop_fil=
ter;
> > > +	bool filtering_dis =3D (loop_filter->level[0] =3D=3D 0)
> > > +			     && (loop_filter->level[1] =3D=3D 0);
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +
> > > +	hantro_reg_write(vpu, &av1_filtering_dis, filtering_dis);
> > > +	hantro_reg_write(vpu, &av1_filt_level_base_gt32, loop_filter->level=
[0] > 32);
> > > +	hantro_reg_write(vpu, &av1_filt_sharpness, loop_filter->sharpness);
> > > +
> > > +	hantro_reg_write(vpu, &av1_filt_level0, loop_filter->level[0]);
> > > +	hantro_reg_write(vpu, &av1_filt_level1, loop_filter->level[1]);
> > > +	hantro_reg_write(vpu, &av1_filt_level2, loop_filter->level[2]);
> > > +	hantro_reg_write(vpu, &av1_filt_level3, loop_filter->level[3]);
> > > +
> > > +	if (loop_filter->flags & V4L2_AV1_LOOP_FILTER_FLAG_DELTA_ENABLED
> > > +	    && !rockchip_vpu981_av1_dec_is_lossless(ctx)
> > > +	    && !(frame->flags & V4L2_AV1_FRAME_FLAG_ALLOW_INTRABC)) {
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_0,
> > > +				 loop_filter->ref_deltas[0]);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_1,
> > > +				 loop_filter->ref_deltas[1]);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_2,
> > > +				 loop_filter->ref_deltas[2]);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_3,
> > > +				 loop_filter->ref_deltas[3]);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_4,
> > > +				 loop_filter->ref_deltas[4]);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_5,
> > > +				 loop_filter->ref_deltas[5]);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_6,
> > > +				 loop_filter->ref_deltas[6]);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_7,
> > > +				 loop_filter->ref_deltas[7]);
> > > +		hantro_reg_write(vpu, &av1_filt_mb_adj_0,
> > > +				 loop_filter->mode_deltas[0]);
> > > +		hantro_reg_write(vpu, &av1_filt_mb_adj_1,
> > > +				 loop_filter->mode_deltas[1]);
> > > +	} else {
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_0, 0);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_1, 0);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_2, 0);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_3, 0);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_4, 0);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_5, 0);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_6, 0);
> > > +		hantro_reg_write(vpu, &av1_filt_ref_adj_7, 0);
> > > +		hantro_reg_write(vpu, &av1_filt_mb_adj_0, 0);
> > > +		hantro_reg_write(vpu, &av1_filt_mb_adj_1, 0);
> > > +	}
> > > +
> > > +	hantro_write_addr(vpu, AV1_DB_DATA_COL, av1_dec->db_data_col.dma);
> > > +	hantro_write_addr(vpu, AV1_DB_CTRL_COL, av1_dec->db_ctrl_col.dma);
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_update_prob(struct hantro_ctx *c=
tx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	bool frame_is_intra =3D IS_INTRA(frame->frame_type);
> > > +	struct av1cdfs *out_cdfs =3D (struct av1cdfs *)av1_dec->prob_tbl_ou=
t.cpu;
> > > +	int i;
> > > +
> > > +	if (frame->flags & V4L2_AV1_FRAME_FLAG_DISABLE_FRAME_END_UPDATE_CDF=
)
> > > +		return;
> > > +
> > > +	for (i =3D 0; i < NUM_REF_FRAMES; i++) {
> > > +		if (frame->refresh_frame_flags & (1 << i)) {
> > > +			struct mvcdfs stored_mv_cdf;
> > > +
> > > +			rockchip_av1_get_cdfs(ctx, i);
> > > +			stored_mv_cdf =3D av1_dec->cdfs->mv_cdf;
> > > +			*av1_dec->cdfs =3D *out_cdfs;
> > > +			if (frame_is_intra) {
> > > +				av1_dec->cdfs->mv_cdf =3D stored_mv_cdf;
> > > +				*av1_dec->cdfs_ndvc =3D out_cdfs->mv_cdf;
> > > +			}
> > > +			rockchip_av1_store_cdfs(ctx,
> > > +						frame->refresh_frame_flags);
> > > +			break;
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +void rockchip_vpu981_av1_dec_done(struct hantro_ctx *ctx)
> > > +{
> > > +	rockchip_vpu981_av1_dec_update_prob(ctx);
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_prob(struct hantro_ctx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	const struct v4l2_av1_quantization *quantization =3D &frame->quanti=
zation;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	bool error_resilient_mode =3D
> > > +	    !!(frame->flags & V4L2_AV1_FRAME_FLAG_ERROR_RESILIENT_MODE);
> > > +	bool frame_is_intra =3D IS_INTRA(frame->frame_type);
> > > +
> > > +	if (error_resilient_mode || frame_is_intra
> > > +	    || frame->primary_ref_frame =3D=3D AV1_PRIMARY_REF_NONE) {
> > > +		av1_dec->cdfs =3D &av1_dec->default_cdfs;
> > > +		av1_dec->cdfs_ndvc =3D &av1_dec->default_cdfs_ndvc;
> > > +		rockchip_av1_default_coeff_probs(quantization->base_q_idx,
> > > +						 av1_dec->cdfs);
> > > +	} else {
> > > +		rockchip_av1_get_cdfs(ctx, frame->ref_frame_idx[frame->primary_ref=
_frame]);
> > > +	}
> > > +	rockchip_av1_store_cdfs(ctx, frame->refresh_frame_flags);
> > > +
> > > +	memcpy(av1_dec->prob_tbl.cpu, av1_dec->cdfs, sizeof(struct av1cdfs)=
);
> > > +
> > > +	if (frame_is_intra) {
> > > +		int mv_offset =3D offsetof(struct av1cdfs, mv_cdf);
> > > +		/* Overwrite MV context area with intrabc MV context */
> > > +		memcpy(av1_dec->prob_tbl.cpu + mv_offset, av1_dec->cdfs_ndvc,
> > > +		       sizeof(struct mvcdfs));
> > > +	}
> > > +
> > > +	hantro_write_addr(vpu, AV1_PROP_TABLE_OUT, av1_dec->prob_tbl_out.dm=
a);
> > > +	hantro_write_addr(vpu, AV1_PROP_TABLE, av1_dec->prob_tbl.dma);
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_cdef(struct hantro_ctx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	const struct v4l2_av1_cdef *cdef =3D &frame->cdef;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	uint32_t luma_pri_strength =3D 0;
> > > +	uint16_t luma_sec_strength =3D 0;
> > > +	uint32_t chroma_pri_strength =3D 0;
> > > +	uint16_t chroma_sec_strength =3D 0;
> > > +	int i;
> > > +
> > > +	hantro_reg_write(vpu, &av1_cdef_bits, cdef->bits);
> > > +	hantro_reg_write(vpu, &av1_cdef_damping, cdef->damping_minus_3);
> > > +
> > > +	for (i =3D 0; i < (1 << cdef->bits); i++) {
> > > +		luma_pri_strength |=3D cdef->y_pri_strength[i] << (i * 4);
> > > +		if (cdef->y_sec_strength[i] =3D=3D 4)
> > > +			luma_sec_strength |=3D 3 << (i * 2);
> > > +		else
> > > +			luma_sec_strength |=3D cdef->y_sec_strength[i] << (i * 2);
> > > +
> > > +		chroma_pri_strength |=3D cdef->uv_pri_strength[i] << (i * 4);
> > > +		if (cdef->uv_sec_strength[i] =3D=3D 4)
> > > +			chroma_sec_strength |=3D 3 << (i * 2);
> > > +		else
> > > +			chroma_sec_strength |=3D cdef->uv_sec_strength[i] << (i * 2);
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_cdef_luma_primary_strength,
> > > +			 luma_pri_strength);
> > > +	hantro_reg_write(vpu, &av1_cdef_luma_secondary_strength,
> > > +			 luma_sec_strength);
> > > +	hantro_reg_write(vpu, &av1_cdef_chroma_primary_strength,
> > > +			 chroma_pri_strength);
> > > +	hantro_reg_write(vpu, &av1_cdef_chroma_secondary_strength,
> > > +			 chroma_sec_strength);
> > > +
> > > +	hantro_write_addr(vpu, AV1_CDEF_COL, av1_dec->cdef_col.dma);
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_lr(struct hantro_ctx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	const struct v4l2_av1_loop_restoration *loop_restoration =3D
> > > +	    &frame->loop_restoration;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	uint16_t lr_type =3D 0, lr_unit_size =3D 0;
> > > +	uint8_t restoration_unit_size[V4L2_AV1_NUM_PLANES_MAX] =3D { 3, 3, =
3 };
> > > +	int i;
> > > +
> > > +	if (loop_restoration->flags & V4L2_AV1_LOOP_RESTORATION_FLAG_USES_L=
R) {
> > > +		restoration_unit_size[0] =3D 1 + loop_restoration->lr_unit_shift;
> > > +		restoration_unit_size[1] =3D
> > > +		    1 + loop_restoration->lr_unit_shift - loop_restoration->lr_uv_=
shift;
> > > +		restoration_unit_size[2] =3D
> > > +		    1 + loop_restoration->lr_unit_shift - loop_restoration->lr_uv_=
shift;
> > > +	}
> > > +
> > > +	for (i =3D 0; i < V4L2_AV1_NUM_PLANES_MAX; i++) {
> > > +		lr_type |=3D
> > > +		    loop_restoration->frame_restoration_type[i] << (i * 2);
> > > +		lr_unit_size |=3D restoration_unit_size[i] << (i * 2);
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_lr_type, lr_type);
> > > +	hantro_reg_write(vpu, &av1_lr_unit_size, lr_unit_size);
> > > +	hantro_write_addr(vpu, AV1_LR_COL, av1_dec->lr_col.dma);
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_superres_params(struct hantr=
o_ctx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	uint8_t superres_scale_denominator =3D SCALE_NUMERATOR;
> > > +	int superres_luma_step =3D RS_SCALE_SUBPEL_BITS;
> > > +	int superres_chroma_step =3D RS_SCALE_SUBPEL_BITS;
> > > +	int superres_luma_step_invra =3D RS_SCALE_SUBPEL_BITS;
> > > +	int superres_chroma_step_invra =3D RS_SCALE_SUBPEL_BITS;
> > > +	int superres_init_luma_subpel_x =3D 0;
> > > +	int superres_init_chroma_subpel_x =3D 0;
> > > +	int superres_is_scaled =3D 0;
> > > +	int min_w =3D min_t(uint32_t, 16, frame->upscaled_width);
> > > +	int upscaledLumaPlaneW, downscaledLumaPlaneW;
> > > +	int downscaledChromaPlaneW, upscaledChromaPlaneW;
> > > +	int stepLumaX, stepChromaX;
> > > +	int errLuma, errChroma;
> > > +	int initialLumaSubpelX, initialChromaSubpelX;
> > You haven't used camel case so far, are you sure this is allowed ?
>=20
> I will change them.
>=20
> >=20
> > > +	int width =3D 0;
> > > +
> > > +	if (frame->flags & V4L2_AV1_FRAME_FLAG_USE_SUPERRES)
> > > +		superres_scale_denominator =3D frame->superres_denom;
> > > +
> > > +	if (superres_scale_denominator <=3D SCALE_NUMERATOR)
> > > +		goto set_regs;
> > > +
> > > +	width =3D (frame->upscaled_width * SCALE_NUMERATOR +
> > > +		(superres_scale_denominator / 2)) / superres_scale_denominator;
> > > +
> > > +	if (width < min_w)
> > > +		width =3D min_w;
> > > +
> > > +	if (width =3D=3D frame->upscaled_width)
> > > +		goto set_regs;
> > > +
> > > +	superres_is_scaled =3D 1;
> > > +	upscaledLumaPlaneW =3D frame->upscaled_width;
> > > +	downscaledLumaPlaneW =3D width;
> > > +	downscaledChromaPlaneW =3D (downscaledLumaPlaneW + 1) >> 1;
> > > +	upscaledChromaPlaneW =3D (upscaledLumaPlaneW + 1) >> 1;
> > > +	stepLumaX =3D
> > > +		((downscaledLumaPlaneW << RS_SCALE_SUBPEL_BITS) +
> > > +		 (upscaledLumaPlaneW / 2)) / upscaledLumaPlaneW;
> > > +	stepChromaX =3D
> > > +		((downscaledChromaPlaneW << RS_SCALE_SUBPEL_BITS) +
> > > +		 (upscaledChromaPlaneW / 2)) / upscaledChromaPlaneW;
> > > +	errLuma =3D
> > > +		(upscaledLumaPlaneW * stepLumaX)
> > > +		- (downscaledLumaPlaneW << RS_SCALE_SUBPEL_BITS);
> > > +	errChroma =3D
> > > +		(upscaledChromaPlaneW * stepChromaX)
> > > +		- (downscaledChromaPlaneW << RS_SCALE_SUBPEL_BITS);
> > > +	initialLumaSubpelX =3D
> > > +		((-((upscaledLumaPlaneW - downscaledLumaPlaneW) << (RS_SCALE_SUBPE=
L_BITS - 1))
> > > +		  + upscaledLumaPlaneW / 2)
> > > +		 / upscaledLumaPlaneW + (1 << (RS_SCALE_EXTRA_BITS - 1)) - errLuma=
 / 2)
> > > +		& RS_SCALE_SUBPEL_MASK;
> > > +	initialChromaSubpelX =3D
> > > +		((-((upscaledChromaPlaneW - downscaledChromaPlaneW) << (RS_SCALE_S=
UBPEL_BITS - 1))
> > > +		  + upscaledChromaPlaneW / 2)
> > > +		 / upscaledChromaPlaneW + (1 << (RS_SCALE_EXTRA_BITS - 1)) - errCh=
roma / 2)
> > > +		& RS_SCALE_SUBPEL_MASK;
> > > +	superres_luma_step =3D stepLumaX;
> > > +	superres_chroma_step =3D stepChromaX;
> > > +	superres_luma_step_invra =3D
> > > +		((upscaledLumaPlaneW << RS_SCALE_SUBPEL_BITS) + (downscaledLumaPla=
neW / 2))
> > > +		/ downscaledLumaPlaneW;
> > > +	superres_chroma_step_invra =3D
> > > +		((upscaledChromaPlaneW << RS_SCALE_SUBPEL_BITS) + (downscaledChrom=
aPlaneW / 2))
> > > +		/ downscaledChromaPlaneW;
> > > +	superres_init_luma_subpel_x =3D initialLumaSubpelX;
> > > +	superres_init_chroma_subpel_x =3D initialChromaSubpelX;
> > > +
> > > +set_regs:
> > > +	hantro_reg_write(vpu, &av1_superres_pic_width, frame->upscaled_widt=
h);
> > > +
> > > +	if (frame->flags & V4L2_AV1_FRAME_FLAG_USE_SUPERRES)
> > > +		hantro_reg_write(vpu, &av1_scale_denom_minus9,
> > > +				 frame->superres_denom - SUPERRES_SCALE_DENOMINATOR_MIN);
> > > +	else
> > > +		hantro_reg_write(vpu, &av1_scale_denom_minus9, frame->superres_den=
om);
> > > +
> > > +	hantro_reg_write(vpu, &av1_superres_luma_step, superres_luma_step);
> > > +	hantro_reg_write(vpu, &av1_superres_chroma_step, superres_chroma_st=
ep);
> > > +	hantro_reg_write(vpu, &av1_superres_luma_step_invra,
> > > +			 superres_luma_step_invra);
> > > +	hantro_reg_write(vpu, &av1_superres_chroma_step_invra,
> > > +			 superres_chroma_step_invra);
> > > +	hantro_reg_write(vpu, &av1_superres_init_luma_subpel_x,
> > > +			 superres_init_luma_subpel_x);
> > > +	hantro_reg_write(vpu, &av1_superres_init_chroma_subpel_x,
> > > +			 superres_init_chroma_subpel_x);
> > > +	hantro_reg_write(vpu, &av1_superres_is_scaled, superres_is_scaled);
> > > +
> > > +	hantro_write_addr(vpu, AV1_SR_COL, av1_dec->sr_col.dma);
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_picture_dimensions(struct ha=
ntro_ctx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	int pic_width_in_cbs =3D ALIGN(frame->frame_width_minus_1 + 1, 8) >=
> 3;
> > > +	int pic_height_in_cbs =3D ALIGN(frame->frame_height_minus_1 + 1, 8)=
 >> 3;
> > Aren't these DIV_ROUND_UP(val + 1, 8) ?
> >=20
> > > +	int pic_width_pad =3D ALIGN(frame->frame_width_minus_1 + 1, 8)
> > > +			    - (frame->frame_width_minus_1 + 1);
> > > +	int pic_height_pad =3D ALIGN(frame->frame_height_minus_1 + 1, 8)
> > > +			     - (frame->frame_height_minus_1 + 1);
> > > +
> > > +	hantro_reg_write(vpu, &av1_pic_width_in_cbs, pic_width_in_cbs);
> > > +	hantro_reg_write(vpu, &av1_pic_height_in_cbs, pic_height_in_cbs);
> > > +	hantro_reg_write(vpu, &av1_pic_width_pad, pic_width_pad);
> > > +	hantro_reg_write(vpu, &av1_pic_height_pad, pic_height_pad);
> > > +
> > > +	rockchip_vpu981_av1_dec_set_superres_params(ctx);
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_other_frames(struct hantro_c=
tx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	bool use_ref_frame_mvs =3D
> > > +	    !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_USE_REF_FRAME_MVS)=
;
> > > +	int cur_frame_offset =3D frame->order_hint;
> > > +	int alt_frame_offset =3D 0;
> > > +	int gld_frame_offset =3D 0;
> > > +	int bwd_frame_offset =3D 0;
> > > +	int alt2_frame_offset =3D 0;
> > > +	int refs_selected[3] =3D { 0, 0, 0 };
> > > +	int cur_mi_cols =3D (frame->frame_width_minus_1 + 8) >> 3;
> > > +	int cur_mi_rows =3D (frame->frame_height_minus_1 + 8) >> 3;
> > This looks like a contraction of (val + 1 + 7) / 8, so in short, anothe=
r
> > DIV_ROUNDUP().
> >=20
> > > +	int cur_offset[V4L2_AV1_NUM_REF_FRAMES - 1];
> > > +	int cur_roffset[V4L2_AV1_NUM_REF_FRAMES - 1];
> > This looks like V4L2_AV1_REFS_PER_FRAME. Daniel, should be remove this
> > V4L2_AV1_NUM_REF_FRAMES ? Its redundant with V4L2_AV1_TOTAL_REFS_PER_FR=
AME ...
> >=20
> > > +	int mf_types[3] =3D { 0, 0, 0 };
> > > +	int ref_stamp =3D 2;
> > > +	int ref_ind =3D 0;
> > > +	int rf, idx;
> > > +
> > > +	alt_frame_offset =3D rockchip_vpu981_get_order_hint(ctx, ALT_BUF_ID=
X);
> > > +	gld_frame_offset =3D rockchip_vpu981_get_order_hint(ctx, GLD_BUF_ID=
X);
> > > +	bwd_frame_offset =3D rockchip_vpu981_get_order_hint(ctx, BWD_BUF_ID=
X);
> > > +	alt2_frame_offset =3D rockchip_vpu981_get_order_hint(ctx, ALT2_BUF_=
IDX);
> > > +
> > > +	idx =3D rockchip_vpu981_get_frame_index(ctx, LST_BUF_IDX);
> > > +	if (idx >=3D 0) {
> > > +		int alt_frame_offset_in_lst =3D
> > > +			av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_ALTREF_FRAME];
> > > +		bool is_lst_overlay =3D
> > > +		    (alt_frame_offset_in_lst =3D=3D gld_frame_offset);
> > > +
> > > +		if (!is_lst_overlay) {
> > > +			int lst_mi_cols =3D
> > > +			    (av1_dec->frame_refs[idx].width + 7) >> 3;
> > DIV_ROUDNUP()
> >=20
> > > +			int lst_mi_rows =3D
> > > +			    (av1_dec->frame_refs[idx].height + 7) >> 3;
> > again. I'll stop pointing these out, I think you can find them.
> >=20
> > > +			bool lst_intra_only =3D
> > > +			    IS_INTRA(av1_dec->frame_refs[idx].frame_type);
> > > +
> > > +			if (lst_mi_cols =3D=3D cur_mi_cols
> > > +			    && lst_mi_rows =3D=3D cur_mi_rows && !lst_intra_only) {
> > > +				mf_types[ref_ind] =3D V4L2_AV1_REF_LAST_FRAME;
> > > +				refs_selected[ref_ind++] =3D LST_BUF_IDX;
> > > +			}
> > > +		}
> > > +		ref_stamp--;
> > > +	}
> > > +
> > > +	idx =3D rockchip_vpu981_get_frame_index(ctx, BWD_BUF_IDX);
> > > +	if (rockchip_vpu981_av1_dec_get_relative_dist
> > > +	    (ctx, bwd_frame_offset, cur_frame_offset) > 0) {
> > > +		int bwd_mi_cols =3D (av1_dec->frame_refs[idx].width + 7) >> 3;
> > > +		int bwd_mi_rows =3D (av1_dec->frame_refs[idx].height + 7) >> 3;
> > > +		bool bwd_intra_only =3D
> > > +		    IS_INTRA(av1_dec->frame_refs[idx].frame_type);
> > > +
> > > +		if (bwd_mi_cols =3D=3D cur_mi_cols && bwd_mi_rows =3D=3D cur_mi_ro=
ws &&
> > > +		    !bwd_intra_only) {
> > > +			mf_types[ref_ind] =3D V4L2_AV1_REF_BWDREF_FRAME;
> > > +			refs_selected[ref_ind++] =3D BWD_BUF_IDX;
> > > +			ref_stamp--;
> > > +		}
> > > +	}
> > > +
> > > +	idx =3D rockchip_vpu981_get_frame_index(ctx, ALT2_BUF_IDX);
> > > +	if (rockchip_vpu981_av1_dec_get_relative_dist
> > > +	    (ctx, alt2_frame_offset, cur_frame_offset) > 0) {
> > > +		int alt2_mi_cols =3D (av1_dec->frame_refs[idx].width + 7) >> 3;
> > > +		int alt2_mi_rows =3D (av1_dec->frame_refs[idx].height + 7) >> 3;
> > > +		bool alt2_intra_only =3D
> > > +		    IS_INTRA(av1_dec->frame_refs[idx].frame_type);
> > > +
> > > +		if (alt2_mi_cols =3D=3D cur_mi_cols && alt2_mi_rows =3D=3D cur_mi_=
rows
> > > +		    && !alt2_intra_only) {
> > > +			mf_types[ref_ind] =3D V4L2_AV1_REF_ALTREF2_FRAME;
> > > +			refs_selected[ref_ind++] =3D ALT2_BUF_IDX;
> > > +			ref_stamp--;
> > > +		}
> > > +	}
> > > +
> > > +	idx =3D rockchip_vpu981_get_frame_index(ctx, ALT_BUF_IDX);
> > > +	if (rockchip_vpu981_av1_dec_get_relative_dist
> > > +	    (ctx, alt_frame_offset, cur_frame_offset) > 0 && ref_stamp >=3D=
 0) {
> > > +		int alt_mi_cols =3D (av1_dec->frame_refs[idx].width + 7) >> 3;
> > > +		int alt_mi_rows =3D (av1_dec->frame_refs[idx].height + 7) >> 3;
> > > +		bool alt_intra_only =3D
> > > +		    IS_INTRA(av1_dec->frame_refs[idx].frame_type);
> > > +
> > > +		if (alt_mi_cols =3D=3D cur_mi_cols && alt_mi_rows =3D=3D cur_mi_ro=
ws &&
> > > +		    !alt_intra_only) {
> > > +			mf_types[ref_ind] =3D V4L2_AV1_REF_ALTREF_FRAME;
> > > +			refs_selected[ref_ind++] =3D ALT_BUF_IDX;
> > > +			ref_stamp--;
> > > +		}
> > > +	}
> > > +
> > > +	idx =3D rockchip_vpu981_get_frame_index(ctx, LST2_BUF_IDX);
> > > +	if (idx >=3D 0 && ref_stamp >=3D 0) {
> > > +		int lst2_mi_cols =3D (av1_dec->frame_refs[idx].width + 7) >> 3;
> > > +		int lst2_mi_rows =3D (av1_dec->frame_refs[idx].height + 7) >> 3;
> > I said I'd stop, but can't this be calculate once and saved in the refe=
rence
> > frame structure ?
>=20
> Indeed that is a simplification, I will implement it.
>=20
> >=20
> > > +		bool lst2_intra_only =3D
> > > +		    IS_INTRA(av1_dec->frame_refs[idx].frame_type);
> > > +
> > > +		if (lst2_mi_cols =3D=3D cur_mi_cols && lst2_mi_rows =3D=3D cur_mi_=
rows
> > > +		    && !lst2_intra_only) {
> > > +			mf_types[ref_ind] =3D V4L2_AV1_REF_LAST2_FRAME;
> > > +			refs_selected[ref_ind++] =3D LST2_BUF_IDX;
> > > +			ref_stamp--;
> > > +		}
> > > +	}
> > > +
> > > +	for (rf =3D 0; rf < V4L2_AV1_NUM_REF_FRAMES - 1; ++rf) {
> > > +		idx =3D rockchip_vpu981_get_frame_index(ctx, rf);
> > > +		if (idx >=3D 0) {
> > > +			int rf_order_hint =3D rockchip_vpu981_get_order_hint(ctx, rf);
> > > +
> > > +			cur_offset[rf] =3D
> > > +			    rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +								      cur_frame_offset,
> > > +								      rf_order_hint);
> > > +			cur_roffset[rf] =3D
> > > +			    rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +								      rf_order_hint,
> > > +								      cur_frame_offset);
> > > +		} else {
> > > +			cur_offset[rf] =3D 0;
> > > +			cur_roffset[rf] =3D 0;
> > > +		}
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_use_temporal0_mvs, 0);
> > > +	hantro_reg_write(vpu, &av1_use_temporal1_mvs, 0);
> > > +	hantro_reg_write(vpu, &av1_use_temporal2_mvs, 0);
> > > +	hantro_reg_write(vpu, &av1_use_temporal3_mvs, 0);
> > > +
> > > +	hantro_reg_write(vpu, &av1_mf1_last_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf1_last2_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf1_last3_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf1_golden_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf1_bwdref_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf1_altref2_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf1_altref_offset, 0);
> > > +
> > > +	if (use_ref_frame_mvs && ref_ind > 0 &&
> > > +	    cur_offset[mf_types[0] - V4L2_AV1_REF_LAST_FRAME] <=3D MAX_FRAM=
E_DISTANCE
> > > +	    && cur_offset[mf_types[0] - V4L2_AV1_REF_LAST_FRAME] >=3D -MAX_=
FRAME_DISTANCE) {
> > > +		int rf_order_hint =3D rockchip_vpu981_get_order_hint(ctx, refs_sel=
ected[0]);
> > > +		int idx =3D rockchip_vpu981_get_frame_index(ctx, refs_selected[0])=
;
> > > +		int val;
> > > +
> > > +		hantro_reg_write(vpu, &av1_use_temporal0_mvs, 1);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_LAST_FRAME]);
> > > +		hantro_reg_write(vpu, &av1_mf1_last_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_LAST2_FRAME]);
> > > +		hantro_reg_write(vpu, &av1_mf1_last2_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_LAST3_FRAME]);
> > > +		hantro_reg_write(vpu, &av1_mf1_last3_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_GOLDEN_FRAME])=
;
> > > +		hantro_reg_write(vpu, &av1_mf1_golden_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_BWDREF_FRAME])=
;
> > > +		hantro_reg_write(vpu, &av1_mf1_bwdref_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_ALTREF2_FRAME]=
);
> > > +		hantro_reg_write(vpu, &av1_mf1_altref2_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_ALTREF_FRAME])=
;
> > > +		hantro_reg_write(vpu, &av1_mf1_altref_offset, val);
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_mf2_last_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf2_last2_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf2_last3_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf2_golden_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf2_bwdref_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf2_altref2_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf2_altref_offset, 0);
> > > +
> > > +	if (use_ref_frame_mvs && ref_ind > 1 &&
> > > +	    cur_offset[mf_types[1] - V4L2_AV1_REF_LAST_FRAME] <=3D MAX_FRAM=
E_DISTANCE
> > > +	    && cur_offset[mf_types[1] - V4L2_AV1_REF_LAST_FRAME] >=3D -MAX_=
FRAME_DISTANCE) {
> > > +		int rf_order_hint =3D rockchip_vpu981_get_order_hint(ctx, refs_sel=
ected[1]);
> > > +		int idx =3D rockchip_vpu981_get_frame_index(ctx, refs_selected[1])=
;
> > > +		int val;
> > > +
> > > +		hantro_reg_write(vpu, &av1_use_temporal1_mvs, 1);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_LAST_FRAME]);
> > > +		hantro_reg_write(vpu, &av1_mf2_last_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_LAST2_FRAME]);
> > > +		hantro_reg_write(vpu, &av1_mf2_last2_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_LAST3_FRAME]);
> > > +		hantro_reg_write(vpu, &av1_mf2_last3_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_GOLDEN_FRAME])=
;
> > > +		hantro_reg_write(vpu, &av1_mf2_golden_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_BWDREF_FRAME])=
;
> > > +		hantro_reg_write(vpu, &av1_mf2_bwdref_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_ALTREF2_FRAME]=
);
> > > +		hantro_reg_write(vpu, &av1_mf2_altref2_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_ALTREF_FRAME])=
;
> > > +		hantro_reg_write(vpu, &av1_mf2_altref_offset, val);
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_mf3_last_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf3_last2_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf3_last3_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf3_golden_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf3_bwdref_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf3_altref2_offset, 0);
> > > +	hantro_reg_write(vpu, &av1_mf3_altref_offset, 0);
> > > +
> > > +	if (use_ref_frame_mvs && ref_ind > 2 &&
> > > +	    cur_offset[mf_types[2] - V4L2_AV1_REF_LAST_FRAME] <=3D MAX_FRAM=
E_DISTANCE
> > > +	    && cur_offset[mf_types[2] - V4L2_AV1_REF_LAST_FRAME] >=3D -MAX_=
FRAME_DISTANCE) {
> > > +		int rf_order_hint =3D rockchip_vpu981_get_order_hint(ctx, refs_sel=
ected[2]);
> > > +		int idx =3D rockchip_vpu981_get_frame_index(ctx, refs_selected[2])=
;
> > > +		int val;
> > > +
> > > +		hantro_reg_write(vpu, &av1_use_temporal2_mvs, 1);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_LAST_FRAME]);
> > > +		hantro_reg_write(vpu, &av1_mf3_last_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_LAST2_FRAME]);
> > > +		hantro_reg_write(vpu, &av1_mf3_last2_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_LAST3_FRAME]);
> > > +		hantro_reg_write(vpu, &av1_mf3_last3_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_GOLDEN_FRAME])=
;
> > > +		hantro_reg_write(vpu, &av1_mf3_golden_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_BWDREF_FRAME])=
;
> > > +		hantro_reg_write(vpu, &av1_mf3_bwdref_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_ALTREF2_FRAME]=
);
> > > +		hantro_reg_write(vpu, &av1_mf3_altref2_offset, val);
> > > +
> > > +		val =3D rockchip_vpu981_av1_dec_get_relative_dist(ctx,
> > > +				rf_order_hint,
> > > +				av1_dec->frame_refs[idx].order_hints[V4L2_AV1_REF_ALTREF_FRAME])=
;
> > > +		hantro_reg_write(vpu, &av1_mf3_altref_offset, val);
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_cur_last_offset, cur_offset[0]);
> > > +	hantro_reg_write(vpu, &av1_cur_last2_offset, cur_offset[1]);
> > > +	hantro_reg_write(vpu, &av1_cur_last3_offset, cur_offset[2]);
> > > +	hantro_reg_write(vpu, &av1_cur_golden_offset, cur_offset[3]);
> > > +	hantro_reg_write(vpu, &av1_cur_bwdref_offset, cur_offset[4]);
> > > +	hantro_reg_write(vpu, &av1_cur_altref2_offset, cur_offset[5]);
> > > +	hantro_reg_write(vpu, &av1_cur_altref_offset, cur_offset[6]);
> > > +
> > > +	hantro_reg_write(vpu, &av1_cur_last_roffset, cur_roffset[0]);
> > > +	hantro_reg_write(vpu, &av1_cur_last2_roffset, cur_roffset[1]);
> > > +	hantro_reg_write(vpu, &av1_cur_last3_roffset, cur_roffset[2]);
> > > +	hantro_reg_write(vpu, &av1_cur_golden_roffset, cur_roffset[3]);
> > > +	hantro_reg_write(vpu, &av1_cur_bwdref_roffset, cur_roffset[4]);
> > > +	hantro_reg_write(vpu, &av1_cur_altref2_roffset, cur_roffset[5]);
> > > +	hantro_reg_write(vpu, &av1_cur_altref_roffset, cur_roffset[6]);
> > > +
> > > +	hantro_reg_write(vpu, &av1_mf1_type, mf_types[0] - V4L2_AV1_REF_LAS=
T_FRAME);
> > > +	hantro_reg_write(vpu, &av1_mf2_type, mf_types[1] - V4L2_AV1_REF_LAS=
T_FRAME);
> > > +	hantro_reg_write(vpu, &av1_mf3_type, mf_types[2] - V4L2_AV1_REF_LAS=
T_FRAME);
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_reference_frames(struct hant=
ro_ctx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_frame *frame =3D ctrls->frame;
> > > +	int frame_type =3D frame->frame_type;
> > > +	bool allow_intrabc =3D !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG=
_ALLOW_INTRABC);
> > > +	int ref_count[AV1DEC_MAX_PIC_BUFFERS] =3D { 0 };
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	int i, ref_frames =3D 0;
> > > +	bool scale_enable =3D false;
> > > +
> > > +	if (IS_INTRA(frame_type) && !allow_intrabc)
> > > +		return;
> > > +
> > > +	if (!allow_intrabc) {
> > > +		for (i =3D 0; i < V4L2_AV1_REFS_PER_FRAME; i++) {
> > > +			int idx =3D rockchip_vpu981_get_frame_index(ctx, i);
> > > +
> > > +			if (idx >=3D 0)
> > > +				ref_count[idx]++;
> > > +		}
> > > +
> > > +		for (i =3D 0; i < AV1DEC_MAX_PIC_BUFFERS; i++) {
> > > +			if (ref_count[i])
> > > +				ref_frames++;
> > > +		}
> > > +	} else {
> > > +		ref_frames =3D 1;
> > > +	}
> > > +	hantro_reg_write(vpu, &av1_ref_frames, ref_frames);
> > > +
> > > +	rockchip_vpu981_av1_dec_set_frame_sign_bias(ctx);
> > > +
> > > +	for (i =3D V4L2_AV1_REF_LAST_FRAME; i < V4L2_AV1_NUM_REF_FRAMES; i+=
+) {
> > > +		uint32_t ref =3D i - 1;
> > > +		int idx =3D 0;
> > > +		int width, height;
> > > +
> > > +		if (allow_intrabc) {
> > > +			idx =3D av1_dec->current_frame_index;
> > > +			width =3D frame->frame_width_minus_1 + 1;
> > > +			height =3D frame->frame_height_minus_1 + 1;
> > > +		} else {
> > > +			if (rockchip_vpu981_get_frame_index(ctx, ref) > 0)
> > > +				idx =3D rockchip_vpu981_get_frame_index(ctx, ref);
> > > +			width =3D av1_dec->frame_refs[idx].width;
> > > +			height =3D av1_dec->frame_refs[idx].height;
> > > +		}
> > > +
> > > +		scale_enable |=3D
> > > +		    rockchip_vpu981_av1_dec_set_ref(ctx, ref, idx, width,
> > > +						    height);
> > > +
> > > +		rockchip_vpu981_av1_dec_set_sign_bias(ctx, ref,
> > > +						      av1_dec->ref_frame_sign_bias[i]);
> > > +	}
> > > +	hantro_reg_write(vpu, &av1_ref_scaling_enable, scale_enable);
> > > +
> > > +	hantro_reg_write(vpu, &av1_ref0_gm_mode,
> > > +			 frame->global_motion.type[V4L2_AV1_REF_LAST_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_ref1_gm_mode,
> > > +			 frame->global_motion.type[V4L2_AV1_REF_LAST2_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_ref2_gm_mode,
> > > +			 frame->global_motion.type[V4L2_AV1_REF_LAST3_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_ref3_gm_mode,
> > > +			 frame->global_motion.type[V4L2_AV1_REF_GOLDEN_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_ref4_gm_mode,
> > > +			 frame->global_motion.type[V4L2_AV1_REF_BWDREF_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_ref5_gm_mode,
> > > +			 frame->global_motion.type[V4L2_AV1_REF_ALTREF2_FRAME]);
> > > +	hantro_reg_write(vpu, &av1_ref6_gm_mode,
> > > +			 frame->global_motion.type[V4L2_AV1_REF_ALTREF_FRAME]);
> > > +
> > > +	rockchip_vpu981_av1_dec_set_other_frames(ctx);
> > > +}
> > > +
> > > +static void rockchip_vpu981_av1_dec_set_parameters(struct hantro_ctx=
 *ctx)
> > > +{
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +
> > > +	hantro_reg_write(vpu, &av1_skip_mode,
> > > +			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_SKIP_MODE_PRESENT))=
;
> > > +	hantro_reg_write(vpu, &av1_tempor_mvp_e,
> > > +			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_USE_REF_FRAME_MVS))=
;
> > > +	hantro_reg_write(vpu, &av1_delta_lf_res_log,
> > > +			 ctrls->frame->loop_filter.delta_lf_res);
> > > +	hantro_reg_write(vpu, &av1_delta_lf_multi,
> > > +			 !!(ctrls->frame->loop_filter.flags
> > > +			    & V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_MULTI));
> > > +	hantro_reg_write(vpu, &av1_delta_lf_present,
> > > +			 !!(ctrls->frame->loop_filter.flags
> > > +			    & V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_PRESENT));
> > > +	hantro_reg_write(vpu, &av1_disable_cdf_update,
> > > +			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_DISABLE_CDF_UPDATE)=
);
> > > +	hantro_reg_write(vpu, &av1_allow_warp,
> > > +			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_ALLOW_WARPED_MOTION=
));
> > > +	hantro_reg_write(vpu, &av1_show_frame,
> > > +			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_SHOW_FRAME));
> > > +	hantro_reg_write(vpu, &av1_switchable_motion_mode,
> > > +			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_IS_MOTION_MODE_SWIT=
CHABLE));
> > > +	hantro_reg_write(vpu, &av1_enable_cdef,
> > > +			 !!(ctrls->sequence->flags & V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF))=
;
> > > +	hantro_reg_write(vpu, &av1_allow_masked_compound,
> > > +			 !!(ctrls->sequence->flags
> > > +			    & V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND));
> > > +	hantro_reg_write(vpu, &av1_allow_interintra,
> > > +			 !!(ctrls->sequence->flags
> > > +			    & V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND));
> > > +	hantro_reg_write(vpu, &av1_enable_intra_edge_filter,
> > > +			 !!(ctrls->sequence->flags
> > > +			    & V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER));
> > > +	hantro_reg_write(vpu, &av1_allow_filter_intra,
> > > +			 !!(ctrls->sequence->flags & V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER=
_INTRA));
> > > +	hantro_reg_write(vpu, &av1_enable_jnt_comp,
> > > +			 !!(ctrls->sequence->flags & V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_CO=
MP));
> > > +	hantro_reg_write(vpu, &av1_enable_dual_filter,
> > > +			 !!(ctrls->sequence->flags & V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_F=
ILTER));
> > > +	hantro_reg_write(vpu, &av1_reduced_tx_set_used,
> > > +			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_REDUCED_TX_SET));
> > > +	hantro_reg_write(vpu, &av1_allow_screen_content_tools,
> > > +			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_ALLOW_SCREEN_CONTEN=
T_TOOLS));
> > > +	hantro_reg_write(vpu, &av1_allow_intrabc,
> > > +			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_ALLOW_INTRABC));
> > > +
> > > +	if (!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_ALLOW_SCREEN_CONTEN=
T_TOOLS))
> > > +		hantro_reg_write(vpu, &av1_force_interger_mv, 0);
> > > +	else
> > > +		hantro_reg_write(vpu, &av1_force_interger_mv,
> > > +				 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_FORCE_INTEGER_MV))=
;
> > > +
> > > +	hantro_reg_write(vpu, &av1_blackwhite_e, 0);
> > > +	hantro_reg_write(vpu, &av1_delta_q_res_log, ctrls->frame->quantizat=
ion.delta_q_res);
> > > +	hantro_reg_write(vpu, &av1_delta_q_present,
> > > +			 !!(ctrls->frame->quantization.flags
> > > +			    & V4L2_AV1_QUANTIZATION_FLAG_DELTA_Q_PRESENT));
> > > +
> > > +	hantro_reg_write(vpu, &av1_idr_pic_e, !ctrls->frame->frame_type);
> > > +	hantro_reg_write(vpu, &av1_quant_base_qindex, ctrls->frame->quantiz=
ation.base_q_idx);
> > > +	hantro_reg_write(vpu, &av1_bit_depth_y_minus8, ctx->bit_depth - 8);
> > > +	hantro_reg_write(vpu, &av1_bit_depth_c_minus8, ctx->bit_depth - 8);
> > I believe these register are read by PP when using format 0, perhaps so=
mething
> > nice to comment about, as they will impact the pixel produce by the pos=
t-
> > processor, which can be a surprising side effect. Bit 11:8 also hold
> > sw_bit_depth_out_minus8, but I don't know if its used for AV1, in my do=
c its
> > only used for AVS2 CODEC.
>=20
> I have no indication about that in MPP code.
> Post processor output pixel format is selected when writing in av1_pp_out=
_format field.

You now have access to the same doc as me.


> >=20
> > I think its good to underline that in VC8000/VC9000, some registers are=
 shared
> > across multiple CODECs.
> >=20
> > > +
> > > +	hantro_reg_write(vpu, &av1_mcomp_filt_type, ctrls->frame->interpola=
tion_filter);
> > > +	hantro_reg_write(vpu, &av1_high_prec_mv_e,
> > > +			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_ALLOW_HIGH_PRECISIO=
N_MV));
> > > +	hantro_reg_write(vpu, &av1_comp_pred_mode,
> > > +			 (ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_REFERENCE_SELECT) ? 2=
 : 0);
> > > +	hantro_reg_write(vpu, &av1_transform_mode, (ctrls->frame->tx_mode =
=3D=3D 1) ? 3 : 4);
> > > +	hantro_reg_write(vpu, &av1_max_cb_size,
> > > +			 (ctrls->sequence->flags
> > > +			  & V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK) ? 7 : 6);
> > > +	hantro_reg_write(vpu, &av1_min_cb_size, 3);
> > > +
> > > +	hantro_reg_write(vpu, &av1_comp_pred_fixed_ref, 0);
> > > +	hantro_reg_write(vpu, &av1_comp_pred_var_ref0_av1, 0);
> > > +	hantro_reg_write(vpu, &av1_comp_pred_var_ref1_av1, 0);
> > > +	hantro_reg_write(vpu, &av1_filt_level_seg0, 0);
> > > +	hantro_reg_write(vpu, &av1_filt_level_seg1, 0);
> > > +	hantro_reg_write(vpu, &av1_filt_level_seg2, 0);
> > > +	hantro_reg_write(vpu, &av1_filt_level_seg3, 0);
> > > +	hantro_reg_write(vpu, &av1_filt_level_seg4, 0);
> > > +	hantro_reg_write(vpu, &av1_filt_level_seg5, 0);
> > > +	hantro_reg_write(vpu, &av1_filt_level_seg6, 0);
> > > +	hantro_reg_write(vpu, &av1_filt_level_seg7, 0);
> > > +
> > > +	hantro_reg_write(vpu, &av1_qp_delta_y_dc_av1, ctrls->frame->quantiz=
ation.delta_q_y_dc);
> > > +	hantro_reg_write(vpu, &av1_qp_delta_ch_dc_av1, ctrls->frame->quanti=
zation.delta_q_u_dc);
> > > +	hantro_reg_write(vpu, &av1_qp_delta_ch_ac_av1, ctrls->frame->quanti=
zation.delta_q_u_ac);
> > > +	if (ctrls->frame->quantization.flags & V4L2_AV1_QUANTIZATION_FLAG_U=
SING_QMATRIX) {
> > > +		hantro_reg_write(vpu, &av1_qmlevel_y, ctrls->frame->quantization.q=
m_y);
> > > +		hantro_reg_write(vpu, &av1_qmlevel_u, ctrls->frame->quantization.q=
m_u);
> > > +		hantro_reg_write(vpu, &av1_qmlevel_v, ctrls->frame->quantization.q=
m_v);
> > > +	} else {
> > > +		hantro_reg_write(vpu, &av1_qmlevel_y, 0xff);
> > > +		hantro_reg_write(vpu, &av1_qmlevel_u, 0xff);
> > > +		hantro_reg_write(vpu, &av1_qmlevel_v, 0xff);
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_lossless_e, rockchip_vpu981_av1_dec_is_l=
ossless(ctx));
> > > +	hantro_reg_write(vpu, &av1_quant_delta_v_dc, ctrls->frame->quantiza=
tion.delta_q_v_dc);
> > > +	hantro_reg_write(vpu, &av1_quant_delta_v_ac, ctrls->frame->quantiza=
tion.delta_q_v_ac);
> > > +
> > > +	hantro_reg_write(vpu, &av1_skip_ref0,
> > > +			 (ctrls->frame->skip_mode_frame[0]) ? ctrls->frame->skip_mode_fra=
me[0] : 1);
> > > +	hantro_reg_write(vpu, &av1_skip_ref1,
> > > +			 (ctrls->frame->skip_mode_frame[1]) ? ctrls->frame->skip_mode_fra=
me[1] : 1);
> > > +
> > > +	hantro_write_addr(vpu, AV1_MC_SYNC_CURR, av1_dec->tile_buf.dma);
> > > +	hantro_write_addr(vpu, AV1_MC_SYNC_LEFT, av1_dec->tile_buf.dma);
> > > +}
> > > +
> > > +static void
> > > +rockchip_vpu981_av1_dec_set_input_buffer(struct hantro_ctx *ctx,
> > > +					 struct vb2_v4l2_buffer *vb2_src)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_av1_dec_ctrls *ctrls =3D &av1_dec->ctrls;
> > > +	const struct v4l2_ctrl_av1_tile_group_entry *group_entry =3D
> > > +	    ctrls->tile_group_entry;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	dma_addr_t src_dma;
> > > +	u32 src_len, src_buf_len;
> > > +	int start_bit, offset;
> > > +
> > > +	src_dma =3D vb2_dma_contig_plane_dma_addr(&vb2_src->vb2_buf, 0);
> > > +	src_len =3D vb2_get_plane_payload(&vb2_src->vb2_buf, 0);
> > > +	src_buf_len =3D vb2_plane_size(&vb2_src->vb2_buf, 0);
> > > +
> > > +	start_bit =3D (group_entry[0].tile_offset & 0xf) * 8;
> > > +	offset =3D group_entry[0].tile_offset & ~0xf;
> > > +
> > > +	hantro_reg_write(vpu, &av1_strm_buffer_len, src_buf_len);
> > > +	hantro_reg_write(vpu, &av1_strm_start_bit, start_bit);
> > > +	hantro_reg_write(vpu, &av1_stream_len, src_len);
> > > +	hantro_reg_write(vpu, &av1_strm_start_offset, 0);
> > > +	hantro_write_addr(vpu, AV1_INPUT_STREAM, src_dma + offset);
> > > +}
> > > +
> > > +static void
> > > +rockchip_vpu981_av1_dec_set_output_buffer(struct hantro_ctx *ctx)
> > > +{
> > > +	struct hantro_av1_dec_hw_ctx *av1_dec =3D &ctx->av1_dec;
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	struct hantro_decoded_buffer *dst;
> > > +	struct vb2_v4l2_buffer *vb2_dst;
> > > +	dma_addr_t luma_addr, chroma_addr, mv_addr =3D 0;
> > > +	size_t cr_offset =3D rockchip_vpu981_av1_dec_luma_size(ctx);
> > > +	size_t mv_offset =3D rockchip_vpu981_av1_dec_chroma_size(ctx);
> > > +
> > > +	vb2_dst =3D av1_dec->frame_refs[av1_dec->current_frame_index].vb2_r=
ef;
> > > +	dst =3D vb2_to_hantro_decoded_buf(&vb2_dst->vb2_buf);
> > > +	luma_addr =3D hantro_get_dec_buf_addr(ctx, &dst->base.vb.vb2_buf);
> > > +	chroma_addr =3D luma_addr + cr_offset;
> > > +	mv_addr =3D luma_addr + mv_offset;
> > > +
> > > +	hantro_write_addr(vpu, AV1_TILE_OUT_LU, luma_addr);
> > > +	hantro_write_addr(vpu, AV1_TILE_OUT_CH, chroma_addr);
> > > +	hantro_write_addr(vpu, AV1_TILE_OUT_MV, mv_addr);
> > > +}
> > > +
> > > +int rockchip_vpu981_av1_dec_run(struct hantro_ctx *ctx)
> > > +{
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	struct vb2_v4l2_buffer *vb2_src;
> > > +	int ret;
> > > +
> > > +	hantro_start_prepare_run(ctx);
> > > +
> > > +	ret =3D rockchip_vpu981_av1_dec_prepare_run(ctx);
> > > +	if (ret)
> > > +		goto prepare_error;
> > > +
> > > +	vb2_src =3D hantro_get_src_buf(ctx);
> > > +	if (!vb2_src)
> > > +		goto prepare_error;
> > > +
> > > +	rockchip_vpu981_av1_dec_clean_refs(ctx);
> > > +	rockchip_vpu981_av1_dec_frame_ref(ctx, vb2_src->vb2_buf.timestamp);
> > > +
> > > +	rockchip_vpu981_av1_dec_set_parameters(ctx);
> > > +	rockchip_vpu981_av1_dec_set_global_model(ctx);
> > > +	rockchip_vpu981_av1_dec_set_tile_info(ctx);
> > > +	rockchip_vpu981_av1_dec_set_reference_frames(ctx);
> > > +	rockchip_vpu981_av1_dec_set_segmentation(ctx);
> > > +	rockchip_vpu981_av1_dec_set_loopfilter(ctx);
> > > +	rockchip_vpu981_av1_dec_set_picture_dimensions(ctx);
> > > +	rockchip_vpu981_av1_dec_set_cdef(ctx);
> > > +	rockchip_vpu981_av1_dec_set_lr(ctx);
> > > +	rockchip_vpu981_av1_dec_set_prob(ctx);
> > > +
> > > +	hantro_reg_write(vpu, &av1_dec_mode, AV1_DEC_MODE);
> > > +	hantro_reg_write(vpu, &av1_dec_out_ec_byte_word, 0);
> > > +	hantro_reg_write(vpu, &av1_write_mvs_e, 1);
> > > +	hantro_reg_write(vpu, &av1_dec_out_ec_bypass, 1);
> > > +	hantro_reg_write(vpu, &av1_dec_clk_gate_e, 1);
> > > +
> > > +	hantro_reg_write(vpu, &av1_dec_abort_e, 0);
> > > +	hantro_reg_write(vpu, &av1_dec_tile_int_e, 0);
> > > +
> > > +	hantro_reg_write(vpu, &av1_dec_alignment, 64);
> > > +	hantro_reg_write(vpu, &av1_apf_disable, 0);
> > > +	hantro_reg_write(vpu, &av1_apf_threshold, 8);
> > > +	hantro_reg_write(vpu, &av1_dec_buswidth, 2);
> > > +	hantro_reg_write(vpu, &av1_dec_max_burst, 16);
> > > +	hantro_reg_write(vpu, &av1_error_conceal_e, 0);
> > > +	hantro_reg_write(vpu, &av1_axi_rd_ostd_threshold, 64);
> > > +	hantro_reg_write(vpu, &av1_axi_wr_ostd_threshold, 64);
> > > +
> > > +	hantro_reg_write(vpu, &av1_ext_timeout_cycles, 0xfffffff);
> > > +	hantro_reg_write(vpu, &av1_ext_timeout_override_e, 1);
> > > +	hantro_reg_write(vpu, &av1_timeout_cycles, 0xfffffff);
> > > +	hantro_reg_write(vpu, &av1_timeout_override_e, 1);
> > > +
> > > +	rockchip_vpu981_av1_dec_set_output_buffer(ctx);
> > > +	rockchip_vpu981_av1_dec_set_input_buffer(ctx, vb2_src);
> > > +
> > > +	hantro_end_prepare_run(ctx);
> > > +
> > > +	hantro_reg_write(vpu, &av1_dec_e, 1);
> > > +
> > > +	return 0;
> > > +
> > > +prepare_error:
> > > +	hantro_end_prepare_run(ctx);
> > > +	hantro_irq_done(vpu, VB2_BUF_STATE_ERROR);
> > > +	return ret;
> > > +}
> > > +
> > > +static void rockchip_vpu981_postproc_enable(struct hantro_ctx *ctx)
> > > +{
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +	int width =3D ctx->dst_fmt.width;
> > > +	int height =3D ctx->dst_fmt.height;
> > > +	struct vb2_v4l2_buffer *vb2_dst;
> > > +	size_t chroma_offset;
> > > +	dma_addr_t dst_dma;
> > > +
> > > +	vb2_dst =3D hantro_get_dst_buf(ctx);
> > > +
> > > +	dst_dma =3D vb2_dma_contig_plane_dma_addr(&vb2_dst->vb2_buf, 0);
> > > +	chroma_offset =3D ctx->dst_fmt.plane_fmt[0].bytesperline *
> > > +	    ctx->dst_fmt.height;
> > > +
> > > +	/* enable post processor */
> > > +	hantro_reg_write(vpu, &av1_pp_out_e, 1);
> > > +	hantro_reg_write(vpu, &av1_pp_in_format, 0);
> > > +	hantro_reg_write(vpu, &av1_pp0_dup_hor, 1);
> > > +	hantro_reg_write(vpu, &av1_pp0_dup_ver, 1);
> > > +
> > > +	hantro_reg_write(vpu, &av1_pp_in_height, height / 2);
> > > +	hantro_reg_write(vpu, &av1_pp_in_width, width / 2);
> > > +	hantro_reg_write(vpu, &av1_pp_out_height, height);
> > > +	hantro_reg_write(vpu, &av1_pp_out_width, width);
> > > +	hantro_reg_write(vpu, &av1_pp_out_y_stride,
> > > +			 ctx->dst_fmt.plane_fmt[0].bytesperline);
> > > +	hantro_reg_write(vpu, &av1_pp_out_c_stride,
> > > +			 ctx->dst_fmt.plane_fmt[0].bytesperline);
> > > +	switch (ctx->dst_fmt.pixelformat) {
> > > +	case V4L2_PIX_FMT_P010:
> > > +		hantro_reg_write(vpu, &av1_pp_out_format, 1);
> > > +		break;
> > > +	case V4L2_PIX_FMT_NV12:
> > > +		hantro_reg_write(vpu, &av1_pp_out_format, 3);
> > > +		break;
> > > +	default:
> > > +		hantro_reg_write(vpu, &av1_pp_out_format, 0);
> > > +	}
> > > +
> > > +	hantro_reg_write(vpu, &av1_ppd_blend_exist, 0);
> > > +	hantro_reg_write(vpu, &av1_ppd_dith_exist, 0);
> > > +	hantro_reg_write(vpu, &av1_ablend_crop_e, 0);
> > > +	hantro_reg_write(vpu, &av1_pp_format_customer1_e, 0);
> > > +	hantro_reg_write(vpu, &av1_pp_crop_exist, 0);
> > > +	hantro_reg_write(vpu, &av1_pp_up_level, 0);
> > > +	hantro_reg_write(vpu, &av1_pp_down_level, 0);
> > > +	hantro_reg_write(vpu, &av1_pp_exist, 0);
> > > +
> > > +	hantro_write_addr(vpu, AV1_PP_OUT_LU, dst_dma);
> > > +	hantro_write_addr(vpu, AV1_PP_OUT_CH, dst_dma + chroma_offset);
> > > +}
> > > +
> > > +static void rockchip_vpu981_postproc_disable(struct hantro_ctx *ctx)
> > > +{
> > > +	struct hantro_dev *vpu =3D ctx->dev;
> > > +
> > > +	/* disable post processor */
> > > +	hantro_reg_write(vpu, &av1_pp_out_e, 0);
> > > +}
> > > +
> > > +const struct hantro_postproc_ops rockchip_vpu981_postproc_ops =3D {
> > > +	.enable =3D rockchip_vpu981_postproc_enable,
> > > +	.disable =3D rockchip_vpu981_postproc_disable,
> > > +};
> > As enabling the post-proc is done by the common driver, we need a mecha=
nism to
> > altern the core decisions, as we really need to enable post-proc to pro=
duce
> > filmgrain. Fortunatly, not applying this filter isn't visually bad, but=
 that's
> > not the intent of the video author, so should not be like this by defau=
lt.
>=20
> I do agree but I think it is out of the scope of this patch.

I believe I managed to changed your mind, please do carry these discussions=
 in
public place though, linux-media IRC channel is a good place.

>=20
> >=20
> > > diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_regs.=
h b/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
> > > new file mode 100644
> > > index 000000000000..182e6c830ff6
> > > --- /dev/null
> > > +++ b/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
> > > @@ -0,0 +1,477 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (c) 2022, Collabora
> > > + *
> > > + * Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > + */
> > > +
> > > +#ifndef _ROCKCHIP_VPU981_REGS_H_
> > > +#define _ROCKCHIP_VPU981_REGS_H_
> > > +
> > > +#include "hantro.h"
> > > +
> > > +#define AV1_SWREG(nr)	((nr) * 4)
> > > +
> > > +#define AV1_DEC_REG(b, s, m) \
> > > +	((const struct hantro_reg) { \
> > > +		.base =3D AV1_SWREG(b), \
> > > +		.shift =3D s, \
> > > +		.mask =3D m, \
> > > +	})
> > Just a note that a lot of this is identical to VC8000 register sets. Bu=
t until
> > someone upstream VC8000 and till we have more VC9000 support, its fine =
to keep
> > that as if it was RK specific.
> >=20
> > > +
> > > +#define AV1_REG_INTERRUPT		AV1_SWREG(1)
> > > +#define AV1_REG_INTERRUPT_DEC_RDY_INT	BIT(12)
> > > +
> > > +#define AV1_REG_CONFIG			AV1_SWREG(2)
> > > +#define AV1_REG_CONFIG_DEC_CLK_GATE_E	BIT(10)
> > > +
> > > +#define av1_dec_e			AV1_DEC_REG(1, 0, 0x1)
> > > +#define av1_dec_abort_e			AV1_DEC_REG(1, 5, 0x1)
> > > +#define av1_dec_tile_int_e		AV1_DEC_REG(1, 7, 0x1)
> > > +
> > > +#define av1_dec_clk_gate_e		AV1_DEC_REG(2, 10, 0x1)
> > > +
> > > +#define av1_dec_out_ec_bypass		AV1_DEC_REG(3, 8,  0x1)
> > > +#define av1_write_mvs_e			AV1_DEC_REG(3, 12, 0x1)
> > > +#define av1_filtering_dis		AV1_DEC_REG(3, 14, 0x1)
> > > +#define av1_dec_out_dis			AV1_DEC_REG(3, 15, 0x1)
> > > +#define av1_dec_out_ec_byte_word	AV1_DEC_REG(3, 16, 0x1)
> > > +#define av1_skip_mode			AV1_DEC_REG(3, 26, 0x1)
> > > +#define av1_dec_mode			AV1_DEC_REG(3, 27, 0x1f)
> > > +
> > > +#define av1_ref_frames			AV1_DEC_REG(4, 0, 0xf)
> > > +#define av1_pic_height_in_cbs		AV1_DEC_REG(4, 6, 0x1fff)
> > > +#define av1_pic_width_in_cbs		AV1_DEC_REG(4, 19, 0x1fff)
> > > +
> > > +#define av1_ref_scaling_enable		AV1_DEC_REG(5, 0, 0x1)
> > > +#define av1_filt_level_base_gt32	AV1_DEC_REG(5, 1, 0x1)
> > > +#define av1_error_resilient		AV1_DEC_REG(5, 2, 0x1)
> > > +#define av1_force_interger_mv		AV1_DEC_REG(5, 3, 0x1)
> > > +#define av1_allow_intrabc		AV1_DEC_REG(5, 4, 0x1)
> > > +#define av1_allow_screen_content_tools	AV1_DEC_REG(5, 5, 0x1)
> > > +#define av1_reduced_tx_set_used		AV1_DEC_REG(5, 6, 0x1)
> > > +#define av1_enable_dual_filter		AV1_DEC_REG(5, 7, 0x1)
> > > +#define av1_enable_jnt_comp		AV1_DEC_REG(5, 8, 0x1)
> > > +#define av1_allow_filter_intra		AV1_DEC_REG(5, 9, 0x1)
> > > +#define av1_enable_intra_edge_filter	AV1_DEC_REG(5, 10, 0x1)
> > > +#define av1_tempor_mvp_e		AV1_DEC_REG(5, 11, 0x1)
> > > +#define av1_allow_interintra		AV1_DEC_REG(5, 12, 0x1)
> > > +#define av1_allow_masked_compound	AV1_DEC_REG(5, 13, 0x1)
> > > +#define av1_enable_cdef			AV1_DEC_REG(5, 14, 0x1)
> > > +#define av1_switchable_motion_mode	AV1_DEC_REG(5, 15, 0x1)
> > > +#define av1_show_frame			AV1_DEC_REG(5, 16, 0x1)
> > > +#define av1_superres_is_scaled		AV1_DEC_REG(5, 17, 0x1)
> > > +#define av1_allow_warp			AV1_DEC_REG(5, 18, 0x1)
> > > +#define av1_disable_cdf_update		AV1_DEC_REG(5, 19, 0x1)
> > > +#define av1_preskip_segid		AV1_DEC_REG(5, 20, 0x1)
> > > +#define av1_delta_lf_present		AV1_DEC_REG(5, 21, 0x1)
> > > +#define av1_delta_lf_multi		AV1_DEC_REG(5, 22, 0x1)
> > > +#define av1_delta_lf_res_log		AV1_DEC_REG(5, 23, 0x3)
> > > +#define av1_strm_start_bit		AV1_DEC_REG(5, 25, 0x7f)
> > > +
> > > +#define	av1_stream_len			AV1_DEC_REG(6, 0, 0xffffffff)
> > > +
> > > +#define av1_delta_q_present		AV1_DEC_REG(7, 0, 0x1)
> > > +#define av1_delta_q_res_log		AV1_DEC_REG(7, 1, 0x3)
> > > +#define av1_cdef_damping		AV1_DEC_REG(7, 3, 0x3)
> > > +#define av1_cdef_bits			AV1_DEC_REG(7, 5, 0x3)
> > > +#define av1_apply_grain			AV1_DEC_REG(7, 7, 0x1)
> > > +#define av1_num_y_points_b		AV1_DEC_REG(7, 8, 0x1)
> > > +#define av1_num_cb_points_b		AV1_DEC_REG(7, 9, 0x1)
> > > +#define av1_num_cr_points_b		AV1_DEC_REG(7, 10, 0x1)
> > > +#define av1_overlap_flag		AV1_DEC_REG(7, 11, 0x1)
> > > +#define av1_clip_to_restricted_range	AV1_DEC_REG(7, 12, 0x1)
> > > +#define av1_chroma_scaling_from_luma	AV1_DEC_REG(7, 13, 0x1)
> > > +#define av1_random_seed			AV1_DEC_REG(7, 14, 0xffff)
> > > +#define av1_blackwhite_e		AV1_DEC_REG(7, 30, 0x1)
> > > +
> > > +#define av1_scaling_shift		AV1_DEC_REG(8, 0, 0xf)
> > > +#define av1_bit_depth_c_minus8		AV1_DEC_REG(8, 4, 0x3)
> > > +#define av1_bit_depth_y_minus8		AV1_DEC_REG(8, 6, 0x3)
> > > +#define av1_quant_base_qindex		AV1_DEC_REG(8, 8, 0xff)
> > > +#define av1_idr_pic_e			AV1_DEC_REG(8, 16, 0x1)
> > > +#define av1_superres_pic_width		AV1_DEC_REG(8, 17, 0x7fff)
> > > +
> > > +#define av1_ref4_sign_bias		AV1_DEC_REG(9, 2, 0x1)
> > > +#define av1_ref5_sign_bias		AV1_DEC_REG(9, 3, 0x1)
> > > +#define av1_ref6_sign_bias		AV1_DEC_REG(9, 4, 0x1)
> > > +#define av1_mf1_type			AV1_DEC_REG(9, 5, 0x7)
> > > +#define av1_mf2_type			AV1_DEC_REG(9, 8, 0x7)
> > > +#define av1_mf3_type			AV1_DEC_REG(9, 11, 0x7)
> > > +#define av1_scale_denom_minus9		AV1_DEC_REG(9, 14, 0x7)
> > > +#define av1_last_active_seg		AV1_DEC_REG(9, 17, 0x7)
> > > +#define av1_context_update_tile_id	AV1_DEC_REG(9, 20, 0xfff)
> > > +
> > > +#define av1_tile_transpose		AV1_DEC_REG(10, 0, 0x1)
> > > +#define av1_tile_enable			AV1_DEC_REG(10, 1, 0x1)
> > > +#define av1_multicore_full_width	AV1_DEC_REG(10,	2, 0xff)
> > > +#define av1_num_tile_rows_8k		AV1_DEC_REG(10, 10, 0x7f)
> > > +#define av1_num_tile_cols_8k		AV1_DEC_REG(10, 17, 0x7f)
> > > +#define av1_multicore_tile_start_x	AV1_DEC_REG(10, 24, 0xff)
> > > +
> > > +#define av1_use_temporal3_mvs		AV1_DEC_REG(11, 0, 0x1)
> > > +#define av1_use_temporal2_mvs		AV1_DEC_REG(11, 1, 0x1)
> > > +#define av1_use_temporal1_mvs		AV1_DEC_REG(11, 2, 0x1)
> > > +#define av1_use_temporal0_mvs		AV1_DEC_REG(11, 3, 0x1)
> > > +#define av1_comp_pred_mode		AV1_DEC_REG(11, 4, 0x3)
> > > +#define av1_high_prec_mv_e		AV1_DEC_REG(11, 7, 0x1)
> > > +#define av1_mcomp_filt_type		AV1_DEC_REG(11, 8, 0x7)
> > > +#define av1_multicore_expect_context_update	AV1_DEC_REG(11, 11, 0x1)
> > > +#define av1_multicore_sbx_offset	AV1_DEC_REG(11, 12, 0x7f)
> > > +#define av1_ulticore_tile_col		AV1_DEC_REG(11, 19, 0x7f)
> > > +#define av1_transform_mode		AV1_DEC_REG(11, 27, 0x7)
> > > +#define av1_dec_tile_size_mag		AV1_DEC_REG(11, 30, 0x3)
> > > +
> > > +#define av1_seg_quant_sign		AV1_DEC_REG(12, 2, 0xff)
> > > +#define av1_max_cb_size			AV1_DEC_REG(12, 10, 0x7)
> > > +#define av1_min_cb_size			AV1_DEC_REG(12, 13, 0x7)
> > > +#define av1_comp_pred_fixed_ref		AV1_DEC_REG(12, 16, 0x7)
> > > +#define av1_multicore_tile_width	AV1_DEC_REG(12, 19, 0x7f)
> > > +#define av1_pic_height_pad		AV1_DEC_REG(12, 26, 0x7)
> > > +#define av1_pic_width_pad		AV1_DEC_REG(12, 29, 0x7)
> > > +
> > > +#define av1_segment_e			AV1_DEC_REG(13, 0, 0x1)
> > > +#define av1_segment_upd_e		AV1_DEC_REG(13, 1, 0x1)
> > > +#define av1_segment_temp_upd_e		AV1_DEC_REG(13, 2, 0x1)
> > > +#define av1_comp_pred_var_ref0_av1	AV1_DEC_REG(13, 3, 0x7)
> > > +#define av1_comp_pred_var_ref1_av1	AV1_DEC_REG(13, 6, 0x7)
> > > +#define av1_lossless_e			AV1_DEC_REG(13, 9, 0x1)
> > > +#define av1_qp_delta_ch_ac_av1		AV1_DEC_REG(13, 11, 0x7f)
> > > +#define av1_qp_delta_ch_dc_av1		AV1_DEC_REG(13, 18, 0x7f)
> > > +#define av1_qp_delta_y_dc_av1		AV1_DEC_REG(13, 25, 0x7f)
> > > +
> > > +#define av1_quant_seg0			AV1_DEC_REG(14, 0, 0xff)
> > > +#define av1_filt_level_seg0		AV1_DEC_REG(14, 8, 0x3f)
> > > +#define av1_skip_seg0			AV1_DEC_REG(14, 14, 0x1)
> > > +#define av1_refpic_seg0			AV1_DEC_REG(14, 15, 0xf)
> > > +#define av1_filt_level_delta0_seg0	AV1_DEC_REG(14, 19, 0x7f)
> > > +#define av1_filt_level0			AV1_DEC_REG(14, 26, 0x3f)
> > > +
> > > +#define av1_quant_seg1			AV1_DEC_REG(15, 0, 0xff)
> > > +#define av1_filt_level_seg1		AV1_DEC_REG(15, 8, 0x3f)
> > > +#define av1_skip_seg1			AV1_DEC_REG(15, 14, 0x1)
> > > +#define av1_refpic_seg1			AV1_DEC_REG(15, 15, 0xf)
> > > +#define av1_filt_level_delta0_seg1	AV1_DEC_REG(15, 19, 0x7f)
> > > +#define av1_filt_level1			AV1_DEC_REG(15, 26, 0x3f)
> > > +
> > > +#define av1_quant_seg2			AV1_DEC_REG(16, 0, 0xff)
> > > +#define av1_filt_level_seg2		AV1_DEC_REG(16, 8, 0x3f)
> > > +#define av1_skip_seg2			AV1_DEC_REG(16, 14, 0x1)
> > > +#define av1_refpic_seg2			AV1_DEC_REG(16, 15, 0xf)
> > > +#define av1_filt_level_delta0_seg2	AV1_DEC_REG(16, 19, 0x7f)
> > > +#define av1_filt_level2			AV1_DEC_REG(16, 26, 0x3f)
> > > +
> > > +#define av1_quant_seg3			AV1_DEC_REG(17, 0, 0xff)
> > > +#define av1_filt_level_seg3		AV1_DEC_REG(17, 8, 0x3f)
> > > +#define av1_skip_seg3			AV1_DEC_REG(17, 14, 0x1)
> > > +#define av1_refpic_seg3			AV1_DEC_REG(17, 15, 0xf)
> > > +#define av1_filt_level_delta0_seg3	AV1_DEC_REG(17, 19, 0x7f)
> > > +#define av1_filt_level3			AV1_DEC_REG(17, 26, 0x3f)
> > > +
> > > +#define av1_quant_seg4			AV1_DEC_REG(18, 0, 0xff)
> > > +#define av1_filt_level_seg4		AV1_DEC_REG(18, 8, 0x3f)
> > > +#define av1_skip_seg4			AV1_DEC_REG(18, 14, 0x1)
> > > +#define av1_refpic_seg4			AV1_DEC_REG(18, 15, 0xf)
> > > +#define av1_filt_level_delta0_seg4	AV1_DEC_REG(18, 19, 0x7f)
> > > +#define av1_lr_type			AV1_DEC_REG(18, 26, 0x3f)
> > > +
> > > +#define av1_quant_seg5			AV1_DEC_REG(19, 0, 0xff)
> > > +#define av1_filt_level_seg5		AV1_DEC_REG(19, 8, 0x3f)
> > > +#define av1_skip_seg5			AV1_DEC_REG(19, 14, 0x1)
> > > +#define av1_refpic_seg5			AV1_DEC_REG(19, 15, 0xf)
> > > +#define av1_filt_level_delta0_seg5	AV1_DEC_REG(19, 19, 0x7f)
> > > +#define av1_lr_unit_size		AV1_DEC_REG(19, 26, 0x3f)
> > > +
> > > +#define av1_filt_level_delta1_seg0	AV1_DEC_REG(20, 0, 0x7f)
> > > +#define av1_filt_level_delta2_seg0	AV1_DEC_REG(20, 7, 0x7f)
> > > +#define av1_filt_level_delta3_seg0	AV1_DEC_REG(20, 14, 0x7f)
> > > +#define av1_global_mv_seg0		AV1_DEC_REG(20, 21, 0x1)
> > > +#define av1_mf1_last_offset		AV1_DEC_REG(20, 22, 0x1ff)
> > > +
> > > +#define av1_filt_level_delta1_seg1	AV1_DEC_REG(21, 0, 0x7f)
> > > +#define av1_filt_level_delta2_seg1	AV1_DEC_REG(21, 7, 0x7f)
> > > +#define av1_filt_level_delta3_seg1	AV1_DEC_REG(21, 14, 0x7f)
> > > +#define av1_global_mv_seg1		AV1_DEC_REG(21, 21, 0x1)
> > > +#define av1_mf1_last2_offset		AV1_DEC_REG(21, 22, 0x1ff)
> > > +
> > > +#define av1_filt_level_delta1_seg2	AV1_DEC_REG(22, 0, 0x7f)
> > > +#define av1_filt_level_delta2_seg2	AV1_DEC_REG(22, 7, 0x7f)
> > > +#define av1_filt_level_delta3_seg2	AV1_DEC_REG(22, 14, 0x7f)
> > > +#define av1_global_mv_seg2		AV1_DEC_REG(22, 21, 0x1)
> > > +#define av1_mf1_last3_offset		AV1_DEC_REG(22, 22, 0x1ff)
> > > +
> > > +#define av1_filt_level_delta1_seg3	AV1_DEC_REG(23, 0, 0x7f)
> > > +#define av1_filt_level_delta2_seg3	AV1_DEC_REG(23, 7, 0x7f)
> > > +#define av1_filt_level_delta3_seg3	AV1_DEC_REG(23, 14, 0x7f)
> > > +#define av1_global_mv_seg3		AV1_DEC_REG(23, 21, 0x1)
> > > +#define av1_mf1_golden_offset		AV1_DEC_REG(23, 22, 0x1ff)
> > > +
> > > +#define av1_filt_level_delta1_seg4	AV1_DEC_REG(24, 0, 0x7f)
> > > +#define av1_filt_level_delta2_seg4	AV1_DEC_REG(24, 7, 0x7f)
> > > +#define av1_filt_level_delta3_seg4	AV1_DEC_REG(24, 14, 0x7f)
> > > +#define av1_global_mv_seg4		AV1_DEC_REG(24, 21, 0x1)
> > > +#define av1_mf1_bwdref_offset		AV1_DEC_REG(24, 22, 0x1ff)
> > > +
> > > +#define av1_filt_level_delta1_seg5	AV1_DEC_REG(25, 0, 0x7f)
> > > +#define av1_filt_level_delta2_seg5	AV1_DEC_REG(25, 7, 0x7f)
> > > +#define av1_filt_level_delta3_seg5	AV1_DEC_REG(25, 14, 0x7f)
> > > +#define av1_global_mv_seg5		AV1_DEC_REG(25, 21, 0x1)
> > > +#define av1_mf1_altref2_offset		AV1_DEC_REG(25, 22, 0x1ff)
> > > +
> > > +#define av1_filt_level_delta1_seg6	AV1_DEC_REG(26, 0, 0x7f)
> > > +#define av1_filt_level_delta2_seg6	AV1_DEC_REG(26, 7, 0x7f)
> > > +#define av1_filt_level_delta3_seg6	AV1_DEC_REG(26, 14, 0x7f)
> > > +#define av1_global_mv_seg6		AV1_DEC_REG(26, 21, 0x1)
> > > +#define av1_mf1_altref_offset		AV1_DEC_REG(26, 22, 0x1ff)
> > > +
> > > +#define av1_filt_level_delta1_seg7	AV1_DEC_REG(27, 0, 0x7f)
> > > +#define av1_filt_level_delta2_seg7	AV1_DEC_REG(27, 7, 0x7f)
> > > +#define av1_filt_level_delta3_seg7	AV1_DEC_REG(27, 14, 0x7f)
> > > +#define av1_global_mv_seg7		AV1_DEC_REG(27, 21, 0x1)
> > > +#define av1_mf2_last_offset		AV1_DEC_REG(27, 22, 0x1ff)
> > > +
> > > +#define av1_cb_offset			AV1_DEC_REG(28, 0, 0x1ff)
> > > +#define av1_cb_luma_mult		AV1_DEC_REG(28, 9, 0xff)
> > > +#define av1_cb_mult			AV1_DEC_REG(28, 17, 0xff)
> > > +#define	av1_quant_delta_v_dc		AV1_DEC_REG(28, 25, 0x7f)
> > > +
> > > +#define av1_cr_offset			AV1_DEC_REG(29, 0, 0x1ff)
> > > +#define av1_cr_luma_mult		AV1_DEC_REG(29, 9, 0xff)
> > > +#define av1_cr_mult			AV1_DEC_REG(29, 17, 0xff)
> > > +#define	av1_quant_delta_v_ac		AV1_DEC_REG(29, 25, 0x7f)
> > > +
> > > +#define av1_filt_ref_adj_5		AV1_DEC_REG(30, 0, 0x7f)
> > > +#define av1_filt_ref_adj_4		AV1_DEC_REG(30, 7, 0x7f)
> > > +#define av1_filt_mb_adj_1		AV1_DEC_REG(30, 14, 0x7f)
> > > +#define av1_filt_mb_adj_0		AV1_DEC_REG(30, 21, 0x7f)
> > > +#define av1_filt_sharpness		AV1_DEC_REG(30, 28, 0x7)
> > > +
> > > +#define av1_quant_seg6			AV1_DEC_REG(31, 0, 0xff)
> > > +#define av1_filt_level_seg6		AV1_DEC_REG(31, 8, 0x3f)
> > > +#define av1_skip_seg6			AV1_DEC_REG(31, 14, 0x1)
> > > +#define av1_refpic_seg6			AV1_DEC_REG(31, 15, 0xf)
> > > +#define av1_filt_level_delta0_seg6	AV1_DEC_REG(31, 19, 0x7f)
> > > +#define av1_skip_ref0			AV1_DEC_REG(31, 26, 0xf)
> > > +
> > > +#define av1_quant_seg7			AV1_DEC_REG(32, 0, 0xff)
> > > +#define av1_filt_level_seg7		AV1_DEC_REG(32, 8, 0x3f)
> > > +#define av1_skip_seg7			AV1_DEC_REG(32, 14, 0x1)
> > > +#define av1_refpic_seg7			AV1_DEC_REG(32, 15, 0xf)
> > > +#define av1_filt_level_delta0_seg7	AV1_DEC_REG(32, 19, 0x7f)
> > > +#define av1_skip_ref1			AV1_DEC_REG(32, 26, 0xf)
> > > +
> > > +#define av1_ref0_height			AV1_DEC_REG(33, 0, 0xffff)
> > > +#define av1_ref0_width			AV1_DEC_REG(33, 16, 0xffff)
> > > +
> > > +#define av1_ref1_height			AV1_DEC_REG(34, 0, 0xffff)
> > > +#define av1_ref1_width			AV1_DEC_REG(34, 16, 0xffff)
> > > +
> > > +#define av1_ref2_height			AV1_DEC_REG(35, 0, 0xffff)
> > > +#define av1_ref2_width			AV1_DEC_REG(35, 16, 0xffff)
> > > +
> > > +#define av1_ref0_ver_scale		AV1_DEC_REG(36, 0, 0xffff)
> > > +#define av1_ref0_hor_scale		AV1_DEC_REG(36, 16, 0xffff)
> > > +
> > > +#define av1_ref1_ver_scale		AV1_DEC_REG(37, 0, 0xffff)
> > > +#define av1_ref1_hor_scale		AV1_DEC_REG(37, 16, 0xffff)
> > > +
> > > +#define av1_ref2_ver_scale		AV1_DEC_REG(38, 0, 0xffff)
> > > +#define av1_ref2_hor_scale		AV1_DEC_REG(38, 16, 0xffff)
> > > +
> > > +#define av1_ref3_ver_scale		AV1_DEC_REG(39, 0, 0xffff)
> > > +#define av1_ref3_hor_scale		AV1_DEC_REG(39, 16, 0xffff)
> > > +
> > > +#define av1_ref4_ver_scale		AV1_DEC_REG(40, 0, 0xffff)
> > > +#define av1_ref4_hor_scale		AV1_DEC_REG(40, 16, 0xffff)
> > > +
> > > +#define av1_ref5_ver_scale		AV1_DEC_REG(41, 0, 0xffff)
> > > +#define av1_ref5_hor_scale		AV1_DEC_REG(41, 16, 0xffff)
> > > +
> > > +#define av1_ref6_ver_scale		AV1_DEC_REG(42, 0, 0xffff)
> > > +#define av1_ref6_hor_scale		AV1_DEC_REG(42, 16, 0xffff)
> > > +
> > > +#define av1_ref3_height			AV1_DEC_REG(43, 0, 0xffff)
> > > +#define av1_ref3_width			AV1_DEC_REG(43, 16, 0xffff)
> > > +
> > > +#define av1_ref4_height			AV1_DEC_REG(44, 0, 0xffff)
> > > +#define av1_ref4_width			AV1_DEC_REG(44, 16, 0xffff)
> > > +
> > > +#define av1_ref5_height			AV1_DEC_REG(45, 0, 0xffff)
> > > +#define av1_ref5_width			AV1_DEC_REG(45, 16, 0xffff)
> > > +
> > > +#define av1_ref6_height			AV1_DEC_REG(46, 0, 0xffff)
> > > +#define av1_ref6_width			AV1_DEC_REG(46, 16, 0xffff)
> > > +
> > > +#define av1_mf2_last2_offset		AV1_DEC_REG(47, 0, 0x1ff)
> > > +#define av1_mf2_last3_offset		AV1_DEC_REG(47, 9, 0x1ff)
> > > +#define av1_mf2_golden_offset		AV1_DEC_REG(47, 18, 0x1ff)
> > > +#define av1_qmlevel_y			AV1_DEC_REG(47, 27, 0xf)
> > > +
> > > +#define av1_mf2_bwdref_offset		AV1_DEC_REG(48, 0, 0x1ff)
> > > +#define av1_mf2_altref2_offset		AV1_DEC_REG(48, 9, 0x1ff)
> > > +#define av1_mf2_altref_offset		AV1_DEC_REG(48, 18, 0x1ff)
> > > +#define av1_qmlevel_u			AV1_DEC_REG(48, 27, 0xf)
> > > +
> > > +#define av1_filt_ref_adj_6		AV1_DEC_REG(49, 0, 0x7f)
> > > +#define av1_filt_ref_adj_7		AV1_DEC_REG(49, 7, 0x7f)
> > > +#define av1_qmlevel_v			AV1_DEC_REG(49, 14, 0xf)
> > > +
> > > +#define av1_superres_chroma_step	AV1_DEC_REG(51, 0, 0x3fff)
> > > +#define av1_superres_luma_step		AV1_DEC_REG(51, 14, 0x3fff)
> > > +
> > > +#define av1_superres_init_chroma_subpel_x	AV1_DEC_REG(52, 0, 0x3fff)
> > > +#define av1_superres_init_luma_subpel_x		AV1_DEC_REG(52, 14, 0x3fff)
> > > +
> > > +#define av1_cdef_chroma_secondary_strength	AV1_DEC_REG(53, 0, 0xffff=
)
> > > +#define av1_cdef_luma_secondary_strength	AV1_DEC_REG(53, 16, 0xffff)
> > > +
> > > +#define av1_apf_threshold		AV1_DEC_REG(55, 0, 0xffff)
> > > +#define av1_apf_single_pu_mode		AV1_DEC_REG(55, 30, 0x1)
> > > +#define av1_apf_disable			AV1_DEC_REG(55, 30, 0x1)
> > > +
> > > +#define av1_dec_max_burst		AV1_DEC_REG(58, 0, 0xff)
> > > +#define av1_dec_buswidth		AV1_DEC_REG(58, 8, 0x7)
> > > +#define av1_dec_multicore_mode		AV1_DEC_REG(58, 11, 0x3)
> > > +#define av1_dec_axi_wd_id_e		AV1_DEC_REG(58,	13, 0x1)
> > > +#define av1_dec_axi_rd_id_e		AV1_DEC_REG(58, 14, 0x1)
> > > +#define av1_dec_mc_polltime		AV1_DEC_REG(58, 17, 0x3ff)
> > > +#define av1_dec_mc_pollmode		AV1_DEC_REG(58,	27, 0x3)
> > > +
> > > +#define av1_filt_ref_adj_3		AV1_DEC_REG(59, 0, 0x3f)
> > > +#define av1_filt_ref_adj_2		AV1_DEC_REG(59, 7, 0x3f)
> > > +#define av1_filt_ref_adj_1		AV1_DEC_REG(59, 14, 0x3f)
> > > +#define av1_filt_ref_adj_0		AV1_DEC_REG(59, 21, 0x3f)
> > > +#define av1_ref0_sign_bias		AV1_DEC_REG(59, 28, 0x1)
> > > +#define av1_ref1_sign_bias		AV1_DEC_REG(59, 29, 0x1)
> > > +#define av1_ref2_sign_bias		AV1_DEC_REG(59, 30, 0x1)
> > > +#define av1_ref3_sign_bias		AV1_DEC_REG(59, 31, 0x1)
> > > +
> > > +#define av1_cur_last_roffset		AV1_DEC_REG(184, 0, 0x1ff)
> > > +#define av1_cur_last_offset		AV1_DEC_REG(184, 9, 0x1ff)
> > > +#define av1_mf3_last_offset		AV1_DEC_REG(184, 18, 0x1ff)
> > > +#define av1_ref0_gm_mode		AV1_DEC_REG(184, 27, 0x3)
> > > +
> > > +#define av1_cur_last2_roffset		AV1_DEC_REG(185, 0, 0x1ff)
> > > +#define av1_cur_last2_offset		AV1_DEC_REG(185, 9, 0x1ff)
> > > +#define av1_mf3_last2_offset		AV1_DEC_REG(185, 18, 0x1ff)
> > > +#define av1_ref1_gm_mode		AV1_DEC_REG(185, 27, 0x3)
> > > +
> > > +#define av1_cur_last3_roffset		AV1_DEC_REG(186, 0, 0x1ff)
> > > +#define av1_cur_last3_offset		AV1_DEC_REG(186, 9, 0x1ff)
> > > +#define av1_mf3_last3_offset		AV1_DEC_REG(186, 18, 0x1ff)
> > > +#define av1_ref2_gm_mode		AV1_DEC_REG(186, 27, 0x3)
> > > +
> > > +#define av1_cur_golden_roffset		AV1_DEC_REG(187, 0, 0x1ff)
> > > +#define av1_cur_golden_offset		AV1_DEC_REG(187, 9, 0x1ff)
> > > +#define av1_mf3_golden_offset		AV1_DEC_REG(187, 18, 0x1ff)
> > > +#define av1_ref3_gm_mode		AV1_DEC_REG(187, 27, 0x3)
> > > +
> > > +#define av1_cur_bwdref_roffset		AV1_DEC_REG(188, 0, 0x1ff)
> > > +#define av1_cur_bwdref_offset		AV1_DEC_REG(188, 9, 0x1ff)
> > > +#define av1_mf3_bwdref_offset		AV1_DEC_REG(188, 18, 0x1ff)
> > > +#define av1_ref4_gm_mode		AV1_DEC_REG(188, 27, 0x3)
> > > +
> > > +#define av1_cur_altref2_roffset		AV1_DEC_REG(257, 0, 0x1ff)
> > > +#define av1_cur_altref2_offset		AV1_DEC_REG(257, 9, 0x1ff)
> > > +#define av1_mf3_altref2_offset		AV1_DEC_REG(257, 18, 0x1ff)
> > > +#define av1_ref5_gm_mode		AV1_DEC_REG(257, 27, 0x3)
> > > +
> > > +#define av1_strm_buffer_len		AV1_DEC_REG(258, 0, 0xffffffff)
> > > +
> > > +#define av1_strm_start_offset		AV1_DEC_REG(259, 0, 0xffffffff)
> > > +
> > > +#define av1_ppd_blend_exist		AV1_DEC_REG(260, 21, 0x1)
> > > +#define av1_ppd_dith_exist		AV1_DEC_REG(260, 23, 0x1)
> > > +#define av1_ablend_crop_e		AV1_DEC_REG(260, 24, 0x1)
> > > +#define av1_pp_format_p010_e		AV1_DEC_REG(260, 25, 0x1)
> > > +#define av1_pp_format_customer1_e	AV1_DEC_REG(260, 26, 0x1)
> > > +#define av1_pp_crop_exist		AV1_DEC_REG(260, 27, 0x1)
> > > +#define av1_pp_up_level			AV1_DEC_REG(260, 28, 0x1)
> > > +#define av1_pp_down_level		AV1_DEC_REG(260, 29, 0x3)
> > > +#define av1_pp_exist			AV1_DEC_REG(260, 31, 0x1)
> > > +
> > > +#define av1_cur_altref_roffset		AV1_DEC_REG(262, 0, 0x1ff)
> > > +#define av1_cur_altref_offset		AV1_DEC_REG(262, 9, 0x1ff)
> > > +#define av1_mf3_altref_offset		AV1_DEC_REG(262, 18, 0x1ff)
> > > +#define av1_ref6_gm_mode		AV1_DEC_REG(262, 27, 0x3)
> > > +
> > > +#define av1_cdef_luma_primary_strength	AV1_DEC_REG(263, 0, 0xfffffff=
f)
> > > +
> > > +#define av1_cdef_chroma_primary_strength AV1_DEC_REG(264, 0, 0xfffff=
fff)
> > > +
> > > +#define av1_axi_arqos			AV1_DEC_REG(265, 0, 0xf)
> > > +#define av1_axi_awqos			AV1_DEC_REG(265, 4, 0xf)
> > > +#define av1_axi_wr_ostd_threshold	AV1_DEC_REG(265, 8, 0x3ff)
> > > +#define av1_axi_rd_ostd_threshold	AV1_DEC_REG(265, 18, 0x3ff)
> > > +#define av1_axi_wr_4k_dis		AV1_DEC_REG(265, 31, 0x1)
> > > +
> > > +#define av1_128bit_mode			AV1_DEC_REG(266, 5, 0x1)
> > > +#define av1_wr_shaper_bypass		AV1_DEC_REG(266, 10, 0x1)
> > > +#define av1_error_conceal_e		AV1_DEC_REG(266, 30, 0x1)
> > > +
> > > +#define av1_superres_chroma_step_invra	AV1_DEC_REG(298, 0, 0xffff)
> > > +#define av1_superres_luma_step_invra	AV1_DEC_REG(298, 16, 0xffff)
> > > +
> > > +#define av1_dec_alignment		AV1_DEC_REG(314, 0, 0xffff)
> > > +
> > > +#define av1_ext_timeout_cycles		AV1_DEC_REG(318, 0, 0x7fffffff)
> > > +#define av1_ext_timeout_override_e	AV1_DEC_REG(318, 31, 0x1)
> > > +
> > > +#define av1_timeout_cycles		AV1_DEC_REG(319, 0, 0x7fffffff)
> > > +#define av1_timeout_override_e		AV1_DEC_REG(319, 31, 0x1)
> > > +
> > > +#define av1_pp_out_e			AV1_DEC_REG(320, 0, 0x1)
> > > +#define av1_pp_cr_first			AV1_DEC_REG(320, 1, 0x1)
> > > +#define av1_pp_out_mode			AV1_DEC_REG(320, 2, 0x1)
> > > +#define av1_pp_out_tile_e		AV1_DEC_REG(320, 3, 0x1)
> > > +#define av1_pp_status			AV1_DEC_REG(320, 4, 0xf)
> > > +#define av1_pp_in_blk_size		AV1_DEC_REG(320, 8, 0x7)
> > > +#define av1_pp_out_p010_fmt		AV1_DEC_REG(320, 11, 0x3)
> > > +#define av1_pp_out_rgb_fmt		AV1_DEC_REG(320, 13, 0x1f)
> > > +#define av1_rgb_range_max		AV1_DEC_REG(320, 18, 0xfff)
> > > +#define av1_pp_rgb_planar		AV1_DEC_REG(320, 30, 0x1)
> > > +
> > > +#define av1_scale_hratio		AV1_DEC_REG(322, 0, 0x3ffff)
> > > +#define av1_pp_out_format		AV1_DEC_REG(322, 18, 0x1f)
> > > +#define av1_ver_scale_mode		AV1_DEC_REG(322, 23, 0x3)
> > > +#define av1_hor_scale_mode		AV1_DEC_REG(322, 25, 0x3)
> > > +#define av1_pp_in_format		AV1_DEC_REG(322, 27, 0x1f)
> > > +
> > > +#define av1_pp_out_c_stride		AV1_DEC_REG(329, 0, 0xffff)
> > > +#define av1_pp_out_y_stride		AV1_DEC_REG(329, 16, 0xffff)
> > > +
> > > +#define av1_pp_in_height		AV1_DEC_REG(331, 0, 0xffff)
> > > +#define av1_pp_in_width			AV1_DEC_REG(331, 16, 0xffff)
> > > +
> > > +#define av1_pp_out_height		AV1_DEC_REG(332, 0, 0xffff)
> > > +#define av1_pp_out_width		AV1_DEC_REG(332, 16, 0xffff)
> > > +
> > > +#define av1_pp1_dup_ver			AV1_DEC_REG(394, 0, 0xff)
> > > +#define av1_pp1_dup_hor			AV1_DEC_REG(394, 8, 0xff)
> > > +#define av1_pp0_dup_ver			AV1_DEC_REG(394, 16, 0xff)
> > > +#define av1_pp0_dup_hor			AV1_DEC_REG(394, 24, 0xff)
> > > +
> > > +#define AV1_TILE_OUT_LU			(AV1_SWREG(65))
> > > +#define AV1_REFERENCE_Y(i)		(AV1_SWREG(67) + ((i) * 0x8))
> > > +#define AV1_SEGMENTATION		(AV1_SWREG(81))
> > > +#define AV1_GLOBAL_MODEL		(AV1_SWREG(83))
> > > +#define AV1_CDEF_COL			(AV1_SWREG(85))
> > > +#define AV1_SR_COL			(AV1_SWREG(89))
> > > +#define AV1_LR_COL			(AV1_SWREG(91))
> > > +#define AV1_FILM_GRAIN			(AV1_SWREG(95))
> > > +#define AV1_TILE_OUT_CH			(AV1_SWREG(99))
> > > +#define AV1_REFERENCE_CB(i)		(AV1_SWREG(101) + ((i) * 0x8))
> > > +#define AV1_TILE_OUT_MV			(AV1_SWREG(133))
> > > +#define AV1_REFERENCE_MV(i)		(AV1_SWREG(135) + ((i) * 0x8))
> > > +#define AV1_TILE_BASE			(AV1_SWREG(167))
> > > +#define AV1_INPUT_STREAM		(AV1_SWREG(169))
> > > +#define AV1_PROP_TABLE_OUT		(AV1_SWREG(171))
> > > +#define AV1_PROP_TABLE			(AV1_SWREG(173))
> > > +#define AV1_MC_SYNC_CURR		(AV1_SWREG(175))
> > > +#define AV1_MC_SYNC_LEFT		(AV1_SWREG(177))
> > > +#define AV1_DB_DATA_COL			(AV1_SWREG(179))
> > > +#define AV1_DB_CTRL_COL			(AV1_SWREG(183))
> > > +#define AV1_PP_OUT_LU			(AV1_SWREG(326))
> > > +#define AV1_PP_OUT_CH			(AV1_SWREG(328))
> > > +
> > > +#endif /* _ROCKCHIP_VPU981_REGS_H_ */

