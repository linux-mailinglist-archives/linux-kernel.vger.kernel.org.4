Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018AC745C26
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGCMVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjGCMVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:21:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1111CE70;
        Mon,  3 Jul 2023 05:21:22 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 012206606F62;
        Mon,  3 Jul 2023 13:21:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688386881;
        bh=+4NDxNUuPKigo60H/IoGaRvRIptn4+QkAhJh/XuVQ/k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hn05dWkSGAfTyn4S4XSqZPSBCSPZLhEPI/V6exDB8RsIQlttnJQuCCaH7KQzntciq
         sAOmo9roYlxeEHzTlaVTuRP7/K7C2R8UMwJe+VyzsfYSjAX8x1B7mhYDO36IVosxeC
         cCZXNGZ8u2l7540y6DWBji+wiaExbSqu5fBJvpG+iriuFc63Un8h4PAknxQ7pnfAkE
         7ia9f6cMDRXE6peXMyCOetO5beWwQ0ZzBSLNodh49O5cdDMypqst+7xTzD/yhlLAy4
         w/svtc8exmONtseD65Y7lSbyAK9K0YMZLJU3PISF9vPB0EM0C0BV/1X4btQVS2+UcF
         YUvqJ/PZh5uEA==
Message-ID: <0430ddab-6a6c-9fa3-95bd-05ce8ac5b94f@collabora.com>
Date:   Mon, 3 Jul 2023 14:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-5-jstephan@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230630100321.1951138-5-jstephan@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/06/23 12:01, Julien Stephan ha scritto:
> From: Phi-bang Nguyen <pnguyen@baylibre.com>
> 
> This driver provides a path to bypass the SoC ISP so that image data
> coming from the SENINF can go directly into memory without any image
> processing. This allows the use of an external ISP.
> 
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   MAINTAINERS                                   |   1 +
>   .../platform/mediatek/isp/isp_30/Kconfig      |  19 +
>   .../platform/mediatek/isp/isp_30/Makefile     |   1 +
>   .../mediatek/isp/isp_30/camsv/Makefile        |   7 +
>   .../mediatek/isp/isp_30/camsv/mtk_camsv.c     | 334 ++++++++
>   .../mediatek/isp/isp_30/camsv/mtk_camsv.h     | 200 +++++
>   .../isp/isp_30/camsv/mtk_camsv30_hw.c         | 474 +++++++++++
>   .../isp/isp_30/camsv/mtk_camsv30_regs.h       |  59 ++
>   .../isp/isp_30/camsv/mtk_camsv_video.c        | 781 ++++++++++++++++++
>   9 files changed, 1876 insertions(+)
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_regs.h
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60b2bceca584..cebb8fb62b45 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13357,6 +13357,7 @@ M:	Andy Hsieh <andy.hsieh@mediatek.com>
>   S:	Supported
>   F:	Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
>   F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> +F:	drivers/media/platform/mediatek/isp/isp_30/camsv/*
>   F:	drivers/media/platform/mediatek/isp/isp_30/seninf/*
>   
>   MEDIATEK SMI DRIVER
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/Kconfig b/drivers/media/platform/mediatek/isp/isp_30/Kconfig
> index 831f9bee5fdd..04d4a2af80bc 100644
> --- a/drivers/media/platform/mediatek/isp/isp_30/Kconfig
> +++ b/drivers/media/platform/mediatek/isp/isp_30/Kconfig
> @@ -14,3 +14,22 @@ config MTK_SENINF
>   
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called mtk-seninf.
> +
> +config MTK_CAMSV30
> +	tristate "MediaTek ISP3.0 CAMSV driver"
> +	depends on VIDEO_V4L2_SUBDEV_API
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on OF
> +	depends on PM
> +	select VIDEOBUF2_VMALLOC
> +	select VIDEOBUF2_DMA_CONTIG
> +	select MTK_SENINF
> +	select PHY_MTK_MIPI_CSI_0_5
> +	default n
> +	help
> +	  This driver provides a path to bypass the SoC ISP so that
> +	  image data come from the SENINF can go directly into memory
> +	  without any image processing.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mtk-camsv30.
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/Makefile b/drivers/media/platform/mediatek/isp/isp_30/Makefile
> index 2e7d731d42b7..c0034ef31702 100644
> --- a/drivers/media/platform/mediatek/isp/isp_30/Makefile
> +++ b/drivers/media/platform/mediatek/isp/isp_30/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-$(CONFIG_MTK_SENINF) += seninf/
> +obj-$(CONFIG_MTK_CAMSV30) += camsv/
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile b/drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile
> new file mode 100644
> index 000000000000..fffbc6e7cb78
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +mtk-camsv30-objs += mtk_camsv.o
> +mtk-camsv30-objs += mtk_camsv30_hw.o
> +mtk-camsv30-objs += mtk_camsv_video.o
> +
> +obj-$(CONFIG_MTK_CAMSV30) += mtk-camsv30.o
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c
> new file mode 100644
> index 000000000000..03d234f54e1c
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 BayLibre
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +
> +#include <media/v4l2-async.h>
> +#include <media/v4l2-device.h>
> +
> +#include "mtk_camsv.h"
> +
> +static inline struct mtk_cam_dev *to_mtk_cam_dev(struct v4l2_subdev *sd)
> +{
> +	return container_of(sd, struct mtk_cam_dev, subdev);
> +}
> +
> +static const u32 mtk_cam_mbus_formats[] = {
> +	MEDIA_BUS_FMT_SBGGR8_1X8,
> +	MEDIA_BUS_FMT_SGBRG8_1X8,
> +	MEDIA_BUS_FMT_SGRBG8_1X8,
> +	MEDIA_BUS_FMT_SRGGB8_1X8,
> +	MEDIA_BUS_FMT_SBGGR10_1X10,
> +	MEDIA_BUS_FMT_SGBRG10_1X10,
> +	MEDIA_BUS_FMT_SGRBG10_1X10,
> +	MEDIA_BUS_FMT_SRGGB10_1X10,
> +	MEDIA_BUS_FMT_SBGGR12_1X12,
> +	MEDIA_BUS_FMT_SGBRG12_1X12,
> +	MEDIA_BUS_FMT_SGRBG12_1X12,
> +	MEDIA_BUS_FMT_SRGGB12_1X12,
> +	MEDIA_BUS_FMT_UYVY8_1X16,
> +	MEDIA_BUS_FMT_VYUY8_1X16,
> +	MEDIA_BUS_FMT_YUYV8_1X16,
> +	MEDIA_BUS_FMT_YVYU8_1X16,
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * V4L2 Subdev Operations
> + */
> +
> +static int mtk_cam_cio_stream_on(struct mtk_cam_dev *cam)
> +{
> +	struct device *dev = cam->dev;
> +	struct v4l2_subdev *seninf;
> +	int ret;
> +
> +	if (!cam->seninf) {
> +		cam->seninf = media_pad_remote_pad_first(&cam->subdev_pads[MTK_CAM_CIO_PAD_SENINF]);
> +		if (!cam->seninf) {
> +			dev_err(dev, "%s: No SENINF connected\n", __func__);
> +			return -ENOLINK;
> +		}
> +	}
> +
> +	seninf = media_entity_to_v4l2_subdev(cam->seninf->entity);
> +
> +	/* Seninf must stream on first */
> +	ret = v4l2_subdev_call(seninf, pad, enable_streams, NULL, cam->seninf->index, 0);
> +	if (ret) {
> +		dev_err(dev, "failed to stream on %s:%d\n",
> +			seninf->entity.name, ret);
> +		return ret;
> +	}
> +
> +	cam->streaming = true;
> +
> +	return 0;
> +}
> +
> +static int mtk_cam_cio_stream_off(struct mtk_cam_dev *cam)
> +{
> +	struct device *dev = cam->dev;

You're using `dev` only once, might as well drop it and just reference to
cam->dev directly for that dev_err() call...

> +	struct v4l2_subdev *seninf;
> +	int ret;
> +
> +	if (cam->seninf) {

if (cam->seninf) {
	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(...);

> +		seninf = media_entity_to_v4l2_subdev(cam->seninf->entity);
> +
> +		ret = v4l2_subdev_call(seninf, pad, disable_streams, NULL,
> +				       cam->seninf->index, 0);
> +		if (ret) {
> +			dev_err(dev, "failed to stream off %s:%d\n",
> +				seninf->entity.name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	cam->streaming = false;
> +
> +	return 0;
> +}
> +


..snip..

> +static int mtk_cam_v4l2_register(struct mtk_cam_dev *cam)
> +{
> +	struct device *dev = cam->dev;
> +	int ret;
> +
> +	/* Initialize subdev pads */
> +	ret = media_entity_pads_init(&cam->subdev.entity,
> +				     ARRAY_SIZE(cam->subdev_pads),
> +				     cam->subdev_pads);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize media pads:%d\n", ret);
> +		return ret;
> +	}
> +
> +	cam->subdev_pads[MTK_CAM_CIO_PAD_SENINF].flags = MEDIA_PAD_FL_SINK;
> +	cam->subdev_pads[MTK_CAM_CIO_PAD_VIDEO].flags = MEDIA_PAD_FL_SOURCE;
> +
> +	/* Initialize subdev */
> +	v4l2_subdev_init(&cam->subdev, &mtk_cam_subdev_ops);
> +
> +	cam->subdev.dev = dev;
> +	cam->subdev.entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
> +	cam->subdev.entity.ops = &mtk_cam_media_entity_ops;
> +	cam->subdev.internal_ops = &mtk_cam_internal_ops;
> +	cam->subdev.flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
> +	strscpy(cam->subdev.name, dev_name(dev), V4L2_SUBDEV_NAME_SIZE);
> +	v4l2_set_subdevdata(&cam->subdev, cam);
> +
> +	mtk_cam_init_cfg(&cam->subdev, NULL);

mtk_cam_init_cfg() returns an integer, and this is probably because you expect
it to get logic to fail: in that case, check the result of that call here,
otherwise, make that function void.

> +
> +	ret = v4l2_async_register_subdev(&cam->subdev);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize subdev:%d\n", ret);
> +		goto fail_clean_media_entiy;

You don't need a goto here, as this the only fail path that requires cleaning
up the entity: just do the same here and return ret *here*.

> +	}
> +
> +	return 0;
> +
> +fail_clean_media_entiy:
> +	media_entity_cleanup(&cam->subdev.entity);
> +
> +	return ret;
> +}
> +
> +static void mtk_cam_v4l2_unregister(struct mtk_cam_dev *cam)
> +{
> +	mtk_cam_video_unregister(&cam->vdev);
> +
> +	media_entity_cleanup(&cam->subdev.entity);
> +	v4l2_async_unregister_subdev(&cam->subdev);
> +}
> +
> +int mtk_cam_dev_init(struct mtk_cam_dev *cam_dev)
> +{
> +	int ret;
> +
> +	mutex_init(&cam_dev->op_lock);
> +
> +	/* v4l2 sub-device registration */
> +	ret = mtk_cam_v4l2_register(cam_dev);
> +	if (ret) {
> +		mutex_destroy(&cam_dev->op_lock);
> +		return ret;
> +	}
> +
> +	return ret;

return 0;

> +}
> +
> +void mtk_cam_dev_cleanup(struct mtk_cam_dev *cam)
> +{
> +	mtk_cam_v4l2_unregister(cam);
> +	mutex_destroy(&cam->op_lock);
> +}
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
> new file mode 100644
> index 000000000000..91e30fe006a8
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
> @@ -0,0 +1,200 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 BayLibre
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_CAMSV_H__
> +#define __MTK_CAMSV_H__
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/of_graph.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/videodev2.h>
> +#include <media/media-entity.h>
> +#include <media/v4l2-subdev.h>
> +#include <media/videobuf2-core.h>
> +#include <media/videobuf2-dma-contig.h>
> +#include <media/videobuf2-v4l2.h>
> +#include <soc/mediatek/smi.h>
> +
> +#define IMG_MAX_WIDTH			5376
> +#define IMG_MAX_HEIGHT			4032
> +#define IMG_DEF_WIDTH			1920
> +#define IMG_DEF_HEIGHT			1080
> +#define IMG_MIN_WIDTH			80
> +#define IMG_MIN_HEIGHT			60
> +
> +#define MTK_CAM_CIO_PAD_SENINF		0
> +#define MTK_CAM_CIO_PAD_VIDEO		1
> +#define MTK_CAM_CIO_NUM_PADS		2
> +
> +struct mtk_cam_format_info {
> +	u32 code;
> +	u32 fourcc;
> +	bool packed;
> +	unsigned int bpp;

Can we get any format that uses a billion bits per pixel? :-P

u8 bpp;

> +};
> +
> +struct mtk_cam_dev_buffer {
> +	struct vb2_v4l2_buffer v4l2_buf;
> +	struct list_head list;
> +	dma_addr_t daddr;
> +	dma_addr_t fhaddr;
> +};
> +
> +struct mtk_cam_sparams {
> +	unsigned int w_factor;
> +	unsigned int module_en_pak;
> +	unsigned int fmt_sel;
> +	unsigned int pak;
> +	unsigned int imgo_stride;

If this relates to registers somehow, that must be a fixed type; otherwise, if not,
I believe you can reduce the size of some of those vars in here.

> +};
> +
> +/*

For kerneldoc, you start with `/**`

> + * struct mtk_cam_vdev_desc - MTK camera device descriptor
> + *

Remove extra blank line.

> + * @name: name of the node
> + * @cap: supported V4L2 capabilities
> + * @buf_type: supported V4L2 buffer type
> + * @link_flags: default media link flags
> + * @def_width: the default format width
> + * @def_height: the default format height
> + * @num_fmts: the number of supported node formats
> + * @max_buf_count: maximum VB2 buffer count
> + * @ioctl_ops:  mapped to v4l2_ioctl_ops
> + * @fmts: supported format
> + * @frmsizes: supported V4L2 frame size number
> + *

same

> + */
> +struct mtk_cam_vdev_desc {
> +	const char *name;
> +	u32 cap;
> +	u32 buf_type;
> +	u32 link_flags;
> +	u32 def_width;
> +	u32 def_height;
> +	u8 num_fmts;
> +	u8 max_buf_count;
> +	const struct v4l2_ioctl_ops *ioctl_ops;
> +	const u32 *fmts;
> +	const struct v4l2_frmsizeenum *frmsizes;
> +};
> +
> +/*

/**

> + * struct mtk_cam_video_device - MediaTek video device structure
> + *

and again... please fix all instances of that.

> + * @desc: The node description of video device
> + * @vdev_pad: The media pad graph object of video device
> + * @vdev: The video device instance
> + * @vbq: A videobuf queue of video device
> + * @vdev_lock: Serializes vb2 queue and video device operations
> + * @format: The V4L2 format of video device
> + * @fmtinfo: Information about the current format
> + */
> +struct mtk_cam_video_device {
> +	const struct mtk_cam_vdev_desc *desc;
> +
> +	struct media_pad vdev_pad;
> +	struct video_device vdev;
> +	struct vb2_queue vbq;
> +
> +	/* Serializes vb2 queue and video device operations */
> +	struct mutex vdev_lock;
> +
> +	struct v4l2_pix_format_mplane format;
> +	const struct mtk_cam_format_info *fmtinfo;
> +};
> +
> +/*
> + * struct mtk_cam_dev - MediaTek camera device structure.
> + *
> + * @dev: Pointer to device.
> + * @regs: Base address of CAMSV.
> + * @regs_img0: Base address of CAMSV IMG0.
> + * @regs_tg: Base address of CAMSV TG.
> + * @num_clks: Number of clocks.
> + * @clks: The clocks.
> + * @irq: Irq fired when buffer is ready.
> + * @conf: soc specific driver data.
> + * @pipeline: Media pipeline information.
> + * @subdev: The V4L2 sub-device instance.
> + * @subdev_pads: Media pads of this sub-device.
> + * @formats: Media bus format for all pads.
> + * @vdev: The video device node.
> + * @seninf: Pointer to the seninf pad.
> + * @streaming: Indicate the overall streaming status is on or off.
> + * @stream_count: Number of streaming video nodes.
> + * @sequence: Buffer sequence number.
> + * @op_lock: Serializes driver's VB2 callback operations.
> + * @irqlock: Protects the buffer list.
> + * @buf_list: List head for the buffer list.
> + * @hw_functions: Hardware specific functions.
> + * @dummy: Dummy buffer used when user buffer is not available.
> + * @dummy_size : Size of the dummy buffer.
> + * @is_dummy_used: True if dummy buffer is currently used.
> + */
> +struct mtk_cam_dev {
> +	struct device *dev;
> +	void __iomem *regs;
> +	void __iomem *regs_img0;
> +	void __iomem *regs_tg;
> +
> +	unsigned int num_clks;
> +	struct clk_bulk_data *clks;
> +	unsigned int irq;
> +	const struct mtk_cam_conf *conf;
> +
> +	struct media_pipeline pipeline;
> +	struct v4l2_subdev subdev;
> +	struct media_pad subdev_pads[MTK_CAM_CIO_NUM_PADS];
> +	struct v4l2_mbus_framefmt formats[MTK_CAM_CIO_NUM_PADS];
> +	struct mtk_cam_video_device vdev;
> +	struct media_pad *seninf;
> +	unsigned int streaming;
> +	unsigned int stream_count;
> +	unsigned int sequence;
> +
> +	struct mutex op_lock;
> +	spinlock_t irqlock;
> +
> +	struct list_head buf_list;
> +
> +	struct mtk_cam_hw_functions *hw_functions;
> +
> +	struct mtk_cam_dev_buffer dummy;
> +	unsigned int dummy_size;
> +	bool is_dummy_used;
> +};
> +
> +struct mtk_cam_conf {
> +	unsigned int tg_sen_mode;
> +	unsigned int module_en;
> +	unsigned int pak;
> +	unsigned int dma_special_fun;
> +	unsigned int imgo_con;
> +	unsigned int imgo_con2;
> +	unsigned int imgo_con3;

u32?

> +	bool enableFH;

bool frm_hdr_en;

> +};
> +
> +struct mtk_cam_hw_functions {
> +	void (*mtk_cam_setup)(struct mtk_cam_dev *cam_dev, u32 width,
> +			      u32 height, u32 bpl, u32 mbus_fmt);
> +	void (*mtk_cam_update_buffers_add)(struct mtk_cam_dev *cam_dev,
> +					   struct mtk_cam_dev_buffer *buf);
> +	void (*mtk_cam_cmos_vf_hw_enable)(struct mtk_cam_dev *cam_dev,
> +					  bool pak_en);
> +	void (*mtk_cam_cmos_vf_hw_disable)(struct mtk_cam_dev *cam_dev,
> +					   bool pak_en);
> +};
> +
> +int mtk_cam_dev_init(struct mtk_cam_dev *cam_dev);
> +void mtk_cam_dev_cleanup(struct mtk_cam_dev *cam_dev);
> +int mtk_cam_video_register(struct mtk_cam_dev *cam_dev);
> +void mtk_cam_video_unregister(struct mtk_cam_video_device *vdev);
> +
> +#endif /* __MTK_CAMSV_H__ */
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
> new file mode 100644
> index 000000000000..39fc3ef7b4e7
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
> @@ -0,0 +1,474 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 BayLibre
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/iommu.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#include "mtk_camsv.h"
> +#include "mtk_camsv30_regs.h"
> +
> +#define MTK_CAMSV30_AUTOSUSPEND_DELAY_MS 100
> +
> +static const struct mtk_cam_conf camsv30_conf = {
> +	.tg_sen_mode = 0x00010002U, /* TIME_STP_EN = 1. DBL_DATA_BUS = 1 */
> +	.module_en = 0x40000001U, /* enable double buffer and TG */
> +	.dma_special_fun = 0x61000000U, /* enable RDMA insterlace */
> +	.imgo_con = 0x80000080U, /* DMA FIFO depth and burst */
> +	.imgo_con2 = 0x00020002U, /* DMA priority */
> +	.imgo_con3 = 0x00020002U, /* DMA pre-priority */
> +	.enableFH = false, /* Frame Header disabled */
> +};
> +
> +static void fmt_to_sparams(u32 mbus_fmt, struct mtk_cam_sparams *sparams)
> +{
> +	switch (mbus_fmt) {
> +	/* SBGGR values coming from isp5.0 configuration.
> +	 * not tested on isp2.0
> +	 */
> +	case MEDIA_BUS_FMT_SBGGR12_1X12:
> +	case MEDIA_BUS_FMT_SGBRG12_1X12:
> +	case MEDIA_BUS_FMT_SGRBG12_1X12:
> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
> +		sparams->w_factor = 1;
> +		sparams->module_en_pak = 0x4;
> +		sparams->fmt_sel = 0x2;
> +		sparams->pak = 0x5;
> +		sparams->imgo_stride = 0x000B0000;
> +		break;
> +	case MEDIA_BUS_FMT_SBGGR10_1X10:
> +	case MEDIA_BUS_FMT_SGBRG10_1X10:
> +	case MEDIA_BUS_FMT_SGRBG10_1X10:
> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
> +		sparams->w_factor = 1;
> +		sparams->module_en_pak = 0x4;
> +		sparams->fmt_sel = 0x1;
> +		sparams->pak = 0x6;
> +		sparams->imgo_stride = 0x000B0000;
> +		break;
> +	case MEDIA_BUS_FMT_SBGGR8_1X8:
> +	case MEDIA_BUS_FMT_SGBRG8_1X8:
> +	case MEDIA_BUS_FMT_SGRBG8_1X8:
> +	case MEDIA_BUS_FMT_SRGGB8_1X8:
> +		sparams->w_factor = 1;
> +		sparams->module_en_pak = 0x4;
> +		sparams->fmt_sel = 0x0;
> +		sparams->pak = 0x7;
> +		sparams->imgo_stride = 0x000B0000;
> +		break;
> +	case MEDIA_BUS_FMT_UYVY8_1X16:
> +	case MEDIA_BUS_FMT_VYUY8_1X16:
> +	case MEDIA_BUS_FMT_YUYV8_1X16:
> +	case MEDIA_BUS_FMT_YVYU8_1X16:
> +		sparams->w_factor = 2;
> +		sparams->module_en_pak = 0x8;
> +		sparams->fmt_sel = 0x1000003;
> +		sparams->pak = 0x0;
> +		sparams->imgo_stride = 0x00090000;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static u32 mtk_camsv30_read(struct mtk_cam_dev *priv, u32 reg)
> +{
> +	return readl(priv->regs + reg);

Drop those one-liners please, it's just not worth the noise imo.

> +}
> +
> +static void mtk_camsv30_write(struct mtk_cam_dev *priv, u32 reg, u32 value)
> +{
> +	writel(value, priv->regs + reg);
> +}
> +
> +static void mtk_camsv30_img0_write(struct mtk_cam_dev *priv, u32 reg, u32 value)
> +{
> +	writel(value, priv->regs_img0 + reg);
> +}
> +
> +static u32 mtk_camsv30_tg_read(struct mtk_cam_dev *priv, u32 reg)
> +{
> +	return readl(priv->regs_tg + reg);
> +}
> +
> +static void mtk_camsv30_tg_write(struct mtk_cam_dev *priv, u32 reg, u32 value)
> +{
> +	writel(value, priv->regs_tg + reg);
> +}
> +

..snip..

> +
> +static void mtk_camsv30_setup(struct mtk_cam_dev *cam_dev, u32 w, u32 h,
> +			      u32 bpl, u32 mbus_fmt)
> +{
> +	const struct mtk_cam_conf *conf = cam_dev->conf;
> +	int poll_num = 1000;
> +	u32 int_en = INT_ST_MASK_CAMSV;
> +	struct mtk_cam_sparams sparams;
> +
> +	fmt_to_sparams(mbus_fmt, &sparams);
> +
> +	spin_lock(&cam_dev->irqlock);
> +
> +	if (pm_runtime_get_sync(cam_dev->dev) < 0) {
> +		dev_err(cam_dev->dev, "failed to get pm_runtime\n");
> +		spin_unlock(&cam_dev->irqlock);
> +		return;
> +	}
> +
> +	mtk_camsv30_tg_write(cam_dev, CAMSV_TG_SEN_MODE, conf->tg_sen_mode);
> +
> +	mtk_camsv30_tg_write(cam_dev,
> +			     CAMSV_TG_SEN_GRAB_PXL, (w * sparams.w_factor) << 16U);
> +
> +	mtk_camsv30_tg_write(cam_dev, CAMSV_TG_SEN_GRAB_LIN, h << 16U);
> +
> +	/* YUV_U2S_DIS: disable YUV sensor unsigned to signed */
> +	mtk_camsv30_tg_write(cam_dev, CAMSV_TG_PATH_CFG, 0x1000U);
> +
> +	/* Reset cam */
> +	mtk_camsv30_write(cam_dev, CAMSV_SW_CTL, CAMSV_SW_RST);
> +	mtk_camsv30_write(cam_dev, CAMSV_SW_CTL, 0x0U);
> +	mtk_camsv30_write(cam_dev, CAMSV_SW_CTL, CAMSV_IMGO_RST_TRIG);
> +
> +	while (mtk_camsv30_read(cam_dev, CAMSV_SW_CTL) !=
> +		       (CAMSV_IMGO_RST_TRIG | CAMSV_IMGO_RST_ST) &&
> +	       poll_num++ < 1000)

Decide: this is either
  # poll_num = 1000; poll_num-- > 0;  or
  # poll_num = 0; poll_num++ < 1000.

Besides, however we put it, it's anyway wrong, as you can use common (atomic or
not) helpers for polling registers, which is what you should do here :-)

> +		;
> +
> +	mtk_camsv30_write(cam_dev, CAMSV_SW_CTL, 0x0U);
> +
> +	mtk_camsv30_write(cam_dev, CAMSV_INT_EN, int_en);
> +
> +	mtk_camsv30_write(cam_dev, CAMSV_MODULE_EN,
> +			  conf->module_en | sparams.module_en_pak);
> +	mtk_camsv30_write(cam_dev, CAMSV_FMT_SEL, sparams.fmt_sel);
> +	mtk_camsv30_write(cam_dev, CAMSV_PAK, sparams.pak);
> +
> +	mtk_camsv30_img0_write(cam_dev, CAMSV_IMGO_SV_XSIZE, bpl - 1U);
> +	mtk_camsv30_img0_write(cam_dev, CAMSV_IMGO_SV_YSIZE, h - 1U);
> +
> +	mtk_camsv30_img0_write(cam_dev, CAMSV_IMGO_SV_STRIDE, sparams.imgo_stride | bpl);
> +
> +	mtk_camsv30_img0_write(cam_dev, CAMSV_IMGO_SV_CON, conf->imgo_con);
> +	mtk_camsv30_img0_write(cam_dev, CAMSV_IMGO_SV_CON2, conf->imgo_con2);
> +
> +	/* CMOS_EN first */
> +	mtk_camsv30_tg_write(cam_dev, CAMSV_TG_SEN_MODE,
> +			     mtk_camsv30_tg_read(cam_dev, CAMSV_TG_SEN_MODE) | 0x1U);

#define CAMSV_TG_SEN_MODE_CMOS_EN	BIT(0)     (did I get that right?)

> +
> +	/* finally, CAMSV_MODULE_EN : IMGO_EN */
> +	mtk_camsv30_write(cam_dev, CAMSV_MODULE_EN,
> +			  mtk_camsv30_read(cam_dev, CAMSV_MODULE_EN) | 0x00000010U);

#define CAMSV_MODULE_IMGO_EN		BIT(4)

> +
> +	pm_runtime_put_autosuspend(cam_dev->dev);
> +	spin_unlock(&cam_dev->irqlock);
> +}
> +

..snip..

> +
> +static int mtk_camsv30_probe(struct platform_device *pdev)
> +{
> +	static const char * const clk_names[] = {
> +		"camsys_cam_cgpdn",
> +		"camsys_camtg_cgpdn",
> +		"camsys_camsv"

"CG" stands for "Clock Gating" while "PDN" stands for "Power DowN", and it also
looks obvious for those clocks to be in the camsys clock controller anyway... and
even if not, we definitely don't care (from this driver's perspective) about which
clock controller they're located at.
In any case, we have those names in the clock controller drivers (so, names are
accessible from the clock framework anyway), and each clock controller driver has
the subsystem name (so, the camsys clk controller advertises being camsys already),
which means that we can shorten the clk_names to...

static const char * const clk_names[] = { "cam", "camtg", "camsv" };

...also eventually leading to a more readable devicetree, as the clock-names will
be just one line.

> +	};
> +
> +	struct mtk_cam_dev *cam_dev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	int i;
> +
> +	if (!iommu_present(&platform_bus_type))
> +		return -EPROBE_DEFER;
> +
> +	cam_dev = devm_kzalloc(dev, sizeof(*cam_dev), GFP_KERNEL);
> +	if (!cam_dev)
> +		return -ENOMEM;
> +
> +	cam_dev->conf = of_device_get_match_data(dev);
> +	if (!cam_dev->conf)
> +		return -ENODEV;
> +
> +	cam_dev->dev = dev;
> +	dev_set_drvdata(dev, cam_dev);
> +
> +	cam_dev->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(cam_dev->regs)) {
> +		dev_err(dev, "failed to map register base\n");

return dev_err_probe( .... )

> +		return PTR_ERR(cam_dev->regs);
> +	}
> +
> +	cam_dev->regs_img0 = devm_platform_ioremap_resource(pdev, 1);
> +
> +	if (IS_ERR(cam_dev->regs_img0)) {
> +		dev_err(dev, "failed to map img0 register base\n");
> +		return PTR_ERR(cam_dev->regs_img0);

dev_err_probe()

> +	}
> +
> +	cam_dev->regs_tg = devm_platform_ioremap_resource(pdev, 2);
> +	if (IS_ERR(cam_dev->regs_tg)) {
> +		dev_err(dev, "failed to map TG register base\n");
> +		return PTR_ERR(cam_dev->regs_tg);

again

> +	}
> +
> +	cam_dev->num_clks = ARRAY_SIZE(clk_names);
> +	cam_dev->clks = devm_kcalloc(dev, cam_dev->num_clks,
> +				     sizeof(*cam_dev->clks), GFP_KERNEL);
> +	if (!cam_dev->clks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cam_dev->num_clks; ++i)
> +		cam_dev->clks[i].id = clk_names[i];
> +
> +	ret = devm_clk_bulk_get(dev, cam_dev->num_clks, cam_dev->clks);
> +	if (ret) {
> +		dev_err(dev, "failed to get clocks: %i\n", ret);
> +		return ret;

and again

> +	}
> +
> +	cam_dev->irq = platform_get_irq(pdev, 0);
> +	ret = devm_request_irq(dev, cam_dev->irq,
> +			       isp_irq_camsv30, 0,
> +			       dev_name(dev), cam_dev);
> +	if (ret != 0) {
> +		dev_err(dev, "failed to request irq=%d\n", cam_dev->irq);
> +		return -ENODEV;

and again.

> +	}
> +
> +	cam_dev->hw_functions = &mtk_camsv30_hw_functions;
> +
> +	spin_lock_init(&cam_dev->irqlock);
> +
> +	/* initialise runtime power management */
> +	pm_runtime_set_autosuspend_delay(dev, MTK_CAMSV30_AUTOSUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_enable(dev);
> +	//pm_runtime_get_sync(dev);

Oops! development leftovers around! :-)

> +
> +	/* Initialize the v4l2 common part */
> +	return mtk_cam_dev_init(cam_dev);
> +}
> +
> +static int mtk_camsv30_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_cam_dev *cam_dev = dev_get_drvdata(dev);
> +
> +	mtk_cam_dev_cleanup(cam_dev);
> +	pm_runtime_put_autosuspend(dev);
> +	pm_runtime_disable(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops mtk_camsv30_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(mtk_camsv30_runtime_suspend,
> +			   mtk_camsv30_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id mtk_camsv30_of_ids[] = {
> +	{
> +		.compatible = "mediatek,mt8365-camsv",
> +		.data = &camsv30_conf,

Fits in one line: { .compatible =..... data... },

> +	},
> +	{}

and { /* sentinel */ }

> +};
> +MODULE_DEVICE_TABLE(of, mtk_camsv30_of_ids);
> +
> +static struct platform_driver mtk_camsv30_driver = {
> +	.probe = mtk_camsv30_probe,
> +	.remove = mtk_camsv30_remove,
> +	.driver = {
> +		.name = "mtk-camsv-isp30",
> +		.of_match_table = mtk_camsv30_of_ids,
> +		.pm = &mtk_camsv30_pm_ops,
> +	}
> +};
> +
> +module_platform_driver(mtk_camsv30_driver);
> +
> +MODULE_DESCRIPTION("MediaTek CAMSV ISP3.0 driver");
> +MODULE_AUTHOR("Florian Sylvestre <fsylvestre@baylibre.com>");
> +MODULE_LICENSE("GPL");

...there might be something else, but it's a long review already; let's see what
comes as v3.

Regards,
Angelo
