Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3498A732852
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbjFPHE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbjFPHEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:04:01 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DE235A6;
        Fri, 16 Jun 2023 00:02:28 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 90CDD24E1E2;
        Fri, 16 Jun 2023 15:02:24 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 16 Jun
 2023 15:02:24 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 16 Jun
 2023 15:02:23 +0800
Message-ID: <af135687-6874-7041-cb8f-cb93f871fdc7@starfivetech.com>
Date:   Fri, 16 Jun 2023 15:02:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 3/6] media: starfive: Add basic driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230525083202.67933-1-jack.zhu@starfivetech.com>
 <20230525083202.67933-4-jack.zhu@starfivetech.com>
 <20230601104448.GG22609@pendragon.ideasonboard.com>
Content-Language: en-US
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230601104448.GG22609@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for your comments.

On 2023/6/1 18:44, Laurent Pinchart wrote:
> Hi Jack,
> 
> Thank you for the patch.
> 
> On Thu, May 25, 2023 at 04:31:59PM +0800, Jack Zhu wrote:
>> Add basic platform driver for StarFive Camera Subsystem.
>> 
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> ---
>>  MAINTAINERS                                  |   1 +
>>  drivers/media/platform/Kconfig               |   1 +
>>  drivers/media/platform/Makefile              |   1 +
>>  drivers/media/platform/starfive/Kconfig      |  19 +
>>  drivers/media/platform/starfive/Makefile     |   9 +
>>  drivers/media/platform/starfive/stf_camss.c  | 372 +++++++++++++++++++
>>  drivers/media/platform/starfive/stf_camss.h  | 153 ++++++++
>>  drivers/media/platform/starfive/stf_common.h |  18 +
>>  8 files changed, 574 insertions(+)
>>  create mode 100644 drivers/media/platform/starfive/Kconfig
>>  create mode 100644 drivers/media/platform/starfive/Makefile
>>  create mode 100644 drivers/media/platform/starfive/stf_camss.c
>>  create mode 100644 drivers/media/platform/starfive/stf_camss.h
>>  create mode 100644 drivers/media/platform/starfive/stf_common.h
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 71291dc58671..33a752569942 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20077,6 +20077,7 @@ L:	linux-media@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/admin-guide/media/starfive_camss.rst
>>  F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> +F:	drivers/media/platform/starfive/
>>  
>>  STARFIVE DEVICETREES
>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
>> index ee579916f874..627eaa0ab3ee 100644
>> --- a/drivers/media/platform/Kconfig
>> +++ b/drivers/media/platform/Kconfig
>> @@ -80,6 +80,7 @@ source "drivers/media/platform/renesas/Kconfig"
>>  source "drivers/media/platform/rockchip/Kconfig"
>>  source "drivers/media/platform/samsung/Kconfig"
>>  source "drivers/media/platform/st/Kconfig"
>> +source "drivers/media/platform/starfive/Kconfig"
>>  source "drivers/media/platform/sunxi/Kconfig"
>>  source "drivers/media/platform/ti/Kconfig"
>>  source "drivers/media/platform/verisilicon/Kconfig"
>> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
>> index 5453bb868e67..5a038498a370 100644
>> --- a/drivers/media/platform/Makefile
>> +++ b/drivers/media/platform/Makefile
>> @@ -23,6 +23,7 @@ obj-y += renesas/
>>  obj-y += rockchip/
>>  obj-y += samsung/
>>  obj-y += st/
>> +obj-y += starfive/
>>  obj-y += sunxi/
>>  obj-y += ti/
>>  obj-y += verisilicon/
>> diff --git a/drivers/media/platform/starfive/Kconfig b/drivers/media/platform/starfive/Kconfig
>> new file mode 100644
>> index 000000000000..1a2293475bd2
>> --- /dev/null
>> +++ b/drivers/media/platform/starfive/Kconfig
>> @@ -0,0 +1,19 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +comment "Starfive media platform drivers"
>> +
>> +config VIDEO_STARFIVE_CAMSS
>> +	tristate "Starfive Camera Subsystem driver"
>> +	depends on V4L_PLATFORM_DRIVERS
>> +	depends on VIDEO_DEV && OF
>> +	depends on DMA_CMA
> 
> I think you can drop this, the driver doesn't depend on DMA. It uses the
> DMA mapping API though, so you should depend on HAS_DMA instead.
> 

Okay, I will use HAS_DMA.

>> +	select MEDIA_CONTROLLER
>> +	select VIDEO_V4L2_SUBDEV_API
>> +	select VIDEOBUF2_DMA_CONTIG
>> +	select V4L2_FWNODE
>> +	help
>> +	   Enable this to support for the Starfive Camera subsystem
>> +	   found on Starfive JH7110 SoC.
>> +
>> +	   To compile this driver as a module, choose M here: the
>> +	   module will be called stf-camss.
>> diff --git a/drivers/media/platform/starfive/Makefile b/drivers/media/platform/starfive/Makefile
>> new file mode 100644
>> index 000000000000..796775fa52f4
>> --- /dev/null
>> +++ b/drivers/media/platform/starfive/Makefile
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Makefile for StarFive camera subsystem driver.
>> +#
>> +
>> +starfive-camss-objs += \
>> +		stf_camss.o
>> +
>> +obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o \
>> diff --git a/drivers/media/platform/starfive/stf_camss.c b/drivers/media/platform/starfive/stf_camss.c
>> new file mode 100644
>> index 000000000000..cb2b62d49416
>> --- /dev/null
>> +++ b/drivers/media/platform/starfive/stf_camss.c
>> @@ -0,0 +1,372 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * stf_camss.c
>> + *
>> + * Starfive Camera Subsystem driver
>> + *
>> + * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
>> + */
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_graph.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/videodev2.h>
>> +#include <media/media-device.h>
>> +#include <media/v4l2-async.h>
>> +#include <media/v4l2-fwnode.h>
>> +#include <media/v4l2-mc.h>
>> +
>> +#include "stf_camss.h"
>> +
>> +static const char * const stfcamss_clocks[] = {
>> +	"clk_apb_func",
>> +	"clk_wrapper_clk_c",
>> +	"clk_dvp_inv",
>> +	"clk_axiwr",
>> +	"clk_mipi_rx0_pxl",
>> +	"clk_ispcore_2x",
>> +	"clk_isp_axi",
>> +};
>> +
>> +static const char * const stfcamss_resets[] = {
>> +	"rst_wrapper_p",
>> +	"rst_wrapper_c",
>> +	"rst_axird",
>> +	"rst_axiwr",
>> +	"rst_isp_top_n",
>> +	"rst_isp_top_axi",
>> +};
>> +
>> +static int stfcamss_get_mem_res(struct platform_device *pdev,
>> +				struct stfcamss *stfcamss)
>> +{
>> +	stfcamss->syscon_base =
>> +		devm_platform_ioremap_resource_byname(pdev, "syscon");
>> +	if (IS_ERR(stfcamss->syscon_base))
>> +		return PTR_ERR(stfcamss->syscon_base);
>> +
>> +	stfcamss->isp_base =
>> +		devm_platform_ioremap_resource_byname(pdev, "isp");
>> +	if (IS_ERR(stfcamss->isp_base))
>> +		return PTR_ERR(stfcamss->isp_base);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * stfcamss_of_parse_endpoint_node - Parse port endpoint node
>> + * @dev: Device
>> + * @node: Device node to be parsed
>> + * @csd: Parsed data from port endpoint node
>> + *
>> + * Return 0 on success or a negative error code on failure
>> + */
>> +static int stfcamss_of_parse_endpoint_node(struct device *dev,
>> +					   struct device_node *node,
>> +					   struct stfcamss_async_subdev *csd)
>> +{
>> +	struct v4l2_fwnode_endpoint vep = { { 0 } };
>> +
>> +	v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
>> +	dev_dbg(dev, "vep.base.port = 0x%x, id = 0x%x\n",
>> +		vep.base.port, vep.base.id);
> 
> You can print the port and id as decimal numbers, they're indices.
> 

Okay, I will modify it.

>> +
>> +	csd->port = vep.base.port;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * stfcamss_of_parse_ports - Parse ports node
>> + * @stfcamss: STFCAMSS device
>> + *
>> + * Return number of "port" nodes found in "ports" node
>> + */
>> +static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
>> +{
>> +	struct device *dev = stfcamss->dev;
>> +	struct device_node *node = NULL;
>> +	struct device_node *remote = NULL;
>> +	int ret, num_subdevs = 0;
>> +
>> +	for_each_endpoint_of_node(dev->of_node, node) {
>> +		struct stfcamss_async_subdev *csd;
>> +
>> +		if (!of_device_is_available(node))
>> +			continue;
>> +
>> +		remote = of_graph_get_remote_port_parent(node);
>> +		if (!remote) {
>> +			dev_err(dev, "Cannot get remote parent\n");
>> +			ret = -EINVAL;
>> +			goto err_cleanup;
>> +		}
>> +
>> +		csd = v4l2_async_nf_add_fwnode(&stfcamss->notifier,
>> +					       of_fwnode_handle(remote),
>> +					       struct stfcamss_async_subdev);
>> +		of_node_put(remote);
> 
> You can use v4l2_async_nf_add_fwnode_remote() to avoid the need to call
> of_graph_get_remote_port_parent() yourself.
> 

Okay, I will fix it.

>> +		if (IS_ERR(csd)) {
>> +			ret = PTR_ERR(csd);
>> +			goto err_cleanup;
>> +		}
>> +
>> +		ret = stfcamss_of_parse_endpoint_node(dev, node, csd);
>> +		if (ret < 0)
>> +			goto err_cleanup;
>> +
>> +		num_subdevs++;
>> +	}
>> +
>> +	return num_subdevs;
>> +
>> +err_cleanup:
>> +	of_node_put(node);
>> +	return ret;
>> +}
>> +
>> +static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
>> +					  struct v4l2_subdev *subdev,
>> +					  struct v4l2_async_subdev *asd)
>> +{
>> +	struct stfcamss *stfcamss =
>> +		container_of(async, struct stfcamss, notifier);
>> +	struct host_data *host_data = &stfcamss->host_data;
>> +	struct media_entity *source;
>> +	int i, j;
> 
> i and j are never negative, you can make them unsigned int.
> 

Okay, I will fix it.

>> +
>> +	source = &subdev->entity;
> 
> You can assign the variable when declaring it:
> 
> 	struct media_entity *source = &subdev->entity;
> 

Okay, I will fix it.

>> +
>> +	for (i = 0; i < source->num_pads; i++) {
>> +		if (source->pads[i].flags & MEDIA_PAD_FL_SOURCE)
>> +			break;
>> +	}
>> +
>> +	if (i == source->num_pads) {
>> +		dev_err(stfcamss->dev, "No source pad in external entity\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (j = 0; host_data->host_entity[j] && (j < HOST_ENTITY_MAX); j++) {
>> +		struct media_entity *input;
>> +		int ret;
>> +
>> +		input = host_data->host_entity[j];
>> +
>> +		ret = media_create_pad_link(
>> +			source,
>> +			i,
>> +			input,
>> +			STF_PAD_SINK,
>> +			source->function == MEDIA_ENT_F_CAM_SENSOR ?
>> +			MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED :
>> +			0);
>> +		if (ret < 0) {
>> +			dev_err(stfcamss->dev,
>> +				"Failed to link %s->%s entities: %d\n",
>> +				source->name, input->name, ret);
>> +			return ret;
>> +		}
>> +	}
> 
> I think you can simplify this. First of all, the port to which the
> newly bound subdev is attached is available in the stfcamss_async_subdev
> structure. You can cast the asd to a stfcamss_async_subdev with
> container_of(), access the port number from there, and get the
> corresponding sink subdev and pad (for the DVP or CSI-2 port). Then, I
> think you can use v4l2_create_fwnode_links_to_pad(), which will search
> for the source pad in the source subdev, instead of doing it yourself.
> 
> I believe the stfcamss.host_data field can be dropped, as it's only used
> in this function.
> 

Okay, I will simplify the code.

>> +
>> +	return 0;
>> +}
>> +
>> +static int stfcamss_subdev_notifier_complete(struct v4l2_async_notifier *ntf)
>> +{
>> +	struct stfcamss *stfcamss =
>> +		container_of(ntf, struct stfcamss, notifier);
>> +
>> +	return v4l2_device_register_subdev_nodes(&stfcamss->v4l2_dev);
>> +}
>> +
>> +static const struct v4l2_async_notifier_operations
>> +stfcamss_subdev_notifier_ops = {
>> +	.bound = stfcamss_subdev_notifier_bound,
>> +	.complete = stfcamss_subdev_notifier_complete,
>> +};
>> +
>> +static const struct media_device_ops stfcamss_media_ops = {
>> +	.link_notify = v4l2_pipeline_link_notify,
>> +};
>> +
>> +static void stfcamss_mc_init(struct platform_device *pdev,
>> +			     struct stfcamss *stfcamss)
>> +{
>> +	stfcamss->media_dev.dev = stfcamss->dev;
>> +	strscpy(stfcamss->media_dev.model, "Starfive Camera Subsystem",
>> +		sizeof(stfcamss->media_dev.model));
>> +	snprintf(stfcamss->media_dev.bus_info,
>> +		 sizeof(stfcamss->media_dev.bus_info),
>> +		 "%s:%s", dev_bus_name(&pdev->dev), pdev->name);
> 
> No need to set bus_info manually, the framework does if for you in
> media_device_init().
> 

Okay, I will drop it.

>> +	stfcamss->media_dev.hw_revision = 0x01;
> 
> Would the hardware have a version or revision register that you could
> use to fill this, by any chance ?
> 

There are no revision registers. Currently, this version number is not
useful and I will delete it.

>> +	stfcamss->media_dev.ops = &stfcamss_media_ops;
>> +	media_device_init(&stfcamss->media_dev);
>> +
>> +	stfcamss->v4l2_dev.mdev = &stfcamss->media_dev;
>> +}
>> +
>> +/*
>> + * stfcamss_probe - Probe STFCAMSS platform device
>> + * @pdev: Pointer to STFCAMSS platform device
>> + *
>> + * Return 0 on success or a negative error code on failure
>> + */
>> +static int stfcamss_probe(struct platform_device *pdev)
>> +{
>> +	struct stfcamss *stfcamss;
>> +	struct device *dev = &pdev->dev;
>> +	int ret = 0, i, num_subdevs;
> 
> No need to initialize ret to 0.
> 
> i is never negative, make it an unsigned int.
> 

Okay, I will fix it.

>> +
>> +	stfcamss = devm_kzalloc(dev, sizeof(*stfcamss), GFP_KERNEL);
>> +	if (!stfcamss)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(stfcamss->irq); ++i) {
>> +		stfcamss->irq[i] = platform_get_irq(pdev, i);
>> +		if (stfcamss->irq[i] < 0)
>> +			return dev_err_probe(&pdev->dev, stfcamss->irq[i],
>> +					     "Failed to get clock%d", i);
> 
> I think you meant "irq %u", not clock.
> 

Okay, I will fix it.

>> +	}
>> +
>> +	stfcamss->nclks = ARRAY_SIZE(stfcamss->sys_clk);
>> +	for (i = 0; i < stfcamss->nclks; ++i)
>> +		stfcamss->sys_clk[i].id = stfcamss_clocks[i];
>> +	ret = devm_clk_bulk_get(dev, stfcamss->nclks, stfcamss->sys_clk);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get clk controls\n");
>> +		return ret;
>> +	}
>> +
>> +	stfcamss->nrsts = ARRAY_SIZE(stfcamss->sys_rst);
>> +	for (i = 0; i < stfcamss->nrsts; ++i)
>> +		stfcamss->sys_rst[i].id = stfcamss_resets[i];
>> +	ret = devm_reset_control_bulk_get_shared(dev, stfcamss->nrsts,
>> +						 stfcamss->sys_rst);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get reset controls\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = stfcamss_get_mem_res(pdev, stfcamss);
>> +	if (ret) {
>> +		dev_err(dev, "Could not map registers\n");
>> +		return ret;
>> +	}
>> +
>> +	stfcamss->dev = dev;
>> +	platform_set_drvdata(pdev, stfcamss);
>> +
>> +	v4l2_async_nf_init(&stfcamss->notifier);
>> +
>> +	num_subdevs = stfcamss_of_parse_ports(stfcamss);
>> +	if (num_subdevs < 0) {
>> +		dev_err(dev, "Failed to find subdevices\n");
>> +		return -ENODEV;
> 
> I would
> 
> 		ret = -ENODEV;
> 		goto err_cleanup_notifier;
> 
> here.
> 

Okay, I will modify the code.

>> +	}
>> +
>> +	stfcamss_mc_init(pdev, stfcamss);
>> +
>> +	ret = v4l2_device_register(stfcamss->dev, &stfcamss->v4l2_dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
>> +		goto err_cleanup_notifier;
>> +	}
>> +
>> +	ret = media_device_register(&stfcamss->media_dev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register media device: %d\n", ret);
>> +		goto err_unregister_device;
>> +	}
>> +
>> +	stfcamss->notifier.ops = &stfcamss_subdev_notifier_ops;
>> +	ret = v4l2_async_nf_register(&stfcamss->v4l2_dev, &stfcamss->notifier);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register async subdev nodes: %d\n",
>> +			ret);
>> +		goto err_unregister_media_dev;
>> +	}
>> +
>> +	pm_runtime_enable(dev);
> 
> You should enable runtime PM before registering the notifier, otherwise
> there's a race condition where userspace could start using the device
> before runtime PM gets enabled.
> 

Okay, will fix it.

>> +
>> +	return 0;
>> +
>> +err_unregister_media_dev:
>> +	media_device_unregister(&stfcamss->media_dev);
>> +err_unregister_device:
>> +	v4l2_device_unregister(&stfcamss->v4l2_dev);
>> +err_cleanup_notifier:
>> +	v4l2_async_nf_cleanup(&stfcamss->notifier);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * stfcamss_remove - Remove STFCAMSS platform device
>> + * @pdev: Pointer to STFCAMSS platform device
>> + *
>> + * Always returns 0.
>> + */
>> +static int stfcamss_remove(struct platform_device *pdev)
>> +{
>> +	struct stfcamss *stfcamss = platform_get_drvdata(pdev);
>> +
>> +	v4l2_device_unregister(&stfcamss->v4l2_dev);
>> +	media_device_cleanup(&stfcamss->media_dev);
>> +	pm_runtime_disable(&pdev->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id stfcamss_of_match[] = {
>> +	{ .compatible = "starfive,jh7110-camss" },
>> +	{ /* sentinel */ },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, stfcamss_of_match);
>> +
>> +static int __maybe_unused stfcamss_runtime_suspend(struct device *dev)
>> +{
>> +	struct stfcamss *stfcamss = dev_get_drvdata(dev);
>> +
>> +	reset_control_assert(stfcamss->sys_rst[STF_RST_ISP_TOP_AXI].rstc);
>> +	reset_control_assert(stfcamss->sys_rst[STF_RST_ISP_TOP_N].rstc);
>> +	clk_disable_unprepare(stfcamss->sys_clk[STF_CLK_ISP_AXI].clk);
>> +	clk_disable_unprepare(stfcamss->sys_clk[STF_CLK_ISPCORE_2X].clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused stfcamss_runtime_resume(struct device *dev)
>> +{
>> +	struct stfcamss *stfcamss = dev_get_drvdata(dev);
>> +
>> +	clk_prepare_enable(stfcamss->sys_clk[STF_CLK_ISPCORE_2X].clk);
>> +	clk_prepare_enable(stfcamss->sys_clk[STF_CLK_ISP_AXI].clk);
> 
> Error handling is missing for those two calls.
> 

Okay, I will add error handing for them.

>> +	reset_control_deassert(stfcamss->sys_rst[STF_RST_ISP_TOP_N].rstc);
>> +	reset_control_deassert(stfcamss->sys_rst[STF_RST_ISP_TOP_AXI].rstc);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dev_pm_ops stfcamss_pm_ops = {
>> +	SET_RUNTIME_PM_OPS(stfcamss_runtime_suspend,
>> +			   stfcamss_runtime_resume,
>> +			   NULL)
>> +};
>> +
>> +static struct platform_driver stfcamss_driver = {
>> +	.probe = stfcamss_probe,
>> +	.remove = stfcamss_remove,
>> +	.driver = {
>> +		.name = DRV_NAME,
>> +		.pm = &stfcamss_pm_ops,
>> +		.of_match_table = of_match_ptr(stfcamss_of_match),
>> +	},
>> +};
>> +
>> +module_platform_driver(stfcamss_driver);
>> +
>> +MODULE_AUTHOR("StarFive Corporation");
>> +MODULE_DESCRIPTION("StarFive Camera Subsystem driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/media/platform/starfive/stf_camss.h b/drivers/media/platform/starfive/stf_camss.h
>> new file mode 100644
>> index 000000000000..8f39cd65950c
>> --- /dev/null
>> +++ b/drivers/media/platform/starfive/stf_camss.h
>> @@ -0,0 +1,153 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * stf_camss.h
>> + *
>> + * Starfive Camera Subsystem driver
>> + *
>> + * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#ifndef STF_CAMSS_H
>> +#define STF_CAMSS_H
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/reset.h>
>> +#include <media/v4l2-device.h>
> 
> You should include media/media-device.h, media/media-entity.h and
> media/v4l2-async.h.
> 

Okay, I will add them.

>> +	struct device *dev;
> 
>> +};
> 
>> +
>> +#include "stf_common.h"
>> +
>> +#define DRV_NAME     "starfive-camss"
> 
> DRV_NAME is used in stfcamss_driver.driver.name only. I would drop the
> macro and write
> 
> 		.name = "starfive-camss",
> 
> above, it will be more readable.
> 

Yes, I will modify the code.

>> +#define STF_DVP_NAME "stf_dvp"
>> +#define STF_CSI_NAME "cdns_csi2rx"
>> +#define STF_ISP_NAME "stf_isp"
>> +#define STF_VIN_NAME "stf_vin"
>> +
>> +#define STF_PAD_SINK   0
>> +#define STF_PAD_SRC    1
>> +#define STF_PADS_NUM   2
>> +
>> +enum port_num {
>> +	PORT_NUMBER_DVP_SENSOR = 0,
>> +	PORT_NUMBER_CSI2RX
> 
> Please name this stf_port_num and STF_PORT_*, to avoid namespace
> clashes. I would drop "NUMBER_", and name the two ports STF_PORT_DVP and
> STF_PORT_CSI2RX.
> 

Okay, I will fix it.

>> +};
>> +
>> +enum stf_clk {
>> +	STF_CLK_APB_FUNC = 0,
>> +	STF_CLK_WRAPPER_CLK_C,
>> +	STF_CLK_DVP_INV,
>> +	STF_CLK_AXIWR,
>> +	STF_CLK_MIPI_RX0_PXL,
>> +	STF_CLK_ISPCORE_2X,
>> +	STF_CLK_ISP_AXI,
>> +	STF_CLK_NUM
>> +};
>> +
>> +enum stf_rst {
>> +	STF_RST_WRAPPER_P = 0,
>> +	STF_RST_WRAPPER_C,
>> +	STF_RST_AXIRD,
>> +	STF_RST_AXIWR,
>> +	STF_RST_ISP_TOP_N,
>> +	STF_RST_ISP_TOP_AXI,
>> +	STF_RST_NUM
>> +};
>> +
>> +enum stf_irq {
>> +	STF_IRQ_VINWR = 0,
>> +	STF_IRQ_ISP,
>> +	STF_IRQ_ISPCSIL,
>> +	STF_IRQ_NUM
>> +};
>> +
>> +#define HOST_ENTITY_MAX		2
>> +
>> +struct host_data {
> 
> Same here, please name this stf_host_data.
> 

According to your previous suggestion, the optimized new code should not
use this structure, and I will delete it.

>> +	struct media_entity *host_entity[HOST_ENTITY_MAX];
>> +};
>> +
>> +struct stfcamss {
>> +	struct v4l2_device v4l2_dev;
>> +	struct media_device media_dev;
>> +	struct media_pipeline pipe;
>> +	struct device *dev;
>> +	struct v4l2_async_notifier notifier;
>> +	struct host_data host_data;
>> +	void __iomem *syscon_base;
>> +	void __iomem *isp_base;
>> +	int irq[STF_IRQ_NUM];
>> +	struct clk_bulk_data sys_clk[STF_CLK_NUM];
>> +	int nclks;
>> +	struct reset_control_bulk_data sys_rst[STF_RST_NUM];
>> +	int nrsts;
>> +};
>> +
>> +struct stfcamss_async_subdev {
>> +	struct v4l2_async_subdev asd;  /* must be first */
>> +	enum port_num port;
>> +};
>> +
>> +static inline u32 stf_isp_reg_read(struct stfcamss *stfcamss, u32 reg)
>> +{
>> +	return ioread32(stfcamss->isp_base + reg);
>> +}
>> +
>> +static inline void stf_isp_reg_write(struct stfcamss *stfcamss,
>> +				     u32 reg, u32 val)
>> +{
>> +	iowrite32(val, stfcamss->isp_base + reg);
>> +}
>> +
>> +static inline void stf_isp_reg_write_delay(struct stfcamss *stfcamss,
>> +					   u32 reg, u32 val, u32 delay)
>> +{
>> +	iowrite32(val, stfcamss->isp_base + reg);
>> +	usleep_range(1000 * delay, 1000 * delay + 100);
>> +}
>> +
>> +static inline void stf_isp_reg_set_bit(struct stfcamss *stfcamss,
>> +				       u32 reg, u32 mask, u32 val)
>> +{
>> +	u32 value;
>> +
>> +	value = ioread32(stfcamss->isp_base + reg) & ~mask;
>> +	val &= mask;
>> +	val |= value;
>> +	iowrite32(val, stfcamss->isp_base + reg);
>> +}
>> +
>> +static inline void stf_isp_reg_set(struct stfcamss *stfcamss, u32 reg, u32 mask)
>> +{
>> +	iowrite32(ioread32(stfcamss->isp_base + reg) | mask,
>> +		  stfcamss->isp_base + reg);
>> +}
>> +
>> +static inline u32 stf_syscon_reg_read(struct stfcamss *stfcamss, u32 reg)
>> +{
>> +	return ioread32(stfcamss->syscon_base + reg);
>> +}
>> +
>> +static inline void stf_syscon_reg_write(struct stfcamss *stfcamss,
>> +					u32 reg, u32 val)
>> +{
>> +	iowrite32(val, stfcamss->syscon_base + reg);
>> +}
>> +
>> +static inline void stf_syscon_reg_set_bit(struct stfcamss *stfcamss,
>> +					  u32 reg, u32 bit_mask)
>> +{
>> +	u32 value;
>> +
>> +	value = ioread32(stfcamss->syscon_base + reg);
>> +	iowrite32(value | bit_mask, stfcamss->syscon_base + reg);
>> +}
>> +
>> +static inline void stf_syscon_reg_clear_bit(struct stfcamss *stfcamss,
>> +					    u32 reg, u32 bit_mask)
>> +{
>> +	u32 value;
>> +
>> +	value = ioread32(stfcamss->syscon_base + reg);
>> +	iowrite32(value & ~bit_mask, stfcamss->syscon_base + reg);
>> +}
>> +#endif /* STF_CAMSS_H */
>> diff --git a/drivers/media/platform/starfive/stf_common.h b/drivers/media/platform/starfive/stf_common.h
>> new file mode 100644
>> index 000000000000..e04fca2d9cd4
>> --- /dev/null
>> +++ b/drivers/media/platform/starfive/stf_common.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * stf_common.h
>> + *
>> + * StarFive Camera Subsystem - Common definitions
>> + *
>> + * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#ifndef STF_COMMON_H
>> +#define STF_COMMON_H
>> +
>> +enum stf_subdev_type {
>> +	STF_SUBDEV_TYPE_VIN,
>> +	STF_SUBDEV_TYPE_ISP,
>> +};
> 
> Looking at the whole series, these two values are set in the struct vin_line
> and stf_isp_dev sdev_type fields, but they are never read. You can drop
> those two fields, drop this enum, and drop this header.
> 

Okay, I will drop them.

>> +
>> +#endif /* STF_COMMON_H */
>> 
> 
