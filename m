Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF4745ABA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGCLCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCLCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:02:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06904D7;
        Mon,  3 Jul 2023 04:02:07 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 418F2660211C;
        Mon,  3 Jul 2023 12:02:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688382126;
        bh=Yu4bF+s4CL259dONcWfgSILVI573N6KIj7ZajslLRDI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kz/Xac9a+v4V65yYezj+fi91I4f6uhf+eQItJMdfli/lDrRWZSnq3q8kumifrLCfC
         BXzuxvNP1u1ME99vBM9WiRhV5u7+19YzUBaTYoaJ5BE2qFBKjngIebT74LoRAxDub6
         dEh+RZz9lBFlyvS+KOQrveVBEfImGJMUZUSlLV7TrTg8xvjKj9d/lp5kTPB5AjdlBp
         7wYeL6K8AXhZUmZxj54uos1jYDuG7c/bm14fstR0P1oqIy4m3OPP1vaY2o0aqHF3u3
         OQQWs1qKoOd4DSUucnthbCHEHCMz6bXS0Rn5tp62YDTp82W8rhUqrJRCRS9vjfRGRS
         VdFbmOoSQcp5g==
Message-ID: <da891ec5-473c-5bef-d88b-661fac70ed25@collabora.com>
Date:   Mon, 3 Jul 2023 13:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Louis Kuo <louis.kuo@mediatek.com>,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-3-jstephan@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230630100321.1951138-3-jstephan@baylibre.com>
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
> From: Louis Kuo <louis.kuo@mediatek.com>
> 
> This will add the mediatek ISP3.0 seninf (sensor interface) driver found
> on several Mediatek SoCs such as the mt8365.
> 
> Then seninf module has 4 physical CSI-2 inputs. Depending on the soc they
> may not be all connected.
> 
> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   MAINTAINERS                                   |    1 +
>   drivers/media/platform/mediatek/Kconfig       |    1 +
>   drivers/media/platform/mediatek/Makefile      |    1 +
>   drivers/media/platform/mediatek/isp/Kconfig   |    2 +
>   drivers/media/platform/mediatek/isp/Makefile  |    3 +
>   .../platform/mediatek/isp/isp_30/Kconfig      |   16 +
>   .../platform/mediatek/isp/isp_30/Makefile     |    3 +
>   .../mediatek/isp/isp_30/seninf/Makefile       |    5 +
>   .../mediatek/isp/isp_30/seninf/mtk_seninf.c   | 1561 +++++++++++++++++
>   .../isp/isp_30/seninf/mtk_seninf_reg.h        |   99 ++
>   10 files changed, 1692 insertions(+)
>   create mode 100644 drivers/media/platform/mediatek/isp/Kconfig
>   create mode 100644 drivers/media/platform/mediatek/isp/Makefile
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Kconfig
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Makefile
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af273a477139..9fda342ad331 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13356,6 +13356,7 @@ M:	Julien Stephan <jstephan@baylibre.com>
>   M:	Andy Hsieh <andy.hsieh@mediatek.com>
>   S:	Supported
>   F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> +F:	drivers/media/platform/mediatek/isp/isp_30/seninf/*
>   
>   MEDIATEK SMI DRIVER
>   M:	Yong Wu <yong.wu@mediatek.com>
> diff --git a/drivers/media/platform/mediatek/Kconfig b/drivers/media/platform/mediatek/Kconfig
> index 84104e2cd024..4e0a5a43f35e 100644
> --- a/drivers/media/platform/mediatek/Kconfig
> +++ b/drivers/media/platform/mediatek/Kconfig
> @@ -7,3 +7,4 @@ source "drivers/media/platform/mediatek/mdp/Kconfig"
>   source "drivers/media/platform/mediatek/vcodec/Kconfig"
>   source "drivers/media/platform/mediatek/vpu/Kconfig"
>   source "drivers/media/platform/mediatek/mdp3/Kconfig"
> +source "drivers/media/platform/mediatek/isp/Kconfig"
> diff --git a/drivers/media/platform/mediatek/Makefile b/drivers/media/platform/mediatek/Makefile
> index 38e6ba917fe5..695f05f525a6 100644
> --- a/drivers/media/platform/mediatek/Makefile
> +++ b/drivers/media/platform/mediatek/Makefile
> @@ -4,3 +4,4 @@ obj-y += mdp/
>   obj-y += vcodec/
>   obj-y += vpu/
>   obj-y += mdp3/
> +obj-y += isp/
> diff --git a/drivers/media/platform/mediatek/isp/Kconfig b/drivers/media/platform/mediatek/isp/Kconfig
> new file mode 100644
> index 000000000000..708b9a6660d2
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/Kconfig
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +source "drivers/media/platform/mediatek/isp/isp_30/Kconfig"
> diff --git a/drivers/media/platform/mediatek/isp/Makefile b/drivers/media/platform/mediatek/isp/Makefile
> new file mode 100644
> index 000000000000..a81ab33d0dd3
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-y += isp_30/
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/Kconfig b/drivers/media/platform/mediatek/isp/isp_30/Kconfig
> new file mode 100644
> index 000000000000..831f9bee5fdd
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config MTK_SENINF

MTK_SENINF_V30 or MTK_ISP30_SENINF instead?

> +	tristate "MediaTek ISP3.0 SENINF driver"
> +	depends on VIDEO_V4L2_SUBDEV_API
> +	depends on MEDIA_CAMERA_SUPPORT
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on OF
> +	select V4L2_FWNODE
> +	default n
> +	help
> +	  This driver provides a MIPI CSI-2 receiver interface to connect
> +	  an external camera module with MediaTek ISP3.0. It is able to handle
> +	  multiple cameras at the same time.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mtk-seninf.

..snip..

> diff --git a/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c b/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c
> new file mode 100644
> index 000000000000..93a13a87d967
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c

s/isp_30/isp30/g and s/mtk_seninf.c/mtk-seninf.c/g


...but then, I'm not sure that having a `isp30` folder inside of `isp` would be
actually beneficial for the driver structure. You're the judge.

> @@ -0,0 +1,1561 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/videodev2.h>
> +#include <media/media-device.h>
> +#include <media/media-entity.h>
> +#include <media/v4l2-async.h>
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-mc.h>
> +#include <media/v4l2-subdev.h>
> +
> +#include "mtk_seninf_reg.h"

If seninf for ISP3 is entirely different from ISP2 and ISP1 seninf, I'd rename
that header to "mtk_isp3_seninf_reg.h" instead.

> +
> +#define SENINF_TIMESTAMP_STEP		0x67
> +#define SENINF_SETTLE_DELAY		0x15
> +#define SENINF_HS_TRAIL_PARAMETER	0x8
> +
> +#define SENINF_MAX_NUM_INPUTS		4
> +#define SENINF_MAX_NUM_OUTPUTS		6
> +#define SENINF_MAX_NUM_MUXES		6
> +#define SENINF_MAX_NUM_PADS		(SENINF_MAX_NUM_INPUTS + \
> +					 SENINF_MAX_NUM_OUTPUTS)
> +
> +#define SENINF_DEFAULT_BUS_FMT		MEDIA_BUS_FMT_SGRBG10_1X10
> +#define SENINF_DEFAULT_WIDTH		1920
> +#define SENINF_DEFAULT_HEIGHT		1080
> +
> +#define SENINF_PAD_10BIT		0
> +
> +#define SENINF_TEST_MODEL		0
> +#define SENINF_NORMAL_MODEL		1
> +#define SENINF_ALL_ERR_IRQ_EN		0x7f
> +#define SENINF_IRQ_CLR_SEL		0x80000000
> +
> +#define SENINF_MIPI_SENSOR		0x8
> +
> +enum PIXEL_MODE {

Lowercase please.

> +	ONE_PIXEL_MODE  = 0x0,
> +	TWO_PIXEL_MODE  = 0x1,
> +	FOUR_PIXEL_MODE = 0x2,
> +};
> +
> +/* Port number in the device tree. */
> +enum mtk_seninf_port {
> +	CSI_PORT_0 = 0,	/* 4D1C or 2D1C */
> +	CSI_PORT_1,	/* 4D1C */
> +	CSI_PORT_2,	/* 4D1C */
> +	CSI_PORT_0B,	/* 2D1C */
> +};
> +
> +enum mtk_seninf_id {
> +	SENINF_1 = 0,
> +	SENINF_2 = 1,
> +	SENINF_3 = 2,
> +	SENINF_5 = 4,

Why is there no SENINF_4?
That deserves a comment in the code.

> +};
> +
> +static const u32 port_to_seninf_id[] = {
> +	[CSI_PORT_0] = SENINF_1,
> +	[CSI_PORT_1] = SENINF_3,
> +	[CSI_PORT_2] = SENINF_5,
> +	[CSI_PORT_0B] = SENINF_2,

Is the port-to-seninf path really static? Is there any way we can for example
configure CSI_PORT_0 to use SENINF_3 instead?

> +};
> +
> +enum mtk_seninf_phy_mode {
> +	SENINF_PHY_MODE_NONE,
> +	SENINF_PHY_MODE_4D1C,
> +	SENINF_PHY_MODE_2D1C,
> +};
> +
> +enum mtk_seninf_format_flag {
> +	MTK_SENINF_FORMAT_BAYER = BIT(0),
> +	MTK_SENINF_FORMAT_DPCM = BIT(1),
> +	MTK_SENINF_FORMAT_JPEG = BIT(2),
> +	MTK_SENINF_FORMAT_INPUT_ONLY = BIT(3),
> +};
> +
> +/**
> + * struct mtk_seninf_conf - Model-specific SENINF parameters
> + * @model: Model description
> + * @nb_inputs: Number of SENINF inputs
> + * @nb_muxes: Number of SENINF MUX (FIFO) instances
> + * @nb_outputs: Number of outputs (to CAM and CAMSV instances)
> + */
> +struct mtk_seninf_conf {
> +	const char *model;
> +	u8 nb_inputs;
> +	u8 nb_muxes;
> +	u8 nb_outputs;
> +};
> +

...snip...


> +
> +static const struct mtk_seninf_format_info mtk_seninf_formats[] = {
> +	{
> +		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
> +		.flags = MTK_SENINF_FORMAT_BAYER,

Each entry fits in one line.

	{ .code = MEDIA_BUS_FMT_SBGGR8_1X8, .flags = MTK_SENINF_FORMAT_BAYER },

> +	}, {
> +		.code = MEDIA_BUS_FMT_SGBRG8_1X8,
> +		.flags = MTK_SENINF_FORMAT_BAYER,

..snip..

> +
> +static const struct mtk_seninf_format_info *mtk_seninf_format_info(u32 code)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mtk_seninf_formats); ++i) {
> +		if (mtk_seninf_formats[i].code == code)
> +			return &mtk_seninf_formats[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * I/O Accessors
> + */
> +static u32 mtk_seninf_read(struct mtk_seninf *priv, u32 reg)
> +{
> +	return readl(priv->base + reg);

I don't think that we need this kind of accessor. It's one line, performing either
just a readl or just a writel, so you can simply use readl/writel directly.

> +}
> +
> +static void mtk_seninf_write(struct mtk_seninf *priv, u32 reg, u32 value)
> +{
> +	writel(value, priv->base + reg);
> +}
> +
> +static void __mtk_seninf_update(struct mtk_seninf *priv, u32 reg,
> +				u32 mask, u32 value)
> +{
> +	u32 val = mtk_seninf_read(priv, reg);
> +
> +	mtk_seninf_write(priv, reg, (val & ~mask) | (value & mask));
> +}
> +
> +#define mtk_seninf_update(priv, reg, field, val)			\
> +	__mtk_seninf_update(priv, reg, reg##_##field,		\
> +			    FIELD_PREP(reg##_##field, val))
> +
> +static u32 mtk_seninf_input_read(struct mtk_seninf_input *input, u32 reg)
> +{
> +	return readl(input->base + reg);
> +}
> +
> +static void mtk_seninf_input_write(struct mtk_seninf_input *input, u32 reg,
> +				   u32 value)
> +{

same here.

> +	writel(value, input->base + reg);
> +}
> +
> +static void __mtk_seninf_input_update(struct mtk_seninf_input *input, u32 reg,
> +				      u32 mask, u32 value)
> +{
> +	u32 val = mtk_seninf_input_read(input, reg);
> +
> +	mtk_seninf_input_write(input, reg, (val & ~mask) | (value & mask));
> +}
> +
> +#define mtk_seninf_input_update(input, reg, field, val)			\
> +	__mtk_seninf_input_update(input, reg, reg##_##field,	\
> +				  FIELD_PREP(reg##_##field, val))
> +
> +static u32 mtk_seninf_mux_read(struct mtk_seninf_mux *mux, u32 reg)
> +{
> +	return readl(mux->base + reg);

...and here

> +}
> +
> +static void mtk_seninf_mux_write(struct mtk_seninf_mux *mux, u32 reg,
> +				 u32 value)
> +{
> +	writel(value, mux->base + reg);
> +}
> +
> +static void __mtk_seninf_mux_update(struct mtk_seninf_mux *mux, u32 reg,
> +				    u32 mask, u32 value)
> +{
> +	u32 val = mtk_seninf_mux_read(mux, reg);
> +
> +	mtk_seninf_mux_write(mux, reg, (val & ~mask) | (value & mask));
> +}
> +
> +#define mtk_seninf_mux_update(mux, reg, field, val)			\
> +	__mtk_seninf_mux_update(mux, reg, reg##_##field,	\
> +				FIELD_PREP(reg##_##field, val))
> +

..snip..


> +static void mtk_seninf_input_setup_csi2_rx(struct mtk_seninf_input *input)
> +{
> +	unsigned int lanes[4] = { };

I don't like that `4` magic number.

#define MTK_CSI_MAX_LANES 4
or
#define MTK_CSIHW_MAX_LANES 4

> +	unsigned int i;
> +
> +	/*
> +	 * Configure data lane muxing. In 2D1C mode, lanes 0 to 2 correspond to
> +	 * CSIx[AB]_L{0,1,2}, and in 4D1C lanes 0 to 5 correspond to
> +	 * CSIxA_L{0,1,2}, CSIxB_L{0,1,2}.
> +	 *
> +	 * The clock lane must be skipped when calculating the index of the
> +	 * physical data lane. For instance, in 4D1C mode, the sensor clock
> +	 * lane is typically connected to lane 2 (CSIxA_L2), and the sensor
> +	 * data lanes 0-3 to lanes 1 (CSIxA_L1), 3 (CSIxB_L0), 0 (CSIxA_L0) and
> +	 * 4 (CSIxB_L1). The when skipping the clock lane, the data lane
> +	 * indices become 1, 2, 0 and 3.
> +	 */
> +	for (i = 0; i < input->bus.num_data_lanes; ++i) {
> +		lanes[i] = input->bus.data_lanes[i];
> +		if (lanes[i] > input->bus.clock_lane)
> +			lanes[i]--;
> +	}
> +
> +	mtk_seninf_input_update(input, MIPI_RX_CON24_CSI0,
> +				CSI0_BIST_LN0_MUX, lanes[0]);
> +	mtk_seninf_input_update(input, MIPI_RX_CON24_CSI0,
> +				CSI0_BIST_LN1_MUX, lanes[1]);

89 columns is fine, so all of those do fit in one line.

> +	mtk_seninf_input_update(input, MIPI_RX_CON24_CSI0,
> +				CSI0_BIST_LN2_MUX, lanes[2]);
> +	mtk_seninf_input_update(input, MIPI_RX_CON24_CSI0,
> +				CSI0_BIST_LN3_MUX, lanes[3]);
> +}
> +
> +static void mtk_seninf_input_setup_csi2(struct mtk_seninf_input *input,
> +					struct v4l2_subdev_state *state)
> +{
> +	const struct mtk_seninf_format_info *fmtinfo;
> +	const struct v4l2_mbus_framefmt *format;
> +	unsigned int dpcm;
> +	unsigned int data_lane_num = input->bus.num_data_lanes;

`unsigned int num_data_lanes` would be more consistent.

> +	unsigned int data_header_order = 1;

Is this a constant?! If so, why is it not a definition? Also, what does `1` mean?

> +	unsigned int val = 0;
> +
> +	format = v4l2_subdev_state_get_stream_format(state, input->pad, 0);
> +	fmtinfo = mtk_seninf_format_info(format->code);
> +
> +	/* Configure timestamp */
> +	mtk_seninf_input_write(input, SENINF_TG1_TM_STP, SENINF_TIMESTAMP_STEP);
> +
> +	/* HQ */
> +	mtk_seninf_input_write(input, SENINF_TG1_PH_CNT, 0x0);
> +	mtk_seninf_input_write(input, SENINF_TG1_SEN_CK, 0x10001);
> +
> +	/* First Enable Sensor interface and select pad (0x1a04_0200) */
> +	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_CTRL, PAD2CAM_DATA_SEL, SENINF_PAD_10BIT);
> +	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_SRC_SEL, 0);
> +	mtk_seninf_input_update(input, SENINF_CTRL_EXT, SENINF_CSI2_IP_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_CTRL_EXT, SENINF_NCSI2_IP_EN, 0);
> +
> +	/* DPCM Enable */
> +	dpcm = fmtinfo->flags & MTK_SENINF_FORMAT_DPCM ? 0x2a : 0;

What does 0x2a mean?

> +	val = 1 << ((dpcm == 0x2a) ? 15 : ((dpcm & 0xF) + 7));

This is BIT(something);

> +	mtk_seninf_input_write(input, SENINF_CSI2_DPCM, val);
> +
> +	/* Settle delay */
> +	mtk_seninf_input_update(input, SENINF_CSI2_LNRD_TIMING,
> +				DATA_SETTLE_PARAMETER, SENINF_SETTLE_DELAY);
> +
> +	/* HQ */
> +	mtk_seninf_input_write(input, SENINF_CSI2_LNRC_FSM, 0x10);
> +
> +	/* CSI2 control */
> +	val = mtk_seninf_input_read(input, SENINF_CSI2_CTL)
> +	    | (data_header_order << 16) | 0x10 | ((1 << data_lane_num) - 1);

What is 0x10?
Also, (BIT(data_lane_num) - 1).

> +	mtk_seninf_input_write(input, SENINF_CSI2_CTL, val);
> +
> +	mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL,
> +				BYPASS_LANE_RESYNC, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL, CDPHY_SEL, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL,
> +				CPHY_LANE_RESYNC_CNT, 3);
> +	mtk_seninf_input_update(input, SENINF_CSI2_MODE, CSR_CSI2_MODE, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_MODE, CSR_CSI2_HEADER_LEN, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_DPHY_SYNC, SYNC_SEQ_MASK_0, 0xff00);
> +	mtk_seninf_input_update(input, SENINF_CSI2_DPHY_SYNC, SYNC_SEQ_PAT_0, 0x001d);
> +
> +	mtk_seninf_input_update(input, SENINF_CSI2_CTL, CLOCK_HS_OPTION, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_CTL, HSRX_DET_EN, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_CTL, HS_TRAIL_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_CSI2_HS_TRAIL, HS_TRAIL_PARAMETER,
> +				SENINF_HS_TRAIL_PARAMETER);
> +
> +	/* Set debug port to output packet number */
> +	mtk_seninf_input_update(input, SENINF_CSI2_DGB_SEL, DEBUG_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_CSI2_DGB_SEL, DEBUG_SEL, 0x1a);
> +
> +	/* HQ */
> +	mtk_seninf_input_write(input, SENINF_CSI2_SPARE0, 0xfffffffe);
> +
> +	/* Enable CSI2 IRQ mask */
> +	/* Turn on all interrupt */
> +	mtk_seninf_input_write(input, SENINF_CSI2_INT_EN, 0xffffffff);
> +	/* Write clear CSI2 IRQ */
> +	mtk_seninf_input_write(input, SENINF_CSI2_INT_STATUS, 0xffffffff);
> +	/* Enable CSI2 Extend IRQ mask */
> +	/* Turn on all interrupt */
> +	mtk_seninf_input_update(input, SENINF_CTRL, CSI2_SW_RST, 1);
> +	udelay(1);
> +	mtk_seninf_input_update(input, SENINF_CTRL, CSI2_SW_RST, 0);

Is there any way to check if the CSI port did reset, or is it *guaranteed* to get
out of reset in a microsecond after deasserting SW_RST?

> +}
> +
> +static void mtk_seninf_mux_setup(struct mtk_seninf_mux *mux,
> +				 struct mtk_seninf_input *input,
> +				 struct v4l2_subdev_state *state)
> +{
> +	const struct mtk_seninf_format_info *fmtinfo;
> +	const struct v4l2_mbus_framefmt *format;
> +	unsigned int pix_sel_ext;
> +	unsigned int pix_sel;
> +	unsigned int hs_pol = 0;
> +	unsigned int vs_pol = 0;
> +	unsigned int pixel_mode = TWO_PIXEL_MODE;
> +	unsigned int val;
> +
> +	format = v4l2_subdev_state_get_stream_format(state, input->pad, 0);
> +	fmtinfo = mtk_seninf_format_info(format->code);
> +
> +	/* Enable mux */
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_MUX_EN, 1);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_SRC_SEL,
> +			      SENINF_MIPI_SENSOR);

Fits in one line.

> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
> +			      SENINF_SRC_SEL_EXT, SENINF_NORMAL_MODEL);

This one too, it's 98 cols, still acceptable.

> +
> +	switch (pixel_mode) {

You're forcing TWO_PIXEL_MODE but then you have a switch here: I get the point, as
in I get that you expect this to be extended to have that read from somewhere, but
only then will this switch make sense.

So, you could either remove this switch or actually introduce some logic that will
make `pixel_mode` variable; I'd be happy if you go for the second option.

> +	case 1: /* 2 Pixel */

Besides, `case 1` is from enum pixel_mode, so please use the definitions instead of
magic numbers.

> +		pix_sel_ext = 0;
> +		pix_sel = 1;
> +		break;
> +	case 2: /* 4 Pixel */
> +		pix_sel_ext = 1;
> +		pix_sel = 0;
> +		break;
> +	default: /* 1 Pixel */
> +		pix_sel_ext = 0;
> +		pix_sel = 0;
> +		break;
> +	}
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
> +			      SENINF_PIX_SEL_EXT, pix_sel_ext);

one line.

> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_PIX_SEL, pix_sel);
> +
> +	if (!(fmtinfo->flags & MTK_SENINF_FORMAT_JPEG)) {

Logically, inverting this branch to

	if (fmtinfo->flags & MTK_SENINF_FORMAT_JPEG) {
		...
	} else {
		...
	}

would be better imo.

> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_EN, 2);
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN, 0x1b);
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN, 0x1f);

Also, can you please add definitions for those FIFO_xxxx_EN values?

> +	} else {
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_EN, 0);
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN, 0x18);
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN, 0x1e);
> +	}
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_POL, hs_pol);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_VSYNC_POL, vs_pol);
> +
> +	val = mtk_seninf_mux_read(mux, SENINF_MUX_CTRL);

rst_mask = SENINF_MUX_CTRL_SENINF_IRQ_SW_RST | SENINF_MUX_CTRL_SENINF_MUX_SW_RST;

writel(mux->base + SENINF_MUX_CTRL, val | rst_mask);
writel(mux->base + SENINFMUX_CTRL, val & ~rst_mask);

that's better, right? :-)

> +	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL, val |
> +			     SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
> +			     SENINF_MUX_CTRL_SENINF_MUX_SW_RST);
> +	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL, val &
> +			     ~(SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
> +			       SENINF_MUX_CTRL_SENINF_MUX_SW_RST));
> +
> +	/* HQ */
> +	mtk_seninf_mux_write(mux, SENINF_MUX_SPARE, 0xc2000);

Again, what does 0xc2000 mean?!

> +}
> +
> +static void mtk_seninf_top_mux_setup(struct mtk_seninf *priv,
> +				     enum mtk_seninf_id seninf_id,
> +				     struct mtk_seninf_mux *mux)
> +{
> +	unsigned int val;
> +
> +	/*
> +	 * Use the top mux (from SENINF input to MUX) to configure routing, and
> +	 * hardcode a 1:1 mapping from the MUX instances to the SENINF outputs.
> +	 */
> +	val = mtk_seninf_read(priv, SENINF_TOP_MUX_CTRL)
> +		& ~(0xf << (mux->mux_id * 4));
> +	val |= (seninf_id & 0xf) << (mux->mux_id * 4);
> +	mtk_seninf_write(priv, SENINF_TOP_MUX_CTRL, val);
> +
> +	mtk_seninf_write(priv, SENINF_TOP_CAM_MUX_CTRL, 0x76541010);
> +}
> +
> +static void seninf_enable_test_pattern(struct mtk_seninf *priv,
> +				       struct v4l2_subdev_state *state)
> +{
> +	struct mtk_seninf_input *input = &priv->inputs[CSI_PORT_0];
> +	struct mtk_seninf_mux *mux = &priv->muxes[0];
> +	const struct mtk_seninf_format_info *fmtinfo;
> +	const struct v4l2_mbus_framefmt *format;
> +	unsigned int val;
> +	unsigned int pixel_mode = TWO_PIXEL_MODE;
> +	unsigned int pix_sel_ext;
> +	unsigned int pix_sel;
> +	unsigned int hs_pol = 0;
> +	unsigned int vs_pol = 0;
> +	unsigned int seninf = 0;
> +	unsigned int mux_id = mux->mux_id;
> +
> +	format = v4l2_subdev_state_get_stream_format(state, priv->conf->nb_inputs, 0);
> +	fmtinfo = mtk_seninf_format_info(format->code);
> +
> +	mtk_seninf_update(priv, SENINF_TOP_CTRL, MUX_LP_MODE, 0);
> +
> +	mtk_seninf_update(priv, SENINF_TOP_CTRL, SENINF_PCLK_EN, 1);
> +	mtk_seninf_update(priv, SENINF_TOP_CTRL, SENINF2_PCLK_EN, 1);
> +
> +	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_SRC_SEL, 1);
> +	mtk_seninf_input_update(input, SENINF_CTRL_EXT,
> +				SENINF_TESTMDL_IP_EN, 1);
> +
> +	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_PAT, 0xc);
> +	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_VSYNC, 4);
> +	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_DUMMYPXL, 0x28);
> +
> +	if (fmtinfo->flags & MTK_SENINF_FORMAT_BAYER)
> +		mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_FMT, 0x0);
> +	else
> +		mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_FMT, 0x1);
> +

#define SENINF_TG1_TM_HEIGHT	GENMASK(31, 16)
#define SENINF_TG1_TM_WIDTH	GENMASK(15, 0)

size = FIELD_PREP(SENINF_TG1_TM_HEIGHT, (format->height + 8));

switch ... {
	case something:
		size |= FIELD_PREP(SENINF_TG1_TM_WIDTH, format->width * 2);
		break;
	case default:
		size |= FIELD_PREP(SENINF_TG1_TM_WIDTH, format->width);
		break;
}

writel(the_base + the_reg, size);

:-) :-) :-) :-)

> +	switch (format->code) {
> +	case MEDIA_BUS_FMT_UYVY8_1X16:
> +	case MEDIA_BUS_FMT_VYUY8_1X16:
> +	case MEDIA_BUS_FMT_YUYV8_1X16:
> +	case MEDIA_BUS_FMT_YVYU8_1X16:
> +		mtk_seninf_input_write(input, SENINF_TG1_TM_SIZE,
> +				       (format->height + 8) << 16 |
> +				       format->width * 2);
> +		break;
> +	default:
> +		mtk_seninf_input_write(input, SENINF_TG1_TM_SIZE,
> +				       (format->height + 8) << 16 |
> +				       format->width);
> +		break;
> +	}
> +
> +	mtk_seninf_input_write(input, SENINF_TG1_TM_CLK, 0x8);

Magic numbers again...

> +	mtk_seninf_input_write(input, SENINF_TG1_TM_STP, 0x1);
> +
> +	/* Set top mux */
> +	val = (mtk_seninf_read(priv, SENINF_TOP_MUX_CTRL) & (~(0xf << (mux_id * 4)))) |
> +		((seninf & 0xf) << (mux_id * 4));
> +	mtk_seninf_write(priv, SENINF_TOP_MUX_CTRL, val);
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_MUX_EN, 1);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
> +			      SENINF_SRC_SEL_EXT, SENINF_TEST_MODEL);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_SRC_SEL, 1);
> +
> +	switch (pixel_mode) {
> +	case 1:
> +		pix_sel_ext = 0;
> +		pix_sel = 1;
> +		break;
> +	case 2:
> +		pix_sel_ext = 1;
> +		pix_sel = 0;
> +		break;
> +	default:
> +		pix_sel_ext = 0;
> +		pix_sel = 0;
> +		break;
> +	}
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
> +			      SENINF_PIX_SEL_EXT, pix_sel_ext);
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_PIX_SEL, pix_sel);
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN, 0x1f);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN, 0x1b);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_EN, 2);
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_POL, hs_pol);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_VSYNC_POL, vs_pol);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_MASK, 1);
> +
> +	mtk_seninf_mux_write(mux, SENINF_MUX_INTEN,
> +			     SENINF_IRQ_CLR_SEL | SENINF_ALL_ERR_IRQ_EN);
> +
> +	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL,
> +			     mtk_seninf_mux_read(mux, SENINF_MUX_CTRL) |
> +			     SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
> +			     SENINF_MUX_CTRL_SENINF_MUX_SW_RST);
> +	udelay(1);
> +	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL,
> +			     mtk_seninf_mux_read(mux, SENINF_MUX_CTRL) &
> +			     ~(SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
> +			       SENINF_MUX_CTRL_SENINF_MUX_SW_RST));
> +
> +	//check this

Please, check this :-) :-)

> +	mtk_seninf_write(priv, SENINF_TOP_CAM_MUX_CTRL, 0x76540010);
> +
> +	dev_dbg(priv->dev, "%s: OK\n", __func__);
> +}
> +
> +static void mtk_seninf_start(struct mtk_seninf *priv,
> +			     struct v4l2_subdev_state *state,
> +			     struct mtk_seninf_input *input,
> +			     struct mtk_seninf_mux *mux)
> +{
> +	phy_power_on(input->phy);
> +
> +	mtk_seninf_input_setup_csi2_rx(input);
> +	mtk_seninf_input_setup_csi2(input, state);
> +
> +	mtk_seninf_mux_setup(mux, input, state);
> +	mtk_seninf_top_mux_setup(priv, input->seninf_id, mux);
> +}
> +
> +static void mtk_seninf_stop(struct mtk_seninf *priv,
> +			    struct mtk_seninf_input *input)
> +{
> +	unsigned int val;
> +
> +	/* Disable CSI2(2.5G) first */
> +	val = mtk_seninf_input_read(input, SENINF_CSI2_CTL);
> +	val &= ~(SENINF_CSI2_CTL_CLOCK_LANE_EN |
> +		 SENINF_CSI2_CTL_DATA_LANE3_EN |
> +		 SENINF_CSI2_CTL_DATA_LANE2_EN |
> +		 SENINF_CSI2_CTL_DATA_LANE1_EN |
> +		 SENINF_CSI2_CTL_DATA_LANE0_EN);
> +	mtk_seninf_input_write(input, SENINF_CSI2_CTL, val);
> +
> +	if (!priv->is_testmode)
> +		phy_power_off(input->phy);
> +}
> +

..snip..


> +/* -----------------------------------------------------------------------------
> + * V4L2 Subdev Operations
> + */
> +static int seninf_s_stream(struct v4l2_subdev *sd, unsigned int source_pad,
> +			   int on)
> +{
> +	struct mtk_seninf *priv = sd_to_mtk_seninf(sd);
> +	struct v4l2_subdev_state *state;
> +	struct mtk_seninf_input *input;
> +	struct mtk_seninf_mux *mux;
> +	struct v4l2_subdev *source;
> +	u32 sink_pad;
> +	int ret;
> +
> +	/* Stream control can only operate on source pads. */
> +	if (source_pad < priv->conf->nb_inputs ||
> +	    source_pad >= priv->conf->nb_inputs + priv->conf->nb_outputs)
> +		return -EINVAL;
> +
> +	/*
> +	 * Locate the SENINF input and MUX for the source pad.
> +	 *
> +	 * Hardcode a 1:1 mapping of MUX instances to SENINF
> +	 * outputs to match the TOP_CAM_MUX configuration in
> +	 * mtk_seninf_top_mux_setup().
> +	 */
> +	state = v4l2_subdev_lock_and_get_active_state(&priv->subdev);
> +	if (!state)
> +		return -EPIPE;
> +
> +	ret = v4l2_subdev_routing_find_opposite_end(&state->routing, source_pad, 0, &sink_pad,
> +						    NULL);
> +	if (ret) {
> +		dev_dbg(priv->dev, "No sink pad routed to source pad %u\n",
> +			source_pad);

one line please...

> +		goto unlock;
> +	}
> +

..snip..

> +
> +static int seninf_set_fmt(struct v4l2_subdev *sd,
> +			  struct v4l2_subdev_state *state,
> +			  struct v4l2_subdev_format *fmt)
> +{
> +	struct mtk_seninf *priv = sd_to_mtk_seninf(sd);
> +	const struct mtk_seninf_format_info *fmtinfo;
> +	struct v4l2_mbus_framefmt *format;
> +
> +	/*
> +	 * TODO (?): We should disallow setting formats on the source pad
> +	 * completely, as the SENINF can't perform any processing. This would
> +	 * however break usage of the test pattern generator, as there would be
> +	 * no way to configure formats at all when no active input is selected.
> +	 */

It's either a TODO or not... but whatever, I imagine that the difficulty here is
that `priv->is_testmode` may become `true` after .set_fmt(), right?

> +
> +	/*
> +	 * Default to the first format if the requested media bus code isn't
> +	 * supported.
> +	 */
> +	fmtinfo = mtk_seninf_format_info(fmt->format.code);
> +	if (!fmtinfo) {
> +		fmtinfo = &mtk_seninf_formats[0];
> +		fmt->format.code = fmtinfo->code;
> +	}
> +
> +	/* Interlaced formats are not supported yet. */
> +	fmt->format.field = V4L2_FIELD_NONE;
> +
> +	/* Store the format. */
> +

Drop extra blank line please.

> +	format = v4l2_subdev_state_get_stream_format(state, fmt->pad, fmt->stream);
> +	if (!format)
> +		return -EINVAL;
> +
> +	*format = fmt->format;
> +
> +	if (mtk_seninf_pad_is_source(priv, fmt->pad))
> +		return 0;
> +
> +	/* Propagate the format to the corresponding source pad. */
> +	format = v4l2_subdev_state_get_opposite_stream_format(state, fmt->pad,
> +							      fmt->stream);
> +	if (!format)
> +		return -EINVAL;
> +
> +	*format = fmt->format;
> +
> +	return 0;
> +}
> +

..snip..

> +
> +static int mtk_seninf_fwnode_parse(struct device *dev,
> +				   unsigned int id)
> +
> +{
> +	static const char * const phy_names[] = { "csi0", "csi1", "csi2", "csi0b"};
> +

Please remove the extra blank line.

> +	struct mtk_seninf *priv = dev_get_drvdata(dev);
> +	struct mtk_seninf_async_subdev *s_asd;
> +	unsigned int port;

Move this before `ret`: makes it a little more readable.

> +	struct mtk_seninf_input *input;
> +	struct fwnode_handle *ep, *fwnode;
> +	struct v4l2_fwnode_endpoint vep = {
> +		.bus_type = V4L2_MBUS_CSI2_DPHY,
> +	};
> +	struct v4l2_async_subdev *asd;
> +	int ret;

static const char * const phy_names[] = { "csi0", "csi1", "csi2", "csi0b" };
struct mtk_seninf *priv = dev_get_drvdata(dev);
struct mtk_seninf_async_subdev *s_asd;
struct fwnode_handle *ep, *fwnode;
struct mtk_seninf_input *input;
struct v4l2_async_subdev *asd;
struct v4l2_fwnode_endpoint vep = {
	.bus_type = V4L2_MBUS_CSI2_DPHY,
};
unsigned int port;
int ret;


> +
> +	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), id, 0, 0);
> +	if (!ep)
> +		return 0;

Are you sure that this should really be `return 0`?

> +
> +	fwnode = fwnode_graph_get_remote_endpoint(ep);
> +	ret = v4l2_fwnode_endpoint_parse(ep, &vep);
> +	if (ret) {
> +		dev_err(dev, "Failed to parse %pOF\n", to_of_node(fwnode));
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	asd = v4l2_async_nf_add_fwnode(&priv->notifier,
> +				       fwnode, struct v4l2_async_subdev);
> +	if (IS_ERR(asd)) {
> +		ret = PTR_ERR(asd);
> +		goto out;
> +	}
> +	s_asd = container_of(asd, struct mtk_seninf_async_subdev, asd);
> +
> +	port = vep.base.port;
> +	s_asd->port = port;
> +
> +	if (mtk_seninf_pad_is_source(priv, port))
> +		return 0;

hmmm... no fwnode_handle_put()!?

> +
> +	if (vep.bus_type != V4L2_MBUS_CSI2_DPHY) {
> +		dev_err(dev, "Only CSI2 bus type is currently supported\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	input = &priv->inputs[port];
> +
> +	input->pad = port;
> +	input->seninf_id = port_to_seninf_id[port];
> +	input->base = priv->base + 0x1000 * input->seninf_id;
> +	input->seninf = priv;
> +
> +	input->bus = vep.bus.mipi_csi2;
> +
> +	input->phy = devm_phy_get(dev, phy_names[port]);
> +	if (IS_ERR(input->phy)) {
> +		dev_err(dev, "failed to get phy:%ld\n", PTR_ERR(input->phy));
> +		ret = PTR_ERR(input->phy);
> +		goto out;
> +	}
> +	input->phy_mode = SENINF_PHY_MODE_4D1C;
> +
> +	s_asd->input = input;
> +
> +	ret = 0;

Honestly, I don't like that `ret = 0`, but I admit that this is the cleanest option
that we can have here, so it's fine.

> +out:
> +	fwnode_handle_put(ep);
> +	fwnode_handle_put(fwnode);
> +	return ret;
> +}
> +
> +static int mtk_seninf_notifier_bound(struct v4l2_async_notifier *notifier,
> +				     struct v4l2_subdev *sd,
> +				     struct v4l2_async_subdev *asd)
> +{
> +	struct mtk_seninf *priv = container_of(notifier, struct mtk_seninf, notifier);
> +	struct mtk_seninf_async_subdev *s_asd =
> +		container_of(asd, struct mtk_seninf_async_subdev, asd);
> +	struct device_link *link;
> +	int ret;
> +
> +	dev_dbg(priv->dev, "%s bound to SENINF port %u\n", sd->entity.name,
> +		s_asd->port);

one line.

> +
> +	if (mtk_seninf_pad_is_sink(priv, s_asd->port)) {
> +		struct mtk_seninf_input *input = s_asd->input;
> +
> +		input->source_sd = sd;
> +
> +		link = device_link_add(priv->dev, sd->dev,
> +				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +		if (!link) {
> +			dev_err(priv->dev,
> +				"Failed to create device link from source %s\n", sd->name);
> +			return -EINVAL;
> +		}
> +
> +		ret = v4l2_create_fwnode_links_to_pad(sd, &priv->pads[input->pad],
> +						      MEDIA_LNK_FL_IMMUTABLE |
> +						      MEDIA_LNK_FL_ENABLED);
> +	} else {
> +		link = device_link_add(sd->dev, priv->dev,
> +				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +		if (!link) {
> +			dev_err(priv->dev,
> +				"Failed to create device link to output %s\n", sd->name);
> +			return -EINVAL;
> +		}
> +
> +		ret = v4l2_create_fwnode_links_to_pad(&priv->subdev,
> +						      &sd->entity.pads[0],
> +						      MEDIA_LNK_FL_IMMUTABLE |
> +						      MEDIA_LNK_FL_ENABLED);
> +	}
> +	if (ret)
> +		dev_err(priv->dev, "Failed to create links between SENINF port %u and %s (%d)\n",
> +			s_asd->port, sd->entity.name, ret);

if (ret) {
	dev_err(...)
	return ret;
}

return 0;

> +
> +	return ret;
> +}
> +
> +static int mtk_seninf_notifier_complete(struct v4l2_async_notifier *notifier)
> +{
> +	struct mtk_seninf *priv = container_of(notifier, struct mtk_seninf, notifier);
> +	int ret;
> +
> +	ret = v4l2_device_register_subdev_nodes(&priv->v4l2_dev);
> +	if (ret)
> +		dev_err(priv->dev, "Failed to register subdev nodes: %d\n", ret);

if (ret) {
	dev_err....
	return ret;
}
return 0;

> +
> +	return ret;
> +}
> +
> +static const struct v4l2_async_notifier_operations mtk_seninf_async_ops = {
> +	.bound = mtk_seninf_notifier_bound,
> +	.complete = mtk_seninf_notifier_complete,
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * Probe & Remove
> + */

I don't think that we need such comments, btw.

> +
> +static int mtk_seninf_media_init(struct mtk_seninf *priv)
> +{
> +	struct media_pad *pads = priv->pads;
> +	const struct mtk_seninf_conf *conf = priv->conf;
> +	struct device *dev = priv->dev;
> +	struct media_device *media_dev = &priv->media_dev;
> +	u8 num_pads = conf->nb_outputs + conf->nb_inputs;

Some reordering would be good for readability here.

> +	unsigned int i;
> +	int ret;
> +
> +	media_dev->dev = dev;
> +	strscpy(media_dev->model, conf->model, sizeof(media_dev->model));
> +	snprintf(media_dev->bus_info, sizeof(media_dev->bus_info),
> +		 "platform:%s", dev_name(dev));
> +	media_dev->hw_revision = 0;
> +	media_device_init(media_dev);
> +
> +	ret = media_entity_pads_init(&priv->subdev.entity, num_pads, pads);
> +	if (ret)
> +		goto err_clean_media;
> +
> +	for (i = 0; i < conf->nb_inputs; i++)
> +		pads[i].flags = MEDIA_PAD_FL_SINK;
> +	for (i = conf->nb_inputs; i < num_pads; i++)
> +		pads[i].flags = MEDIA_PAD_FL_SOURCE;
> +
> +	return 0;
> +err_clean_media:
> +	media_device_cleanup(media_dev);
> +
> +	return ret;
> +}
> +
> +static int mtk_seninf_v4l2_async_register(struct mtk_seninf *priv)
> +{
> +	struct device *dev = priv->dev;
> +	const struct mtk_seninf_conf *conf = priv->conf;
> +	int ret;
> +	unsigned int i;

const struct mtk_seninf_conf *conf = priv->conf;
struct device *dev = priv->dev;
unsigned int i;
int ret;

> +
> +	v4l2_async_nf_init(&priv->notifier);
> +
> +	for (i = 0; i < conf->nb_inputs + conf->nb_outputs; ++i) {
> +		ret = mtk_seninf_fwnode_parse(dev, i);
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to parse endpoint at port %d, err: %d\n", i, ret);
> +			goto err_clean_notififer;
> +		}
> +	}
> +
> +	priv->notifier.ops = &mtk_seninf_async_ops;
> +	ret = v4l2_async_nf_register(&priv->v4l2_dev, &priv->notifier);
> +	if (ret)
> +		dev_err(dev, "Failed to register async notifier: %d\n", ret);

So you don't care about this failure?! :-)

> +	return 0;
> +
> +err_clean_notififer:
> +	v4l2_async_nf_cleanup(&priv->notifier);
> +
> +	return ret;
> +}
> +
> +static int mtk_seninf_v4l2_register(struct mtk_seninf *priv)
> +{
> +	struct v4l2_subdev *sd = &priv->subdev;
> +	struct device *dev = priv->dev;
> +	int ret;
> +
> +	/* Initialize media device & pads. */
> +	ret = mtk_seninf_media_init(priv);
> +	if (ret)
> +		return ret;
> +
> +	/* Initialize & register v4l2 device. */
> +	priv->v4l2_dev.mdev = &priv->media_dev;
> +
> +	ret = v4l2_device_register(dev, &priv->v4l2_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);

You can still use dev_err_probe, even if you're not returning: this would make
sure that the log format is consistent for at least all probe functions :-)

> +		goto err_clean_media;
> +	}
> +
> +	/* Initialize & register subdev. */
> +	v4l2_subdev_init(sd, &seninf_subdev_ops);
> +	sd->dev = dev;
> +	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
> +	sd->entity.ops = &seninf_media_ops;
> +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS
> +		  |  V4L2_SUBDEV_FL_STREAMS;
> +	strscpy(sd->name, dev_name(dev), V4L2_SUBDEV_NAME_SIZE);
> +	ret = seninf_initialize_controls(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize controls: %d\n", ret);
> +		goto err_unreg_v4l2;
> +	}
> +	v4l2_set_subdevdata(sd, priv);
> +
> +	ret = v4l2_subdev_init_finalize(sd);
> +	if (ret)
> +		goto err_free_handler;
> +
> +	ret = v4l2_device_register_subdev(&priv->v4l2_dev, sd);
> +	if (ret) {
> +		dev_err(dev, "Failed to register subdev: %d\n", ret);
> +		goto err_cleanup_subdev;
> +	}
> +
> +	/* Set up async device */
> +	ret = mtk_seninf_v4l2_async_register(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to register v4l2 async notifier: %d\n", ret);
> +		goto err_unreg_subdev;
> +	}
> +
> +	/* Register media device */
> +	ret = media_device_register(&priv->media_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register media device: %d\n", ret);
> +		goto err_unreg_notifier;
> +	}
> +
> +	return 0;
> +
> +err_unreg_notifier:
> +	v4l2_async_nf_unregister(&priv->notifier);
> +err_unreg_subdev:
> +	v4l2_device_unregister_subdev(sd);
> +err_cleanup_subdev:
> +	v4l2_subdev_cleanup(sd);
> +err_free_handler:
> +	v4l2_ctrl_handler_free(&priv->ctrl_handler);
> +err_unreg_v4l2:
> +	v4l2_device_unregister(&priv->v4l2_dev);
> +err_clean_media:
> +	media_entity_cleanup(&sd->entity);
> +	media_device_cleanup(&priv->media_dev);
> +
> +	return ret;
> +}
> +
> +static int seninf_probe(struct platform_device *pdev)
> +{
> +	/* List of clocks required by seninf. */
> +	static const char * const clk_names[] = {
> +		"camsys", "top_mux"
> +	};

Fits in one line; drop extra blank line.

> +
> +	struct mtk_seninf *priv;
> +	struct device *dev = &pdev->dev;

reordering: dev before priv

> +	unsigned int i;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct mtk_seninf), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->conf = of_device_get_match_data(dev);
> +
> +	dev_set_drvdata(dev, priv);
> +	priv->dev = dev;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->num_clks = ARRAY_SIZE(clk_names);
> +	priv->clks = devm_kcalloc(dev, priv->num_clks,
> +				  sizeof(*priv->clks), GFP_KERNEL);
> +	if (!priv->clks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < priv->num_clks; ++i)
> +		priv->clks[i].id = clk_names[i];
> +
> +	ret = devm_clk_bulk_get(dev, priv->num_clks, priv->clks);
> +	if (ret) {
> +		dev_err(dev, "failed to get seninf clock:%d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < priv->conf->nb_muxes; ++i) {
> +		struct mtk_seninf_mux *mux = &priv->muxes[i];
> +
> +		mux->pad = priv->conf->nb_inputs + i;
> +		mux->mux_id = i;
> +		mux->base = priv->base + 0x1000 * i;
> +		mux->seninf = priv;
> +	}
> +
> +	ret = mtk_seninf_v4l2_register(priv);

if (ret)
	return ret;

pm_runtime_enable(dev); (P.S.: Why not devm_pm_runtime_enable()?)

return 0;
}

> +	if (!ret)
> +		pm_runtime_enable(dev);
> +
> +	return ret;
> +}
> +
> +static int seninf_pm_suspend(struct device *dev)
> +{
> +	struct mtk_seninf *priv = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "seninf runtime suspend\n");
> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> +
> +	return 0;
> +}
> +
> +static int seninf_pm_resume(struct device *dev)
> +{
> +	struct mtk_seninf *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(dev, "seninf runtime resume\n");
> +	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock:%d\n", ret);
> +		return ret;
> +	}
> +
> +	mtk_seninf_csi2_setup_phy(priv);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops runtime_pm_ops = {
> +	SET_RUNTIME_PM_OPS(seninf_pm_suspend, seninf_pm_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)

Fits in one line.

> +};
> +
> +static int seninf_remove(struct platform_device *pdev)
> +{
> +	struct mtk_seninf *priv = dev_get_drvdata(&pdev->dev);
> +
> +	media_device_unregister(&priv->media_dev);
> +	media_device_cleanup(&priv->media_dev);
> +	v4l2_async_nf_unregister(&priv->notifier);
> +	v4l2_async_nf_cleanup(&priv->notifier);
> +	v4l2_device_unregister_subdev(&priv->subdev);
> +	v4l2_subdev_cleanup(&priv->subdev);
> +	v4l2_ctrl_handler_free(&priv->ctrl_handler);
> +	media_entity_cleanup(&priv->subdev.entity);
> +	v4l2_device_unregister(&priv->v4l2_dev);
> +
> +	pm_runtime_disable(priv->dev);
> +
> +	return 0;
> +}
> +
> +static const struct mtk_seninf_conf seninf_8365_conf = {
> +	.model = "mtk-camsys-3.0",
> +	.nb_inputs = 4,
> +	.nb_muxes = 6,
> +	.nb_outputs = 4,
> +};
> +
> +static const struct of_device_id mtk_seninf_of_match[] = {
> +	{
> +		.compatible = "mediatek,mt8365-seninf",
> +		.data = &seninf_8365_conf,

This fits in one line:

{ .compatible = "mediatek,mt8365-seninf", .data = &seninf_8365_conf }

> +	},
> +	{

Please always end of_device_id lists with

	{ /* sentinel */ }

> +	},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_seninf_of_match);
> +
> +static struct platform_driver seninf_pdrv = {
> +	.driver	= {
> +		.name	= "mtk-seninf",

Either tabs or one space please.

> +		.pm  = &runtime_pm_ops,
> +		.of_match_table = mtk_seninf_of_match,
> +	},
> +	.probe	= seninf_probe,
> +	.remove	= seninf_remove,
> +};
> +
> +module_platform_driver(seninf_pdrv);
> +
> +MODULE_DESCRIPTION("MTK sensor interface driver");
> +MODULE_AUTHOR("Louis Kuo <louis.kuo@mediatek.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h b/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h
> new file mode 100644
> index 000000000000..b6af8567fa20
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +
> +#ifndef __SENINF_REG_H__
> +#define __SENINF_REG_H__
> +
> +#include <linux/bits.h>
> +
> +#define SENINF_TOP_CTRL							0x0000
> +#define SENINF_TOP_CTRL_MUX_LP_MODE					BIT(31)

..snip..

> +#define SENINF_MUX_CTRL_SENINF_MUX_EN					BIT(31)
> +#define SENINF_MUX_INTEN						0x0d04
> +#define SENINF_MUX_SPARE						0x0d2c
> +#define SENINF_MUX_CTRL_EXT						0x0d3c
> +#define SENINF_MUX_CTRL_EXT_SENINF_SRC_SEL_EXT				GENMASK(1, 0)
> +#define SENINF_MUX_CTRL_EXT_SENINF_PIX_SEL_EXT				BIT(4)

#endif /* __SENINF_REG_H__ */

> +#endif

Regards,
Angelo
