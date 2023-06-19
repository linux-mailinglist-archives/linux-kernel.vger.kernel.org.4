Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D7D73594A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjFSOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjFSON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:13:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD39E78;
        Mon, 19 Jun 2023 07:13:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98862e7e3e6so245019266b.0;
        Mon, 19 Jun 2023 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687184029; x=1689776029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6Yng48/u05hMXpd1JJ34C/keFLRgepFSqLUZWuJ5LY=;
        b=NLik40LfHSJs9DzDL7AxFI2kjxXRzSJzFsRpOI4PhoRVCWo44YOwRl+wMa0/DErFoZ
         tw+/TeRJ5HJdIvRDWVo49Yjr5yOV/4DTAg7iFa0cgd4d7u5y+2TH3MGKaxOnZllWN0TR
         EcwJpfPoZUtyG8wb7HFOF2rq+NKe+2/9b4A9c8BN5DlYmCs82uIQ/hUUMloq+kHDL/KS
         dfRBG8Ku9DVlzdy5+7lKwo9bNQdim4UTjflxmOkDacQVsW2oiV3ANAkoliL2UH0xY+mb
         phBO+oPIy2Nz+vnbS0HHCi2NZdHcJ8FWv3jwcBV34NUHjDJnnjukXdJBrvwrLDX7LwHv
         Zk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687184029; x=1689776029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6Yng48/u05hMXpd1JJ34C/keFLRgepFSqLUZWuJ5LY=;
        b=VqvHSf1+Pw5YxhzW2yji/fBza3naXvp8JYjZ59QK1NuyOR4Yny+fDU2ByhkYu7MrrS
         fnGEG4/EBDiSx+5L9PusLUp2+bYddtg9qaVTIU9xY+gf7Ds+iu5X+rigIenuncNdEjbZ
         zZd2lUCj7IUo8QOOuo83sDNkBIU5lsiQygL9YYl55Xvv7YVGjFJlKxD3wXijsdH0OV8E
         Qj1wlg4dKrX260TgQ2ad3OrWCHv5irLYI6WLH2m6Vx5Lv0+55bEYqBqU9tjYm7J2A7l6
         MxPJS8ikC5r0BykZyog6oBAdim1ewvf6KsdorJ1+xoOhQsnoz6GEaSWI27OVU1YPtw+x
         PRdA==
X-Gm-Message-State: AC+VfDxkGVq2SIR438gB0IYtAmljzwPvxaMtHnefgL3BNeeXAxu1mvmC
        ZTtg/bcyYtBQO6gaQnmHkS4=
X-Google-Smtp-Source: ACHHUZ5cGE5JaivQcop2cGFcRd7u07JcAv7Vs/MMr59OwkUKenYYTxYxtpWW+qVqR62sFQJu3jA5qQ==
X-Received: by 2002:a17:907:16a1:b0:988:d1d5:cd5b with SMTP id hc33-20020a17090716a100b00988d1d5cd5bmr1644961ejc.75.1687184028431;
        Mon, 19 Jun 2023 07:13:48 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation ([37.159.46.147])
        by smtp.gmail.com with ESMTPSA id p13-20020a1709066a8d00b00986ad2e34f4sm4191428ejr.205.2023.06.19.07.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:13:47 -0700 (PDT)
Date:   Mon, 19 Jun 2023 16:13:44 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 3/3] media: i2c: Add support for alvium camera
Message-ID: <ZJBimGYN12fiqqfn@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230608083127.545750-1-tomm.merciai@gmail.com>
 <20230608083127.545750-4-tomm.merciai@gmail.com>
 <ZILuNrA9cMaI9ihP@kekkonen.localdomain>
 <ZIMklWtBW8fx/Ddd@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZJAy4vRxI9uEUwQj@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJAy4vRxI9uEUwQj@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Mon, Jun 19, 2023 at 10:50:10AM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Fri, Jun 09, 2023 at 03:09:41PM +0200, Tommaso Merciai wrote:
> > Hi Sakar,
> > 
> > Thanks for your review.
> > 
> > On Fri, Jun 09, 2023 at 09:17:42AM +0000, Sakari Ailus wrote:
> > > Hi Tommaso,
> > > 
> > > Thanks for the patch.
> > > 
> > > On Thu, Jun 08, 2023 at 10:31:16AM +0200, Tommaso Merciai wrote:
> > > > The Alvium camera is shipped with sensor + isp in the same housing.
> > > > The camera can be equipped with one out of various sensor and abstract
> > > > the user from this. Camera is connected via MIPI CSI-2.
> > > > 
> > > > Most of the camera module features are supported, with the main exception
> > > > being fw update.
> > > > 
> > > > The driver provides all mandatory, optional and recommended V4L2 controls
> > > > for maximum compatibility with libcamera
> > > > 
> > > > References:
> > > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > > 
> > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > ---
> > > > Changes since v2:
> > > >  - Removed gpios/clock handling as suggested by LPinchart
> > > >  - Added vcc-ext-in supply support as suggested by LPinchart
> > > >  - Fixed alvium_setup_mipi_fmt funct as suggested by CJAILLET
> > > >  - Removed upside_down/hshake_bit priv data as suggested by CJAILLET
> > > >  - Fixed commit body as suggested by LPinchart
> > > >  - Mv alvium_set_streamon_delay to yalvium_set_lp2hs_delay
> > > >  - Fixed comment on lp2hs prop as suggested by LPinchart
> > > >  - Added pm resume/suspend functs as suggested by LPinchart
> > > >  - Dropped alvium_link_setup/alvium_s_power as suggested by LPinchart
> > > >  - Fixed regs defines as suggested by LPinchart
> > > >  - Fixed typedef as suggested by LPinchart
> > > >  - Dropped bcrm_v/fw_v from priv data as suggested by LPinchart
> > > >  - Now driver use the subdev active state to store the active format and crop
> > > >    as suggested by LPinchart
> > > >  - Dropped alvium_is_csi2/i2c_to_alvium as suggested by LPinchart
> > > > 
> > > > Changes since v3:
> > > >  - Fixed warnings Reported-by: kernel test robot <lkp@intel.com>
> > > > 
> > > > Changes since v4:
> > > >  - Removed print into alvium_get_dt_data for alliedvision,lp2hs-delay-us as
> > > >    suggested by CDooley
> > > > 
> > > >  drivers/media/i2c/Kconfig       |   10 +
> > > >  drivers/media/i2c/Makefile      |    1 +
> > > >  drivers/media/i2c/alvium-csi2.c | 3479 +++++++++++++++++++++++++++++++
> > > >  drivers/media/i2c/alvium-csi2.h |  485 +++++
> > > >  4 files changed, 3975 insertions(+)
> > > >  create mode 100644 drivers/media/i2c/alvium-csi2.c
> > > >  create mode 100644 drivers/media/i2c/alvium-csi2.h
> > > > 
> > > > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > > > index 256d55bb2b1d..a9fdf10ffc15 100644
> > > > --- a/drivers/media/i2c/Kconfig
> > > > +++ b/drivers/media/i2c/Kconfig
> > > > @@ -34,6 +34,16 @@ config VIDEO_APTINA_PLL
> > > >  config VIDEO_CCS_PLL
> > > >  	tristate
> > > >  
> > > > +config VIDEO_ALVIUM_CSI2
> > > > +	tristate "Allied Vision ALVIUM MIPI CSI-2 camera support"
> > > > +	depends on I2C
> > > > +	select MEDIA_CONTROLLER
> > > > +	select VIDEO_V4L2_SUBDEV_API
> > > > +	select V4L2_FWNODE
> > > > +	help
> > > > +	  This is a Video4Linux2 sensor driver for the Allied Vision
> > > > +	  ALVIUM camera connected via MIPI CSI-2 interface.
> > > > +
> > > >  config VIDEO_AR0521
> > > >  	tristate "ON Semiconductor AR0521 sensor support"
> > > >  	depends on I2C && VIDEO_DEV
> > > > diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> > > > index b44dacf935f4..be4dddd6fd98 100644
> > > > --- a/drivers/media/i2c/Makefile
> > > > +++ b/drivers/media/i2c/Makefile
> > > > @@ -17,6 +17,7 @@ obj-$(CONFIG_VIDEO_ADV7604) += adv7604.o
> > > >  obj-$(CONFIG_VIDEO_ADV7842) += adv7842.o
> > > >  obj-$(CONFIG_VIDEO_AK7375) += ak7375.o
> > > >  obj-$(CONFIG_VIDEO_AK881X) += ak881x.o
> > > > +obj-$(CONFIG_VIDEO_ALVIUM_CSI2) += alvium-csi2.o
> > > >  obj-$(CONFIG_VIDEO_APTINA_PLL) += aptina-pll.o
> > > >  obj-$(CONFIG_VIDEO_AR0521) += ar0521.o
> > > >  obj-$(CONFIG_VIDEO_BT819) += bt819.o
> > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > new file mode 100644
> > > > index 000000000000..52c9263075cf
> > > > --- /dev/null
> > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > @@ -0,0 +1,3479 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * Allied Vision Inc. Alvium camera driver
> > > > + *
> > > > + * Copyright (C) 2023 Tommaso Merciai
> > > > + * Copyright (C) 2023 Martin Hecht
> > > > + * Copyright (C) 2023 Avnet EMG GmbH
> > > > + */
> > > > +
> > > > +#include <asm/unaligned.h>
> > > > +#include <linux/clk.h>
> > > > +#include <linux/clk-provider.h>
> > > > +#include <linux/clkdev.h>
> > > > +#include <linux/ctype.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/init.h>
> > > 
> > > Do you need this?
> > 
> > No, Thanks :)
> > > 
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_device.h>
> > > > +#include <linux/of_graph.h>
> > > > +#include <linux/pm_runtime.h>
> > > > +#include <linux/regulator/consumer.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/types.h>
> > > > +#include <media/v4l2-async.h>
> > > > +#include <media/v4l2-ctrls.h>
> > > > +#include <media/mipi-csi2.h>
> > > 
> > > Please order alphabetically.
> > 
> > Oooks, ty
> > 
> > > 
> > > > +#include <media/v4l2-device.h>
> > > > +#include <media/v4l2-event.h>
> > > > +#include <media/v4l2-fwnode.h>
> > > > +#include <media/v4l2-subdev.h>
> > > > +
> > > > +#include "alvium-csi2.h"
> > > > +
> > > > +static const struct v4l2_mbus_framefmt alvium_csi2_default_fmt = {
> > > > +	.code = MEDIA_BUS_FMT_UYVY8_1X16,
> > > > +	.width = 640,
> > > > +	.height = 480,
> > > > +	.colorspace = V4L2_COLORSPACE_SRGB,
> > > > +	.ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SRGB),
> > > > +	.quantization = V4L2_QUANTIZATION_FULL_RANGE,
> > > > +	.xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SRGB),
> > > > +	.field = V4L2_FIELD_NONE,
> > > > +};
> > > > +
> > > > +static const struct alvium_pixfmt alvium_csi2_fmts[] = {
> > > > +	{
> > > > +		/* UYVY8_2X8 */
> > > > +		.id = ALVIUM_FMT_UYVY8_2X8,
> > > > +		.code = MEDIA_BUS_FMT_UYVY8_2X8,
> > > > +		.colorspace = V4L2_COLORSPACE_SRGB,
> > > > +		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
> > > > +		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
> > > > +		.mipi_fmt_regval = 0x1E,
> > > 
> > > Could you use MIPI_CSI2_DT_ definitions in mipi-csi2.h?
> > 
> > ofc ty
> 
> I'm not sure I understand all your comments.

Sorry.. :)

> 
> ...
> 
> > > > +{
> > > > +	struct i2c_client *client = alvium->i2c_client;
> > > > +	u16 addr = REG_BCRM_ADDR(reg);
> > > > +	unsigned int len = REG_BCRM_SIZE(reg);
> > > > +	struct i2c_msg msgs[2] = {0};
> > > > +	u8 addr_buf[2] = {0};
> > > > +	u8 data_buf[8] = {0};
> > > > +	int ret;
> > > > +
> > > > +	if (WARN_ON(len > 8))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (reg & REG_BCRM_V4L2)
> > > > +		addr += alvium->bcrm_addr;
> > > > +
> > > > +	put_unaligned_be16(addr, addr_buf);
> > > > +
> > > > +	msgs[0].addr = client->addr;
> > > > +	msgs[0].flags = 0;
> > > > +	msgs[0].len = ARRAY_SIZE(addr_buf);
> > > > +	msgs[0].buf = addr_buf;
> > > > +
> > > > +	msgs[1].addr = client->addr;
> > > > +	msgs[1].flags = I2C_M_RD;
> > > > +	msgs[1].len = len;
> > > > +	msgs[1].buf = &data_buf[8 - len];
> > > > +
> > > > +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> > > > +	if (ret != ARRAY_SIZE(msgs))
> > > > +		return -EIO;
> > > > +
> > > > +	*val = get_unaligned_be64(data_buf);
> > > 
> > > Could you use CCI wrapper Hans has been working on? It'll be merged fairly
> > > soon I presume:
> > > <URL:https://lore.kernel.org/linux-media/20230606165808.70751-1-hdegoede@redhat.com/T/#t>.
> > 
> > Thanks for sharing.
> > 
> > Actually I'm working/testing the driver on
> > 6.4.0-rc2 I don't see this new functionality, sry.
> 
> They're not there yet. I presume we'll be merging them soonish though.

Please Check v6.
In this version I'm using new cci API from Hans.

> 
> > 
> > I can try.
> > But this is only for CCI regs read/write right?
> > 
> > Or also for v4l2 regs?
> > Let me know, thanks! :)
> > 
> > > 
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_write(struct alvium_dev *alvium,
> > > > +				  u32 reg, u64 val)
> > > > +{
> > > > +	struct i2c_client *client = alvium->i2c_client;
> > > > +	u16 addr = REG_BCRM_ADDR(reg);
> > > > +	unsigned int len = REG_BCRM_SIZE(reg);
> > > > +	u8 buf[10] = {0};
> > > > +
> > > > +	if (WARN_ON(len > 8))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (reg & REG_BCRM_V4L2)
> > > > +		addr += alvium->bcrm_addr;
> > > > +
> > > > +	put_unaligned_be16(addr, buf);
> > > > +	put_unaligned_be64(val << (8 * (8 - len)), buf + 2);
> > > > +	if (i2c_master_send(client, buf, len + 2) != len + 2)
> > > > +		return -EIO;
> > > 
> > > Same here.
> > 
> > ^Same question.
> > 
> > > 
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_write_hshake(struct alvium_dev *alvium,
> > > > +				  u32 reg, u64 val)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	u64 hshake_regval;
> > > > +	u8 hshake_bit;
> > > > +	int ret;
> > > > +
> > > > +	if (!alvium->bcrm_addr)
> > > > +		return -EINVAL;
> > > > +
> > > > +	/* reset handshake bit */
> > > > +	ret = alvium_write(alvium,
> > > > +			  REG_BCRM_WRITE_HANDSHAKE_RW,
> > > > +			  BCRM_HANDSHAKE_W_RST);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to reset hshake reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	/* write alvium reg*/
> > > > +	ret = alvium_write(alvium, reg, val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to write reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	/* poll handshake bit since bit0 = 1*/
> > > > +	do {
> > > > +		ret = alvium_read(alvium,
> > > > +				  REG_BCRM_WRITE_HANDSHAKE_RW,
> > > > +				  &hshake_regval);
> > > > +		if (ret) {
> > > > +			dev_err(dev, "Fail to read hshake reg\n");
> > > > +			return ret;
> > > > +		}
> > > > +
> > > > +		hshake_bit = (hshake_regval & BCRM_HANDSHAKE_W_DONE_EN_BIT);
> > > > +
> > > > +	} while (!hshake_bit);
> > > > +
> > > > +	/* reset handshake bit, write 0 to bit0 */
> > > > +	ret = alvium_write(alvium,
> > > > +			  REG_BCRM_WRITE_HANDSHAKE_RW,
> > > > +			  BCRM_HANDSHAKE_W_RST);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to reset hshake reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	/* poll handshake bit since bit0 = 0 */
> > > > +	do {
> > > > +		ret = alvium_read(alvium,
> > > > +				  REG_BCRM_WRITE_HANDSHAKE_RW,
> > > > +				  &hshake_regval);
> > > > +		if (ret) {
> > > > +			dev_err(dev, "Fail to read hshake reg\n");
> > > > +			return ret;
> > > > +		}
> > > > +
> > > > +		hshake_bit = (hshake_regval & BCRM_HANDSHAKE_W_DONE_EN_BIT);
> > > > +
> > > > +	} while (hshake_bit);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_get_bcrm_vers(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	int ret;
> > > > +	u64 val;
> > > > +	struct alvium_bcrm_vers *v;
> > > > +
> > > > +	ret = alvium_read(alvium,
> > > > +			  REG_BCRM_VERSION_R,
> > > > +			  &val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to read bcrm version reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	v = (struct alvium_bcrm_vers *) &val;
> > > > +
> > > > +	v->minor = cpu_to_le16(v->minor);
> > > > +	v->major = cpu_to_le16(v->major);
> > > > +
> > > > +	dev_info(dev, "bcrm version: %u.%u\n", v->minor,
> > > > +			  v->major);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_get_fw_version(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	int ret;
> > > > +	u64 val;
> > > > +	struct alvium_fw_vers *fw_v;
> > > 
> > > Please order temporary, loop etc. variables as last. Same for the other
> > > functions. Reverse Christmas tree order is often the same.
> > 
> > Can you explain me better pls?
> > Your plan is the following order:
> > 
> > struct device *dev = &alvium->i2c_client->dev;
> > struct alvium_fw_vers *fw_v;
> > u64 val;
> > int ret;
> 
> This is what I intended, yes.

Fixed in v6.

> 
> > 
> > or I'm wrong? Thanks.
> > 
> > > 
> > > > +
> > > > +	ret = alvium_read(alvium,
> > > > +			  REG_BCRM_DEVICE_FIRMWARE_VERSION_R,
> > > > +			  &val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to read fw version reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	fw_v = (struct alvium_fw_vers *) &val;
> > > > +
> > > > +	fw_v->minor = cpu_to_le16(fw_v->minor);
> > > > +	fw_v->patch = cpu_to_le32(fw_v->patch);
> > > > +
> > > > +	dev_info(dev, "fw version: %u.%u.%u.%u\n",
> > > > +			  fw_v->special,
> > > 
> > > Please align arguments to just right of the opening parenthesis. Also, more
> > > fits on the same line (up to 80 chars). This applies to the entire patch.
> > 
> > 
> > dev_info(dev, "fw version: %u.%u.%u.%u\n", fw_v->special, fw_v->major,
> > 	 fw_v->minor, fw_v->patch);
> > 
> > Like this?
> 
> Yes.

Oooks

> 
> > 
> > > 
> > > > +			  fw_v->major,
> > > > +			  fw_v->minor,
> > > > +			  fw_v->patch);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_get_bcrm_addr(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	int ret;
> > > > +	u64 val;
> > > > +
> > > > +	ret = alvium_read(alvium,
> > > > +			  REG_BCRM_REG_ADDR_R,
> > > > +			  &val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to read bcrm addr reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	alvium->bcrm_addr = (u16)val;
> > > > +	dev_dbg(dev, "bcrm addr: %d\n", alvium->bcrm_addr);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static bool alvium_is_alive(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	int ret;
> > > > +	u64 val = 0;
> > > > +	u8 hbeat_val = 0;
> > > > +
> > > > +	ret = alvium_read(alvium,
> > > > +			  REG_BCRM_VERSION_R,
> > > > +			  &val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to read bcrm version reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret = alvium_read(alvium,
> > > > +			  REG_BCRM_HEARTBEAT_R,
> > > > +			  &val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to read heartbeat reg\n");
> > > > +		return false;
> > > > +	}
> > > > +
> > > > +	hbeat_val = (u8)val;
> > > > +	dev_dbg(dev, "hearthbeat = %d", hbeat_val);
> > > > +
> > > > +	if (hbeat_val)
> > > > +		return true;
> > > > +	else
> > > > +		return false;
> > > 
> > > return hbeat_val;
> > 
> > Oks.
> > 
> > > 
> > > > +}
> > > > +
> > > > +static void alvium_print_avail_mipi_fmt(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +
> > > > +	dev_dbg(dev, "avail mipi_fmt yuv420_8_leg: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_LEG]);
> > > > +	dev_dbg(dev, "avail mipi_fmt yuv420_8: %u\n",
> > > > +		   alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8]);
> > > > +	dev_dbg(dev, "avail mipi_fmt yuv420_10: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10]);
> > > > +	dev_dbg(dev, "avail mipi_fmt yuv420_8_csps: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_CSPS]);
> > > > +	dev_dbg(dev, "avail mipi_fmt yuv420_10_csps: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10_CSPS]);
> > > > +	dev_dbg(dev, "avail mipi_fmt yuv422_8: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_8]);
> > > > +	dev_dbg(dev, "avail mipi_fmt yuv422_10: %u\n",
> > > > +		   alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_10]);
> > > > +	dev_dbg(dev, "avail mipi_fmt rgb888: %u\n",
> > > > +		   alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB888]);
> > > > +	dev_dbg(dev, "avail mipi_fmt rgb666: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB666]);
> > > > +	dev_dbg(dev, "avail mipi_fmt rgb565: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB565]);
> > > > +	dev_dbg(dev, "avail mipi_fmt rgb555: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB555]);
> > > > +	dev_dbg(dev, "avail mipi_fmt rgb444: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB444]);
> > > > +	dev_dbg(dev, "avail mipi_fmt raw6: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW6]);
> > > > +	dev_dbg(dev, "avail mipi_fmt raw7: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW7]);
> > > > +	dev_dbg(dev, "avail mipi_fmt raw8: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW8]);
> > > > +	dev_dbg(dev, "avail mipi_fmt raw10: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW10]);
> > > > +	dev_dbg(dev, "avail mipi_fmt raw12: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW12]);
> > > > +	dev_dbg(dev, "avail mipi_fmt raw14: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW14]);
> > > > +	dev_dbg(dev, "avail mipi_fmt jpeg: %u\n",
> > > > +		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_JPEG]);
> > > > +}
> > > > +
> > > > +static void alvium_print_avail_feat(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +
> > > > +	dev_dbg(dev, "feature rev_x: %u\n",
> > > > +		  alvium->avail_ft.rev_x);
> > > > +	dev_dbg(dev, "feature rev_y: %u\n",
> > > > +		  alvium->avail_ft.rev_y);
> > > > +	dev_dbg(dev, "feature int_autop: %u\n",
> > > > +		  alvium->avail_ft.int_autop);
> > > > +	dev_dbg(dev, "feature black_lvl: %u\n",
> > > > +		  alvium->avail_ft.black_lvl);
> > > > +	dev_dbg(dev, "feature gain: %u\n",
> > > > +		  alvium->avail_ft.gain);
> > > > +	dev_dbg(dev, "feature gamma: %u\n",
> > > > +		  alvium->avail_ft.gamma);
> > > > +	dev_dbg(dev, "feature contrast: %u\n",
> > > > +		  alvium->avail_ft.contrast);
> > > > +	dev_dbg(dev, "feature sat: %u\n",
> > > > +		  alvium->avail_ft.sat);
> > > > +	dev_dbg(dev, "feature hue: %u\n",
> > > > +		  alvium->avail_ft.hue);
> > > > +	dev_dbg(dev, "feature whiteb: %u\n",
> > > > +		  alvium->avail_ft.whiteb);
> > > > +	dev_dbg(dev, "feature sharp: %u\n",
> > > > +		  alvium->avail_ft.sharp);
> > > > +	dev_dbg(dev, "feature auto_exp: %u\n",
> > > > +		  alvium->avail_ft.auto_exp);
> > > > +	dev_dbg(dev, "feature auto_gain: %u\n",
> > > > +		  alvium->avail_ft.auto_gain);
> > > > +	dev_dbg(dev, "feature auto_whiteb: %u\n",
> > > > +		  alvium->avail_ft.auto_whiteb);
> > > > +	dev_dbg(dev, "feature dev_temp: %u\n",
> > > > +		  alvium->avail_ft.dev_temp);
> > > > +	dev_dbg(dev, "feature acq_abort: %u\n",
> > > > +		  alvium->avail_ft.acq_abort);
> > > > +	dev_dbg(dev, "feature acq_fr: %u\n",
> > > > +		  alvium->avail_ft.acq_fr);
> > > > +	dev_dbg(dev, "feature fr_trigger: %u\n",
> > > > +		  alvium->avail_ft.fr_trigger);
> > > > +	dev_dbg(dev, "feature exp_acq_line: %u\n",
> > > > +		  alvium->avail_ft.exp_acq_line);
> > > > +}
> > > > +
> > > > +static void alvium_print_avail_bayer(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +
> > > > +	dev_dbg(dev, "avail bayer mono: %u\n",
> > > > +		  alvium->is_bay_avail[ALVIUM_BIT_BAY_MONO]);
> > > > +	dev_dbg(dev, "avail bayer gr: %u\n",
> > > > +		  alvium->is_bay_avail[ALVIUM_BIT_BAY_GR]);
> > > > +	dev_dbg(dev, "avail bayer rg: %u\n",
> > > > +		  alvium->is_bay_avail[ALVIUM_BIT_BAY_RG]);
> > > > +	dev_dbg(dev, "avail bayer gb: %u\n",
> > > > +		  alvium->is_bay_avail[ALVIUM_BIT_BAY_GB]);
> > > > +	dev_dbg(dev, "avail bayer bg: %u\n",
> > > > +		  alvium->is_bay_avail[ALVIUM_BIT_BAY_BG]);
> > > > +}
> > > > +
> > > > +static int alvium_get_feat_inq(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	struct alvium_avail_feat *f;
> > > > +	int ret;
> > > > +	u64 val;
> > > > +
> > > > +	if (!alvium->bcrm_addr)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = alvium_read(alvium,
> > > > +			  REG_BCRM_FEATURE_INQUIRY_R,
> > > > +			  &val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to features inquiry reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	f = (struct alvium_avail_feat *) &val;
> > > > +
> > > > +	alvium->avail_ft.rev_x = f->rev_x;
> > > > +	alvium->avail_ft.rev_y = f->rev_y;
> > > > +	alvium->avail_ft.int_autop = f->int_autop;
> > > > +	alvium->avail_ft.black_lvl = f->black_lvl;
> > > > +	alvium->avail_ft.gain = f->gain;
> > > > +	alvium->avail_ft.gamma = f->gamma;
> > > > +	alvium->avail_ft.contrast = f->contrast;
> > > > +	alvium->avail_ft.sat = f->sat;
> > > > +	alvium->avail_ft.hue = f->rev_y;
> > > > +	alvium->avail_ft.whiteb = f->whiteb;
> > > > +	alvium->avail_ft.sharp = f->sharp;
> > > > +	alvium->avail_ft.auto_exp = f->auto_exp;
> > > > +	alvium->avail_ft.auto_gain = f->auto_gain;
> > > > +	alvium->avail_ft.auto_whiteb = f->auto_whiteb;
> > > > +	alvium->avail_ft.dev_temp = f->dev_temp;
> > > > +	alvium->avail_ft.acq_abort = f->acq_abort;
> > > > +	alvium->avail_ft.acq_fr = f->acq_fr;
> > > > +	alvium->avail_ft.fr_trigger = f->fr_trigger;
> > > > +	alvium->avail_ft.exp_acq_line = f->exp_acq_line;
> > > 
> > > You could instead do:
> > > 
> > > 	alvium->avail_ft = *f;
> > > 
> > > But is there an endianness issue here? I think you should use u64 also for
> > > the struct fields.
> > 
> > Mmmm.. I'm not sure are all u8 this is not safe (on endianess pesrpective)?
> > Or I'm completely wrong?
> 
> The u8 fields in the struct are fine but the u64 value is not. Instead you
> should read a u8 array.

This is fixed with new CCI Api right??
If yes, this is fixed in v6.

> 
> > 
> > > 
> > > > +
> > > > +	alvium_print_avail_feat(alvium);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_get_host_supp_csi_lanes(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	int ret;
> > > > +	u64 val;
> > > > +
> > > > +	if (!alvium->bcrm_addr)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = alvium_read(alvium,
> > > > +			  REG_BCRM_CSI2_LANE_COUNT_RW,
> > > > +			  &val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	alvium->h_sup_csi_lanes = (u8)val;
> > > > +	dev_dbg(dev, "host supported csi2 lanes count: %d\n",
> > > > +			  alvium->h_sup_csi_lanes);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_set_csi_lanes(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	int ret;
> > > > +	u64 num_lanes;
> > > > +
> > > > +	if (!alvium->bcrm_addr)
> > > > +		return -EINVAL;
> > > > +
> > > > +	num_lanes = alvium->ep.bus.mipi_csi2.num_data_lanes;
> > > > +
> > > > +	if (num_lanes <= alvium->h_sup_csi_lanes) {
> > > > +		ret = alvium_write_hshake(alvium,
> > > > +				  REG_BCRM_CSI2_LANE_COUNT_RW,
> > > > +				  num_lanes);
> > > > +		if (ret) {
> > > > +			dev_err(dev, "Fail to set csi lanes reg\n");
> > > > +			return ret;
> > > > +		}
> > > > +	} else {
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	dev_dbg(dev, "Set n lanes = %llu", num_lanes);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_set_lp2hs_delay(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	int ret;
> > > > +	u64 lp2hs_delay;
> > > > +
> > > > +	if (!alvium->bcrm_addr)
> > > > +		return -EINVAL;
> > > > +
> > > > +	/*
> > > > +	 * The purpose of this reg is force a DPhy reset
> > > > +	 * for the period described by the microseconds on
> > > > +	 * the reg, before it starts streaming.
> > > > +	 *
> > > > +	 * To be clear, with that value bigger than 0 the
> > > > +	 * Alvium forces a dphy-reset on all lanes for that period.
> > > > +	 * That means all lanes go up into low power state.
> > > > +	 *
> > > > +	 * This may help a csi2 rx ip to reset if that IP
> > > > +	 * can't deal with a continous clock.
> > > > +	 */
> > > > +	lp2hs_delay = (u64)alvium->lp2hs_delay;
> > > > +
> > > > +	ret = alvium_write_hshake(alvium,
> > > > +			  REG_BCRM_STREAM_ON_DELAY_RW,
> > > > +			  lp2hs_delay);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to set streamon delay reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_get_csi_clk_params(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	int ret;
> > > > +	u64 val;
> > > > +
> > > > +	if (!alvium->bcrm_addr)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = alvium_read(alvium,
> > > > +			  REG_BCRM_CSI2_CLOCK_MIN_R,
> > > > +			  &val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	alvium->min_csi_clk = (u32)val;
> > > > +	dev_dbg(dev, "Min host supported csi clock: %d\n",
> > > > +			  alvium->min_csi_clk);
> > > > +
> > > > +	ret = alvium_read(alvium,
> > > > +			  REG_BCRM_CSI2_CLOCK_MAX_R,
> > > > +			  &val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	alvium->max_csi_clk = (u32)val;
> > > > +	dev_dbg(dev, "Max host supported csi clock: %d\n",
> > > > +			  alvium->max_csi_clk);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_set_csi_clk(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	int ret;
> > > > +	u64 csi_clk;
> > > > +
> > > > +	if (!alvium->bcrm_addr)
> > > > +		return -EINVAL;
> > > > +
> > > > +	csi_clk = (u32)alvium->ep.link_frequencies[0];
> > > > +
> > > > +	if (csi_clk > alvium->min_csi_clk ||
> > > > +		csi_clk < alvium->max_csi_clk) {
> > > > +		ret = alvium_write_hshake(alvium,
> > > > +				  REG_BCRM_CSI2_CLOCK_RW,
> > > > +				  csi_clk);
> > > > +		if (ret) {
> > > > +			dev_err(dev, "Fail to set csi lanes reg\n");
> > > > +			return ret;
> > > > +		}
> > > > +	} else {
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	alvium->link_freq = alvium->ep.link_frequencies[0];
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_get_img_width_params(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	int ret;
> > > > +	u64 val;
> > > > +
> > > > +	if (!alvium->bcrm_addr)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = alvium_read(alvium,
> > > > +			  REG_BCRM_IMG_WIDTH_MIN_R,
> > > > +			  &val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to read img min width reg\n");
> > > > +		return ret;
> > > > +	}
> > > 
> > > Could you add a macro that assigns the value to the variable (or a struct
> > > field in this case) when the read is successful? Add the print if you think
> > > you need it.
> > 
> > I don't get this comment.
> > Can you explain me better your plan please.
> 
> You have exactly the same pattern repeated over and over in a number of
> functions. I'd like you to add a macro (or a function) that takes what
> varies as arguments, and call that function here. It would reduce a lot of
> the repeated lines code here.


Mmmm... I'll give a try on this in v7

> 
> ...
> 
> > > > +static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
> > > > +{
> > > > +	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
> > > > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > +	int ret;
> > > > +
> > > > +	switch (ctrl->id) {
> > > > +	case V4L2_CID_AUTOGAIN:
> > > > +		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
> > > > +		break;
> > > > +	case V4L2_CID_EXPOSURE_AUTO:
> > > > +		ret = alvium_set_ctrl_exposure(alvium, ctrl->val);
> > > > +		break;
> > > > +	case V4L2_CID_AUTO_WHITE_BALANCE:
> > > > +		ret = alvium_set_ctrl_white_balance(alvium, ctrl->val);
> > > > +		break;
> > > > +	case V4L2_CID_HUE:
> > > > +		ret = alvium_set_ctrl_hue(alvium, ctrl->val);
> > > > +		break;
> > > > +	case V4L2_CID_CONTRAST:
> > > > +		ret = alvium_set_ctrl_contrast(alvium, ctrl->val);
> > > > +		break;
> > > > +	case V4L2_CID_SATURATION:
> > > > +		ret = alvium_set_ctrl_saturation(alvium, ctrl->val);
> > > > +		break;
> > > > +	case V4L2_CID_GAMMA:
> > > > +		ret = alvium_set_ctrl_gamma(alvium, ctrl->val);
> > > > +		break;
> > > > +	case V4L2_CID_SHARPNESS:
> > > > +		ret = alvium_set_ctrl_sharpness(alvium, ctrl->val);
> > > > +		break;
> > > > +	case V4L2_CID_HFLIP:
> > > > +		ret = alvium_set_ctrl_hflip(alvium, ctrl->val);
> > > > +		break;
> > > > +	case V4L2_CID_VFLIP:
> > > > +		ret = alvium_set_ctrl_vflip(alvium, ctrl->val);
> > > > +		break;
> > > 
> > > No hsync or vsync controls?
> > 
> > This is not a sensor Alvium ISP/Vision core
> > is responsible for timings checking of the sensor mounted.
> 
> And those values are unknown then?
> 
> Generally raw cameras are controlled configuring the blanking. Of course if
> these aren't available, we can't expose them to user space either.

Right, these are not available.

> 
> ...
> 
> > > > +	ret = fwnode_property_read_u32(dev_fwnode(dev),
> > > > +			  "alliedvision,lp2hs-delay-us",
> > > > +			  &alvium->lp2hs_delay);
> > > > +
> > > > +	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
> > > > +	if (!endpoint) {
> > > > +		dev_err(dev, "endpoint node not found\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > 
> > > As you have D-PHY, please assign bus type to D-PHY before parsing the
> > > endpoint.
> > 
> > I don't completely got this.
> > You mean, check:
> > 
> > if (alvium->ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
> > 		dev_err(dev, "unsupported bus type\n");
> > 		return -EINVAL;
> > 	}
> > 
> > before parsing or I'm wrong?
> 
> Please read v4l2_fwnode_endpoint_alloc_parse() documentation in
> include/media/v4l2-fwnode.h .

I Think this is fixed in v6. Pls check.

> 
> ...
> 
> > > > +struct alvium_avail_mipi_fmt {
> > > > +	u8 yuv420_8_leg:1;
> > > > +	u8 yuv420_8:1;
> > > > +	u8 yuv420_10:1;
> > > > +	u8 yuv420_8_csps:1;
> > > > +	u8 yuv420_10_csps:1;
> > > > +	u8 yuv422_8:1;
> > > > +	u8 yuv422_10:1;
> > > > +	u8 rgb888:1;
> > > > +	u8 rgb666:1;
> > > > +	u8 rgb565:1;
> > > > +	u8 rgb555:1;
> > > > +	u8 rgb444:1;
> > > > +	u8 raw6:1;
> > > > +	u8 raw7:1;
> > > > +	u8 raw8:1;
> > > > +	u8 raw10:1;
> > > > +	u8 raw12:1;
> > > > +	u8 raw14:1;
> > > > +	u8 jpeg:1;
> > > 
> > > I don't think C defines a particular location for the bit fields if their
> > > size is less than that of the type. Could you add padding to ensure that?
> > > Same for other structs.
> > 
> > I take "struct s5k5baf" of drivers/media/i2c/s5k5baf.c
> > as reference. I'm missing something? Can you explain me better?
> 
> How is this related to the comment, other than that it uses bit fields?

Yes.

> 
> > 
> > Thanks!
> > 
> > 
> > 
> > > 
> > > > +};
> > > > +
> > > > +struct alvium_avail_bayer {
> > > > +	u8 mono:1;
> > > > +	u8 gr:1;
> > > > +	u8 rg:1;
> > > > +	u8 gb:1;
> > > > +	u8 bg:1;
> > > > +};
> > > > +
> > > > +struct alvium_mode {
> > > > +	struct v4l2_rect crop;
> > > > +	struct v4l2_mbus_framefmt fmt;
> > > > +	u32 width;
> > > > +	u32 height;
> > > > +};
> > > > +
> > > > +struct alvium_pixfmt {
> > > > +	u8 id;
> > > > +	u32 code;
> > > > +	u32 colorspace;
> > > > +	u8 fmt_av_bit;
> > > > +	u8 bay_av_bit;
> > > > +	u64 mipi_fmt_regval;
> > > > +	u64 bay_fmt_regval;
> > > > +	u8 is_raw;
> > > 
> > > This would require less memory if you moved all 8-bit fields to the end of
> > > the struct.
> > 
> > Also Laurent and Cristophe point me about this, thanks.
> > 
> > If is possible I prefer to keep this order this is more
> > clear for me.
> > 
> > But If not fit your plan never mind I pick your order.
> > Thanks to all! :)
> 
> If you've received the same comment from three reviewers, then please do
> it. :-)

Pls check v6.

Resume:
I'm going to send v7 with some hints from Laurent,
and some suggestion from you and Hans. Also I have to fix .h
indentation.

Please meanwhile take your time to check v6.
Thanks again for your review! :)

Regards,
Tommaso
> 
> -- 
> Kind regards,
> 
> Sakari Ailus
