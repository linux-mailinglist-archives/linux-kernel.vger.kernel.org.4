Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FED7463BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGCUMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjGCUMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:12:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60027E4E;
        Mon,  3 Jul 2023 13:12:28 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:88d9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3E2D36606F85;
        Mon,  3 Jul 2023 21:12:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688415146;
        bh=RpTXnNtN+9zBoLvLPLvqf2envtbxD/1I2+fTHS8QqnY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n1E+gpBrxehNfaC9OYmAY+tbhxCo1lbgjzab4YgyILUHmnB5r8rNI1xls1EnW+0y3
         V32IaD3loKSmhOSmDIXPVSCuIQcoX8CvhiZIhwKI9PROYOmeVmpdy1nP+HcdK2Upb3
         av3hLwZGAADGBahNpxO9Ke5kPUEa9LN8YZaf+9VP0vsS+WJiGL5QH7xAuzG3QZQ6LZ
         3vXNEyB77Xpc+mzBRcEnwdHibdYi4RZRmNUSU/sbBTsQ3PkTWt4M1lgmeGwB6EAmhe
         LQNCGwCj0B05CLFoSG/nsr2JxhpTYGl44pVg/+NGL8N71hwB5wttEhn34reMI/KOXs
         xSFwFNsQduZtw==
Message-ID: <d4f8bc2c3a75ab6b33352f75d961889ad20bbbfa.camel@collabora.com>
Subject: Re: [PATCH v4,11/11] media: mediatek: vcodec: separete decoder and
 encoder
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
Date:   Mon, 03 Jul 2023 16:12:16 -0400
In-Reply-To: <20230626035346.30654-12-yunfei.dong@mediatek.com>
References: <20230626035346.30654-1-yunfei.dong@mediatek.com>
         <20230626035346.30654-12-yunfei.dong@mediatek.com>
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
> Move all decoder files to folder video-decoder.
> Move all encoder files to folder video-encoder.
> Move common files which shared for encoder and decoder to folder video-co=
mmon.
>=20
> Change include header files and Makefile to fix build error.
>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/mediatek/vcodec/Makefile   | 55 +------------------
>  .../platform/mediatek/vcodec/common/Makefile  | 21 +++++++
>  .../vcodec/{ =3D> common}/mtk_vcodec_com_drv.h  |  0
>  .../vcodec/{ =3D> common}/mtk_vcodec_dbgfs.c    |  4 +-
>  .../vcodec/{ =3D> common}/mtk_vcodec_dbgfs.h    |  0
>  .../vcodec/{ =3D> common}/mtk_vcodec_fw.c       |  4 +-
>  .../vcodec/{ =3D> common}/mtk_vcodec_fw.h       |  2 +-
>  .../vcodec/{ =3D> common}/mtk_vcodec_fw_priv.h  |  0
>  .../vcodec/{ =3D> common}/mtk_vcodec_fw_scp.c   |  4 +-
>  .../vcodec/{ =3D> common}/mtk_vcodec_fw_vpu.c   |  4 +-
>  .../vcodec/{ =3D> common}/mtk_vcodec_intr.c     |  4 +-
>  .../vcodec/{ =3D> common}/mtk_vcodec_intr.h     |  0
>  .../vcodec/{ =3D> common}/mtk_vcodec_util.c     |  6 +-
>  .../vcodec/{ =3D> common}/mtk_vcodec_util.h     | 22 --------
>  .../platform/mediatek/vcodec/decoder/Makefile | 25 +++++++++
>  .../vcodec/{ =3D> decoder}/mtk_vcodec_dec.c     |  0
>  .../vcodec/{ =3D> decoder}/mtk_vcodec_dec.h     |  0
>  .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_drv.c |  2 +-
>  .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_drv.h | 19 +++++--
>  .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_hw.c  |  2 +-
>  .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_hw.h  |  0
>  .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_pm.c  |  0
>  .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_pm.h  |  0
>  .../{ =3D> decoder}/mtk_vcodec_dec_stateful.c   |  0
>  .../{ =3D> decoder}/mtk_vcodec_dec_stateless.c  |  0
>  .../{ =3D> decoder}/vdec/vdec_av1_req_lat_if.c  |  2 +-
>  .../vcodec/{ =3D> decoder}/vdec/vdec_h264_if.c  |  2 +-
>  .../{ =3D> decoder}/vdec/vdec_h264_req_common.c |  0
>  .../{ =3D> decoder}/vdec/vdec_h264_req_common.h |  0
>  .../{ =3D> decoder}/vdec/vdec_h264_req_if.c     |  2 +-
>  .../vdec/vdec_h264_req_multi_if.c             |  2 +-
>  .../vdec/vdec_hevc_req_multi_if.c             |  2 +-
>  .../vcodec/{ =3D> decoder}/vdec/vdec_vp8_if.c   |  2 +-
>  .../{ =3D> decoder}/vdec/vdec_vp8_req_if.c      |  2 +-
>  .../vcodec/{ =3D> decoder}/vdec/vdec_vp9_if.c   |  2 +-
>  .../{ =3D> decoder}/vdec/vdec_vp9_req_lat_if.c  |  2 +-
>  .../vcodec/{ =3D> decoder}/vdec_drv_base.h      |  0
>  .../vcodec/{ =3D> decoder}/vdec_drv_if.c        |  0
>  .../vcodec/{ =3D> decoder}/vdec_drv_if.h        |  0
>  .../vcodec/{ =3D> decoder}/vdec_ipi_msg.h       |  0
>  .../vcodec/{ =3D> decoder}/vdec_msg_queue.c     |  0
>  .../vcodec/{ =3D> decoder}/vdec_msg_queue.h     |  0
>  .../vcodec/{ =3D> decoder}/vdec_vpu_if.c        |  0
>  .../vcodec/{ =3D> decoder}/vdec_vpu_if.h        |  0
>  .../platform/mediatek/vcodec/encoder/Makefile | 11 ++++
>  .../vcodec/{ =3D> encoder}/mtk_vcodec_enc.c     |  0
>  .../vcodec/{ =3D> encoder}/mtk_vcodec_enc.h     |  0
>  .../vcodec/{ =3D> encoder}/mtk_vcodec_enc_drv.c |  2 +-
>  .../vcodec/{ =3D> encoder}/mtk_vcodec_enc_drv.h | 19 +++++--
>  .../vcodec/{ =3D> encoder}/mtk_vcodec_enc_pm.c  |  0
>  .../vcodec/{ =3D> encoder}/mtk_vcodec_enc_pm.h  |  0
>  .../vcodec/{ =3D> encoder}/venc/venc_h264_if.c  |  2 +-
>  .../vcodec/{ =3D> encoder}/venc/venc_vp8_if.c   |  2 +-
>  .../vcodec/{ =3D> encoder}/venc_drv_base.h      |  0
>  .../vcodec/{ =3D> encoder}/venc_drv_if.c        |  0
>  .../vcodec/{ =3D> encoder}/venc_drv_if.h        |  0
>  .../vcodec/{ =3D> encoder}/venc_ipi_msg.h       |  0
>  .../vcodec/{ =3D> encoder}/venc_vpu_if.c        |  0
>  .../vcodec/{ =3D> encoder}/venc_vpu_if.h        |  0
>  59 files changed, 118 insertions(+), 110 deletions(-)
>  create mode 100644 drivers/media/platform/mediatek/vcodec/common/Makefil=
e
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
com_drv.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
dbgfs.c (98%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
dbgfs.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
fw.c (95%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
fw.h (97%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
fw_priv.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
fw_scp.c (96%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
fw_vpu.c (97%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
intr.c (95%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
intr.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
util.c (96%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_=
util.h (71%)
>  create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/Makefi=
le
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec=
_dec.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec=
_dec.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec=
_dec_drv.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec=
_dec_drv.h (93%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec=
_dec_hw.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec=
_dec_hw.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec=
_dec_pm.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec=
_dec_pm.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec=
_dec_stateful.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec=
_dec_stateless.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
av1_req_lat_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
h264_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
h264_req_common.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
h264_req_common.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
h264_req_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
h264_req_multi_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
hevc_req_multi_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
vp8_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
vp8_req_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
vp9_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_=
vp9_req_lat_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_drv_b=
ase.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_drv_i=
f.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_drv_i=
f.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_ipi_m=
sg.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_msg_q=
ueue.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_msg_q=
ueue.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_vpu_i=
f.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_vpu_i=
f.h (100%)
>  create mode 100644 drivers/media/platform/mediatek/vcodec/encoder/Makefi=
le
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec=
_enc.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec=
_enc.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec=
_enc_drv.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec=
_enc_drv.h (91%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec=
_enc_pm.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec=
_enc_pm.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc/venc_=
h264_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc/venc_=
vp8_if.c (99%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_drv_b=
ase.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_drv_i=
f.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_drv_i=
f.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_ipi_m=
sg.h (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_vpu_i=
f.c (100%)
>  rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_vpu_i=
f.h (100%)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/Makefile b/drivers/me=
dia/platform/mediatek/vcodec/Makefile
> index 5f4c30fec85a..014abbfbd993 100644
> --- a/drivers/media/platform/mediatek/vcodec/Makefile
> +++ b/drivers/media/platform/mediatek/vcodec/Makefile
> @@ -1,54 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> -obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) +=3D mtk-vcodec-dec.o \
> -				       mtk-vcodec-enc.o \
> -				       mtk-vcodec-common.o \
> -				       mtk-vcodec-dec-hw.o
> -
> -mtk-vcodec-dec-y :=3D vdec/vdec_h264_if.o \
> -		vdec/vdec_vp8_if.o \
> -		vdec/vdec_vp8_req_if.o \
> -		vdec/vdec_vp9_if.o \
> -		vdec/vdec_vp9_req_lat_if.o \
> -		vdec/vdec_av1_req_lat_if.o \
> -		vdec/vdec_h264_req_if.o \
> -		vdec/vdec_h264_req_common.o \
> -		vdec/vdec_h264_req_multi_if.o \
> -		vdec/vdec_hevc_req_multi_if.o \
> -		mtk_vcodec_dec_drv.o \
> -		vdec_drv_if.o \
> -		vdec_vpu_if.o \
> -		vdec_msg_queue.o \
> -		mtk_vcodec_dec.o \
> -		mtk_vcodec_dec_stateful.o \
> -		mtk_vcodec_dec_stateless.o \
> -		mtk_vcodec_dec_pm.o \
> -
> -mtk-vcodec-dec-hw-y :=3D mtk_vcodec_dec_hw.o
> -
> -mtk-vcodec-enc-y :=3D venc/venc_vp8_if.o \
> -		venc/venc_h264_if.o \
> -		mtk_vcodec_enc.o \
> -		mtk_vcodec_enc_drv.o \
> -		mtk_vcodec_enc_pm.o \
> -		venc_drv_if.o \
> -		venc_vpu_if.o \
> -
> -
> -mtk-vcodec-common-y :=3D mtk_vcodec_intr.o \
> -		mtk_vcodec_util.o \
> -		mtk_vcodec_fw.o \
> -
> -ifneq ($(CONFIG_VIDEO_MEDIATEK_VCODEC_VPU),)
> -mtk-vcodec-common-y +=3D mtk_vcodec_fw_vpu.o
> -endif
> -
> -ifneq ($(CONFIG_VIDEO_MEDIATEK_VCODEC_SCP),)
> -mtk-vcodec-common-y +=3D mtk_vcodec_fw_scp.o
> -endif
> -
> -ifneq ($(CONFIG_DEBUG_FS),)
> -obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) +=3D mtk-vcodec-dbgfs.o
> -
> -mtk-vcodec-dbgfs-y :=3D mtk_vcodec_dbgfs.o
> -endif
> \ No newline at end of file
> +obj-y +=3D common/
> +obj-y +=3D encoder/
> +obj-y +=3D decoder/
> diff --git a/drivers/media/platform/mediatek/vcodec/common/Makefile b/dri=
vers/media/platform/mediatek/vcodec/common/Makefile
> new file mode 100644
> index 000000000000..d0479914dfb3
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/common/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) +=3D mtk-vcodec-common.o
> +
> +mtk-vcodec-common-y :=3D mtk_vcodec_intr.o \
> +		mtk_vcodec_util.o \
> +		mtk_vcodec_fw.o \
> +
> +ifneq ($(CONFIG_VIDEO_MEDIATEK_VCODEC_VPU),)
> +mtk-vcodec-common-y +=3D mtk_vcodec_fw_vpu.o
> +endif
> +
> +ifneq ($(CONFIG_VIDEO_MEDIATEK_VCODEC_SCP),)
> +mtk-vcodec-common-y +=3D mtk_vcodec_fw_scp.o
> +endif
> +
> +ifneq ($(CONFIG_DEBUG_FS),)
> +obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) +=3D mtk-vcodec-dbgfs.o
> +
> +mtk-vcodec-dbgfs-y :=3D mtk_vcodec_dbgfs.o
> +endif
> \ No newline at end of file
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h =
b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_com_drv.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_com_dr=
v.h
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/=
drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
> similarity index 98%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.=
c
> index c6a02b33cc74..54d5accf87d2 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
> @@ -7,8 +7,8 @@
>  #include <linux/debugfs.h>
> =20
>  #include "mtk_vcodec_dbgfs.h"
> -#include "mtk_vcodec_dec_drv.h"
> -#include "mtk_vcodec_enc_drv.h"
> +#include "../decoder/mtk_vcodec_dec_drv.h"
> +#include "../encoder/mtk_vcodec_enc_drv.h"
>  #include "mtk_vcodec_util.h"
> =20
>  static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_dec_ctx *ct=
x, char *buf,
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/=
drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.=
h
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c b/dri=
vers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.c
> similarity index 95%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.c
> index e59ce7c78742..5f3b1375c829 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> -#include "mtk_vcodec_dec_drv.h"
> -#include "mtk_vcodec_enc_drv.h"
> +#include "../decoder/mtk_vcodec_dec_drv.h"
> +#include "../encoder/mtk_vcodec_enc_drv.h"
>  #include "mtk_vcodec_fw_priv.h"
> =20
>  struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_f=
w_type type,
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h b/dri=
vers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
> similarity index 97%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
> index 83479ab70385..300363a40158 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
> @@ -6,7 +6,7 @@
>  #include <linux/remoteproc.h>
>  #include <linux/remoteproc/mtk_scp.h>
> =20
> -#include "../vpu/mtk_vpu.h"
> +#include "../../vpu/mtk_vpu.h"
> =20
>  struct mtk_vcodec_dec_dev;
>  struct mtk_vcodec_enc_dev;
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h =
b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_priv.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_pri=
v.h
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b=
/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
> similarity index 96%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp=
.c
> index 3cb5a5befd24..9e744d07a1e8 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> -#include "mtk_vcodec_dec_drv.h"
> -#include "mtk_vcodec_enc_drv.h"
> +#include "../decoder/mtk_vcodec_dec_drv.h"
> +#include "../encoder/mtk_vcodec_enc_drv.h"
>  #include "mtk_vcodec_fw_priv.h"
> =20
>  static int mtk_vcodec_scp_load_firmware(struct mtk_vcodec_fw *fw)
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b=
/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> similarity index 97%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu=
.c
> index 18274a51a8f8..5e03b0886559 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> -#include "mtk_vcodec_dec_drv.h"
> -#include "mtk_vcodec_enc_drv.h"
> +#include "../decoder/mtk_vcodec_dec_drv.h"
> +#include "../encoder/mtk_vcodec_enc_drv.h"
>  #include "mtk_vcodec_fw_priv.h"
> =20
>  static int mtk_vcodec_vpu_load_firmware(struct mtk_vcodec_fw *fw)
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/d=
rivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.c
> similarity index 95%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.c
> index 69dae0336a14..934fad0f0f5d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.c
> @@ -7,8 +7,8 @@
>  #include <linux/errno.h>
>  #include <linux/wait.h>
> =20
> -#include "mtk_vcodec_dec_drv.h"
> -#include "mtk_vcodec_enc_drv.h"
> +#include "../decoder/mtk_vcodec_dec_drv.h"
> +#include "../encoder/mtk_vcodec_enc_drv.h"
>  #include "mtk_vcodec_intr.h"
> =20
>  int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int t=
imeout_ms,
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h b/d=
rivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.h
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/d=
rivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
> similarity index 96%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
> index 18f632eb0b8a..5ab812885fac 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
> @@ -9,9 +9,9 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> =20
> -#include "mtk_vcodec_dec_drv.h"
> -#include "mtk_vcodec_enc_drv.h"
> -#include "mtk_vcodec_dec_hw.h"
> +#include "../decoder/mtk_vcodec_dec_drv.h"
> +#include "../encoder/mtk_vcodec_enc_drv.h"
> +#include "../decoder/mtk_vcodec_dec_hw.h"
> =20
>  #if defined(CONFIG_DEBUG_FS)
>  int mtk_vcodec_dbg;
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/d=
rivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.h
> similarity index 71%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.h
> index 6c24bb8b1715..2bb3fd0b9d11 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.h
> @@ -58,28 +58,6 @@ extern int mtk_vcodec_dbg;
>  	dev_dbg(&(plat_dev)->dev, "[MTK_VCODEC][%d]: " fmt "\n", inst_id, ##arg=
s)
>  #endif
> =20
> -#define mtk_vdec_err(ctx, fmt, args...)                               \
> -	mtk_vcodec_err((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> -
> -#define mtk_vdec_debug(ctx, fmt, args...)                             \
> -	mtk_vcodec_debug((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> -
> -#define mtk_venc_err(ctx, fmt, args...)                               \
> -	mtk_vcodec_err((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> -
> -#define mtk_venc_debug(ctx, fmt, args...)                              \
> -	mtk_vcodec_debug((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> -
> -#define mtk_v4l2_vdec_err(ctx, fmt, args...) mtk_v4l2_err((ctx)->dev->pl=
at_dev, fmt, ##args)
> -
> -#define mtk_v4l2_vdec_dbg(level, ctx, fmt, args...)             \
> -	mtk_v4l2_debug((ctx)->dev->plat_dev, level, fmt, ##args)
> -
> -#define mtk_v4l2_venc_err(ctx, fmt, args...) mtk_v4l2_err((ctx)->dev->pl=
at_dev, fmt, ##args)
> -
> -#define mtk_v4l2_venc_dbg(level, ctx, fmt, args...)             \
> -	mtk_v4l2_debug((ctx)->dev->plat_dev, level, fmt, ##args)
> -
>  void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned =
int reg_idx);
>  int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
>  void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem);
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/Makefile b/dr=
ivers/media/platform/mediatek/vcodec/decoder/Makefile
> new file mode 100644
> index 000000000000..904cd22def84
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/Makefile
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) +=3D mtk-vcodec-dec.o \
> +				       mtk-vcodec-dec-hw.o
> +
> +mtk-vcodec-dec-y :=3D vdec/vdec_h264_if.o \
> +		vdec/vdec_vp8_if.o \
> +		vdec/vdec_vp8_req_if.o \
> +		vdec/vdec_vp9_if.o \
> +		vdec/vdec_vp9_req_lat_if.o \
> +		vdec/vdec_av1_req_lat_if.o \
> +		vdec/vdec_h264_req_if.o \
> +		vdec/vdec_h264_req_common.o \
> +		vdec/vdec_h264_req_multi_if.o \
> +		vdec/vdec_hevc_req_multi_if.o \
> +		mtk_vcodec_dec_drv.o \
> +		vdec_drv_if.o \
> +		vdec_vpu_if.o \
> +		vdec_msg_queue.o \
> +		mtk_vcodec_dec.o \
> +		mtk_vcodec_dec_stateful.o \
> +		mtk_vcodec_dec_stateless.o \
> +		mtk_vcodec_dec_pm.o \
> +
> +mtk-vcodec-dec-hw-y :=3D mtk_vcodec_dec_hw.o
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/dr=
ivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h b/dr=
ivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
> rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.h
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c =
b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_d=
rv.c
> index 36970113d069..6ee319762418 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> @@ -20,7 +20,7 @@
>  #include "mtk_vcodec_dec.h"
>  #include "mtk_vcodec_dec_hw.h"
>  #include "mtk_vcodec_dec_pm.h"
> -#include "mtk_vcodec_intr.h"
> +#include "../common/mtk_vcodec_intr.h"
> =20
>  static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dec_ctx *ctx, struc=
t mtk_vcodec_dec_dev *dev)
>  {
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h =
b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> similarity index 93%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
> rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_d=
rv.h
> index 1a0375dd5b6d..db29f3437b6e 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> @@ -7,10 +7,10 @@
>  #ifndef _MTK_VCODEC_DEC_DRV_H_
>  #define _MTK_VCODEC_DEC_DRV_H_
> =20
> -#include "mtk_vcodec_com_drv.h"
> -#include "mtk_vcodec_dbgfs.h"
> -#include "mtk_vcodec_fw_priv.h"
> -#include "mtk_vcodec_util.h"
> +#include "../common/mtk_vcodec_com_drv.h"
> +#include "../common/mtk_vcodec_dbgfs.h"
> +#include "../common/mtk_vcodec_fw_priv.h"
> +#include "../common/mtk_vcodec_util.h"
>  #include "vdec_msg_queue.h"
> =20
>  #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
> @@ -303,4 +303,15 @@ wake_up_dec_ctx(struct mtk_vcodec_dec_ctx *ctx, unsi=
gned int reason, unsigned in
>  	wake_up_interruptible(&ctx->queue[hw_id]);
>  }
> =20
> +#define mtk_vdec_err(ctx, fmt, args...)                               \
> +	mtk_vcodec_err((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> +
> +#define mtk_vdec_debug(ctx, fmt, args...)                             \
> +	mtk_vcodec_debug((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> +
> +#define mtk_v4l2_vdec_err(ctx, fmt, args...) mtk_v4l2_err((ctx)->dev->pl=
at_dev, fmt, ##args)
> +
> +#define mtk_v4l2_vdec_dbg(level, ctx, fmt, args...)             \
> +	mtk_v4l2_debug((ctx)->dev->plat_dev, level, fmt, ##args)
> +
>  #endif /* _MTK_VCODEC_DEC_DRV_H_ */
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b=
/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_h=
w.c
> index fa02fcf4e8c2..4f05a179970c 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.c
> @@ -15,7 +15,7 @@
>  #include "mtk_vcodec_dec.h"
>  #include "mtk_vcodec_dec_hw.h"
>  #include "mtk_vcodec_dec_pm.h"
> -#include "mtk_vcodec_intr.h"
> +#include "../common/mtk_vcodec_intr.h"
> =20
>  static const struct of_device_id mtk_vdec_hw_match[] =3D {
>  	{
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h b=
/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
> rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_h=
w.h
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b=
/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_p=
m.c
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h b=
/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
> rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_p=
m.h
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statef=
ul.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_statef=
ul.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statefu=
l.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tateful.c
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statel=
ess.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statele=
ss.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tateless.c
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat=
_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_la=
t_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_=
if.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_re=
q_lat_if.c
> index d272fef36cd1..81f9e0c1540c 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_la=
t_if.c
> @@ -9,7 +9,7 @@
>  #include <media/videobuf2-dma-contig.h>
> =20
>  #include "../mtk_vcodec_dec.h"
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
>  #include "../vdec_drv_if.h"
>  #include "../vdec_vpu_if.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_i=
f.c
> index a8175f977ed2..bf7dffe60d07 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_if.c
> @@ -9,7 +9,7 @@
> =20
>  #include "../vdec_drv_if.h"
>  #include "../mtk_vcodec_dec.h"
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../vdec_vpu_if.h"
>  #include "../vdec_drv_base.h"
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_co=
mmon.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_=
common.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_com=
mon.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_r=
eq_common.c
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_co=
mmon.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_=
common.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_com=
mon.h
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_r=
eq_common.h
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if=
.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.=
c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_r=
eq_if.c
> index 4c5ef35199a1..5600f1df653d 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_i=
f.c
> @@ -7,7 +7,7 @@
>  #include <media/videobuf2-dma-contig.h>
> =20
>  #include "../mtk_vcodec_dec.h"
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
>  #include "../vdec_drv_if.h"
>  #include "../vdec_vpu_if.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_re=
q_multi_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_mul=
ti_if.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_r=
eq_multi_if.c
> index 0f9f7b56882f..0e741e0dc8ba 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.=
c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_m=
ulti_if.c
> @@ -11,7 +11,7 @@
>  #include <media/videobuf2-dma-contig.h>
> =20
>  #include "../mtk_vcodec_dec.h"
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
>  #include "../vdec_drv_if.h"
>  #include "../vdec_vpu_if.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_re=
q_multi_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_mul=
ti_if.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_r=
eq_multi_if.c
> index 2682f40d1361..06ed47df693b 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.=
c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_m=
ulti_if.c
> @@ -9,7 +9,7 @@
>  #include <media/videobuf2-dma-contig.h>
> =20
>  #include "../mtk_vcodec_dec.h"
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
>  #include "../vdec_drv_if.h"
>  #include "../vdec_vpu_if.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if=
.c
> index ceddcfd9135b..d82205a1d8d0 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> @@ -8,7 +8,7 @@
>  #include <linux/slab.h>
>  #include "../vdec_drv_if.h"
>  #include "../mtk_vcodec_dec.h"
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../vdec_vpu_if.h"
>  #include "../vdec_drv_base.h"
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.=
c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_re=
q_if.c
> index c85c849d2548..f64b21c07169 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if=
.c
> @@ -10,7 +10,7 @@
>  #include <uapi/linux/v4l2-controls.h>
> =20
>  #include "../mtk_vcodec_dec.h"
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
>  #include "../vdec_drv_if.h"
>  #include "../vdec_vpu_if.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/=
drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if=
.c
> index d3493d36329d..5780052d9b38 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
> @@ -12,7 +12,7 @@
>  #include <linux/delay.h>
>  #include <linux/time.h>
> =20
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
>  #include "../vdec_vpu_if.h"
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat=
_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_=
if.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_re=
q_lat_if.c
> index 3e9458470484..e393e3e668f8 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> @@ -10,7 +10,7 @@
>  #include <media/v4l2-vp9.h>
> =20
>  #include "../mtk_vcodec_dec.h"
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../vdec_drv_base.h"
>  #include "../vdec_drv_if.h"
>  #include "../vdec_vpu_if.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h b/dri=
vers/media/platform/mediatek/vcodec/decoder/vdec_drv_base.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_base.h
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c b/drive=
rs/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drive=
rs/media/platform/mediatek/vcodec/decoder/vdec_drv_if.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.h
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_ipi_msg.h b/driv=
ers/media/platform/mediatek/vcodec/decoder/vdec_ipi_msg.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/vdec_ipi_msg.h
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_ipi_msg.h
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/dr=
ivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.c
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/dr=
ivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drive=
rs/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h b/drive=
rs/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
> rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/Makefile b/dr=
ivers/media/platform/mediatek/vcodec/encoder/Makefile
> new file mode 100644
> index 000000000000..e621b5b7e5e6
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) +=3D mtk-vcodec-enc.o
> +
> +mtk-vcodec-enc-y :=3D venc/venc_vp8_if.o \
> +		venc/venc_h264_if.o \
> +		mtk_vcodec_enc.o \
> +		mtk_vcodec_enc_drv.o \
> +		mtk_vcodec_enc_pm.o \
> +		venc_drv_if.o \
> +		venc_vpu_if.o \
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/dr=
ivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h b/dr=
ivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
> rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.h
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c =
b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_d=
rv.c
> index f1b4d5e8cd49..5db2bf3db4c5 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> @@ -18,7 +18,7 @@
> =20
>  #include "mtk_vcodec_enc.h"
>  #include "mtk_vcodec_enc_pm.h"
> -#include "mtk_vcodec_intr.h"
> +#include "../common/mtk_vcodec_intr.h"
> =20
>  static const struct mtk_video_fmt mtk_video_formats_output[] =3D {
>  	{
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h =
b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
> similarity index 91%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
> rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_d=
rv.h
> index 4804d8531a4e..5f3484fb9193 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
> @@ -7,10 +7,10 @@
>  #ifndef _MTK_VCODEC_ENC_DRV_H_
>  #define _MTK_VCODEC_ENC_DRV_H_
> =20
> -#include "mtk_vcodec_com_drv.h"
> -#include "mtk_vcodec_dbgfs.h"
> -#include "mtk_vcodec_fw_priv.h"
> -#include "mtk_vcodec_util.h"
> +#include "../common/mtk_vcodec_com_drv.h"
> +#include "../common/mtk_vcodec_dbgfs.h"
> +#include "../common/mtk_vcodec_fw_priv.h"
> +#include "../common/mtk_vcodec_util.h"
> =20
>  #define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
> =20
> @@ -242,4 +242,15 @@ wake_up_enc_ctx(struct mtk_vcodec_enc_ctx *ctx, unsi=
gned int reason, unsigned in
>  	wake_up_interruptible(&ctx->queue[hw_id]);
>  }
> =20
> +#define mtk_venc_err(ctx, fmt, args...)                               \
> +	mtk_vcodec_err((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> +
> +#define mtk_venc_debug(ctx, fmt, args...)                              \
> +	mtk_vcodec_debug((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> +
> +#define mtk_v4l2_venc_err(ctx, fmt, args...) mtk_v4l2_err((ctx)->dev->pl=
at_dev, fmt, ##args)
> +
> +#define mtk_v4l2_venc_dbg(level, ctx, fmt, args...)             \
> +	mtk_v4l2_debug((ctx)->dev->plat_dev, level, fmt, ##args)
> +
>  #endif /* _MTK_VCODEC_ENC_DRV_H_ */
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b=
/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
> rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_p=
m.c
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h b=
/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
> rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_p=
m.h
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> rename to drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_i=
f.c
> index 9127bceb0db4..a68dac72c4e4 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> @@ -11,7 +11,7 @@
>  #include <linux/slab.h>
> =20
>  #include "../mtk_vcodec_enc_drv.h"
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../mtk_vcodec_enc.h"
>  #include "../mtk_vcodec_enc_pm.h"
>  #include "../venc_drv_base.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
> similarity index 99%
> rename from drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> rename to drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if=
.c
> index 510f3b042670..05abca91e742 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
> @@ -10,7 +10,7 @@
>  #include <linux/slab.h>
> =20
>  #include "../mtk_vcodec_enc_drv.h"
> -#include "../mtk_vcodec_intr.h"
> +#include "../../common/mtk_vcodec_intr.h"
>  #include "../mtk_vcodec_enc.h"
>  #include "../mtk_vcodec_enc_pm.h"
>  #include "../venc_drv_base.h"
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h b/dri=
vers/media/platform/mediatek/vcodec/encoder/venc_drv_base.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/venc_drv_base.h
> rename to drivers/media/platform/mediatek/vcodec/encoder/venc_drv_base.h
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c b/drive=
rs/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/venc_drv_if.c
> rename to drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h b/drive=
rs/media/platform/mediatek/vcodec/encoder/venc_drv_if.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/venc_drv_if.h
> rename to drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.h
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_ipi_msg.h b/driv=
ers/media/platform/mediatek/vcodec/encoder/venc_ipi_msg.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/venc_ipi_msg.h
> rename to drivers/media/platform/mediatek/vcodec/encoder/venc_ipi_msg.h
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drive=
rs/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> rename to drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h b/drive=
rs/media/platform/mediatek/vcodec/encoder/venc_vpu_if.h
> similarity index 100%
> rename from drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
> rename to drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.h

