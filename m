Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1CD609FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJXLFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJXLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:04:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A325C5C;
        Mon, 24 Oct 2022 04:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C94EB80DB5;
        Mon, 24 Oct 2022 11:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED462C433D6;
        Mon, 24 Oct 2022 11:03:51 +0000 (UTC)
Message-ID: <208aa144-8156-5015-7757-acd224d173b1@xs4all.nl>
Date:   Mon, 24 Oct 2022 13:03:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 14/14] media: davinci: remove vpbe support
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-15-arnd@kernel.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20221019152947.3857217-15-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 10/19/22 17:29, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The davinci dm3xx/dm644x platforms are gone now, and the remaining
> da8xx platforms do not use the vpbe driver, so the driver can be
> removed as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

As discussed on irc, it is best if you merge this to due dependencies on
arch/arm/mach-davinci/davinci.h.

Regards,

	Hans

> ---
>  .../admin-guide/media/davinci-vpbe.rst        |   65 -
>  .../admin-guide/media/platform-cardlist.rst   |    1 -
>  .../admin-guide/media/v4l-drivers.rst         |    1 -
>  .../media/drivers/davinci-vpbe-devel.rst      |   39 -
>  .../driver-api/media/drivers/index.rst        |    1 -
>  drivers/media/platform/ti/davinci/Kconfig     |   16 -
>  drivers/media/platform/ti/davinci/Makefile    |    3 -
>  drivers/media/platform/ti/davinci/vpbe.c      |  840 ---------
>  .../media/platform/ti/davinci/vpbe_display.c  | 1510 ----------------
>  drivers/media/platform/ti/davinci/vpbe_osd.c  | 1582 -----------------
>  .../media/platform/ti/davinci/vpbe_osd_regs.h |  352 ----
>  drivers/media/platform/ti/davinci/vpbe_venc.c |  676 -------
>  .../platform/ti/davinci/vpbe_venc_regs.h      |  165 --
>  drivers/media/platform/ti/davinci/vpss.c      |  529 ------
>  include/media/davinci/vpbe.h                  |  184 --
>  include/media/davinci/vpbe_display.h          |  122 --
>  include/media/davinci/vpbe_osd.h              |  382 ----
>  include/media/davinci/vpbe_types.h            |   74 -
>  include/media/davinci/vpbe_venc.h             |   37 -
>  include/media/davinci/vpss.h                  |  111 --
>  20 files changed, 6690 deletions(-)
>  delete mode 100644 Documentation/admin-guide/media/davinci-vpbe.rst
>  delete mode 100644 Documentation/driver-api/media/drivers/davinci-vpbe-devel.rst
>  delete mode 100644 drivers/media/platform/ti/davinci/vpbe.c
>  delete mode 100644 drivers/media/platform/ti/davinci/vpbe_display.c
>  delete mode 100644 drivers/media/platform/ti/davinci/vpbe_osd.c
>  delete mode 100644 drivers/media/platform/ti/davinci/vpbe_osd_regs.h
>  delete mode 100644 drivers/media/platform/ti/davinci/vpbe_venc.c
>  delete mode 100644 drivers/media/platform/ti/davinci/vpbe_venc_regs.h
>  delete mode 100644 drivers/media/platform/ti/davinci/vpss.c
>  delete mode 100644 include/media/davinci/vpbe.h
>  delete mode 100644 include/media/davinci/vpbe_display.h
>  delete mode 100644 include/media/davinci/vpbe_osd.h
>  delete mode 100644 include/media/davinci/vpbe_types.h
>  delete mode 100644 include/media/davinci/vpbe_venc.h
>  delete mode 100644 include/media/davinci/vpss.h
> 
> diff --git a/Documentation/admin-guide/media/davinci-vpbe.rst b/Documentation/admin-guide/media/davinci-vpbe.rst
> deleted file mode 100644
> index 9e6360fd02db..000000000000
> --- a/Documentation/admin-guide/media/davinci-vpbe.rst
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -The VPBE V4L2 driver design
> -===========================
> -
> -Functional partitioning
> ------------------------
> -
> -Consists of the following:
> -
> - 1. V4L2 display driver
> -
> -    Implements creation of video2 and video3 device nodes and
> -    provides v4l2 device interface to manage VID0 and VID1 layers.
> -
> - 2. Display controller
> -
> -    Loads up VENC, OSD and external encoders such as ths8200. It provides
> -    a set of API calls to V4L2 drivers to set the output/standards
> -    in the VENC or external sub devices. It also provides
> -    a device object to access the services from OSD subdevice
> -    using sub device ops. The connection of external encoders to VENC LCD
> -    controller port is done at init time based on default output and standard
> -    selection or at run time when application change the output through
> -    V4L2 IOCTLs.
> -
> -    When connected to an external encoder, vpbe controller is also responsible
> -    for setting up the interface between VENC and external encoders based on
> -    board specific settings (specified in board-xxx-evm.c). This allows
> -    interfacing external encoders such as ths8200. The setup_if_config()
> -    is implemented for this as well as configure_venc() (part of the next patch)
> -    API to set timings in VENC for a specific display resolution. As of this
> -    patch series, the interconnection and enabling and setting of the external
> -    encoders is not present, and would be a part of the next patch series.
> -
> - 3. VENC subdevice module
> -
> -    Responsible for setting outputs provided through internal DACs and also
> -    setting timings at LCD controller port when external encoders are connected
> -    at the port or LCD panel timings required. When external encoder/LCD panel
> -    is connected, the timings for a specific standard/preset is retrieved from
> -    the board specific table and the values are used to set the timings in
> -    venc using non-standard timing mode.
> -
> -    Support LCD Panel displays using the VENC. For example to support a Logic
> -    PD display, it requires setting up the LCD controller port with a set of
> -    timings for the resolution supported and setting the dot clock. So we could
> -    add the available outputs as a board specific entry (i.e add the "LogicPD"
> -    output name to board-xxx-evm.c). A table of timings for various LCDs
> -    supported can be maintained in the board specific setup file to support
> -    various LCD displays.As of this patch a basic driver is present, and this
> -    support for external encoders and displays forms a part of the next
> -    patch series.
> -
> - 4. OSD module
> -
> -    OSD module implements all OSD layer management and hardware specific
> -    features. The VPBE module interacts with the OSD for enabling and
> -    disabling appropriate features of the OSD.
> -
> -Current status
> ---------------
> -
> -A fully functional working version of the V4L2 driver is available. This
> -driver has been tested with NTSC and PAL standards and buffer streaming.
> diff --git a/Documentation/admin-guide/media/platform-cardlist.rst b/Documentation/admin-guide/media/platform-cardlist.rst
> index ac73c4166d1e..8ef57cd13dec 100644
> --- a/Documentation/admin-guide/media/platform-cardlist.rst
> +++ b/Documentation/admin-guide/media/platform-cardlist.rst
> @@ -73,7 +73,6 @@ via-camera         VIAFB camera controller
>  video-mux          Video Multiplexer
>  vpif_display       TI DaVinci VPIF V4L2-Display
>  vpif_capture       TI DaVinci VPIF video capture
> -vpss               TI DaVinci VPBE V4L2-Display
>  vsp1               Renesas VSP1 Video Processing Engine
>  xilinx-tpg         Xilinx Video Test Pattern Generator
>  xilinx-video       Xilinx Video IP (EXPERIMENTAL)
> diff --git a/Documentation/admin-guide/media/v4l-drivers.rst b/Documentation/admin-guide/media/v4l-drivers.rst
> index 9c7ebe2ca3bd..13f8a39366c9 100644
> --- a/Documentation/admin-guide/media/v4l-drivers.rst
> +++ b/Documentation/admin-guide/media/v4l-drivers.rst
> @@ -13,7 +13,6 @@ Video4Linux (V4L) driver-specific documentation
>  	cafe_ccic
>  	cpia2
>  	cx88
> -	davinci-vpbe
>  	fimc
>  	imx
>  	imx7
> diff --git a/Documentation/driver-api/media/drivers/davinci-vpbe-devel.rst b/Documentation/driver-api/media/drivers/davinci-vpbe-devel.rst
> deleted file mode 100644
> index 4e87bdbc7ae4..000000000000
> --- a/Documentation/driver-api/media/drivers/davinci-vpbe-devel.rst
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -The VPBE V4L2 driver design
> -===========================
> -
> -File partitioning
> ------------------
> -
> - V4L2 display device driver
> -         drivers/media/platform/ti/davinci/vpbe_display.c
> -         drivers/media/platform/ti/davinci/vpbe_display.h
> -
> - VPBE display controller
> -         drivers/media/platform/ti/davinci/vpbe.c
> -         drivers/media/platform/ti/davinci/vpbe.h
> -
> - VPBE venc sub device driver
> -         drivers/media/platform/ti/davinci/vpbe_venc.c
> -         drivers/media/platform/ti/davinci/vpbe_venc.h
> -         drivers/media/platform/ti/davinci/vpbe_venc_regs.h
> -
> - VPBE osd driver
> -         drivers/media/platform/ti/davinci/vpbe_osd.c
> -         drivers/media/platform/ti/davinci/vpbe_osd.h
> -         drivers/media/platform/ti/davinci/vpbe_osd_regs.h
> -
> -To be done
> -----------
> -
> -vpbe display controller
> -    - Add support for external encoders.
> -    - add support for selecting external encoder as default at probe time.
> -
> -vpbe venc sub device
> -    - add timings for supporting ths8200
> -    - add support for LogicPD LCD.
> -
> -FB drivers
> -    - Add support for fbdev drivers.- Ready and part of subsequent patches.
> diff --git a/Documentation/driver-api/media/drivers/index.rst b/Documentation/driver-api/media/drivers/index.rst
> index 32406490557c..3c17d48f83c0 100644
> --- a/Documentation/driver-api/media/drivers/index.rst
> +++ b/Documentation/driver-api/media/drivers/index.rst
> @@ -16,7 +16,6 @@ Video4Linux (V4L) drivers
>  	cpia2_devel
>  	cx2341x-devel
>  	cx88-devel
> -	davinci-vpbe-devel
>  	fimc-devel
>  	pvrusb2
>  	pxa_camera
> diff --git a/drivers/media/platform/ti/davinci/Kconfig b/drivers/media/platform/ti/davinci/Kconfig
> index 96d4bed7fe9e..542a602e66be 100644
> --- a/drivers/media/platform/ti/davinci/Kconfig
> +++ b/drivers/media/platform/ti/davinci/Kconfig
> @@ -31,19 +31,3 @@ config VIDEO_DAVINCI_VPIF_CAPTURE
>  
>  	  To compile this driver as a module, choose M here. There will
>  	  be two modules called vpif.ko and vpif_capture.ko
> -
> -config VIDEO_DAVINCI_VPBE_DISPLAY
> -	tristate "TI DaVinci VPBE V4L2-Display driver"
> -	depends on V4L_PLATFORM_DRIVERS
> -	depends on VIDEO_DEV
> -	depends on ARCH_DAVINCI || COMPILE_TEST
> -	depends on I2C
> -	select VIDEOBUF2_DMA_CONTIG
> -	help
> -	    Enables Davinci VPBE module used for display devices.
> -	    This module is used for display on TI DM644x/DM365/DM355
> -	    based display devices.
> -
> -	    To compile this driver as a module, choose M here. There will
> -	    be five modules created called vpss.ko, vpbe.ko, vpbe_osd.ko,
> -	    vpbe_venc.ko and vpbe_display.ko
> diff --git a/drivers/media/platform/ti/davinci/Makefile b/drivers/media/platform/ti/davinci/Makefile
> index b20a91653162..512f03369bae 100644
> --- a/drivers/media/platform/ti/davinci/Makefile
> +++ b/drivers/media/platform/ti/davinci/Makefile
> @@ -7,6 +7,3 @@
>  obj-$(CONFIG_VIDEO_DAVINCI_VPIF_DISPLAY) += vpif.o vpif_display.o
>  #VPIF Capture driver
>  obj-$(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE) += vpif.o vpif_capture.o
> -
> -obj-$(CONFIG_VIDEO_DAVINCI_VPBE_DISPLAY) += vpss.o vpbe.o vpbe_osd.o \
> -	vpbe_venc.o vpbe_display.o
> diff --git a/drivers/media/platform/ti/davinci/vpbe.c b/drivers/media/platform/ti/davinci/vpbe.c
> deleted file mode 100644
> index 509ecc84624e..000000000000
> --- a/drivers/media/platform/ti/davinci/vpbe.c
> +++ /dev/null
> @@ -1,840 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2010 Texas Instruments Inc
> - */
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/errno.h>
> -#include <linux/fs.h>
> -#include <linux/string.h>
> -#include <linux/wait.h>
> -#include <linux/time.h>
> -#include <linux/platform_device.h>
> -#include <linux/io.h>
> -#include <linux/slab.h>
> -#include <linux/clk.h>
> -#include <linux/err.h>
> -
> -#include <media/v4l2-device.h>
> -#include <media/davinci/vpbe_types.h>
> -#include <media/davinci/vpbe.h>
> -#include <media/davinci/vpss.h>
> -#include <media/davinci/vpbe_venc.h>
> -
> -#define VPBE_DEFAULT_OUTPUT	"Composite"
> -#define VPBE_DEFAULT_MODE	"ntsc"
> -
> -static char *def_output = VPBE_DEFAULT_OUTPUT;
> -static char *def_mode = VPBE_DEFAULT_MODE;
> -static int debug;
> -
> -module_param(def_output, charp, S_IRUGO);
> -module_param(def_mode, charp, S_IRUGO);
> -module_param(debug, int, 0644);
> -
> -MODULE_PARM_DESC(def_output, "vpbe output name (default:Composite)");
> -MODULE_PARM_DESC(def_mode, "vpbe output mode name (default:ntsc");
> -MODULE_PARM_DESC(debug, "Debug level 0-1");
> -
> -MODULE_DESCRIPTION("TI DMXXX VPBE Display controller");
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Texas Instruments");
> -
> -/**
> - * vpbe_current_encoder_info - Get config info for current encoder
> - * @vpbe_dev: vpbe device ptr
> - *
> - * Return ptr to current encoder config info
> - */
> -static struct encoder_config_info*
> -vpbe_current_encoder_info(struct vpbe_device *vpbe_dev)
> -{
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	int index = vpbe_dev->current_sd_index;
> -
> -	return ((index == 0) ? &cfg->venc :
> -				&cfg->ext_encoders[index-1]);
> -}
> -
> -/**
> - * vpbe_find_encoder_sd_index - Given a name find encoder sd index
> - *
> - * @cfg: ptr to vpbe cfg
> - * @index: index used by application
> - *
> - * Return sd index of the encoder
> - */
> -static int vpbe_find_encoder_sd_index(struct vpbe_config *cfg,
> -			     int index)
> -{
> -	char *encoder_name = cfg->outputs[index].subdev_name;
> -	int i;
> -
> -	/* Venc is always first	*/
> -	if (!strcmp(encoder_name, cfg->venc.module_name))
> -		return 0;
> -
> -	for (i = 0; i < cfg->num_ext_encoders; i++) {
> -		if (!strcmp(encoder_name,
> -		     cfg->ext_encoders[i].module_name))
> -			return i+1;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -/**
> - * vpbe_enum_outputs - enumerate outputs
> - * @vpbe_dev: vpbe device ptr
> - * @output: ptr to v4l2_output structure
> - *
> - * Enumerates the outputs available at the vpbe display
> - * returns the status, -EINVAL if end of output list
> - */
> -static int vpbe_enum_outputs(struct vpbe_device *vpbe_dev,
> -			     struct v4l2_output *output)
> -{
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	unsigned int temp_index = output->index;
> -
> -	if (temp_index >= cfg->num_outputs)
> -		return -EINVAL;
> -
> -	*output = cfg->outputs[temp_index].output;
> -	output->index = temp_index;
> -
> -	return 0;
> -}
> -
> -static int vpbe_get_mode_info(struct vpbe_device *vpbe_dev, char *mode,
> -			      int output_index)
> -{
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	struct vpbe_enc_mode_info var;
> -	int curr_output = output_index;
> -	int i;
> -
> -	if (!mode)
> -		return -EINVAL;
> -
> -	for (i = 0; i < cfg->outputs[curr_output].num_modes; i++) {
> -		var = cfg->outputs[curr_output].modes[i];
> -		if (!strcmp(mode, var.name)) {
> -			vpbe_dev->current_timings = var;
> -			return 0;
> -		}
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -static int vpbe_get_current_mode_info(struct vpbe_device *vpbe_dev,
> -				      struct vpbe_enc_mode_info *mode_info)
> -{
> -	if (!mode_info)
> -		return -EINVAL;
> -
> -	*mode_info = vpbe_dev->current_timings;
> -
> -	return 0;
> -}
> -
> -/* Get std by std id */
> -static int vpbe_get_std_info(struct vpbe_device *vpbe_dev,
> -			     v4l2_std_id std_id)
> -{
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	struct vpbe_enc_mode_info var;
> -	int curr_output = vpbe_dev->current_out_index;
> -	int i;
> -
> -	for (i = 0; i < vpbe_dev->cfg->outputs[curr_output].num_modes; i++) {
> -		var = cfg->outputs[curr_output].modes[i];
> -		if ((var.timings_type & VPBE_ENC_STD) &&
> -		  (var.std_id & std_id)) {
> -			vpbe_dev->current_timings = var;
> -			return 0;
> -		}
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -static int vpbe_get_std_info_by_name(struct vpbe_device *vpbe_dev,
> -				char *std_name)
> -{
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	struct vpbe_enc_mode_info var;
> -	int curr_output = vpbe_dev->current_out_index;
> -	int i;
> -
> -	for (i = 0; i < vpbe_dev->cfg->outputs[curr_output].num_modes; i++) {
> -		var = cfg->outputs[curr_output].modes[i];
> -		if (!strcmp(var.name, std_name)) {
> -			vpbe_dev->current_timings = var;
> -			return 0;
> -		}
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -/**
> - * vpbe_set_output - Set output
> - * @vpbe_dev: vpbe device ptr
> - * @index: index of output
> - *
> - * Set vpbe output to the output specified by the index
> - */
> -static int vpbe_set_output(struct vpbe_device *vpbe_dev, int index)
> -{
> -	struct encoder_config_info *curr_enc_info =
> -			vpbe_current_encoder_info(vpbe_dev);
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	struct venc_platform_data *venc_device = vpbe_dev->venc_device;
> -	int enc_out_index;
> -	int sd_index;
> -	int ret;
> -
> -	if (index >= cfg->num_outputs)
> -		return -EINVAL;
> -
> -	mutex_lock(&vpbe_dev->lock);
> -
> -	sd_index = vpbe_dev->current_sd_index;
> -	enc_out_index = cfg->outputs[index].output.index;
> -	/*
> -	 * Currently we switch the encoder based on output selected
> -	 * by the application. If media controller is implemented later
> -	 * there is will be an API added to setup_link between venc
> -	 * and external encoder. So in that case below comparison always
> -	 * match and encoder will not be switched. But if application
> -	 * chose not to use media controller, then this provides current
> -	 * way of switching encoder at the venc output.
> -	 */
> -	if (strcmp(curr_enc_info->module_name,
> -		   cfg->outputs[index].subdev_name)) {
> -		/* Need to switch the encoder at the output */
> -		sd_index = vpbe_find_encoder_sd_index(cfg, index);
> -		if (sd_index < 0) {
> -			ret = -EINVAL;
> -			goto unlock;
> -		}
> -
> -		ret = venc_device->setup_if_config(cfg->outputs[index].if_params);
> -		if (ret)
> -			goto unlock;
> -	}
> -
> -	/* Set output at the encoder */
> -	ret = v4l2_subdev_call(vpbe_dev->encoders[sd_index], video,
> -				       s_routing, 0, enc_out_index, 0);
> -	if (ret)
> -		goto unlock;
> -
> -	/*
> -	 * It is assumed that venc or external encoder will set a default
> -	 * mode in the sub device. For external encoder or LCD pannel output,
> -	 * we also need to set up the lcd port for the required mode. So setup
> -	 * the lcd port for the default mode that is configured in the board
> -	 * arch/arm/mach-davinci/board-dm355-evm.setup file for the external
> -	 * encoder.
> -	 */
> -	ret = vpbe_get_mode_info(vpbe_dev,
> -				 cfg->outputs[index].default_mode, index);
> -	if (!ret) {
> -		struct osd_state *osd_device = vpbe_dev->osd_device;
> -
> -		osd_device->ops.set_left_margin(osd_device,
> -			vpbe_dev->current_timings.left_margin);
> -		osd_device->ops.set_top_margin(osd_device,
> -		vpbe_dev->current_timings.upper_margin);
> -		vpbe_dev->current_sd_index = sd_index;
> -		vpbe_dev->current_out_index = index;
> -	}
> -unlock:
> -	mutex_unlock(&vpbe_dev->lock);
> -	return ret;
> -}
> -
> -static int vpbe_set_default_output(struct vpbe_device *vpbe_dev)
> -{
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	int i;
> -
> -	for (i = 0; i < cfg->num_outputs; i++) {
> -		if (!strcmp(def_output,
> -			    cfg->outputs[i].output.name)) {
> -			int ret = vpbe_set_output(vpbe_dev, i);
> -
> -			if (!ret)
> -				vpbe_dev->current_out_index = i;
> -			return ret;
> -		}
> -	}
> -	return 0;
> -}
> -
> -/**
> - * vpbe_get_output - Get output
> - * @vpbe_dev: vpbe device ptr
> - *
> - * return current vpbe output to the index
> - */
> -static unsigned int vpbe_get_output(struct vpbe_device *vpbe_dev)
> -{
> -	return vpbe_dev->current_out_index;
> -}
> -
> -/*
> - * vpbe_s_dv_timings - Set the given preset timings in the encoder
> - *
> - * Sets the timings if supported by the current encoder. Return the status.
> - * 0 - success & -EINVAL on error
> - */
> -static int vpbe_s_dv_timings(struct vpbe_device *vpbe_dev,
> -		    struct v4l2_dv_timings *dv_timings)
> -{
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	int out_index = vpbe_dev->current_out_index;
> -	struct vpbe_output *output = &cfg->outputs[out_index];
> -	int sd_index = vpbe_dev->current_sd_index;
> -	int ret, i;
> -
> -
> -	if (!(cfg->outputs[out_index].output.capabilities &
> -	    V4L2_OUT_CAP_DV_TIMINGS))
> -		return -ENODATA;
> -
> -	for (i = 0; i < output->num_modes; i++) {
> -		if (output->modes[i].timings_type == VPBE_ENC_DV_TIMINGS &&
> -		    !memcmp(&output->modes[i].dv_timings,
> -				dv_timings, sizeof(*dv_timings)))
> -			break;
> -	}
> -	if (i >= output->num_modes)
> -		return -EINVAL;
> -	vpbe_dev->current_timings = output->modes[i];
> -	mutex_lock(&vpbe_dev->lock);
> -
> -	ret = v4l2_subdev_call(vpbe_dev->encoders[sd_index], video,
> -					s_dv_timings, dv_timings);
> -	if (!ret && vpbe_dev->amp) {
> -		/* Call amplifier subdevice */
> -		ret = v4l2_subdev_call(vpbe_dev->amp, video,
> -				s_dv_timings, dv_timings);
> -	}
> -	/* set the lcd controller output for the given mode */
> -	if (!ret) {
> -		struct osd_state *osd_device = vpbe_dev->osd_device;
> -
> -		osd_device->ops.set_left_margin(osd_device,
> -		vpbe_dev->current_timings.left_margin);
> -		osd_device->ops.set_top_margin(osd_device,
> -		vpbe_dev->current_timings.upper_margin);
> -	}
> -	mutex_unlock(&vpbe_dev->lock);
> -
> -	return ret;
> -}
> -
> -/*
> - * vpbe_g_dv_timings - Get the timings in the current encoder
> - *
> - * Get the timings in the current encoder. Return the status. 0 - success
> - * -EINVAL on error
> - */
> -static int vpbe_g_dv_timings(struct vpbe_device *vpbe_dev,
> -		     struct v4l2_dv_timings *dv_timings)
> -{
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	int out_index = vpbe_dev->current_out_index;
> -
> -	if (!(cfg->outputs[out_index].output.capabilities &
> -		V4L2_OUT_CAP_DV_TIMINGS))
> -		return -ENODATA;
> -
> -	if (vpbe_dev->current_timings.timings_type &
> -	  VPBE_ENC_DV_TIMINGS) {
> -		*dv_timings = vpbe_dev->current_timings.dv_timings;
> -		return 0;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -/*
> - * vpbe_enum_dv_timings - Enumerate the dv timings in the current encoder
> - *
> - * Get the timings in the current encoder. Return the status. 0 - success
> - * -EINVAL on error
> - */
> -static int vpbe_enum_dv_timings(struct vpbe_device *vpbe_dev,
> -			 struct v4l2_enum_dv_timings *timings)
> -{
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	int out_index = vpbe_dev->current_out_index;
> -	struct vpbe_output *output = &cfg->outputs[out_index];
> -	int j = 0;
> -	int i;
> -
> -	if (!(output->output.capabilities & V4L2_OUT_CAP_DV_TIMINGS))
> -		return -ENODATA;
> -
> -	for (i = 0; i < output->num_modes; i++) {
> -		if (output->modes[i].timings_type == VPBE_ENC_DV_TIMINGS) {
> -			if (j == timings->index)
> -				break;
> -			j++;
> -		}
> -	}
> -
> -	if (i == output->num_modes)
> -		return -EINVAL;
> -	timings->timings = output->modes[i].dv_timings;
> -	return 0;
> -}
> -
> -/*
> - * vpbe_s_std - Set the given standard in the encoder
> - *
> - * Sets the standard if supported by the current encoder. Return the status.
> - * 0 - success & -EINVAL on error
> - */
> -static int vpbe_s_std(struct vpbe_device *vpbe_dev, v4l2_std_id std_id)
> -{
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	int out_index = vpbe_dev->current_out_index;
> -	int sd_index = vpbe_dev->current_sd_index;
> -	int ret;
> -
> -	if (!(cfg->outputs[out_index].output.capabilities &
> -		V4L2_OUT_CAP_STD))
> -		return -ENODATA;
> -
> -	ret = vpbe_get_std_info(vpbe_dev, std_id);
> -	if (ret)
> -		return ret;
> -
> -	mutex_lock(&vpbe_dev->lock);
> -
> -	ret = v4l2_subdev_call(vpbe_dev->encoders[sd_index], video,
> -			       s_std_output, std_id);
> -	/* set the lcd controller output for the given mode */
> -	if (!ret) {
> -		struct osd_state *osd_device = vpbe_dev->osd_device;
> -
> -		osd_device->ops.set_left_margin(osd_device,
> -		vpbe_dev->current_timings.left_margin);
> -		osd_device->ops.set_top_margin(osd_device,
> -		vpbe_dev->current_timings.upper_margin);
> -	}
> -	mutex_unlock(&vpbe_dev->lock);
> -
> -	return ret;
> -}
> -
> -/*
> - * vpbe_g_std - Get the standard in the current encoder
> - *
> - * Get the standard in the current encoder. Return the status. 0 - success
> - * -EINVAL on error
> - */
> -static int vpbe_g_std(struct vpbe_device *vpbe_dev, v4l2_std_id *std_id)
> -{
> -	struct vpbe_enc_mode_info *cur_timings = &vpbe_dev->current_timings;
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	int out_index = vpbe_dev->current_out_index;
> -
> -	if (!(cfg->outputs[out_index].output.capabilities & V4L2_OUT_CAP_STD))
> -		return -ENODATA;
> -
> -	if (cur_timings->timings_type & VPBE_ENC_STD) {
> -		*std_id = cur_timings->std_id;
> -		return 0;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -/*
> - * vpbe_set_mode - Set mode in the current encoder using mode info
> - *
> - * Use the mode string to decide what timings to set in the encoder
> - * This is typically useful when fbset command is used to change the current
> - * timings by specifying a string to indicate the timings.
> - */
> -static int vpbe_set_mode(struct vpbe_device *vpbe_dev,
> -			 struct vpbe_enc_mode_info *mode_info)
> -{
> -	struct vpbe_enc_mode_info *preset_mode = NULL;
> -	struct vpbe_config *cfg = vpbe_dev->cfg;
> -	struct v4l2_dv_timings dv_timings;
> -	struct osd_state *osd_device;
> -	int out_index = vpbe_dev->current_out_index;
> -	int i;
> -
> -	if (!mode_info || !mode_info->name)
> -		return -EINVAL;
> -
> -	for (i = 0; i < cfg->outputs[out_index].num_modes; i++) {
> -		if (!strcmp(mode_info->name,
> -		     cfg->outputs[out_index].modes[i].name)) {
> -			preset_mode = &cfg->outputs[out_index].modes[i];
> -			/*
> -			 * it may be one of the 3 timings type. Check and
> -			 * invoke right API
> -			 */
> -			if (preset_mode->timings_type & VPBE_ENC_STD)
> -				return vpbe_s_std(vpbe_dev,
> -						 preset_mode->std_id);
> -			if (preset_mode->timings_type &
> -						VPBE_ENC_DV_TIMINGS) {
> -				dv_timings =
> -					preset_mode->dv_timings;
> -				return vpbe_s_dv_timings(vpbe_dev, &dv_timings);
> -			}
> -		}
> -	}
> -
> -	/* Only custom timing should reach here */
> -	if (!preset_mode)
> -		return -EINVAL;
> -
> -	mutex_lock(&vpbe_dev->lock);
> -
> -	osd_device = vpbe_dev->osd_device;
> -	vpbe_dev->current_timings = *preset_mode;
> -	osd_device->ops.set_left_margin(osd_device,
> -		vpbe_dev->current_timings.left_margin);
> -	osd_device->ops.set_top_margin(osd_device,
> -		vpbe_dev->current_timings.upper_margin);
> -
> -	mutex_unlock(&vpbe_dev->lock);
> -	return 0;
> -}
> -
> -static int vpbe_set_default_mode(struct vpbe_device *vpbe_dev)
> -{
> -	int ret;
> -
> -	ret = vpbe_get_std_info_by_name(vpbe_dev, def_mode);
> -	if (ret)
> -		return ret;
> -
> -	/* set the default mode in the encoder */
> -	return vpbe_set_mode(vpbe_dev, &vpbe_dev->current_timings);
> -}
> -
> -static int platform_device_get(struct device *dev, void *data)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct vpbe_device *vpbe_dev = data;
> -
> -	if (strstr(pdev->name, "vpbe-osd"))
> -		vpbe_dev->osd_device = platform_get_drvdata(pdev);
> -	if (strstr(pdev->name, "vpbe-venc"))
> -		vpbe_dev->venc_device = dev_get_platdata(&pdev->dev);
> -
> -	return 0;
> -}
> -
> -/**
> - * vpbe_initialize() - Initialize the vpbe display controller
> - * @dev: Master and slave device ptr
> - * @vpbe_dev: vpbe device ptr
> - *
> - * Master frame buffer device drivers calls this to initialize vpbe
> - * display controller. This will then registers v4l2 device and the sub
> - * devices and sets a current encoder sub device for display. v4l2 display
> - * device driver is the master and frame buffer display device driver is
> - * the slave. Frame buffer display driver checks the initialized during
> - * probe and exit if not initialized. Returns status.
> - */
> -static int vpbe_initialize(struct device *dev, struct vpbe_device *vpbe_dev)
> -{
> -	struct encoder_config_info *enc_info;
> -	struct amp_config_info *amp_info;
> -	struct v4l2_subdev **enc_subdev;
> -	struct osd_state *osd_device;
> -	struct i2c_adapter *i2c_adap;
> -	int num_encoders;
> -	int ret = 0;
> -	int err;
> -	int i;
> -
> -	/*
> -	 * v4l2 abd FBDev frame buffer devices will get the vpbe_dev pointer
> -	 * from the platform device by iteration of platform drivers and
> -	 * matching with device name
> -	 */
> -	if (!vpbe_dev || !dev) {
> -		printk(KERN_ERR "Null device pointers.\n");
> -		return -ENODEV;
> -	}
> -
> -	if (vpbe_dev->initialized)
> -		return 0;
> -
> -	mutex_lock(&vpbe_dev->lock);
> -
> -	if (strcmp(vpbe_dev->cfg->module_name, "dm644x-vpbe-display") != 0) {
> -		/* We have dac clock available for platform */
> -		vpbe_dev->dac_clk = clk_get(vpbe_dev->pdev, "vpss_dac");
> -		if (IS_ERR(vpbe_dev->dac_clk)) {
> -			ret =  PTR_ERR(vpbe_dev->dac_clk);
> -			goto fail_mutex_unlock;
> -		}
> -		if (clk_prepare_enable(vpbe_dev->dac_clk)) {
> -			ret =  -ENODEV;
> -			clk_put(vpbe_dev->dac_clk);
> -			goto fail_mutex_unlock;
> -		}
> -	}
> -
> -	/* first enable vpss clocks */
> -	vpss_enable_clock(VPSS_VPBE_CLOCK, 1);
> -
> -	/* First register a v4l2 device */
> -	ret = v4l2_device_register(dev, &vpbe_dev->v4l2_dev);
> -	if (ret) {
> -		v4l2_err(dev->driver,
> -			"Unable to register v4l2 device.\n");
> -		goto fail_clk_put;
> -	}
> -	v4l2_info(&vpbe_dev->v4l2_dev, "vpbe v4l2 device registered\n");
> -
> -	err = bus_for_each_dev(&platform_bus_type, NULL, vpbe_dev,
> -			       platform_device_get);
> -	if (err < 0) {
> -		ret = err;
> -		goto fail_dev_unregister;
> -	}
> -
> -	vpbe_dev->venc = venc_sub_dev_init(&vpbe_dev->v4l2_dev,
> -					   vpbe_dev->cfg->venc.module_name);
> -	/* register venc sub device */
> -	if (!vpbe_dev->venc) {
> -		v4l2_err(&vpbe_dev->v4l2_dev,
> -			"vpbe unable to init venc sub device\n");
> -		ret = -ENODEV;
> -		goto fail_dev_unregister;
> -	}
> -	/* initialize osd device */
> -	osd_device = vpbe_dev->osd_device;
> -	if (osd_device->ops.initialize) {
> -		err = osd_device->ops.initialize(osd_device);
> -		if (err) {
> -			v4l2_err(&vpbe_dev->v4l2_dev,
> -				 "unable to initialize the OSD device");
> -			ret = -ENOMEM;
> -			goto fail_dev_unregister;
> -		}
> -	}
> -
> -	/*
> -	 * Register any external encoders that are configured. At index 0 we
> -	 * store venc sd index.
> -	 */
> -	num_encoders = vpbe_dev->cfg->num_ext_encoders + 1;
> -	vpbe_dev->encoders = kmalloc_array(num_encoders,
> -					   sizeof(*vpbe_dev->encoders),
> -					   GFP_KERNEL);
> -	if (!vpbe_dev->encoders) {
> -		ret = -ENOMEM;
> -		goto fail_dev_unregister;
> -	}
> -
> -	i2c_adap = i2c_get_adapter(vpbe_dev->cfg->i2c_adapter_id);
> -	for (i = 0; i < (vpbe_dev->cfg->num_ext_encoders + 1); i++) {
> -		if (i == 0) {
> -			/* venc is at index 0 */
> -			enc_subdev = &vpbe_dev->encoders[i];
> -			*enc_subdev = vpbe_dev->venc;
> -			continue;
> -		}
> -		enc_info = &vpbe_dev->cfg->ext_encoders[i];
> -		if (enc_info->is_i2c) {
> -			enc_subdev = &vpbe_dev->encoders[i];
> -			*enc_subdev = v4l2_i2c_new_subdev_board(
> -						&vpbe_dev->v4l2_dev, i2c_adap,
> -						&enc_info->board_info, NULL);
> -			if (*enc_subdev)
> -				v4l2_info(&vpbe_dev->v4l2_dev,
> -					  "v4l2 sub device %s registered\n",
> -					  enc_info->module_name);
> -			else {
> -				v4l2_err(&vpbe_dev->v4l2_dev, "encoder %s failed to register",
> -					 enc_info->module_name);
> -				ret = -ENODEV;
> -				goto fail_kfree_encoders;
> -			}
> -		} else
> -			v4l2_warn(&vpbe_dev->v4l2_dev, "non-i2c encoders currently not supported");
> -	}
> -	/* Add amplifier subdevice for dm365 */
> -	if ((strcmp(vpbe_dev->cfg->module_name, "dm365-vpbe-display") == 0) &&
> -	   vpbe_dev->cfg->amp) {
> -		amp_info = vpbe_dev->cfg->amp;
> -		if (amp_info->is_i2c) {
> -			vpbe_dev->amp = v4l2_i2c_new_subdev_board(
> -			&vpbe_dev->v4l2_dev, i2c_adap,
> -			&amp_info->board_info, NULL);
> -			if (!vpbe_dev->amp) {
> -				v4l2_err(&vpbe_dev->v4l2_dev,
> -					 "amplifier %s failed to register",
> -					 amp_info->module_name);
> -				ret = -ENODEV;
> -				goto fail_kfree_encoders;
> -			}
> -			v4l2_info(&vpbe_dev->v4l2_dev,
> -					  "v4l2 sub device %s registered\n",
> -					  amp_info->module_name);
> -		} else {
> -			    vpbe_dev->amp = NULL;
> -			    v4l2_warn(&vpbe_dev->v4l2_dev, "non-i2c amplifiers currently not supported");
> -		}
> -	} else {
> -	    vpbe_dev->amp = NULL;
> -	}
> -
> -	/* set the current encoder and output to that of venc by default */
> -	vpbe_dev->current_sd_index = 0;
> -	vpbe_dev->current_out_index = 0;
> -
> -	mutex_unlock(&vpbe_dev->lock);
> -
> -	printk(KERN_NOTICE "Setting default output to %s\n", def_output);
> -	ret = vpbe_set_default_output(vpbe_dev);
> -	if (ret) {
> -		v4l2_err(&vpbe_dev->v4l2_dev, "Failed to set default output %s",
> -			 def_output);
> -		goto fail_kfree_amp;
> -	}
> -
> -	printk(KERN_NOTICE "Setting default mode to %s\n", def_mode);
> -	ret = vpbe_set_default_mode(vpbe_dev);
> -	if (ret) {
> -		v4l2_err(&vpbe_dev->v4l2_dev, "Failed to set default mode %s",
> -			 def_mode);
> -		goto fail_kfree_amp;
> -	}
> -	vpbe_dev->initialized = 1;
> -	/* TBD handling of bootargs for default output and mode */
> -	return 0;
> -
> -fail_kfree_amp:
> -	mutex_lock(&vpbe_dev->lock);
> -	kfree(vpbe_dev->amp);
> -fail_kfree_encoders:
> -	kfree(vpbe_dev->encoders);
> -fail_dev_unregister:
> -	v4l2_device_unregister(&vpbe_dev->v4l2_dev);
> -fail_clk_put:
> -	if (strcmp(vpbe_dev->cfg->module_name, "dm644x-vpbe-display") != 0) {
> -		clk_disable_unprepare(vpbe_dev->dac_clk);
> -		clk_put(vpbe_dev->dac_clk);
> -	}
> -fail_mutex_unlock:
> -	mutex_unlock(&vpbe_dev->lock);
> -	return ret;
> -}
> -
> -/**
> - * vpbe_deinitialize() - de-initialize the vpbe display controller
> - * @dev: Master and slave device ptr
> - * @vpbe_dev: vpbe device ptr
> - *
> - * vpbe_master and slave frame buffer devices calls this to de-initialize
> - * the display controller. It is called when master and slave device
> - * driver modules are removed and no longer requires the display controller.
> - */
> -static void vpbe_deinitialize(struct device *dev, struct vpbe_device *vpbe_dev)
> -{
> -	v4l2_device_unregister(&vpbe_dev->v4l2_dev);
> -	if (strcmp(vpbe_dev->cfg->module_name, "dm644x-vpbe-display") != 0) {
> -		clk_disable_unprepare(vpbe_dev->dac_clk);
> -		clk_put(vpbe_dev->dac_clk);
> -	}
> -
> -	kfree(vpbe_dev->amp);
> -	kfree(vpbe_dev->encoders);
> -	vpbe_dev->initialized = 0;
> -	/* disable vpss clocks */
> -	vpss_enable_clock(VPSS_VPBE_CLOCK, 0);
> -}
> -
> -static const struct vpbe_device_ops vpbe_dev_ops = {
> -	.enum_outputs = vpbe_enum_outputs,
> -	.set_output = vpbe_set_output,
> -	.get_output = vpbe_get_output,
> -	.s_dv_timings = vpbe_s_dv_timings,
> -	.g_dv_timings = vpbe_g_dv_timings,
> -	.enum_dv_timings = vpbe_enum_dv_timings,
> -	.s_std = vpbe_s_std,
> -	.g_std = vpbe_g_std,
> -	.initialize = vpbe_initialize,
> -	.deinitialize = vpbe_deinitialize,
> -	.get_mode_info = vpbe_get_current_mode_info,
> -	.set_mode = vpbe_set_mode,
> -};
> -
> -static int vpbe_probe(struct platform_device *pdev)
> -{
> -	struct vpbe_device *vpbe_dev;
> -	struct vpbe_config *cfg;
> -
> -	if (!pdev->dev.platform_data) {
> -		v4l2_err(pdev->dev.driver, "No platform data\n");
> -		return -ENODEV;
> -	}
> -	cfg = pdev->dev.platform_data;
> -
> -	if (!cfg->module_name[0] ||
> -	    !cfg->osd.module_name[0] ||
> -	    !cfg->venc.module_name[0]) {
> -		v4l2_err(pdev->dev.driver, "vpbe display module names not defined\n");
> -		return -EINVAL;
> -	}
> -
> -	vpbe_dev = kzalloc(sizeof(*vpbe_dev), GFP_KERNEL);
> -	if (!vpbe_dev)
> -		return -ENOMEM;
> -
> -	vpbe_dev->cfg = cfg;
> -	vpbe_dev->ops = vpbe_dev_ops;
> -	vpbe_dev->pdev = &pdev->dev;
> -
> -	if (cfg->outputs->num_modes > 0)
> -		vpbe_dev->current_timings = vpbe_dev->cfg->outputs[0].modes[0];
> -	else {
> -		kfree(vpbe_dev);
> -		return -ENODEV;
> -	}
> -
> -	/* set the driver data in platform device */
> -	platform_set_drvdata(pdev, vpbe_dev);
> -	mutex_init(&vpbe_dev->lock);
> -
> -	return 0;
> -}
> -
> -static int vpbe_remove(struct platform_device *device)
> -{
> -	struct vpbe_device *vpbe_dev = platform_get_drvdata(device);
> -
> -	kfree(vpbe_dev);
> -
> -	return 0;
> -}
> -
> -static struct platform_driver vpbe_driver = {
> -	.driver	= {
> -		.name	= "vpbe_controller",
> -	},
> -	.probe = vpbe_probe,
> -	.remove = vpbe_remove,
> -};
> -
> -module_platform_driver(vpbe_driver);
> diff --git a/drivers/media/platform/ti/davinci/vpbe_display.c b/drivers/media/platform/ti/davinci/vpbe_display.c
> deleted file mode 100644
> index 9ea70817538e..000000000000
> --- a/drivers/media/platform/ti/davinci/vpbe_display.c
> +++ /dev/null
> @@ -1,1510 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/errno.h>
> -#include <linux/interrupt.h>
> -#include <linux/string.h>
> -#include <linux/wait.h>
> -#include <linux/time.h>
> -#include <linux/platform_device.h>
> -#include <linux/irq.h>
> -#include <linux/mm.h>
> -#include <linux/mutex.h>
> -#include <linux/videodev2.h>
> -#include <linux/slab.h>
> -
> -
> -#include <media/v4l2-dev.h>
> -#include <media/v4l2-common.h>
> -#include <media/v4l2-ioctl.h>
> -#include <media/v4l2-device.h>
> -#include <media/davinci/vpbe_display.h>
> -#include <media/davinci/vpbe_types.h>
> -#include <media/davinci/vpbe.h>
> -#include <media/davinci/vpbe_venc.h>
> -#include <media/davinci/vpbe_osd.h>
> -#include "vpbe_venc_regs.h"
> -
> -#define VPBE_DISPLAY_DRIVER "vpbe-v4l2"
> -
> -static int debug;
> -
> -#define VPBE_DEFAULT_NUM_BUFS 3
> -
> -module_param(debug, int, 0644);
> -
> -static int vpbe_set_osd_display_params(struct vpbe_display *disp_dev,
> -			struct vpbe_layer *layer);
> -
> -static int venc_is_second_field(struct vpbe_display *disp_dev)
> -{
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -	int ret, val;
> -
> -	ret = v4l2_subdev_call(vpbe_dev->venc,
> -			       core,
> -			       command,
> -			       VENC_GET_FLD,
> -			       &val);
> -	if (ret < 0) {
> -		v4l2_err(&vpbe_dev->v4l2_dev,
> -			 "Error in getting Field ID 0\n");
> -		return 1;
> -	}
> -	return val;
> -}
> -
> -static void vpbe_isr_even_field(struct vpbe_display *disp_obj,
> -				struct vpbe_layer *layer)
> -{
> -	if (layer->cur_frm == layer->next_frm)
> -		return;
> -
> -	layer->cur_frm->vb.vb2_buf.timestamp = ktime_get_ns();
> -	vb2_buffer_done(&layer->cur_frm->vb.vb2_buf, VB2_BUF_STATE_DONE);
> -	/* Make cur_frm pointing to next_frm */
> -	layer->cur_frm = layer->next_frm;
> -}
> -
> -static void vpbe_isr_odd_field(struct vpbe_display *disp_obj,
> -				struct vpbe_layer *layer)
> -{
> -	struct osd_state *osd_device = disp_obj->osd_device;
> -	unsigned long addr;
> -
> -	spin_lock(&disp_obj->dma_queue_lock);
> -	if (list_empty(&layer->dma_queue) ||
> -		(layer->cur_frm != layer->next_frm)) {
> -		spin_unlock(&disp_obj->dma_queue_lock);
> -		return;
> -	}
> -	/*
> -	 * one field is displayed configure
> -	 * the next frame if it is available
> -	 * otherwise hold on current frame
> -	 * Get next from the buffer queue
> -	 */
> -	layer->next_frm = list_entry(layer->dma_queue.next,
> -			  struct  vpbe_disp_buffer, list);
> -	/* Remove that from the buffer queue */
> -	list_del(&layer->next_frm->list);
> -	spin_unlock(&disp_obj->dma_queue_lock);
> -	/* Mark state of the frame to active */
> -	layer->next_frm->vb.vb2_buf.state = VB2_BUF_STATE_ACTIVE;
> -	addr = vb2_dma_contig_plane_dma_addr(&layer->next_frm->vb.vb2_buf, 0);
> -	osd_device->ops.start_layer(osd_device,
> -			layer->layer_info.id,
> -			addr,
> -			disp_obj->cbcr_ofst);
> -}
> -
> -/* interrupt service routine */
> -static irqreturn_t venc_isr(int irq, void *arg)
> -{
> -	struct vpbe_display *disp_dev = (struct vpbe_display *)arg;
> -	struct vpbe_layer *layer;
> -	static unsigned last_event;
> -	unsigned event = 0;
> -	int fid;
> -	int i;
> -
> -	if (!arg || !disp_dev->dev[0])
> -		return IRQ_HANDLED;
> -
> -	if (venc_is_second_field(disp_dev))
> -		event |= VENC_SECOND_FIELD;
> -	else
> -		event |= VENC_FIRST_FIELD;
> -
> -	if (event == (last_event & ~VENC_END_OF_FRAME)) {
> -		/*
> -		* If the display is non-interlaced, then we need to flag the
> -		* end-of-frame event at every interrupt regardless of the
> -		* value of the FIDST bit.  We can conclude that the display is
> -		* non-interlaced if the value of the FIDST bit is unchanged
> -		* from the previous interrupt.
> -		*/
> -		event |= VENC_END_OF_FRAME;
> -	} else if (event == VENC_SECOND_FIELD) {
> -		/* end-of-frame for interlaced display */
> -		event |= VENC_END_OF_FRAME;
> -	}
> -	last_event = event;
> -
> -	for (i = 0; i < VPBE_DISPLAY_MAX_DEVICES; i++) {
> -		layer = disp_dev->dev[i];
> -
> -		if (!vb2_start_streaming_called(&layer->buffer_queue))
> -			continue;
> -
> -		if (layer->layer_first_int) {
> -			layer->layer_first_int = 0;
> -			continue;
> -		}
> -		/* Check the field format */
> -		if ((V4L2_FIELD_NONE == layer->pix_fmt.field) &&
> -			(event & VENC_END_OF_FRAME)) {
> -			/* Progressive mode */
> -
> -			vpbe_isr_even_field(disp_dev, layer);
> -			vpbe_isr_odd_field(disp_dev, layer);
> -		} else {
> -		/* Interlaced mode */
> -
> -			layer->field_id ^= 1;
> -			if (event & VENC_FIRST_FIELD)
> -				fid = 0;
> -			else
> -				fid = 1;
> -
> -			/*
> -			* If field id does not match with store
> -			* field id
> -			*/
> -			if (fid != layer->field_id) {
> -				/* Make them in sync */
> -				layer->field_id = fid;
> -				continue;
> -			}
> -			/*
> -			* device field id and local field id are
> -			* in sync. If this is even field
> -			*/
> -			if (0 == fid)
> -				vpbe_isr_even_field(disp_dev, layer);
> -			else  /* odd field */
> -				vpbe_isr_odd_field(disp_dev, layer);
> -		}
> -	}
> -
> -	return IRQ_HANDLED;
> -}
> -
> -/*
> - * vpbe_buffer_prepare()
> - * This is the callback function called from vb2_qbuf() function
> - * the buffer is prepared and user space virtual address is converted into
> - * physical address
> - */
> -static int vpbe_buffer_prepare(struct vb2_buffer *vb)
> -{
> -	struct vb2_queue *q = vb->vb2_queue;
> -	struct vpbe_layer *layer = vb2_get_drv_priv(q);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -	unsigned long addr;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -				"vpbe_buffer_prepare\n");
> -
> -	vb2_set_plane_payload(vb, 0, layer->pix_fmt.sizeimage);
> -	if (vb2_get_plane_payload(vb, 0) > vb2_plane_size(vb, 0))
> -		return -EINVAL;
> -
> -	addr = vb2_dma_contig_plane_dma_addr(vb, 0);
> -	if (!IS_ALIGNED(addr, 8)) {
> -		v4l2_err(&vpbe_dev->v4l2_dev,
> -			 "buffer_prepare:offset is not aligned to 32 bytes\n");
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -/*
> - * vpbe_buffer_setup()
> - * This function allocates memory for the buffers
> - */
> -static int
> -vpbe_buffer_queue_setup(struct vb2_queue *vq,
> -			unsigned int *nbuffers, unsigned int *nplanes,
> -			unsigned int sizes[], struct device *alloc_devs[])
> -
> -{
> -	/* Get the file handle object and layer object */
> -	struct vpbe_layer *layer = vb2_get_drv_priv(vq);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "vpbe_buffer_setup\n");
> -
> -	/* Store number of buffers allocated in numbuffer member */
> -	if (vq->num_buffers + *nbuffers < VPBE_DEFAULT_NUM_BUFS)
> -		*nbuffers = VPBE_DEFAULT_NUM_BUFS - vq->num_buffers;
> -
> -	if (*nplanes)
> -		return sizes[0] < layer->pix_fmt.sizeimage ? -EINVAL : 0;
> -
> -	*nplanes = 1;
> -	sizes[0] = layer->pix_fmt.sizeimage;
> -
> -	return 0;
> -}
> -
> -/*
> - * vpbe_buffer_queue()
> - * This function adds the buffer to DMA queue
> - */
> -static void vpbe_buffer_queue(struct vb2_buffer *vb)
> -{
> -	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> -	/* Get the file handle object and layer object */
> -	struct vpbe_disp_buffer *buf = container_of(vbuf,
> -				struct vpbe_disp_buffer, vb);
> -	struct vpbe_layer *layer = vb2_get_drv_priv(vb->vb2_queue);
> -	struct vpbe_display *disp = layer->disp_dev;
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -	unsigned long flags;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -			"vpbe_buffer_queue\n");
> -
> -	/* add the buffer to the DMA queue */
> -	spin_lock_irqsave(&disp->dma_queue_lock, flags);
> -	list_add_tail(&buf->list, &layer->dma_queue);
> -	spin_unlock_irqrestore(&disp->dma_queue_lock, flags);
> -}
> -
> -static int vpbe_start_streaming(struct vb2_queue *vq, unsigned int count)
> -{
> -	struct vpbe_layer *layer = vb2_get_drv_priv(vq);
> -	struct osd_state *osd_device = layer->disp_dev->osd_device;
> -	int ret;
> -
> -	osd_device->ops.disable_layer(osd_device, layer->layer_info.id);
> -
> -	/* Get the next frame from the buffer queue */
> -	layer->next_frm = layer->cur_frm = list_entry(layer->dma_queue.next,
> -				struct vpbe_disp_buffer, list);
> -	/* Remove buffer from the buffer queue */
> -	list_del(&layer->cur_frm->list);
> -	/* Mark state of the current frame to active */
> -	layer->cur_frm->vb.vb2_buf.state = VB2_BUF_STATE_ACTIVE;
> -	/* Initialize field_id and started member */
> -	layer->field_id = 0;
> -
> -	/* Set parameters in OSD and VENC */
> -	ret = vpbe_set_osd_display_params(layer->disp_dev, layer);
> -	if (ret < 0) {
> -		struct vpbe_disp_buffer *buf, *tmp;
> -
> -		vb2_buffer_done(&layer->cur_frm->vb.vb2_buf,
> -				VB2_BUF_STATE_QUEUED);
> -		list_for_each_entry_safe(buf, tmp, &layer->dma_queue, list) {
> -			list_del(&buf->list);
> -			vb2_buffer_done(&buf->vb.vb2_buf,
> -					VB2_BUF_STATE_QUEUED);
> -		}
> -
> -		return ret;
> -	}
> -
> -	/*
> -	 * if request format is yuv420 semiplanar, need to
> -	 * enable both video windows
> -	 */
> -	layer->layer_first_int = 1;
> -
> -	return ret;
> -}
> -
> -static void vpbe_stop_streaming(struct vb2_queue *vq)
> -{
> -	struct vpbe_layer *layer = vb2_get_drv_priv(vq);
> -	struct osd_state *osd_device = layer->disp_dev->osd_device;
> -	struct vpbe_display *disp = layer->disp_dev;
> -	unsigned long flags;
> -
> -	if (!vb2_is_streaming(vq))
> -		return;
> -
> -	osd_device->ops.disable_layer(osd_device, layer->layer_info.id);
> -
> -	/* release all active buffers */
> -	spin_lock_irqsave(&disp->dma_queue_lock, flags);
> -	if (layer->cur_frm == layer->next_frm) {
> -		vb2_buffer_done(&layer->cur_frm->vb.vb2_buf,
> -				VB2_BUF_STATE_ERROR);
> -	} else {
> -		if (layer->cur_frm)
> -			vb2_buffer_done(&layer->cur_frm->vb.vb2_buf,
> -					VB2_BUF_STATE_ERROR);
> -		if (layer->next_frm)
> -			vb2_buffer_done(&layer->next_frm->vb.vb2_buf,
> -					VB2_BUF_STATE_ERROR);
> -	}
> -
> -	while (!list_empty(&layer->dma_queue)) {
> -		layer->next_frm = list_entry(layer->dma_queue.next,
> -						struct vpbe_disp_buffer, list);
> -		list_del(&layer->next_frm->list);
> -		vb2_buffer_done(&layer->next_frm->vb.vb2_buf,
> -				VB2_BUF_STATE_ERROR);
> -	}
> -	spin_unlock_irqrestore(&disp->dma_queue_lock, flags);
> -}
> -
> -static const struct vb2_ops video_qops = {
> -	.queue_setup = vpbe_buffer_queue_setup,
> -	.wait_prepare = vb2_ops_wait_prepare,
> -	.wait_finish = vb2_ops_wait_finish,
> -	.buf_prepare = vpbe_buffer_prepare,
> -	.start_streaming = vpbe_start_streaming,
> -	.stop_streaming = vpbe_stop_streaming,
> -	.buf_queue = vpbe_buffer_queue,
> -};
> -
> -static
> -struct vpbe_layer*
> -_vpbe_display_get_other_win_layer(struct vpbe_display *disp_dev,
> -			struct vpbe_layer *layer)
> -{
> -	enum vpbe_display_device_id thiswin, otherwin;
> -	thiswin = layer->device_id;
> -
> -	otherwin = (thiswin == VPBE_DISPLAY_DEVICE_0) ?
> -	VPBE_DISPLAY_DEVICE_1 : VPBE_DISPLAY_DEVICE_0;
> -	return disp_dev->dev[otherwin];
> -}
> -
> -static int vpbe_set_osd_display_params(struct vpbe_display *disp_dev,
> -			struct vpbe_layer *layer)
> -{
> -	struct osd_layer_config *cfg  = &layer->layer_info.config;
> -	struct osd_state *osd_device = disp_dev->osd_device;
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -	unsigned long addr;
> -	int ret;
> -
> -	addr = vb2_dma_contig_plane_dma_addr(&layer->cur_frm->vb.vb2_buf, 0);
> -	/* Set address in the display registers */
> -	osd_device->ops.start_layer(osd_device,
> -				    layer->layer_info.id,
> -				    addr,
> -				    disp_dev->cbcr_ofst);
> -
> -	ret = osd_device->ops.enable_layer(osd_device,
> -				layer->layer_info.id, 0);
> -	if (ret < 0) {
> -		v4l2_err(&vpbe_dev->v4l2_dev,
> -			"Error in enabling osd window layer 0\n");
> -		return -1;
> -	}
> -
> -	/* Enable the window */
> -	layer->layer_info.enable = 1;
> -	if (cfg->pixfmt == PIXFMT_NV12) {
> -		struct vpbe_layer *otherlayer =
> -			_vpbe_display_get_other_win_layer(disp_dev, layer);
> -
> -		ret = osd_device->ops.enable_layer(osd_device,
> -				otherlayer->layer_info.id, 1);
> -		if (ret < 0) {
> -			v4l2_err(&vpbe_dev->v4l2_dev,
> -				"Error in enabling osd window layer 1\n");
> -			return -1;
> -		}
> -		otherlayer->layer_info.enable = 1;
> -	}
> -	return 0;
> -}
> -
> -static void
> -vpbe_disp_calculate_scale_factor(struct vpbe_display *disp_dev,
> -			struct vpbe_layer *layer,
> -			int expected_xsize, int expected_ysize)
> -{
> -	struct display_layer_info *layer_info = &layer->layer_info;
> -	struct v4l2_pix_format *pixfmt = &layer->pix_fmt;
> -	struct osd_layer_config *cfg  = &layer->layer_info.config;
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -	int calculated_xsize;
> -	int h_exp = 0;
> -	int v_exp = 0;
> -	int h_scale;
> -	int v_scale;
> -
> -	v4l2_std_id standard_id = vpbe_dev->current_timings.std_id;
> -
> -	/*
> -	 * Application initially set the image format. Current display
> -	 * size is obtained from the vpbe display controller. expected_xsize
> -	 * and expected_ysize are set through S_SELECTION ioctl. Based on this,
> -	 * driver will calculate the scale factors for vertical and
> -	 * horizontal direction so that the image is displayed scaled
> -	 * and expanded. Application uses expansion to display the image
> -	 * in a square pixel. Otherwise it is displayed using displays
> -	 * pixel aspect ratio.It is expected that application chooses
> -	 * the crop coordinates for cropped or scaled display. if crop
> -	 * size is less than the image size, it is displayed cropped or
> -	 * it is displayed scaled and/or expanded.
> -	 *
> -	 * to begin with, set the crop window same as expected. Later we
> -	 * will override with scaled window size
> -	 */
> -
> -	cfg->xsize = pixfmt->width;
> -	cfg->ysize = pixfmt->height;
> -	layer_info->h_zoom = ZOOM_X1;	/* no horizontal zoom */
> -	layer_info->v_zoom = ZOOM_X1;	/* no horizontal zoom */
> -	layer_info->h_exp = H_EXP_OFF;	/* no horizontal zoom */
> -	layer_info->v_exp = V_EXP_OFF;	/* no horizontal zoom */
> -
> -	if (pixfmt->width < expected_xsize) {
> -		h_scale = vpbe_dev->current_timings.xres / pixfmt->width;
> -		if (h_scale < 2)
> -			h_scale = 1;
> -		else if (h_scale >= 4)
> -			h_scale = 4;
> -		else
> -			h_scale = 2;
> -		cfg->xsize *= h_scale;
> -		if (cfg->xsize < expected_xsize) {
> -			if ((standard_id & V4L2_STD_525_60) ||
> -			(standard_id & V4L2_STD_625_50)) {
> -				calculated_xsize = (cfg->xsize *
> -					VPBE_DISPLAY_H_EXP_RATIO_N) /
> -					VPBE_DISPLAY_H_EXP_RATIO_D;
> -				if (calculated_xsize <= expected_xsize) {
> -					h_exp = 1;
> -					cfg->xsize = calculated_xsize;
> -				}
> -			}
> -		}
> -		if (h_scale == 2)
> -			layer_info->h_zoom = ZOOM_X2;
> -		else if (h_scale == 4)
> -			layer_info->h_zoom = ZOOM_X4;
> -		if (h_exp)
> -			layer_info->h_exp = H_EXP_9_OVER_8;
> -	} else {
> -		/* no scaling, only cropping. Set display area to crop area */
> -		cfg->xsize = expected_xsize;
> -	}
> -
> -	if (pixfmt->height < expected_ysize) {
> -		v_scale = expected_ysize / pixfmt->height;
> -		if (v_scale < 2)
> -			v_scale = 1;
> -		else if (v_scale >= 4)
> -			v_scale = 4;
> -		else
> -			v_scale = 2;
> -		cfg->ysize *= v_scale;
> -		if (cfg->ysize < expected_ysize) {
> -			if ((standard_id & V4L2_STD_625_50)) {
> -				calculated_xsize = (cfg->ysize *
> -					VPBE_DISPLAY_V_EXP_RATIO_N) /
> -					VPBE_DISPLAY_V_EXP_RATIO_D;
> -				if (calculated_xsize <= expected_ysize) {
> -					v_exp = 1;
> -					cfg->ysize = calculated_xsize;
> -				}
> -			}
> -		}
> -		if (v_scale == 2)
> -			layer_info->v_zoom = ZOOM_X2;
> -		else if (v_scale == 4)
> -			layer_info->v_zoom = ZOOM_X4;
> -		if (v_exp)
> -			layer_info->v_exp = V_EXP_6_OVER_5;
> -	} else {
> -		/* no scaling, only cropping. Set display area to crop area */
> -		cfg->ysize = expected_ysize;
> -	}
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -		"crop display xsize = %d, ysize = %d\n",
> -		cfg->xsize, cfg->ysize);
> -}
> -
> -static void vpbe_disp_adj_position(struct vpbe_display *disp_dev,
> -			struct vpbe_layer *layer,
> -			int top, int left)
> -{
> -	struct osd_layer_config *cfg = &layer->layer_info.config;
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -
> -	cfg->xpos = min((unsigned int)left,
> -			vpbe_dev->current_timings.xres - cfg->xsize);
> -	cfg->ypos = min((unsigned int)top,
> -			vpbe_dev->current_timings.yres - cfg->ysize);
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -		"new xpos = %d, ypos = %d\n",
> -		cfg->xpos, cfg->ypos);
> -}
> -
> -static void vpbe_disp_check_window_params(struct vpbe_display *disp_dev,
> -			struct v4l2_rect *c)
> -{
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -
> -	if ((c->width == 0) ||
> -	  ((c->width + c->left) > vpbe_dev->current_timings.xres))
> -		c->width = vpbe_dev->current_timings.xres - c->left;
> -
> -	if ((c->height == 0) || ((c->height + c->top) >
> -	  vpbe_dev->current_timings.yres))
> -		c->height = vpbe_dev->current_timings.yres - c->top;
> -
> -	/* window height must be even for interlaced display */
> -	if (vpbe_dev->current_timings.interlaced)
> -		c->height &= (~0x01);
> -
> -}
> -
> -/*
> - * vpbe_try_format()
> - * If user application provides width and height, and have bytesperline set
> - * to zero, driver calculates bytesperline and sizeimage based on hardware
> - * limits.
> - */
> -static int vpbe_try_format(struct vpbe_display *disp_dev,
> -			struct v4l2_pix_format *pixfmt, int check)
> -{
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -	int min_height = 1;
> -	int min_width = 32;
> -	int max_height;
> -	int max_width;
> -	int bpp;
> -
> -	if ((pixfmt->pixelformat != V4L2_PIX_FMT_UYVY) &&
> -	    (pixfmt->pixelformat != V4L2_PIX_FMT_NV12))
> -		/* choose default as V4L2_PIX_FMT_UYVY */
> -		pixfmt->pixelformat = V4L2_PIX_FMT_UYVY;
> -
> -	/* Check the field format */
> -	if ((pixfmt->field != V4L2_FIELD_INTERLACED) &&
> -		(pixfmt->field != V4L2_FIELD_NONE)) {
> -		if (vpbe_dev->current_timings.interlaced)
> -			pixfmt->field = V4L2_FIELD_INTERLACED;
> -		else
> -			pixfmt->field = V4L2_FIELD_NONE;
> -	}
> -
> -	if (pixfmt->field == V4L2_FIELD_INTERLACED)
> -		min_height = 2;
> -
> -	if (pixfmt->pixelformat == V4L2_PIX_FMT_NV12)
> -		bpp = 1;
> -	else
> -		bpp = 2;
> -
> -	max_width = vpbe_dev->current_timings.xres;
> -	max_height = vpbe_dev->current_timings.yres;
> -
> -	min_width /= bpp;
> -
> -	if (!pixfmt->width || (pixfmt->width < min_width) ||
> -		(pixfmt->width > max_width)) {
> -		pixfmt->width = vpbe_dev->current_timings.xres;
> -	}
> -
> -	if (!pixfmt->height || (pixfmt->height  < min_height) ||
> -		(pixfmt->height  > max_height)) {
> -		pixfmt->height = vpbe_dev->current_timings.yres;
> -	}
> -
> -	if (pixfmt->bytesperline < (pixfmt->width * bpp))
> -		pixfmt->bytesperline = pixfmt->width * bpp;
> -
> -	/* Make the bytesperline 32 byte aligned */
> -	pixfmt->bytesperline = ((pixfmt->width * bpp + 31) & ~31);
> -
> -	if (pixfmt->pixelformat == V4L2_PIX_FMT_NV12)
> -		pixfmt->sizeimage = pixfmt->bytesperline * pixfmt->height +
> -				(pixfmt->bytesperline * pixfmt->height >> 1);
> -	else
> -		pixfmt->sizeimage = pixfmt->bytesperline * pixfmt->height;
> -
> -	return 0;
> -}
> -
> -static int vpbe_display_querycap(struct file *file, void  *priv,
> -			       struct v4l2_capability *cap)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -
> -	snprintf(cap->driver, sizeof(cap->driver), "%s",
> -		dev_name(vpbe_dev->pdev));
> -	strscpy(cap->card, vpbe_dev->cfg->module_name, sizeof(cap->card));
> -
> -	return 0;
> -}
> -
> -static int vpbe_display_s_selection(struct file *file, void *priv,
> -			     struct v4l2_selection *sel)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_display *disp_dev = layer->disp_dev;
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -	struct osd_layer_config *cfg = &layer->layer_info.config;
> -	struct osd_state *osd_device = disp_dev->osd_device;
> -	struct v4l2_rect rect = sel->r;
> -	int ret;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -		"VIDIOC_S_SELECTION, layer id = %d\n", layer->device_id);
> -
> -	if (sel->type != V4L2_BUF_TYPE_VIDEO_OUTPUT ||
> -	    sel->target != V4L2_SEL_TGT_CROP)
> -		return -EINVAL;
> -
> -	if (rect.top < 0)
> -		rect.top = 0;
> -	if (rect.left < 0)
> -		rect.left = 0;
> -
> -	vpbe_disp_check_window_params(disp_dev, &rect);
> -
> -	osd_device->ops.get_layer_config(osd_device,
> -			layer->layer_info.id, cfg);
> -
> -	vpbe_disp_calculate_scale_factor(disp_dev, layer,
> -					rect.width,
> -					rect.height);
> -	vpbe_disp_adj_position(disp_dev, layer, rect.top,
> -					rect.left);
> -	ret = osd_device->ops.set_layer_config(osd_device,
> -				layer->layer_info.id, cfg);
> -	if (ret < 0) {
> -		v4l2_err(&vpbe_dev->v4l2_dev,
> -			"Error in set layer config:\n");
> -		return -EINVAL;
> -	}
> -
> -	/* apply zooming and h or v expansion */
> -	osd_device->ops.set_zoom(osd_device,
> -			layer->layer_info.id,
> -			layer->layer_info.h_zoom,
> -			layer->layer_info.v_zoom);
> -	ret = osd_device->ops.set_vid_expansion(osd_device,
> -			layer->layer_info.h_exp,
> -			layer->layer_info.v_exp);
> -	if (ret < 0) {
> -		v4l2_err(&vpbe_dev->v4l2_dev,
> -		"Error in set vid expansion:\n");
> -		return -EINVAL;
> -	}
> -
> -	if ((layer->layer_info.h_zoom != ZOOM_X1) ||
> -		(layer->layer_info.v_zoom != ZOOM_X1) ||
> -		(layer->layer_info.h_exp != H_EXP_OFF) ||
> -		(layer->layer_info.v_exp != V_EXP_OFF))
> -		/* Enable expansion filter */
> -		osd_device->ops.set_interpolation_filter(osd_device, 1);
> -	else
> -		osd_device->ops.set_interpolation_filter(osd_device, 0);
> -
> -	sel->r = rect;
> -	return 0;
> -}
> -
> -static int vpbe_display_g_selection(struct file *file, void *priv,
> -				    struct v4l2_selection *sel)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct osd_layer_config *cfg = &layer->layer_info.config;
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -	struct osd_state *osd_device = layer->disp_dev->osd_device;
> -	struct v4l2_rect *rect = &sel->r;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -			"VIDIOC_G_SELECTION, layer id = %d\n",
> -			layer->device_id);
> -
> -	if (sel->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> -		return -EINVAL;
> -
> -	switch (sel->target) {
> -	case V4L2_SEL_TGT_CROP:
> -		osd_device->ops.get_layer_config(osd_device,
> -						 layer->layer_info.id, cfg);
> -		rect->top = cfg->ypos;
> -		rect->left = cfg->xpos;
> -		rect->width = cfg->xsize;
> -		rect->height = cfg->ysize;
> -		break;
> -	case V4L2_SEL_TGT_CROP_DEFAULT:
> -	case V4L2_SEL_TGT_CROP_BOUNDS:
> -		rect->left = 0;
> -		rect->top = 0;
> -		rect->width = vpbe_dev->current_timings.xres;
> -		rect->height = vpbe_dev->current_timings.yres;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int vpbe_display_g_pixelaspect(struct file *file, void *priv,
> -				      int type, struct v4l2_fract *f)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "VIDIOC_CROPCAP ioctl\n");
> -
> -	if (type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> -		return -EINVAL;
> -
> -	*f = vpbe_dev->current_timings.aspect;
> -	return 0;
> -}
> -
> -static int vpbe_display_g_fmt(struct file *file, void *priv,
> -				struct v4l2_format *fmt)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -			"VIDIOC_G_FMT, layer id = %d\n",
> -			layer->device_id);
> -
> -	/* If buffer type is video output */
> -	if (V4L2_BUF_TYPE_VIDEO_OUTPUT != fmt->type) {
> -		v4l2_err(&vpbe_dev->v4l2_dev, "invalid type\n");
> -		return -EINVAL;
> -	}
> -	/* Fill in the information about format */
> -	fmt->fmt.pix = layer->pix_fmt;
> -
> -	return 0;
> -}
> -
> -static int vpbe_display_enum_fmt(struct file *file, void  *priv,
> -				   struct v4l2_fmtdesc *fmt)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -				"VIDIOC_ENUM_FMT, layer id = %d\n",
> -				layer->device_id);
> -	if (fmt->index > 1) {
> -		v4l2_err(&vpbe_dev->v4l2_dev, "Invalid format index\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Fill in the information about format */
> -	if (fmt->index == 0)
> -		fmt->pixelformat = V4L2_PIX_FMT_UYVY;
> -	else
> -		fmt->pixelformat = V4L2_PIX_FMT_NV12;
> -
> -	return 0;
> -}
> -
> -static int vpbe_display_s_fmt(struct file *file, void *priv,
> -				struct v4l2_format *fmt)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_display *disp_dev = layer->disp_dev;
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -	struct osd_layer_config *cfg  = &layer->layer_info.config;
> -	struct v4l2_pix_format *pixfmt = &fmt->fmt.pix;
> -	struct osd_state *osd_device = disp_dev->osd_device;
> -	int ret;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -			"VIDIOC_S_FMT, layer id = %d\n",
> -			layer->device_id);
> -
> -	if (vb2_is_busy(&layer->buffer_queue))
> -		return -EBUSY;
> -
> -	if (V4L2_BUF_TYPE_VIDEO_OUTPUT != fmt->type) {
> -		v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "invalid type\n");
> -		return -EINVAL;
> -	}
> -	/* Check for valid pixel format */
> -	ret = vpbe_try_format(disp_dev, pixfmt, 1);
> -	if (ret)
> -		return ret;
> -
> -	/* YUV420 is requested, check availability of the
> -	other video window */
> -
> -	layer->pix_fmt = *pixfmt;
> -	if (pixfmt->pixelformat == V4L2_PIX_FMT_NV12) {
> -		struct vpbe_layer *otherlayer;
> -
> -		otherlayer = _vpbe_display_get_other_win_layer(disp_dev, layer);
> -		/* if other layer is available, only
> -		 * claim it, do not configure it
> -		 */
> -		ret = osd_device->ops.request_layer(osd_device,
> -						    otherlayer->layer_info.id);
> -		if (ret < 0) {
> -			v4l2_err(&vpbe_dev->v4l2_dev,
> -				 "Display Manager failed to allocate layer\n");
> -			return -EBUSY;
> -		}
> -	}
> -
> -	/* Get osd layer config */
> -	osd_device->ops.get_layer_config(osd_device,
> -			layer->layer_info.id, cfg);
> -	/* Store the pixel format in the layer object */
> -	cfg->xsize = pixfmt->width;
> -	cfg->ysize = pixfmt->height;
> -	cfg->line_length = pixfmt->bytesperline;
> -	cfg->ypos = 0;
> -	cfg->xpos = 0;
> -	cfg->interlaced = vpbe_dev->current_timings.interlaced;
> -
> -	if (V4L2_PIX_FMT_UYVY == pixfmt->pixelformat)
> -		cfg->pixfmt = PIXFMT_YCBCRI;
> -
> -	/* Change of the default pixel format for both video windows */
> -	if (V4L2_PIX_FMT_NV12 == pixfmt->pixelformat) {
> -		struct vpbe_layer *otherlayer;
> -		cfg->pixfmt = PIXFMT_NV12;
> -		otherlayer = _vpbe_display_get_other_win_layer(disp_dev,
> -								layer);
> -		otherlayer->layer_info.config.pixfmt = PIXFMT_NV12;
> -	}
> -
> -	/* Set the layer config in the osd window */
> -	ret = osd_device->ops.set_layer_config(osd_device,
> -				layer->layer_info.id, cfg);
> -	if (ret < 0) {
> -		v4l2_err(&vpbe_dev->v4l2_dev,
> -				"Error in S_FMT params:\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Readback and fill the local copy of current pix format */
> -	osd_device->ops.get_layer_config(osd_device,
> -			layer->layer_info.id, cfg);
> -
> -	return 0;
> -}
> -
> -static int vpbe_display_try_fmt(struct file *file, void *priv,
> -				  struct v4l2_format *fmt)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_display *disp_dev = layer->disp_dev;
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -	struct v4l2_pix_format *pixfmt = &fmt->fmt.pix;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "VIDIOC_TRY_FMT\n");
> -
> -	if (V4L2_BUF_TYPE_VIDEO_OUTPUT != fmt->type) {
> -		v4l2_err(&vpbe_dev->v4l2_dev, "invalid type\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Check for valid field format */
> -	return  vpbe_try_format(disp_dev, pixfmt, 0);
> -
> -}
> -
> -/*
> - * vpbe_display_s_std - Set the given standard in the encoder
> - *
> - * Sets the standard if supported by the current encoder. Return the status.
> - * 0 - success & -EINVAL on error
> - */
> -static int vpbe_display_s_std(struct file *file, void *priv,
> -				v4l2_std_id std_id)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -	int ret;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "VIDIOC_S_STD\n");
> -
> -	if (vb2_is_busy(&layer->buffer_queue))
> -		return -EBUSY;
> -
> -	if (vpbe_dev->ops.s_std) {
> -		ret = vpbe_dev->ops.s_std(vpbe_dev, std_id);
> -		if (ret) {
> -			v4l2_err(&vpbe_dev->v4l2_dev,
> -			"Failed to set standard for sub devices\n");
> -			return -EINVAL;
> -		}
> -	} else {
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * vpbe_display_g_std - Get the standard in the current encoder
> - *
> - * Get the standard in the current encoder. Return the status. 0 - success
> - * -EINVAL on error
> - */
> -static int vpbe_display_g_std(struct file *file, void *priv,
> -				v4l2_std_id *std_id)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,	"VIDIOC_G_STD\n");
> -
> -	/* Get the standard from the current encoder */
> -	if (vpbe_dev->current_timings.timings_type & VPBE_ENC_STD) {
> -		*std_id = vpbe_dev->current_timings.std_id;
> -		return 0;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -/*
> - * vpbe_display_enum_output - enumerate outputs
> - *
> - * Enumerates the outputs available at the vpbe display
> - * returns the status, -EINVAL if end of output list
> - */
> -static int vpbe_display_enum_output(struct file *file, void *priv,
> -				    struct v4l2_output *output)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -	int ret;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,	"VIDIOC_ENUM_OUTPUT\n");
> -
> -	/* Enumerate outputs */
> -	if (!vpbe_dev->ops.enum_outputs)
> -		return -EINVAL;
> -
> -	ret = vpbe_dev->ops.enum_outputs(vpbe_dev, output);
> -	if (ret) {
> -		v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -			"Failed to enumerate outputs\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * vpbe_display_s_output - Set output to
> - * the output specified by the index
> - */
> -static int vpbe_display_s_output(struct file *file, void *priv,
> -				unsigned int i)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -	int ret;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,	"VIDIOC_S_OUTPUT\n");
> -
> -	if (vb2_is_busy(&layer->buffer_queue))
> -		return -EBUSY;
> -
> -	if (!vpbe_dev->ops.set_output)
> -		return -EINVAL;
> -
> -	ret = vpbe_dev->ops.set_output(vpbe_dev, i);
> -	if (ret) {
> -		v4l2_err(&vpbe_dev->v4l2_dev,
> -			"Failed to set output for sub devices\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * vpbe_display_g_output - Get output from subdevice
> - * for a given by the index
> - */
> -static int vpbe_display_g_output(struct file *file, void *priv,
> -				unsigned int *i)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "VIDIOC_G_OUTPUT\n");
> -	/* Get the standard from the current encoder */
> -	*i = vpbe_dev->current_out_index;
> -
> -	return 0;
> -}
> -
> -/*
> - * vpbe_display_enum_dv_timings - Enumerate the dv timings
> - *
> - * enum the timings in the current encoder. Return the status. 0 - success
> - * -EINVAL on error
> - */
> -static int
> -vpbe_display_enum_dv_timings(struct file *file, void *priv,
> -			struct v4l2_enum_dv_timings *timings)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -	int ret;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "VIDIOC_ENUM_DV_TIMINGS\n");
> -
> -	/* Enumerate outputs */
> -	if (!vpbe_dev->ops.enum_dv_timings)
> -		return -EINVAL;
> -
> -	ret = vpbe_dev->ops.enum_dv_timings(vpbe_dev, timings);
> -	if (ret) {
> -		v4l2_err(&vpbe_dev->v4l2_dev,
> -			"Failed to enumerate dv timings info\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * vpbe_display_s_dv_timings - Set the dv timings
> - *
> - * Set the timings in the current encoder. Return the status. 0 - success
> - * -EINVAL on error
> - */
> -static int
> -vpbe_display_s_dv_timings(struct file *file, void *priv,
> -				struct v4l2_dv_timings *timings)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -	int ret;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "VIDIOC_S_DV_TIMINGS\n");
> -
> -	if (vb2_is_busy(&layer->buffer_queue))
> -		return -EBUSY;
> -
> -	/* Set the given standard in the encoder */
> -	if (!vpbe_dev->ops.s_dv_timings)
> -		return -EINVAL;
> -
> -	ret = vpbe_dev->ops.s_dv_timings(vpbe_dev, timings);
> -	if (ret) {
> -		v4l2_err(&vpbe_dev->v4l2_dev,
> -			"Failed to set the dv timings info\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * vpbe_display_g_dv_timings - Set the dv timings
> - *
> - * Get the timings in the current encoder. Return the status. 0 - success
> - * -EINVAL on error
> - */
> -static int
> -vpbe_display_g_dv_timings(struct file *file, void *priv,
> -				struct v4l2_dv_timings *dv_timings)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_device *vpbe_dev = layer->disp_dev->vpbe_dev;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "VIDIOC_G_DV_TIMINGS\n");
> -
> -	/* Get the given standard in the encoder */
> -
> -	if (vpbe_dev->current_timings.timings_type &
> -				VPBE_ENC_DV_TIMINGS) {
> -		*dv_timings = vpbe_dev->current_timings.dv_timings;
> -	} else {
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * vpbe_display_open()
> - * It creates object of file handle structure and stores it in private_data
> - * member of filepointer
> - */
> -static int vpbe_display_open(struct file *file)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct vpbe_display *disp_dev = layer->disp_dev;
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -	struct osd_state *osd_device = disp_dev->osd_device;
> -	int err;
> -
> -	/* creating context for file descriptor */
> -	err = v4l2_fh_open(file);
> -	if (err) {
> -		v4l2_err(&vpbe_dev->v4l2_dev, "v4l2_fh_open failed\n");
> -		return err;
> -	}
> -
> -	/* leaving if layer is already initialized */
> -	if (!v4l2_fh_is_singular_file(file))
> -		return err;
> -
> -	if (!layer->usrs) {
> -		if (mutex_lock_interruptible(&layer->opslock))
> -			return -ERESTARTSYS;
> -		/* First claim the layer for this device */
> -		err = osd_device->ops.request_layer(osd_device,
> -						layer->layer_info.id);
> -		mutex_unlock(&layer->opslock);
> -		if (err < 0) {
> -			/* Couldn't get layer */
> -			v4l2_err(&vpbe_dev->v4l2_dev,
> -				"Display Manager failed to allocate layer\n");
> -			v4l2_fh_release(file);
> -			return -EINVAL;
> -		}
> -	}
> -	/* Increment layer usrs counter */
> -	layer->usrs++;
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev,
> -			"vpbe display device opened successfully\n");
> -	return 0;
> -}
> -
> -/*
> - * vpbe_display_release()
> - * This function deletes buffer queue, frees the buffers and the davinci
> - * display file * handle
> - */
> -static int vpbe_display_release(struct file *file)
> -{
> -	struct vpbe_layer *layer = video_drvdata(file);
> -	struct osd_layer_config *cfg  = &layer->layer_info.config;
> -	struct vpbe_display *disp_dev = layer->disp_dev;
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -	struct osd_state *osd_device = disp_dev->osd_device;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "vpbe_display_release\n");
> -
> -	mutex_lock(&layer->opslock);
> -
> -	osd_device->ops.disable_layer(osd_device,
> -			layer->layer_info.id);
> -	/* Decrement layer usrs counter */
> -	layer->usrs--;
> -	/* If this file handle has initialize encoder device, reset it */
> -	if (!layer->usrs) {
> -		if (cfg->pixfmt == PIXFMT_NV12) {
> -			struct vpbe_layer *otherlayer;
> -			otherlayer =
> -			_vpbe_display_get_other_win_layer(disp_dev, layer);
> -			osd_device->ops.disable_layer(osd_device,
> -					otherlayer->layer_info.id);
> -			osd_device->ops.release_layer(osd_device,
> -					otherlayer->layer_info.id);
> -		}
> -		osd_device->ops.disable_layer(osd_device,
> -				layer->layer_info.id);
> -		osd_device->ops.release_layer(osd_device,
> -				layer->layer_info.id);
> -	}
> -
> -	_vb2_fop_release(file, NULL);
> -	mutex_unlock(&layer->opslock);
> -
> -	disp_dev->cbcr_ofst = 0;
> -
> -	return 0;
> -}
> -
> -/* vpbe capture ioctl operations */
> -static const struct v4l2_ioctl_ops vpbe_ioctl_ops = {
> -	.vidioc_querycap	 = vpbe_display_querycap,
> -	.vidioc_g_fmt_vid_out    = vpbe_display_g_fmt,
> -	.vidioc_enum_fmt_vid_out = vpbe_display_enum_fmt,
> -	.vidioc_s_fmt_vid_out    = vpbe_display_s_fmt,
> -	.vidioc_try_fmt_vid_out  = vpbe_display_try_fmt,
> -
> -	.vidioc_reqbufs		 = vb2_ioctl_reqbufs,
> -	.vidioc_create_bufs	 = vb2_ioctl_create_bufs,
> -	.vidioc_querybuf	 = vb2_ioctl_querybuf,
> -	.vidioc_qbuf		 = vb2_ioctl_qbuf,
> -	.vidioc_dqbuf		 = vb2_ioctl_dqbuf,
> -	.vidioc_streamon	 = vb2_ioctl_streamon,
> -	.vidioc_streamoff	 = vb2_ioctl_streamoff,
> -	.vidioc_expbuf		 = vb2_ioctl_expbuf,
> -
> -	.vidioc_g_pixelaspect	 = vpbe_display_g_pixelaspect,
> -	.vidioc_g_selection	 = vpbe_display_g_selection,
> -	.vidioc_s_selection	 = vpbe_display_s_selection,
> -
> -	.vidioc_s_std		 = vpbe_display_s_std,
> -	.vidioc_g_std		 = vpbe_display_g_std,
> -
> -	.vidioc_enum_output	 = vpbe_display_enum_output,
> -	.vidioc_s_output	 = vpbe_display_s_output,
> -	.vidioc_g_output	 = vpbe_display_g_output,
> -
> -	.vidioc_s_dv_timings	 = vpbe_display_s_dv_timings,
> -	.vidioc_g_dv_timings	 = vpbe_display_g_dv_timings,
> -	.vidioc_enum_dv_timings	 = vpbe_display_enum_dv_timings,
> -};
> -
> -static const struct v4l2_file_operations vpbe_fops = {
> -	.owner = THIS_MODULE,
> -	.open = vpbe_display_open,
> -	.release = vpbe_display_release,
> -	.unlocked_ioctl = video_ioctl2,
> -	.mmap = vb2_fop_mmap,
> -	.poll =  vb2_fop_poll,
> -};
> -
> -static int vpbe_device_get(struct device *dev, void *data)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct vpbe_display *vpbe_disp  = data;
> -
> -	if (strcmp("vpbe_controller", pdev->name) == 0)
> -		vpbe_disp->vpbe_dev = platform_get_drvdata(pdev);
> -
> -	if (strstr(pdev->name, "vpbe-osd"))
> -		vpbe_disp->osd_device = platform_get_drvdata(pdev);
> -
> -	return 0;
> -}
> -
> -static int init_vpbe_layer(int i, struct vpbe_display *disp_dev,
> -			   struct platform_device *pdev)
> -{
> -	struct vpbe_layer *vpbe_display_layer = NULL;
> -	struct video_device *vbd = NULL;
> -
> -	/* Allocate memory for four plane display objects */
> -	disp_dev->dev[i] = kzalloc(sizeof(*disp_dev->dev[i]), GFP_KERNEL);
> -	if (!disp_dev->dev[i])
> -		return  -ENOMEM;
> -
> -	spin_lock_init(&disp_dev->dev[i]->irqlock);
> -	mutex_init(&disp_dev->dev[i]->opslock);
> -
> -	/* Get the pointer to the layer object */
> -	vpbe_display_layer = disp_dev->dev[i];
> -	vbd = &vpbe_display_layer->video_dev;
> -	/* Initialize field of video device */
> -	vbd->release	= video_device_release_empty;
> -	vbd->fops	= &vpbe_fops;
> -	vbd->ioctl_ops	= &vpbe_ioctl_ops;
> -	vbd->minor	= -1;
> -	vbd->v4l2_dev   = &disp_dev->vpbe_dev->v4l2_dev;
> -	vbd->lock	= &vpbe_display_layer->opslock;
> -	vbd->vfl_dir	= VFL_DIR_TX;
> -	vbd->device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
> -
> -	if (disp_dev->vpbe_dev->current_timings.timings_type &
> -			VPBE_ENC_STD)
> -		vbd->tvnorms = (V4L2_STD_525_60 | V4L2_STD_625_50);
> -
> -	snprintf(vbd->name, sizeof(vbd->name),
> -			"DaVinci_VPBE Display_DRIVER_V%d.%d.%d",
> -			(VPBE_DISPLAY_VERSION_CODE >> 16) & 0xff,
> -			(VPBE_DISPLAY_VERSION_CODE >> 8) & 0xff,
> -			(VPBE_DISPLAY_VERSION_CODE) & 0xff);
> -
> -	vpbe_display_layer->device_id = i;
> -
> -	vpbe_display_layer->layer_info.id =
> -		((i == VPBE_DISPLAY_DEVICE_0) ? WIN_VID0 : WIN_VID1);
> -
> -
> -	return 0;
> -}
> -
> -static int register_device(struct vpbe_layer *vpbe_display_layer,
> -			   struct vpbe_display *disp_dev,
> -			   struct platform_device *pdev)
> -{
> -	int err;
> -
> -	v4l2_info(&disp_dev->vpbe_dev->v4l2_dev,
> -		  "Trying to register VPBE display device.\n");
> -	v4l2_info(&disp_dev->vpbe_dev->v4l2_dev,
> -		  "layer=%p,layer->video_dev=%p\n",
> -		  vpbe_display_layer,
> -		  &vpbe_display_layer->video_dev);
> -
> -	vpbe_display_layer->video_dev.queue = &vpbe_display_layer->buffer_queue;
> -	err = video_register_device(&vpbe_display_layer->video_dev,
> -				    VFL_TYPE_VIDEO,
> -				    -1);
> -	if (err)
> -		return -ENODEV;
> -
> -	vpbe_display_layer->disp_dev = disp_dev;
> -	/* set the driver data in platform device */
> -	platform_set_drvdata(pdev, disp_dev);
> -	video_set_drvdata(&vpbe_display_layer->video_dev,
> -			  vpbe_display_layer);
> -
> -	return 0;
> -}
> -
> -
> -
> -/*
> - * vpbe_display_probe()
> - * This function creates device entries by register itself to the V4L2 driver
> - * and initializes fields of each layer objects
> - */
> -static int vpbe_display_probe(struct platform_device *pdev)
> -{
> -	struct vpbe_display *disp_dev;
> -	struct v4l2_device *v4l2_dev;
> -	struct resource *res = NULL;
> -	struct vb2_queue *q;
> -	int k;
> -	int i;
> -	int err;
> -	int irq;
> -
> -	printk(KERN_DEBUG "vpbe_display_probe\n");
> -	/* Allocate memory for vpbe_display */
> -	disp_dev = devm_kzalloc(&pdev->dev, sizeof(*disp_dev), GFP_KERNEL);
> -	if (!disp_dev)
> -		return -ENOMEM;
> -
> -	spin_lock_init(&disp_dev->dma_queue_lock);
> -	/*
> -	 * Scan all the platform devices to find the vpbe
> -	 * controller device and get the vpbe_dev object
> -	 */
> -	err = bus_for_each_dev(&platform_bus_type, NULL, disp_dev,
> -			vpbe_device_get);
> -	if (err < 0)
> -		return err;
> -
> -	v4l2_dev = &disp_dev->vpbe_dev->v4l2_dev;
> -	/* Initialize the vpbe display controller */
> -	if (disp_dev->vpbe_dev->ops.initialize) {
> -		err = disp_dev->vpbe_dev->ops.initialize(&pdev->dev,
> -							 disp_dev->vpbe_dev);
> -		if (err) {
> -			v4l2_err(v4l2_dev, "Error initing vpbe\n");
> -			err = -ENOMEM;
> -			goto probe_out;
> -		}
> -	}
> -
> -	for (i = 0; i < VPBE_DISPLAY_MAX_DEVICES; i++) {
> -		if (init_vpbe_layer(i, disp_dev, pdev)) {
> -			err = -ENODEV;
> -			goto probe_out;
> -		}
> -	}
> -
> -	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res) {
> -		v4l2_err(v4l2_dev, "Unable to get VENC interrupt resource\n");
> -		err = -ENODEV;
> -		goto probe_out;
> -	}
> -
> -	irq = res->start;
> -	err = devm_request_irq(&pdev->dev, irq, venc_isr, 0,
> -			       VPBE_DISPLAY_DRIVER, disp_dev);
> -	if (err) {
> -		v4l2_err(v4l2_dev, "VPBE IRQ request failed\n");
> -		goto probe_out;
> -	}
> -
> -	for (i = 0; i < VPBE_DISPLAY_MAX_DEVICES; i++) {
> -		/* initialize vb2 queue */
> -		q = &disp_dev->dev[i]->buffer_queue;
> -		memset(q, 0, sizeof(*q));
> -		q->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
> -		q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
> -		q->drv_priv = disp_dev->dev[i];
> -		q->ops = &video_qops;
> -		q->mem_ops = &vb2_dma_contig_memops;
> -		q->buf_struct_size = sizeof(struct vpbe_disp_buffer);
> -		q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> -		q->min_buffers_needed = 1;
> -		q->lock = &disp_dev->dev[i]->opslock;
> -		q->dev = disp_dev->vpbe_dev->pdev;
> -		err = vb2_queue_init(q);
> -		if (err) {
> -			v4l2_err(v4l2_dev, "vb2_queue_init() failed\n");
> -			goto probe_out;
> -		}
> -
> -		INIT_LIST_HEAD(&disp_dev->dev[i]->dma_queue);
> -
> -		if (register_device(disp_dev->dev[i], disp_dev, pdev)) {
> -			err = -ENODEV;
> -			goto probe_out;
> -		}
> -	}
> -
> -	v4l2_dbg(1, debug, v4l2_dev,
> -		 "Successfully completed the probing of vpbe v4l2 device\n");
> -
> -	return 0;
> -
> -probe_out:
> -	for (k = 0; k < VPBE_DISPLAY_MAX_DEVICES; k++) {
> -		/* Unregister video device */
> -		if (disp_dev->dev[k]) {
> -			video_unregister_device(&disp_dev->dev[k]->video_dev);
> -			kfree(disp_dev->dev[k]);
> -		}
> -	}
> -	return err;
> -}
> -
> -/*
> - * vpbe_display_remove()
> - * It un-register hardware layer from V4L2 driver
> - */
> -static int vpbe_display_remove(struct platform_device *pdev)
> -{
> -	struct vpbe_layer *vpbe_display_layer;
> -	struct vpbe_display *disp_dev = platform_get_drvdata(pdev);
> -	struct vpbe_device *vpbe_dev = disp_dev->vpbe_dev;
> -	int i;
> -
> -	v4l2_dbg(1, debug, &vpbe_dev->v4l2_dev, "vpbe_display_remove\n");
> -
> -	/* deinitialize the vpbe display controller */
> -	if (vpbe_dev->ops.deinitialize)
> -		vpbe_dev->ops.deinitialize(&pdev->dev, vpbe_dev);
> -	/* un-register device */
> -	for (i = 0; i < VPBE_DISPLAY_MAX_DEVICES; i++) {
> -		/* Get the pointer to the layer object */
> -		vpbe_display_layer = disp_dev->dev[i];
> -		/* Unregister video device */
> -		video_unregister_device(&vpbe_display_layer->video_dev);
> -
> -	}
> -	for (i = 0; i < VPBE_DISPLAY_MAX_DEVICES; i++) {
> -		kfree(disp_dev->dev[i]);
> -		disp_dev->dev[i] = NULL;
> -	}
> -
> -	return 0;
> -}
> -
> -static struct platform_driver vpbe_display_driver = {
> -	.driver = {
> -		.name = VPBE_DISPLAY_DRIVER,
> -		.bus = &platform_bus_type,
> -	},
> -	.probe = vpbe_display_probe,
> -	.remove = vpbe_display_remove,
> -};
> -
> -module_platform_driver(vpbe_display_driver);
> -
> -MODULE_DESCRIPTION("TI DM644x/DM355/DM365 VPBE Display controller");
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Texas Instruments");
> diff --git a/drivers/media/platform/ti/davinci/vpbe_osd.c b/drivers/media/platform/ti/davinci/vpbe_osd.c
> deleted file mode 100644
> index 32f7ef547c82..000000000000
> --- a/drivers/media/platform/ti/davinci/vpbe_osd.c
> +++ /dev/null
> @@ -1,1582 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2007-2010 Texas Instruments Inc
> - * Copyright (C) 2007 MontaVista Software, Inc.
> - *
> - * Andy Lowe (alowe@mvista.com), MontaVista Software
> - * - Initial version
> - * Murali Karicheri (mkaricheri@gmail.com), Texas Instruments Ltd.
> - * - ported to sub device interface
> - */
> -#include <linux/module.h>
> -#include <linux/mod_devicetable.h>
> -#include <linux/kernel.h>
> -#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -#include <linux/clk.h>
> -#include <linux/slab.h>
> -
> -#include <media/davinci/vpss.h>
> -#include <media/v4l2-device.h>
> -#include <media/davinci/vpbe_types.h>
> -#include <media/davinci/vpbe_osd.h>
> -
> -#include <linux/io.h>
> -#include "vpbe_osd_regs.h"
> -
> -#define MODULE_NAME	"davinci-vpbe-osd"
> -
> -static const struct platform_device_id vpbe_osd_devtype[] = {
> -	{
> -		.name = DM644X_VPBE_OSD_SUBDEV_NAME,
> -		.driver_data = VPBE_VERSION_1,
> -	}, {
> -		.name = DM365_VPBE_OSD_SUBDEV_NAME,
> -		.driver_data = VPBE_VERSION_2,
> -	}, {
> -		.name = DM355_VPBE_OSD_SUBDEV_NAME,
> -		.driver_data = VPBE_VERSION_3,
> -	},
> -	{
> -		/* sentinel */
> -	}
> -};
> -
> -MODULE_DEVICE_TABLE(platform, vpbe_osd_devtype);
> -
> -/* register access routines */
> -static inline u32 __always_unused osd_read(struct osd_state *sd, u32 offset)
> -{
> -	struct osd_state *osd = sd;
> -
> -	return readl(osd->osd_base + offset);
> -}
> -
> -static inline u32 osd_write(struct osd_state *sd, u32 val, u32 offset)
> -{
> -	struct osd_state *osd = sd;
> -
> -	writel(val, osd->osd_base + offset);
> -
> -	return val;
> -}
> -
> -static inline u32 osd_set(struct osd_state *sd, u32 mask, u32 offset)
> -{
> -	struct osd_state *osd = sd;
> -
> -	void __iomem *addr = osd->osd_base + offset;
> -	u32 val = readl(addr) | mask;
> -
> -	writel(val, addr);
> -
> -	return val;
> -}
> -
> -static inline u32 osd_clear(struct osd_state *sd, u32 mask, u32 offset)
> -{
> -	struct osd_state *osd = sd;
> -
> -	void __iomem *addr = osd->osd_base + offset;
> -	u32 val = readl(addr) & ~mask;
> -
> -	writel(val, addr);
> -
> -	return val;
> -}
> -
> -static inline u32 osd_modify(struct osd_state *sd, u32 mask, u32 val,
> -				 u32 offset)
> -{
> -	struct osd_state *osd = sd;
> -
> -	void __iomem *addr = osd->osd_base + offset;
> -	u32 new_val = (readl(addr) & ~mask) | (val & mask);
> -
> -	writel(new_val, addr);
> -
> -	return new_val;
> -}
> -
> -/* define some macros for layer and pixfmt classification */
> -#define is_osd_win(layer) (((layer) == WIN_OSD0) || ((layer) == WIN_OSD1))
> -#define is_vid_win(layer) (((layer) == WIN_VID0) || ((layer) == WIN_VID1))
> -#define is_rgb_pixfmt(pixfmt) \
> -	(((pixfmt) == PIXFMT_RGB565) || ((pixfmt) == PIXFMT_RGB888))
> -#define is_yc_pixfmt(pixfmt) \
> -	(((pixfmt) == PIXFMT_YCBCRI) || ((pixfmt) == PIXFMT_YCRCBI) || \
> -	((pixfmt) == PIXFMT_NV12))
> -#define MAX_WIN_SIZE OSD_VIDWIN0XP_V0X
> -#define MAX_LINE_LENGTH (OSD_VIDWIN0OFST_V0LO << 5)
> -
> -/**
> - * _osd_dm6446_vid0_pingpong() - field inversion fix for DM6446
> - * @sd: ptr to struct osd_state
> - * @field_inversion: inversion flag
> - * @fb_base_phys: frame buffer address
> - * @lconfig: ptr to layer config
> - *
> - * This routine implements a workaround for the field signal inversion silicon
> - * erratum described in Advisory 1.3.8 for the DM6446.  The fb_base_phys and
> - * lconfig parameters apply to the vid0 window.  This routine should be called
> - * whenever the vid0 layer configuration or start address is modified, or when
> - * the OSD field inversion setting is modified.
> - * Returns: 1 if the ping-pong buffers need to be toggled in the vsync isr, or
> - *          0 otherwise
> - */
> -static int _osd_dm6446_vid0_pingpong(struct osd_state *sd,
> -				     int field_inversion,
> -				     unsigned long fb_base_phys,
> -				     const struct osd_layer_config *lconfig)
> -{
> -	struct osd_platform_data *pdata;
> -
> -	pdata = (struct osd_platform_data *)sd->dev->platform_data;
> -	if (pdata != NULL && pdata->field_inv_wa_enable) {
> -
> -		if (!field_inversion || !lconfig->interlaced) {
> -			osd_write(sd, fb_base_phys & ~0x1F, OSD_VIDWIN0ADR);
> -			osd_write(sd, fb_base_phys & ~0x1F, OSD_PPVWIN0ADR);
> -			osd_modify(sd, OSD_MISCCTL_PPSW | OSD_MISCCTL_PPRV, 0,
> -				   OSD_MISCCTL);
> -			return 0;
> -		} else {
> -			unsigned miscctl = OSD_MISCCTL_PPRV;
> -
> -			osd_write(sd,
> -				(fb_base_phys & ~0x1F) - lconfig->line_length,
> -				OSD_VIDWIN0ADR);
> -			osd_write(sd,
> -				(fb_base_phys & ~0x1F) + lconfig->line_length,
> -				OSD_PPVWIN0ADR);
> -			osd_modify(sd,
> -				OSD_MISCCTL_PPSW | OSD_MISCCTL_PPRV, miscctl,
> -				OSD_MISCCTL);
> -
> -			return 1;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static void _osd_set_field_inversion(struct osd_state *sd, int enable)
> -{
> -	unsigned fsinv = 0;
> -
> -	if (enable)
> -		fsinv = OSD_MODE_FSINV;
> -
> -	osd_modify(sd, OSD_MODE_FSINV, fsinv, OSD_MODE);
> -}
> -
> -static void _osd_set_blink_attribute(struct osd_state *sd, int enable,
> -				     enum osd_blink_interval blink)
> -{
> -	u32 osdatrmd = 0;
> -
> -	if (enable) {
> -		osdatrmd |= OSD_OSDATRMD_BLNK;
> -		osdatrmd |= blink << OSD_OSDATRMD_BLNKINT_SHIFT;
> -	}
> -	/* caller must ensure that OSD1 is configured in attribute mode */
> -	osd_modify(sd, OSD_OSDATRMD_BLNKINT | OSD_OSDATRMD_BLNK, osdatrmd,
> -		  OSD_OSDATRMD);
> -}
> -
> -static void _osd_set_rom_clut(struct osd_state *sd,
> -			      enum osd_rom_clut rom_clut)
> -{
> -	if (rom_clut == ROM_CLUT0)
> -		osd_clear(sd, OSD_MISCCTL_RSEL, OSD_MISCCTL);
> -	else
> -		osd_set(sd, OSD_MISCCTL_RSEL, OSD_MISCCTL);
> -}
> -
> -static void _osd_set_palette_map(struct osd_state *sd,
> -				 enum osd_win_layer osdwin,
> -				 unsigned char pixel_value,
> -				 unsigned char clut_index,
> -				 enum osd_pix_format pixfmt)
> -{
> -	static const int map_2bpp[] = { 0, 5, 10, 15 };
> -	static const int map_1bpp[] = { 0, 15 };
> -	int bmp_offset;
> -	int bmp_shift;
> -	int bmp_mask;
> -	int bmp_reg;
> -
> -	switch (pixfmt) {
> -	case PIXFMT_1BPP:
> -		bmp_reg = map_1bpp[pixel_value & 0x1];
> -		break;
> -	case PIXFMT_2BPP:
> -		bmp_reg = map_2bpp[pixel_value & 0x3];
> -		break;
> -	case PIXFMT_4BPP:
> -		bmp_reg = pixel_value & 0xf;
> -		break;
> -	default:
> -		return;
> -	}
> -
> -	switch (osdwin) {
> -	case OSDWIN_OSD0:
> -		bmp_offset = OSD_W0BMP01 + (bmp_reg >> 1) * sizeof(u32);
> -		break;
> -	case OSDWIN_OSD1:
> -		bmp_offset = OSD_W1BMP01 + (bmp_reg >> 1) * sizeof(u32);
> -		break;
> -	default:
> -		return;
> -	}
> -
> -	if (bmp_reg & 1) {
> -		bmp_shift = 8;
> -		bmp_mask = 0xff << 8;
> -	} else {
> -		bmp_shift = 0;
> -		bmp_mask = 0xff;
> -	}
> -
> -	osd_modify(sd, bmp_mask, clut_index << bmp_shift, bmp_offset);
> -}
> -
> -static void _osd_set_rec601_attenuation(struct osd_state *sd,
> -					enum osd_win_layer osdwin, int enable)
> -{
> -	switch (osdwin) {
> -	case OSDWIN_OSD0:
> -		osd_modify(sd, OSD_OSDWIN0MD_ATN0E,
> -			  enable ? OSD_OSDWIN0MD_ATN0E : 0,
> -			  OSD_OSDWIN0MD);
> -		if (sd->vpbe_type == VPBE_VERSION_1)
> -			osd_modify(sd, OSD_OSDWIN0MD_ATN0E,
> -				  enable ? OSD_OSDWIN0MD_ATN0E : 0,
> -				  OSD_OSDWIN0MD);
> -		else if ((sd->vpbe_type == VPBE_VERSION_3) ||
> -			   (sd->vpbe_type == VPBE_VERSION_2))
> -			osd_modify(sd, OSD_EXTMODE_ATNOSD0EN,
> -				  enable ? OSD_EXTMODE_ATNOSD0EN : 0,
> -				  OSD_EXTMODE);
> -		break;
> -	case OSDWIN_OSD1:
> -		osd_modify(sd, OSD_OSDWIN1MD_ATN1E,
> -			  enable ? OSD_OSDWIN1MD_ATN1E : 0,
> -			  OSD_OSDWIN1MD);
> -		if (sd->vpbe_type == VPBE_VERSION_1)
> -			osd_modify(sd, OSD_OSDWIN1MD_ATN1E,
> -				  enable ? OSD_OSDWIN1MD_ATN1E : 0,
> -				  OSD_OSDWIN1MD);
> -		else if ((sd->vpbe_type == VPBE_VERSION_3) ||
> -			   (sd->vpbe_type == VPBE_VERSION_2))
> -			osd_modify(sd, OSD_EXTMODE_ATNOSD1EN,
> -				  enable ? OSD_EXTMODE_ATNOSD1EN : 0,
> -				  OSD_EXTMODE);
> -		break;
> -	}
> -}
> -
> -static void _osd_set_blending_factor(struct osd_state *sd,
> -				     enum osd_win_layer osdwin,
> -				     enum osd_blending_factor blend)
> -{
> -	switch (osdwin) {
> -	case OSDWIN_OSD0:
> -		osd_modify(sd, OSD_OSDWIN0MD_BLND0,
> -			  blend << OSD_OSDWIN0MD_BLND0_SHIFT, OSD_OSDWIN0MD);
> -		break;
> -	case OSDWIN_OSD1:
> -		osd_modify(sd, OSD_OSDWIN1MD_BLND1,
> -			  blend << OSD_OSDWIN1MD_BLND1_SHIFT, OSD_OSDWIN1MD);
> -		break;
> -	}
> -}
> -
> -static void _osd_enable_rgb888_pixblend(struct osd_state *sd,
> -					enum osd_win_layer osdwin)
> -{
> -
> -	osd_modify(sd, OSD_MISCCTL_BLDSEL, 0, OSD_MISCCTL);
> -	switch (osdwin) {
> -	case OSDWIN_OSD0:
> -		osd_modify(sd, OSD_EXTMODE_OSD0BLDCHR,
> -			  OSD_EXTMODE_OSD0BLDCHR, OSD_EXTMODE);
> -		break;
> -	case OSDWIN_OSD1:
> -		osd_modify(sd, OSD_EXTMODE_OSD1BLDCHR,
> -			  OSD_EXTMODE_OSD1BLDCHR, OSD_EXTMODE);
> -		break;
> -	}
> -}
> -
> -static void _osd_enable_color_key(struct osd_state *sd,
> -				  enum osd_win_layer osdwin,
> -				  unsigned colorkey,
> -				  enum osd_pix_format pixfmt)
> -{
> -	switch (pixfmt) {
> -	case PIXFMT_1BPP:
> -	case PIXFMT_2BPP:
> -	case PIXFMT_4BPP:
> -	case PIXFMT_8BPP:
> -		if (sd->vpbe_type == VPBE_VERSION_3) {
> -			switch (osdwin) {
> -			case OSDWIN_OSD0:
> -				osd_modify(sd, OSD_TRANSPBMPIDX_BMP0,
> -					  colorkey <<
> -					  OSD_TRANSPBMPIDX_BMP0_SHIFT,
> -					  OSD_TRANSPBMPIDX);
> -				break;
> -			case OSDWIN_OSD1:
> -				osd_modify(sd, OSD_TRANSPBMPIDX_BMP1,
> -					  colorkey <<
> -					  OSD_TRANSPBMPIDX_BMP1_SHIFT,
> -					  OSD_TRANSPBMPIDX);
> -				break;
> -			}
> -		}
> -		break;
> -	case PIXFMT_RGB565:
> -		if (sd->vpbe_type == VPBE_VERSION_1)
> -			osd_write(sd, colorkey & OSD_TRANSPVAL_RGBTRANS,
> -				  OSD_TRANSPVAL);
> -		else if (sd->vpbe_type == VPBE_VERSION_3)
> -			osd_write(sd, colorkey & OSD_TRANSPVALL_RGBL,
> -				  OSD_TRANSPVALL);
> -		break;
> -	case PIXFMT_YCBCRI:
> -	case PIXFMT_YCRCBI:
> -		if (sd->vpbe_type == VPBE_VERSION_3)
> -			osd_modify(sd, OSD_TRANSPVALU_Y, colorkey,
> -				   OSD_TRANSPVALU);
> -		break;
> -	case PIXFMT_RGB888:
> -		if (sd->vpbe_type == VPBE_VERSION_3) {
> -			osd_write(sd, colorkey & OSD_TRANSPVALL_RGBL,
> -				  OSD_TRANSPVALL);
> -			osd_modify(sd, OSD_TRANSPVALU_RGBU, colorkey >> 16,
> -				  OSD_TRANSPVALU);
> -		}
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	switch (osdwin) {
> -	case OSDWIN_OSD0:
> -		osd_set(sd, OSD_OSDWIN0MD_TE0, OSD_OSDWIN0MD);
> -		break;
> -	case OSDWIN_OSD1:
> -		osd_set(sd, OSD_OSDWIN1MD_TE1, OSD_OSDWIN1MD);
> -		break;
> -	}
> -}
> -
> -static void _osd_disable_color_key(struct osd_state *sd,
> -				   enum osd_win_layer osdwin)
> -{
> -	switch (osdwin) {
> -	case OSDWIN_OSD0:
> -		osd_clear(sd, OSD_OSDWIN0MD_TE0, OSD_OSDWIN0MD);
> -		break;
> -	case OSDWIN_OSD1:
> -		osd_clear(sd, OSD_OSDWIN1MD_TE1, OSD_OSDWIN1MD);
> -		break;
> -	}
> -}
> -
> -static void _osd_set_osd_clut(struct osd_state *sd,
> -			      enum osd_win_layer osdwin,
> -			      enum osd_clut clut)
> -{
> -	u32 winmd = 0;
> -
> -	switch (osdwin) {
> -	case OSDWIN_OSD0:
> -		if (clut == RAM_CLUT)
> -			winmd |= OSD_OSDWIN0MD_CLUTS0;
> -		osd_modify(sd, OSD_OSDWIN0MD_CLUTS0, winmd, OSD_OSDWIN0MD);
> -		break;
> -	case OSDWIN_OSD1:
> -		if (clut == RAM_CLUT)
> -			winmd |= OSD_OSDWIN1MD_CLUTS1;
> -		osd_modify(sd, OSD_OSDWIN1MD_CLUTS1, winmd, OSD_OSDWIN1MD);
> -		break;
> -	}
> -}
> -
> -static void _osd_set_zoom(struct osd_state *sd, enum osd_layer layer,
> -			  enum osd_zoom_factor h_zoom,
> -			  enum osd_zoom_factor v_zoom)
> -{
> -	u32 winmd = 0;
> -
> -	switch (layer) {
> -	case WIN_OSD0:
> -		winmd |= (h_zoom << OSD_OSDWIN0MD_OHZ0_SHIFT);
> -		winmd |= (v_zoom << OSD_OSDWIN0MD_OVZ0_SHIFT);
> -		osd_modify(sd, OSD_OSDWIN0MD_OHZ0 | OSD_OSDWIN0MD_OVZ0, winmd,
> -			  OSD_OSDWIN0MD);
> -		break;
> -	case WIN_VID0:
> -		winmd |= (h_zoom << OSD_VIDWINMD_VHZ0_SHIFT);
> -		winmd |= (v_zoom << OSD_VIDWINMD_VVZ0_SHIFT);
> -		osd_modify(sd, OSD_VIDWINMD_VHZ0 | OSD_VIDWINMD_VVZ0, winmd,
> -			  OSD_VIDWINMD);
> -		break;
> -	case WIN_OSD1:
> -		winmd |= (h_zoom << OSD_OSDWIN1MD_OHZ1_SHIFT);
> -		winmd |= (v_zoom << OSD_OSDWIN1MD_OVZ1_SHIFT);
> -		osd_modify(sd, OSD_OSDWIN1MD_OHZ1 | OSD_OSDWIN1MD_OVZ1, winmd,
> -			  OSD_OSDWIN1MD);
> -		break;
> -	case WIN_VID1:
> -		winmd |= (h_zoom << OSD_VIDWINMD_VHZ1_SHIFT);
> -		winmd |= (v_zoom << OSD_VIDWINMD_VVZ1_SHIFT);
> -		osd_modify(sd, OSD_VIDWINMD_VHZ1 | OSD_VIDWINMD_VVZ1, winmd,
> -			  OSD_VIDWINMD);
> -		break;
> -	}
> -}
> -
> -static void _osd_disable_layer(struct osd_state *sd, enum osd_layer layer)
> -{
> -	switch (layer) {
> -	case WIN_OSD0:
> -		osd_clear(sd, OSD_OSDWIN0MD_OACT0, OSD_OSDWIN0MD);
> -		break;
> -	case WIN_VID0:
> -		osd_clear(sd, OSD_VIDWINMD_ACT0, OSD_VIDWINMD);
> -		break;
> -	case WIN_OSD1:
> -		/* disable attribute mode as well as disabling the window */
> -		osd_clear(sd, OSD_OSDWIN1MD_OASW | OSD_OSDWIN1MD_OACT1,
> -			  OSD_OSDWIN1MD);
> -		break;
> -	case WIN_VID1:
> -		osd_clear(sd, OSD_VIDWINMD_ACT1, OSD_VIDWINMD);
> -		break;
> -	}
> -}
> -
> -static void osd_disable_layer(struct osd_state *sd, enum osd_layer layer)
> -{
> -	struct osd_state *osd = sd;
> -	struct osd_window_state *win = &osd->win[layer];
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&osd->lock, flags);
> -
> -	if (!win->is_enabled) {
> -		spin_unlock_irqrestore(&osd->lock, flags);
> -		return;
> -	}
> -	win->is_enabled = 0;
> -
> -	_osd_disable_layer(sd, layer);
> -
> -	spin_unlock_irqrestore(&osd->lock, flags);
> -}
> -
> -static void _osd_enable_attribute_mode(struct osd_state *sd)
> -{
> -	/* enable attribute mode for OSD1 */
> -	osd_set(sd, OSD_OSDWIN1MD_OASW, OSD_OSDWIN1MD);
> -}
> -
> -static void _osd_enable_layer(struct osd_state *sd, enum osd_layer layer)
> -{
> -	switch (layer) {
> -	case WIN_OSD0:
> -		osd_set(sd, OSD_OSDWIN0MD_OACT0, OSD_OSDWIN0MD);
> -		break;
> -	case WIN_VID0:
> -		osd_set(sd, OSD_VIDWINMD_ACT0, OSD_VIDWINMD);
> -		break;
> -	case WIN_OSD1:
> -		/* enable OSD1 and disable attribute mode */
> -		osd_modify(sd, OSD_OSDWIN1MD_OASW | OSD_OSDWIN1MD_OACT1,
> -			  OSD_OSDWIN1MD_OACT1, OSD_OSDWIN1MD);
> -		break;
> -	case WIN_VID1:
> -		osd_set(sd, OSD_VIDWINMD_ACT1, OSD_VIDWINMD);
> -		break;
> -	}
> -}
> -
> -static int osd_enable_layer(struct osd_state *sd, enum osd_layer layer,
> -			    int otherwin)
> -{
> -	struct osd_state *osd = sd;
> -	struct osd_window_state *win = &osd->win[layer];
> -	struct osd_layer_config *cfg = &win->lconfig;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&osd->lock, flags);
> -
> -	/*
> -	 * use otherwin flag to know this is the other vid window
> -	 * in YUV420 mode, if is, skip this check
> -	 */
> -	if (!otherwin && (!win->is_allocated ||
> -			!win->fb_base_phys ||
> -			!cfg->line_length ||
> -			!cfg->xsize ||
> -			!cfg->ysize)) {
> -		spin_unlock_irqrestore(&osd->lock, flags);
> -		return -1;
> -	}
> -
> -	if (win->is_enabled) {
> -		spin_unlock_irqrestore(&osd->lock, flags);
> -		return 0;
> -	}
> -	win->is_enabled = 1;
> -
> -	if (cfg->pixfmt != PIXFMT_OSD_ATTR)
> -		_osd_enable_layer(sd, layer);
> -	else {
> -		_osd_enable_attribute_mode(sd);
> -		_osd_set_blink_attribute(sd, osd->is_blinking, osd->blink);
> -	}
> -
> -	spin_unlock_irqrestore(&osd->lock, flags);
> -
> -	return 0;
> -}
> -
> -#define OSD_SRC_ADDR_HIGH4	0x7800000
> -#define OSD_SRC_ADDR_HIGH7	0x7F0000
> -#define OSD_SRCADD_OFSET_SFT	23
> -#define OSD_SRCADD_ADD_SFT	16
> -#define OSD_WINADL_MASK		0xFFFF
> -#define OSD_WINOFST_MASK	0x1000
> -#define VPBE_REG_BASE		0x80000000
> -
> -static void _osd_start_layer(struct osd_state *sd, enum osd_layer layer,
> -			     unsigned long fb_base_phys,
> -			     unsigned long cbcr_ofst)
> -{
> -
> -	if (sd->vpbe_type == VPBE_VERSION_1) {
> -		switch (layer) {
> -		case WIN_OSD0:
> -			osd_write(sd, fb_base_phys & ~0x1F, OSD_OSDWIN0ADR);
> -			break;
> -		case WIN_VID0:
> -			osd_write(sd, fb_base_phys & ~0x1F, OSD_VIDWIN0ADR);
> -			break;
> -		case WIN_OSD1:
> -			osd_write(sd, fb_base_phys & ~0x1F, OSD_OSDWIN1ADR);
> -			break;
> -		case WIN_VID1:
> -			osd_write(sd, fb_base_phys & ~0x1F, OSD_VIDWIN1ADR);
> -			break;
> -	      }
> -	} else if (sd->vpbe_type == VPBE_VERSION_3) {
> -		unsigned long fb_offset_32 =
> -		    (fb_base_phys - VPBE_REG_BASE) >> 5;
> -
> -		switch (layer) {
> -		case WIN_OSD0:
> -			osd_modify(sd, OSD_OSDWINADH_O0AH,
> -				  fb_offset_32 >> (OSD_SRCADD_ADD_SFT -
> -						   OSD_OSDWINADH_O0AH_SHIFT),
> -				  OSD_OSDWINADH);
> -			osd_write(sd, fb_offset_32 & OSD_OSDWIN0ADL_O0AL,
> -				  OSD_OSDWIN0ADL);
> -			break;
> -		case WIN_VID0:
> -			osd_modify(sd, OSD_VIDWINADH_V0AH,
> -				  fb_offset_32 >> (OSD_SRCADD_ADD_SFT -
> -						   OSD_VIDWINADH_V0AH_SHIFT),
> -				  OSD_VIDWINADH);
> -			osd_write(sd, fb_offset_32 & OSD_VIDWIN0ADL_V0AL,
> -				  OSD_VIDWIN0ADL);
> -			break;
> -		case WIN_OSD1:
> -			osd_modify(sd, OSD_OSDWINADH_O1AH,
> -				  fb_offset_32 >> (OSD_SRCADD_ADD_SFT -
> -						   OSD_OSDWINADH_O1AH_SHIFT),
> -				  OSD_OSDWINADH);
> -			osd_write(sd, fb_offset_32 & OSD_OSDWIN1ADL_O1AL,
> -				  OSD_OSDWIN1ADL);
> -			break;
> -		case WIN_VID1:
> -			osd_modify(sd, OSD_VIDWINADH_V1AH,
> -				  fb_offset_32 >> (OSD_SRCADD_ADD_SFT -
> -						   OSD_VIDWINADH_V1AH_SHIFT),
> -				  OSD_VIDWINADH);
> -			osd_write(sd, fb_offset_32 & OSD_VIDWIN1ADL_V1AL,
> -				  OSD_VIDWIN1ADL);
> -			break;
> -		}
> -	} else if (sd->vpbe_type == VPBE_VERSION_2) {
> -		struct osd_window_state *win = &sd->win[layer];
> -		unsigned long fb_offset_32, cbcr_offset_32;
> -
> -		fb_offset_32 = fb_base_phys - VPBE_REG_BASE;
> -		if (cbcr_ofst)
> -			cbcr_offset_32 = cbcr_ofst;
> -		else
> -			cbcr_offset_32 = win->lconfig.line_length *
> -					 win->lconfig.ysize;
> -		cbcr_offset_32 += fb_offset_32;
> -		fb_offset_32 = fb_offset_32 >> 5;
> -		cbcr_offset_32 = cbcr_offset_32 >> 5;
> -		/*
> -		 * DM365: start address is 27-bit long address b26 - b23 are
> -		 * in offset register b12 - b9, and * bit 26 has to be '1'
> -		 */
> -		if (win->lconfig.pixfmt == PIXFMT_NV12) {
> -			switch (layer) {
> -			case WIN_VID0:
> -			case WIN_VID1:
> -				/* Y is in VID0 */
> -				osd_modify(sd, OSD_VIDWIN0OFST_V0AH,
> -					 ((fb_offset_32 & OSD_SRC_ADDR_HIGH4) >>
> -					 (OSD_SRCADD_OFSET_SFT -
> -					 OSD_WINOFST_AH_SHIFT)) |
> -					 OSD_WINOFST_MASK, OSD_VIDWIN0OFST);
> -				osd_modify(sd, OSD_VIDWINADH_V0AH,
> -					  (fb_offset_32 & OSD_SRC_ADDR_HIGH7) >>
> -					  (OSD_SRCADD_ADD_SFT -
> -					  OSD_VIDWINADH_V0AH_SHIFT),
> -					   OSD_VIDWINADH);
> -				osd_write(sd, fb_offset_32 & OSD_WINADL_MASK,
> -					  OSD_VIDWIN0ADL);
> -				/* CbCr is in VID1 */
> -				osd_modify(sd, OSD_VIDWIN1OFST_V1AH,
> -					 ((cbcr_offset_32 &
> -					 OSD_SRC_ADDR_HIGH4) >>
> -					 (OSD_SRCADD_OFSET_SFT -
> -					 OSD_WINOFST_AH_SHIFT)) |
> -					 OSD_WINOFST_MASK, OSD_VIDWIN1OFST);
> -				osd_modify(sd, OSD_VIDWINADH_V1AH,
> -					  (cbcr_offset_32 &
> -					  OSD_SRC_ADDR_HIGH7) >>
> -					  (OSD_SRCADD_ADD_SFT -
> -					  OSD_VIDWINADH_V1AH_SHIFT),
> -					  OSD_VIDWINADH);
> -				osd_write(sd, cbcr_offset_32 & OSD_WINADL_MASK,
> -					  OSD_VIDWIN1ADL);
> -				break;
> -			default:
> -				break;
> -			}
> -		}
> -
> -		switch (layer) {
> -		case WIN_OSD0:
> -			osd_modify(sd, OSD_OSDWIN0OFST_O0AH,
> -				 ((fb_offset_32 & OSD_SRC_ADDR_HIGH4) >>
> -				 (OSD_SRCADD_OFSET_SFT -
> -				 OSD_WINOFST_AH_SHIFT)) | OSD_WINOFST_MASK,
> -				  OSD_OSDWIN0OFST);
> -			osd_modify(sd, OSD_OSDWINADH_O0AH,
> -				 (fb_offset_32 & OSD_SRC_ADDR_HIGH7) >>
> -				 (OSD_SRCADD_ADD_SFT -
> -				 OSD_OSDWINADH_O0AH_SHIFT), OSD_OSDWINADH);
> -			osd_write(sd, fb_offset_32 & OSD_WINADL_MASK,
> -					OSD_OSDWIN0ADL);
> -			break;
> -		case WIN_VID0:
> -			if (win->lconfig.pixfmt != PIXFMT_NV12) {
> -				osd_modify(sd, OSD_VIDWIN0OFST_V0AH,
> -					 ((fb_offset_32 & OSD_SRC_ADDR_HIGH4) >>
> -					 (OSD_SRCADD_OFSET_SFT -
> -					 OSD_WINOFST_AH_SHIFT)) |
> -					 OSD_WINOFST_MASK, OSD_VIDWIN0OFST);
> -				osd_modify(sd, OSD_VIDWINADH_V0AH,
> -					  (fb_offset_32 & OSD_SRC_ADDR_HIGH7) >>
> -					  (OSD_SRCADD_ADD_SFT -
> -					  OSD_VIDWINADH_V0AH_SHIFT),
> -					  OSD_VIDWINADH);
> -				osd_write(sd, fb_offset_32 & OSD_WINADL_MASK,
> -					  OSD_VIDWIN0ADL);
> -			}
> -			break;
> -		case WIN_OSD1:
> -			osd_modify(sd, OSD_OSDWIN1OFST_O1AH,
> -				 ((fb_offset_32 & OSD_SRC_ADDR_HIGH4) >>
> -				 (OSD_SRCADD_OFSET_SFT -
> -				 OSD_WINOFST_AH_SHIFT)) | OSD_WINOFST_MASK,
> -				  OSD_OSDWIN1OFST);
> -			osd_modify(sd, OSD_OSDWINADH_O1AH,
> -				  (fb_offset_32 & OSD_SRC_ADDR_HIGH7) >>
> -				  (OSD_SRCADD_ADD_SFT -
> -				  OSD_OSDWINADH_O1AH_SHIFT),
> -				  OSD_OSDWINADH);
> -			osd_write(sd, fb_offset_32 & OSD_WINADL_MASK,
> -					OSD_OSDWIN1ADL);
> -			break;
> -		case WIN_VID1:
> -			if (win->lconfig.pixfmt != PIXFMT_NV12) {
> -				osd_modify(sd, OSD_VIDWIN1OFST_V1AH,
> -					 ((fb_offset_32 & OSD_SRC_ADDR_HIGH4) >>
> -					 (OSD_SRCADD_OFSET_SFT -
> -					 OSD_WINOFST_AH_SHIFT)) |
> -					 OSD_WINOFST_MASK, OSD_VIDWIN1OFST);
> -				osd_modify(sd, OSD_VIDWINADH_V1AH,
> -					  (fb_offset_32 & OSD_SRC_ADDR_HIGH7) >>
> -					  (OSD_SRCADD_ADD_SFT -
> -					  OSD_VIDWINADH_V1AH_SHIFT),
> -					  OSD_VIDWINADH);
> -				osd_write(sd, fb_offset_32 & OSD_WINADL_MASK,
> -					  OSD_VIDWIN1ADL);
> -			}
> -			break;
> -		}
> -	}
> -}
> -
> -static void osd_start_layer(struct osd_state *sd, enum osd_layer layer,
> -			    unsigned long fb_base_phys,
> -			    unsigned long cbcr_ofst)
> -{
> -	struct osd_state *osd = sd;
> -	struct osd_window_state *win = &osd->win[layer];
> -	struct osd_layer_config *cfg = &win->lconfig;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&osd->lock, flags);
> -
> -	win->fb_base_phys = fb_base_phys & ~0x1F;
> -	_osd_start_layer(sd, layer, fb_base_phys, cbcr_ofst);
> -
> -	if (layer == WIN_VID0) {
> -		osd->pingpong =
> -		    _osd_dm6446_vid0_pingpong(sd, osd->field_inversion,
> -						       win->fb_base_phys,
> -						       cfg);
> -	}
> -
> -	spin_unlock_irqrestore(&osd->lock, flags);
> -}
> -
> -static void osd_get_layer_config(struct osd_state *sd, enum osd_layer layer,
> -				 struct osd_layer_config *lconfig)
> -{
> -	struct osd_state *osd = sd;
> -	struct osd_window_state *win = &osd->win[layer];
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&osd->lock, flags);
> -
> -	*lconfig = win->lconfig;
> -
> -	spin_unlock_irqrestore(&osd->lock, flags);
> -}
> -
> -/**
> - * try_layer_config() - Try a specific configuration for the layer
> - * @sd: ptr to struct osd_state
> - * @layer: layer to configure
> - * @lconfig: layer configuration to try
> - *
> - * If the requested lconfig is completely rejected and the value of lconfig on
> - * exit is the current lconfig, then try_layer_config() returns 1.  Otherwise,
> - * try_layer_config() returns 0.  A return value of 0 does not necessarily mean
> - * that the value of lconfig on exit is identical to the value of lconfig on
> - * entry, but merely that it represents a change from the current lconfig.
> - */
> -static int try_layer_config(struct osd_state *sd, enum osd_layer layer,
> -			    struct osd_layer_config *lconfig)
> -{
> -	struct osd_state *osd = sd;
> -	struct osd_window_state *win = &osd->win[layer];
> -	int bad_config = 0;
> -
> -	/* verify that the pixel format is compatible with the layer */
> -	switch (lconfig->pixfmt) {
> -	case PIXFMT_1BPP:
> -	case PIXFMT_2BPP:
> -	case PIXFMT_4BPP:
> -	case PIXFMT_8BPP:
> -	case PIXFMT_RGB565:
> -		if (osd->vpbe_type == VPBE_VERSION_1)
> -			bad_config = !is_vid_win(layer);
> -		break;
> -	case PIXFMT_YCBCRI:
> -	case PIXFMT_YCRCBI:
> -		bad_config = !is_vid_win(layer);
> -		break;
> -	case PIXFMT_RGB888:
> -		if (osd->vpbe_type == VPBE_VERSION_1)
> -			bad_config = !is_vid_win(layer);
> -		else if ((osd->vpbe_type == VPBE_VERSION_3) ||
> -			 (osd->vpbe_type == VPBE_VERSION_2))
> -			bad_config = !is_osd_win(layer);
> -		break;
> -	case PIXFMT_NV12:
> -		if (osd->vpbe_type != VPBE_VERSION_2)
> -			bad_config = 1;
> -		else
> -			bad_config = is_osd_win(layer);
> -		break;
> -	case PIXFMT_OSD_ATTR:
> -		bad_config = (layer != WIN_OSD1);
> -		break;
> -	default:
> -		bad_config = 1;
> -		break;
> -	}
> -	if (bad_config) {
> -		/*
> -		 * The requested pixel format is incompatible with the layer,
> -		 * so keep the current layer configuration.
> -		 */
> -		*lconfig = win->lconfig;
> -		return bad_config;
> -	}
> -
> -	/* DM6446: */
> -	/* only one OSD window at a time can use RGB pixel formats */
> -	if ((osd->vpbe_type == VPBE_VERSION_1) &&
> -	    is_osd_win(layer) && is_rgb_pixfmt(lconfig->pixfmt)) {
> -		enum osd_pix_format pixfmt;
> -
> -		if (layer == WIN_OSD0)
> -			pixfmt = osd->win[WIN_OSD1].lconfig.pixfmt;
> -		else
> -			pixfmt = osd->win[WIN_OSD0].lconfig.pixfmt;
> -
> -		if (is_rgb_pixfmt(pixfmt)) {
> -			/*
> -			 * The other OSD window is already configured for an
> -			 * RGB, so keep the current layer configuration.
> -			 */
> -			*lconfig = win->lconfig;
> -			return 1;
> -		}
> -	}
> -
> -	/* DM6446: only one video window at a time can use RGB888 */
> -	if ((osd->vpbe_type == VPBE_VERSION_1) && is_vid_win(layer) &&
> -		lconfig->pixfmt == PIXFMT_RGB888) {
> -		enum osd_pix_format pixfmt;
> -
> -		if (layer == WIN_VID0)
> -			pixfmt = osd->win[WIN_VID1].lconfig.pixfmt;
> -		else
> -			pixfmt = osd->win[WIN_VID0].lconfig.pixfmt;
> -
> -		if (pixfmt == PIXFMT_RGB888) {
> -			/*
> -			 * The other video window is already configured for
> -			 * RGB888, so keep the current layer configuration.
> -			 */
> -			*lconfig = win->lconfig;
> -			return 1;
> -		}
> -	}
> -
> -	/* window dimensions must be non-zero */
> -	if (!lconfig->line_length || !lconfig->xsize || !lconfig->ysize) {
> -		*lconfig = win->lconfig;
> -		return 1;
> -	}
> -
> -	/* round line_length up to a multiple of 32 */
> -	lconfig->line_length = ((lconfig->line_length + 31) / 32) * 32;
> -	lconfig->line_length =
> -	    min(lconfig->line_length, (unsigned)MAX_LINE_LENGTH);
> -	lconfig->xsize = min(lconfig->xsize, (unsigned)MAX_WIN_SIZE);
> -	lconfig->ysize = min(lconfig->ysize, (unsigned)MAX_WIN_SIZE);
> -	lconfig->xpos = min(lconfig->xpos, (unsigned)MAX_WIN_SIZE);
> -	lconfig->ypos = min(lconfig->ypos, (unsigned)MAX_WIN_SIZE);
> -	lconfig->interlaced = (lconfig->interlaced != 0);
> -	if (lconfig->interlaced) {
> -		/* ysize and ypos must be even for interlaced displays */
> -		lconfig->ysize &= ~1;
> -		lconfig->ypos &= ~1;
> -	}
> -
> -	return 0;
> -}
> -
> -static void _osd_disable_vid_rgb888(struct osd_state *sd)
> -{
> -	/*
> -	 * The DM6446 supports RGB888 pixel format in a single video window.
> -	 * This routine disables RGB888 pixel format for both video windows.
> -	 * The caller must ensure that neither video window is currently
> -	 * configured for RGB888 pixel format.
> -	 */
> -	if (sd->vpbe_type == VPBE_VERSION_1)
> -		osd_clear(sd, OSD_MISCCTL_RGBEN, OSD_MISCCTL);
> -}
> -
> -static void _osd_enable_vid_rgb888(struct osd_state *sd,
> -				   enum osd_layer layer)
> -{
> -	/*
> -	 * The DM6446 supports RGB888 pixel format in a single video window.
> -	 * This routine enables RGB888 pixel format for the specified video
> -	 * window.  The caller must ensure that the other video window is not
> -	 * currently configured for RGB888 pixel format, as this routine will
> -	 * disable RGB888 pixel format for the other window.
> -	 */
> -	if (sd->vpbe_type == VPBE_VERSION_1) {
> -		if (layer == WIN_VID0)
> -			osd_modify(sd, OSD_MISCCTL_RGBEN | OSD_MISCCTL_RGBWIN,
> -				  OSD_MISCCTL_RGBEN, OSD_MISCCTL);
> -		else if (layer == WIN_VID1)
> -			osd_modify(sd, OSD_MISCCTL_RGBEN | OSD_MISCCTL_RGBWIN,
> -				  OSD_MISCCTL_RGBEN | OSD_MISCCTL_RGBWIN,
> -				  OSD_MISCCTL);
> -	}
> -}
> -
> -static void _osd_set_cbcr_order(struct osd_state *sd,
> -				enum osd_pix_format pixfmt)
> -{
> -	/*
> -	 * The caller must ensure that all windows using YC pixfmt use the same
> -	 * Cb/Cr order.
> -	 */
> -	if (pixfmt == PIXFMT_YCBCRI)
> -		osd_clear(sd, OSD_MODE_CS, OSD_MODE);
> -	else if (pixfmt == PIXFMT_YCRCBI)
> -		osd_set(sd, OSD_MODE_CS, OSD_MODE);
> -}
> -
> -static void _osd_set_layer_config(struct osd_state *sd, enum osd_layer layer,
> -				  const struct osd_layer_config *lconfig)
> -{
> -	u32 winmd = 0, winmd_mask = 0, bmw = 0;
> -
> -	_osd_set_cbcr_order(sd, lconfig->pixfmt);
> -
> -	switch (layer) {
> -	case WIN_OSD0:
> -		if (sd->vpbe_type == VPBE_VERSION_1) {
> -			winmd_mask |= OSD_OSDWIN0MD_RGB0E;
> -			if (lconfig->pixfmt == PIXFMT_RGB565)
> -				winmd |= OSD_OSDWIN0MD_RGB0E;
> -		} else if ((sd->vpbe_type == VPBE_VERSION_3) ||
> -		  (sd->vpbe_type == VPBE_VERSION_2)) {
> -			winmd_mask |= OSD_OSDWIN0MD_BMP0MD;
> -			switch (lconfig->pixfmt) {
> -			case PIXFMT_RGB565:
> -					winmd |= (1 <<
> -					OSD_OSDWIN0MD_BMP0MD_SHIFT);
> -					break;
> -			case PIXFMT_RGB888:
> -				winmd |= (2 << OSD_OSDWIN0MD_BMP0MD_SHIFT);
> -				_osd_enable_rgb888_pixblend(sd, OSDWIN_OSD0);
> -				break;
> -			case PIXFMT_YCBCRI:
> -			case PIXFMT_YCRCBI:
> -				winmd |= (3 << OSD_OSDWIN0MD_BMP0MD_SHIFT);
> -				break;
> -			default:
> -				break;
> -			}
> -		}
> -
> -		winmd_mask |= OSD_OSDWIN0MD_BMW0 | OSD_OSDWIN0MD_OFF0;
> -
> -		switch (lconfig->pixfmt) {
> -		case PIXFMT_1BPP:
> -			bmw = 0;
> -			break;
> -		case PIXFMT_2BPP:
> -			bmw = 1;
> -			break;
> -		case PIXFMT_4BPP:
> -			bmw = 2;
> -			break;
> -		case PIXFMT_8BPP:
> -			bmw = 3;
> -			break;
> -		default:
> -			break;
> -		}
> -		winmd |= (bmw << OSD_OSDWIN0MD_BMW0_SHIFT);
> -
> -		if (lconfig->interlaced)
> -			winmd |= OSD_OSDWIN0MD_OFF0;
> -
> -		osd_modify(sd, winmd_mask, winmd, OSD_OSDWIN0MD);
> -		osd_write(sd, lconfig->line_length >> 5, OSD_OSDWIN0OFST);
> -		osd_write(sd, lconfig->xpos, OSD_OSDWIN0XP);
> -		osd_write(sd, lconfig->xsize, OSD_OSDWIN0XL);
> -		if (lconfig->interlaced) {
> -			osd_write(sd, lconfig->ypos >> 1, OSD_OSDWIN0YP);
> -			osd_write(sd, lconfig->ysize >> 1, OSD_OSDWIN0YL);
> -		} else {
> -			osd_write(sd, lconfig->ypos, OSD_OSDWIN0YP);
> -			osd_write(sd, lconfig->ysize, OSD_OSDWIN0YL);
> -		}
> -		break;
> -	case WIN_VID0:
> -		winmd_mask |= OSD_VIDWINMD_VFF0;
> -		if (lconfig->interlaced)
> -			winmd |= OSD_VIDWINMD_VFF0;
> -
> -		osd_modify(sd, winmd_mask, winmd, OSD_VIDWINMD);
> -		osd_write(sd, lconfig->line_length >> 5, OSD_VIDWIN0OFST);
> -		osd_write(sd, lconfig->xpos, OSD_VIDWIN0XP);
> -		osd_write(sd, lconfig->xsize, OSD_VIDWIN0XL);
> -		/*
> -		 * For YUV420P format the register contents are
> -		 * duplicated in both VID registers
> -		 */
> -		if ((sd->vpbe_type == VPBE_VERSION_2) &&
> -				(lconfig->pixfmt == PIXFMT_NV12)) {
> -			/* other window also */
> -			if (lconfig->interlaced) {
> -				winmd_mask |= OSD_VIDWINMD_VFF1;
> -				winmd |= OSD_VIDWINMD_VFF1;
> -				osd_modify(sd, winmd_mask, winmd,
> -					  OSD_VIDWINMD);
> -			}
> -
> -			osd_modify(sd, OSD_MISCCTL_S420D,
> -				    OSD_MISCCTL_S420D, OSD_MISCCTL);
> -			osd_write(sd, lconfig->line_length >> 5,
> -				  OSD_VIDWIN1OFST);
> -			osd_write(sd, lconfig->xpos, OSD_VIDWIN1XP);
> -			osd_write(sd, lconfig->xsize, OSD_VIDWIN1XL);
> -			/*
> -			  * if NV21 pixfmt and line length not 32B
> -			  * aligned (e.g. NTSC), Need to set window
> -			  * X pixel size to be 32B aligned as well
> -			  */
> -			if (lconfig->xsize % 32) {
> -				osd_write(sd,
> -					  ((lconfig->xsize + 31) & ~31),
> -					  OSD_VIDWIN1XL);
> -				osd_write(sd,
> -					  ((lconfig->xsize + 31) & ~31),
> -					  OSD_VIDWIN0XL);
> -			}
> -		} else if ((sd->vpbe_type == VPBE_VERSION_2) &&
> -				(lconfig->pixfmt != PIXFMT_NV12)) {
> -			osd_modify(sd, OSD_MISCCTL_S420D, ~OSD_MISCCTL_S420D,
> -						OSD_MISCCTL);
> -		}
> -
> -		if (lconfig->interlaced) {
> -			osd_write(sd, lconfig->ypos >> 1, OSD_VIDWIN0YP);
> -			osd_write(sd, lconfig->ysize >> 1, OSD_VIDWIN0YL);
> -			if ((sd->vpbe_type == VPBE_VERSION_2) &&
> -				lconfig->pixfmt == PIXFMT_NV12) {
> -				osd_write(sd, lconfig->ypos >> 1,
> -					  OSD_VIDWIN1YP);
> -				osd_write(sd, lconfig->ysize >> 1,
> -					  OSD_VIDWIN1YL);
> -			}
> -		} else {
> -			osd_write(sd, lconfig->ypos, OSD_VIDWIN0YP);
> -			osd_write(sd, lconfig->ysize, OSD_VIDWIN0YL);
> -			if ((sd->vpbe_type == VPBE_VERSION_2) &&
> -				lconfig->pixfmt == PIXFMT_NV12) {
> -				osd_write(sd, lconfig->ypos, OSD_VIDWIN1YP);
> -				osd_write(sd, lconfig->ysize, OSD_VIDWIN1YL);
> -			}
> -		}
> -		break;
> -	case WIN_OSD1:
> -		/*
> -		 * The caller must ensure that OSD1 is disabled prior to
> -		 * switching from a normal mode to attribute mode or from
> -		 * attribute mode to a normal mode.
> -		 */
> -		if (lconfig->pixfmt == PIXFMT_OSD_ATTR) {
> -			if (sd->vpbe_type == VPBE_VERSION_1) {
> -				winmd_mask |= OSD_OSDWIN1MD_ATN1E |
> -				OSD_OSDWIN1MD_RGB1E | OSD_OSDWIN1MD_CLUTS1 |
> -				OSD_OSDWIN1MD_BLND1 | OSD_OSDWIN1MD_TE1;
> -			} else {
> -				winmd_mask |= OSD_OSDWIN1MD_BMP1MD |
> -				OSD_OSDWIN1MD_CLUTS1 | OSD_OSDWIN1MD_BLND1 |
> -				OSD_OSDWIN1MD_TE1;
> -			}
> -		} else {
> -			if (sd->vpbe_type == VPBE_VERSION_1) {
> -				winmd_mask |= OSD_OSDWIN1MD_RGB1E;
> -				if (lconfig->pixfmt == PIXFMT_RGB565)
> -					winmd |= OSD_OSDWIN1MD_RGB1E;
> -			} else if ((sd->vpbe_type == VPBE_VERSION_3)
> -				   || (sd->vpbe_type == VPBE_VERSION_2)) {
> -				winmd_mask |= OSD_OSDWIN1MD_BMP1MD;
> -				switch (lconfig->pixfmt) {
> -				case PIXFMT_RGB565:
> -					winmd |=
> -					    (1 << OSD_OSDWIN1MD_BMP1MD_SHIFT);
> -					break;
> -				case PIXFMT_RGB888:
> -					winmd |=
> -					    (2 << OSD_OSDWIN1MD_BMP1MD_SHIFT);
> -					_osd_enable_rgb888_pixblend(sd,
> -							OSDWIN_OSD1);
> -					break;
> -				case PIXFMT_YCBCRI:
> -				case PIXFMT_YCRCBI:
> -					winmd |=
> -					    (3 << OSD_OSDWIN1MD_BMP1MD_SHIFT);
> -					break;
> -				default:
> -					break;
> -				}
> -			}
> -
> -			winmd_mask |= OSD_OSDWIN1MD_BMW1;
> -			switch (lconfig->pixfmt) {
> -			case PIXFMT_1BPP:
> -				bmw = 0;
> -				break;
> -			case PIXFMT_2BPP:
> -				bmw = 1;
> -				break;
> -			case PIXFMT_4BPP:
> -				bmw = 2;
> -				break;
> -			case PIXFMT_8BPP:
> -				bmw = 3;
> -				break;
> -			default:
> -				break;
> -			}
> -			winmd |= (bmw << OSD_OSDWIN1MD_BMW1_SHIFT);
> -		}
> -
> -		winmd_mask |= OSD_OSDWIN1MD_OFF1;
> -		if (lconfig->interlaced)
> -			winmd |= OSD_OSDWIN1MD_OFF1;
> -
> -		osd_modify(sd, winmd_mask, winmd, OSD_OSDWIN1MD);
> -		osd_write(sd, lconfig->line_length >> 5, OSD_OSDWIN1OFST);
> -		osd_write(sd, lconfig->xpos, OSD_OSDWIN1XP);
> -		osd_write(sd, lconfig->xsize, OSD_OSDWIN1XL);
> -		if (lconfig->interlaced) {
> -			osd_write(sd, lconfig->ypos >> 1, OSD_OSDWIN1YP);
> -			osd_write(sd, lconfig->ysize >> 1, OSD_OSDWIN1YL);
> -		} else {
> -			osd_write(sd, lconfig->ypos, OSD_OSDWIN1YP);
> -			osd_write(sd, lconfig->ysize, OSD_OSDWIN1YL);
> -		}
> -		break;
> -	case WIN_VID1:
> -		winmd_mask |= OSD_VIDWINMD_VFF1;
> -		if (lconfig->interlaced)
> -			winmd |= OSD_VIDWINMD_VFF1;
> -
> -		osd_modify(sd, winmd_mask, winmd, OSD_VIDWINMD);
> -		osd_write(sd, lconfig->line_length >> 5, OSD_VIDWIN1OFST);
> -		osd_write(sd, lconfig->xpos, OSD_VIDWIN1XP);
> -		osd_write(sd, lconfig->xsize, OSD_VIDWIN1XL);
> -		/*
> -		 * For YUV420P format the register contents are
> -		 * duplicated in both VID registers
> -		 */
> -		if (sd->vpbe_type == VPBE_VERSION_2) {
> -			if (lconfig->pixfmt == PIXFMT_NV12) {
> -				/* other window also */
> -				if (lconfig->interlaced) {
> -					winmd_mask |= OSD_VIDWINMD_VFF0;
> -					winmd |= OSD_VIDWINMD_VFF0;
> -					osd_modify(sd, winmd_mask, winmd,
> -						  OSD_VIDWINMD);
> -				}
> -				osd_modify(sd, OSD_MISCCTL_S420D,
> -					   OSD_MISCCTL_S420D, OSD_MISCCTL);
> -				osd_write(sd, lconfig->line_length >> 5,
> -					  OSD_VIDWIN0OFST);
> -				osd_write(sd, lconfig->xpos, OSD_VIDWIN0XP);
> -				osd_write(sd, lconfig->xsize, OSD_VIDWIN0XL);
> -			} else {
> -				osd_modify(sd, OSD_MISCCTL_S420D,
> -					   ~OSD_MISCCTL_S420D, OSD_MISCCTL);
> -			}
> -		}
> -
> -		if (lconfig->interlaced) {
> -			osd_write(sd, lconfig->ypos >> 1, OSD_VIDWIN1YP);
> -			osd_write(sd, lconfig->ysize >> 1, OSD_VIDWIN1YL);
> -			if ((sd->vpbe_type == VPBE_VERSION_2) &&
> -				lconfig->pixfmt == PIXFMT_NV12) {
> -				osd_write(sd, lconfig->ypos >> 1,
> -					  OSD_VIDWIN0YP);
> -				osd_write(sd, lconfig->ysize >> 1,
> -					  OSD_VIDWIN0YL);
> -			}
> -		} else {
> -			osd_write(sd, lconfig->ypos, OSD_VIDWIN1YP);
> -			osd_write(sd, lconfig->ysize, OSD_VIDWIN1YL);
> -			if ((sd->vpbe_type == VPBE_VERSION_2) &&
> -				lconfig->pixfmt == PIXFMT_NV12) {
> -				osd_write(sd, lconfig->ypos, OSD_VIDWIN0YP);
> -				osd_write(sd, lconfig->ysize, OSD_VIDWIN0YL);
> -			}
> -		}
> -		break;
> -	}
> -}
> -
> -static int osd_set_layer_config(struct osd_state *sd, enum osd_layer layer,
> -				struct osd_layer_config *lconfig)
> -{
> -	struct osd_state *osd = sd;
> -	struct osd_window_state *win = &osd->win[layer];
> -	struct osd_layer_config *cfg = &win->lconfig;
> -	unsigned long flags;
> -	int reject_config;
> -
> -	spin_lock_irqsave(&osd->lock, flags);
> -
> -	reject_config = try_layer_config(sd, layer, lconfig);
> -	if (reject_config) {
> -		spin_unlock_irqrestore(&osd->lock, flags);
> -		return reject_config;
> -	}
> -
> -	/* update the current Cb/Cr order */
> -	if (is_yc_pixfmt(lconfig->pixfmt))
> -		osd->yc_pixfmt = lconfig->pixfmt;
> -
> -	/*
> -	 * If we are switching OSD1 from normal mode to attribute mode or from
> -	 * attribute mode to normal mode, then we must disable the window.
> -	 */
> -	if (layer == WIN_OSD1) {
> -		if (((lconfig->pixfmt == PIXFMT_OSD_ATTR) &&
> -		  (cfg->pixfmt != PIXFMT_OSD_ATTR)) ||
> -		  ((lconfig->pixfmt != PIXFMT_OSD_ATTR) &&
> -		  (cfg->pixfmt == PIXFMT_OSD_ATTR))) {
> -			win->is_enabled = 0;
> -			_osd_disable_layer(sd, layer);
> -		}
> -	}
> -
> -	_osd_set_layer_config(sd, layer, lconfig);
> -
> -	if (layer == WIN_OSD1) {
> -		struct osd_osdwin_state *osdwin_state =
> -		    &osd->osdwin[OSDWIN_OSD1];
> -
> -		if ((lconfig->pixfmt != PIXFMT_OSD_ATTR) &&
> -		  (cfg->pixfmt == PIXFMT_OSD_ATTR)) {
> -			/*
> -			 * We just switched OSD1 from attribute mode to normal
> -			 * mode, so we must initialize the CLUT select, the
> -			 * blend factor, transparency colorkey enable, and
> -			 * attenuation enable (DM6446 only) bits in the
> -			 * OSDWIN1MD register.
> -			 */
> -			_osd_set_osd_clut(sd, OSDWIN_OSD1,
> -						   osdwin_state->clut);
> -			_osd_set_blending_factor(sd, OSDWIN_OSD1,
> -							  osdwin_state->blend);
> -			if (osdwin_state->colorkey_blending) {
> -				_osd_enable_color_key(sd, OSDWIN_OSD1,
> -							       osdwin_state->
> -							       colorkey,
> -							       lconfig->pixfmt);
> -			} else
> -				_osd_disable_color_key(sd, OSDWIN_OSD1);
> -			_osd_set_rec601_attenuation(sd, OSDWIN_OSD1,
> -						    osdwin_state->
> -						    rec601_attenuation);
> -		} else if ((lconfig->pixfmt == PIXFMT_OSD_ATTR) &&
> -		  (cfg->pixfmt != PIXFMT_OSD_ATTR)) {
> -			/*
> -			 * We just switched OSD1 from normal mode to attribute
> -			 * mode, so we must initialize the blink enable and
> -			 * blink interval bits in the OSDATRMD register.
> -			 */
> -			_osd_set_blink_attribute(sd, osd->is_blinking,
> -							  osd->blink);
> -		}
> -	}
> -
> -	/*
> -	 * If we just switched to a 1-, 2-, or 4-bits-per-pixel bitmap format
> -	 * then configure a default palette map.
> -	 */
> -	if ((lconfig->pixfmt != cfg->pixfmt) &&
> -	  ((lconfig->pixfmt == PIXFMT_1BPP) ||
> -	  (lconfig->pixfmt == PIXFMT_2BPP) ||
> -	  (lconfig->pixfmt == PIXFMT_4BPP))) {
> -		enum osd_win_layer osdwin =
> -		    ((layer == WIN_OSD0) ? OSDWIN_OSD0 : OSDWIN_OSD1);
> -		struct osd_osdwin_state *osdwin_state =
> -		    &osd->osdwin[osdwin];
> -		unsigned char clut_index;
> -		unsigned char clut_entries = 0;
> -
> -		switch (lconfig->pixfmt) {
> -		case PIXFMT_1BPP:
> -			clut_entries = 2;
> -			break;
> -		case PIXFMT_2BPP:
> -			clut_entries = 4;
> -			break;
> -		case PIXFMT_4BPP:
> -			clut_entries = 16;
> -			break;
> -		default:
> -			break;
> -		}
> -		/*
> -		 * The default palette map maps the pixel value to the clut
> -		 * index, i.e. pixel value 0 maps to clut entry 0, pixel value
> -		 * 1 maps to clut entry 1, etc.
> -		 */
> -		for (clut_index = 0; clut_index < 16; clut_index++) {
> -			osdwin_state->palette_map[clut_index] = clut_index;
> -			if (clut_index < clut_entries) {
> -				_osd_set_palette_map(sd, osdwin, clut_index,
> -						     clut_index,
> -						     lconfig->pixfmt);
> -			}
> -		}
> -	}
> -
> -	*cfg = *lconfig;
> -	/* DM6446: configure the RGB888 enable and window selection */
> -	if (osd->win[WIN_VID0].lconfig.pixfmt == PIXFMT_RGB888)
> -		_osd_enable_vid_rgb888(sd, WIN_VID0);
> -	else if (osd->win[WIN_VID1].lconfig.pixfmt == PIXFMT_RGB888)
> -		_osd_enable_vid_rgb888(sd, WIN_VID1);
> -	else
> -		_osd_disable_vid_rgb888(sd);
> -
> -	if (layer == WIN_VID0) {
> -		osd->pingpong =
> -		    _osd_dm6446_vid0_pingpong(sd, osd->field_inversion,
> -						       win->fb_base_phys,
> -						       cfg);
> -	}
> -
> -	spin_unlock_irqrestore(&osd->lock, flags);
> -
> -	return 0;
> -}
> -
> -static void osd_init_layer(struct osd_state *sd, enum osd_layer layer)
> -{
> -	struct osd_state *osd = sd;
> -	struct osd_window_state *win = &osd->win[layer];
> -	enum osd_win_layer osdwin;
> -	struct osd_osdwin_state *osdwin_state;
> -	struct osd_layer_config *cfg = &win->lconfig;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&osd->lock, flags);
> -
> -	win->is_enabled = 0;
> -	_osd_disable_layer(sd, layer);
> -
> -	win->h_zoom = ZOOM_X1;
> -	win->v_zoom = ZOOM_X1;
> -	_osd_set_zoom(sd, layer, win->h_zoom, win->v_zoom);
> -
> -	win->fb_base_phys = 0;
> -	_osd_start_layer(sd, layer, win->fb_base_phys, 0);
> -
> -	cfg->line_length = 0;
> -	cfg->xsize = 0;
> -	cfg->ysize = 0;
> -	cfg->xpos = 0;
> -	cfg->ypos = 0;
> -	cfg->interlaced = 0;
> -	switch (layer) {
> -	case WIN_OSD0:
> -	case WIN_OSD1:
> -		osdwin = (layer == WIN_OSD0) ? OSDWIN_OSD0 : OSDWIN_OSD1;
> -		osdwin_state = &osd->osdwin[osdwin];
> -		/*
> -		 * Other code relies on the fact that OSD windows default to a
> -		 * bitmap pixel format when they are deallocated, so don't
> -		 * change this default pixel format.
> -		 */
> -		cfg->pixfmt = PIXFMT_8BPP;
> -		_osd_set_layer_config(sd, layer, cfg);
> -		osdwin_state->clut = RAM_CLUT;
> -		_osd_set_osd_clut(sd, osdwin, osdwin_state->clut);
> -		osdwin_state->colorkey_blending = 0;
> -		_osd_disable_color_key(sd, osdwin);
> -		osdwin_state->blend = OSD_8_VID_0;
> -		_osd_set_blending_factor(sd, osdwin, osdwin_state->blend);
> -		osdwin_state->rec601_attenuation = 0;
> -		_osd_set_rec601_attenuation(sd, osdwin,
> -						     osdwin_state->
> -						     rec601_attenuation);
> -		if (osdwin == OSDWIN_OSD1) {
> -			osd->is_blinking = 0;
> -			osd->blink = BLINK_X1;
> -		}
> -		break;
> -	case WIN_VID0:
> -	case WIN_VID1:
> -		cfg->pixfmt = osd->yc_pixfmt;
> -		_osd_set_layer_config(sd, layer, cfg);
> -		break;
> -	}
> -
> -	spin_unlock_irqrestore(&osd->lock, flags);
> -}
> -
> -static void osd_release_layer(struct osd_state *sd, enum osd_layer layer)
> -{
> -	struct osd_state *osd = sd;
> -	struct osd_window_state *win = &osd->win[layer];
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&osd->lock, flags);
> -
> -	if (!win->is_allocated) {
> -		spin_unlock_irqrestore(&osd->lock, flags);
> -		return;
> -	}
> -
> -	spin_unlock_irqrestore(&osd->lock, flags);
> -	osd_init_layer(sd, layer);
> -	spin_lock_irqsave(&osd->lock, flags);
> -
> -	win->is_allocated = 0;
> -
> -	spin_unlock_irqrestore(&osd->lock, flags);
> -}
> -
> -static int osd_request_layer(struct osd_state *sd, enum osd_layer layer)
> -{
> -	struct osd_state *osd = sd;
> -	struct osd_window_state *win = &osd->win[layer];
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&osd->lock, flags);
> -
> -	if (win->is_allocated) {
> -		spin_unlock_irqrestore(&osd->lock, flags);
> -		return -1;
> -	}
> -	win->is_allocated = 1;
> -
> -	spin_unlock_irqrestore(&osd->lock, flags);
> -
> -	return 0;
> -}
> -
> -static void _osd_init(struct osd_state *sd)
> -{
> -	osd_write(sd, 0, OSD_MODE);
> -	osd_write(sd, 0, OSD_VIDWINMD);
> -	osd_write(sd, 0, OSD_OSDWIN0MD);
> -	osd_write(sd, 0, OSD_OSDWIN1MD);
> -	osd_write(sd, 0, OSD_RECTCUR);
> -	osd_write(sd, 0, OSD_MISCCTL);
> -	if (sd->vpbe_type == VPBE_VERSION_3) {
> -		osd_write(sd, 0, OSD_VBNDRY);
> -		osd_write(sd, 0, OSD_EXTMODE);
> -		osd_write(sd, OSD_MISCCTL_DMANG, OSD_MISCCTL);
> -	}
> -}
> -
> -static void osd_set_left_margin(struct osd_state *sd, u32 val)
> -{
> -	osd_write(sd, val, OSD_BASEPX);
> -}
> -
> -static void osd_set_top_margin(struct osd_state *sd, u32 val)
> -{
> -	osd_write(sd, val, OSD_BASEPY);
> -}
> -
> -static int osd_initialize(struct osd_state *osd)
> -{
> -	if (osd == NULL)
> -		return -ENODEV;
> -	_osd_init(osd);
> -
> -	/* set default Cb/Cr order */
> -	osd->yc_pixfmt = PIXFMT_YCBCRI;
> -
> -	if (osd->vpbe_type == VPBE_VERSION_3) {
> -		/*
> -		 * ROM CLUT1 on the DM355 is similar (identical?) to ROM CLUT0
> -		 * on the DM6446, so make ROM_CLUT1 the default on the DM355.
> -		 */
> -		osd->rom_clut = ROM_CLUT1;
> -	}
> -
> -	_osd_set_field_inversion(osd, osd->field_inversion);
> -	_osd_set_rom_clut(osd, osd->rom_clut);
> -
> -	osd_init_layer(osd, WIN_OSD0);
> -	osd_init_layer(osd, WIN_VID0);
> -	osd_init_layer(osd, WIN_OSD1);
> -	osd_init_layer(osd, WIN_VID1);
> -
> -	return 0;
> -}
> -
> -static const struct vpbe_osd_ops osd_ops = {
> -	.initialize = osd_initialize,
> -	.request_layer = osd_request_layer,
> -	.release_layer = osd_release_layer,
> -	.enable_layer = osd_enable_layer,
> -	.disable_layer = osd_disable_layer,
> -	.set_layer_config = osd_set_layer_config,
> -	.get_layer_config = osd_get_layer_config,
> -	.start_layer = osd_start_layer,
> -	.set_left_margin = osd_set_left_margin,
> -	.set_top_margin = osd_set_top_margin,
> -};
> -
> -static int osd_probe(struct platform_device *pdev)
> -{
> -	const struct platform_device_id *pdev_id;
> -	struct osd_state *osd;
> -	struct resource *res;
> -
> -	pdev_id = platform_get_device_id(pdev);
> -	if (!pdev_id)
> -		return -EINVAL;
> -
> -	osd = devm_kzalloc(&pdev->dev, sizeof(struct osd_state), GFP_KERNEL);
> -	if (osd == NULL)
> -		return -ENOMEM;
> -
> -
> -	osd->dev = &pdev->dev;
> -	osd->vpbe_type = pdev_id->driver_data;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	osd->osd_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(osd->osd_base))
> -		return PTR_ERR(osd->osd_base);
> -
> -	osd->osd_base_phys = res->start;
> -	osd->osd_size = resource_size(res);
> -	spin_lock_init(&osd->lock);
> -	osd->ops = osd_ops;
> -	platform_set_drvdata(pdev, osd);
> -	dev_notice(osd->dev, "OSD sub device probe success\n");
> -
> -	return 0;
> -}
> -
> -static int osd_remove(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
> -static struct platform_driver osd_driver = {
> -	.probe		= osd_probe,
> -	.remove		= osd_remove,
> -	.driver		= {
> -		.name	= MODULE_NAME,
> -	},
> -	.id_table	= vpbe_osd_devtype
> -};
> -
> -module_platform_driver(osd_driver);
> -
> -MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("DaVinci OSD Manager Driver");
> -MODULE_AUTHOR("Texas Instruments");
> diff --git a/drivers/media/platform/ti/davinci/vpbe_osd_regs.h b/drivers/media/platform/ti/davinci/vpbe_osd_regs.h
> deleted file mode 100644
> index cecd5991d4c5..000000000000
> --- a/drivers/media/platform/ti/davinci/vpbe_osd_regs.h
> +++ /dev/null
> @@ -1,352 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2006-2010 Texas Instruments Inc
> - */
> -#ifndef _VPBE_OSD_REGS_H
> -#define _VPBE_OSD_REGS_H
> -
> -/* VPBE Global Registers */
> -#define VPBE_PID				0x0
> -#define VPBE_PCR				0x4
> -
> -/* VPSS CLock Registers */
> -#define VPSSCLK_PID				0x00
> -#define VPSSCLK_CLKCTRL				0x04
> -
> -/* VPSS Buffer Logic Registers */
> -#define VPSSBL_PID				0x00
> -#define VPSSBL_PCR				0x04
> -#define VPSSBL_BCR				0x08
> -#define VPSSBL_INTSTAT				0x0C
> -#define VPSSBL_INTSEL				0x10
> -#define VPSSBL_EVTSEL				0x14
> -#define VPSSBL_MEMCTRL				0x18
> -#define VPSSBL_CCDCMUX				0x1C
> -
> -/* DM365 ISP5 system configuration */
> -#define ISP5_PID				0x0
> -#define ISP5_PCCR				0x4
> -#define ISP5_BCR				0x8
> -#define ISP5_INTSTAT				0xC
> -#define ISP5_INTSEL1				0x10
> -#define ISP5_INTSEL2				0x14
> -#define ISP5_INTSEL3				0x18
> -#define ISP5_EVTSEL				0x1c
> -#define ISP5_CCDCMUX				0x20
> -
> -/* VPBE On-Screen Display Subsystem Registers (OSD) */
> -#define OSD_MODE				0x00
> -#define OSD_VIDWINMD				0x04
> -#define OSD_OSDWIN0MD				0x08
> -#define OSD_OSDWIN1MD				0x0C
> -#define OSD_OSDATRMD				0x0C
> -#define OSD_RECTCUR				0x10
> -#define OSD_VIDWIN0OFST				0x18
> -#define OSD_VIDWIN1OFST				0x1C
> -#define OSD_OSDWIN0OFST				0x20
> -#define OSD_OSDWIN1OFST				0x24
> -#define OSD_VIDWINADH				0x28
> -#define OSD_VIDWIN0ADL				0x2C
> -#define OSD_VIDWIN0ADR				0x2C
> -#define OSD_VIDWIN1ADL				0x30
> -#define OSD_VIDWIN1ADR				0x30
> -#define OSD_OSDWINADH				0x34
> -#define OSD_OSDWIN0ADL				0x38
> -#define OSD_OSDWIN0ADR				0x38
> -#define OSD_OSDWIN1ADL				0x3C
> -#define OSD_OSDWIN1ADR				0x3C
> -#define OSD_BASEPX				0x40
> -#define OSD_BASEPY				0x44
> -#define OSD_VIDWIN0XP				0x48
> -#define OSD_VIDWIN0YP				0x4C
> -#define OSD_VIDWIN0XL				0x50
> -#define OSD_VIDWIN0YL				0x54
> -#define OSD_VIDWIN1XP				0x58
> -#define OSD_VIDWIN1YP				0x5C
> -#define OSD_VIDWIN1XL				0x60
> -#define OSD_VIDWIN1YL				0x64
> -#define OSD_OSDWIN0XP				0x68
> -#define OSD_OSDWIN0YP				0x6C
> -#define OSD_OSDWIN0XL				0x70
> -#define OSD_OSDWIN0YL				0x74
> -#define OSD_OSDWIN1XP				0x78
> -#define OSD_OSDWIN1YP				0x7C
> -#define OSD_OSDWIN1XL				0x80
> -#define OSD_OSDWIN1YL				0x84
> -#define OSD_CURXP				0x88
> -#define OSD_CURYP				0x8C
> -#define OSD_CURXL				0x90
> -#define OSD_CURYL				0x94
> -#define OSD_W0BMP01				0xA0
> -#define OSD_W0BMP23				0xA4
> -#define OSD_W0BMP45				0xA8
> -#define OSD_W0BMP67				0xAC
> -#define OSD_W0BMP89				0xB0
> -#define OSD_W0BMPAB				0xB4
> -#define OSD_W0BMPCD				0xB8
> -#define OSD_W0BMPEF				0xBC
> -#define OSD_W1BMP01				0xC0
> -#define OSD_W1BMP23				0xC4
> -#define OSD_W1BMP45				0xC8
> -#define OSD_W1BMP67				0xCC
> -#define OSD_W1BMP89				0xD0
> -#define OSD_W1BMPAB				0xD4
> -#define OSD_W1BMPCD				0xD8
> -#define OSD_W1BMPEF				0xDC
> -#define OSD_VBNDRY				0xE0
> -#define OSD_EXTMODE				0xE4
> -#define OSD_MISCCTL				0xE8
> -#define OSD_CLUTRAMYCB				0xEC
> -#define OSD_CLUTRAMCR				0xF0
> -#define OSD_TRANSPVAL				0xF4
> -#define OSD_TRANSPVALL				0xF4
> -#define OSD_TRANSPVALU				0xF8
> -#define OSD_TRANSPBMPIDX			0xFC
> -#define OSD_PPVWIN0ADR				0xFC
> -
> -/* bit definitions */
> -#define VPBE_PCR_VENC_DIV			(1 << 1)
> -#define VPBE_PCR_CLK_OFF			(1 << 0)
> -
> -#define VPSSBL_INTSTAT_HSSIINT			(1 << 14)
> -#define VPSSBL_INTSTAT_CFALDINT			(1 << 13)
> -#define VPSSBL_INTSTAT_IPIPE_INT5		(1 << 12)
> -#define VPSSBL_INTSTAT_IPIPE_INT4		(1 << 11)
> -#define VPSSBL_INTSTAT_IPIPE_INT3		(1 << 10)
> -#define VPSSBL_INTSTAT_IPIPE_INT2		(1 << 9)
> -#define VPSSBL_INTSTAT_IPIPE_INT1		(1 << 8)
> -#define VPSSBL_INTSTAT_IPIPE_INT0		(1 << 7)
> -#define VPSSBL_INTSTAT_IPIPEIFINT		(1 << 6)
> -#define VPSSBL_INTSTAT_OSDINT			(1 << 5)
> -#define VPSSBL_INTSTAT_VENCINT			(1 << 4)
> -#define VPSSBL_INTSTAT_H3AINT			(1 << 3)
> -#define VPSSBL_INTSTAT_CCDC_VDINT2		(1 << 2)
> -#define VPSSBL_INTSTAT_CCDC_VDINT1		(1 << 1)
> -#define VPSSBL_INTSTAT_CCDC_VDINT0		(1 << 0)
> -
> -/* DM365 ISP5 bit definitions */
> -#define ISP5_INTSTAT_VENCINT			(1 << 21)
> -#define ISP5_INTSTAT_OSDINT			(1 << 20)
> -
> -/* VMOD TVTYP options for HDMD=0 */
> -#define SDTV_NTSC				0
> -#define SDTV_PAL				1
> -/* VMOD TVTYP options for HDMD=1 */
> -#define HDTV_525P				0
> -#define HDTV_625P				1
> -#define HDTV_1080I				2
> -#define HDTV_720P				3
> -
> -#define OSD_MODE_CS				(1 << 15)
> -#define OSD_MODE_OVRSZ				(1 << 14)
> -#define OSD_MODE_OHRSZ				(1 << 13)
> -#define OSD_MODE_EF				(1 << 12)
> -#define OSD_MODE_VVRSZ				(1 << 11)
> -#define OSD_MODE_VHRSZ				(1 << 10)
> -#define OSD_MODE_FSINV				(1 << 9)
> -#define OSD_MODE_BCLUT				(1 << 8)
> -#define OSD_MODE_CABG_SHIFT			0
> -#define OSD_MODE_CABG				(0xff << 0)
> -
> -#define OSD_VIDWINMD_VFINV			(1 << 15)
> -#define OSD_VIDWINMD_V1EFC			(1 << 14)
> -#define OSD_VIDWINMD_VHZ1_SHIFT			12
> -#define OSD_VIDWINMD_VHZ1			(3 << 12)
> -#define OSD_VIDWINMD_VVZ1_SHIFT			10
> -#define OSD_VIDWINMD_VVZ1			(3 << 10)
> -#define OSD_VIDWINMD_VFF1			(1 << 9)
> -#define OSD_VIDWINMD_ACT1			(1 << 8)
> -#define OSD_VIDWINMD_V0EFC			(1 << 6)
> -#define OSD_VIDWINMD_VHZ0_SHIFT			4
> -#define OSD_VIDWINMD_VHZ0			(3 << 4)
> -#define OSD_VIDWINMD_VVZ0_SHIFT			2
> -#define OSD_VIDWINMD_VVZ0			(3 << 2)
> -#define OSD_VIDWINMD_VFF0			(1 << 1)
> -#define OSD_VIDWINMD_ACT0			(1 << 0)
> -
> -#define OSD_OSDWIN0MD_ATN0E			(1 << 14)
> -#define OSD_OSDWIN0MD_RGB0E			(1 << 13)
> -#define OSD_OSDWIN0MD_BMP0MD_SHIFT		13
> -#define OSD_OSDWIN0MD_BMP0MD			(3 << 13)
> -#define OSD_OSDWIN0MD_CLUTS0			(1 << 12)
> -#define OSD_OSDWIN0MD_OHZ0_SHIFT		10
> -#define OSD_OSDWIN0MD_OHZ0			(3 << 10)
> -#define OSD_OSDWIN0MD_OVZ0_SHIFT		8
> -#define OSD_OSDWIN0MD_OVZ0			(3 << 8)
> -#define OSD_OSDWIN0MD_BMW0_SHIFT		6
> -#define OSD_OSDWIN0MD_BMW0			(3 << 6)
> -#define OSD_OSDWIN0MD_BLND0_SHIFT		3
> -#define OSD_OSDWIN0MD_BLND0			(7 << 3)
> -#define OSD_OSDWIN0MD_TE0			(1 << 2)
> -#define OSD_OSDWIN0MD_OFF0			(1 << 1)
> -#define OSD_OSDWIN0MD_OACT0			(1 << 0)
> -
> -#define OSD_OSDWIN1MD_OASW			(1 << 15)
> -#define OSD_OSDWIN1MD_ATN1E			(1 << 14)
> -#define OSD_OSDWIN1MD_RGB1E			(1 << 13)
> -#define OSD_OSDWIN1MD_BMP1MD_SHIFT		13
> -#define OSD_OSDWIN1MD_BMP1MD			(3 << 13)
> -#define OSD_OSDWIN1MD_CLUTS1			(1 << 12)
> -#define OSD_OSDWIN1MD_OHZ1_SHIFT		10
> -#define OSD_OSDWIN1MD_OHZ1			(3 << 10)
> -#define OSD_OSDWIN1MD_OVZ1_SHIFT		8
> -#define OSD_OSDWIN1MD_OVZ1			(3 << 8)
> -#define OSD_OSDWIN1MD_BMW1_SHIFT		6
> -#define OSD_OSDWIN1MD_BMW1			(3 << 6)
> -#define OSD_OSDWIN1MD_BLND1_SHIFT		3
> -#define OSD_OSDWIN1MD_BLND1			(7 << 3)
> -#define OSD_OSDWIN1MD_TE1			(1 << 2)
> -#define OSD_OSDWIN1MD_OFF1			(1 << 1)
> -#define OSD_OSDWIN1MD_OACT1			(1 << 0)
> -
> -#define OSD_OSDATRMD_OASW			(1 << 15)
> -#define OSD_OSDATRMD_OHZA_SHIFT			10
> -#define OSD_OSDATRMD_OHZA			(3 << 10)
> -#define OSD_OSDATRMD_OVZA_SHIFT			8
> -#define OSD_OSDATRMD_OVZA			(3 << 8)
> -#define OSD_OSDATRMD_BLNKINT_SHIFT		6
> -#define OSD_OSDATRMD_BLNKINT			(3 << 6)
> -#define OSD_OSDATRMD_OFFA			(1 << 1)
> -#define OSD_OSDATRMD_BLNK			(1 << 0)
> -
> -#define OSD_RECTCUR_RCAD_SHIFT			8
> -#define OSD_RECTCUR_RCAD			(0xff << 8)
> -#define OSD_RECTCUR_CLUTSR			(1 << 7)
> -#define OSD_RECTCUR_RCHW_SHIFT			4
> -#define OSD_RECTCUR_RCHW			(7 << 4)
> -#define OSD_RECTCUR_RCVW_SHIFT			1
> -#define OSD_RECTCUR_RCVW			(7 << 1)
> -#define OSD_RECTCUR_RCACT			(1 << 0)
> -
> -#define OSD_VIDWIN0OFST_V0LO			(0x1ff << 0)
> -
> -#define OSD_VIDWIN1OFST_V1LO			(0x1ff << 0)
> -
> -#define OSD_OSDWIN0OFST_O0LO			(0x1ff << 0)
> -
> -#define OSD_OSDWIN1OFST_O1LO			(0x1ff << 0)
> -
> -#define OSD_WINOFST_AH_SHIFT			9
> -
> -#define OSD_VIDWIN0OFST_V0AH			(0xf << 9)
> -#define OSD_VIDWIN1OFST_V1AH			(0xf << 9)
> -#define OSD_OSDWIN0OFST_O0AH			(0xf << 9)
> -#define OSD_OSDWIN1OFST_O1AH			(0xf << 9)
> -
> -#define OSD_VIDWINADH_V1AH_SHIFT		8
> -#define OSD_VIDWINADH_V1AH			(0x7f << 8)
> -#define OSD_VIDWINADH_V0AH_SHIFT		0
> -#define OSD_VIDWINADH_V0AH			(0x7f << 0)
> -
> -#define OSD_VIDWIN0ADL_V0AL			(0xffff << 0)
> -
> -#define OSD_VIDWIN1ADL_V1AL			(0xffff << 0)
> -
> -#define OSD_OSDWINADH_O1AH_SHIFT		8
> -#define OSD_OSDWINADH_O1AH			(0x7f << 8)
> -#define OSD_OSDWINADH_O0AH_SHIFT		0
> -#define OSD_OSDWINADH_O0AH			(0x7f << 0)
> -
> -#define OSD_OSDWIN0ADL_O0AL			(0xffff << 0)
> -
> -#define OSD_OSDWIN1ADL_O1AL			(0xffff << 0)
> -
> -#define OSD_BASEPX_BPX				(0x3ff << 0)
> -
> -#define OSD_BASEPY_BPY				(0x1ff << 0)
> -
> -#define OSD_VIDWIN0XP_V0X			(0x7ff << 0)
> -
> -#define OSD_VIDWIN0YP_V0Y			(0x7ff << 0)
> -
> -#define OSD_VIDWIN0XL_V0W			(0x7ff << 0)
> -
> -#define OSD_VIDWIN0YL_V0H			(0x7ff << 0)
> -
> -#define OSD_VIDWIN1XP_V1X			(0x7ff << 0)
> -
> -#define OSD_VIDWIN1YP_V1Y			(0x7ff << 0)
> -
> -#define OSD_VIDWIN1XL_V1W			(0x7ff << 0)
> -
> -#define OSD_VIDWIN1YL_V1H			(0x7ff << 0)
> -
> -#define OSD_OSDWIN0XP_W0X			(0x7ff << 0)
> -
> -#define OSD_OSDWIN0YP_W0Y			(0x7ff << 0)
> -
> -#define OSD_OSDWIN0XL_W0W			(0x7ff << 0)
> -
> -#define OSD_OSDWIN0YL_W0H			(0x7ff << 0)
> -
> -#define OSD_OSDWIN1XP_W1X			(0x7ff << 0)
> -
> -#define OSD_OSDWIN1YP_W1Y			(0x7ff << 0)
> -
> -#define OSD_OSDWIN1XL_W1W			(0x7ff << 0)
> -
> -#define OSD_OSDWIN1YL_W1H			(0x7ff << 0)
> -
> -#define OSD_CURXP_RCSX				(0x7ff << 0)
> -
> -#define OSD_CURYP_RCSY				(0x7ff << 0)
> -
> -#define OSD_CURXL_RCSW				(0x7ff << 0)
> -
> -#define OSD_CURYL_RCSH				(0x7ff << 0)
> -
> -#define OSD_EXTMODE_EXPMDSEL			(1 << 15)
> -#define OSD_EXTMODE_SCRNHEXP_SHIFT		13
> -#define OSD_EXTMODE_SCRNHEXP			(3 << 13)
> -#define OSD_EXTMODE_SCRNVEXP			(1 << 12)
> -#define OSD_EXTMODE_OSD1BLDCHR			(1 << 11)
> -#define OSD_EXTMODE_OSD0BLDCHR			(1 << 10)
> -#define OSD_EXTMODE_ATNOSD1EN			(1 << 9)
> -#define OSD_EXTMODE_ATNOSD0EN			(1 << 8)
> -#define OSD_EXTMODE_OSDHRSZ15			(1 << 7)
> -#define OSD_EXTMODE_VIDHRSZ15			(1 << 6)
> -#define OSD_EXTMODE_ZMFILV1HEN			(1 << 5)
> -#define OSD_EXTMODE_ZMFILV1VEN			(1 << 4)
> -#define OSD_EXTMODE_ZMFILV0HEN			(1 << 3)
> -#define OSD_EXTMODE_ZMFILV0VEN			(1 << 2)
> -#define OSD_EXTMODE_EXPFILHEN			(1 << 1)
> -#define OSD_EXTMODE_EXPFILVEN			(1 << 0)
> -
> -#define OSD_MISCCTL_BLDSEL			(1 << 15)
> -#define OSD_MISCCTL_S420D			(1 << 14)
> -#define OSD_MISCCTL_BMAPT			(1 << 13)
> -#define OSD_MISCCTL_DM365M			(1 << 12)
> -#define OSD_MISCCTL_RGBEN			(1 << 7)
> -#define OSD_MISCCTL_RGBWIN			(1 << 6)
> -#define OSD_MISCCTL_DMANG			(1 << 6)
> -#define OSD_MISCCTL_TMON			(1 << 5)
> -#define OSD_MISCCTL_RSEL			(1 << 4)
> -#define OSD_MISCCTL_CPBSY			(1 << 3)
> -#define OSD_MISCCTL_PPSW			(1 << 2)
> -#define OSD_MISCCTL_PPRV			(1 << 1)
> -
> -#define OSD_CLUTRAMYCB_Y_SHIFT			8
> -#define OSD_CLUTRAMYCB_Y			(0xff << 8)
> -#define OSD_CLUTRAMYCB_CB_SHIFT			0
> -#define OSD_CLUTRAMYCB_CB			(0xff << 0)
> -
> -#define OSD_CLUTRAMCR_CR_SHIFT			8
> -#define OSD_CLUTRAMCR_CR			(0xff << 8)
> -#define OSD_CLUTRAMCR_CADDR_SHIFT		0
> -#define OSD_CLUTRAMCR_CADDR			(0xff << 0)
> -
> -#define OSD_TRANSPVAL_RGBTRANS			(0xffff << 0)
> -
> -#define OSD_TRANSPVALL_RGBL			(0xffff << 0)
> -
> -#define OSD_TRANSPVALU_Y_SHIFT			8
> -#define OSD_TRANSPVALU_Y			(0xff << 8)
> -#define OSD_TRANSPVALU_RGBU_SHIFT		0
> -#define OSD_TRANSPVALU_RGBU			(0xff << 0)
> -
> -#define OSD_TRANSPBMPIDX_BMP1_SHIFT		8
> -#define OSD_TRANSPBMPIDX_BMP1			(0xff << 8)
> -#define OSD_TRANSPBMPIDX_BMP0_SHIFT		0
> -#define OSD_TRANSPBMPIDX_BMP0			0xff
> -
> -#endif				/* _DAVINCI_VPBE_H_ */
> diff --git a/drivers/media/platform/ti/davinci/vpbe_venc.c b/drivers/media/platform/ti/davinci/vpbe_venc.c
> deleted file mode 100644
> index 4c8e31de12b1..000000000000
> --- a/drivers/media/platform/ti/davinci/vpbe_venc.c
> +++ /dev/null
> @@ -1,676 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2010 Texas Instruments Inc
> - */
> -#include <linux/module.h>
> -#include <linux/mod_devicetable.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/ctype.h>
> -#include <linux/delay.h>
> -#include <linux/device.h>
> -#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -#include <linux/videodev2.h>
> -#include <linux/slab.h>
> -
> -#include <linux/platform_data/i2c-davinci.h>
> -
> -#include <linux/io.h>
> -
> -#include <media/davinci/vpbe_types.h>
> -#include <media/davinci/vpbe_venc.h>
> -#include <media/davinci/vpss.h>
> -#include <media/v4l2-device.h>
> -
> -#include "vpbe_venc_regs.h"
> -
> -#define MODULE_NAME	"davinci-vpbe-venc"
> -
> -static const struct platform_device_id vpbe_venc_devtype[] = {
> -	{
> -		.name = DM644X_VPBE_VENC_SUBDEV_NAME,
> -		.driver_data = VPBE_VERSION_1,
> -	}, {
> -		.name = DM365_VPBE_VENC_SUBDEV_NAME,
> -		.driver_data = VPBE_VERSION_2,
> -	}, {
> -		.name = DM355_VPBE_VENC_SUBDEV_NAME,
> -		.driver_data = VPBE_VERSION_3,
> -	},
> -	{
> -		/* sentinel */
> -	}
> -};
> -
> -MODULE_DEVICE_TABLE(platform, vpbe_venc_devtype);
> -
> -static int debug = 2;
> -module_param(debug, int, 0644);
> -MODULE_PARM_DESC(debug, "Debug level 0-2");
> -
> -struct venc_state {
> -	struct v4l2_subdev sd;
> -	struct venc_callback *callback;
> -	struct venc_platform_data *pdata;
> -	struct device *pdev;
> -	u32 output;
> -	v4l2_std_id std;
> -	spinlock_t lock;
> -	void __iomem *venc_base;
> -	void __iomem *vdaccfg_reg;
> -	enum vpbe_version venc_type;
> -};
> -
> -static inline struct venc_state *to_state(struct v4l2_subdev *sd)
> -{
> -	return container_of(sd, struct venc_state, sd);
> -}
> -
> -static inline u32 venc_read(struct v4l2_subdev *sd, u32 offset)
> -{
> -	struct venc_state *venc = to_state(sd);
> -
> -	return readl(venc->venc_base + offset);
> -}
> -
> -static inline u32 venc_write(struct v4l2_subdev *sd, u32 offset, u32 val)
> -{
> -	struct venc_state *venc = to_state(sd);
> -
> -	writel(val, (venc->venc_base + offset));
> -
> -	return val;
> -}
> -
> -static inline u32 venc_modify(struct v4l2_subdev *sd, u32 offset,
> -				 u32 val, u32 mask)
> -{
> -	u32 new_val = (venc_read(sd, offset) & ~mask) | (val & mask);
> -
> -	venc_write(sd, offset, new_val);
> -
> -	return new_val;
> -}
> -
> -static inline u32 vdaccfg_write(struct v4l2_subdev *sd, u32 val)
> -{
> -	struct venc_state *venc = to_state(sd);
> -
> -	writel(val, venc->vdaccfg_reg);
> -
> -	val = readl(venc->vdaccfg_reg);
> -
> -	return val;
> -}
> -
> -#define VDAC_COMPONENT	0x543
> -#define VDAC_S_VIDEO	0x210
> -/* This function sets the dac of the VPBE for various outputs
> - */
> -static int venc_set_dac(struct v4l2_subdev *sd, u32 out_index)
> -{
> -	switch (out_index) {
> -	case 0:
> -		v4l2_dbg(debug, 1, sd, "Setting output to Composite\n");
> -		venc_write(sd, VENC_DACSEL, 0);
> -		break;
> -	case 1:
> -		v4l2_dbg(debug, 1, sd, "Setting output to Component\n");
> -		venc_write(sd, VENC_DACSEL, VDAC_COMPONENT);
> -		break;
> -	case 2:
> -		v4l2_dbg(debug, 1, sd, "Setting output to S-video\n");
> -		venc_write(sd, VENC_DACSEL, VDAC_S_VIDEO);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static void venc_enabledigitaloutput(struct v4l2_subdev *sd, int benable)
> -{
> -	struct venc_state *venc = to_state(sd);
> -
> -	v4l2_dbg(debug, 2, sd, "venc_enabledigitaloutput\n");
> -
> -	if (benable) {
> -		venc_write(sd, VENC_VMOD, 0);
> -		venc_write(sd, VENC_CVBS, 0);
> -		venc_write(sd, VENC_LCDOUT, 0);
> -		venc_write(sd, VENC_HSPLS, 0);
> -		venc_write(sd, VENC_HSTART, 0);
> -		venc_write(sd, VENC_HVALID, 0);
> -		venc_write(sd, VENC_HINT, 0);
> -		venc_write(sd, VENC_VSPLS, 0);
> -		venc_write(sd, VENC_VSTART, 0);
> -		venc_write(sd, VENC_VVALID, 0);
> -		venc_write(sd, VENC_VINT, 0);
> -		venc_write(sd, VENC_YCCCTL, 0);
> -		venc_write(sd, VENC_DACSEL, 0);
> -
> -	} else {
> -		venc_write(sd, VENC_VMOD, 0);
> -		/* disable VCLK output pin enable */
> -		venc_write(sd, VENC_VIDCTL, 0x141);
> -
> -		/* Disable output sync pins */
> -		venc_write(sd, VENC_SYNCCTL, 0);
> -
> -		/* Disable DCLOCK */
> -		venc_write(sd, VENC_DCLKCTL, 0);
> -		venc_write(sd, VENC_DRGBX1, 0x0000057C);
> -
> -		/* Disable LCD output control (accepting default polarity) */
> -		venc_write(sd, VENC_LCDOUT, 0);
> -		if (venc->venc_type != VPBE_VERSION_3)
> -			venc_write(sd, VENC_CMPNT, 0x100);
> -		venc_write(sd, VENC_HSPLS, 0);
> -		venc_write(sd, VENC_HINT, 0);
> -		venc_write(sd, VENC_HSTART, 0);
> -		venc_write(sd, VENC_HVALID, 0);
> -
> -		venc_write(sd, VENC_VSPLS, 0);
> -		venc_write(sd, VENC_VINT, 0);
> -		venc_write(sd, VENC_VSTART, 0);
> -		venc_write(sd, VENC_VVALID, 0);
> -
> -		venc_write(sd, VENC_HSDLY, 0);
> -		venc_write(sd, VENC_VSDLY, 0);
> -
> -		venc_write(sd, VENC_YCCCTL, 0);
> -		venc_write(sd, VENC_VSTARTA, 0);
> -
> -		/* Set OSD clock and OSD Sync Adavance registers */
> -		venc_write(sd, VENC_OSDCLK0, 1);
> -		venc_write(sd, VENC_OSDCLK1, 2);
> -	}
> -}
> -
> -static void
> -venc_enable_vpss_clock(int venc_type,
> -		       enum vpbe_enc_timings_type type,
> -		       unsigned int pclock)
> -{
> -	if (venc_type == VPBE_VERSION_1)
> -		return;
> -
> -	if (venc_type == VPBE_VERSION_2 && (type == VPBE_ENC_STD || (type ==
> -	    VPBE_ENC_DV_TIMINGS && pclock <= 27000000))) {
> -		vpss_enable_clock(VPSS_VENC_CLOCK_SEL, 1);
> -		vpss_enable_clock(VPSS_VPBE_CLOCK, 1);
> -		return;
> -	}
> -
> -	if (venc_type == VPBE_VERSION_3 && type == VPBE_ENC_STD)
> -		vpss_enable_clock(VPSS_VENC_CLOCK_SEL, 0);
> -}
> -
> -#define VDAC_CONFIG_SD_V3	0x0E21A6B6
> -#define VDAC_CONFIG_SD_V2	0x081141CF
> -/*
> - * setting NTSC mode
> - */
> -static int venc_set_ntsc(struct v4l2_subdev *sd)
> -{
> -	struct venc_state *venc = to_state(sd);
> -	struct venc_platform_data *pdata = venc->pdata;
> -
> -	v4l2_dbg(debug, 2, sd, "venc_set_ntsc\n");
> -
> -	/* Setup clock at VPSS & VENC for SD */
> -	vpss_enable_clock(VPSS_VENC_CLOCK_SEL, 1);
> -	if (pdata->setup_clock(VPBE_ENC_STD, V4L2_STD_525_60) < 0)
> -		return -EINVAL;
> -
> -	venc_enable_vpss_clock(venc->venc_type, VPBE_ENC_STD, V4L2_STD_525_60);
> -	venc_enabledigitaloutput(sd, 0);
> -
> -	if (venc->venc_type == VPBE_VERSION_3) {
> -		venc_write(sd, VENC_CLKCTL, 0x01);
> -		venc_write(sd, VENC_VIDCTL, 0);
> -		vdaccfg_write(sd, VDAC_CONFIG_SD_V3);
> -	} else if (venc->venc_type == VPBE_VERSION_2) {
> -		venc_write(sd, VENC_CLKCTL, 0x01);
> -		venc_write(sd, VENC_VIDCTL, 0);
> -		vdaccfg_write(sd, VDAC_CONFIG_SD_V2);
> -	} else {
> -		/* to set VENC CLK DIV to 1 - final clock is 54 MHz */
> -		venc_modify(sd, VENC_VIDCTL, 0, 1 << 1);
> -		/* Set REC656 Mode */
> -		venc_write(sd, VENC_YCCCTL, 0x1);
> -		venc_modify(sd, VENC_VDPRO, 0, VENC_VDPRO_DAFRQ);
> -		venc_modify(sd, VENC_VDPRO, 0, VENC_VDPRO_DAUPS);
> -	}
> -
> -	venc_write(sd, VENC_VMOD, 0);
> -	venc_modify(sd, VENC_VMOD, (1 << VENC_VMOD_VIE_SHIFT),
> -			VENC_VMOD_VIE);
> -	venc_modify(sd, VENC_VMOD, (0 << VENC_VMOD_VMD), VENC_VMOD_VMD);
> -	venc_modify(sd, VENC_VMOD, (0 << VENC_VMOD_TVTYP_SHIFT),
> -			VENC_VMOD_TVTYP);
> -	venc_write(sd, VENC_DACTST, 0x0);
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_VENC, VENC_VMOD_VENC);
> -
> -	return 0;
> -}
> -
> -/*
> - * setting PAL mode
> - */
> -static int venc_set_pal(struct v4l2_subdev *sd)
> -{
> -	struct venc_state *venc = to_state(sd);
> -
> -	v4l2_dbg(debug, 2, sd, "venc_set_pal\n");
> -
> -	/* Setup clock at VPSS & VENC for SD */
> -	vpss_enable_clock(VPSS_VENC_CLOCK_SEL, 1);
> -	if (venc->pdata->setup_clock(VPBE_ENC_STD, V4L2_STD_625_50) < 0)
> -		return -EINVAL;
> -
> -	venc_enable_vpss_clock(venc->venc_type, VPBE_ENC_STD, V4L2_STD_625_50);
> -	venc_enabledigitaloutput(sd, 0);
> -
> -	if (venc->venc_type == VPBE_VERSION_3) {
> -		venc_write(sd, VENC_CLKCTL, 0x1);
> -		venc_write(sd, VENC_VIDCTL, 0);
> -		vdaccfg_write(sd, VDAC_CONFIG_SD_V3);
> -	} else if (venc->venc_type == VPBE_VERSION_2) {
> -		venc_write(sd, VENC_CLKCTL, 0x1);
> -		venc_write(sd, VENC_VIDCTL, 0);
> -		vdaccfg_write(sd, VDAC_CONFIG_SD_V2);
> -	} else {
> -		/* to set VENC CLK DIV to 1 - final clock is 54 MHz */
> -		venc_modify(sd, VENC_VIDCTL, 0, 1 << 1);
> -		/* Set REC656 Mode */
> -		venc_write(sd, VENC_YCCCTL, 0x1);
> -	}
> -
> -	venc_modify(sd, VENC_SYNCCTL, 1 << VENC_SYNCCTL_OVD_SHIFT,
> -			VENC_SYNCCTL_OVD);
> -	venc_write(sd, VENC_VMOD, 0);
> -	venc_modify(sd, VENC_VMOD,
> -			(1 << VENC_VMOD_VIE_SHIFT),
> -			VENC_VMOD_VIE);
> -	venc_modify(sd, VENC_VMOD,
> -			(0 << VENC_VMOD_VMD), VENC_VMOD_VMD);
> -	venc_modify(sd, VENC_VMOD,
> -			(1 << VENC_VMOD_TVTYP_SHIFT),
> -			VENC_VMOD_TVTYP);
> -	venc_write(sd, VENC_DACTST, 0x0);
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_VENC, VENC_VMOD_VENC);
> -
> -	return 0;
> -}
> -
> -#define VDAC_CONFIG_HD_V2	0x081141EF
> -/*
> - * venc_set_480p59_94
> - *
> - * This function configures the video encoder to EDTV(525p) component setting.
> - */
> -static int venc_set_480p59_94(struct v4l2_subdev *sd)
> -{
> -	struct venc_state *venc = to_state(sd);
> -	struct venc_platform_data *pdata = venc->pdata;
> -
> -	v4l2_dbg(debug, 2, sd, "venc_set_480p59_94\n");
> -	if (venc->venc_type != VPBE_VERSION_1 &&
> -	    venc->venc_type != VPBE_VERSION_2)
> -		return -EINVAL;
> -
> -	/* Setup clock at VPSS & VENC for SD */
> -	if (pdata->setup_clock(VPBE_ENC_DV_TIMINGS, 27000000) < 0)
> -		return -EINVAL;
> -
> -	venc_enable_vpss_clock(venc->venc_type, VPBE_ENC_DV_TIMINGS, 27000000);
> -	venc_enabledigitaloutput(sd, 0);
> -
> -	if (venc->venc_type == VPBE_VERSION_2)
> -		vdaccfg_write(sd, VDAC_CONFIG_HD_V2);
> -	venc_write(sd, VENC_OSDCLK0, 0);
> -	venc_write(sd, VENC_OSDCLK1, 1);
> -
> -	if (venc->venc_type == VPBE_VERSION_1) {
> -		venc_modify(sd, VENC_VDPRO, VENC_VDPRO_DAFRQ,
> -			    VENC_VDPRO_DAFRQ);
> -		venc_modify(sd, VENC_VDPRO, VENC_VDPRO_DAUPS,
> -			    VENC_VDPRO_DAUPS);
> -	}
> -
> -	venc_write(sd, VENC_VMOD, 0);
> -	venc_modify(sd, VENC_VMOD, (1 << VENC_VMOD_VIE_SHIFT),
> -		    VENC_VMOD_VIE);
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_HDMD, VENC_VMOD_HDMD);
> -	venc_modify(sd, VENC_VMOD, (HDTV_525P << VENC_VMOD_TVTYP_SHIFT),
> -		    VENC_VMOD_TVTYP);
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_VDMD_YCBCR8 <<
> -		    VENC_VMOD_VDMD_SHIFT, VENC_VMOD_VDMD);
> -
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_VENC, VENC_VMOD_VENC);
> -
> -	return 0;
> -}
> -
> -/*
> - * venc_set_625p
> - *
> - * This function configures the video encoder to HDTV(625p) component setting
> - */
> -static int venc_set_576p50(struct v4l2_subdev *sd)
> -{
> -	struct venc_state *venc = to_state(sd);
> -	struct venc_platform_data *pdata = venc->pdata;
> -
> -	v4l2_dbg(debug, 2, sd, "venc_set_576p50\n");
> -
> -	if (venc->venc_type != VPBE_VERSION_1 &&
> -	    venc->venc_type != VPBE_VERSION_2)
> -		return -EINVAL;
> -	/* Setup clock at VPSS & VENC for SD */
> -	if (pdata->setup_clock(VPBE_ENC_DV_TIMINGS, 27000000) < 0)
> -		return -EINVAL;
> -
> -	venc_enable_vpss_clock(venc->venc_type, VPBE_ENC_DV_TIMINGS, 27000000);
> -	venc_enabledigitaloutput(sd, 0);
> -
> -	if (venc->venc_type == VPBE_VERSION_2)
> -		vdaccfg_write(sd, VDAC_CONFIG_HD_V2);
> -
> -	venc_write(sd, VENC_OSDCLK0, 0);
> -	venc_write(sd, VENC_OSDCLK1, 1);
> -
> -	if (venc->venc_type == VPBE_VERSION_1) {
> -		venc_modify(sd, VENC_VDPRO, VENC_VDPRO_DAFRQ,
> -			    VENC_VDPRO_DAFRQ);
> -		venc_modify(sd, VENC_VDPRO, VENC_VDPRO_DAUPS,
> -			    VENC_VDPRO_DAUPS);
> -	}
> -
> -	venc_write(sd, VENC_VMOD, 0);
> -	venc_modify(sd, VENC_VMOD, (1 << VENC_VMOD_VIE_SHIFT),
> -		    VENC_VMOD_VIE);
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_HDMD, VENC_VMOD_HDMD);
> -	venc_modify(sd, VENC_VMOD, (HDTV_625P << VENC_VMOD_TVTYP_SHIFT),
> -		    VENC_VMOD_TVTYP);
> -
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_VDMD_YCBCR8 <<
> -		    VENC_VMOD_VDMD_SHIFT, VENC_VMOD_VDMD);
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_VENC, VENC_VMOD_VENC);
> -
> -	return 0;
> -}
> -
> -/*
> - * venc_set_720p60_internal - Setup 720p60 in venc for dm365 only
> - */
> -static int venc_set_720p60_internal(struct v4l2_subdev *sd)
> -{
> -	struct venc_state *venc = to_state(sd);
> -	struct venc_platform_data *pdata = venc->pdata;
> -
> -	if (pdata->setup_clock(VPBE_ENC_DV_TIMINGS, 74250000) < 0)
> -		return -EINVAL;
> -
> -	venc_enable_vpss_clock(venc->venc_type, VPBE_ENC_DV_TIMINGS, 74250000);
> -	venc_enabledigitaloutput(sd, 0);
> -
> -	venc_write(sd, VENC_OSDCLK0, 0);
> -	venc_write(sd, VENC_OSDCLK1, 1);
> -
> -	venc_write(sd, VENC_VMOD, 0);
> -	/* DM365 component HD mode */
> -	venc_modify(sd, VENC_VMOD, (1 << VENC_VMOD_VIE_SHIFT),
> -	    VENC_VMOD_VIE);
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_HDMD, VENC_VMOD_HDMD);
> -	venc_modify(sd, VENC_VMOD, (HDTV_720P << VENC_VMOD_TVTYP_SHIFT),
> -		    VENC_VMOD_TVTYP);
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_VENC, VENC_VMOD_VENC);
> -	venc_write(sd, VENC_XHINTVL, 0);
> -	return 0;
> -}
> -
> -/*
> - * venc_set_1080i30_internal - Setup 1080i30 in venc for dm365 only
> - */
> -static int venc_set_1080i30_internal(struct v4l2_subdev *sd)
> -{
> -	struct venc_state *venc = to_state(sd);
> -	struct venc_platform_data *pdata = venc->pdata;
> -
> -	if (pdata->setup_clock(VPBE_ENC_DV_TIMINGS, 74250000) < 0)
> -		return -EINVAL;
> -
> -	venc_enable_vpss_clock(venc->venc_type, VPBE_ENC_DV_TIMINGS, 74250000);
> -	venc_enabledigitaloutput(sd, 0);
> -
> -	venc_write(sd, VENC_OSDCLK0, 0);
> -	venc_write(sd, VENC_OSDCLK1, 1);
> -
> -
> -	venc_write(sd, VENC_VMOD, 0);
> -	/* DM365 component HD mode */
> -	venc_modify(sd, VENC_VMOD, (1 << VENC_VMOD_VIE_SHIFT),
> -		    VENC_VMOD_VIE);
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_HDMD, VENC_VMOD_HDMD);
> -	venc_modify(sd, VENC_VMOD, (HDTV_1080I << VENC_VMOD_TVTYP_SHIFT),
> -		    VENC_VMOD_TVTYP);
> -	venc_modify(sd, VENC_VMOD, VENC_VMOD_VENC, VENC_VMOD_VENC);
> -	venc_write(sd, VENC_XHINTVL, 0);
> -	return 0;
> -}
> -
> -static int venc_s_std_output(struct v4l2_subdev *sd, v4l2_std_id norm)
> -{
> -	v4l2_dbg(debug, 1, sd, "venc_s_std_output\n");
> -
> -	if (norm & V4L2_STD_525_60)
> -		return venc_set_ntsc(sd);
> -	else if (norm & V4L2_STD_625_50)
> -		return venc_set_pal(sd);
> -
> -	return -EINVAL;
> -}
> -
> -static int venc_s_dv_timings(struct v4l2_subdev *sd,
> -			    struct v4l2_dv_timings *dv_timings)
> -{
> -	struct venc_state *venc = to_state(sd);
> -	u32 height = dv_timings->bt.height;
> -	int ret;
> -
> -	v4l2_dbg(debug, 1, sd, "venc_s_dv_timings\n");
> -
> -	if (height == 576)
> -		return venc_set_576p50(sd);
> -	else if (height == 480)
> -		return venc_set_480p59_94(sd);
> -	else if ((height == 720) &&
> -			(venc->venc_type == VPBE_VERSION_2)) {
> -		/* TBD setup internal 720p mode here */
> -		ret = venc_set_720p60_internal(sd);
> -		/* for DM365 VPBE, there is DAC inside */
> -		vdaccfg_write(sd, VDAC_CONFIG_HD_V2);
> -		return ret;
> -	} else if ((height == 1080) &&
> -		(venc->venc_type == VPBE_VERSION_2)) {
> -		/* TBD setup internal 1080i mode here */
> -		ret = venc_set_1080i30_internal(sd);
> -		/* for DM365 VPBE, there is DAC inside */
> -		vdaccfg_write(sd, VDAC_CONFIG_HD_V2);
> -		return ret;
> -	}
> -	return -EINVAL;
> -}
> -
> -static int venc_s_routing(struct v4l2_subdev *sd, u32 input, u32 output,
> -			  u32 config)
> -{
> -	struct venc_state *venc = to_state(sd);
> -	int ret;
> -
> -	v4l2_dbg(debug, 1, sd, "venc_s_routing\n");
> -
> -	ret = venc_set_dac(sd, output);
> -	if (!ret)
> -		venc->output = output;
> -
> -	return ret;
> -}
> -
> -static long venc_command(struct v4l2_subdev *sd, unsigned int cmd, void *arg)
> -{
> -	u32 val;
> -
> -	switch (cmd) {
> -	case VENC_GET_FLD:
> -		val = venc_read(sd, VENC_VSTAT);
> -		*((int *)arg) = ((val & VENC_VSTAT_FIDST) ==
> -		VENC_VSTAT_FIDST);
> -		break;
> -	default:
> -		v4l2_err(sd, "Wrong IOCTL cmd\n");
> -		break;
> -	}
> -
> -	return 0;
> -}
> -
> -static const struct v4l2_subdev_core_ops venc_core_ops = {
> -	.command      = venc_command,
> -};
> -
> -static const struct v4l2_subdev_video_ops venc_video_ops = {
> -	.s_routing = venc_s_routing,
> -	.s_std_output = venc_s_std_output,
> -	.s_dv_timings = venc_s_dv_timings,
> -};
> -
> -static const struct v4l2_subdev_ops venc_ops = {
> -	.core = &venc_core_ops,
> -	.video = &venc_video_ops,
> -};
> -
> -static int venc_initialize(struct v4l2_subdev *sd)
> -{
> -	struct venc_state *venc = to_state(sd);
> -	int ret;
> -
> -	/* Set default to output to composite and std to NTSC */
> -	venc->output = 0;
> -	venc->std = V4L2_STD_525_60;
> -
> -	ret = venc_s_routing(sd, 0, venc->output, 0);
> -	if (ret < 0) {
> -		v4l2_err(sd, "Error setting output during init\n");
> -		return -EINVAL;
> -	}
> -
> -	ret = venc_s_std_output(sd, venc->std);
> -	if (ret < 0) {
> -		v4l2_err(sd, "Error setting std during init\n");
> -		return -EINVAL;
> -	}
> -
> -	return ret;
> -}
> -
> -static int venc_device_get(struct device *dev, void *data)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct venc_state **venc = data;
> -
> -	if (strstr(pdev->name, "vpbe-venc") != NULL)
> -		*venc = platform_get_drvdata(pdev);
> -
> -	return 0;
> -}
> -
> -struct v4l2_subdev *venc_sub_dev_init(struct v4l2_device *v4l2_dev,
> -		const char *venc_name)
> -{
> -	struct venc_state *venc = NULL;
> -
> -	bus_for_each_dev(&platform_bus_type, NULL, &venc,
> -			venc_device_get);
> -	if (venc == NULL)
> -		return NULL;
> -
> -	v4l2_subdev_init(&venc->sd, &venc_ops);
> -
> -	strscpy(venc->sd.name, venc_name, sizeof(venc->sd.name));
> -	if (v4l2_device_register_subdev(v4l2_dev, &venc->sd) < 0) {
> -		v4l2_err(v4l2_dev,
> -			"vpbe unable to register venc sub device\n");
> -		return NULL;
> -	}
> -	if (venc_initialize(&venc->sd)) {
> -		v4l2_err(v4l2_dev,
> -			"vpbe venc initialization failed\n");
> -		return NULL;
> -	}
> -
> -	return &venc->sd;
> -}
> -EXPORT_SYMBOL(venc_sub_dev_init);
> -
> -static int venc_probe(struct platform_device *pdev)
> -{
> -	const struct platform_device_id *pdev_id;
> -	struct venc_state *venc;
> -
> -	if (!pdev->dev.platform_data) {
> -		dev_err(&pdev->dev, "No platform data for VENC sub device");
> -		return -EINVAL;
> -	}
> -
> -	pdev_id = platform_get_device_id(pdev);
> -	if (!pdev_id)
> -		return -EINVAL;
> -
> -	venc = devm_kzalloc(&pdev->dev, sizeof(struct venc_state), GFP_KERNEL);
> -	if (venc == NULL)
> -		return -ENOMEM;
> -
> -	venc->venc_type = pdev_id->driver_data;
> -	venc->pdev = &pdev->dev;
> -	venc->pdata = pdev->dev.platform_data;
> -
> -	venc->venc_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(venc->venc_base))
> -		return PTR_ERR(venc->venc_base);
> -
> -	if (venc->venc_type != VPBE_VERSION_1) {
> -		venc->vdaccfg_reg = devm_platform_ioremap_resource(pdev, 1);
> -		if (IS_ERR(venc->vdaccfg_reg))
> -			return PTR_ERR(venc->vdaccfg_reg);
> -	}
> -	spin_lock_init(&venc->lock);
> -	platform_set_drvdata(pdev, venc);
> -	dev_notice(venc->pdev, "VENC sub device probe success\n");
> -
> -	return 0;
> -}
> -
> -static int venc_remove(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
> -static struct platform_driver venc_driver = {
> -	.probe		= venc_probe,
> -	.remove		= venc_remove,
> -	.driver		= {
> -		.name	= MODULE_NAME,
> -	},
> -	.id_table	= vpbe_venc_devtype
> -};
> -
> -module_platform_driver(venc_driver);
> -
> -MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("VPBE VENC Driver");
> -MODULE_AUTHOR("Texas Instruments");
> diff --git a/drivers/media/platform/ti/davinci/vpbe_venc_regs.h b/drivers/media/platform/ti/davinci/vpbe_venc_regs.h
> deleted file mode 100644
> index 29d8fc3af662..000000000000
> --- a/drivers/media/platform/ti/davinci/vpbe_venc_regs.h
> +++ /dev/null
> @@ -1,165 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2006-2010 Texas Instruments Inc
> - */
> -#ifndef _VPBE_VENC_REGS_H
> -#define _VPBE_VENC_REGS_H
> -
> -/* VPBE Video Encoder / Digital LCD Subsystem Registers (VENC) */
> -#define VENC_VMOD				0x00
> -#define VENC_VIDCTL				0x04
> -#define VENC_VDPRO				0x08
> -#define VENC_SYNCCTL				0x0C
> -#define VENC_HSPLS				0x10
> -#define VENC_VSPLS				0x14
> -#define VENC_HINT				0x18
> -#define VENC_HSTART				0x1C
> -#define VENC_HVALID				0x20
> -#define VENC_VINT				0x24
> -#define VENC_VSTART				0x28
> -#define VENC_VVALID				0x2C
> -#define VENC_HSDLY				0x30
> -#define VENC_VSDLY				0x34
> -#define VENC_YCCCTL				0x38
> -#define VENC_RGBCTL				0x3C
> -#define VENC_RGBCLP				0x40
> -#define VENC_LINECTL				0x44
> -#define VENC_CULLLINE				0x48
> -#define VENC_LCDOUT				0x4C
> -#define VENC_BRTS				0x50
> -#define VENC_BRTW				0x54
> -#define VENC_ACCTL				0x58
> -#define VENC_PWMP				0x5C
> -#define VENC_PWMW				0x60
> -#define VENC_DCLKCTL				0x64
> -#define VENC_DCLKPTN0				0x68
> -#define VENC_DCLKPTN1				0x6C
> -#define VENC_DCLKPTN2				0x70
> -#define VENC_DCLKPTN3				0x74
> -#define VENC_DCLKPTN0A				0x78
> -#define VENC_DCLKPTN1A				0x7C
> -#define VENC_DCLKPTN2A				0x80
> -#define VENC_DCLKPTN3A				0x84
> -#define VENC_DCLKHS				0x88
> -#define VENC_DCLKHSA				0x8C
> -#define VENC_DCLKHR				0x90
> -#define VENC_DCLKVS				0x94
> -#define VENC_DCLKVR				0x98
> -#define VENC_CAPCTL				0x9C
> -#define VENC_CAPDO				0xA0
> -#define VENC_CAPDE				0xA4
> -#define VENC_ATR0				0xA8
> -#define VENC_ATR1				0xAC
> -#define VENC_ATR2				0xB0
> -#define VENC_VSTAT				0xB8
> -#define VENC_RAMADR				0xBC
> -#define VENC_RAMPORT				0xC0
> -#define VENC_DACTST				0xC4
> -#define VENC_YCOLVL				0xC8
> -#define VENC_SCPROG				0xCC
> -#define VENC_CVBS				0xDC
> -#define VENC_CMPNT				0xE0
> -#define VENC_ETMG0				0xE4
> -#define VENC_ETMG1				0xE8
> -#define VENC_ETMG2				0xEC
> -#define VENC_ETMG3				0xF0
> -#define VENC_DACSEL				0xF4
> -#define VENC_ARGBX0				0x100
> -#define VENC_ARGBX1				0x104
> -#define VENC_ARGBX2				0x108
> -#define VENC_ARGBX3				0x10C
> -#define VENC_ARGBX4				0x110
> -#define VENC_DRGBX0				0x114
> -#define VENC_DRGBX1				0x118
> -#define VENC_DRGBX2				0x11C
> -#define VENC_DRGBX3				0x120
> -#define VENC_DRGBX4				0x124
> -#define VENC_VSTARTA				0x128
> -#define VENC_OSDCLK0				0x12C
> -#define VENC_OSDCLK1				0x130
> -#define VENC_HVLDCL0				0x134
> -#define VENC_HVLDCL1				0x138
> -#define VENC_OSDHADV				0x13C
> -#define VENC_CLKCTL				0x140
> -#define VENC_GAMCTL				0x144
> -#define VENC_XHINTVL				0x174
> -
> -/* bit definitions */
> -#define VPBE_PCR_VENC_DIV			(1 << 1)
> -#define VPBE_PCR_CLK_OFF			(1 << 0)
> -
> -#define VENC_VMOD_VDMD_SHIFT			12
> -#define VENC_VMOD_VDMD_YCBCR16			0
> -#define VENC_VMOD_VDMD_YCBCR8			1
> -#define VENC_VMOD_VDMD_RGB666			2
> -#define VENC_VMOD_VDMD_RGB8			3
> -#define VENC_VMOD_VDMD_EPSON			4
> -#define VENC_VMOD_VDMD_CASIO			5
> -#define VENC_VMOD_VDMD_UDISPQVGA		6
> -#define VENC_VMOD_VDMD_STNLCD			7
> -#define VENC_VMOD_VIE_SHIFT			1
> -#define VENC_VMOD_VDMD				(7 << 12)
> -#define VENC_VMOD_ITLCL				(1 << 11)
> -#define VENC_VMOD_ITLC				(1 << 10)
> -#define VENC_VMOD_NSIT				(1 << 9)
> -#define VENC_VMOD_HDMD				(1 << 8)
> -#define VENC_VMOD_TVTYP_SHIFT			6
> -#define VENC_VMOD_TVTYP				(3 << 6)
> -#define VENC_VMOD_SLAVE				(1 << 5)
> -#define VENC_VMOD_VMD				(1 << 4)
> -#define VENC_VMOD_BLNK				(1 << 3)
> -#define VENC_VMOD_VIE				(1 << 1)
> -#define VENC_VMOD_VENC				(1 << 0)
> -
> -/* VMOD TVTYP options for HDMD=0 */
> -#define SDTV_NTSC				0
> -#define SDTV_PAL				1
> -/* VMOD TVTYP options for HDMD=1 */
> -#define HDTV_525P				0
> -#define HDTV_625P				1
> -#define HDTV_1080I				2
> -#define HDTV_720P				3
> -
> -#define VENC_VIDCTL_VCLKP			(1 << 14)
> -#define VENC_VIDCTL_VCLKE_SHIFT			13
> -#define VENC_VIDCTL_VCLKE			(1 << 13)
> -#define VENC_VIDCTL_VCLKZ_SHIFT			12
> -#define VENC_VIDCTL_VCLKZ			(1 << 12)
> -#define VENC_VIDCTL_SYDIR_SHIFT			8
> -#define VENC_VIDCTL_SYDIR			(1 << 8)
> -#define VENC_VIDCTL_DOMD_SHIFT			4
> -#define VENC_VIDCTL_DOMD			(3 << 4)
> -#define VENC_VIDCTL_YCDIR_SHIFT			0
> -#define VENC_VIDCTL_YCDIR			(1 << 0)
> -
> -#define VENC_VDPRO_ATYCC_SHIFT			5
> -#define VENC_VDPRO_ATYCC			(1 << 5)
> -#define VENC_VDPRO_ATCOM_SHIFT			4
> -#define VENC_VDPRO_ATCOM			(1 << 4)
> -#define VENC_VDPRO_DAFRQ			(1 << 3)
> -#define VENC_VDPRO_DAUPS			(1 << 2)
> -#define VENC_VDPRO_CUPS				(1 << 1)
> -#define VENC_VDPRO_YUPS				(1 << 0)
> -
> -#define VENC_SYNCCTL_VPL_SHIFT			3
> -#define VENC_SYNCCTL_VPL			(1 << 3)
> -#define VENC_SYNCCTL_HPL_SHIFT			2
> -#define VENC_SYNCCTL_HPL			(1 << 2)
> -#define VENC_SYNCCTL_SYEV_SHIFT			1
> -#define VENC_SYNCCTL_SYEV			(1 << 1)
> -#define VENC_SYNCCTL_SYEH_SHIFT			0
> -#define VENC_SYNCCTL_SYEH			(1 << 0)
> -#define VENC_SYNCCTL_OVD_SHIFT			14
> -#define VENC_SYNCCTL_OVD			(1 << 14)
> -
> -#define VENC_DCLKCTL_DCKEC_SHIFT		11
> -#define VENC_DCLKCTL_DCKEC			(1 << 11)
> -#define VENC_DCLKCTL_DCKPW_SHIFT		0
> -#define VENC_DCLKCTL_DCKPW			(0x3f << 0)
> -
> -#define VENC_VSTAT_FIDST			(1 << 4)
> -
> -#define VENC_CMPNT_MRGB_SHIFT			14
> -#define VENC_CMPNT_MRGB				(1 << 14)
> -
> -#endif				/* _VPBE_VENC_REGS_H */
> diff --git a/drivers/media/platform/ti/davinci/vpss.c b/drivers/media/platform/ti/davinci/vpss.c
> deleted file mode 100644
> index d15b991ab17c..000000000000
> --- a/drivers/media/platform/ti/davinci/vpss.c
> +++ /dev/null
> @@ -1,529 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright (C) 2009 Texas Instruments.
> - *
> - * common vpss system module platform driver for all video drivers.
> - */
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/io.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/err.h>
> -
> -#include <media/davinci/vpss.h>
> -
> -MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("VPSS Driver");
> -MODULE_AUTHOR("Texas Instruments");
> -
> -/* DM644x defines */
> -#define DM644X_SBL_PCR_VPSS		(4)
> -
> -#define DM355_VPSSBL_INTSEL		0x10
> -#define DM355_VPSSBL_EVTSEL		0x14
> -/* vpss BL register offsets */
> -#define DM355_VPSSBL_CCDCMUX		0x1c
> -/* vpss CLK register offsets */
> -#define DM355_VPSSCLK_CLKCTRL		0x04
> -/* masks and shifts */
> -#define VPSS_HSSISEL_SHIFT		4
> -/*
> - * VDINT0 - vpss_int0, VDINT1 - vpss_int1, H3A - vpss_int4,
> - * IPIPE_INT1_SDR - vpss_int5
> - */
> -#define DM355_VPSSBL_INTSEL_DEFAULT	0xff83ff10
> -/* VENCINT - vpss_int8 */
> -#define DM355_VPSSBL_EVTSEL_DEFAULT	0x4
> -
> -#define DM365_ISP5_PCCR				0x04
> -#define DM365_ISP5_PCCR_BL_CLK_ENABLE		BIT(0)
> -#define DM365_ISP5_PCCR_ISIF_CLK_ENABLE		BIT(1)
> -#define DM365_ISP5_PCCR_H3A_CLK_ENABLE		BIT(2)
> -#define DM365_ISP5_PCCR_RSZ_CLK_ENABLE		BIT(3)
> -#define DM365_ISP5_PCCR_IPIPE_CLK_ENABLE	BIT(4)
> -#define DM365_ISP5_PCCR_IPIPEIF_CLK_ENABLE	BIT(5)
> -#define DM365_ISP5_PCCR_RSV			BIT(6)
> -
> -#define DM365_ISP5_BCR			0x08
> -#define DM365_ISP5_BCR_ISIF_OUT_ENABLE	BIT(1)
> -
> -#define DM365_ISP5_INTSEL1		0x10
> -#define DM365_ISP5_INTSEL2		0x14
> -#define DM365_ISP5_INTSEL3		0x18
> -#define DM365_ISP5_CCDCMUX		0x20
> -#define DM365_ISP5_PG_FRAME_SIZE	0x28
> -#define DM365_VPBE_CLK_CTRL		0x00
> -
> -#define VPSS_CLK_CTRL			0x01c40044
> -#define VPSS_CLK_CTRL_VENCCLKEN		BIT(3)
> -#define VPSS_CLK_CTRL_DACCLKEN		BIT(4)
> -
> -/*
> - * vpss interrupts. VDINT0 - vpss_int0, VDINT1 - vpss_int1,
> - * AF - vpss_int3
> - */
> -#define DM365_ISP5_INTSEL1_DEFAULT	0x0b1f0100
> -/* AEW - vpss_int6, RSZ_INT_DMA - vpss_int5 */
> -#define DM365_ISP5_INTSEL2_DEFAULT	0x1f0a0f1f
> -/* VENC - vpss_int8 */
> -#define DM365_ISP5_INTSEL3_DEFAULT	0x00000015
> -
> -/* masks and shifts for DM365*/
> -#define DM365_CCDC_PG_VD_POL_SHIFT	0
> -#define DM365_CCDC_PG_HD_POL_SHIFT	1
> -
> -#define CCD_SRC_SEL_MASK		(BIT_MASK(5) | BIT_MASK(4))
> -#define CCD_SRC_SEL_SHIFT		4
> -
> -/* Different SoC platforms supported by this driver */
> -enum vpss_platform_type {
> -	DM644X,
> -	DM355,
> -	DM365,
> -};
> -
> -/*
> - * vpss operations. Depends on platform. Not all functions are available
> - * on all platforms. The api, first check if a function is available before
> - * invoking it. In the probe, the function ptrs are initialized based on
> - * vpss name. vpss name can be "dm355_vpss", "dm644x_vpss" etc.
> - */
> -struct vpss_hw_ops {
> -	/* enable clock */
> -	int (*enable_clock)(enum vpss_clock_sel clock_sel, int en);
> -	/* select input to ccdc */
> -	void (*select_ccdc_source)(enum vpss_ccdc_source_sel src_sel);
> -	/* clear wbl overflow bit */
> -	int (*clear_wbl_overflow)(enum vpss_wbl_sel wbl_sel);
> -	/* set sync polarity */
> -	void (*set_sync_pol)(struct vpss_sync_pol);
> -	/* set the PG_FRAME_SIZE register*/
> -	void (*set_pg_frame_size)(struct vpss_pg_frame_size);
> -	/* check and clear interrupt if occurred */
> -	int (*dma_complete_interrupt)(void);
> -};
> -
> -/* vpss configuration */
> -struct vpss_oper_config {
> -	__iomem void *vpss_regs_base0;
> -	__iomem void *vpss_regs_base1;
> -	__iomem void *vpss_regs_base2;
> -	enum vpss_platform_type platform;
> -	spinlock_t vpss_lock;
> -	struct vpss_hw_ops hw_ops;
> -};
> -
> -static struct vpss_oper_config oper_cfg;
> -
> -/* register access routines */
> -static inline u32 bl_regr(u32 offset)
> -{
> -	return __raw_readl(oper_cfg.vpss_regs_base0 + offset);
> -}
> -
> -static inline void bl_regw(u32 val, u32 offset)
> -{
> -	__raw_writel(val, oper_cfg.vpss_regs_base0 + offset);
> -}
> -
> -static inline u32 vpss_regr(u32 offset)
> -{
> -	return __raw_readl(oper_cfg.vpss_regs_base1 + offset);
> -}
> -
> -static inline void vpss_regw(u32 val, u32 offset)
> -{
> -	__raw_writel(val, oper_cfg.vpss_regs_base1 + offset);
> -}
> -
> -/* For DM365 only */
> -static inline u32 isp5_read(u32 offset)
> -{
> -	return __raw_readl(oper_cfg.vpss_regs_base0 + offset);
> -}
> -
> -/* For DM365 only */
> -static inline void isp5_write(u32 val, u32 offset)
> -{
> -	__raw_writel(val, oper_cfg.vpss_regs_base0 + offset);
> -}
> -
> -static void dm365_select_ccdc_source(enum vpss_ccdc_source_sel src_sel)
> -{
> -	u32 temp = isp5_read(DM365_ISP5_CCDCMUX) & ~CCD_SRC_SEL_MASK;
> -
> -	/* if we are using pattern generator, enable it */
> -	if (src_sel == VPSS_PGLPBK || src_sel == VPSS_CCDCPG)
> -		temp |= 0x08;
> -
> -	temp |= (src_sel << CCD_SRC_SEL_SHIFT);
> -	isp5_write(temp, DM365_ISP5_CCDCMUX);
> -}
> -
> -static void dm355_select_ccdc_source(enum vpss_ccdc_source_sel src_sel)
> -{
> -	bl_regw(src_sel << VPSS_HSSISEL_SHIFT, DM355_VPSSBL_CCDCMUX);
> -}
> -
> -int vpss_dma_complete_interrupt(void)
> -{
> -	if (!oper_cfg.hw_ops.dma_complete_interrupt)
> -		return 2;
> -	return oper_cfg.hw_ops.dma_complete_interrupt();
> -}
> -EXPORT_SYMBOL(vpss_dma_complete_interrupt);
> -
> -int vpss_select_ccdc_source(enum vpss_ccdc_source_sel src_sel)
> -{
> -	if (!oper_cfg.hw_ops.select_ccdc_source)
> -		return -EINVAL;
> -
> -	oper_cfg.hw_ops.select_ccdc_source(src_sel);
> -	return 0;
> -}
> -EXPORT_SYMBOL(vpss_select_ccdc_source);
> -
> -static int dm644x_clear_wbl_overflow(enum vpss_wbl_sel wbl_sel)
> -{
> -	u32 mask = 1, val;
> -
> -	if (wbl_sel < VPSS_PCR_AEW_WBL_0 ||
> -	    wbl_sel > VPSS_PCR_CCDC_WBL_O)
> -		return -EINVAL;
> -
> -	/* writing a 0 clear the overflow */
> -	mask = ~(mask << wbl_sel);
> -	val = bl_regr(DM644X_SBL_PCR_VPSS) & mask;
> -	bl_regw(val, DM644X_SBL_PCR_VPSS);
> -	return 0;
> -}
> -
> -void vpss_set_sync_pol(struct vpss_sync_pol sync)
> -{
> -	if (!oper_cfg.hw_ops.set_sync_pol)
> -		return;
> -
> -	oper_cfg.hw_ops.set_sync_pol(sync);
> -}
> -EXPORT_SYMBOL(vpss_set_sync_pol);
> -
> -int vpss_clear_wbl_overflow(enum vpss_wbl_sel wbl_sel)
> -{
> -	if (!oper_cfg.hw_ops.clear_wbl_overflow)
> -		return -EINVAL;
> -
> -	return oper_cfg.hw_ops.clear_wbl_overflow(wbl_sel);
> -}
> -EXPORT_SYMBOL(vpss_clear_wbl_overflow);
> -
> -/*
> - *  dm355_enable_clock - Enable VPSS Clock
> - *  @clock_sel: Clock to be enabled/disabled
> - *  @en: enable/disable flag
> - *
> - *  This is called to enable or disable a vpss clock
> - */
> -static int dm355_enable_clock(enum vpss_clock_sel clock_sel, int en)
> -{
> -	unsigned long flags;
> -	u32 utemp, mask = 0x1, shift = 0;
> -
> -	switch (clock_sel) {
> -	case VPSS_VPBE_CLOCK:
> -		/* nothing since lsb */
> -		break;
> -	case VPSS_VENC_CLOCK_SEL:
> -		shift = 2;
> -		break;
> -	case VPSS_CFALD_CLOCK:
> -		shift = 3;
> -		break;
> -	case VPSS_H3A_CLOCK:
> -		shift = 4;
> -		break;
> -	case VPSS_IPIPE_CLOCK:
> -		shift = 5;
> -		break;
> -	case VPSS_CCDC_CLOCK:
> -		shift = 6;
> -		break;
> -	default:
> -		printk(KERN_ERR "dm355_enable_clock: Invalid selector: %d\n",
> -		       clock_sel);
> -		return -EINVAL;
> -	}
> -
> -	spin_lock_irqsave(&oper_cfg.vpss_lock, flags);
> -	utemp = vpss_regr(DM355_VPSSCLK_CLKCTRL);
> -	if (!en)
> -		utemp &= ~(mask << shift);
> -	else
> -		utemp |= (mask << shift);
> -
> -	vpss_regw(utemp, DM355_VPSSCLK_CLKCTRL);
> -	spin_unlock_irqrestore(&oper_cfg.vpss_lock, flags);
> -	return 0;
> -}
> -
> -static int dm365_enable_clock(enum vpss_clock_sel clock_sel, int en)
> -{
> -	unsigned long flags;
> -	u32 utemp, mask = 0x1, shift = 0, offset = DM365_ISP5_PCCR;
> -	u32 (*read)(u32 offset) = isp5_read;
> -	void(*write)(u32 val, u32 offset) = isp5_write;
> -
> -	switch (clock_sel) {
> -	case VPSS_BL_CLOCK:
> -		break;
> -	case VPSS_CCDC_CLOCK:
> -		shift = 1;
> -		break;
> -	case VPSS_H3A_CLOCK:
> -		shift = 2;
> -		break;
> -	case VPSS_RSZ_CLOCK:
> -		shift = 3;
> -		break;
> -	case VPSS_IPIPE_CLOCK:
> -		shift = 4;
> -		break;
> -	case VPSS_IPIPEIF_CLOCK:
> -		shift = 5;
> -		break;
> -	case VPSS_PCLK_INTERNAL:
> -		shift = 6;
> -		break;
> -	case VPSS_PSYNC_CLOCK_SEL:
> -		shift = 7;
> -		break;
> -	case VPSS_VPBE_CLOCK:
> -		read = vpss_regr;
> -		write = vpss_regw;
> -		offset = DM365_VPBE_CLK_CTRL;
> -		break;
> -	case VPSS_VENC_CLOCK_SEL:
> -		shift = 2;
> -		read = vpss_regr;
> -		write = vpss_regw;
> -		offset = DM365_VPBE_CLK_CTRL;
> -		break;
> -	case VPSS_LDC_CLOCK:
> -		shift = 3;
> -		read = vpss_regr;
> -		write = vpss_regw;
> -		offset = DM365_VPBE_CLK_CTRL;
> -		break;
> -	case VPSS_FDIF_CLOCK:
> -		shift = 4;
> -		read = vpss_regr;
> -		write = vpss_regw;
> -		offset = DM365_VPBE_CLK_CTRL;
> -		break;
> -	case VPSS_OSD_CLOCK_SEL:
> -		shift = 6;
> -		read = vpss_regr;
> -		write = vpss_regw;
> -		offset = DM365_VPBE_CLK_CTRL;
> -		break;
> -	case VPSS_LDC_CLOCK_SEL:
> -		shift = 7;
> -		read = vpss_regr;
> -		write = vpss_regw;
> -		offset = DM365_VPBE_CLK_CTRL;
> -		break;
> -	default:
> -		printk(KERN_ERR "dm365_enable_clock: Invalid selector: %d\n",
> -		       clock_sel);
> -		return -1;
> -	}
> -
> -	spin_lock_irqsave(&oper_cfg.vpss_lock, flags);
> -	utemp = read(offset);
> -	if (!en) {
> -		mask = ~mask;
> -		utemp &= (mask << shift);
> -	} else
> -		utemp |= (mask << shift);
> -
> -	write(utemp, offset);
> -	spin_unlock_irqrestore(&oper_cfg.vpss_lock, flags);
> -
> -	return 0;
> -}
> -
> -int vpss_enable_clock(enum vpss_clock_sel clock_sel, int en)
> -{
> -	if (!oper_cfg.hw_ops.enable_clock)
> -		return -EINVAL;
> -
> -	return oper_cfg.hw_ops.enable_clock(clock_sel, en);
> -}
> -EXPORT_SYMBOL(vpss_enable_clock);
> -
> -void dm365_vpss_set_sync_pol(struct vpss_sync_pol sync)
> -{
> -	int val = 0;
> -	val = isp5_read(DM365_ISP5_CCDCMUX);
> -
> -	val |= (sync.ccdpg_hdpol << DM365_CCDC_PG_HD_POL_SHIFT);
> -	val |= (sync.ccdpg_vdpol << DM365_CCDC_PG_VD_POL_SHIFT);
> -
> -	isp5_write(val, DM365_ISP5_CCDCMUX);
> -}
> -EXPORT_SYMBOL(dm365_vpss_set_sync_pol);
> -
> -void vpss_set_pg_frame_size(struct vpss_pg_frame_size frame_size)
> -{
> -	if (!oper_cfg.hw_ops.set_pg_frame_size)
> -		return;
> -
> -	oper_cfg.hw_ops.set_pg_frame_size(frame_size);
> -}
> -EXPORT_SYMBOL(vpss_set_pg_frame_size);
> -
> -void dm365_vpss_set_pg_frame_size(struct vpss_pg_frame_size frame_size)
> -{
> -	int current_reg = ((frame_size.hlpfr >> 1) - 1) << 16;
> -
> -	current_reg |= (frame_size.pplen - 1);
> -	isp5_write(current_reg, DM365_ISP5_PG_FRAME_SIZE);
> -}
> -EXPORT_SYMBOL(dm365_vpss_set_pg_frame_size);
> -
> -static int vpss_probe(struct platform_device *pdev)
> -{
> -	char *platform_name;
> -
> -	if (!pdev->dev.platform_data) {
> -		dev_err(&pdev->dev, "no platform data\n");
> -		return -ENOENT;
> -	}
> -
> -	platform_name = pdev->dev.platform_data;
> -	if (!strcmp(platform_name, "dm355_vpss"))
> -		oper_cfg.platform = DM355;
> -	else if (!strcmp(platform_name, "dm365_vpss"))
> -		oper_cfg.platform = DM365;
> -	else if (!strcmp(platform_name, "dm644x_vpss"))
> -		oper_cfg.platform = DM644X;
> -	else {
> -		dev_err(&pdev->dev, "vpss driver not supported on this platform\n");
> -		return -ENODEV;
> -	}
> -
> -	dev_info(&pdev->dev, "%s vpss probed\n", platform_name);
> -	oper_cfg.vpss_regs_base0 = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(oper_cfg.vpss_regs_base0))
> -		return PTR_ERR(oper_cfg.vpss_regs_base0);
> -
> -	if (oper_cfg.platform == DM355 || oper_cfg.platform == DM365) {
> -		oper_cfg.vpss_regs_base1 = devm_platform_ioremap_resource(pdev, 1);
> -		if (IS_ERR(oper_cfg.vpss_regs_base1))
> -			return PTR_ERR(oper_cfg.vpss_regs_base1);
> -	}
> -
> -	if (oper_cfg.platform == DM355) {
> -		oper_cfg.hw_ops.enable_clock = dm355_enable_clock;
> -		oper_cfg.hw_ops.select_ccdc_source = dm355_select_ccdc_source;
> -		/* Setup vpss interrupts */
> -		bl_regw(DM355_VPSSBL_INTSEL_DEFAULT, DM355_VPSSBL_INTSEL);
> -		bl_regw(DM355_VPSSBL_EVTSEL_DEFAULT, DM355_VPSSBL_EVTSEL);
> -	} else if (oper_cfg.platform == DM365) {
> -		oper_cfg.hw_ops.enable_clock = dm365_enable_clock;
> -		oper_cfg.hw_ops.select_ccdc_source = dm365_select_ccdc_source;
> -		/* Setup vpss interrupts */
> -		isp5_write((isp5_read(DM365_ISP5_PCCR) |
> -				      DM365_ISP5_PCCR_BL_CLK_ENABLE |
> -				      DM365_ISP5_PCCR_ISIF_CLK_ENABLE |
> -				      DM365_ISP5_PCCR_H3A_CLK_ENABLE |
> -				      DM365_ISP5_PCCR_RSZ_CLK_ENABLE |
> -				      DM365_ISP5_PCCR_IPIPE_CLK_ENABLE |
> -				      DM365_ISP5_PCCR_IPIPEIF_CLK_ENABLE |
> -				      DM365_ISP5_PCCR_RSV), DM365_ISP5_PCCR);
> -		isp5_write((isp5_read(DM365_ISP5_BCR) |
> -			    DM365_ISP5_BCR_ISIF_OUT_ENABLE), DM365_ISP5_BCR);
> -		isp5_write(DM365_ISP5_INTSEL1_DEFAULT, DM365_ISP5_INTSEL1);
> -		isp5_write(DM365_ISP5_INTSEL2_DEFAULT, DM365_ISP5_INTSEL2);
> -		isp5_write(DM365_ISP5_INTSEL3_DEFAULT, DM365_ISP5_INTSEL3);
> -	} else
> -		oper_cfg.hw_ops.clear_wbl_overflow = dm644x_clear_wbl_overflow;
> -
> -	pm_runtime_enable(&pdev->dev);
> -
> -	pm_runtime_get(&pdev->dev);
> -
> -	spin_lock_init(&oper_cfg.vpss_lock);
> -	dev_info(&pdev->dev, "%s vpss probe success\n", platform_name);
> -
> -	return 0;
> -}
> -
> -static int vpss_remove(struct platform_device *pdev)
> -{
> -	pm_runtime_disable(&pdev->dev);
> -	return 0;
> -}
> -
> -static int vpss_suspend(struct device *dev)
> -{
> -	pm_runtime_put(dev);
> -	return 0;
> -}
> -
> -static int vpss_resume(struct device *dev)
> -{
> -	pm_runtime_get(dev);
> -	return 0;
> -}
> -
> -static const struct dev_pm_ops vpss_pm_ops = {
> -	.suspend = vpss_suspend,
> -	.resume = vpss_resume,
> -};
> -
> -static struct platform_driver vpss_driver = {
> -	.driver = {
> -		.name	= "vpss",
> -		.pm = &vpss_pm_ops,
> -	},
> -	.remove = vpss_remove,
> -	.probe = vpss_probe,
> -};
> -
> -static void vpss_exit(void)
> -{
> -	platform_driver_unregister(&vpss_driver);
> -	iounmap(oper_cfg.vpss_regs_base2);
> -	release_mem_region(VPSS_CLK_CTRL, 4);
> -}
> -
> -static int __init vpss_init(void)
> -{
> -	int ret;
> -
> -	if (!request_mem_region(VPSS_CLK_CTRL, 4, "vpss_clock_control"))
> -		return -EBUSY;
> -
> -	oper_cfg.vpss_regs_base2 = ioremap(VPSS_CLK_CTRL, 4);
> -	if (unlikely(!oper_cfg.vpss_regs_base2)) {
> -		ret = -ENOMEM;
> -		goto err_ioremap;
> -	}
> -
> -	writel(VPSS_CLK_CTRL_VENCCLKEN |
> -	       VPSS_CLK_CTRL_DACCLKEN, oper_cfg.vpss_regs_base2);
> -
> -	ret = platform_driver_register(&vpss_driver);
> -	if (ret)
> -		goto err_pd_register;
> -
> -	return 0;
> -
> -err_pd_register:
> -	iounmap(oper_cfg.vpss_regs_base2);
> -err_ioremap:
> -	release_mem_region(VPSS_CLK_CTRL, 4);
> -	return ret;
> -}
> -subsys_initcall(vpss_init);
> -module_exit(vpss_exit);
> diff --git a/include/media/davinci/vpbe.h b/include/media/davinci/vpbe.h
> deleted file mode 100644
> index e74a93475d21..000000000000
> --- a/include/media/davinci/vpbe.h
> +++ /dev/null
> @@ -1,184 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2010 Texas Instruments Inc
> - */
> -#ifndef _VPBE_H
> -#define _VPBE_H
> -
> -#include <linux/videodev2.h>
> -#include <linux/i2c.h>
> -
> -#include <media/v4l2-dev.h>
> -#include <media/v4l2-ioctl.h>
> -#include <media/v4l2-device.h>
> -#include <media/davinci/vpbe_osd.h>
> -#include <media/davinci/vpbe_venc.h>
> -#include <media/davinci/vpbe_types.h>
> -
> -/* OSD configuration info */
> -struct osd_config_info {
> -	char module_name[32];
> -};
> -
> -struct vpbe_output {
> -	struct v4l2_output output;
> -	/*
> -	 * If output capabilities include dv_timings, list supported timings
> -	 * below
> -	 */
> -	char *subdev_name;
> -	/*
> -	 * defualt_mode identifies the default timings set at the venc or
> -	 * external encoder.
> -	 */
> -	char *default_mode;
> -	/*
> -	 * Fields below are used for supporting multiple modes. For example,
> -	 * LCD panel might support different modes and they are listed here.
> -	 * Similarly for supporting external encoders, lcd controller port
> -	 * requires a set of non-standard timing values to be listed here for
> -	 * each supported mode since venc is used in non-standard timing mode
> -	 * for interfacing with external encoder similar to configuring lcd
> -	 * panel timings
> -	 */
> -	unsigned int num_modes;
> -	struct vpbe_enc_mode_info *modes;
> -	/*
> -	 * Bus configuration goes here for external encoders. Some encoders
> -	 * may require multiple interface types for each of the output. For
> -	 * example, SD modes would use YCC8 where as HD mode would use YCC16.
> -	 * Not sure if this is needed on a per mode basis instead of per
> -	 * output basis. If per mode is needed, we may have to move this to
> -	 * mode_info structure
> -	 */
> -	u32 if_params;
> -};
> -
> -/* encoder configuration info */
> -struct encoder_config_info {
> -	char module_name[32];
> -	/* Is this an i2c device ? */
> -	unsigned int is_i2c:1;
> -	/* i2c subdevice board info */
> -	struct i2c_board_info board_info;
> -};
> -
> -/*amplifier configuration info */
> -struct amp_config_info {
> -	char module_name[32];
> -	/* Is this an i2c device ? */
> -	unsigned int is_i2c:1;
> -	/* i2c subdevice board info */
> -	struct i2c_board_info board_info;
> -};
> -
> -/* structure for defining vpbe display subsystem components */
> -struct vpbe_config {
> -	char module_name[32];
> -	/* i2c bus adapter no */
> -	int i2c_adapter_id;
> -	struct osd_config_info osd;
> -	struct encoder_config_info venc;
> -	/* external encoder information goes here */
> -	int num_ext_encoders;
> -	struct encoder_config_info *ext_encoders;
> -	/* amplifier information goes here */
> -	struct amp_config_info *amp;
> -	unsigned int num_outputs;
> -	/* Order is venc outputs followed by LCD and then external encoders */
> -	struct vpbe_output *outputs;
> -};
> -
> -struct vpbe_device;
> -
> -struct vpbe_device_ops {
> -	/* Enumerate the outputs */
> -	int (*enum_outputs)(struct vpbe_device *vpbe_dev,
> -			    struct v4l2_output *output);
> -
> -	/* Set output to the given index */
> -	int (*set_output)(struct vpbe_device *vpbe_dev,
> -			 int index);
> -
> -	/* Get current output */
> -	unsigned int (*get_output)(struct vpbe_device *vpbe_dev);
> -
> -	/* Set DV preset at current output */
> -	int (*s_dv_timings)(struct vpbe_device *vpbe_dev,
> -			   struct v4l2_dv_timings *dv_timings);
> -
> -	/* Get DV presets supported at the output */
> -	int (*g_dv_timings)(struct vpbe_device *vpbe_dev,
> -			   struct v4l2_dv_timings *dv_timings);
> -
> -	/* Enumerate the DV Presets supported at the output */
> -	int (*enum_dv_timings)(struct vpbe_device *vpbe_dev,
> -			       struct v4l2_enum_dv_timings *timings_info);
> -
> -	/* Set std at the output */
> -	int (*s_std)(struct vpbe_device *vpbe_dev, v4l2_std_id std_id);
> -
> -	/* Get the current std at the output */
> -	int (*g_std)(struct vpbe_device *vpbe_dev, v4l2_std_id *std_id);
> -
> -	/* initialize the device */
> -	int (*initialize)(struct device *dev, struct vpbe_device *vpbe_dev);
> -
> -	/* De-initialize the device */
> -	void (*deinitialize)(struct device *dev, struct vpbe_device *vpbe_dev);
> -
> -	/* Get the current mode info */
> -	int (*get_mode_info)(struct vpbe_device *vpbe_dev,
> -			     struct vpbe_enc_mode_info*);
> -
> -	/*
> -	 * Set the current mode in the encoder. Alternate way of setting
> -	 * standard or DV preset or custom timings in the encoder
> -	 */
> -	int (*set_mode)(struct vpbe_device *vpbe_dev,
> -			struct vpbe_enc_mode_info*);
> -	/* Power management operations */
> -	int (*suspend)(struct vpbe_device *vpbe_dev);
> -	int (*resume)(struct vpbe_device *vpbe_dev);
> -};
> -
> -/* struct for vpbe device */
> -struct vpbe_device {
> -	/* V4l2 device */
> -	struct v4l2_device v4l2_dev;
> -	/* vpbe dispay controller cfg */
> -	struct vpbe_config *cfg;
> -	/* parent device */
> -	struct device *pdev;
> -	/* external encoder v4l2 sub devices */
> -	struct v4l2_subdev **encoders;
> -	/* current encoder index */
> -	int current_sd_index;
> -	/* external amplifier v4l2 subdevice */
> -	struct v4l2_subdev *amp;
> -	struct mutex lock;
> -	/* device initialized */
> -	int initialized;
> -	/* vpbe dac clock */
> -	struct clk *dac_clk;
> -	/* osd_device pointer */
> -	struct osd_state *osd_device;
> -	/* venc device pointer */
> -	struct venc_platform_data *venc_device;
> -	/*
> -	 * fields below are accessed by users of vpbe_device. Not the
> -	 * ones above
> -	 */
> -
> -	/* current output */
> -	int current_out_index;
> -	/* lock used by caller to do atomic operation on vpbe device */
> -	/* current timings set in the controller */
> -	struct vpbe_enc_mode_info current_timings;
> -	/* venc sub device */
> -	struct v4l2_subdev *venc;
> -	/* device operations below */
> -	struct vpbe_device_ops ops;
> -};
> -
> -#endif
> diff --git a/include/media/davinci/vpbe_display.h b/include/media/davinci/vpbe_display.h
> deleted file mode 100644
> index d8751ea926a2..000000000000
> --- a/include/media/davinci/vpbe_display.h
> +++ /dev/null
> @@ -1,122 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -#ifndef VPBE_DISPLAY_H
> -#define VPBE_DISPLAY_H
> -
> -/* Header files */
> -#include <linux/videodev2.h>
> -#include <media/v4l2-common.h>
> -#include <media/v4l2-fh.h>
> -#include <media/videobuf2-v4l2.h>
> -#include <media/videobuf2-dma-contig.h>
> -#include <media/davinci/vpbe_types.h>
> -#include <media/davinci/vpbe_osd.h>
> -#include <media/davinci/vpbe.h>
> -
> -#define VPBE_DISPLAY_MAX_DEVICES 2
> -
> -enum vpbe_display_device_id {
> -	VPBE_DISPLAY_DEVICE_0,
> -	VPBE_DISPLAY_DEVICE_1
> -};
> -
> -#define VPBE_DISPLAY_DRV_NAME	"vpbe-display"
> -
> -#define VPBE_DISPLAY_MAJOR_RELEASE              1
> -#define VPBE_DISPLAY_MINOR_RELEASE              0
> -#define VPBE_DISPLAY_BUILD                      1
> -#define VPBE_DISPLAY_VERSION_CODE ((VPBE_DISPLAY_MAJOR_RELEASE << 16) | \
> -	(VPBE_DISPLAY_MINOR_RELEASE << 8)  | \
> -	VPBE_DISPLAY_BUILD)
> -
> -#define VPBE_DISPLAY_VALID_FIELD(field)   ((V4L2_FIELD_NONE == field) || \
> -	 (V4L2_FIELD_ANY == field) || (V4L2_FIELD_INTERLACED == field))
> -
> -/* Exp ratio numerator and denominator constants */
> -#define VPBE_DISPLAY_H_EXP_RATIO_N	9
> -#define VPBE_DISPLAY_H_EXP_RATIO_D	8
> -#define VPBE_DISPLAY_V_EXP_RATIO_N	6
> -#define VPBE_DISPLAY_V_EXP_RATIO_D	5
> -
> -/* Zoom multiplication factor */
> -#define VPBE_DISPLAY_ZOOM_4X	4
> -#define VPBE_DISPLAY_ZOOM_2X	2
> -
> -/* Structures */
> -struct display_layer_info {
> -	int enable;
> -	/* Layer ID used by Display Manager */
> -	enum osd_layer id;
> -	struct osd_layer_config config;
> -	enum osd_zoom_factor h_zoom;
> -	enum osd_zoom_factor v_zoom;
> -	enum osd_h_exp_ratio h_exp;
> -	enum osd_v_exp_ratio v_exp;
> -};
> -
> -struct vpbe_disp_buffer {
> -	struct vb2_v4l2_buffer vb;
> -	struct list_head list;
> -};
> -
> -/* vpbe display object structure */
> -struct vpbe_layer {
> -	/* Pointer to the vpbe_display */
> -	struct vpbe_display *disp_dev;
> -	/* Pointer pointing to current v4l2_buffer */
> -	struct vpbe_disp_buffer *cur_frm;
> -	/* Pointer pointing to next v4l2_buffer */
> -	struct vpbe_disp_buffer *next_frm;
> -	/* vb2 specific parameters
> -	 * Buffer queue used in vb2
> -	 */
> -	struct vb2_queue buffer_queue;
> -	/* Queue of filled frames */
> -	struct list_head dma_queue;
> -	/* Used for video buffer handling */
> -	spinlock_t irqlock;
> -	/* V4l2 specific parameters */
> -	/* Identifies video device for this layer */
> -	struct video_device video_dev;
> -	/* Used to store pixel format */
> -	struct v4l2_pix_format pix_fmt;
> -	enum v4l2_field buf_field;
> -	/* Video layer configuration params */
> -	struct display_layer_info layer_info;
> -	/* vpbe specific parameters
> -	 * enable window for display
> -	 */
> -	unsigned char window_enable;
> -	/* number of open instances of the layer */
> -	unsigned int usrs;
> -	/* Indicates id of the field which is being displayed */
> -	unsigned int field_id;
> -	/* Identifies device object */
> -	enum vpbe_display_device_id device_id;
> -	/* facilitation of ioctl ops lock by v4l2*/
> -	struct mutex opslock;
> -	u8 layer_first_int;
> -};
> -
> -/* vpbe device structure */
> -struct vpbe_display {
> -	/* layer specific parameters */
> -	/* lock for isr updates to buf layers*/
> -	spinlock_t dma_queue_lock;
> -	/* C-Plane offset from start of y-plane */
> -	unsigned int cbcr_ofst;
> -	struct vpbe_layer *dev[VPBE_DISPLAY_MAX_DEVICES];
> -	struct vpbe_device *vpbe_dev;
> -	struct osd_state *osd_device;
> -};
> -
> -struct buf_config_params {
> -	unsigned char min_numbuffers;
> -	unsigned char numbuffers[VPBE_DISPLAY_MAX_DEVICES];
> -	unsigned int min_bufsize[VPBE_DISPLAY_MAX_DEVICES];
> -	unsigned int layer_bufsize[VPBE_DISPLAY_MAX_DEVICES];
> -};
> -
> -#endif	/* VPBE_DISPLAY_H */
> diff --git a/include/media/davinci/vpbe_osd.h b/include/media/davinci/vpbe_osd.h
> deleted file mode 100644
> index a4fc4f2a56fb..000000000000
> --- a/include/media/davinci/vpbe_osd.h
> +++ /dev/null
> @@ -1,382 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2007-2009 Texas Instruments Inc
> - * Copyright (C) 2007 MontaVista Software, Inc.
> - *
> - * Andy Lowe (alowe@mvista.com), MontaVista Software
> - * - Initial version
> - * Murali Karicheri (mkaricheri@gmail.com), Texas Instruments Ltd.
> - * - ported to sub device interface
> - */
> -#ifndef _OSD_H
> -#define _OSD_H
> -
> -#include <media/davinci/vpbe_types.h>
> -
> -#define DM644X_VPBE_OSD_SUBDEV_NAME	"dm644x,vpbe-osd"
> -#define DM365_VPBE_OSD_SUBDEV_NAME	"dm365,vpbe-osd"
> -#define DM355_VPBE_OSD_SUBDEV_NAME	"dm355,vpbe-osd"
> -
> -/**
> - * enum osd_layer
> - * @WIN_OSD0: On-Screen Display Window 0
> - * @WIN_VID0: Video Window 0
> - * @WIN_OSD1: On-Screen Display Window 1
> - * @WIN_VID1: Video Window 1
> - *
> - * Description:
> - * An enumeration of the osd display layers.
> - */
> -enum osd_layer {
> -	WIN_OSD0,
> -	WIN_VID0,
> -	WIN_OSD1,
> -	WIN_VID1,
> -};
> -
> -/**
> - * enum osd_win_layer
> - * @OSDWIN_OSD0: On-Screen Display Window 0
> - * @OSDWIN_OSD1: On-Screen Display Window 1
> - *
> - * Description:
> - * An enumeration of the OSD Window layers.
> - */
> -enum osd_win_layer {
> -	OSDWIN_OSD0,
> -	OSDWIN_OSD1,
> -};
> -
> -/**
> - * enum osd_pix_format
> - * @PIXFMT_1BPP: 1-bit-per-pixel bitmap
> - * @PIXFMT_2BPP: 2-bits-per-pixel bitmap
> - * @PIXFMT_4BPP: 4-bits-per-pixel bitmap
> - * @PIXFMT_8BPP: 8-bits-per-pixel bitmap
> - * @PIXFMT_RGB565: 16-bits-per-pixel RGB565
> - * @PIXFMT_YCBCRI: YUV 4:2:2
> - * @PIXFMT_RGB888: 24-bits-per-pixel RGB888
> - * @PIXFMT_YCRCBI: YUV 4:2:2 with chroma swap
> - * @PIXFMT_NV12: YUV 4:2:0 planar
> - * @PIXFMT_OSD_ATTR: OSD Attribute Window pixel format (4bpp)
> - *
> - * Description:
> - * An enumeration of the DaVinci pixel formats.
> - */
> -enum osd_pix_format {
> -	PIXFMT_1BPP = 0,
> -	PIXFMT_2BPP,
> -	PIXFMT_4BPP,
> -	PIXFMT_8BPP,
> -	PIXFMT_RGB565,
> -	PIXFMT_YCBCRI,
> -	PIXFMT_RGB888,
> -	PIXFMT_YCRCBI,
> -	PIXFMT_NV12,
> -	PIXFMT_OSD_ATTR,
> -};
> -
> -/**
> - * enum osd_h_exp_ratio
> - * @H_EXP_OFF: no expansion (1/1)
> - * @H_EXP_9_OVER_8: 9/8 expansion ratio
> - * @H_EXP_3_OVER_2: 3/2 expansion ratio
> - *
> - * Description:
> - * An enumeration of the available horizontal expansion ratios.
> - */
> -enum osd_h_exp_ratio {
> -	H_EXP_OFF,
> -	H_EXP_9_OVER_8,
> -	H_EXP_3_OVER_2,
> -};
> -
> -/**
> - * enum osd_v_exp_ratio
> - * @V_EXP_OFF: no expansion (1/1)
> - * @V_EXP_6_OVER_5: 6/5 expansion ratio
> - *
> - * Description:
> - * An enumeration of the available vertical expansion ratios.
> - */
> -enum osd_v_exp_ratio {
> -	V_EXP_OFF,
> -	V_EXP_6_OVER_5,
> -};
> -
> -/**
> - * enum osd_zoom_factor
> - * @ZOOM_X1: no zoom (x1)
> - * @ZOOM_X2: x2 zoom
> - * @ZOOM_X4: x4 zoom
> - *
> - * Description:
> - * An enumeration of the available zoom factors.
> - */
> -enum osd_zoom_factor {
> -	ZOOM_X1,
> -	ZOOM_X2,
> -	ZOOM_X4,
> -};
> -
> -/**
> - * enum osd_clut
> - * @ROM_CLUT: ROM CLUT
> - * @RAM_CLUT: RAM CLUT
> - *
> - * Description:
> - * An enumeration of the available Color Lookup Tables (CLUTs).
> - */
> -enum osd_clut {
> -	ROM_CLUT,
> -	RAM_CLUT,
> -};
> -
> -/**
> - * enum osd_rom_clut
> - * @ROM_CLUT0: Macintosh CLUT
> - * @ROM_CLUT1: CLUT from DM270 and prior devices
> - *
> - * Description:
> - * An enumeration of the ROM Color Lookup Table (CLUT) options.
> - */
> -enum osd_rom_clut {
> -	ROM_CLUT0,
> -	ROM_CLUT1,
> -};
> -
> -/**
> - * enum osd_blending_factor
> - * @OSD_0_VID_8: OSD pixels are fully transparent
> - * @OSD_1_VID_7: OSD pixels contribute 1/8, video pixels contribute 7/8
> - * @OSD_2_VID_6: OSD pixels contribute 2/8, video pixels contribute 6/8
> - * @OSD_3_VID_5: OSD pixels contribute 3/8, video pixels contribute 5/8
> - * @OSD_4_VID_4: OSD pixels contribute 4/8, video pixels contribute 4/8
> - * @OSD_5_VID_3: OSD pixels contribute 5/8, video pixels contribute 3/8
> - * @OSD_6_VID_2: OSD pixels contribute 6/8, video pixels contribute 2/8
> - * @OSD_8_VID_0: OSD pixels are fully opaque
> - *
> - * Description:
> - * An enumeration of the DaVinci pixel blending factor options.
> - */
> -enum osd_blending_factor {
> -	OSD_0_VID_8,
> -	OSD_1_VID_7,
> -	OSD_2_VID_6,
> -	OSD_3_VID_5,
> -	OSD_4_VID_4,
> -	OSD_5_VID_3,
> -	OSD_6_VID_2,
> -	OSD_8_VID_0,
> -};
> -
> -/**
> - * enum osd_blink_interval
> - * @BLINK_X1: blink interval is 1 vertical refresh cycle
> - * @BLINK_X2: blink interval is 2 vertical refresh cycles
> - * @BLINK_X3: blink interval is 3 vertical refresh cycles
> - * @BLINK_X4: blink interval is 4 vertical refresh cycles
> - *
> - * Description:
> - * An enumeration of the DaVinci pixel blinking interval options.
> - */
> -enum osd_blink_interval {
> -	BLINK_X1,
> -	BLINK_X2,
> -	BLINK_X3,
> -	BLINK_X4,
> -};
> -
> -/**
> - * enum osd_cursor_h_width
> - * @H_WIDTH_1: horizontal line width is 1 pixel
> - * @H_WIDTH_4: horizontal line width is 4 pixels
> - * @H_WIDTH_8: horizontal line width is 8 pixels
> - * @H_WIDTH_12: horizontal line width is 12 pixels
> - * @H_WIDTH_16: horizontal line width is 16 pixels
> - * @H_WIDTH_20: horizontal line width is 20 pixels
> - * @H_WIDTH_24: horizontal line width is 24 pixels
> - * @H_WIDTH_28: horizontal line width is 28 pixels
> - */
> -enum osd_cursor_h_width {
> -	H_WIDTH_1,
> -	H_WIDTH_4,
> -	H_WIDTH_8,
> -	H_WIDTH_12,
> -	H_WIDTH_16,
> -	H_WIDTH_20,
> -	H_WIDTH_24,
> -	H_WIDTH_28,
> -};
> -
> -/**
> - * enum osd_cursor_v_width
> - * @V_WIDTH_1: vertical line width is 1 line
> - * @V_WIDTH_2: vertical line width is 2 lines
> - * @V_WIDTH_4: vertical line width is 4 lines
> - * @V_WIDTH_6: vertical line width is 6 lines
> - * @V_WIDTH_8: vertical line width is 8 lines
> - * @V_WIDTH_10: vertical line width is 10 lines
> - * @V_WIDTH_12: vertical line width is 12 lines
> - * @V_WIDTH_14: vertical line width is 14 lines
> - */
> -enum osd_cursor_v_width {
> -	V_WIDTH_1,
> -	V_WIDTH_2,
> -	V_WIDTH_4,
> -	V_WIDTH_6,
> -	V_WIDTH_8,
> -	V_WIDTH_10,
> -	V_WIDTH_12,
> -	V_WIDTH_14,
> -};
> -
> -/**
> - * struct osd_cursor_config
> - * @xsize: horizontal size in pixels
> - * @ysize: vertical size in lines
> - * @xpos: horizontal offset in pixels from the left edge of the display
> - * @ypos: vertical offset in lines from the top of the display
> - * @interlaced: Non-zero if the display is interlaced, or zero otherwise
> - * @h_width: horizontal line width
> - * @v_width: vertical line width
> - * @clut: the CLUT selector (ROM or RAM) for the cursor color
> - * @clut_index: an index into the CLUT for the cursor color
> - *
> - * Description:
> - * A structure describing the configuration parameters of the hardware
> - * rectangular cursor.
> - */
> -struct osd_cursor_config {
> -	unsigned xsize;
> -	unsigned ysize;
> -	unsigned xpos;
> -	unsigned ypos;
> -	int interlaced;
> -	enum osd_cursor_h_width h_width;
> -	enum osd_cursor_v_width v_width;
> -	enum osd_clut clut;
> -	unsigned char clut_index;
> -};
> -
> -/**
> - * struct osd_layer_config
> - * @pixfmt: pixel format
> - * @line_length: offset in bytes between start of each line in memory
> - * @xsize: number of horizontal pixels displayed per line
> - * @ysize: number of lines displayed
> - * @xpos: horizontal offset in pixels from the left edge of the display
> - * @ypos: vertical offset in lines from the top of the display
> - * @interlaced: Non-zero if the display is interlaced, or zero otherwise
> - *
> - * Description:
> - * A structure describing the configuration parameters of an On-Screen Display
> - * (OSD) or video layer related to how the image is stored in memory.
> - * @line_length must be a multiple of the cache line size (32 bytes).
> - */
> -struct osd_layer_config {
> -	enum osd_pix_format pixfmt;
> -	unsigned line_length;
> -	unsigned xsize;
> -	unsigned ysize;
> -	unsigned xpos;
> -	unsigned ypos;
> -	int interlaced;
> -};
> -
> -/* parameters that apply on a per-window (OSD or video) basis */
> -struct osd_window_state {
> -	int is_allocated;
> -	int is_enabled;
> -	unsigned long fb_base_phys;
> -	enum osd_zoom_factor h_zoom;
> -	enum osd_zoom_factor v_zoom;
> -	struct osd_layer_config lconfig;
> -};
> -
> -/* parameters that apply on a per-OSD-window basis */
> -struct osd_osdwin_state {
> -	enum osd_clut clut;
> -	enum osd_blending_factor blend;
> -	int colorkey_blending;
> -	unsigned colorkey;
> -	int rec601_attenuation;
> -	/* index is pixel value */
> -	unsigned char palette_map[16];
> -};
> -
> -/* hardware rectangular cursor parameters */
> -struct osd_cursor_state {
> -	int is_enabled;
> -	struct osd_cursor_config config;
> -};
> -
> -struct osd_state;
> -
> -struct vpbe_osd_ops {
> -	int (*initialize)(struct osd_state *sd);
> -	int (*request_layer)(struct osd_state *sd, enum osd_layer layer);
> -	void (*release_layer)(struct osd_state *sd, enum osd_layer layer);
> -	int (*enable_layer)(struct osd_state *sd, enum osd_layer layer,
> -			    int otherwin);
> -	void (*disable_layer)(struct osd_state *sd, enum osd_layer layer);
> -	int (*set_layer_config)(struct osd_state *sd, enum osd_layer layer,
> -				struct osd_layer_config *lconfig);
> -	void (*get_layer_config)(struct osd_state *sd, enum osd_layer layer,
> -				 struct osd_layer_config *lconfig);
> -	void (*start_layer)(struct osd_state *sd, enum osd_layer layer,
> -			    unsigned long fb_base_phys,
> -			    unsigned long cbcr_ofst);
> -	void (*set_left_margin)(struct osd_state *sd, u32 val);
> -	void (*set_top_margin)(struct osd_state *sd, u32 val);
> -	void (*set_interpolation_filter)(struct osd_state *sd, int filter);
> -	int (*set_vid_expansion)(struct osd_state *sd,
> -					enum osd_h_exp_ratio h_exp,
> -					enum osd_v_exp_ratio v_exp);
> -	void (*get_vid_expansion)(struct osd_state *sd,
> -					enum osd_h_exp_ratio *h_exp,
> -					enum osd_v_exp_ratio *v_exp);
> -	void (*set_zoom)(struct osd_state *sd, enum osd_layer layer,
> -				enum osd_zoom_factor h_zoom,
> -				enum osd_zoom_factor v_zoom);
> -};
> -
> -struct osd_state {
> -	enum vpbe_version vpbe_type;
> -	spinlock_t lock;
> -	struct device *dev;
> -	dma_addr_t osd_base_phys;
> -	void __iomem *osd_base;
> -	unsigned long osd_size;
> -	/* 1-->the isr will toggle the VID0 ping-pong buffer */
> -	int pingpong;
> -	int interpolation_filter;
> -	int field_inversion;
> -	enum osd_h_exp_ratio osd_h_exp;
> -	enum osd_v_exp_ratio osd_v_exp;
> -	enum osd_h_exp_ratio vid_h_exp;
> -	enum osd_v_exp_ratio vid_v_exp;
> -	enum osd_clut backg_clut;
> -	unsigned backg_clut_index;
> -	enum osd_rom_clut rom_clut;
> -	int is_blinking;
> -	/* attribute window blinking enabled */
> -	enum osd_blink_interval blink;
> -	/* YCbCrI or YCrCbI */
> -	enum osd_pix_format yc_pixfmt;
> -	/* columns are Y, Cb, Cr */
> -	unsigned char clut_ram[256][3];
> -	struct osd_cursor_state cursor;
> -	/* OSD0, VID0, OSD1, VID1 */
> -	struct osd_window_state win[4];
> -	/* OSD0, OSD1 */
> -	struct osd_osdwin_state osdwin[2];
> -	/* OSD device Operations */
> -	struct vpbe_osd_ops ops;
> -};
> -
> -struct osd_platform_data {
> -	int  field_inv_wa_enable;
> -};
> -
> -#endif
> diff --git a/include/media/davinci/vpbe_types.h b/include/media/davinci/vpbe_types.h
> deleted file mode 100644
> index 6015cda235cc..000000000000
> --- a/include/media/davinci/vpbe_types.h
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2010 Texas Instruments Inc
> - */
> -#ifndef _VPBE_TYPES_H
> -#define _VPBE_TYPES_H
> -
> -enum vpbe_version {
> -	VPBE_VERSION_1 = 1,
> -	VPBE_VERSION_2,
> -	VPBE_VERSION_3,
> -};
> -
> -/* vpbe_timing_type - Timing types used in vpbe device */
> -enum vpbe_enc_timings_type {
> -	VPBE_ENC_STD = 0x1,
> -	VPBE_ENC_DV_TIMINGS = 0x4,
> -	/* Used when set timings through FB device interface */
> -	VPBE_ENC_TIMINGS_INVALID = 0x8,
> -};
> -
> -/*
> - * struct vpbe_enc_mode_info
> - * @name: ptr to name string of the standard, "NTSC", "PAL" etc
> - * @std: standard or non-standard mode. 1 - standard, 0 - nonstandard
> - * @interlaced: 1 - interlaced, 0 - non interlaced/progressive
> - * @xres: x or horizontal resolution of the display
> - * @yres: y or vertical resolution of the display
> - * @fps: frame per second
> - * @left_margin: left margin of the display
> - * @right_margin: right margin of the display
> - * @upper_margin: upper margin of the display
> - * @lower_margin: lower margin of the display
> - * @hsync_len: h-sync length
> - * @vsync_len: v-sync length
> - * @flags: bit field: bit usage is documented below
> - *
> - * Description:
> - *  Structure holding timing and resolution information of a standard.
> - * Used by vpbe_device to set required non-standard timing in the
> - * venc when lcd controller output is connected to a external encoder.
> - * A table of timings is maintained in vpbe device to set this in
> - * venc when external encoder is connected to lcd controller output.
> - * Encoder may provide a g_dv_timings() API to override these values
> - * as needed.
> - *
> - *  Notes
> - *  ------
> - *  if_type should be used only by encoder manager and encoder.
> - *  flags usage
> - *     b0 (LSB) - hsync polarity, 0 - negative, 1 - positive
> - *     b1       - vsync polarity, 0 - negative, 1 - positive
> - *     b2       - field id polarity, 0 - negative, 1  - positive
> - */
> -struct vpbe_enc_mode_info {
> -	unsigned char *name;
> -	enum vpbe_enc_timings_type timings_type;
> -	v4l2_std_id std_id;
> -	struct v4l2_dv_timings dv_timings;
> -	unsigned int interlaced;
> -	unsigned int xres;
> -	unsigned int yres;
> -	struct v4l2_fract aspect;
> -	struct v4l2_fract fps;
> -	unsigned int left_margin;
> -	unsigned int right_margin;
> -	unsigned int upper_margin;
> -	unsigned int lower_margin;
> -	unsigned int hsync_len;
> -	unsigned int vsync_len;
> -	unsigned int flags;
> -};
> -
> -#endif
> diff --git a/include/media/davinci/vpbe_venc.h b/include/media/davinci/vpbe_venc.h
> deleted file mode 100644
> index 93cf6a5fb49d..000000000000
> --- a/include/media/davinci/vpbe_venc.h
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2010 Texas Instruments Inc
> - */
> -#ifndef _VPBE_VENC_H
> -#define _VPBE_VENC_H
> -
> -#include <media/v4l2-subdev.h>
> -#include <media/davinci/vpbe_types.h>
> -
> -#define DM644X_VPBE_VENC_SUBDEV_NAME	"dm644x,vpbe-venc"
> -#define DM365_VPBE_VENC_SUBDEV_NAME	"dm365,vpbe-venc"
> -#define DM355_VPBE_VENC_SUBDEV_NAME	"dm355,vpbe-venc"
> -
> -/* venc events */
> -#define VENC_END_OF_FRAME	BIT(0)
> -#define VENC_FIRST_FIELD	BIT(1)
> -#define VENC_SECOND_FIELD	BIT(2)
> -
> -struct venc_platform_data {
> -	int (*setup_pinmux)(u32 if_type, int field);
> -	int (*setup_clock)(enum vpbe_enc_timings_type type,
> -			   unsigned int pixclock);
> -	int (*setup_if_config)(u32 pixcode);
> -	/* Number of LCD outputs supported */
> -	int num_lcd_outputs;
> -	struct vpbe_if_params *lcd_if_params;
> -};
> -
> -enum venc_ioctls {
> -	VENC_GET_FLD = 1,
> -};
> -
> -/* exported functions */
> -struct v4l2_subdev *venc_sub_dev_init(struct v4l2_device *v4l2_dev,
> -		const char *venc_name);
> -#endif
> diff --git a/include/media/davinci/vpss.h b/include/media/davinci/vpss.h
> deleted file mode 100644
> index 315fa77e238c..000000000000
> --- a/include/media/davinci/vpss.h
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright (C) 2009 Texas Instruments Inc
> - *
> - * vpss - video processing subsystem module header file.
> - *
> - * Include this header file if a driver needs to configure vpss system
> - * module. It exports a set of library functions  for video drivers to
> - * configure vpss system module functions such as clock enable/disable,
> - * vpss interrupt mux to arm, and other common vpss system module
> - * functions.
> - */
> -#ifndef _VPSS_H
> -#define _VPSS_H
> -
> -/* selector for ccdc input selection on DM355 */
> -enum vpss_ccdc_source_sel {
> -	VPSS_CCDCIN,
> -	VPSS_HSSIIN,
> -	VPSS_PGLPBK,	/* for DM365 only */
> -	VPSS_CCDCPG	/* for DM365 only */
> -};
> -
> -struct vpss_sync_pol {
> -	unsigned int ccdpg_hdpol:1;
> -	unsigned int ccdpg_vdpol:1;
> -};
> -
> -struct vpss_pg_frame_size {
> -	short hlpfr;
> -	short pplen;
> -};
> -
> -/* Used for enable/disable VPSS Clock */
> -enum vpss_clock_sel {
> -	/* DM355/DM365 */
> -	VPSS_CCDC_CLOCK,
> -	VPSS_IPIPE_CLOCK,
> -	VPSS_H3A_CLOCK,
> -	VPSS_CFALD_CLOCK,
> -	/*
> -	 * When using VPSS_VENC_CLOCK_SEL in vpss_enable_clock() api
> -	 * following applies:-
> -	 * en = 0 selects ENC_CLK
> -	 * en = 1 selects ENC_CLK/2
> -	 */
> -	VPSS_VENC_CLOCK_SEL,
> -	VPSS_VPBE_CLOCK,
> -	/* DM365 only clocks */
> -	VPSS_IPIPEIF_CLOCK,
> -	VPSS_RSZ_CLOCK,
> -	VPSS_BL_CLOCK,
> -	/*
> -	 * When using VPSS_PCLK_INTERNAL in vpss_enable_clock() api
> -	 * following applies:-
> -	 * en = 0 disable internal PCLK
> -	 * en = 1 enables internal PCLK
> -	 */
> -	VPSS_PCLK_INTERNAL,
> -	/*
> -	 * When using VPSS_PSYNC_CLOCK_SEL in vpss_enable_clock() api
> -	 * following applies:-
> -	 * en = 0 enables MMR clock
> -	 * en = 1 enables VPSS clock
> -	 */
> -	VPSS_PSYNC_CLOCK_SEL,
> -	VPSS_LDC_CLOCK_SEL,
> -	VPSS_OSD_CLOCK_SEL,
> -	VPSS_FDIF_CLOCK,
> -	VPSS_LDC_CLOCK
> -};
> -
> -/* select input to ccdc on dm355 */
> -int vpss_select_ccdc_source(enum vpss_ccdc_source_sel src_sel);
> -/* enable/disable a vpss clock, 0 - success, -1 - failure */
> -int vpss_enable_clock(enum vpss_clock_sel clock_sel, int en);
> -/* set sync polarity, only for DM365*/
> -void dm365_vpss_set_sync_pol(struct vpss_sync_pol);
> -/* set the PG_FRAME_SIZE register, only for DM365 */
> -void dm365_vpss_set_pg_frame_size(struct vpss_pg_frame_size);
> -
> -/* wbl reset for dm644x */
> -enum vpss_wbl_sel {
> -	VPSS_PCR_AEW_WBL_0 = 16,
> -	VPSS_PCR_AF_WBL_0,
> -	VPSS_PCR_RSZ4_WBL_0,
> -	VPSS_PCR_RSZ3_WBL_0,
> -	VPSS_PCR_RSZ2_WBL_0,
> -	VPSS_PCR_RSZ1_WBL_0,
> -	VPSS_PCR_PREV_WBL_0,
> -	VPSS_PCR_CCDC_WBL_O,
> -};
> -/* clear wbl overflow flag for DM6446 */
> -int vpss_clear_wbl_overflow(enum vpss_wbl_sel wbl_sel);
> -
> -/* set sync polarity*/
> -void vpss_set_sync_pol(struct vpss_sync_pol sync);
> -/* set the PG_FRAME_SIZE register */
> -void vpss_set_pg_frame_size(struct vpss_pg_frame_size frame_size);
> -/*
> - * vpss_check_and_clear_interrupt - check and clear interrupt
> - * @irq - common enumerator for IRQ
> - *
> - * Following return values used:-
> - * 0 - interrupt occurred and cleared
> - * 1 - interrupt not occurred
> - * 2 - interrupt status not available
> - */
> -int vpss_dma_complete_interrupt(void);
> -
> -#endif
