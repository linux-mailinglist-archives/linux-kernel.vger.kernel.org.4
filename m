Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B736B3EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCJMGm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 07:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCJMGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:06:11 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6A7F92C8;
        Fri, 10 Mar 2023 04:06:00 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 91C4724E274;
        Fri, 10 Mar 2023 20:05:57 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 10 Mar
 2023 20:05:57 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 10 Mar
 2023 20:05:56 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 6/6] media: starfive: Add Starfive Camera Subsystem driver
Date:   Fri, 10 Mar 2023 20:05:53 +0800
Message-ID: <20230310120553.60586-7-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310120553.60586-1-jack.zhu@starfivetech.com>
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the driver for Starfive Camera Subsystem found on
Starfive JH7110 SoC. It is used for handing image sensor
data.

Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/starfive/Kconfig       |   18 +
 drivers/media/platform/starfive/Makefile      |   14 +
 drivers/media/platform/starfive/stf_camss.c   |  728 +++++++++
 drivers/media/platform/starfive/stf_camss.h   |  104 ++
 drivers/media/platform/starfive/stf_common.h  |  149 ++
 drivers/media/platform/starfive/stf_isp.c     | 1079 ++++++++++++++
 drivers/media/platform/starfive/stf_isp.h     |  183 +++
 .../media/platform/starfive/stf_isp_hw_ops.c  | 1286 ++++++++++++++++
 drivers/media/platform/starfive/stf_video.c   | 1286 ++++++++++++++++
 drivers/media/platform/starfive/stf_video.h   |   89 ++
 drivers/media/platform/starfive/stf_vin.c     | 1314 +++++++++++++++++
 drivers/media/platform/starfive/stf_vin.h     |  194 +++
 .../media/platform/starfive/stf_vin_hw_ops.c  |  357 +++++
 include/uapi/linux/stf_isp_ioctl.h            |  127 ++
 16 files changed, 6930 insertions(+)
 create mode 100644 drivers/media/platform/starfive/Kconfig
 create mode 100644 drivers/media/platform/starfive/Makefile
 create mode 100644 drivers/media/platform/starfive/stf_camss.c
 create mode 100644 drivers/media/platform/starfive/stf_camss.h
 create mode 100644 drivers/media/platform/starfive/stf_common.h
 create mode 100644 drivers/media/platform/starfive/stf_isp.c
 create mode 100644 drivers/media/platform/starfive/stf_isp.h
 create mode 100644 drivers/media/platform/starfive/stf_isp_hw_ops.c
 create mode 100644 drivers/media/platform/starfive/stf_video.c
 create mode 100644 drivers/media/platform/starfive/stf_video.h
 create mode 100644 drivers/media/platform/starfive/stf_vin.c
 create mode 100644 drivers/media/platform/starfive/stf_vin.h
 create mode 100644 drivers/media/platform/starfive/stf_vin_hw_ops.c
 create mode 100644 include/uapi/linux/stf_isp_ioctl.h

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index ee579916f874..627eaa0ab3ee 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -80,6 +80,7 @@ source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/Kconfig"
 source "drivers/media/platform/samsung/Kconfig"
 source "drivers/media/platform/st/Kconfig"
+source "drivers/media/platform/starfive/Kconfig"
 source "drivers/media/platform/sunxi/Kconfig"
 source "drivers/media/platform/ti/Kconfig"
 source "drivers/media/platform/verisilicon/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 5453bb868e67..5a038498a370 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -23,6 +23,7 @@ obj-y += renesas/
 obj-y += rockchip/
 obj-y += samsung/
 obj-y += st/
+obj-y += starfive/
 obj-y += sunxi/
 obj-y += ti/
 obj-y += verisilicon/
diff --git a/drivers/media/platform/starfive/Kconfig b/drivers/media/platform/starfive/Kconfig
new file mode 100644
index 000000000000..4bb1e25b66ca
--- /dev/null
+++ b/drivers/media/platform/starfive/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+comment "Starfive media platform drivers"
+
+config VIDEO_STARFIVE_CAMSS
+	tristate "Starfive Camera Subsystem driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && OF
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	help
+	   Enable this to support for the Starfive Camera subsystem
+	   found on Starfive JH7110 SoC.
+
+	   To compile this driver as a module, choose M here: the
+	   module will be called stf-camss.
diff --git a/drivers/media/platform/starfive/Makefile b/drivers/media/platform/starfive/Makefile
new file mode 100644
index 000000000000..bf497dd24bbb
--- /dev/null
+++ b/drivers/media/platform/starfive/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for StarFive camera subsystem driver.
+#
+
+starfive-camss-objs += \
+		stf_camss.o \
+		stf_isp.o \
+		stf_isp_hw_ops.o \
+		stf_video.o \
+		stf_vin.o \
+		stf_vin_hw_ops.o
+
+obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o \
diff --git a/drivers/media/platform/starfive/stf_camss.c b/drivers/media/platform/starfive/stf_camss.c
new file mode 100644
index 000000000000..525f2d80c5eb
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_camss.c
@@ -0,0 +1,728 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_camss.c
+ *
+ * Starfive Camera Subsystem driver
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/videodev2.h>
+#include <media/media-device.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-mc.h>
+
+#include "stf_camss.h"
+
+static struct clk_bulk_data stfcamss_clocks[] = {
+	{ .id = "clk_apb_func" },
+	{ .id = "clk_wrapper_clk_c" },
+	{ .id = "clk_dvp_inv" },
+	{ .id = "clk_axiwr" },
+	{ .id = "clk_mipi_rx0_pxl" },
+	{ .id = "clk_ispcore_2x" },
+	{ .id = "clk_isp_axi" },
+};
+
+static struct reset_control_bulk_data stfcamss_resets[] = {
+	{ .id = "rst_wrapper_p" },
+	{ .id = "rst_wrapper_c" },
+	{ .id = "rst_axird" },
+	{ .id = "rst_axiwr" },
+	{ .id = "rst_isp_top_n" },
+	{ .id = "rst_isp_top_axi" },
+};
+
+int stfcamss_get_mem_res(struct platform_device *pdev,
+			 struct stfcamss *stfcamss)
+{
+	stfcamss->syscon_base =
+		devm_platform_ioremap_resource_byname(pdev, "syscon");
+	if (IS_ERR(stfcamss->syscon_base))
+		return PTR_ERR(stfcamss->syscon_base);
+
+	stfcamss->isp_base =
+		devm_platform_ioremap_resource_byname(pdev, "isp");
+	if (IS_ERR(stfcamss->isp_base))
+		return PTR_ERR(stfcamss->isp_base);
+
+	return 0;
+}
+
+/*
+ * stfcamss_find_sensor - Find a linked media entity which represents a sensor
+ * @entity: Media entity to start searching from
+ *
+ * Return a pointer to sensor media entity or NULL if not found
+ */
+struct media_entity *stfcamss_find_sensor(struct media_entity *entity)
+{
+	struct media_pad *pad;
+
+	while (1) {
+		if (!entity->pads)
+			return NULL;
+
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			return NULL;
+
+		pad = media_pad_remote_pad_first(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			return NULL;
+
+		entity = pad->entity;
+
+		if (entity->function == MEDIA_ENT_F_CAM_SENSOR)
+			return entity;
+	}
+}
+
+/*
+ * stfcamss_of_parse_endpoint_node - Parse port endpoint node
+ * @dev: Device
+ * @node: Device node to be parsed
+ * @csd: Parsed data from port endpoint node
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int stfcamss_of_parse_endpoint_node(struct device *dev,
+					   struct device_node *node,
+					   struct stfcamss_async_subdev *csd)
+{
+	struct v4l2_fwnode_endpoint vep = { { 0 } };
+
+	v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+	st_debug(ST_CAMSS, "%s: vep.base.port = 0x%x, id = 0x%x\n",
+		 __func__, vep.base.port, vep.base.id);
+
+	csd->port = vep.base.port;
+	switch (csd->port) {
+	case PORT_NUMBER_DVP_SENSOR:
+		break;
+	case PORT_NUMBER_CSI2RX:
+		break;
+	default:
+		break;
+	};
+
+	return 0;
+}
+
+/*
+ * stfcamss_of_parse_ports - Parse ports node
+ * @stfcamss: STFCAMSS device
+ *
+ * Return number of "port" nodes found in "ports" node
+ */
+static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
+{
+	struct device *dev = stfcamss->dev;
+	struct device_node *node = NULL;
+	struct device_node *remote = NULL;
+	int ret, num_subdevs = 0;
+
+	for_each_endpoint_of_node(dev->of_node, node) {
+		struct stfcamss_async_subdev *csd;
+
+		if (!of_device_is_available(node))
+			continue;
+
+		remote = of_graph_get_remote_port_parent(node);
+		if (!remote) {
+			st_err(ST_CAMSS, "Cannot get remote parent\n");
+			ret = -EINVAL;
+			goto err_cleanup;
+		}
+
+		csd = v4l2_async_nf_add_fwnode(&stfcamss->notifier,
+					       of_fwnode_handle(remote),
+					       struct stfcamss_async_subdev);
+		of_node_put(remote);
+		if (IS_ERR(csd)) {
+			ret = PTR_ERR(csd);
+			goto err_cleanup;
+		}
+
+		ret = stfcamss_of_parse_endpoint_node(dev, node, csd);
+		if (ret < 0)
+			goto err_cleanup;
+
+		num_subdevs++;
+	}
+
+	return num_subdevs;
+
+err_cleanup:
+	of_node_put(node);
+	return ret;
+}
+
+/*
+ * stfcamss_init_subdevices - Initialize subdev structures and resources
+ * @stfcamss: STFCAMSS device
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int stfcamss_init_subdevices(struct stfcamss *stfcamss)
+{
+	int ret;
+
+	ret = stf_isp_subdev_init(stfcamss);
+	if (ret < 0) {
+		st_err(ST_CAMSS,
+		       "Failed to init stf_isp sub-device: %d\n", ret);
+		return ret;
+	}
+
+	ret = stf_vin_subdev_init(stfcamss);
+	if (ret < 0) {
+		st_err(ST_CAMSS,
+		       "Failed to init stf_vin sub-device: %d\n", ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int stfcamss_register_subdevices(struct stfcamss *stfcamss)
+{
+	int ret;
+	struct stf_vin_dev *vin_dev = stfcamss->vin_dev;
+	struct stf_isp_dev *isp_dev = stfcamss->isp_dev;
+
+	ret = stf_isp_register(isp_dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		st_err(ST_CAMSS,
+		       "Failed to register stf isp%d entity: %d\n", 0, ret);
+		goto err_reg_isp;
+	}
+
+	ret = stf_vin_register(vin_dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		st_err(ST_CAMSS,
+		       "Failed to register vin entity: %d\n", ret);
+		goto err_reg_vin;
+	}
+
+	ret = media_create_pad_link(&isp_dev->subdev.entity,
+				    STF_ISP_PAD_SRC,
+				    &vin_dev->line[VIN_LINE_ISP].subdev.entity,
+				    STF_VIN_PAD_SINK,
+				    0);
+	if (ret < 0) {
+		st_err(ST_CAMSS,
+		       "Failed to link %s->%s entities: %d\n",
+		       isp_dev->subdev.entity.name,
+		       vin_dev->line[VIN_LINE_ISP].subdev.entity.name,
+		       ret);
+		goto err_link;
+	}
+
+	ret = media_create_pad_link(
+		&isp_dev->subdev.entity,
+		STF_ISP_PAD_SRC_SS0,
+		&vin_dev->line[VIN_LINE_ISP_SS0].subdev.entity,
+		STF_VIN_PAD_SINK,
+		0);
+
+	if (ret < 0) {
+		st_err(ST_CAMSS,
+		       "Failed to link %s->%s entities: %d\n",
+		       isp_dev->subdev.entity.name,
+		       vin_dev->line[VIN_LINE_ISP_SS0].subdev.entity.name,
+		       ret);
+		goto err_link;
+	}
+
+	ret = media_create_pad_link(
+		&isp_dev->subdev.entity,
+		STF_ISP_PAD_SRC_SS1,
+		&vin_dev->line[VIN_LINE_ISP_SS1].subdev.entity,
+		STF_VIN_PAD_SINK,
+		0);
+	if (ret < 0) {
+		st_err(ST_CAMSS,
+		       "Failed to link %s->%s entities: %d\n",
+		       isp_dev->subdev.entity.name,
+		       vin_dev->line[VIN_LINE_ISP_SS1].subdev.entity.name,
+		       ret);
+		goto err_link;
+	}
+
+	ret = media_create_pad_link(
+		&isp_dev->subdev.entity,
+		STF_ISP_PAD_SRC_RAW,
+		&vin_dev->line[VIN_LINE_ISP_RAW].subdev.entity,
+		STF_VIN_PAD_SINK,
+		0);
+	if (ret < 0) {
+		st_err(ST_CAMSS,
+		       "Failed to link %s->%s entities: %d\n",
+		       isp_dev->subdev.entity.name,
+		       vin_dev->line[VIN_LINE_ISP_RAW].subdev.entity.name,
+		       ret);
+		goto err_link;
+	}
+
+	return ret;
+
+err_link:
+	stf_vin_unregister(stfcamss->vin_dev);
+err_reg_vin:
+	stf_isp_unregister(stfcamss->isp_dev);
+err_reg_isp:
+	return ret;
+}
+
+static void stfcamss_unregister_subdevices(struct stfcamss *stfcamss)
+{
+	stf_isp_unregister(stfcamss->isp_dev);
+	stf_vin_unregister(stfcamss->vin_dev);
+}
+
+static int stfcamss_register_media_subdev_nod(struct v4l2_async_notifier *async,
+					      struct v4l2_subdev *sd)
+{
+	struct stfcamss *stfcamss =
+		container_of(async, struct stfcamss, notifier);
+	struct host_data *host_data = v4l2_get_subdev_hostdata(sd);
+	struct media_entity *sensor;
+	struct media_entity *input;
+	int ret;
+	int i, j;
+
+	for (i = 0; host_data->host_entity[i] && (i < HOST_ENTITY_MAX); i++) {
+		sensor = &sd->entity;
+		input = host_data->host_entity[i];
+
+		for (j = 0; j < sensor->num_pads; j++) {
+			if (sensor->pads[j].flags & MEDIA_PAD_FL_SOURCE)
+				break;
+		}
+
+		if (j == sensor->num_pads) {
+			st_err(ST_CAMSS, "No source pad in external entity\n");
+			return -EINVAL;
+		}
+
+		ret = media_create_pad_link(
+			sensor,
+			j,
+			input,
+			STF_PAD_SINK,
+			sensor->function == MEDIA_ENT_F_CAM_SENSOR ?
+			MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED :
+			0);
+		if (ret < 0) {
+			st_err(ST_CAMSS, "Failed to link %s->%s entities: %d\n",
+			       sensor->name, input->name, ret);
+			return ret;
+		}
+	}
+
+	ret = v4l2_device_register_subdev_nodes(&stfcamss->v4l2_dev);
+	if (ret < 0)
+		return ret;
+
+	if (stfcamss->media_dev.devnode)
+		return ret;
+
+	st_debug(ST_CAMSS, "stfcamss register media device\n");
+	return media_device_register(&stfcamss->media_dev);
+}
+
+static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
+					  struct v4l2_subdev *subdev,
+					  struct v4l2_async_subdev *asd)
+{
+	struct stfcamss *stfcamss =
+		container_of(async, struct stfcamss, notifier);
+	struct stfcamss_async_subdev *csd =
+		container_of(asd, struct stfcamss_async_subdev, asd);
+	enum port_num port = csd->port;
+	struct stf_isp_dev *isp_dev = stfcamss->isp_dev;
+	struct stf_vin_dev *vin_dev = stfcamss->vin_dev;
+	struct host_data *host_data = &stfcamss->host_data;
+
+	switch (port) {
+	case PORT_NUMBER_DVP_SENSOR:
+		host_data->host_entity[0] = NULL;
+		host_data->host_entity[1] = NULL;
+		/* not support DVP sensor */
+		break;
+	case PORT_NUMBER_CSI2RX:
+		host_data->host_entity[0] =
+			&vin_dev->line[VIN_LINE_WR].subdev.entity;
+		host_data->host_entity[1] = &isp_dev->subdev.entity;
+		break;
+	default:
+		break;
+	};
+
+	v4l2_set_subdev_hostdata(subdev, host_data);
+	stfcamss_register_media_subdev_nod(async, subdev);
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations
+stfcamss_subdev_notifier_ops = {
+	.bound = stfcamss_subdev_notifier_bound,
+};
+
+static const struct media_device_ops stfcamss_media_ops = {
+	.link_notify = v4l2_pipeline_link_notify,
+};
+
+/*
+ * stfcamss_probe - Probe STFCAMSS platform device
+ * @pdev: Pointer to STFCAMSS platform device
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int stfcamss_probe(struct platform_device *pdev)
+{
+	struct stfcamss *stfcamss;
+	struct device *dev = &pdev->dev;
+	int ret = 0, num_subdevs;
+
+	stfcamss = devm_kzalloc(dev, sizeof(struct stfcamss), GFP_KERNEL);
+	if (!stfcamss)
+		return -ENOMEM;
+
+	stfcamss->isp_dev = devm_kzalloc(dev, sizeof(*stfcamss->isp_dev),
+					 GFP_KERNEL);
+	if (!stfcamss->isp_dev) {
+		ret = -ENOMEM;
+		goto err_cam;
+	}
+
+	stfcamss->vin_dev = devm_kzalloc(dev, sizeof(*stfcamss->vin_dev),
+					 GFP_KERNEL);
+	if (!stfcamss->vin_dev) {
+		ret = -ENOMEM;
+		goto err_cam;
+	}
+
+	stfcamss->irq = platform_get_irq(pdev, 0);
+	if (stfcamss->irq <= 0) {
+		st_err(ST_CAMSS, "Could not get irq\n");
+		goto err_cam;
+	}
+
+	stfcamss->isp_irq = platform_get_irq(pdev, 1);
+	if (stfcamss->isp_irq <= 0) {
+		st_err(ST_CAMSS, "Could not get isp irq\n");
+		goto err_cam;
+	}
+
+	stfcamss->isp_irq_csi = platform_get_irq(pdev, 2);
+	if (stfcamss->isp_irq_csi <= 0) {
+		st_err(ST_CAMSS, "Could not get isp csi irq\n");
+		goto err_cam;
+	}
+
+	stfcamss->isp_irq_csiline = platform_get_irq(pdev, 3);
+	if (stfcamss->isp_irq_csiline <= 0) {
+		st_err(ST_CAMSS, "Could not get isp irq csiline\n");
+		goto err_cam;
+	}
+
+	pm_runtime_enable(dev);
+
+	stfcamss->nclks = ARRAY_SIZE(stfcamss_clocks);
+	stfcamss->sys_clk = stfcamss_clocks;
+
+	ret = devm_clk_bulk_get(dev, stfcamss->nclks, stfcamss->sys_clk);
+	if (ret) {
+		st_err(ST_CAMSS, "Failed to get clk controls\n");
+		return ret;
+	}
+
+	stfcamss->nrsts = ARRAY_SIZE(stfcamss_resets);
+	stfcamss->sys_rst = stfcamss_resets;
+
+	ret = devm_reset_control_bulk_get_shared(dev, stfcamss->nrsts,
+						 stfcamss->sys_rst);
+	if (ret) {
+		st_err(ST_CAMSS, "Failed to get reset controls\n");
+		return ret;
+	}
+
+	ret = stfcamss_get_mem_res(pdev, stfcamss);
+	if (ret) {
+		st_err(ST_CAMSS, "Could not map registers\n");
+		goto err_cam;
+	}
+
+	stfcamss->dev = dev;
+	platform_set_drvdata(pdev, stfcamss);
+
+	v4l2_async_nf_init(&stfcamss->notifier);
+
+	num_subdevs = stfcamss_of_parse_ports(stfcamss);
+	if (num_subdevs < 0) {
+		ret = num_subdevs;
+		goto err_cam_noti;
+	}
+
+	ret = stfcamss_init_subdevices(stfcamss);
+	if (ret < 0) {
+		st_err(ST_CAMSS, "Failed to init subdevice: %d\n", ret);
+		goto err_cam_noti;
+	}
+
+	stfcamss->media_dev.dev = stfcamss->dev;
+	strscpy(stfcamss->media_dev.model, "Starfive Camera Subsystem",
+		sizeof(stfcamss->media_dev.model));
+	strscpy(stfcamss->media_dev.serial, "0123456789ABCDEF",
+		sizeof(stfcamss->media_dev.serial));
+	snprintf(stfcamss->media_dev.bus_info,
+		 sizeof(stfcamss->media_dev.bus_info),
+		 "%s:%s", dev_bus_name(dev), pdev->name);
+	stfcamss->media_dev.hw_revision = 0x01;
+	stfcamss->media_dev.ops = &stfcamss_media_ops;
+	media_device_init(&stfcamss->media_dev);
+
+	stfcamss->v4l2_dev.mdev = &stfcamss->media_dev;
+
+	ret = v4l2_device_register(stfcamss->dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		st_err(ST_CAMSS, "Failed to register V4L2 device: %d\n", ret);
+		goto err_cam_noti_med;
+	}
+
+	ret = stfcamss_register_subdevices(stfcamss);
+	if (ret < 0) {
+		st_err(ST_CAMSS, "Failed to register subdevice: %d\n", ret);
+		goto err_cam_noti_med_vreg;
+	}
+
+	if (num_subdevs) {
+		stfcamss->notifier.ops = &stfcamss_subdev_notifier_ops;
+		ret = v4l2_async_nf_register(&stfcamss->v4l2_dev,
+					     &stfcamss->notifier);
+		if (ret) {
+			st_err(ST_CAMSS,
+			       "Failed to register async subdev nodes: %d\n",
+			       ret);
+			goto err_cam_noti_med_vreg_sub;
+		}
+	} else {
+		ret = v4l2_device_register_subdev_nodes(&stfcamss->v4l2_dev);
+		if (ret < 0) {
+			st_err(ST_CAMSS,
+			       "Failed to register subdev nodes: %d\n",
+			       ret);
+			goto err_cam_noti_med_vreg_sub;
+		}
+
+		ret = media_device_register(&stfcamss->media_dev);
+		if (ret < 0) {
+			st_err(ST_CAMSS,
+			       "Failed to register media device: %d\n",
+			       ret);
+			goto err_cam_noti_med_vreg_sub_medreg;
+		}
+	}
+
+	dev_info(dev, "stfcamss probe success!\n");
+	return 0;
+
+err_cam_noti_med_vreg_sub_medreg:
+err_cam_noti_med_vreg_sub:
+	stfcamss_unregister_subdevices(stfcamss);
+err_cam_noti_med_vreg:
+	v4l2_device_unregister(&stfcamss->v4l2_dev);
+err_cam_noti_med:
+	media_device_cleanup(&stfcamss->media_dev);
+err_cam_noti:
+	v4l2_async_nf_cleanup(&stfcamss->notifier);
+err_cam:
+	return ret;
+}
+
+/*
+ * stfcamss_remove - Remove STFCAMSS platform device
+ * @pdev: Pointer to STFCAMSS platform device
+ *
+ * Always returns 0.
+ */
+static int stfcamss_remove(struct platform_device *pdev)
+{
+	struct stfcamss *stfcamss = platform_get_drvdata(pdev);
+
+	dev_info(&pdev->dev, "remove done\n");
+
+	stfcamss_unregister_subdevices(stfcamss);
+	v4l2_device_unregister(&stfcamss->v4l2_dev);
+	media_device_cleanup(&stfcamss->media_dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id stfcamss_of_match[] = {
+	{ .compatible = "starfive,jh7110-camss" },
+	{ /* end node */ },
+};
+
+MODULE_DEVICE_TABLE(of, stfcamss_of_match);
+
+#ifdef CONFIG_PM_SLEEP
+static int stfcamss_suspend(struct device *dev)
+{
+	struct stfcamss *stfcamss = dev_get_drvdata(dev);
+	struct stf_vin_dev *vin_dev = stfcamss->vin_dev;
+	struct media_entity *entity;
+	struct media_pad *pad;
+	struct v4l2_subdev *subdev;
+	struct stfcamss_video *video;
+	struct video_device *vdev;
+	int i = 0;
+
+	for (i = 0; i < VIN_LINE_MAX; i++) {
+		if (vin_dev->line[i].stream_count) {
+			vin_dev->line[i].stream_count++;
+			video = &vin_dev->line[i].video_out;
+			vdev = &vin_dev->line[i].video_out.vdev;
+			entity = &vdev->entity;
+			while (1) {
+				pad = &entity->pads[0];
+				if (!(pad->flags & MEDIA_PAD_FL_SINK))
+					break;
+
+				pad = media_pad_remote_pad_first(pad);
+				if (!pad ||
+				    !is_media_entity_v4l2_subdev(pad->entity))
+					break;
+
+				entity = pad->entity;
+				subdev = media_entity_to_v4l2_subdev(entity);
+
+				v4l2_subdev_call(subdev, video, s_stream, 0);
+			}
+			video_device_pipeline_stop(vdev);
+			video->ops->flush_buffers(video, VB2_BUF_STATE_ERROR);
+			v4l2_pipeline_pm_put(&vdev->entity);
+		}
+	}
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int stfcamss_resume(struct device *dev)
+{
+	struct stfcamss *stfcamss = dev_get_drvdata(dev);
+	struct stf_vin_dev *vin_dev = stfcamss->vin_dev;
+	struct media_entity *entity;
+	struct media_pad *pad;
+	struct v4l2_subdev *subdev;
+	struct stfcamss_video *video;
+	struct video_device *vdev;
+	int i = 0;
+	int ret = 0;
+
+	pm_runtime_force_resume(dev);
+
+	for (i = 0; i < VIN_LINE_MAX; i++) {
+		if (vin_dev->line[i].stream_count) {
+			vin_dev->line[i].stream_count--;
+			video = &vin_dev->line[i].video_out;
+			vdev = &vin_dev->line[i].video_out.vdev;
+
+			ret = v4l2_pipeline_pm_get(&vdev->entity);
+			if (ret < 0)
+				goto err;
+
+			ret = video_device_pipeline_start(
+				vdev, &video->stfcamss->pipe);
+			if (ret < 0)
+				goto err_pm_put;
+
+			entity = &vdev->entity;
+			while (1) {
+				pad = &entity->pads[0];
+				if (!(pad->flags & MEDIA_PAD_FL_SINK))
+					break;
+
+				pad = media_pad_remote_pad_first(pad);
+				if (!pad ||
+				    !is_media_entity_v4l2_subdev(pad->entity))
+					break;
+
+				entity = pad->entity;
+				subdev = media_entity_to_v4l2_subdev(entity);
+
+				ret = v4l2_subdev_call(subdev, video,
+						       s_stream, 1);
+				if (ret < 0 && ret != -ENOIOCTLCMD)
+					goto err_pipeline_stop;
+			}
+		}
+	}
+
+	return 0;
+
+err_pipeline_stop:
+	video_device_pipeline_stop(vdev);
+err_pm_put:
+	v4l2_pipeline_pm_put(&vdev->entity);
+err:
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM
+static int stfcamss_runtime_suspend(struct device *dev)
+{
+	struct stfcamss *stfcamss = dev_get_drvdata(dev);
+
+	reset_control_assert(stfcamss->sys_rst[STF_RST_ISP_TOP_AXI].rstc);
+	reset_control_assert(stfcamss->sys_rst[STF_RST_ISP_TOP_N].rstc);
+	clk_disable_unprepare(stfcamss->sys_clk[STF_CLK_ISP_AXI].clk);
+	clk_disable_unprepare(stfcamss->sys_clk[STF_CLK_ISPCORE_2X].clk);
+
+	return 0;
+}
+
+static int stfcamss_runtime_resume(struct device *dev)
+{
+	struct stfcamss *stfcamss = dev_get_drvdata(dev);
+
+	clk_prepare_enable(stfcamss->sys_clk[STF_CLK_ISPCORE_2X].clk);
+	clk_prepare_enable(stfcamss->sys_clk[STF_CLK_ISP_AXI].clk);
+	reset_control_deassert(stfcamss->sys_rst[STF_RST_ISP_TOP_N].rstc);
+	reset_control_deassert(stfcamss->sys_rst[STF_RST_ISP_TOP_AXI].rstc);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops stfcamss_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stfcamss_suspend, stfcamss_resume)
+	SET_RUNTIME_PM_OPS(stfcamss_runtime_suspend,
+			   stfcamss_runtime_resume,
+			   NULL)
+};
+
+static struct platform_driver stfcamss_driver = {
+	.probe = stfcamss_probe,
+	.remove = stfcamss_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.pm = &stfcamss_pm_ops,
+		.of_match_table = of_match_ptr(stfcamss_of_match),
+	},
+};
+
+module_platform_driver(stfcamss_driver);
+
+MODULE_AUTHOR("StarFive Corporation");
+MODULE_DESCRIPTION("StarFive Camera Subsystem driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/starfive/stf_camss.h b/drivers/media/platform/starfive/stf_camss.h
new file mode 100644
index 000000000000..a8c6579d62ed
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_camss.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * stf_camss.h
+ *
+ * Starfive Camera Subsystem driver
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_CAMSS_H
+#define STF_CAMSS_H
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <media/v4l2-device.h>
+
+enum sensor_type {
+	SENSOR_VIN,
+	/* need replace sensor */
+	SENSOR_ISP,
+};
+
+enum subdev_type {
+	SUBDEV_TYPE_VIN,
+	SUBDEV_TYPE_ISP,
+};
+
+#include "stf_common.h"
+#include "stf_isp.h"
+#include "stf_vin.h"
+
+#define DRV_NAME     "starfive-camss"
+#define STF_DVP_NAME "stf_dvp"
+#define STF_CSI_NAME "cdns_csi2rx"
+#define STF_ISP_NAME "stf_isp"
+#define STF_VIN_NAME "stf_vin"
+
+#define STF_PAD_SINK   0
+#define STF_PAD_SRC    1
+#define STF_PADS_NUM   2
+
+enum port_num {
+	PORT_NUMBER_DVP_SENSOR = 0,
+	PORT_NUMBER_CSI2RX
+};
+
+enum stf_clk {
+	STF_CLK_APB_FUNC = 0,
+	STF_CLK_WRAPPER_CLK_C,
+	STF_CLK_DVP_INV,
+	STF_CLK_AXIWR,
+	STF_CLK_MIPI_RX0_PXL,
+	STF_CLK_ISPCORE_2X,
+	STF_CLK_ISP_AXI,
+	STF_CLK_NUM
+};
+
+enum stf_rst {
+	STF_RST_WRAPPER_P = 0,
+	STF_RST_WRAPPER_C,
+	STF_RST_AXIRD,
+	STF_RST_AXIWR,
+	STF_RST_ISP_TOP_N,
+	STF_RST_ISP_TOP_AXI,
+	STF_RST_NUM
+};
+
+#define HOST_ENTITY_MAX		2
+
+struct host_data {
+	struct media_entity *host_entity[HOST_ENTITY_MAX];
+};
+
+struct stfcamss {
+	struct v4l2_device v4l2_dev;
+	struct media_device media_dev;
+	struct media_pipeline pipe;
+	struct device *dev;
+	struct stf_vin_dev *vin_dev;
+	struct stf_isp_dev *isp_dev;
+	struct v4l2_async_notifier notifier;
+	struct host_data host_data;
+	void __iomem *syscon_base;
+	void __iomem *isp_base;
+	int irq;
+	int isp_irq;
+	int isp_irq_csi;
+	int isp_irq_csiline;
+	struct clk_bulk_data *sys_clk;
+	int nclks;
+	struct reset_control_bulk_data *sys_rst;
+	int nrsts;
+	struct regmap *stf_aon_syscon;
+	u32 aon_gp_reg;
+};
+
+struct stfcamss_async_subdev {
+	struct v4l2_async_subdev asd;  /* must be first */
+	enum port_num port;
+};
+
+struct media_entity *stfcamss_find_sensor(struct media_entity *entity);
+
+#endif /* STF_CAMSS_H */
diff --git a/drivers/media/platform/starfive/stf_common.h b/drivers/media/platform/starfive/stf_common.h
new file mode 100644
index 000000000000..90f5e4c3061c
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_common.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * stf_common.h
+ *
+ * StarFive Camera Subsystem - Common definitions
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_COMMON_H
+#define STF_COMMON_H
+
+#include <linux/io.h>
+#include <linux/kern_levels.h>
+
+enum {
+	ST_DVP = 0x0001,
+	ST_ISP = 0x0002,
+	ST_VIN = 0x0004,
+	ST_VIDEO = 0x0008,
+	ST_CAMSS = 0x0010,
+	ST_SENSOR = 0x0020,
+};
+
+enum {
+	ST_NONE = 0x00,
+	ST_ERR = 0x01,
+	ST_WARN = 0x02,
+	ST_INFO = 0x03,
+	ST_DEBUG = 0x04,
+};
+
+#ifdef STF_DEBUG
+#define STFDBG_LEVEL	ST_DEBUG
+#define STFDBG_MASK	0x7F
+#else
+#define STFDBG_LEVEL	ST_ERR
+#define STFDBG_MASK	0x7F
+#endif
+
+#define ST_MODULE2STRING(__module) ({ \
+	char *__str;			\
+					\
+	switch (__module) {		\
+	case ST_DVP:			\
+		__str = "st_dvp";	\
+		break;			\
+	case ST_ISP:			\
+		__str = "st_isp";	\
+		break;			\
+	case ST_VIN:			\
+		__str = "st_vin";	\
+		break;			\
+	case ST_VIDEO:			\
+		__str = "st_video";	\
+		break;			\
+	case ST_CAMSS:			\
+		__str = "st_camss";	\
+		break;			\
+	case ST_SENSOR:			\
+		__str = "st_sensor";	\
+		break;			\
+	default:			\
+		__str = "unknown";	\
+		break;			\
+	}				\
+					\
+	__str;				\
+	})
+
+#define st_debug(module, __fmt, arg...)					\
+	do {								\
+		if (STFDBG_LEVEL > ST_INFO) {				\
+			if (STFDBG_MASK & (module))			\
+				pr_err("[%s] debug: " __fmt,		\
+				       ST_MODULE2STRING((module)),	\
+				       ## arg);				\
+		}							\
+	} while (0)
+
+#define st_info(module, __fmt, arg...)					\
+	do {								\
+		if (STFDBG_LEVEL > ST_WARN) {				\
+			if (STFDBG_MASK & (module))			\
+				pr_err("[%s] info: " __fmt,		\
+				       ST_MODULE2STRING((module)),	\
+				       ## arg);				\
+		}							\
+	} while (0)
+
+#define st_warn(module, __fmt, arg...)					\
+	do {								\
+		if (STFDBG_LEVEL > ST_ERR) {				\
+			if (STFDBG_MASK & (module))			\
+				pr_err("[%s] warn: " __fmt,		\
+				       ST_MODULE2STRING((module)),	\
+				       ## arg);				\
+		}							\
+	} while (0)
+
+#define st_err(module, __fmt, arg...)					\
+	do {								\
+		if (STFDBG_LEVEL > ST_NONE) {				\
+			if (STFDBG_MASK & (module))			\
+				pr_err("[%s] error: " __fmt,		\
+				       ST_MODULE2STRING((module)),	\
+				       ## arg);				\
+		}							\
+	} while (0)
+
+#define st_err_ratelimited(module, fmt, ...)				\
+	do {								\
+		static DEFINE_RATELIMIT_STATE(_rs,			\
+					      DEFAULT_RATELIMIT_INTERVAL, \
+					      DEFAULT_RATELIMIT_BURST); \
+		if (__ratelimit(&_rs) && STFDBG_LEVEL > ST_NONE) {	\
+			if (STFDBG_MASK & (module))			\
+				pr_err("[%s] error: " fmt,		\
+				       ST_MODULE2STRING((module)),	\
+				       ##__VA_ARGS__);			\
+		}							\
+	} while (0)
+
+static inline u32 reg_read(void __iomem *base, u32 reg)
+{
+	return ioread32(base + reg);
+}
+
+static inline void reg_write(void __iomem *base, u32 reg, u32 val)
+{
+	iowrite32(val, base + reg);
+}
+
+static inline void reg_set_bit(void __iomem *base, u32 reg, u32 mask, u32 val)
+{
+	u32 value;
+
+	value = ioread32(base + reg) & ~mask;
+	val &= mask;
+	val |= value;
+	iowrite32(val, base + reg);
+}
+
+static inline void reg_set(void __iomem *base, u32 reg, u32 mask)
+{
+	iowrite32(ioread32(base + reg) | mask, base + reg);
+}
+
+#endif /* STF_COMMON_H */
diff --git a/drivers/media/platform/starfive/stf_isp.c b/drivers/media/platform/starfive/stf_isp.c
new file mode 100644
index 000000000000..0c67d1d06e03
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_isp.c
@@ -0,0 +1,1079 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_isp.c
+ *
+ * StarFive Camera Subsystem - ISP Module
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+#include <linux/firmware.h>
+#include <linux/stf_isp_ioctl.h>
+#include <media/v4l2-event.h>
+
+#include "stf_camss.h"
+
+#define SINK_FORMATS_INDEX    0
+#define UO_FORMATS_INDEX      1
+#define RAW_FORMATS_INDEX     2
+
+static int user_config_isp;
+
+static int isp_set_selection(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_state *state,
+			     struct v4l2_subdev_selection *sel);
+
+static struct v4l2_rect *
+__isp_get_compose(struct stf_isp_dev *isp_dev,
+		  struct v4l2_subdev_state *state,
+		  enum v4l2_subdev_format_whence which);
+
+static struct v4l2_rect *
+__isp_get_crop(struct stf_isp_dev *isp_dev,
+	       struct v4l2_subdev_state *state,
+	       enum v4l2_subdev_format_whence which);
+
+static struct v4l2_rect *
+__isp_get_scale(struct stf_isp_dev *isp_dev,
+		struct v4l2_subdev_state *state,
+		struct v4l2_subdev_selection *sel);
+
+static const struct isp_format isp_formats_sink[] = {
+	{ MEDIA_BUS_FMT_SRGGB10_1X10, 10 },
+	{ MEDIA_BUS_FMT_SGRBG10_1X10, 10 },
+	{ MEDIA_BUS_FMT_SGBRG10_1X10, 10 },
+	{ MEDIA_BUS_FMT_SBGGR10_1X10, 10 },
+};
+
+static const struct isp_format isp_formats_raw[] = {
+	{ MEDIA_BUS_FMT_SRGGB12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SGRBG12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SGBRG12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SBGGR12_1X12, 12 },
+};
+
+static const struct isp_format isp_formats_compat_raw10[] = {
+	{ MEDIA_BUS_FMT_SRGGB10_1X10, 10 },
+	{ MEDIA_BUS_FMT_SGRBG10_1X10, 10 },
+	{ MEDIA_BUS_FMT_SGBRG10_1X10, 10 },
+	{ MEDIA_BUS_FMT_SBGGR10_1X10, 10 },
+};
+
+static const struct isp_format isp_formats_compat_raw8[] = {
+	{ MEDIA_BUS_FMT_SRGGB8_1X8, 8 },
+	{ MEDIA_BUS_FMT_SGRBG8_1X8, 8 },
+	{ MEDIA_BUS_FMT_SGBRG8_1X8, 8 },
+	{ MEDIA_BUS_FMT_SBGGR8_1X8, 8 },
+};
+
+static const struct isp_format isp_formats_uo[] = {
+	{ MEDIA_BUS_FMT_Y12_1X12, 8 },
+};
+
+static const struct isp_format_table isp_formats_st7110[] = {
+	{ isp_formats_sink, ARRAY_SIZE(isp_formats_sink) },
+	{ isp_formats_uo, ARRAY_SIZE(isp_formats_uo) },
+	{ isp_formats_raw, ARRAY_SIZE(isp_formats_raw) },
+};
+
+int stf_isp_subdev_init(struct stfcamss *stfcamss)
+{
+	struct stf_isp_dev *isp_dev = stfcamss->isp_dev;
+	struct device *dev = stfcamss->dev;
+
+	isp_dev->sdev_type = SUBDEV_TYPE_ISP;
+	isp_dev->hw_ops = &isp_ops;
+	isp_dev->stfcamss = stfcamss;
+	isp_dev->formats = isp_formats_st7110;
+	isp_dev->nformats = ARRAY_SIZE(isp_formats_st7110);
+	isp_dev->reg_buf = devm_kzalloc(dev, sizeof(*isp_dev->reg_buf),
+					GFP_KERNEL);
+	if (!isp_dev->reg_buf)
+		return -ENOMEM;
+
+	mutex_init(&isp_dev->stream_lock);
+	mutex_init(&isp_dev->power_lock);
+	mutex_init(&isp_dev->setfile_lock);
+	atomic_set(&isp_dev->shadow_count, 0);
+	return 0;
+}
+
+static int isp_set_power(struct v4l2_subdev *sd, int on)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+
+	mutex_lock(&isp_dev->power_lock);
+	if (on) {
+		if (isp_dev->power_count == 0)
+			st_debug(ST_ISP, "turn on isp\n");
+		isp_dev->power_count++;
+	} else {
+		if (isp_dev->power_count == 0)
+			goto exit;
+		isp_dev->power_count--;
+	}
+exit:
+	mutex_unlock(&isp_dev->power_lock);
+
+	return 0;
+}
+
+static struct v4l2_mbus_framefmt *
+__isp_get_format(struct stf_isp_dev *isp_dev,
+		 struct v4l2_subdev_state *state,
+		 unsigned int pad,
+		 enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&isp_dev->subdev, state, pad);
+
+	return &isp_dev->fmt[pad];
+}
+
+static int isp_get_interface_type(struct media_entity *entity)
+{
+	struct v4l2_subdev *subdev;
+	struct media_pad *pad = &entity->pads[0];
+
+	if (!(pad->flags & MEDIA_PAD_FL_SINK))
+		return -EINVAL;
+
+	pad = media_pad_remote_pad_first(pad);
+	if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+		return -EINVAL;
+
+	subdev = media_entity_to_v4l2_subdev(pad->entity);
+
+	st_debug(ST_ISP, "interface subdev name %s\n", subdev->name);
+	if (!strncmp(subdev->name, STF_CSI_NAME, strlen(STF_CSI_NAME)))
+		return INTERFACE_CSI;
+
+	return -EINVAL;
+}
+
+static int isp_set_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	int ret = 0, interface_type;
+	struct v4l2_mbus_framefmt *fmt;
+	struct v4l2_event src_ch = { 0 };
+
+	fmt = __isp_get_format(isp_dev, NULL, STF_ISP_PAD_SINK,
+			       V4L2_SUBDEV_FORMAT_ACTIVE);
+	mutex_lock(&isp_dev->stream_lock);
+	if (enable) {
+		if (isp_dev->stream_count == 0) {
+			isp_dev->hw_ops->isp_clk_enable(isp_dev);
+			if (!user_config_isp)
+				isp_dev->hw_ops->isp_config_set(isp_dev);
+			interface_type = isp_get_interface_type(&sd->entity);
+			if (interface_type < 0) {
+				st_err(ST_ISP,
+				       "%s, pipeline not config\n", __func__);
+				goto exit;
+			}
+			isp_dev->hw_ops->isp_set_format(isp_dev,
+							isp_dev->rect,
+							fmt->code,
+							interface_type);
+			isp_dev->hw_ops->isp_reset(isp_dev);
+			isp_dev->hw_ops->isp_stream_set(isp_dev, enable);
+			user_config_isp = 0;
+		}
+		isp_dev->stream_count++;
+	} else {
+		if (isp_dev->stream_count == 0)
+			goto exit;
+		if (isp_dev->stream_count == 1) {
+			isp_dev->hw_ops->isp_stream_set(isp_dev, enable);
+			isp_dev->hw_ops->isp_clk_disable(isp_dev);
+		}
+		isp_dev->stream_count--;
+	}
+	src_ch.type = V4L2_EVENT_SOURCE_CHANGE,
+	src_ch.u.src_change.changes = isp_dev->stream_count,
+
+	v4l2_subdev_notify_event(sd, &src_ch);
+exit:
+	mutex_unlock(&isp_dev->stream_lock);
+
+	return ret;
+}
+
+static int isp_sensor_fmt_to_index(struct stf_isp_dev *isp_dev)
+{
+	int ret, idx;
+	struct media_entity *sensor;
+	struct v4l2_subdev *subdev;
+	struct v4l2_subdev_format fmt;
+	const struct isp_format_table *formats;
+
+	if (!isp_dev)
+		return -EINVAL;
+
+	sensor = stfcamss_find_sensor(&isp_dev->subdev.entity);
+	if (!sensor)
+		return -EINVAL;
+
+	subdev = media_entity_to_v4l2_subdev(sensor);
+	st_debug(ST_ISP, "Found sensor = %s\n", sensor->name);
+
+	fmt.pad = 0;
+	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+	ret = v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);
+	if (ret) {
+		st_warn(ST_ISP, "Sonser get format failed !!\n");
+		return -EINVAL;
+	}
+
+	st_debug(ST_ISP, "Got sensor format 0x%x !!\n", fmt.format.code);
+
+	formats = &isp_dev->formats[SINK_FORMATS_INDEX];
+	for (idx = 0; idx < formats->nfmts; idx++) {
+		if (formats->fmts[idx].code == fmt.format.code) {
+			st_info(ST_ISP, "Match sensor format to index %d\n",
+				idx);
+			return idx;
+		}
+	}
+	return -ERANGE;
+}
+
+static int isp_fmt_to_index(const struct isp_format_table *f_table,
+			    __u32 mbus_code, unsigned int pad)
+{
+	int i;
+
+	for (i = 0; i < f_table->nfmts; i++) {
+		if (mbus_code == f_table->fmts[i].code)
+			break;
+
+		if (pad == STF_ISP_PAD_SRC_RAW) {
+			if (mbus_code == isp_formats_compat_raw10[i].code ||
+			    mbus_code == isp_formats_compat_raw8[i].code)
+				break;
+		}
+	}
+
+	return i;
+}
+
+static void isp_try_format(struct stf_isp_dev *isp_dev,
+			   struct v4l2_subdev_state *state,
+			   unsigned int pad,
+			   struct v4l2_mbus_framefmt *fmt,
+			   enum v4l2_subdev_format_whence which)
+{
+	const struct isp_format_table *formats;
+	unsigned int i;
+	u32 code = fmt->code;
+	u32 bpp;
+
+	switch (pad) {
+	case STF_ISP_PAD_SINK:
+		/* Set format on sink pad */
+		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
+		fmt->width = clamp_t(u32,
+				     fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
+				     STFCAMSS_FRAME_MAX_WIDTH);
+		fmt->height = clamp_t(u32,
+				      fmt->height, STFCAMSS_FRAME_MIN_HEIGHT,
+				      STFCAMSS_FRAME_MAX_HEIGHT);
+		fmt->height &= ~0x1;
+		fmt->field = V4L2_FIELD_NONE;
+		fmt->colorspace = V4L2_COLORSPACE_SRGB;
+		fmt->flags = 0;
+		break;
+
+	case STF_ISP_PAD_SRC:
+	case STF_ISP_PAD_SRC_SS0:
+	case STF_ISP_PAD_SRC_SS1:
+		formats = &isp_dev->formats[UO_FORMATS_INDEX];
+		break;
+
+	case STF_ISP_PAD_SRC_RAW:
+		formats = &isp_dev->formats[RAW_FORMATS_INDEX];
+		break;
+	}
+
+	i = isp_fmt_to_index(formats, fmt->code, pad);
+	st_debug(ST_ISP, "%s pad=%d, code=%x format to index = %d\n",
+		 __func__, pad, code, i);
+
+	if (i >= formats->nfmts && pad == STF_ISP_PAD_SRC_RAW) {
+		int sensor_idx;
+
+		sensor_idx = isp_sensor_fmt_to_index(isp_dev);
+		if (sensor_idx)
+			i = sensor_idx;
+	}
+
+	if (pad != STF_ISP_PAD_SINK)
+		*fmt = *__isp_get_format(isp_dev, state,
+					 STF_ISP_PAD_SINK, which);
+
+	if (i >= formats->nfmts) {
+		fmt->code = formats->fmts[0].code;
+		bpp = formats->fmts[0].bpp;
+		st_info(ST_ISP, "Use default index 0 format = 0x%x\n",
+			fmt->code);
+	} else {
+		if (pad == STF_ISP_PAD_SRC_RAW) {
+			fmt->code = formats->fmts[i].code;
+			bpp = formats->fmts[i].bpp;
+			st_info(ST_ISP,
+				"use format from sink index %d = 0x%x\n",
+				i, fmt->code);
+		} else {
+			fmt->code = code;
+			bpp = formats->fmts[i].bpp;
+			st_info(ST_ISP, "Use input format = 0x%x\n", fmt->code);
+		}
+	}
+
+	switch (pad) {
+	case STF_ISP_PAD_SINK:
+		break;
+
+	case STF_ISP_PAD_SRC:
+		isp_dev->rect[ISP_COMPOSE].bpp = bpp;
+		break;
+
+	case STF_ISP_PAD_SRC_SS0:
+		isp_dev->rect[ISP_SCALE_SS0].bpp = bpp;
+		break;
+
+	case STF_ISP_PAD_SRC_SS1:
+		isp_dev->rect[ISP_SCALE_SS1].bpp = bpp;
+		break;
+
+	case STF_ISP_PAD_SRC_RAW:
+		isp_dev->rect[ISP_CROP].bpp = bpp;
+		break;
+	}
+}
+
+static int isp_enum_mbus_code(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *state,
+			      struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	const struct isp_format_table *formats;
+
+	if (code->index >= isp_dev->nformats)
+		return -EINVAL;
+	if (code->pad == STF_ISP_PAD_SINK) {
+		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
+		code->code = formats->fmts[code->index].code;
+	} else {
+		struct v4l2_mbus_framefmt *sink_fmt;
+
+		sink_fmt = __isp_get_format(isp_dev, state, STF_ISP_PAD_SINK,
+					    code->which);
+
+		code->code = sink_fmt->code;
+		if (!code->code)
+			return -EINVAL;
+	}
+	code->flags = 0;
+
+	return 0;
+}
+
+static int isp_enum_frame_size(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *state,
+			       struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt format;
+
+	if (fse->index != 0)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = 1;
+	format.height = 1;
+	isp_try_format(isp_dev, state, fse->pad, &format, fse->which);
+	fse->min_width = format.width;
+	fse->min_height = format.height;
+
+	if (format.code != fse->code)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = -1;
+	format.height = -1;
+	isp_try_format(isp_dev, state, fse->pad, &format, fse->which);
+	fse->max_width = format.width;
+	fse->max_height = format.height;
+
+	return 0;
+}
+
+static int isp_get_format(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __isp_get_format(isp_dev, state, fmt->pad, fmt->which);
+	if (!format)
+		return -EINVAL;
+
+	fmt->format = *format;
+
+	return 0;
+}
+
+static int isp_set_format(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+	struct v4l2_subdev_selection sel = { 0 };
+	struct v4l2_rect *rect = NULL;
+	int ret;
+
+	st_debug(ST_ISP, "%s pad=%d, code=%x, which=%d\n",
+		 __func__, fmt->reserved[0], fmt->format.code, fmt->which);
+	format = __isp_get_format(isp_dev, state, fmt->pad, fmt->which);
+	if (!format)
+		return -EINVAL;
+
+	mutex_lock(&isp_dev->stream_lock);
+	if (isp_dev->stream_count) {
+		fmt->format = *format;
+		if (fmt->reserved[0] != 0) {
+			sel.which = fmt->which;
+			sel.pad = fmt->reserved[0];
+
+			switch (fmt->reserved[0]) {
+			case STF_ISP_PAD_SRC:
+				rect = __isp_get_compose(isp_dev,
+							 state, fmt->which);
+				break;
+
+			case STF_ISP_PAD_SRC_SS0:
+			case STF_ISP_PAD_SRC_SS1:
+				rect = __isp_get_scale(isp_dev, state, &sel);
+				break;
+
+			case STF_ISP_PAD_SRC_RAW:
+				rect = __isp_get_crop(isp_dev,
+						      state, fmt->which);
+				break;
+
+			default:
+				break;
+			}
+			if (rect) {
+				fmt->format.width = rect->width;
+				fmt->format.height = rect->height;
+			}
+		}
+		mutex_unlock(&isp_dev->stream_lock);
+		goto out;
+	} else {
+		isp_try_format(isp_dev, state, fmt->pad,
+			       &fmt->format, fmt->which);
+		*format = fmt->format;
+	}
+	mutex_unlock(&isp_dev->stream_lock);
+
+	/* Propagate the format from sink to source */
+	if (fmt->pad == STF_ISP_PAD_SINK) {
+		/* Reset sink pad compose selection */
+		sel.which = fmt->which;
+		sel.pad = STF_ISP_PAD_SINK;
+		sel.target = V4L2_SEL_TGT_CROP;
+		sel.r.width = fmt->format.width;
+		sel.r.height = fmt->format.height;
+		ret = isp_set_selection(sd, state, &sel);
+		if (ret < 0)
+			return ret;
+	}
+
+out:
+	return 0;
+}
+
+static struct v4l2_rect *
+__isp_get_compose(struct stf_isp_dev *isp_dev,
+		  struct v4l2_subdev_state *state,
+		  enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_compose(&isp_dev->subdev, state,
+						   STF_ISP_PAD_SINK);
+
+	return &isp_dev->rect[ISP_COMPOSE].rect;
+}
+
+static struct v4l2_rect *
+__isp_get_crop(struct stf_isp_dev *isp_dev,
+	       struct v4l2_subdev_state *state,
+	       enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_crop(&isp_dev->subdev, state,
+						STF_ISP_PAD_SINK);
+
+	return &isp_dev->rect[ISP_CROP].rect;
+}
+
+static struct v4l2_rect *
+__isp_get_scale(struct stf_isp_dev *isp_dev,
+		struct v4l2_subdev_state *state,
+		struct v4l2_subdev_selection *sel)
+{
+	int pad;
+
+	if (sel->which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_compose(&isp_dev->subdev, state,
+						   STF_ISP_PAD_SINK);
+	if (sel->pad != STF_ISP_PAD_SRC_SS0 && sel->pad != STF_ISP_PAD_SRC_SS1)
+		return NULL;
+
+	pad = sel->pad == STF_ISP_PAD_SRC_SS0 ? ISP_SCALE_SS0 : ISP_SCALE_SS1;
+	return &isp_dev->rect[pad].rect;
+}
+
+static void isp_try_crop(struct stf_isp_dev *isp_dev,
+			 struct v4l2_subdev_state *state,
+			 struct v4l2_rect *rect,
+			 enum v4l2_subdev_format_whence which)
+{
+	struct v4l2_mbus_framefmt *fmt;
+
+	fmt = __isp_get_format(isp_dev, state, STF_ISP_PAD_SINK, which);
+
+	if (rect->width > fmt->width)
+		rect->width = fmt->width;
+
+	if (rect->width + rect->left > fmt->width)
+		rect->left = fmt->width - rect->width;
+
+	if (rect->height > fmt->height)
+		rect->height = fmt->height;
+
+	if (rect->height + rect->top > fmt->height)
+		rect->top = fmt->height - rect->height;
+
+	if (rect->width < STFCAMSS_FRAME_MIN_WIDTH) {
+		rect->left = 0;
+		rect->width = STFCAMSS_FRAME_MIN_WIDTH;
+	}
+
+	if (rect->height < STFCAMSS_FRAME_MIN_HEIGHT) {
+		rect->top = 0;
+		rect->height = STFCAMSS_FRAME_MIN_HEIGHT;
+	}
+	rect->height &= ~0x1;
+}
+
+static void isp_try_compose(struct stf_isp_dev *isp_dev,
+			    struct v4l2_subdev_state *state,
+			    struct v4l2_rect *rect,
+			    enum v4l2_subdev_format_whence which)
+{
+	struct v4l2_rect *crop;
+
+	crop = __isp_get_crop(isp_dev, state, which);
+
+	if (rect->width > crop->width)
+		rect->width = crop->width;
+
+	if (rect->height > crop->height)
+		rect->height = crop->height;
+
+	if (crop->width > rect->width * SCALER_RATIO_MAX)
+		rect->width =
+			(crop->width + SCALER_RATIO_MAX - 1) / SCALER_RATIO_MAX;
+
+	if (crop->height > rect->height * SCALER_RATIO_MAX)
+		rect->height =
+			(crop->height + SCALER_RATIO_MAX - 1) / SCALER_RATIO_MAX;
+
+	if (rect->width < STFCAMSS_FRAME_MIN_WIDTH)
+		rect->width = STFCAMSS_FRAME_MIN_WIDTH;
+
+	if (rect->height < STFCAMSS_FRAME_MIN_HEIGHT)
+		rect->height = STFCAMSS_FRAME_MIN_HEIGHT;
+	rect->height &= ~0x1;
+}
+
+static void isp_try_scale(struct stf_isp_dev *isp_dev,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_rect *rect,
+			  enum v4l2_subdev_format_whence which)
+{
+	struct v4l2_rect *compose;
+
+	compose = __isp_get_compose(isp_dev, state, which);
+
+	if (rect->width > compose->width)
+		rect->width = compose->width;
+
+	if (rect->width + rect->left > compose->width)
+		rect->left = compose->width - rect->width;
+
+	if (rect->height > compose->height)
+		rect->height = compose->height;
+
+	if (rect->height + rect->top > compose->height)
+		rect->top = compose->height - rect->height;
+
+	if (rect->width < STFCAMSS_FRAME_MIN_WIDTH) {
+		rect->left = 0;
+		rect->width = STFCAMSS_FRAME_MIN_WIDTH;
+	}
+
+	if (rect->height < STFCAMSS_FRAME_MIN_HEIGHT) {
+		rect->top = 0;
+		rect->height = STFCAMSS_FRAME_MIN_HEIGHT;
+	}
+
+	rect->height &= ~0x1;
+}
+
+static int isp_get_selection(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_state *state,
+			     struct v4l2_subdev_selection *sel)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_subdev_format fmt = { 0 };
+	struct v4l2_rect *rect;
+	int ret;
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+		fmt.pad = sel->pad;
+		fmt.which = sel->which;
+		ret = isp_get_format(sd, state, &fmt);
+		if (ret < 0)
+			return ret;
+
+		sel->r.left = 0;
+		sel->r.top = 0;
+		sel->r.width = fmt.format.width;
+		sel->r.height = fmt.format.height;
+		break;
+
+	case V4L2_SEL_TGT_CROP:
+		rect = __isp_get_crop(isp_dev, state, sel->which);
+		if (!rect)
+			return -EINVAL;
+
+		sel->r = *rect;
+		break;
+
+	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+		if (sel->pad > STF_ISP_PAD_SRC_SS1)
+			return -EINVAL;
+		rect = __isp_get_crop(isp_dev, state, sel->which);
+		if (!rect)
+			return -EINVAL;
+
+		sel->r.left = rect->left;
+		sel->r.top = rect->top;
+		sel->r.width = rect->width;
+		sel->r.height = rect->height;
+		break;
+
+	case V4L2_SEL_TGT_COMPOSE:
+		if (sel->pad > STF_ISP_PAD_SRC_SS1)
+			return -EINVAL;
+		if (sel->pad == STF_ISP_PAD_SRC_SS0 ||
+		    sel->pad == STF_ISP_PAD_SRC_SS1) {
+			rect = __isp_get_scale(isp_dev, state, sel);
+			if (!rect)
+				return -EINVAL;
+		} else {
+			rect = __isp_get_compose(isp_dev, state, sel->which);
+			if (!rect)
+				return -EINVAL;
+		}
+		sel->r = *rect;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	st_info(ST_ISP, "%s pad = %d, left = %d, %d, %d, %d\n",
+		__func__, sel->pad, sel->r.left,
+		sel->r.top, sel->r.width, sel->r.height);
+	return 0;
+}
+
+static int isp_set_selection(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_state *state,
+			     struct v4l2_subdev_selection *sel)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_rect *rect;
+	int ret = 0;
+
+	if (sel->target == V4L2_SEL_TGT_COMPOSE &&
+	    (sel->pad == STF_ISP_PAD_SINK || sel->pad == STF_ISP_PAD_SRC)) {
+		struct v4l2_subdev_format fmt = { 0 };
+		int i;
+
+		rect = __isp_get_compose(isp_dev, state, sel->which);
+		if (!rect)
+			return -EINVAL;
+
+		mutex_lock(&isp_dev->stream_lock);
+		if (isp_dev->stream_count) {
+			sel->r = *rect;
+			mutex_unlock(&isp_dev->stream_lock);
+			ret = 0;
+			goto out;
+		} else {
+			isp_try_compose(isp_dev, state, &sel->r, sel->which);
+			*rect = sel->r;
+		}
+		mutex_unlock(&isp_dev->stream_lock);
+
+		/* Reset source pad format width and height */
+		fmt.which = sel->which;
+		fmt.pad = STF_ISP_PAD_SRC;
+		ret = isp_get_format(sd, state, &fmt);
+		if (ret < 0)
+			return ret;
+
+		fmt.format.width = rect->width;
+		fmt.format.height = rect->height;
+		ret = isp_set_format(sd, state, &fmt);
+
+		/* Reset scale */
+		for (i = STF_ISP_PAD_SRC_SS0; i <= STF_ISP_PAD_SRC_SS1; i++) {
+			struct v4l2_subdev_selection scale = { 0 };
+
+			scale.which = sel->which;
+			scale.target = V4L2_SEL_TGT_COMPOSE;
+			scale.r = *rect;
+			scale.pad = i;
+			ret = isp_set_selection(sd, state, &scale);
+		}
+	} else if (sel->target == V4L2_SEL_TGT_COMPOSE &&
+		   ((sel->pad == STF_ISP_PAD_SRC_SS0) ||
+		   (sel->pad == STF_ISP_PAD_SRC_SS1))) {
+		struct v4l2_subdev_format fmt = { 0 };
+
+		rect = __isp_get_scale(isp_dev, state, sel);
+		if (!rect)
+			return -EINVAL;
+
+		mutex_lock(&isp_dev->stream_lock);
+		if (isp_dev->stream_count) {
+			sel->r = *rect;
+			mutex_unlock(&isp_dev->stream_lock);
+			ret = 0;
+			goto out;
+		} else {
+			isp_try_scale(isp_dev, state, &sel->r, sel->which);
+			*rect = sel->r;
+		}
+		mutex_unlock(&isp_dev->stream_lock);
+
+		/* Reset source pad format width and height */
+		fmt.which = sel->which;
+		fmt.pad = sel->pad;
+		ret = isp_get_format(sd, state, &fmt);
+		if (ret < 0)
+			return ret;
+
+		fmt.format.width = rect->width;
+		fmt.format.height = rect->height;
+		ret = isp_set_format(sd, state, &fmt);
+	} else if (sel->target == V4L2_SEL_TGT_CROP) {
+		struct v4l2_subdev_selection compose = { 0 };
+		int i;
+
+		rect = __isp_get_crop(isp_dev, state, sel->which);
+		if (!rect)
+			return -EINVAL;
+
+		mutex_lock(&isp_dev->stream_lock);
+		if (isp_dev->stream_count) {
+			sel->r = *rect;
+			mutex_unlock(&isp_dev->stream_lock);
+			ret = 0;
+			goto out;
+		} else {
+			isp_try_crop(isp_dev, state, &sel->r, sel->which);
+			*rect = sel->r;
+		}
+		mutex_unlock(&isp_dev->stream_lock);
+
+		/* Reset source compose selection */
+		compose.which = sel->which;
+		compose.target = V4L2_SEL_TGT_COMPOSE;
+		compose.r.width = rect->width;
+		compose.r.height = rect->height;
+		compose.pad = STF_ISP_PAD_SINK;
+		ret = isp_set_selection(sd, state, &compose);
+
+		/* Reset source pad format width and height */
+		for (i = STF_ISP_PAD_SRC_RAW; i < STF_ISP_PAD_MAX; i++) {
+			struct v4l2_subdev_format fmt = { 0 };
+
+			fmt.which = sel->which;
+			fmt.pad = i;
+			ret = isp_get_format(sd, state, &fmt);
+			if (ret < 0)
+				return ret;
+
+			fmt.format.width = rect->width;
+			fmt.format.height = rect->height;
+			ret = isp_set_format(sd, state, &fmt);
+		}
+	} else {
+		ret = -EINVAL;
+	}
+
+	st_info(ST_ISP, "%s pad = %d, left = %d, %d, %d, %d\n",
+		__func__, sel->pad, sel->r.left,
+		sel->r.top, sel->r.width, sel->r.height);
+out:
+	return ret;
+}
+
+static int isp_init_formats(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_fh *fh)
+{
+	struct v4l2_subdev_format format = {
+		.pad = STF_ISP_PAD_SINK,
+		.which =
+			fh ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_RGB565_2X8_LE,
+			.width = 1920,
+			.height = 1080
+		}
+	};
+
+	return isp_set_format(sd, fh ? fh->state : NULL, &format);
+}
+
+static int isp_link_setup(struct media_entity *entity,
+			  const struct media_pad *local,
+			  const struct media_pad *remote, u32 flags)
+{
+	if (flags & MEDIA_LNK_FL_ENABLED)
+		if (media_pad_remote_pad_first(local))
+			return -EBUSY;
+	return 0;
+}
+
+static int stf_isp_load_setfile(struct stf_isp_dev *isp_dev, char *file_name)
+{
+	struct device *dev = isp_dev->stfcamss->dev;
+	const struct firmware *fw;
+	u8 *buf = NULL;
+	int *regval_num;
+	int ret;
+
+	st_debug(ST_ISP, "%s, file_name %s\n", __func__, file_name);
+	ret = request_firmware(&fw, file_name, dev);
+	if (ret < 0) {
+		st_err(ST_ISP, "firmware request failed (%d)\n", ret);
+		return ret;
+	}
+	buf = devm_kzalloc(dev, fw->size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	memcpy(buf, fw->data, fw->size);
+
+	mutex_lock(&isp_dev->setfile_lock);
+	if (isp_dev->setfile.state == 1)
+		devm_kfree(dev, isp_dev->setfile.data);
+	isp_dev->setfile.data = buf;
+	isp_dev->setfile.size = fw->size;
+	isp_dev->setfile.state = 1;
+	regval_num = (int *)&buf[fw->size - sizeof(unsigned int)];
+	isp_dev->setfile.settings.regval_num = *regval_num;
+	isp_dev->setfile.settings.regval = (struct regval_t *)buf;
+	mutex_unlock(&isp_dev->setfile_lock);
+
+	st_debug(ST_ISP, "stf_isp setfile loaded size: %zu B, reg_nul: %d\n",
+		 fw->size, isp_dev->setfile.settings.regval_num);
+
+	release_firmware(fw);
+	return ret;
+}
+
+static long stf_isp_ioctl(struct v4l2_subdev *sd, unsigned int cmd, void *arg)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct stfisp_fw_info *fw_info = arg;
+	int ret = -ENOIOCTLCMD;
+
+	switch (cmd) {
+	case VIDIOC_STFISP_LOAD_FW:
+		if (IS_ERR(fw_info)) {
+			st_err(ST_ISP, "fw_info failed, params invalid\n");
+			return -EINVAL;
+		}
+
+		ret = stf_isp_load_setfile(isp_dev, fw_info->filename);
+		break;
+
+	case VIDIOC_STFISP_GET_REG:
+		ret = isp_dev->hw_ops->isp_reg_read(isp_dev, arg);
+		break;
+
+	case VIDIOC_STFISP_SET_REG:
+		ret = isp_dev->hw_ops->isp_reg_write(isp_dev, arg);
+		break;
+
+	case VIDIOC_STFISP_SHADOW_LOCK:
+		if (atomic_add_unless(&isp_dev->shadow_count, 1, 1))
+			ret = 0;
+		else
+			ret = -EBUSY;
+		break;
+
+	case VIDIOC_STFISP_SHADOW_UNLOCK:
+		if (atomic_dec_if_positive(&isp_dev->shadow_count) < 0)
+			ret = -EINVAL;
+		else
+			ret = 0;
+		break;
+
+	case VIDIOC_STFISP_SHADOW_UNLOCK_N_TRIGGER:
+		isp_dev->hw_ops->isp_shadow_trigger(isp_dev);
+		if (atomic_dec_if_positive(&isp_dev->shadow_count) < 0)
+			ret = -EINVAL;
+		else
+			ret = 0;
+		break;
+
+	case VIDIOC_STFISP_SET_USER_CONFIG_ISP:
+		st_debug(ST_ISP, "Set user config isp\n");
+		user_config_isp = 1;
+		break;
+
+	default:
+		break;
+	}
+	return ret;
+}
+
+int isp_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+
+	while (atomic_dec_if_positive(&isp_dev->shadow_count) > 0)
+		st_warn(ST_ISP, "unlock the shadow lock!\n");
+
+	return 0;
+}
+
+static int stf_isp_subscribe_event(struct v4l2_subdev *sd,
+				   struct v4l2_fh *fh,
+				   struct v4l2_event_subscription *sub)
+{
+	switch (sub->type) {
+	case V4L2_EVENT_SOURCE_CHANGE:
+		return v4l2_src_change_event_subdev_subscribe(sd, fh, sub);
+	default:
+		st_debug(ST_ISP, "unspport subscribe_event\n");
+		return -EINVAL;
+	}
+}
+
+static const struct v4l2_subdev_core_ops isp_core_ops = {
+	.s_power = isp_set_power,
+	.ioctl = stf_isp_ioctl,
+	.subscribe_event = stf_isp_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
+static const struct v4l2_subdev_video_ops isp_video_ops = {
+	.s_stream = isp_set_stream,
+};
+
+static const struct v4l2_subdev_pad_ops isp_pad_ops = {
+	.enum_mbus_code = isp_enum_mbus_code,
+	.enum_frame_size = isp_enum_frame_size,
+	.get_fmt = isp_get_format,
+	.set_fmt = isp_set_format,
+	.get_selection = isp_get_selection,
+	.set_selection = isp_set_selection,
+};
+
+static const struct v4l2_subdev_ops isp_v4l2_ops = {
+	.core = &isp_core_ops,
+	.video = &isp_video_ops,
+	.pad = &isp_pad_ops,
+};
+
+static const struct v4l2_subdev_internal_ops isp_v4l2_internal_ops = {
+	.open = isp_init_formats,
+	.close = isp_close,
+};
+
+static const struct media_entity_operations isp_media_ops = {
+	.link_setup = isp_link_setup,
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
+{
+	struct v4l2_subdev *sd = &isp_dev->subdev;
+	struct media_pad *pads = isp_dev->pads;
+	int ret;
+
+	v4l2_subdev_init(sd, &isp_v4l2_ops);
+	sd->internal_ops = &isp_v4l2_internal_ops;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
+	snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d", STF_ISP_NAME, 0);
+	v4l2_set_subdevdata(sd, isp_dev);
+
+	ret = isp_init_formats(sd, NULL);
+	if (ret < 0) {
+		st_err(ST_ISP, "Failed to init format: %d\n", ret);
+		return ret;
+	}
+
+	pads[STF_ISP_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	pads[STF_ISP_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+	pads[STF_ISP_PAD_SRC_SS0].flags = MEDIA_PAD_FL_SOURCE;
+	pads[STF_ISP_PAD_SRC_SS1].flags = MEDIA_PAD_FL_SOURCE;
+	pads[STF_ISP_PAD_SRC_RAW].flags = MEDIA_PAD_FL_SOURCE;
+
+	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
+	sd->entity.ops = &isp_media_ops;
+	ret = media_entity_pads_init(&sd->entity, STF_ISP_PAD_MAX, pads);
+	if (ret < 0) {
+		st_err(ST_ISP, "Failed to init media entity: %d\n", ret);
+		return ret;
+	}
+
+	ret = v4l2_device_register_subdev(v4l2_dev, sd);
+	if (ret < 0) {
+		st_err(ST_ISP, "Failed to register subdev: %d\n", ret);
+		goto err_sreg;
+	}
+
+	return 0;
+
+err_sreg:
+	media_entity_cleanup(&sd->entity);
+	return ret;
+}
+
+int stf_isp_unregister(struct stf_isp_dev *isp_dev)
+{
+	v4l2_device_unregister_subdev(&isp_dev->subdev);
+	media_entity_cleanup(&isp_dev->subdev.entity);
+	mutex_destroy(&isp_dev->stream_lock);
+	mutex_destroy(&isp_dev->power_lock);
+	mutex_destroy(&isp_dev->setfile_lock);
+	return 0;
+}
diff --git a/drivers/media/platform/starfive/stf_isp.h b/drivers/media/platform/starfive/stf_isp.h
new file mode 100644
index 000000000000..ca80b8d1f1cc
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_isp.h
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * stf_isp.h
+ *
+ * StarFive Camera Subsystem - ISP Module
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_ISP_H
+#define STF_ISP_H
+
+#include <media/media-entity.h>
+#include <media/v4l2-subdev.h>
+
+#define STF_ISP_SETFILE     "stf_isp0_fw.bin"
+
+#define ISP_RAW_DATA_BITS       12
+#define SCALER_RATIO_MAX        1
+#define STF_ISP_REG_OFFSET_MAX  0x0FFF
+#define STF_ISP_REG_DELAY_MAX   100
+
+/* isp registers */
+#define ISP_REG_CSI_INPUT_EN_AND_STATUS   0x00000000
+#define ISP_REG_CSIINTS_ADDR              0x00000008
+#define ISP_REG_CSI_MODULE_CFG            0x00000010
+#define ISP_REG_SENSOR                    0x00000014
+#define ISP_REG_RAW_FORMAT_CFG            0x00000018
+#define ISP_REG_PIC_CAPTURE_START_CFG     0x0000001C
+#define ISP_REG_PIC_CAPTURE_END_CFG       0x00000020
+#define ISP_REG_DUMP_CFG_0                0x00000024
+#define ISP_REG_DUMP_CFG_1                0x00000028
+#define ISP_REG_SCD_CFG_0                 0x00000098
+#define ISP_REG_SCD_CFG_1                 0x0000009C
+#define ISP_REG_SC_CFG_1                  0x000000BC
+#define ISP_REG_ISP_CTRL_0                0x00000A00
+#define ISP_REG_ISP_CTRL_1                0x00000A08
+#define ISP_REG_PIPELINE_XY_SIZE          0x00000A0C
+#define ISP_REG_IESHD_ADDR                0x00000A50
+#define ISP_REG_Y_PLANE_START_ADDR        0x00000A80
+#define ISP_REG_UV_PLANE_START_ADDR       0x00000A84
+#define ISP_REG_STRIDE                    0x00000A88
+#define ISP_REG_PIXEL_COORDINATE_GEN      0x00000A8C
+#define ISP_REG_SS0AY                     0x00000A94
+#define ISP_REG_SS0AUV                    0x00000A98
+#define ISP_REG_SS0S                      0x00000A9C
+#define ISP_REG_SS0IW                     0x00000AA8
+#define ISP_REG_SS1AY                     0x00000AAC
+#define ISP_REG_SS1AUV                    0x00000AB0
+#define ISP_REG_SS1S                      0x00000AB4
+#define ISP_REG_SS1IW                     0x00000AC0
+#define ISP_REG_YHIST_CFG_4               0x00000CD8
+#define ISP_REG_ITIIWSR                   0x00000B20
+#define ISP_REG_ITIDWLSR                  0x00000B24
+#define ISP_REG_ITIDWYSAR                 0x00000B28
+#define ISP_REG_ITIDWUSAR                 0x00000B2C
+#define ISP_REG_ITIDRYSAR                 0x00000B30
+#define ISP_REG_ITIDRUSAR                 0x00000B34
+#define ISP_REG_ITIPDFR                   0x00000B38
+#define ISP_REG_ITIDRLSR                  0x00000B3C
+#define ISP_REG_ITIBSR                    0x00000B40
+#define ISP_REG_ITIAIR                    0x00000B44
+#define ISP_REG_ITIDPSR                   0x00000B48
+
+/* The output line of ISP */
+enum isp_line_id {
+	STF_ISP_LINE_INVALID = -1,
+	STF_ISP_LINE_SRC = 1,
+	STF_ISP_LINE_SRC_SS0,
+	STF_ISP_LINE_SRC_SS1,
+	STF_ISP_LINE_SRC_RAW,
+	STF_ISP_LINE_MAX = STF_ISP_LINE_SRC_RAW
+};
+
+/* pad id for media framework */
+enum isp_pad_id {
+	STF_ISP_PAD_SINK = 0,
+	STF_ISP_PAD_SRC,
+	STF_ISP_PAD_SRC_SS0,
+	STF_ISP_PAD_SRC_SS1,
+	STF_ISP_PAD_SRC_RAW,
+	STF_ISP_PAD_MAX
+};
+
+enum {
+	EN_INT_NONE                 = 0,
+	EN_INT_ISP_DONE             = (0x1 << 24),
+	EN_INT_CSI_DONE             = (0x1 << 25),
+	EN_INT_SC_DONE              = (0x1 << 26),
+	EN_INT_LINE_INT             = (0x1 << 27),
+	EN_INT_ALL                  = (0xF << 24),
+};
+
+enum {
+	INTERFACE_DVP = 0,
+	INTERFACE_CSI,
+};
+
+struct isp_format {
+	u32 code;
+	u8 bpp;
+};
+
+struct isp_format_table {
+	const struct isp_format *fmts;
+	int nfmts;
+};
+
+struct regval_t {
+	u32 addr;
+	u32 val;
+	u32 mask;
+	u32 delay_ms;
+};
+
+struct reg_table {
+	const struct regval_t *regval;
+	int regval_num;
+};
+
+struct isp_stream_format {
+	struct v4l2_rect rect;
+	u32 bpp;
+};
+
+struct isp_setfile {
+	struct reg_table settings;
+	const u8 *data;
+	unsigned int size;
+	unsigned int state;
+};
+
+enum {
+	ISP_CROP = 0,
+	ISP_COMPOSE,
+	ISP_SCALE_SS0,
+	ISP_SCALE_SS1,
+	ISP_RECT_MAX
+};
+
+struct stf_isp_dev {
+	enum subdev_type sdev_type;  /* This member must be first */
+	struct stfcamss *stfcamss;
+	struct v4l2_subdev subdev;
+	struct media_pad pads[STF_ISP_PAD_MAX];
+	struct v4l2_mbus_framefmt fmt[STF_ISP_PAD_MAX];
+	struct isp_stream_format rect[ISP_RECT_MAX];
+	const struct isp_format_table *formats;
+	unsigned int nformats;
+	const struct isp_hw_ops *hw_ops;
+	struct mutex power_lock;	/* serialize power control*/
+	int power_count;
+	struct mutex stream_lock;	/* serialize stream control */
+	int stream_count;
+	atomic_t shadow_count;
+
+	struct mutex setfile_lock;	/* protects setting files */
+	struct isp_setfile setfile;
+
+	union reg_buf *reg_buf;
+};
+
+struct isp_hw_ops {
+	int (*isp_clk_enable)(struct stf_isp_dev *isp_dev);
+	int (*isp_clk_disable)(struct stf_isp_dev *isp_dev);
+	int (*isp_reset)(struct stf_isp_dev *isp_dev);
+	int (*isp_config_set)(struct stf_isp_dev *isp_dev);
+	int (*isp_set_format)(struct stf_isp_dev *isp_dev,
+			      struct isp_stream_format *crop,
+			      u32 mcode, int type);
+	int (*isp_stream_set)(struct stf_isp_dev *isp_dev, int on);
+	int (*isp_reg_read)(struct stf_isp_dev *isp_dev, void *arg);
+	int (*isp_reg_write)(struct stf_isp_dev *isp_dev, void *arg);
+	int (*isp_shadow_trigger)(struct stf_isp_dev *isp_dev);
+};
+
+extern const struct isp_hw_ops isp_ops;
+
+int stf_isp_subdev_init(struct stfcamss *stfcamss);
+int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
+int stf_isp_unregister(struct stf_isp_dev *isp_dev);
+
+#endif /* STF_ISP_H */
diff --git a/drivers/media/platform/starfive/stf_isp_hw_ops.c b/drivers/media/platform/starfive/stf_isp_hw_ops.c
new file mode 100644
index 000000000000..b2aee00a78ad
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_isp_hw_ops.c
@@ -0,0 +1,1286 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_isp_hw_ops.c
+ *
+ * Register interface file for StarFive ISP driver
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ *
+ */
+#include <linux/delay.h>
+#include <linux/stf_isp_ioctl.h>
+
+#include "stf_camss.h"
+
+static const struct regval_t isp_reg_init_config_list[] = {
+	/* config DC */
+	{0x00000044, 0x00000000, 0, 0},
+	/* config DEC */
+	{0x00000030, 0x00000000, 0, 0},
+	/* config OBC */
+	{0x00000034, 0x000000BB, 0, 0},
+	{0x000002E0, 0x40404040, 0, 0},
+	{0x000002E4, 0x40404040, 0, 0},
+	{0x000002E8, 0x40404040, 0, 0},
+	{0x000002EC, 0x40404040, 0, 0},
+	{0x000002F0, 0x00000000, 0, 0},
+	{0x000002F4, 0x00000000, 0, 0},
+	{0x000002F8, 0x00000000, 0, 0},
+	{0x000002FC, 0x00000000, 0, 0},
+	/* config LCBQ */
+	{0x00000074, 0x00009900, 0, 0},
+	{0x0000007C, 0x01E40040, 0, 0},
+	{0x00000300, 0x01000100, 0, 0},
+	{0x00000304, 0x01000100, 0, 0},
+	{0x00000308, 0x01000100, 0, 0},
+	{0x0000030C, 0x01000100, 0, 0},
+	{0x00000310, 0x01000100, 0, 0},
+	{0x00000314, 0x01000100, 0, 0},
+	{0x00000318, 0x01000100, 0, 0},
+	{0x0000031C, 0x01000100, 0, 0},
+	{0x00000320, 0x01000100, 0, 0},
+	{0x00000324, 0x01000100, 0, 0},
+	{0x00000328, 0x01000100, 0, 0},
+	{0x0000032C, 0x01000100, 0, 0},
+	{0x00000330, 0x00000100, 0, 0},
+	{0x00000334, 0x01000100, 0, 0},
+	{0x00000338, 0x01000100, 0, 0},
+	{0x0000033C, 0x01000100, 0, 0},
+	{0x00000340, 0x01000100, 0, 0},
+	{0x00000344, 0x01000100, 0, 0},
+	{0x00000348, 0x01000100, 0, 0},
+	{0x0000034C, 0x01000100, 0, 0},
+	{0x00000350, 0x01000100, 0, 0},
+	{0x00000354, 0x01000100, 0, 0},
+	{0x00000358, 0x01000100, 0, 0},
+	{0x0000035C, 0x01000100, 0, 0},
+	{0x00000360, 0x01000100, 0, 0},
+	{0x00000364, 0x00000100, 0, 0},
+	{0x00000368, 0x01000100, 0, 0},
+	{0x0000036C, 0x01000100, 0, 0},
+	{0x00000370, 0x01000100, 0, 0},
+	{0x00000374, 0x01000100, 0, 0},
+	{0x00000378, 0x01000100, 0, 0},
+	{0x0000037C, 0x01000100, 0, 0},
+	{0x00000380, 0x01000100, 0, 0},
+	{0x00000384, 0x01000100, 0, 0},
+	{0x00000388, 0x01000100, 0, 0},
+	{0x0000038C, 0x01000100, 0, 0},
+	{0x00000390, 0x01000100, 0, 0},
+	{0x00000394, 0x01000100, 0, 0},
+	{0x00000398, 0x00000100, 0, 0},
+	{0x0000039C, 0x01000100, 0, 0},
+	{0x000003A0, 0x01000100, 0, 0},
+	{0x000003A4, 0x01000100, 0, 0},
+	{0x000003A8, 0x01000100, 0, 0},
+	{0x000003AC, 0x01000100, 0, 0},
+	{0x000003B0, 0x01000100, 0, 0},
+	{0x000003B4, 0x01000100, 0, 0},
+	{0x000003B8, 0x01000100, 0, 0},
+	{0x000003BC, 0x01000100, 0, 0},
+	{0x000003C0, 0x01000100, 0, 0},
+	{0x000003C4, 0x01000100, 0, 0},
+	{0x000003C8, 0x01000100, 0, 0},
+	{0x000003CC, 0x00000100, 0, 0},
+	{0x00000400, 0x00000000, 0, 0},
+	{0x00000404, 0x00000000, 0, 0},
+	{0x00000408, 0x00000000, 0, 0},
+	{0x0000040C, 0x00000000, 0, 0},
+	{0x00000410, 0x00000000, 0, 0},
+	{0x00000414, 0x00000000, 0, 0},
+	{0x00000418, 0x00000000, 0, 0},
+	{0x0000041C, 0x00000000, 0, 0},
+	{0x00000420, 0x00000000, 0, 0},
+	{0x00000424, 0x00000000, 0, 0},
+	{0x00000428, 0x00000000, 0, 0},
+	{0x0000042C, 0x00000000, 0, 0},
+	{0x00000430, 0x00000000, 0, 0},
+	{0x00000434, 0x00000000, 0, 0},
+	{0x00000438, 0x00000000, 0, 0},
+	{0x0000043C, 0x00000000, 0, 0},
+	{0x00000440, 0x00000000, 0, 0},
+	{0x00000444, 0x00000000, 0, 0},
+	{0x00000448, 0x00000000, 0, 0},
+	{0x0000044C, 0x00000000, 0, 0},
+	{0x00000450, 0x00000000, 0, 0},
+	{0x00000454, 0x00000000, 0, 0},
+	{0x00000458, 0x00000000, 0, 0},
+	{0x0000045C, 0x00000000, 0, 0},
+	{0x00000460, 0x00000000, 0, 0},
+	{0x00000464, 0x00000000, 0, 0},
+	{0x00000468, 0x00000000, 0, 0},
+	{0x0000046C, 0x00000000, 0, 0},
+	{0x00000470, 0x00000000, 0, 0},
+	{0x00000474, 0x00000000, 0, 0},
+	{0x00000478, 0x00000000, 0, 0},
+	{0x0000047C, 0x00000000, 0, 0},
+	{0x00000480, 0x00000000, 0, 0},
+	{0x00000484, 0x00000000, 0, 0},
+	{0x00000488, 0x00000000, 0, 0},
+	{0x0000048C, 0x00000000, 0, 0},
+	{0x00000490, 0x00000000, 0, 0},
+	{0x00000494, 0x00000000, 0, 0},
+	{0x00000498, 0x00000000, 0, 0},
+	{0x0000049C, 0x00000000, 0, 0},
+	{0x000004A0, 0x00000000, 0, 0},
+	{0x000004A4, 0x00000000, 0, 0},
+	{0x000004A8, 0x00000000, 0, 0},
+	{0x000004AC, 0x00000000, 0, 0},
+	{0x000004B0, 0x00000000, 0, 0},
+	{0x000004B4, 0x00000000, 0, 0},
+	{0x000004B8, 0x00000000, 0, 0},
+	{0x000004BC, 0x00000000, 0, 0},
+	{0x000004C0, 0x00000000, 0, 0},
+	{0x000004C4, 0x00000000, 0, 0},
+	{0x000004C8, 0x00000000, 0, 0},
+	{0x000004CC, 0x00000000, 0, 0},
+	/* config OECF */
+	{0x00000100, 0x00100000, 0, 0},
+	{0x00000104, 0x00400020, 0, 0},
+	{0x00000108, 0x00800060, 0, 0},
+	{0x0000010C, 0x00C000A0, 0, 0},
+	{0x00000110, 0x010000E0, 0, 0},
+	{0x00000114, 0x02000180, 0, 0},
+	{0x00000118, 0x03000280, 0, 0},
+	{0x0000011C, 0x03FE0380, 0, 0},
+	{0x00000120, 0x00100000, 0, 0},
+	{0x00000124, 0x00400020, 0, 0},
+	{0x00000128, 0x00800060, 0, 0},
+	{0x0000012C, 0x00C000A0, 0, 0},
+	{0x00000130, 0x010000E0, 0, 0},
+	{0x00000134, 0x02000180, 0, 0},
+	{0x00000138, 0x03000280, 0, 0},
+	{0x0000013C, 0x03FE0380, 0, 0},
+	{0x00000140, 0x00100000, 0, 0},
+	{0x00000144, 0x00400020, 0, 0},
+	{0x00000148, 0x00800060, 0, 0},
+	{0x0000014C, 0x00C000A0, 0, 0},
+	{0x00000150, 0x010000E0, 0, 0},
+	{0x00000154, 0x02000180, 0, 0},
+	{0x00000158, 0x03000280, 0, 0},
+	{0x0000015C, 0x03FE0380, 0, 0},
+	{0x00000160, 0x00100000, 0, 0},
+	{0x00000164, 0x00400020, 0, 0},
+	{0x00000168, 0x00800060, 0, 0},
+	{0x0000016C, 0x00C000A0, 0, 0},
+	{0x00000170, 0x010000E0, 0, 0},
+	{0x00000174, 0x02000180, 0, 0},
+	{0x00000178, 0x03000280, 0, 0},
+	{0x0000017C, 0x03FE0380, 0, 0},
+	{0x00000180, 0x00100000, 0, 0},
+	{0x00000184, 0x00400020, 0, 0},
+	{0x00000188, 0x00800060, 0, 0},
+	{0x0000018C, 0x00C000A0, 0, 0},
+	{0x00000190, 0x010000E0, 0, 0},
+	{0x00000194, 0x02000180, 0, 0},
+	{0x00000198, 0x03000280, 0, 0},
+	{0x0000019C, 0x03FE0380, 0, 0},
+	{0x000001A0, 0x00100000, 0, 0},
+	{0x000001A4, 0x00400020, 0, 0},
+	{0x000001A8, 0x00800060, 0, 0},
+	{0x000001AC, 0x00C000A0, 0, 0},
+	{0x000001B0, 0x010000E0, 0, 0},
+	{0x000001B4, 0x02000180, 0, 0},
+	{0x000001B8, 0x03000280, 0, 0},
+	{0x000001BC, 0x03FE0380, 0, 0},
+	{0x000001C0, 0x00100000, 0, 0},
+	{0x000001C4, 0x00400020, 0, 0},
+	{0x000001C8, 0x00800060, 0, 0},
+	{0x000001CC, 0x00C000A0, 0, 0},
+	{0x000001D0, 0x010000E0, 0, 0},
+	{0x000001D4, 0x02000180, 0, 0},
+	{0x000001D8, 0x03000280, 0, 0},
+	{0x000001DC, 0x03FE0380, 0, 0},
+	{0x000001E0, 0x00100000, 0, 0},
+	{0x000001E4, 0x00400020, 0, 0},
+	{0x000001E8, 0x00800060, 0, 0},
+	{0x000001EC, 0x00C000A0, 0, 0},
+	{0x000001F0, 0x010000E0, 0, 0},
+	{0x000001F4, 0x02000180, 0, 0},
+	{0x000001F8, 0x03000280, 0, 0},
+	{0x000001FC, 0x03FE0380, 0, 0},
+	{0x00000200, 0x00800080, 0, 0},
+	{0x00000204, 0x00800080, 0, 0},
+	{0x00000208, 0x00800080, 0, 0},
+	{0x0000020C, 0x00800080, 0, 0},
+	{0x00000210, 0x00800080, 0, 0},
+	{0x00000214, 0x00800080, 0, 0},
+	{0x00000218, 0x00800080, 0, 0},
+	{0x0000021C, 0x00800080, 0, 0},
+	{0x00000220, 0x00800080, 0, 0},
+	{0x00000224, 0x00800080, 0, 0},
+	{0x00000228, 0x00800080, 0, 0},
+	{0x0000022C, 0x00800080, 0, 0},
+	{0x00000230, 0x00800080, 0, 0},
+	{0x00000234, 0x00800080, 0, 0},
+	{0x00000238, 0x00800080, 0, 0},
+	{0x0000023C, 0x00800080, 0, 0},
+	{0x00000240, 0x00800080, 0, 0},
+	{0x00000244, 0x00800080, 0, 0},
+	{0x00000248, 0x00800080, 0, 0},
+	{0x0000024C, 0x00800080, 0, 0},
+	{0x00000250, 0x00800080, 0, 0},
+	{0x00000254, 0x00800080, 0, 0},
+	{0x00000258, 0x00800080, 0, 0},
+	{0x0000025C, 0x00800080, 0, 0},
+	{0x00000260, 0x00800080, 0, 0},
+	{0x00000264, 0x00800080, 0, 0},
+	{0x00000268, 0x00800080, 0, 0},
+	{0x0000026C, 0x00800080, 0, 0},
+	{0x00000270, 0x00800080, 0, 0},
+	{0x00000274, 0x00800080, 0, 0},
+	{0x00000278, 0x00800080, 0, 0},
+	{0x0000027C, 0x00800080, 0, 0},
+	/* config OECFHM */
+	{0x000003D0, 0x04000000, 0, 0},
+	{0x000003D4, 0x0C000800, 0, 0},
+	{0x000003D8, 0x00000FFF, 0, 0},
+	{0x000003DC, 0x08000800, 0, 0},
+	{0x000003E0, 0x08000800, 0, 0},
+	{0x000003E4, 0x00000800, 0, 0},
+	/* config LCCF */
+	{0x00000050, 0x021C03C0, 0, 0},
+	{0x00000058, 0x0000000B, 0, 0},
+	{0x000000E0, 0x00000000, 0, 0},
+	{0x000000E4, 0x00000000, 0, 0},
+	{0x000000E8, 0x00000000, 0, 0},
+	{0x000000EC, 0x00000000, 0, 0},
+	/* config AWB */
+	{0x00000280, 0x00000000, 0, 0},
+	{0x00000284, 0x00000000, 0, 0},
+	{0x00000288, 0x00000000, 0, 0},
+	{0x0000028C, 0x00000000, 0, 0},
+	{0x00000290, 0x00000000, 0, 0},
+	{0x00000294, 0x00000000, 0, 0},
+	{0x00000298, 0x00000000, 0, 0},
+	{0x0000029C, 0x00000000, 0, 0},
+	{0x000002A0, 0x00000000, 0, 0},
+	{0x000002A4, 0x00000000, 0, 0},
+	{0x000002A8, 0x00000000, 0, 0},
+	{0x000002AC, 0x00000000, 0, 0},
+	{0x000002B0, 0x00000000, 0, 0},
+	{0x000002B4, 0x00000000, 0, 0},
+	{0x000002B8, 0x00000000, 0, 0},
+	{0x000002BC, 0x00000000, 0, 0},
+	{0x000002C0, 0x00800080, 0, 0},
+	{0x000002C4, 0x00800080, 0, 0},
+	{0x000002C8, 0x00800080, 0, 0},
+	{0x000002CC, 0x00800080, 0, 0},
+	{0x000002D0, 0x00800080, 0, 0},
+	{0x000002D4, 0x00800080, 0, 0},
+	{0x000002D8, 0x00800080, 0, 0},
+	{0x000002DC, 0x00800080, 0, 0},
+	/* config CTC and DBC filter */
+	{0x00000A10, 0x41400040, 0, 0},
+	{0x00000A14, 0x02000200, 0, 0},
+	/* config CFA */
+	{0x00000018, 0x000011BB, 0, 0},
+	{0x00000A1C, 0x00000032, 0, 0},
+	/* config CCM */
+	{0x00000C40, 0x00060000, 0, 0},
+	{0x00000C44, 0x00000000, 0, 0},
+	{0x00000C48, 0x00000000, 0, 0},
+	{0x00000C4C, 0x00000000, 0, 0},
+	{0x00000C50, 0x00000000, 0, 0},
+	{0x00000C54, 0x00000000, 0, 0},
+	{0x00000C58, 0x00000000, 0, 0},
+	{0x00000C5C, 0x00000000, 0, 0},
+	{0x00000C60, 0x00000000, 0, 0},
+	{0x00000C64, 0x00000000, 0, 0},
+	{0x00000C68, 0x00000000, 0, 0},
+	{0x00000C6C, 0x00000000, 0, 0},
+	{0x00000C70, 0x00000080, 0, 0},
+	{0x00000C74, 0x00000000, 0, 0},
+	{0x00000C78, 0x00000000, 0, 0},
+	{0x00000C7C, 0x00000000, 0, 0},
+	{0x00000C80, 0x00000080, 0, 0},
+	{0x00000C84, 0x00000000, 0, 0},
+	{0x00000C88, 0x00000000, 0, 0},
+	{0x00000C8C, 0x00000000, 0, 0},
+	{0x00000C90, 0x00000080, 0, 0},
+	{0x00000C94, 0x00000000, 0, 0},
+	{0x00000C98, 0x00000000, 0, 0},
+	{0x00000C9C, 0x00000000, 0, 0},
+	{0x00000CA0, 0x00000700, 0, 0},
+	{0x00000CA4, 0x00000200, 0, 0},
+	/* config GMARGB */
+	{0x00000E00, 0x24000000, 0, 0},
+	{0x00000E04, 0x08000020, 0, 0},
+	{0x00000E08, 0x08000040, 0, 0},
+	{0x00000E0C, 0x08000060, 0, 0},
+	{0x00000E10, 0x08000080, 0, 0},
+	{0x00000E14, 0x080000A0, 0, 0},
+	{0x00000E18, 0x080000C0, 0, 0},
+	{0x00000E1C, 0x080000E0, 0, 0},
+	{0x00000E20, 0x08000100, 0, 0},
+	{0x00000E24, 0x08000180, 0, 0},
+	{0x00000E28, 0x08000200, 0, 0},
+	{0x00000E2C, 0x08000280, 0, 0},
+	{0x00000E30, 0x08000300, 0, 0},
+	{0x00000E34, 0x08000380, 0, 0},
+	{0x00000E38, 0x080003FE, 0, 0},
+	/* config R2Y */
+	{0x00000E40, 0x0000004C, 0, 0},
+	{0x00000E44, 0x00000097, 0, 0},
+	{0x00000E48, 0x0000001D, 0, 0},
+	{0x00000E4C, 0x000001D5, 0, 0},
+	{0x00000E50, 0x000001AC, 0, 0},
+	{0x00000E54, 0x00000080, 0, 0},
+	{0x00000E58, 0x00000080, 0, 0},
+	{0x00000E5C, 0x00000194, 0, 0},
+	{0x00000E60, 0x000001EC, 0, 0},
+	/* config YCRV */
+	{0x00000F00, 0x00000000, 0, 0},
+	{0x00000F04, 0x00000010, 0, 0},
+	{0x00000F08, 0x00000020, 0, 0},
+	{0x00000F0C, 0x00000030, 0, 0},
+	{0x00000F10, 0x00000040, 0, 0},
+	{0x00000F14, 0x00000050, 0, 0},
+	{0x00000F18, 0x00000060, 0, 0},
+	{0x00000F1C, 0x00000070, 0, 0},
+	{0x00000F20, 0x00000080, 0, 0},
+	{0x00000F24, 0x00000090, 0, 0},
+	{0x00000F28, 0x000000A0, 0, 0},
+	{0x00000F2C, 0x000000B0, 0, 0},
+	{0x00000F30, 0x000000C0, 0, 0},
+	{0x00000F34, 0x000000D0, 0, 0},
+	{0x00000F38, 0x000000E0, 0, 0},
+	{0x00000F3C, 0x000000F0, 0, 0},
+	{0x00000F40, 0x00000100, 0, 0},
+	{0x00000F44, 0x00000110, 0, 0},
+	{0x00000F48, 0x00000120, 0, 0},
+	{0x00000F4C, 0x00000130, 0, 0},
+	{0x00000F50, 0x00000140, 0, 0},
+	{0x00000F54, 0x00000150, 0, 0},
+	{0x00000F58, 0x00000160, 0, 0},
+	{0x00000F5C, 0x00000170, 0, 0},
+	{0x00000F60, 0x00000180, 0, 0},
+	{0x00000F64, 0x00000190, 0, 0},
+	{0x00000F68, 0x000001A0, 0, 0},
+	{0x00000F6C, 0x000001B0, 0, 0},
+	{0x00000F70, 0x000001C0, 0, 0},
+	{0x00000F74, 0x000001D0, 0, 0},
+	{0x00000F78, 0x000001E0, 0, 0},
+	{0x00000F7C, 0x000001F0, 0, 0},
+	{0x00000F80, 0x00000200, 0, 0},
+	{0x00000F84, 0x00000210, 0, 0},
+	{0x00000F88, 0x00000220, 0, 0},
+	{0x00000F8C, 0x00000230, 0, 0},
+	{0x00000F90, 0x00000240, 0, 0},
+	{0x00000F94, 0x00000250, 0, 0},
+	{0x00000F98, 0x00000260, 0, 0},
+	{0x00000F9C, 0x00000270, 0, 0},
+	{0x00000FA0, 0x00000280, 0, 0},
+	{0x00000FA4, 0x00000290, 0, 0},
+	{0x00000FA8, 0x000002A0, 0, 0},
+	{0x00000FAC, 0x000002B0, 0, 0},
+	{0x00000FB0, 0x000002C0, 0, 0},
+	{0x00000FB4, 0x000002D0, 0, 0},
+	{0x00000FB8, 0x000002E0, 0, 0},
+	{0x00000FBC, 0x000002F0, 0, 0},
+	{0x00000FC0, 0x00000300, 0, 0},
+	{0x00000FC4, 0x00000310, 0, 0},
+	{0x00000FC8, 0x00000320, 0, 0},
+	{0x00000FCC, 0x00000330, 0, 0},
+	{0x00000FD0, 0x00000340, 0, 0},
+	{0x00000FD4, 0x00000350, 0, 0},
+	{0x00000FD8, 0x00000360, 0, 0},
+	{0x00000FDC, 0x00000370, 0, 0},
+	{0x00000FE0, 0x00000380, 0, 0},
+	{0x00000FE4, 0x00000390, 0, 0},
+	{0x00000FE8, 0x000003A0, 0, 0},
+	{0x00000FEC, 0x000003B0, 0, 0},
+	{0x00000FF0, 0x000003C0, 0, 0},
+	{0x00000FF4, 0x000003D0, 0, 0},
+	{0x00000FF8, 0x000003E0, 0, 0},
+	{0x00000FFC, 0x000003F0, 0, 0},
+	/* config Sharp */
+	{0x00000E80, 0x00070F00, 0, 0},
+	{0x00000E84, 0x00180F00, 0, 0},
+	{0x00000E88, 0x00800F00, 0, 0},
+	{0x00000E8C, 0x01000F00, 0, 0},
+	{0x00000E90, 0x00100F00, 0, 0},
+	{0x00000E94, 0x00600F00, 0, 0},
+	{0x00000E98, 0x01000F00, 0, 0},
+	{0x00000E9C, 0x01900F00, 0, 0},
+	{0x00000EA0, 0x00000F00, 0, 0},
+	{0x00000EA4, 0x00000F00, 0, 0},
+	{0x00000EA8, 0x00000F00, 0, 0},
+	{0x00000EAC, 0x00000F00, 0, 0},
+	{0x00000EB0, 0x00000F00, 0, 0},
+	{0x00000EB4, 0x00000F00, 0, 0},
+	{0x00000EB8, 0x00000F00, 0, 0},
+	{0x00000EBC, 0x10000000, 0, 0},
+	{0x00000EC0, 0x10000000, 0, 0},
+	{0x00000EC4, 0x10000000, 0, 0},
+	{0x00000EC8, 0x10000000, 0, 0},
+	{0x00000ECC, 0x10000000, 0, 0},
+	{0x00000ED0, 0x10000000, 0, 0},
+	{0x00000ED4, 0x88000D7C, 0, 0},
+	{0x00000ED8, 0x00C00040, 0, 0},
+	{0x00000EDC, 0xFF000000, 0, 0},
+	{0x00000EE0, 0x00A00040, 0, 0},
+	{0x00000EE4, 0x00000000, 0, 0},
+	{0x00000EE8, 0x00000000, 0, 0},
+	/* config DNYUV */
+	{0x00000C00, 0x00777777, 0, 0},
+	{0x00000C04, 0x00007777, 0, 0},
+	{0x00000C08, 0x00777777, 0, 0},
+	{0x00000C0C, 0x00007777, 0, 0},
+	{0x00000C10, 0x00600040, 0, 0},
+	{0x00000C14, 0x00D80090, 0, 0},
+	{0x00000C18, 0x01E60144, 0, 0},
+	{0x00000C1C, 0x00600040, 0, 0},
+	{0x00000C20, 0x00D80090, 0, 0},
+	{0x00000C24, 0x01E60144, 0, 0},
+	/* config SAT */
+	{0x00000A30, 0x00000100, 0, 0},
+	{0x00000A34, 0x001F0001, 0, 0},
+	{0x00000A38, 0x00000000, 0, 0},
+	{0x00000A3C, 0x00000100, 0, 0},
+	{0x00000A40, 0x00000008, 0, 0},
+	{0x00000A54, 0x04010001, 0, 0},
+	{0x00000A58, 0x03FF0001, 0, 0},
+	/* config OBA */
+	{0x00000090, 0x04380000, 0, 0},
+	{0x00000094, 0x04390780, 0, 0},
+	/* config SC */
+	{0x0000009C, 0x01000000, 0, 0},
+	{0x000000B8, 0x000C0000, 0, 0},
+	{0x000000BC, 0xC010151D, 0, 0},
+	{0x000000C0, 0x01F1BF08, 0, 0},
+	{0x000000C4, 0xFF00FF00, 0, 0},
+	{0x000000C8, 0xFF00FF00, 0, 0},
+	{0x000000CC, 0xFFFF0000, 0, 0},
+	{0x000000D0, 0xFFFF0000, 0, 0},
+	{0x000000D4, 0xFFFF0000, 0, 0},
+	{0x000000D8, 0x01050107, 0, 0},
+	{0x000004D0, 0x00000000, 0, 0},
+	{0x000004D4, 0x00000000, 0, 0},
+	{0x000004D8, 0x00000000, 0, 0},
+	{0x000004DC, 0x00000000, 0, 0},
+	{0x000004E0, 0x00000000, 0, 0},
+	{0x000004E4, 0x00000000, 0, 0},
+	{0x000004E8, 0x00000000, 0, 0},
+	{0x000004EC, 0x00000000, 0, 0},
+	{0x000004F0, 0x00100000, 0, 0},
+	{0x000004F4, 0x00000000, 0, 0},
+	{0x000004F8, 0x03D20000, 0, 0},
+	{0x000004FC, 0x00000000, 0, 0},
+	{0x00000500, 0x00950000, 0, 0},
+	{0x00000504, 0x00000000, 0, 0},
+	{0x00000508, 0x00253000, 0, 0},
+	{0x0000050C, 0x00000000, 0, 0},
+	{0x00000510, 0x00000000, 0, 0},
+	{0x00000514, 0x00000000, 0, 0},
+	{0x00000518, 0x00000000, 0, 0},
+	{0x0000051C, 0x00000000, 0, 0},
+	{0x00000520, 0x00000000, 0, 0},
+	{0x00000524, 0x00000000, 0, 0},
+	{0x00000528, 0x00000000, 0, 0},
+	{0x0000052C, 0x00000000, 0, 0},
+	{0x00000530, 0x00000000, 0, 0},
+	{0x00000534, 0x00000000, 0, 0},
+	{0x00000538, 0xFFFFFFF0, 0, 0},
+	{0x0000053C, 0x8FFFFFFF, 0, 0},
+	{0x00000540, 0x0000001E, 0, 0},
+	{0x00000544, 0x00000000, 0, 0},
+	{0x00000548, 0x00000000, 0, 0},
+	{0x0000054C, 0xF0F20000, 0, 0},
+	{0x000005D0, 0xFF00FF00, 0, 0},
+	{0x000005D4, 0xFF00FF00, 0, 0},
+	/* config YHIST */
+	{0x00000CC8, 0x00000000, 0, 0},
+	{0x00000CCC, 0x0437077F, 0, 0},
+	{0x00000CD0, 0x00010002, 0, 0},
+	{0x00000CD4, 0x00000000, 0, 0},
+	/* config CBAR */
+	{0x00000600, 0x043E0782, 0, 0},
+	{0x00000604, 0x00000000, 0, 0},
+	{0x00000608, 0x0437077F, 0, 0},
+	{0x0000060C, 0x00443150, 0, 0},
+	{0x00000610, 0x00000000, 0, 0},
+	{0x00000614, 0x08880888, 0, 0},
+	{0x00000618, 0x02220222, 0, 0},
+	{0x0000061C, 0x04440444, 0, 0},
+	{0x00000620, 0x08880888, 0, 0},
+	{0x00000624, 0x0AAA0AAA, 0, 0},
+	{0x00000628, 0x0CCC0CCC, 0, 0},
+	{0x0000062C, 0x0EEE0EEE, 0, 0},
+	{0x00000630, 0x0FFF0FFF, 0, 0},
+	{0x00000634, 0x08880888, 0, 0},
+	{0x00000638, 0x02220222, 0, 0},
+	{0x0000063C, 0x04440444, 0, 0},
+	{0x00000640, 0x08880888, 0, 0},
+	{0x00000644, 0x0AAA0AAA, 0, 0},
+	{0x00000648, 0x0CCC0CCC, 0, 0},
+	{0x0000064C, 0x0EEE0EEE, 0, 0},
+	{0x00000650, 0x0FFF0FFF, 0, 0},
+	/* config sensor */
+	{0x00000014, 0x0000000c, 0, 0},
+	/* config CROP */
+	{0x0000001C, 0x00000000, 0, 0},
+	{0x00000020, 0x0437077F, 0, 0},
+	/* config isp pileline X/Y size */
+	{0x00000A0C, 0x04380780, 0, 0},
+	/* config CSI dump */
+	{0x00000028, 0x00030B80, 0, 0},
+	/* config UO */
+	{0x00000A88, 0x00000780, 0, 0},
+	/* NV12 */
+	{0x00000A8C, 0x00000000, 0, 0},
+	/* NV21
+	 *{0x00000A8C, 0x00000020, 0, 0},
+	 */
+	{0x00000A90, 0x00000000, 0, 0},
+	{0x00000A9C, 0x00000780, 0, 0},
+	{0x00000AA0, 0x00000002, 0, 0},
+	{0x00000AA4, 0x00000002, 0, 0},
+	{0x00000AA8, 0x07800438, 0, 0},
+	{0x00000AB4, 0x00000780, 0, 0},
+	{0x00000AB8, 0x00000002, 0, 0},
+	{0x00000ABC, 0x00000002, 0, 0},
+	{0x00000AC0, 0x07800438, 0, 0},
+	{0x00000AC4, 0x00000000, 0, 0},
+	/* config TIL */
+	{0x00000B20, 0x04380780, 0, 0},
+	{0x00000B24, 0x00000960, 0, 0},
+	{0x00000B38, 0x00030003, 0, 0},
+	{0x00000B3C, 0x00000960, 0, 0},
+	{0x00000B44, 0x00000000, 0, 0},
+	{0x00000B48, 0x00000000, 0, 0},
+	/* Enable DEC/OBC/OECF/LCCF/AWB/SC/DUMP */
+	{0x00000010, 0x000A00D6, 0x00000000, 0x00},
+	/* Enable CFA/CAR/CCM/GMARGB/R2Y/SHRP/SAT/DNYUV/YCRV/YHIST/CTC/DBC */
+	{0x00000A08, 0x107A01BE, 0x00000000, 0x00},
+};
+
+const struct reg_table isp_reg_init_settings[] = {
+	{isp_reg_init_config_list, ARRAY_SIZE(isp_reg_init_config_list)},
+};
+
+static const struct regval_t isp_reg_start_config_list[] = {
+	/* ENABLE UO/Multi-Frame and Reset ISP */
+	{0x00000A00, 0x00120002, 0x00000000, 0x0A},
+	/* ENABLE UO/Multi-Frame and Leave ISP reset */
+	{0x00000A00, 0x00120000, 0x00000000, 0x0A},
+	/* Config ISP shadow mode as next-vsync */
+	{0x00000A50, 0x00000002, 0x00000000, 0x00},
+	/* ENABLE UO/Multi-Frame and Enable ISP */
+	{0x00000A00, 0x00120001, 0x00000000, 0x0A},
+	/* Config CSI shadow mode as immediate to fetch current setting */
+	{0x00000008, 0x00010004, 0x00000000, 0x0A},
+	/* Config CSI shadow mode as next-vsync */
+	{0x00000008, 0x00020004, 0x00000000, 0x00},
+	/* Enable CSI */
+	{0x00000000, 0x00000001, 0x00000000, 0x0A},
+};
+
+const struct reg_table isp_reg_start_settings[] = {
+	{isp_reg_start_config_list, ARRAY_SIZE(isp_reg_start_config_list)},
+};
+
+static struct regval_t isp_format_reg_list[] = {
+	{0x0000001C, 0x00000000, 0x00000000, 0},
+	{0x00000020, 0x0437077F, 0x00000000, 0},
+	{0x00000A0C, 0x04380780, 0x00000000, 0},
+	{0x00000A88, 0x00000780, 0x00000000, 0},
+	{0x00000018, 0x000011BB, 0x00000000, 0},
+	{0x00000A08, 0x10000000, 0xF0000000, 0},
+	{0x00000028, 0x00030B80, 0x0003FFFF, 0},
+	{0x00000AA8, 0x07800438, 0x00000000, 0},
+	{0x00000A9C, 0x00000780, 0x00000000, 0},
+	{0x00000AC0, 0x07800438, 0x00000000, 0},
+	{0x00000AB4, 0x00000780, 0x00000000, 0},
+	{0x00000B20, 0x04380780, 0x00000000, 0},
+	{0x00000B24, 0x00000960, 0x00000000, 0},
+	{0x00000B3C, 0x00000960, 0x00000000, 0},
+	{0x00000014, 0x00000008, 0x00000000, 0},
+};
+
+const struct reg_table isp_format_settings[] = {
+	{isp_format_reg_list, ARRAY_SIZE(isp_format_reg_list)},
+};
+
+static void isp_load_regs(void __iomem *ispbase, const struct reg_table *table)
+{
+	int j;
+	u32 delay_ms, reg_addr, mask, val;
+
+	for (j = 0; j < table->regval_num; j++) {
+		delay_ms = table->regval[j].delay_ms;
+		reg_addr = table->regval[j].addr;
+		val = table->regval[j].val;
+		mask = table->regval[j].mask;
+
+		if (reg_addr % 4 ||
+		    reg_addr > STF_ISP_REG_OFFSET_MAX ||
+		    delay_ms > STF_ISP_REG_DELAY_MAX)
+			continue;
+
+		if (mask)
+			reg_set_bit(ispbase, reg_addr, mask, val);
+		else
+			reg_write(ispbase, reg_addr, val);
+
+		if (delay_ms)
+			usleep_range(1000 * delay_ms, 1000 * delay_ms + 100);
+	}
+}
+
+static void isp_load_regs_exclude_csi_isp_enable(void __iomem *ispbase,
+						 const struct reg_table *table)
+{
+	int j;
+	u32 delay_ms, reg_addr, mask, val;
+
+	for (j = 0; j < table->regval_num; j++) {
+		delay_ms = table->regval[j].delay_ms;
+		reg_addr = table->regval[j].addr;
+		val = table->regval[j].val;
+		mask = table->regval[j].mask;
+
+		if (reg_addr % 4 ||
+		    reg_addr > STF_ISP_REG_OFFSET_MAX ||
+		    delay_ms > STF_ISP_REG_DELAY_MAX ||
+		    (reg_addr == ISP_REG_CSI_INPUT_EN_AND_STATUS && (val & 0x01)) ||
+		    (reg_addr == ISP_REG_ISP_CTRL_0 && (val & 0x01)))
+			continue;
+
+		if (mask)
+			reg_set_bit(ispbase, reg_addr, mask, val);
+		else
+			reg_write(ispbase, reg_addr, val);
+		if (delay_ms)
+			usleep_range(1000 * delay_ms, 1000 * delay_ms + 100);
+	}
+}
+
+static int stf_isp_clk_enable(struct stf_isp_dev *isp_dev)
+{
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	clk_prepare_enable(stfcamss->sys_clk[STF_CLK_WRAPPER_CLK_C].clk);
+	reset_control_deassert(stfcamss->sys_rst[STF_RST_WRAPPER_C].rstc);
+	reset_control_deassert(stfcamss->sys_rst[STF_RST_WRAPPER_P].rstc);
+
+	return 0;
+}
+
+static int stf_isp_clk_disable(struct stf_isp_dev *isp_dev)
+{
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	reset_control_assert(stfcamss->sys_rst[STF_RST_WRAPPER_C].rstc);
+	reset_control_assert(stfcamss->sys_rst[STF_RST_WRAPPER_P].rstc);
+	clk_disable_unprepare(stfcamss->sys_clk[STF_CLK_WRAPPER_CLK_C].clk);
+
+	return 0;
+}
+
+static void __iomem *stf_isp_get_ispbase(struct stf_isp_dev *isp_dev)
+{
+	void __iomem *base = isp_dev->stfcamss->isp_base;
+
+	return base;
+}
+
+static int stf_isp_reset(struct stf_isp_dev *isp_dev)
+{
+	void __iomem *ispbase = stf_isp_get_ispbase(isp_dev);
+
+	reg_set_bit(ispbase, ISP_REG_ISP_CTRL_0, BIT(1), BIT(1));
+	reg_set_bit(ispbase, ISP_REG_ISP_CTRL_0, BIT(1), 0);
+
+	return 0;
+}
+
+static int stf_isp_config_set(struct stf_isp_dev *isp_dev)
+{
+	void __iomem *ispbase = stf_isp_get_ispbase(isp_dev);
+
+	mutex_lock(&isp_dev->setfile_lock);
+	isp_load_regs(ispbase, isp_reg_init_settings);
+	if (isp_dev->setfile.state) {
+		st_info(ST_ISP, "%s, Program extra ISP setting!\n", __func__);
+		isp_load_regs_exclude_csi_isp_enable(ispbase,
+						     &isp_dev->setfile.settings);
+	}
+
+	mutex_unlock(&isp_dev->setfile_lock);
+
+	return 0;
+}
+
+static int stf_isp_set_format(struct stf_isp_dev *isp_dev,
+			      struct isp_stream_format *crop_array,
+			      u32 mcode,
+			      int type)
+{
+	struct v4l2_rect *crop = &crop_array[ISP_COMPOSE].rect;
+	u32 bpp = crop_array[ISP_COMPOSE].bpp;
+	void __iomem *ispbase = stf_isp_get_ispbase(isp_dev);
+	u32 val, val1;
+
+	st_debug(ST_ISP, "interface type is %d(%s)\n",
+		 type, type == INTERFACE_CSI ? "CSI" : "DVP");
+
+	val = crop->left + (crop->top << 16);
+	isp_format_reg_list[0].addr = ISP_REG_PIC_CAPTURE_START_CFG;
+	isp_format_reg_list[0].val = val;
+
+	val = (crop->width + crop->left - 1)
+		+ ((crop->height + crop->top - 1) << 16);
+	isp_format_reg_list[1].addr = ISP_REG_PIC_CAPTURE_END_CFG;
+	isp_format_reg_list[1].val = val;
+
+	val = crop->width + (crop->height << 16);
+	isp_format_reg_list[2].addr = ISP_REG_PIPELINE_XY_SIZE;
+	isp_format_reg_list[2].val = val;
+
+	isp_format_reg_list[3].addr = ISP_REG_STRIDE;
+	isp_format_reg_list[3].val = ALIGN(crop->width * bpp / 8,
+					   STFCAMSS_FRAME_WIDTH_ALIGN_8);
+
+	switch (mcode) {
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		/* 3 2 3 2 1 0 1 0 B Gb B Gb Gr R Gr R */
+		val = 0x0000EE44;
+		val1 = 0x00000000;
+		break;
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+		/* 2 3 2 3 0 1 0 1, Gb B Gb B R Gr R Gr */
+		val = 0x0000BB11;
+		val1 = 0x20000000;
+		break;
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+		/* 1 0 1 0 3 2 3 2, Gr R Gr R B Gb B Gb */
+		val = 0x000044EE;
+		val1 = 0x30000000;
+		break;
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+		/* 0 1 0 1 2 3 2 3 R Gr R Gr Gb B Gb B */
+		val = 0x000011BB;
+		val1 = 0x10000000;
+		break;
+	default:
+		st_err(ST_ISP, "UNKNOWN format\n");
+		val = 0x000011BB;
+		val1 = 0x10000000;
+		break;
+	}
+
+	isp_format_reg_list[4].addr = ISP_REG_RAW_FORMAT_CFG;
+	isp_format_reg_list[4].val = val;
+
+	isp_format_reg_list[5].addr = ISP_REG_ISP_CTRL_1;
+	isp_format_reg_list[5].val = val1;
+	isp_format_reg_list[5].mask = 0xF0000000;
+
+	st_info(ST_ISP,
+		"src left: %d, top: %d, width = %d, height = %d, bpp = %d\n",
+		crop->left, crop->top, crop->width, crop->height, bpp);
+
+	crop = &crop_array[ISP_CROP].rect;
+	bpp = crop_array[ISP_CROP].bpp;
+	val = ALIGN(crop->width * bpp / 8, STFCAMSS_FRAME_WIDTH_ALIGN_128);
+	isp_format_reg_list[6].addr = ISP_REG_DUMP_CFG_1;
+	isp_format_reg_list[6].val = val | 3 << 16;
+	isp_format_reg_list[6].mask = 0x0003FFFF;
+
+	st_info(ST_ISP,
+		"raw left: %d, top: %d, width = %d, height = %d, bpp = %d\n",
+		crop->left, crop->top, crop->width, crop->height, bpp);
+
+	crop = &crop_array[ISP_SCALE_SS0].rect;
+	bpp = crop_array[ISP_SCALE_SS0].bpp;
+	isp_format_reg_list[7].addr = ISP_REG_SS0IW;
+	isp_format_reg_list[7].val = (crop->width << 16) + crop->height;
+	isp_format_reg_list[8].addr = ISP_REG_SS0S;
+	isp_format_reg_list[8].val =
+		ALIGN(crop->width * bpp / 8, STFCAMSS_FRAME_WIDTH_ALIGN_8);
+
+	st_info(ST_ISP,
+		"ss0 left: %d, top: %d, width = %d, height = %d, bpp = %d\n",
+		crop->left, crop->top, crop->width, crop->height, bpp);
+
+	crop = &crop_array[ISP_SCALE_SS1].rect;
+	bpp = crop_array[ISP_SCALE_SS1].bpp;
+	isp_format_reg_list[9].addr = ISP_REG_SS1IW;
+	isp_format_reg_list[9].val = (crop->width << 16) + crop->height;
+	isp_format_reg_list[10].addr = ISP_REG_SS1S;
+	isp_format_reg_list[10].val =
+		ALIGN(crop->width * bpp / 8, STFCAMSS_FRAME_WIDTH_ALIGN_8);
+
+	isp_format_reg_list[14].addr = ISP_REG_SENSOR;
+	isp_format_reg_list[14].val = 0x00000000;
+	if (type == INTERFACE_CSI)
+		isp_format_reg_list[14].val |= 0x01;
+
+	isp_load_regs(ispbase, isp_format_settings);
+	return 0;
+}
+
+static int stf_isp_stream_set(struct stf_isp_dev *isp_dev, int on)
+{
+	void __iomem *ispbase = stf_isp_get_ispbase(isp_dev);
+
+	if (on)
+		isp_load_regs(ispbase, isp_reg_start_settings);
+
+	return 0;
+}
+
+static int stf_isp_reg_read(struct stf_isp_dev *isp_dev, void *arg)
+{
+	void __iomem *ispbase = stf_isp_get_ispbase(isp_dev);
+	struct isp_reg_param *reg_param = arg;
+	union reg_buf *reg_buf = isp_dev->reg_buf;
+	u32 size;
+	unsigned long r;
+
+	if (!reg_param->reg_buf) {
+		st_err(ST_ISP,
+		       "Failed to access register.The pointer is NULL!\n");
+		return -EINVAL;
+	}
+
+	size = 0;
+	switch (reg_param->reg_info.method) {
+	case STF_ISP_REG_METHOD_ONE_REG:
+		break;
+
+	case STF_ISP_REG_METHOD_SERIES:
+		if (reg_param->reg_info.length > STF_ISP_REG_BUF_SIZE) {
+			st_err(ST_ISP,
+			       "The length = 0x%08X is out of size!\n",
+			       reg_param->reg_info.length);
+			return -EINVAL;
+		}
+		break;
+
+	case STF_ISP_REG_METHOD_MODULE:
+		st_err(ST_ISP, "The method = %d is not supported!\n",
+		       reg_param->reg_info.method);
+		return -ENOTTY;
+
+	case STF_ISP_REG_METHOD_TABLE:
+		if (reg_param->reg_info.length > STF_ISP_REG_TBL_BUF_SIZE) {
+			st_err(ST_ISP,
+			       "The length = 0x%08X is out of size!\n",
+			       reg_param->reg_info.length);
+			return -EINVAL;
+		}
+		size = sizeof(u32) * reg_param->reg_info.length * 2;
+		break;
+
+	case STF_ISP_REG_METHOD_TABLE_2:
+		if (reg_param->reg_info.length > STF_ISP_REG_TBL_2_BUF_SIZE) {
+			st_err(ST_ISP,
+			       "The length = 0x%08X is out of size!\n",
+			       reg_param->reg_info.length);
+			return -EINVAL;
+		}
+		size = sizeof(u32) * reg_param->reg_info.length * 3;
+		break;
+
+	case STF_ISP_REG_METHOD_TABLE_3:
+		if (reg_param->reg_info.length > STF_ISP_REG_TBL_3_BUF_SIZE) {
+			st_err(ST_ISP,
+			       "The length = 0x%08X is out of size!\n",
+			       reg_param->reg_info.length);
+			return -EINVAL;
+		}
+		size = sizeof(u32) * reg_param->reg_info.length * 4;
+		break;
+
+	case STF_ISP_REG_METHOD_SMPL_PACK:
+		st_err(ST_ISP, "The method = %d is not supported!\n",
+		       reg_param->reg_info.method);
+		return -ENOTTY;
+
+	case STF_ISP_REG_METHOD_SOFT_RDMA:
+		st_err(ST_ISP, "The method = %d is not supported!\n",
+		       reg_param->reg_info.method);
+		return -ENOTTY;
+
+	default:
+		st_err(ST_ISP, "The method = %d is not supported!\n",
+		       reg_param->reg_info.method);
+		return -ENOTTY;
+	}
+
+	memset(reg_buf, 0, sizeof(union reg_buf));
+	if (size) {
+		r = copy_from_user((u8 *)reg_buf->buffer,
+				   (u8 *)reg_param->reg_buf->buffer, size);
+		if (r) {
+			st_err(ST_ISP, "Failed to copy buffer data\n");
+			return -EIO;
+		}
+	}
+
+	size = 0;
+	switch (reg_param->reg_info.method) {
+	case STF_ISP_REG_METHOD_ONE_REG:
+		reg_buf->buffer[0] = reg_read(ispbase,
+					      reg_param->reg_info.offset);
+		size = sizeof(u32);
+		break;
+
+	case STF_ISP_REG_METHOD_SERIES:
+		for (r = 0; r < reg_param->reg_info.length; r++)
+			reg_buf->buffer[r] =
+				reg_read(ispbase,
+					 reg_param->reg_info.offset + (r * 4));
+
+		size = sizeof(u32) * reg_param->reg_info.length;
+		break;
+
+	case STF_ISP_REG_METHOD_MODULE:
+		break;
+
+	case STF_ISP_REG_METHOD_TABLE:
+		for (r = 0; r < reg_param->reg_info.length; r++)
+			reg_buf->reg_tbl[r].value =
+				reg_read(ispbase, reg_buf->reg_tbl[r].offset);
+
+		size = sizeof(u32) * reg_param->reg_info.length * 2;
+		break;
+
+	case STF_ISP_REG_METHOD_TABLE_2:
+		for (r = 0; r < reg_param->reg_info.length; r++) {
+			if (reg_buf->reg_tbl2[r].mask)
+				reg_buf->reg_tbl2[r].value =
+					reg_read(ispbase, reg_buf->reg_tbl2[r].offset) &
+					reg_buf->reg_tbl2[r].mask;
+			else
+				reg_buf->reg_tbl2[r].value =
+					reg_read(ispbase,
+						 reg_buf->reg_tbl2[r].offset);
+		}
+
+		size = sizeof(u32) * reg_param->reg_info.length * 3;
+		break;
+
+	case STF_ISP_REG_METHOD_TABLE_3:
+		for (r = 0; r < reg_param->reg_info.length; r++) {
+			if (reg_buf->reg_tbl3[r].mask)
+				reg_buf->reg_tbl3[r].value =
+					reg_read(ispbase, reg_buf->reg_tbl3[r].offset) &
+					reg_buf->reg_tbl3[r].mask;
+			else
+				reg_buf->reg_tbl3[r].value =
+					reg_read(ispbase,
+						 reg_buf->reg_tbl3[r].offset);
+
+			if (reg_buf->reg_tbl3[r].delay_ms)
+				usleep_range(1000 * reg_buf->reg_tbl3[r].delay_ms,
+					     1000 * reg_buf->reg_tbl3[r].delay_ms + 100);
+		}
+
+		size = sizeof(u32) * reg_param->reg_info.length * 4;
+		break;
+
+	case STF_ISP_REG_METHOD_SMPL_PACK:
+		break;
+
+	case STF_ISP_REG_METHOD_SOFT_RDMA:
+		break;
+
+	default:
+		break;
+	}
+
+	r = copy_to_user((u8 *)reg_param->reg_buf->buffer,
+			 (u8 *)reg_buf->buffer, size);
+	if (r) {
+		st_err(ST_ISP,
+		       "Failed to copy the reg_param->buffer value\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int stf_isp_soft_rdma(struct stf_isp_dev *isp_dev, u32 rdma_addr)
+{
+	void __iomem *ispbase = stf_isp_get_ispbase(isp_dev);
+	struct isp_rdma_info *rdma_info = NULL;
+	s32 len;
+	u32 offset;
+	int ret = 0;
+
+	rdma_info = phys_to_virt(rdma_addr);
+	while (1) {
+		if (rdma_info->tag == RDMA_END)
+			break;
+
+		if (rdma_info->tag == RDMA_WR_ONE) {
+			reg_write(ispbase, rdma_info->offset, rdma_info->param);
+			rdma_info++;
+		} else if (rdma_info->tag == RDMA_WR_SRL) {
+			offset = rdma_info->offset;
+			len = rdma_info->param;
+			rdma_info++;
+			while (len > 0) {
+				reg_write(ispbase, offset, rdma_info->param);
+				offset += 4;
+				len--;
+				if (len > 0) {
+					reg_write(ispbase,
+						  offset, rdma_info->value);
+					len--;
+				}
+				offset += 4;
+				rdma_info++;
+			}
+		} else if (rdma_info->tag == RDMA_LINK) {
+			rdma_info = phys_to_virt(rdma_info->param);
+		} else if (rdma_info->tag == RDMA_SINT) {
+			/* not support this command. */
+			rdma_info++;
+		} else {
+			rdma_info++;
+		}
+	}
+
+	return ret;
+}
+
+static int stf_isp_reg_write(struct stf_isp_dev *isp_dev, void *arg)
+{
+	void __iomem *ispbase = stf_isp_get_ispbase(isp_dev);
+	struct isp_reg_param *reg_param = arg;
+	struct isp_rdma_info *rdma_info = NULL;
+	union reg_buf *reg_buf = isp_dev->reg_buf;
+	s32 len;
+	u32 offset;
+	u32 size;
+	unsigned long r;
+	int ret = 0;
+
+	if (!reg_param->reg_buf &&
+	    reg_param->reg_info.method != STF_ISP_REG_METHOD_SOFT_RDMA) {
+		st_err(ST_ISP, "Failed to access register.\n");
+		return -EINVAL;
+	}
+
+	size = 0;
+	switch (reg_param->reg_info.method) {
+	case STF_ISP_REG_METHOD_ONE_REG:
+		size = sizeof(u32);
+		break;
+
+	case STF_ISP_REG_METHOD_SERIES:
+		if (reg_param->reg_info.length > STF_ISP_REG_BUF_SIZE) {
+			st_err(ST_ISP,
+			       "The length = 0x%08X is out of size!\n",
+			       reg_param->reg_info.length);
+			return -EINVAL;
+		}
+		size = sizeof(u32) * reg_param->reg_info.length;
+		break;
+
+	case STF_ISP_REG_METHOD_MODULE:
+		st_err(ST_ISP, "The method = %d is not supported!\n",
+		       reg_param->reg_info.method);
+		return -ENOTTY;
+
+	case STF_ISP_REG_METHOD_TABLE:
+		if (reg_param->reg_info.length > STF_ISP_REG_TBL_BUF_SIZE) {
+			st_err(ST_ISP,
+			       "The length = 0x%08X is out of size!\n",
+			       reg_param->reg_info.length);
+			return -EINVAL;
+		}
+		size = sizeof(u32) * reg_param->reg_info.length * 2;
+		break;
+
+	case STF_ISP_REG_METHOD_TABLE_2:
+		if (reg_param->reg_info.length > STF_ISP_REG_TBL_2_BUF_SIZE) {
+			st_err(ST_ISP,
+			       "The length = 0x%08X is out of size!\n",
+			       reg_param->reg_info.length);
+			return -EINVAL;
+		}
+		size = sizeof(u32) * reg_param->reg_info.length * 3;
+		break;
+
+	case STF_ISP_REG_METHOD_TABLE_3:
+		if (reg_param->reg_info.length > STF_ISP_REG_TBL_3_BUF_SIZE) {
+			st_err(ST_ISP,
+			       "The length = 0x%08X is out of size!\n",
+			       reg_param->reg_info.length);
+			return -EINVAL;
+		}
+		size = sizeof(u32) * reg_param->reg_info.length * 4;
+		break;
+
+	case STF_ISP_REG_METHOD_SMPL_PACK:
+		if (reg_param->reg_info.length >
+		    STF_ISP_REG_SMPL_PACK_BUF_SIZE) {
+			st_err(ST_ISP,
+			       "The length = 0x%08X is out of size!\n",
+			       reg_param->reg_info.length);
+			return -EINVAL;
+		}
+		size = sizeof(u32) * reg_param->reg_info.length * 2;
+		break;
+
+	case STF_ISP_REG_METHOD_SOFT_RDMA:
+		break;
+
+	default:
+		st_err(ST_ISP, "The method = %d is not supported!\n",
+		       reg_param->reg_info.method);
+		return -ENOTTY;
+	}
+
+	memset(reg_buf, 0, sizeof(union reg_buf));
+	if (size) {
+		r = copy_from_user((u8 *)reg_buf->buffer,
+				   (u8 *)reg_param->reg_buf->buffer, size);
+		if (r) {
+			st_err(ST_ISP, "Failed to copy buffer data\n");
+			return -EIO;
+		}
+	}
+
+	switch (reg_param->reg_info.method) {
+	case STF_ISP_REG_METHOD_ONE_REG:
+		reg_write(ispbase,
+			  reg_param->reg_info.offset, reg_buf->buffer[0]);
+		break;
+
+	case STF_ISP_REG_METHOD_SERIES:
+		for (r = 0; r < reg_param->reg_info.length; r++) {
+			reg_write(ispbase,
+				  reg_param->reg_info.offset + (r * 4),
+				  reg_buf->buffer[r]);
+		}
+		break;
+
+	case STF_ISP_REG_METHOD_MODULE:
+		/* This mode is not supported.*/
+		break;
+
+	case STF_ISP_REG_METHOD_TABLE:
+		for (r = 0; r < reg_param->reg_info.length; r++) {
+			reg_write(ispbase, reg_buf->reg_tbl[r].offset,
+				  reg_buf->reg_tbl[r].value);
+		}
+		break;
+
+	case STF_ISP_REG_METHOD_TABLE_2:
+		for (r = 0; r < reg_param->reg_info.length; r++) {
+			if (reg_buf->reg_tbl2[r].mask) {
+				reg_set_bit(ispbase,
+					    reg_buf->reg_tbl2[r].offset,
+					    reg_buf->reg_tbl2[r].mask,
+					    reg_buf->reg_tbl2[r].value);
+			} else {
+				reg_write(ispbase, reg_buf->reg_tbl2[r].offset,
+					  reg_buf->reg_tbl2[r].value);
+			}
+		}
+		break;
+
+	case STF_ISP_REG_METHOD_TABLE_3:
+		for (r = 0; r < reg_param->reg_info.length; r++) {
+			if (reg_buf->reg_tbl3[r].mask)
+				reg_set_bit(ispbase,
+					    reg_buf->reg_tbl3[r].offset,
+					    reg_buf->reg_tbl3[r].mask,
+					    reg_buf->reg_tbl3[r].value);
+			else
+				reg_write(ispbase, reg_buf->reg_tbl3[r].offset,
+					  reg_buf->reg_tbl3[r].value);
+
+			if (reg_buf->reg_tbl3[r].delay_ms)
+				usleep_range(1000 * reg_buf->reg_tbl3[r].delay_ms,
+					     1000 * reg_buf->reg_tbl3[r].delay_ms + 100);
+		}
+		break;
+
+	case STF_ISP_REG_METHOD_SMPL_PACK:
+		size = reg_param->reg_info.length;
+		rdma_info = &reg_buf->rdma_cmd[0];
+		while (size) {
+			if (rdma_info->tag == RDMA_END)
+				break;
+
+			if (rdma_info->tag == RDMA_WR_ONE) {
+				reg_write(ispbase,
+					  rdma_info->offset, rdma_info->param);
+				rdma_info++;
+				size--;
+			} else if (rdma_info->tag == RDMA_WR_SRL) {
+				offset = rdma_info->offset;
+				len = rdma_info->param;
+				rdma_info++;
+				size--;
+				while (size && (len > 0)) {
+					reg_write(ispbase,
+						  offset, rdma_info->param);
+					offset += 4;
+					len--;
+					if (len > 0) {
+						reg_write(ispbase,
+							  offset,
+							  rdma_info->value);
+						len--;
+					}
+					offset += 4;
+					rdma_info++;
+					size--;
+				}
+			} else {
+				rdma_info++;
+				size--;
+			}
+		}
+		break;
+
+	case STF_ISP_REG_METHOD_SOFT_RDMA:
+		/*
+		 * Simulation the hardware RDMA behavior to debug and verify
+		 * the RDMA chain.
+		 */
+		ret = stf_isp_soft_rdma(isp_dev, reg_param->reg_info.offset);
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int stf_isp_shadow_trigger(struct stf_isp_dev *isp_dev)
+{
+	void __iomem *ispbase = stf_isp_get_ispbase(isp_dev);
+
+	/* shadow update */
+	reg_set_bit(ispbase,
+		    ISP_REG_CSIINTS_ADDR, (BIT(17) | BIT(16)), 0x30000);
+	reg_set_bit(ispbase, ISP_REG_IESHD_ADDR, (BIT(1) | BIT(0)), 0x3);
+
+	return 0;
+}
+
+const struct isp_hw_ops isp_ops = {
+	.isp_clk_enable        = stf_isp_clk_enable,
+	.isp_clk_disable       = stf_isp_clk_disable,
+	.isp_reset             = stf_isp_reset,
+	.isp_config_set        = stf_isp_config_set,
+	.isp_set_format        = stf_isp_set_format,
+	.isp_stream_set        = stf_isp_stream_set,
+	.isp_reg_read          = stf_isp_reg_read,
+	.isp_reg_write         = stf_isp_reg_write,
+	.isp_shadow_trigger    = stf_isp_shadow_trigger,
+};
diff --git a/drivers/media/platform/starfive/stf_video.c b/drivers/media/platform/starfive/stf_video.c
new file mode 100644
index 000000000000..23d393e6fd78
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_video.c
@@ -0,0 +1,1286 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_video.c
+ *
+ * StarFive Camera Subsystem - V4L2 device node
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#include <media/media-entity.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-mc.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include "stf_camss.h"
+#include "stf_video.h"
+
+static const struct stfcamss_format_info formats_pix_wr[] = {
+	{ MEDIA_BUS_FMT_SRGGB10_1X10, V4L2_PIX_FMT_SRGGB10, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
+	{ MEDIA_BUS_FMT_SGRBG10_1X10, V4L2_PIX_FMT_SGRBG10, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
+	{ MEDIA_BUS_FMT_SGBRG10_1X10, V4L2_PIX_FMT_SGBRG10, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
+	{ MEDIA_BUS_FMT_SBGGR10_1X10, V4L2_PIX_FMT_SBGGR10, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
+};
+
+static const struct stfcamss_format_info formats_raw_isp[] = {
+	{ MEDIA_BUS_FMT_SBGGR12_1X12, V4L2_PIX_FMT_SBGGR12, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
+	{ MEDIA_BUS_FMT_SRGGB12_1X12, V4L2_PIX_FMT_SRGGB12, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
+	{ MEDIA_BUS_FMT_SGRBG12_1X12, V4L2_PIX_FMT_SGRBG12, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
+	{ MEDIA_BUS_FMT_SGBRG12_1X12, V4L2_PIX_FMT_SGBRG12, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
+};
+
+static const struct stfcamss_format_info formats_pix_isp[] = {
+	{ MEDIA_BUS_FMT_Y12_1X12, V4L2_PIX_FMT_NV12, 1,
+	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
+};
+
+/* -----------------------------------------------------------------------------
+ * Helper functions
+ */
+
+static int video_find_format(u32 code, u32 pixelformat,
+			     const struct stfcamss_format_info *formats,
+			     unsigned int nformats)
+{
+	int i;
+
+	for (i = 0; i < nformats; i++) {
+		if (formats[i].code == code &&
+		    formats[i].pixelformat == pixelformat)
+			return i;
+	}
+
+	for (i = 0; i < nformats; i++)
+		if (formats[i].code == code)
+			return i;
+
+	for (i = 0; i < nformats; i++)
+		if (formats[i].pixelformat == pixelformat)
+			return i;
+
+	return -EINVAL;
+}
+
+static int __video_try_fmt(struct stfcamss_video *video, struct v4l2_format *f)
+{
+	struct v4l2_pix_format *pix;
+	const struct stfcamss_format_info *fi;
+	u32 width, height;
+	u32 bpl;
+	int i;
+
+	st_debug(ST_VIDEO, "%s, fmt.type = 0x%x\n", __func__, f->type);
+	pix = &f->fmt.pix;
+
+	for (i = 0; i < video->nformats; i++)
+		if (pix->pixelformat == video->formats[i].pixelformat)
+			break;
+
+	if (i == video->nformats)
+		i = 0; /* default format */
+
+	fi = &video->formats[i];
+	width = pix->width;
+	height = pix->height;
+
+	memset(pix, 0, sizeof(*pix));
+
+	pix->pixelformat = fi->pixelformat;
+	pix->width = clamp_t(u32, width, STFCAMSS_FRAME_MIN_WIDTH,
+			     STFCAMSS_FRAME_MAX_WIDTH);
+	pix->height = clamp_t(u32, height, STFCAMSS_FRAME_MIN_HEIGHT,
+			      STFCAMSS_FRAME_MAX_HEIGHT);
+	bpl = pix->width / fi->hsub[0].numerator *
+	      fi->hsub[0].denominator * fi->bpp[0] / 8;
+	bpl = ALIGN(bpl, video->bpl_alignment);
+	pix->bytesperline = bpl;
+	pix->sizeimage = pix->height / fi->vsub[0].numerator *
+			 fi->vsub[0].denominator * bpl;
+
+	pix->field = V4L2_FIELD_NONE;
+	pix->colorspace = V4L2_COLORSPACE_SRGB;
+	pix->flags = 0;
+	pix->ycbcr_enc =
+		V4L2_MAP_YCBCR_ENC_DEFAULT(pix->colorspace);
+	pix->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
+							  pix->colorspace,
+							  pix->ycbcr_enc);
+	pix->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(pix->colorspace);
+
+	st_info(ST_VIDEO, "w, h = %d, %d, bpp = %d\n",
+		pix->width, pix->height, fi->bpp[0]);
+	st_info(ST_VIDEO, "i = %d, s = 0x%x\n", i, pix->sizeimage);
+
+	return 0;
+}
+
+static int stf_video_init_format(struct stfcamss_video *video)
+{
+	int ret;
+	struct v4l2_format format = {
+		.type = video->type,
+		.fmt.pix = {
+			.width = 1920,
+			.height = 1080,
+			.pixelformat = V4L2_PIX_FMT_RGB565,
+		},
+	};
+
+	ret = __video_try_fmt(video, &format);
+
+	if (ret < 0)
+		return ret;
+
+	video->active_fmt = format;
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------------
+ * Video queue operations
+ */
+
+static int video_queue_setup(struct vb2_queue *q,
+			     unsigned int *num_buffers,
+			     unsigned int *num_planes,
+			     unsigned int sizes[],
+			     struct device *alloc_devs[])
+{
+	struct stfcamss_video *video = vb2_get_drv_priv(q);
+	const struct v4l2_pix_format *format = &video->active_fmt.fmt.pix;
+
+	st_debug(ST_VIDEO, "%s, planes = %d\n", __func__, *num_planes);
+
+	if (*num_planes) {
+		if (*num_planes != 1)
+			return -EINVAL;
+
+		if (sizes[0] < format->sizeimage)
+			return -EINVAL;
+	}
+
+	*num_planes = 1;
+	sizes[0] = format->sizeimage;
+	if (!sizes[0])
+		st_err(ST_VIDEO, "%s: error size is zero!!!\n", __func__);
+
+	st_info(ST_VIDEO, "%s, planes = %d, size = %d\n",
+		__func__, *num_planes, sizes[0]);
+
+	return 0;
+}
+
+static int video_buf_init(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
+	struct stfcamss_buffer *buffer =
+		container_of(vbuf, struct stfcamss_buffer, vb);
+	const struct v4l2_pix_format *fmt = &video->active_fmt.fmt.pix;
+	dma_addr_t *paddr;
+
+	buffer->sizeimage = 0;
+
+	paddr = vb2_plane_cookie(vb, 0);
+	buffer->sizeimage = vb2_plane_size(vb, 0);
+	buffer->addr[0] = *paddr;
+	if (fmt->pixelformat == V4L2_PIX_FMT_NV12 ||
+	    fmt->pixelformat == V4L2_PIX_FMT_NV21 ||
+	    fmt->pixelformat == V4L2_PIX_FMT_NV16 ||
+	    fmt->pixelformat == V4L2_PIX_FMT_NV61)
+		buffer->addr[1] =
+			buffer->addr[0] + fmt->bytesperline * fmt->height;
+
+	return 0;
+}
+
+static int video_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
+	const struct v4l2_pix_format *fmt = &video->active_fmt.fmt.pix;
+
+	if (fmt->sizeimage > vb2_plane_size(vb, 0)) {
+		st_err(ST_VIDEO, "sizeimage = %d, plane size = %d\n",
+		       fmt->sizeimage, (unsigned int)vb2_plane_size(vb, 0));
+		return -EINVAL;
+	}
+	vb2_set_plane_payload(vb, 0, fmt->sizeimage);
+
+	vbuf->field = V4L2_FIELD_NONE;
+
+	return 0;
+}
+
+static void video_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
+	struct stfcamss_buffer *buffer =
+		container_of(vbuf, struct stfcamss_buffer, vb);
+
+	video->ops->queue_buffer(video, buffer);
+}
+
+/*
+ * video_mbus_to_pix - Convert v4l2_mbus_framefmt to v4l2_pix_format
+ * @mbus: v4l2_mbus_framefmt format (input)
+ * @pix: v4l2_pix_format_mplane format (output)
+ * @f: a pointer to formats array element to be used for the conversion
+ * @alignment: bytesperline alignment value
+ *
+ * Fill the output pix structure with information from the input mbus format.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int video_mbus_to_pix(const struct v4l2_mbus_framefmt *mbus,
+			     struct v4l2_pix_format *pix,
+			     const struct stfcamss_format_info *f,
+			     unsigned int alignment)
+{
+	u32 bytesperline;
+
+	memset(pix, 0, sizeof(*pix));
+	v4l2_fill_pix_format(pix, mbus);
+	pix->pixelformat = f->pixelformat;
+	bytesperline = pix->width / f->hsub[0].numerator *
+		       f->hsub[0].denominator * f->bpp[0] / 8;
+	bytesperline = ALIGN(bytesperline, alignment);
+	pix->bytesperline = bytesperline;
+	pix->sizeimage = pix->height / f->vsub[0].numerator *
+			 f->vsub[0].denominator * bytesperline;
+	return 0;
+}
+
+static struct v4l2_subdev *video_remote_subdev(struct stfcamss_video *video,
+					       u32 *pad)
+{
+	struct media_pad *remote;
+
+	remote = media_pad_remote_pad_first(&video->pad);
+
+	if (!remote || !is_media_entity_v4l2_subdev(remote->entity))
+		return NULL;
+
+	if (pad)
+		*pad = remote->index;
+
+	return media_entity_to_v4l2_subdev(remote->entity);
+}
+
+static int video_get_subdev_format(struct stfcamss_video *video,
+				   struct v4l2_format *format)
+{
+	struct v4l2_pix_format *pix = &video->active_fmt.fmt.pix;
+	struct v4l2_subdev_format fmt;
+	struct v4l2_subdev *subdev;
+	u32 pixelformat;
+	u32 pad;
+	int ret;
+
+	subdev = video_remote_subdev(video, &pad);
+	if (!subdev)
+		return -EPIPE;
+
+	fmt.pad = pad;
+	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+
+	ret = v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);
+	if (ret)
+		return ret;
+
+	pixelformat = pix->pixelformat;
+	ret = video_find_format(fmt.format.code, pixelformat,
+				video->formats, video->nformats);
+	if (ret < 0)
+		return ret;
+
+	format->type = video->type;
+
+	return video_mbus_to_pix(&fmt.format, &format->fmt.pix,
+				 &video->formats[ret], video->bpl_alignment);
+}
+
+static int video_check_format(struct stfcamss_video *video)
+{
+	struct v4l2_pix_format *pix = &video->active_fmt.fmt.pix;
+	struct v4l2_format format;
+	struct v4l2_pix_format *sd_pix = &format.fmt.pix;
+	int ret;
+
+	sd_pix->pixelformat = pix->pixelformat;
+	ret = video_get_subdev_format(video, &format);
+	if (ret < 0)
+		return ret;
+
+	if (pix->pixelformat != sd_pix->pixelformat ||
+	    pix->height > sd_pix->height ||
+	    pix->width > sd_pix->width ||
+	    pix->field != format.fmt.pix.field) {
+		st_err(ST_VIDEO,
+		       "%s, not match:\n"
+		       "0x%x 0x%x\n0x%x 0x%x\n0x%x 0x%x\n",
+		       __func__,
+		       pix->pixelformat, sd_pix->pixelformat,
+		       pix->height, sd_pix->height,
+		       pix->field, format.fmt.pix.field);
+		return -EPIPE;
+	}
+
+	return 0;
+}
+
+static int video_start_streaming(struct vb2_queue *q, unsigned int count)
+{
+	struct stfcamss_video *video = vb2_get_drv_priv(q);
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity;
+	struct media_pad *pad;
+	struct v4l2_subdev *subdev;
+	int ret;
+
+	ret = video_device_pipeline_start(vdev, &video->stfcamss->pipe);
+	if (ret < 0) {
+		st_err(ST_VIDEO, "Failed to media_pipeline_start: %d\n", ret);
+		return ret;
+	}
+
+	ret = video_check_format(video);
+	if (ret < 0)
+		goto error;
+	entity = &vdev->entity;
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			break;
+
+		pad = media_pad_remote_pad_first(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			break;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		ret = v4l2_subdev_call(subdev, video, s_stream, 1);
+		if (ret < 0 && ret != -ENOIOCTLCMD)
+			goto error;
+	}
+	return 0;
+
+error:
+	video_device_pipeline_stop(vdev);
+	video->ops->flush_buffers(video, VB2_BUF_STATE_QUEUED);
+	return ret;
+}
+
+static void video_stop_streaming(struct vb2_queue *q)
+{
+	struct stfcamss_video *video = vb2_get_drv_priv(q);
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity;
+	struct media_pad *pad;
+	struct v4l2_subdev *subdev;
+
+	entity = &vdev->entity;
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			break;
+
+		pad = media_pad_remote_pad_first(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			break;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		v4l2_subdev_call(subdev, video, s_stream, 0);
+	}
+
+	video_device_pipeline_stop(vdev);
+	video->ops->flush_buffers(video, VB2_BUF_STATE_ERROR);
+}
+
+static const struct vb2_ops stf_video_vb2_q_ops = {
+	.queue_setup     = video_queue_setup,
+	.wait_prepare    = vb2_ops_wait_prepare,
+	.wait_finish     = vb2_ops_wait_finish,
+	.buf_init        = video_buf_init,
+	.buf_prepare     = video_buf_prepare,
+	.buf_queue       = video_buf_queue,
+	.start_streaming = video_start_streaming,
+	.stop_streaming  = video_stop_streaming,
+};
+
+/* -----------------------------------------------------------------------------
+ * V4L2 ioctls
+ */
+
+static int video_querycap(struct file *file, void *fh,
+			  struct v4l2_capability *cap)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+
+	strscpy(cap->driver, "stf camss", sizeof(cap->driver));
+	strscpy(cap->card, "Starfive Camera Subsystem", sizeof(cap->card));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
+		 dev_name(video->stfcamss->dev));
+	return 0;
+}
+
+static int video_get_pfmt_by_index(struct stfcamss_video *video, int ndx)
+{
+	int i, j, k;
+
+	/* find index "i" of "k"th unique pixelformat in formats array */
+	k = -1;
+	for (i = 0; i < video->nformats; i++) {
+		for (j = 0; j < i; j++) {
+			if (video->formats[i].pixelformat ==
+			    video->formats[j].pixelformat)
+				break;
+		}
+
+		if (j == i)
+			k++;
+
+		if (k == ndx)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int video_get_pfmt_by_mcode(struct stfcamss_video *video, u32 mcode)
+{
+	int i;
+
+	for (i = 0; i < video->nformats; i++) {
+		if (video->formats[i].code == mcode)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int video_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	int i;
+
+	st_debug(ST_VIDEO, "%s:\n0x%x 0x%x\n 0x%x, 0x%x\n0x%x\n",
+		 __func__,
+		 f->type, video->type,
+		 f->index, video->nformats,
+		 f->mbus_code);
+
+	if (f->type != video->type)
+		return -EINVAL;
+	if (f->index >= video->nformats)
+		return -EINVAL;
+
+	if (f->mbus_code) {
+		/* Each entry in formats[] table has unique mbus_code */
+		if (f->index > 0)
+			return -EINVAL;
+
+		i = video_get_pfmt_by_mcode(video, f->mbus_code);
+	} else {
+		i = video_get_pfmt_by_index(video, f->index);
+	}
+
+	if (i < 0)
+		return -EINVAL;
+
+	f->pixelformat = video->formats[i].pixelformat;
+
+	return 0;
+}
+
+static int video_enum_framesizes(struct file *file, void *fh,
+				 struct v4l2_frmsizeenum *fsize)
+{
+	struct v4l2_subdev_frame_size_enum fse = {0};
+	struct v4l2_subdev_mbus_code_enum code = {0};
+	struct stfcamss_video *video = video_drvdata(file);
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity = &vdev->entity;
+	struct media_entity *sensor;
+	struct v4l2_subdev *subdev;
+	struct media_pad *pad;
+	bool support_selection = false;
+	int i;
+	int ret;
+
+	for (i = 0; i < video->nformats; i++) {
+		if (video->formats[i].pixelformat == fsize->pixel_format)
+			break;
+	}
+
+	if (i == video->nformats)
+		return -EINVAL;
+
+	entity = &vdev->entity;
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			break;
+
+		pad = media_pad_remote_pad_first(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			break;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		if (v4l2_subdev_has_op(subdev, pad, set_selection)) {
+			support_selection = true;
+			break;
+		}
+	}
+
+	if (support_selection) {
+		if (fsize->index)
+			return -EINVAL;
+		fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
+		fsize->stepwise.min_width = STFCAMSS_FRAME_MIN_WIDTH;
+		fsize->stepwise.max_width = STFCAMSS_FRAME_MAX_WIDTH;
+		fsize->stepwise.min_height = STFCAMSS_FRAME_MIN_HEIGHT;
+		fsize->stepwise.max_height = STFCAMSS_FRAME_MAX_HEIGHT;
+		fsize->stepwise.step_width = 1;
+		fsize->stepwise.step_height = 1;
+	} else {
+		entity = &vdev->entity;
+		sensor = stfcamss_find_sensor(entity);
+		if (!sensor)
+			return -ENOTTY;
+
+		subdev = media_entity_to_v4l2_subdev(sensor);
+		code.index = 0;
+		code.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+		ret = v4l2_subdev_call(subdev, pad,
+				       enum_mbus_code, NULL, &code);
+		if (ret < 0)
+			return -EINVAL;
+		fse.index = fsize->index;
+		fse.code = code.code;
+		fse.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+		ret = v4l2_subdev_call(subdev, pad,
+				       enum_frame_size, NULL, &fse);
+		if (ret < 0)
+			return -EINVAL;
+		fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
+		fsize->discrete.width = fse.min_width;
+		fsize->discrete.height = fse.min_height;
+	}
+
+	return 0;
+}
+
+static int video_enum_frameintervals(struct file *file, void *fh,
+				     struct v4l2_frmivalenum *fival)
+{
+	int ret = 0;
+	struct stfcamss_video *video = video_drvdata(file);
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity = &vdev->entity;
+	struct media_entity *sensor;
+	struct v4l2_subdev *subdev;
+	struct v4l2_subdev_mbus_code_enum code = {0};
+	struct v4l2_subdev_frame_interval_enum fie = {0};
+
+	sensor = stfcamss_find_sensor(entity);
+	if (!sensor)
+		return -ENOTTY;
+	fie.index = fival->index;
+	fie.width = fival->width;
+	fie.height = fival->height;
+	fie.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+	subdev = media_entity_to_v4l2_subdev(sensor);
+
+	code.index = 0;
+	code.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+
+	ret = video_find_format(0, fival->pixel_format,
+				video->formats, video->nformats);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = v4l2_subdev_call(subdev, pad, enum_mbus_code, NULL, &code);
+	if (ret < 0)
+		return -EINVAL;
+
+	fie.code = code.code;
+	ret = v4l2_subdev_call(subdev, pad, enum_frame_interval, NULL, &fie);
+	if (ret < 0)
+		return ret;
+
+	fival->type = V4L2_FRMIVAL_TYPE_DISCRETE;
+	fival->discrete = fie.interval;
+
+	return 0;
+}
+
+static int video_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+
+	st_debug(ST_VIDEO, "%s, fmt.type = 0x%x\n", __func__, f->type);
+	st_debug(ST_VIDEO, "%s, active_fmt.type = 0x%x,0x%x\n",
+		 __func__, video->active_fmt.type,
+		 video->active_fmt.fmt.pix.pixelformat);
+	*f = video->active_fmt;
+	return 0;
+}
+
+static int video_entity_s_fmt(struct stfcamss_video *video,
+			      struct media_entity *entity,
+			      struct v4l2_subdev_state *state,
+			      struct v4l2_subdev_format *fmt,
+			      u32 dst_code)
+{
+	struct v4l2_subdev *subdev;
+	struct media_pad *pad;
+	struct v4l2_mbus_framefmt *mf = &fmt->format;
+	u32 width, height, code;
+	int ret, index = 0;
+
+	code = mf->code;
+	width = mf->width;
+	height = mf->height;
+	subdev = media_entity_to_v4l2_subdev(entity);
+	while (1) {
+		if (index >= entity->num_pads)
+			break;
+		pad = &entity->pads[index];
+		pad = media_pad_remote_pad_first(pad);
+		if (pad && is_media_entity_v4l2_subdev(pad->entity)) {
+			fmt->pad = index;
+			if (index)
+				mf->code = dst_code;
+			ret = v4l2_subdev_call(subdev, pad,
+					       set_fmt, state, fmt);
+			st_warn(ST_VIDEO,
+				"\"%s\":%d pad fmt set to 0x%x %ux%u\n",
+				subdev->name, fmt->pad, mf->code,
+				mf->width, mf->height);
+			if (mf->code != code ||
+			    mf->width != width ||
+			    mf->height != height) {
+				st_warn(ST_VIDEO,
+					"\"%s\":%d,changed fmt to 0x%x %ux%u\n",
+					subdev->name, fmt->pad, mf->code,
+					mf->width, mf->height);
+			}
+			if (index)
+				ret = video_entity_s_fmt(video, pad->entity,
+							 state, fmt, dst_code);
+		}
+
+		if (ret < 0 && ret != -ENOIOCTLCMD)
+			break;
+		index++;
+	}
+	return ret;
+}
+
+static int video_getcrop_pad_id(int video_id)
+{
+	return stf_vin_map_isp_pad(video_id, STF_ISP_PAD_SRC);
+}
+
+static int video_pipeline_s_fmt(struct stfcamss_video *video,
+				struct v4l2_subdev_state *state,
+				struct v4l2_format *f)
+{
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity = &vdev->entity;
+	struct v4l2_subdev *subdev;
+	int ret, index;
+	struct v4l2_subdev_format fmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.reserved = {video_getcrop_pad_id(video->id)}
+	};
+	struct v4l2_mbus_framefmt *mf = &fmt.format;
+	struct v4l2_pix_format *pix = &f->fmt.pix;
+	struct media_entity *sensor;
+	u32 width, height, code;
+	struct media_pad *pad;
+
+	/* pix to mbus format */
+	index = video_find_format(mf->code,
+				  pix->pixelformat,
+				  video->formats, video->nformats);
+	if (index < 0)
+		return index;
+	v4l2_fill_mbus_format(mf, pix, video->formats[index].code);
+
+	code = mf->code;
+	width = mf->width;
+	height = mf->height;
+	sensor = stfcamss_find_sensor(entity);
+	if (sensor) {
+		subdev = media_entity_to_v4l2_subdev(sensor);
+		ret = v4l2_subdev_call(subdev, pad, set_fmt, state, &fmt);
+		st_warn(ST_VIDEO,
+			"\"%s\":%d pad fmt set to 0x%x %ux%u\n",
+			subdev->name, fmt.pad, mf->code,
+			mf->width, mf->height);
+		if (mf->code != code ||
+		    mf->width != width ||
+		    mf->height != height) {
+			st_warn(ST_VIDEO,
+				"\"%s\":%d, changed fmt to 0x%x %ux%u\n",
+				subdev->name, fmt.pad, mf->code,
+				mf->width, mf->height);
+		}
+	} else {
+		st_err(ST_VIDEO, "Can't find sensor\n");
+		return -ENOTTY;
+	}
+	/*
+	 * Starting from sensor subdevice, walk within
+	 * pipeline and set format on each subdevice
+	 */
+	sensor = stfcamss_find_sensor(entity);
+	pad = media_pad_remote_pad_first(&sensor->pads[0]);
+	ret = video_entity_s_fmt(video, pad->entity, state, &fmt, code);
+
+	if (ret < 0 && ret != -ENOIOCTLCMD)
+		return ret;
+
+	index = video_find_format(mf->code,
+				  video->formats[index].pixelformat,
+				  video->formats, video->nformats);
+	st_debug(ST_VIDEO, "%s, code=%x, index=%d\n",
+		 __func__, mf->code, index);
+
+	if (index < 0)
+		return index;
+
+	video_mbus_to_pix(mf, pix, &video->formats[index],
+			  video->bpl_alignment);
+
+	ret = __video_try_fmt(video, f);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int video_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	int ret;
+
+	st_debug(ST_VIDEO, "%s, fmt.type = 0x%x, v4l2fmt=%x\n",
+		 __func__, f->type, f->fmt.pix.pixelformat);
+
+	if (vb2_is_busy(&video->vb2_q))
+		return -EBUSY;
+
+	ret = __video_try_fmt(video, f);
+	if (ret < 0)
+		return ret;
+
+	ret = video_pipeline_s_fmt(video, NULL, f);
+
+	st_debug(ST_VIDEO, "%s, pixelformat=0x%x, ret=%d\n",
+		 __func__, f->fmt.pix.pixelformat, ret);
+	if (ret < 0)
+		return ret;
+
+	video->active_fmt = *f;
+
+	return 0;
+}
+
+static int video_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+
+	return __video_try_fmt(video, f);
+}
+
+static int video_enum_input(struct file *file, void *fh,
+			    struct v4l2_input *input)
+{
+	if (input->index > 0)
+		return -EINVAL;
+
+	strscpy(input->name, "camera", sizeof(input->name));
+	input->type = V4L2_INPUT_TYPE_CAMERA;
+
+	return 0;
+}
+
+static int video_g_input(struct file *file, void *fh, unsigned int *input)
+{
+	*input = 0;
+
+	return 0;
+}
+
+static int video_s_input(struct file *file, void *fh, unsigned int input)
+{
+	return input == 0 ? 0 : -EINVAL;
+}
+
+static int video_g_parm(struct file *file, void *priv,
+			struct v4l2_streamparm *p)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity;
+	struct v4l2_subdev *subdev;
+	struct media_pad *pad;
+	int ret, is_support = 0;
+
+	entity = &vdev->entity;
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			break;
+
+		pad = media_pad_remote_pad_first(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			break;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		ret = v4l2_g_parm_cap(vdev, subdev, p);
+		if (ret < 0 && ret != -ENOIOCTLCMD)
+			break;
+		if (!ret)
+			is_support = 1;
+	}
+
+	return is_support ? 0 : ret;
+}
+
+static int video_s_parm(struct file *file, void *priv,
+			struct v4l2_streamparm *p)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity;
+	struct v4l2_subdev *subdev;
+	struct media_pad *pad;
+	struct v4l2_streamparm tmp_p;
+	int ret, is_support = 0;
+
+	entity = &vdev->entity;
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			break;
+
+		pad = media_pad_remote_pad_first(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			break;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		tmp_p = *p;
+		ret = v4l2_s_parm_cap(vdev, subdev, &tmp_p);
+		if (ret < 0 && ret != -ENOIOCTLCMD)
+			break;
+		if (!ret) {
+			is_support = 1;
+			*p = tmp_p;
+		}
+	}
+
+	return is_support ? 0 : ret;
+}
+
+static int video_g_selection(struct file *file, void *fh,
+			     struct v4l2_selection *s)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity;
+	struct v4l2_subdev *subdev;
+	struct media_pad *pad;
+	struct v4l2_subdev_selection sel = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = video_getcrop_pad_id(video->id),
+		.target = s->target,
+		.r = s->r,
+		.flags = s->flags,
+	};
+	int ret;
+
+	st_debug(ST_VIDEO, "%s, target = 0x%x, 0x%x\n",
+		 __func__, sel.target, s->target);
+	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
+	    s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return -EINVAL;
+
+	entity = &vdev->entity;
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			break;
+
+		pad = media_pad_remote_pad_first(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			break;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		ret = v4l2_subdev_call(subdev, pad, get_selection, NULL, &sel);
+		if (!ret) {
+			s->r = sel.r;
+			s->flags = sel.flags;
+			break;
+		}
+		if (ret != -ENOIOCTLCMD)
+			break;
+	}
+
+	return ret;
+}
+
+static int video_s_selection(struct file *file, void *fh,
+			     struct v4l2_selection *s)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity;
+	struct v4l2_subdev *subdev;
+	struct media_pad *pad;
+	struct v4l2_subdev_selection sel = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = video_getcrop_pad_id(video->id),
+		.target = s->target,
+		.r = s->r,
+		.flags = s->flags,
+	};
+	struct v4l2_pix_format *format = &video->active_fmt.fmt.pix;
+	int ret;
+
+	st_debug(ST_VIDEO, "%s, target = 0x%x, 0x%x\n",
+		 __func__, sel.target, s->target);
+	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
+	    s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return -EINVAL;
+
+	entity = &vdev->entity;
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			break;
+
+		pad = media_pad_remote_pad_first(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			break;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		ret = v4l2_subdev_call(subdev, pad, set_selection, NULL, &sel);
+		if (!ret) {
+			s->r = sel.r;
+			s->flags = sel.flags;
+			format->width = s->r.width;
+			format->height = s->r.height;
+			ret = __video_try_fmt(video, &video->active_fmt);
+			if (ret < 0)
+				return ret;
+			break;
+		}
+		if (ret != -ENOIOCTLCMD)
+			break;
+	}
+
+	st_debug(ST_VIDEO, "ret = 0x%x, -EINVAL = 0x%x\n", ret, -EINVAL);
+
+	return ret;
+}
+
+static int video_subscribe_event(struct v4l2_fh *fh,
+				 const struct v4l2_event_subscription *sub)
+{
+	struct v4l2_subdev *subdev = NULL;
+	struct media_entity *entity = &fh->vdev->entity;
+	struct media_entity *sensor;
+
+	sensor = stfcamss_find_sensor(entity);
+	if (sensor)
+		subdev = media_entity_to_v4l2_subdev(sensor);
+
+	if (!subdev)
+		return -ENOTTY;
+
+	fh->ctrl_handler = subdev->ctrl_handler;
+	return v4l2_ctrl_subscribe_event(fh, sub);
+}
+
+static int video_unsubscribe_event(struct v4l2_fh *fh,
+				   const struct v4l2_event_subscription *sub)
+{
+	struct v4l2_subdev *subdev = NULL;
+	struct media_entity *entity = &fh->vdev->entity;
+	struct media_entity *sensor;
+
+	sensor = stfcamss_find_sensor(entity);
+	if (sensor)
+		subdev = media_entity_to_v4l2_subdev(sensor);
+
+	if (!subdev)
+		return -ENOTTY;
+
+	fh->ctrl_handler = subdev->ctrl_handler;
+	return v4l2_event_unsubscribe(fh, sub);
+}
+
+static const struct v4l2_ioctl_ops stf_vid_vin_ioctl_ops = {
+	.vidioc_querycap                = video_querycap,
+	.vidioc_enum_fmt_vid_cap        = video_enum_fmt,
+	.vidioc_enum_fmt_vid_out        = video_enum_fmt,
+	.vidioc_enum_framesizes         = video_enum_framesizes,
+	.vidioc_enum_frameintervals     = video_enum_frameintervals,
+	.vidioc_g_fmt_vid_cap           = video_g_fmt,
+	.vidioc_s_fmt_vid_cap           = video_s_fmt,
+	.vidioc_try_fmt_vid_cap         = video_try_fmt,
+	.vidioc_g_fmt_vid_out           = video_g_fmt,
+	.vidioc_s_fmt_vid_out           = video_s_fmt,
+	.vidioc_try_fmt_vid_out         = video_try_fmt,
+	.vidioc_reqbufs                 = vb2_ioctl_reqbufs,
+	.vidioc_querybuf                = vb2_ioctl_querybuf,
+	.vidioc_qbuf                    = vb2_ioctl_qbuf,
+	.vidioc_expbuf                  = vb2_ioctl_expbuf,
+	.vidioc_dqbuf                   = vb2_ioctl_dqbuf,
+	.vidioc_create_bufs             = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf             = vb2_ioctl_prepare_buf,
+	.vidioc_streamon                = vb2_ioctl_streamon,
+	.vidioc_streamoff               = vb2_ioctl_streamoff,
+	.vidioc_enum_input              = video_enum_input,
+	.vidioc_g_input                 = video_g_input,
+	.vidioc_s_input                 = video_s_input,
+	.vidioc_g_parm                  = video_g_parm,
+	.vidioc_s_parm                  = video_s_parm,
+	.vidioc_subscribe_event         = video_subscribe_event,
+	.vidioc_unsubscribe_event       = video_unsubscribe_event,
+};
+
+static const struct v4l2_ioctl_ops stf_vid_isp_ioctl_ops = {
+	.vidioc_querycap                = video_querycap,
+	.vidioc_enum_fmt_vid_cap        = video_enum_fmt,
+	.vidioc_enum_fmt_vid_out        = video_enum_fmt,
+	.vidioc_enum_framesizes         = video_enum_framesizes,
+	.vidioc_enum_frameintervals     = video_enum_frameintervals,
+	.vidioc_g_fmt_vid_cap           = video_g_fmt,
+	.vidioc_s_fmt_vid_cap           = video_s_fmt,
+	.vidioc_try_fmt_vid_cap         = video_try_fmt,
+	.vidioc_g_fmt_vid_out           = video_g_fmt,
+	.vidioc_s_fmt_vid_out           = video_s_fmt,
+	.vidioc_try_fmt_vid_out         = video_try_fmt,
+	.vidioc_reqbufs                 = vb2_ioctl_reqbufs,
+	.vidioc_querybuf                = vb2_ioctl_querybuf,
+	.vidioc_qbuf                    = vb2_ioctl_qbuf,
+	.vidioc_expbuf                  = vb2_ioctl_expbuf,
+	.vidioc_dqbuf                   = vb2_ioctl_dqbuf,
+	.vidioc_create_bufs             = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf             = vb2_ioctl_prepare_buf,
+	.vidioc_streamon                = vb2_ioctl_streamon,
+	.vidioc_streamoff               = vb2_ioctl_streamoff,
+	.vidioc_enum_input              = video_enum_input,
+	.vidioc_g_input                 = video_g_input,
+	.vidioc_s_input                 = video_s_input,
+	.vidioc_g_parm                  = video_g_parm,
+	.vidioc_s_parm                  = video_s_parm,
+	.vidioc_s_selection             = video_s_selection,
+	.vidioc_g_selection             = video_g_selection,
+	.vidioc_subscribe_event         = video_subscribe_event,
+	.vidioc_unsubscribe_event       = video_unsubscribe_event,
+};
+
+/* -----------------------------------------------------------------------------
+ * V4L2 file operations
+ */
+
+static int video_open(struct file *file)
+{
+	struct video_device *vdev = video_devdata(file);
+	struct stfcamss_video *video = video_drvdata(file);
+	struct v4l2_fh *vfh;
+	int ret;
+
+	mutex_lock(&video->lock);
+
+	vfh = kzalloc(sizeof(*vfh), GFP_KERNEL);
+	if (!vfh) {
+		ret = -ENOMEM;
+		goto error_alloc;
+	}
+
+	v4l2_fh_init(vfh, vdev);
+	v4l2_fh_add(vfh);
+
+	file->private_data = vfh;
+
+	ret = v4l2_pipeline_pm_get(&vdev->entity);
+	if (ret < 0) {
+		st_err(ST_VIDEO,
+		       "Failed to power up pipeline: %d\n", ret);
+		goto error_pm_use;
+	}
+	mutex_unlock(&video->lock);
+
+	return 0;
+
+error_pm_use:
+	v4l2_fh_release(file);
+error_alloc:
+	mutex_unlock(&video->lock);
+	return ret;
+}
+
+static int video_release(struct file *file)
+{
+	struct video_device *vdev = video_devdata(file);
+
+	vb2_fop_release(file);
+	v4l2_pipeline_pm_put(&vdev->entity);
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static const struct v4l2_file_operations stf_vid_fops = {
+	.owner          = THIS_MODULE,
+	.unlocked_ioctl = video_ioctl2,
+	.open           = video_open,
+	.release        = video_release,
+	.poll           = vb2_fop_poll,
+	.mmap           = vb2_fop_mmap,
+	.read           = vb2_fop_read,
+};
+
+/* -----------------------------------------------------------------------------
+ * STFCAMSS video core
+ */
+
+static void stf_video_release(struct video_device *vdev)
+{
+	struct stfcamss_video *video = video_get_drvdata(vdev);
+
+	media_entity_cleanup(&vdev->entity);
+
+	mutex_destroy(&video->q_lock);
+	mutex_destroy(&video->lock);
+}
+
+int stf_video_register(struct stfcamss_video *video,
+		       struct v4l2_device *v4l2_dev, const char *name)
+{
+	struct video_device *vdev;
+	struct vb2_queue *q;
+	struct media_pad *pad = &video->pad;
+	int ret;
+	enum isp_pad_id isp_pad;
+
+	vdev = &video->vdev;
+
+	mutex_init(&video->q_lock);
+
+	q = &video->vb2_q;
+	q->drv_priv = video;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->ops = &stf_video_vb2_q_ops;
+	q->type = video->type;
+	q->io_modes = VB2_DMABUF | VB2_MMAP | VB2_READ;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->buf_struct_size = sizeof(struct stfcamss_buffer);
+	q->dev = video->stfcamss->dev;
+	q->lock = &video->q_lock;
+	q->min_buffers_needed = STFCAMSS_MIN_BUFFERS;
+	ret = vb2_queue_init(q);
+	if (ret < 0) {
+		st_err(ST_VIDEO, "Failed to init vb2 queue: %d\n", ret);
+		goto err_vb2_init;
+	}
+
+	pad->flags = MEDIA_PAD_FL_SINK;
+	ret = media_entity_pads_init(&vdev->entity, 1, pad);
+	if (ret < 0) {
+		st_err(ST_VIDEO, "Failed to init video entity: %d\n", ret);
+		goto err_vb2_init;
+	}
+
+	mutex_init(&video->lock);
+
+	isp_pad = stf_vin_map_isp_pad(video->id, STF_ISP_PAD_SRC);
+	if (video->id == VIN_LINE_WR) {
+		video->formats = formats_pix_wr;
+		video->nformats = ARRAY_SIZE(formats_pix_wr);
+		video->bpl_alignment = STFCAMSS_FRAME_WIDTH_ALIGN_8;
+		vdev->ioctl_ops = &stf_vid_vin_ioctl_ops;
+	} else if (isp_pad == STF_ISP_PAD_SRC ||
+		   isp_pad == STF_ISP_PAD_SRC_SS0 ||
+		   isp_pad == STF_ISP_PAD_SRC_SS1) {
+		video->formats = formats_pix_isp;
+		video->nformats = ARRAY_SIZE(formats_pix_isp);
+		video->bpl_alignment = STFCAMSS_FRAME_WIDTH_ALIGN_8;
+		vdev->ioctl_ops = &stf_vid_isp_ioctl_ops;
+	} else {
+		video->formats = formats_raw_isp;
+		video->nformats = ARRAY_SIZE(formats_raw_isp);
+		video->bpl_alignment = STFCAMSS_FRAME_WIDTH_ALIGN_128;
+		vdev->ioctl_ops = &stf_vid_isp_ioctl_ops;
+	}
+
+	ret = stf_video_init_format(video);
+	if (ret < 0) {
+		st_err(ST_VIDEO, "Failed to init format: %d\n", ret);
+		goto err_vid_init_format;
+	}
+
+	vdev->fops = &stf_vid_fops;
+	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE;
+	vdev->vfl_dir = VFL_DIR_RX;
+	vdev->device_caps |= V4L2_CAP_STREAMING | V4L2_CAP_READWRITE;
+	vdev->release = stf_video_release;
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->queue = &video->vb2_q;
+	vdev->lock = &video->lock;
+	strscpy(vdev->name, name, sizeof(vdev->name));
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, video->id);
+	if (ret < 0) {
+		st_err(ST_VIDEO,
+		       "Failed to register video device: %d\n",
+		       ret);
+		goto err_vid_reg;
+	}
+
+	video_set_drvdata(vdev, video);
+	return 0;
+
+err_vid_reg:
+err_vid_init_format:
+	media_entity_cleanup(&vdev->entity);
+	mutex_destroy(&video->lock);
+err_vb2_init:
+	mutex_destroy(&video->q_lock);
+	return ret;
+}
+
+void stf_video_unregister(struct stfcamss_video *video)
+{
+	vb2_video_unregister_device(&video->vdev);
+}
diff --git a/drivers/media/platform/starfive/stf_video.h b/drivers/media/platform/starfive/stf_video.h
new file mode 100644
index 000000000000..b41257cde09a
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_video.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * stf_video.h
+ *
+ * StarFive Camera Subsystem - V4L2 device node
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_VIDEO_H
+#define STF_VIDEO_H
+
+#include <linux/mutex.h>
+#include <linux/videodev2.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-v4l2.h>
+
+#define STFCAMSS_FRAME_MIN_WIDTH		64
+#define STFCAMSS_FRAME_MAX_WIDTH		1920
+#define STFCAMSS_FRAME_MIN_HEIGHT		64
+#define STFCAMSS_FRAME_MAX_HEIGHT		1080
+#define STFCAMSS_FRAME_WIDTH_ALIGN_8		8
+#define STFCAMSS_FRAME_WIDTH_ALIGN_128		128
+#define STFCAMSS_MIN_BUFFERS			2
+
+#define STFCAMSS_MAX_ENTITY_NAME_LEN		27
+
+struct stfcamss_buffer {
+	struct vb2_v4l2_buffer vb;
+	dma_addr_t addr[3];
+	struct list_head queue;
+	int sizeimage;
+};
+
+struct fract {
+	u8 numerator;
+	u8 denominator;
+};
+
+/*
+ * struct stfcamss_format_info - ISP media bus format information
+ * @code: V4L2 media bus format code
+ * @pixelformat: V4L2 pixel format FCC identifier
+ * @planes: Number of planes
+ * @hsub: Horizontal subsampling (for each plane)
+ * @vsub: Vertical subsampling (for each plane)
+ * @bpp: Bits per pixel when stored in memory (for each plane)
+ */
+struct stfcamss_format_info {
+	u32 code;
+	u32 pixelformat;
+	u8 planes;
+	struct fract hsub[3];
+	struct fract vsub[3];
+	u8 bpp[3];
+};
+
+struct stfcamss_video {
+	struct stfcamss *stfcamss;
+	u8 id;
+	struct vb2_queue vb2_q;
+	struct video_device vdev;
+	struct media_pad pad;
+	struct media_pipeline pipe;
+	struct v4l2_format active_fmt;
+	enum v4l2_buf_type type;
+	const struct stfcamss_video_ops *ops;
+	struct mutex lock;	 /* serialize device access */
+	struct mutex q_lock;	 /* protects the queue */
+	unsigned int bpl_alignment;
+	const struct stfcamss_format_info *formats;
+	unsigned int nformats;
+};
+
+struct stfcamss_video_ops {
+	int (*queue_buffer)(struct stfcamss_video *vid,
+			    struct stfcamss_buffer *buf);
+	int (*flush_buffers)(struct stfcamss_video *vid,
+			     enum vb2_buffer_state state);
+};
+
+int stf_video_register(struct stfcamss_video *video,
+		       struct v4l2_device *v4l2_dev, const char *name);
+
+void stf_video_unregister(struct stfcamss_video *video);
+
+#endif /* STF_VIDEO_H */
diff --git a/drivers/media/platform/starfive/stf_vin.c b/drivers/media/platform/starfive/stf_vin.c
new file mode 100644
index 000000000000..38d0e2d74280
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_vin.c
@@ -0,0 +1,1314 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_vin.c
+ *
+ * StarFive Camera Subsystem - VIN Module
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+#include <linux/pm_runtime.h>
+
+#include "stf_camss.h"
+
+#define vin_line_array(ptr_line) \
+	((const struct vin_line (*)[]) &(ptr_line)[-((ptr_line)->id)])
+
+#define line_to_vin_dev(ptr_line) \
+	container_of(vin_line_array(ptr_line), struct stf_vin_dev, line)
+
+#define VIN_FRAME_DROP_MAX_VAL 90
+#define VIN_FRAME_DROP_MIN_VAL 4
+#define VIN_FRAME_PER_SEC_MAX_VAL 90
+
+/* ISP ctrl need 1 sec to let frames become stable. */
+#define VIN_FRAME_DROP_SEC_FOR_ISP_CTRL 1
+
+static const struct vin_format vin_formats_wr[] = {
+	{ MEDIA_BUS_FMT_SRGGB10_1X10, 10},
+	{ MEDIA_BUS_FMT_SGRBG10_1X10, 10},
+	{ MEDIA_BUS_FMT_SGBRG10_1X10, 10},
+	{ MEDIA_BUS_FMT_SBGGR10_1X10, 10},
+};
+
+static const struct vin_format vin_formats_raw[] = {
+	{ MEDIA_BUS_FMT_SBGGR12_1X12, 12},
+	{ MEDIA_BUS_FMT_SRGGB12_1X12, 12},
+	{ MEDIA_BUS_FMT_SGRBG12_1X12, 12},
+	{ MEDIA_BUS_FMT_SGBRG12_1X12, 12},
+};
+
+static const struct vin_format vin_formats_uo[] = {
+	{ MEDIA_BUS_FMT_Y12_1X12, 8},
+};
+
+static const struct vin_format_table vin_formats_table[] = {
+	/* VIN_LINE_WR */
+	{ vin_formats_wr, ARRAY_SIZE(vin_formats_wr) },
+	/* VIN_LINE_ISP */
+	{ vin_formats_uo, ARRAY_SIZE(vin_formats_uo) },
+	/* VIN_LINE_ISP_SS0 */
+	{ vin_formats_uo, ARRAY_SIZE(vin_formats_uo) },
+	/* VIN_LINE_ISP_SS1 */
+	{ vin_formats_uo, ARRAY_SIZE(vin_formats_uo) },
+	/* VIN_LINE_ISP_RAW */
+	{ vin_formats_raw, ARRAY_SIZE(vin_formats_raw) },
+};
+
+static void vin_buffer_done(struct vin_line *line);
+static void vin_change_buffer(struct vin_line *line);
+static struct stfcamss_buffer *vin_buf_get_pending(struct vin_output *output);
+static void vin_output_init_addrs(struct vin_line *line);
+static void vin_init_outputs(struct vin_line *line);
+static struct v4l2_mbus_framefmt *
+__vin_get_format(struct vin_line *line,
+		 struct v4l2_subdev_state *state,
+		 unsigned int pad,
+		 enum v4l2_subdev_format_whence which);
+
+static char *vin_get_line_subdevname(int line_id)
+{
+	char *name = NULL;
+
+	switch (line_id) {
+	case VIN_LINE_WR:
+		name = "wr";
+		break;
+	case VIN_LINE_ISP:
+		name = "isp0";
+		break;
+	case VIN_LINE_ISP_SS0:
+		name = "isp0_ss0";
+		break;
+	case VIN_LINE_ISP_SS1:
+		name = "isp0_ss1";
+		break;
+	case VIN_LINE_ISP_RAW:
+		name = "isp0_raw";
+		break;
+	default:
+		name = "unknown";
+		break;
+	}
+	return name;
+}
+
+static enum isp_line_id vin_map_isp_line(enum vin_line_id line)
+{
+	enum isp_line_id line_id;
+
+	if (line > VIN_LINE_WR && line < VIN_LINE_MAX) {
+		line_id = line % STF_ISP_LINE_MAX;
+		if (line_id == 0)
+			line_id = STF_ISP_LINE_SRC_RAW;
+	} else {
+		line_id = STF_ISP_LINE_INVALID;
+	}
+
+	return line_id;
+}
+
+enum isp_pad_id stf_vin_map_isp_pad(enum vin_line_id line, enum isp_pad_id def)
+{
+	enum isp_pad_id pad_id;
+
+	if (line == VIN_LINE_WR)
+		pad_id = STF_ISP_PAD_SINK;
+	else if ((line > VIN_LINE_WR) && (line < VIN_LINE_MAX))
+		pad_id = vin_map_isp_line(line);
+	else
+		pad_id = def;
+
+	return pad_id;
+}
+
+int stf_vin_subdev_init(struct stfcamss *stfcamss)
+{
+	struct device *dev = stfcamss->dev;
+	struct stf_vin_dev *vin_dev = stfcamss->vin_dev;
+	int i, ret = 0;
+
+	vin_dev->stfcamss = stfcamss;
+	vin_dev->hw_ops = &vin_ops;
+
+	vin_dev->isr_ops = devm_kzalloc(dev, sizeof(*vin_dev->isr_ops),
+					GFP_KERNEL);
+	if (!vin_dev->isr_ops)
+		return -ENOMEM;
+	vin_dev->isr_ops->isr_buffer_done = vin_buffer_done;
+	vin_dev->isr_ops->isr_change_buffer = vin_change_buffer;
+
+	atomic_set(&vin_dev->ref_count, 0);
+
+	ret = devm_request_irq(dev,
+			       stfcamss->irq,
+			       vin_dev->hw_ops->vin_wr_irq_handler,
+			       0, "vin_axiwr_irq", vin_dev);
+	if (ret) {
+		st_err(ST_VIN, "failed to request irq\n");
+		goto out;
+	}
+
+	ret = devm_request_irq(dev,
+			       stfcamss->isp_irq,
+			       vin_dev->hw_ops->vin_isp_irq_handler,
+			       0, "vin_isp_irq", vin_dev);
+	if (ret) {
+		st_err(ST_VIN, "failed to request isp irq\n");
+		goto out;
+	}
+
+	ret = devm_request_irq(dev,
+			       stfcamss->isp_irq_csi,
+			       vin_dev->hw_ops->vin_isp_irq_csi_handler,
+			       0, "vin_isp_irq_csi", vin_dev);
+	if (ret) {
+		st_err(ST_VIN, "failed to request isp raw irq\n");
+		goto out;
+	}
+
+	ret = devm_request_irq(dev,
+			       stfcamss->isp_irq_csiline,
+			       vin_dev->hw_ops->vin_isp_irq_csiline_handler,
+			       0, "vin_isp_irq_csiline", vin_dev);
+	if (ret) {
+		st_err(ST_VIN, "failed to request isp irq csiline\n");
+		goto out;
+	}
+
+	mutex_init(&vin_dev->power_lock);
+	vin_dev->power_count = 0;
+
+	for (i = 0; i < STF_DUMMY_MODULE_NUMS; i++) {
+		struct dummy_buffer *dummy_buffer = &vin_dev->dummy_buffer[i];
+
+		mutex_init(&dummy_buffer->stream_lock);
+		dummy_buffer->nums =
+			i == 0 ? VIN_DUMMY_BUFFER_NUMS : ISP_DUMMY_BUFFER_NUMS;
+		dummy_buffer->stream_count = 0;
+		dummy_buffer->buffer =
+			devm_kzalloc(dev,
+				     dummy_buffer->nums * sizeof(struct vin_dummy_buffer),
+				     GFP_KERNEL);
+		atomic_set(&dummy_buffer->frame_skip, 0);
+	}
+
+	for (i = VIN_LINE_WR;
+		i < STF_ISP_LINE_MAX + 1; i++) {
+		struct vin_line *l = &vin_dev->line[i];
+
+		l->video_out.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		l->video_out.stfcamss = stfcamss;
+		l->id = i;
+		l->sdev_type = SUBDEV_TYPE_VIN;
+		l->formats = vin_formats_table[i].fmts;
+		l->nformats = vin_formats_table[i].nfmts;
+		spin_lock_init(&l->output_lock);
+
+		mutex_init(&l->stream_lock);
+		l->stream_count = 0;
+		mutex_init(&l->power_lock);
+		l->power_count = 0;
+	}
+
+	return 0;
+out:
+	return ret;
+}
+
+static enum link vin_get_link(struct media_entity *entity)
+{
+	struct v4l2_subdev *subdev;
+	struct media_pad *pad;
+	bool isp = false;
+
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			return LINK_ERROR;
+
+		pad = media_pad_remote_pad_first(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			return LINK_ERROR;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		if (!strncmp(subdev->name, STF_CSI_NAME,
+			     strlen(STF_CSI_NAME))) {
+			if (isp)
+				return LINK_CSI_TO_ISP;
+			else
+				return LINK_CSI_TO_WR;
+		} else if (!strncmp(subdev->name, STF_DVP_NAME,
+				    strlen(STF_DVP_NAME))) {
+			if (isp)
+				return LINK_DVP_TO_ISP;
+			else
+				return LINK_DVP_TO_WR;
+		} else if (!strncmp(subdev->name, STF_ISP_NAME,
+				    strlen(STF_ISP_NAME))) {
+			isp = true;
+		} else {
+			return LINK_ERROR;
+		}
+	}
+}
+
+static int vin_set_power(struct v4l2_subdev *sd, int on)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+	struct stf_vin_dev *vin_dev = line_to_vin_dev(line);
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+	enum link link;
+
+	mutex_lock(&line->power_lock);
+	if (on) {
+		if (line->power_count == 0)
+			vin_init_outputs(line);
+		line->power_count++;
+	} else {
+		if (line->power_count == 0) {
+			st_err(ST_VIN, "line power off on power_count = 0\n");
+			goto exit_line;
+		}
+		line->power_count--;
+	}
+exit_line:
+	mutex_unlock(&line->power_lock);
+
+	mutex_lock(&vin_dev->power_lock);
+	link = vin_get_link(&sd->entity);
+	if (link == LINK_ERROR)
+		goto exit;
+
+	if (on) {
+		if (vin_dev->power_count == 0) {
+			pm_runtime_get_sync(stfcamss->dev);
+			vin_dev->hw_ops->vin_clk_enable(vin_dev, link);
+		}
+		vin_dev->power_count++;
+	} else {
+		if (vin_dev->power_count == 0) {
+			st_err(ST_VIN, "vin_dev power off on power_count=0\n");
+			goto exit;
+		}
+		if (vin_dev->power_count == 1) {
+			vin_dev->hw_ops->vin_clk_disable(vin_dev, link);
+			pm_runtime_put_sync(stfcamss->dev);
+		}
+		vin_dev->power_count--;
+	}
+exit:
+
+	mutex_unlock(&vin_dev->power_lock);
+
+	return 0;
+}
+
+static unsigned int vin_get_frame_skip(struct vin_line *line)
+{
+	unsigned int frame_skip = 0;
+	unsigned int isp_ctrl_skip_frames = 0;
+	struct media_entity *sensor;
+	struct v4l2_subdev_frame_interval fi = {
+		.pad = 0,
+	};
+
+	sensor = stfcamss_find_sensor(&line->subdev.entity);
+	if (sensor) {
+		int fps = 0;
+		struct v4l2_subdev *subdev =
+			media_entity_to_v4l2_subdev(sensor);
+
+		v4l2_subdev_call(subdev, video, g_frame_interval, &fi);
+		fps = fi.interval.denominator;
+
+		if (fps > 0 && fps <= 90)
+			isp_ctrl_skip_frames =
+				fps * VIN_FRAME_DROP_SEC_FOR_ISP_CTRL;
+
+		if (!fps)
+			st_debug(ST_VIN,
+				 "%s, Failed to get sensor fps !\n", __func__);
+
+		if (isp_ctrl_skip_frames <= VIN_FRAME_DROP_MIN_VAL)
+			isp_ctrl_skip_frames = VIN_FRAME_DROP_MIN_VAL;
+
+		v4l2_subdev_call(subdev, sensor, g_skip_frames, &frame_skip);
+
+		frame_skip += isp_ctrl_skip_frames;
+
+		if (frame_skip > VIN_FRAME_DROP_MAX_VAL)
+			frame_skip = VIN_FRAME_DROP_MAX_VAL;
+		st_debug(ST_VIN, "%s, frame_skip %d\n", __func__, frame_skip);
+	}
+
+	return frame_skip;
+}
+
+static int vin_enable_output(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+	unsigned long flags;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	output->state = VIN_OUTPUT_IDLE;
+
+	output->buf[0] = vin_buf_get_pending(output);
+
+	if (!output->buf[0] && output->buf[1]) {
+		output->buf[0] = output->buf[1];
+		output->buf[1] = NULL;
+	}
+
+	if (output->buf[0])
+		output->state = VIN_OUTPUT_SINGLE;
+
+	output->sequence = 0;
+
+	vin_output_init_addrs(line);
+	spin_unlock_irqrestore(&line->output_lock, flags);
+	return 0;
+}
+
+static int vin_disable_output(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+	unsigned long flags;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	output->state = VIN_OUTPUT_OFF;
+
+	spin_unlock_irqrestore(&line->output_lock, flags);
+	return 0;
+}
+
+static u32 vin_line_to_dummy_module(struct vin_line *line)
+{
+	u32 dummy_module = 0;
+
+	switch (line->id) {
+	case VIN_LINE_WR:
+		dummy_module = STF_DUMMY_VIN;
+		break;
+	case VIN_LINE_ISP:
+	case VIN_LINE_ISP_SS0:
+	case VIN_LINE_ISP_SS1:
+	case VIN_LINE_ISP_RAW:
+		dummy_module = STF_DUMMY_ISP;
+		break;
+	default:
+		dummy_module = STF_DUMMY_VIN;
+		break;
+	}
+
+	return dummy_module;
+}
+
+static int vin_alloc_dummy_buffer(struct stf_vin_dev *vin_dev,
+				  struct v4l2_mbus_framefmt *fmt,
+				  int dummy_module)
+{
+	struct device *dev = vin_dev->stfcamss->dev;
+	struct dummy_buffer *dummy_buffer =
+				&vin_dev->dummy_buffer[dummy_module];
+	struct vin_dummy_buffer *buffer = NULL;
+	int ret = 0, i;
+	u32 aligns;
+
+	for (i = 0; i < dummy_buffer->nums; i++) {
+		buffer = &vin_dev->dummy_buffer[dummy_module].buffer[i];
+		buffer->width = fmt->width;
+		buffer->height = fmt->height;
+		buffer->mcode = fmt->code;
+		if (i == STF_VIN_PAD_SINK) {
+			aligns = ALIGN(fmt->width * 4,
+				       STFCAMSS_FRAME_WIDTH_ALIGN_8);
+			buffer->buffer_size = PAGE_ALIGN(aligns * fmt->height);
+		} else if (i == STF_ISP_PAD_SRC ||
+			   i == STF_ISP_PAD_SRC_SS0 ||
+			   i == STF_ISP_PAD_SRC_SS1) {
+			aligns = ALIGN(fmt->width,
+				       STFCAMSS_FRAME_WIDTH_ALIGN_8);
+			buffer->buffer_size =
+				PAGE_ALIGN(aligns * fmt->height * 3 / 2);
+		} else if (i == STF_ISP_PAD_SRC_RAW) {
+			aligns = ALIGN(fmt->width * ISP_RAW_DATA_BITS / 8,
+				       STFCAMSS_FRAME_WIDTH_ALIGN_128);
+			buffer->buffer_size = PAGE_ALIGN(aligns * fmt->height);
+		} else {
+			continue;
+		}
+
+		buffer->vaddr = dma_alloc_coherent(dev,
+						   buffer->buffer_size,
+						   &buffer->paddr[0],
+						   GFP_DMA | GFP_KERNEL);
+
+		if (buffer->vaddr) {
+			if (i == STF_ISP_PAD_SRC ||
+			    i == STF_ISP_PAD_SRC_SS0 ||
+			    i == STF_ISP_PAD_SRC_SS1)
+				buffer->paddr[1] =
+					(dma_addr_t)(buffer->paddr[0] + aligns * fmt->height);
+			else
+				st_debug(ST_VIN, "signal plane\n");
+		}
+	}
+
+	return ret;
+}
+
+static void vin_free_dummy_buffer(struct stf_vin_dev *vin_dev, int dummy_module)
+{
+	struct device *dev = vin_dev->stfcamss->dev;
+	struct dummy_buffer *dummy_buffer =
+		&vin_dev->dummy_buffer[dummy_module];
+	struct vin_dummy_buffer *buffer = NULL;
+	int i;
+
+	for (i = 0; i < dummy_buffer->nums; i++) {
+		buffer = &dummy_buffer->buffer[i];
+		if (buffer->vaddr)
+			dma_free_coherent(dev, buffer->buffer_size,
+					  buffer->vaddr, buffer->paddr[0]);
+		memset(buffer, 0, sizeof(struct vin_dummy_buffer));
+	}
+}
+
+static void vin_set_dummy_buffer(struct vin_line *line, u32 pad)
+{
+	struct stf_vin_dev *vin_dev = line_to_vin_dev(line);
+	int dummy_module = vin_line_to_dummy_module(line);
+	struct dummy_buffer *dummy_buffer =
+		&vin_dev->dummy_buffer[dummy_module];
+	struct vin_dummy_buffer *buffer = NULL;
+
+	switch (pad) {
+	case STF_VIN_PAD_SINK:
+		if (line->id == VIN_LINE_WR) {
+			buffer = &dummy_buffer->buffer[STF_VIN_PAD_SINK];
+			vin_dev->hw_ops->vin_wr_set_ping_addr(vin_dev,
+							      buffer->paddr[0]);
+			vin_dev->hw_ops->vin_wr_set_pong_addr(vin_dev,
+							      buffer->paddr[0]);
+		} else {
+			buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC];
+			vin_dev->hw_ops->vin_isp_set_yuv_addr(vin_dev,
+							      buffer->paddr[0],
+							      buffer->paddr[1]);
+
+			buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC_SS0];
+			vin_dev->hw_ops->vin_isp_set_ss0_addr(vin_dev,
+							      buffer->paddr[0],
+							      buffer->paddr[1]);
+
+			buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC_SS1];
+			vin_dev->hw_ops->vin_isp_set_ss1_addr(vin_dev,
+							      buffer->paddr[0],
+							      buffer->paddr[1]);
+
+			buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC_RAW];
+			vin_dev->hw_ops->vin_isp_set_raw_addr(vin_dev,
+							      buffer->paddr[0]);
+		}
+		break;
+	case STF_ISP_PAD_SRC:
+		buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC];
+		vin_dev->hw_ops->vin_isp_set_yuv_addr(vin_dev,
+						      buffer->paddr[0],
+						      buffer->paddr[1]);
+		break;
+	case STF_ISP_PAD_SRC_SS0:
+		buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC_SS0];
+		vin_dev->hw_ops->vin_isp_set_ss0_addr(vin_dev,
+						      buffer->paddr[0],
+						      buffer->paddr[1]);
+		break;
+	case STF_ISP_PAD_SRC_SS1:
+		buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC_SS1];
+		vin_dev->hw_ops->vin_isp_set_ss1_addr(vin_dev,
+						      buffer->paddr[0],
+						      buffer->paddr[1]);
+		break;
+	case STF_ISP_PAD_SRC_RAW:
+		buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC_RAW];
+		vin_dev->hw_ops->vin_isp_set_raw_addr(vin_dev,
+						      buffer->paddr[0]);
+		break;
+	default:
+		break;
+	}
+}
+
+static int vin_set_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+	struct stf_vin_dev *vin_dev = line_to_vin_dev(line);
+	int dummy_module = vin_line_to_dummy_module(line);
+	struct dummy_buffer *dummy_buffer =
+		&vin_dev->dummy_buffer[dummy_module];
+	struct v4l2_mbus_framefmt *fmt;
+	struct media_entity *sensor;
+	struct v4l2_subdev *sensor_sd;
+	struct v4l2_subdev_format sensor_fmt;
+	enum link link;
+	int ret;
+
+	sensor = stfcamss_find_sensor(&line->subdev.entity);
+	if (!sensor)
+		return -EINVAL;
+
+	sensor_sd = media_entity_to_v4l2_subdev(sensor);
+
+	sensor_fmt.pad = 0;
+	sensor_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+	ret = v4l2_subdev_call(sensor_sd, pad, get_fmt, NULL, &sensor_fmt);
+	if (ret) {
+		st_warn(ST_VIN, "Sensor get format failed !!\n");
+		return -EINVAL;
+	}
+
+	fmt = __vin_get_format(line, NULL,
+			       STF_VIN_PAD_SINK, V4L2_SUBDEV_FORMAT_ACTIVE);
+	mutex_lock(&dummy_buffer->stream_lock);
+	if (enable) {
+		if (dummy_buffer->stream_count == 0) {
+			vin_alloc_dummy_buffer(vin_dev, fmt, dummy_module);
+			vin_set_dummy_buffer(line, STF_VIN_PAD_SINK);
+			atomic_set(&dummy_buffer->frame_skip,
+				   vin_get_frame_skip(line));
+		}
+		dummy_buffer->stream_count++;
+	} else {
+		if (dummy_buffer->stream_count == 1) {
+			vin_free_dummy_buffer(vin_dev, dummy_module);
+			/* set buffer addr to zero */
+			vin_set_dummy_buffer(line, STF_VIN_PAD_SINK);
+		} else {
+			vin_set_dummy_buffer(line,
+				stf_vin_map_isp_pad(line->id, STF_ISP_PAD_SINK));
+		}
+
+		dummy_buffer->stream_count--;
+	}
+	mutex_unlock(&dummy_buffer->stream_lock);
+
+	mutex_lock(&line->stream_lock);
+	link = vin_get_link(&sd->entity);
+	if (link == LINK_ERROR)
+		goto exit;
+
+	if (enable) {
+		if (line->stream_count == 0) {
+			vin_dev->hw_ops->vin_stream_set(vin_dev, 1,
+							sensor_fmt, link);
+			if (line->id == VIN_LINE_WR) {
+				vin_dev->hw_ops->vin_wr_irq_enable(vin_dev, 1);
+				vin_dev->hw_ops->vin_wr_stream_set(vin_dev, 1);
+			}
+		}
+		line->stream_count++;
+	} else {
+		if (line->stream_count == 1) {
+			if (line->id == VIN_LINE_WR) {
+				vin_dev->hw_ops->vin_wr_irq_enable(vin_dev, 0);
+				vin_dev->hw_ops->vin_wr_stream_set(vin_dev, 0);
+			}
+			vin_dev->hw_ops->vin_stream_set(vin_dev, 0,
+							sensor_fmt, link);
+		}
+		line->stream_count--;
+	}
+exit:
+	mutex_unlock(&line->stream_lock);
+
+	if (enable)
+		vin_enable_output(line);
+	else
+		vin_disable_output(line);
+
+	return 0;
+}
+
+static struct v4l2_mbus_framefmt *
+__vin_get_format(struct vin_line *line,
+		 struct v4l2_subdev_state *state,
+		 unsigned int pad,
+		 enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&line->subdev, state, pad);
+	return &line->fmt[pad];
+}
+
+static void vin_try_format(struct vin_line *line,
+			   struct v4l2_subdev_state *state,
+			   unsigned int pad,
+			   struct v4l2_mbus_framefmt *fmt,
+			   enum v4l2_subdev_format_whence which)
+{
+	unsigned int i;
+
+	switch (pad) {
+	case STF_VIN_PAD_SINK:
+		/* Set format on sink pad */
+		for (i = 0; i < line->nformats; i++)
+			if (fmt->code == line->formats[i].code)
+				break;
+
+		/* If not found, use UYVY as default */
+		if (i >= line->nformats)
+			fmt->code = line->formats[0].code;
+
+		fmt->width = clamp_t(u32, fmt->width,
+				     STFCAMSS_FRAME_MIN_WIDTH,
+				     STFCAMSS_FRAME_MAX_WIDTH);
+		fmt->height = clamp_t(u32, fmt->height,
+				      STFCAMSS_FRAME_MIN_HEIGHT,
+				      STFCAMSS_FRAME_MAX_HEIGHT);
+
+		fmt->field = V4L2_FIELD_NONE;
+		fmt->colorspace = V4L2_COLORSPACE_SRGB;
+		fmt->flags = 0;
+		break;
+
+	case STF_VIN_PAD_SRC:
+		/* Set and return a format same as sink pad */
+		*fmt = *__vin_get_format(line, state, STF_VIN_PAD_SINK, which);
+		break;
+	}
+
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+}
+
+static int vin_enum_mbus_code(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *state,
+			      struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+
+	if (code->index >= line->nformats)
+		return -EINVAL;
+	if (code->pad == STF_VIN_PAD_SINK) {
+		code->code = line->formats[code->index].code;
+	} else {
+		struct v4l2_mbus_framefmt *sink_fmt;
+
+		sink_fmt = __vin_get_format(line, state, STF_VIN_PAD_SINK,
+					    code->which);
+
+		code->code = sink_fmt->code;
+		if (!code->code)
+			return -EINVAL;
+	}
+	code->flags = 0;
+
+	return 0;
+}
+
+static int vin_enum_frame_size(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *state,
+			       struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt format;
+
+	if (fse->index != 0)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = 1;
+	format.height = 1;
+	vin_try_format(line, state, fse->pad, &format, fse->which);
+	fse->min_width = format.width;
+	fse->min_height = format.height;
+
+	if (format.code != fse->code)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = -1;
+	format.height = -1;
+	vin_try_format(line, state, fse->pad, &format, fse->which);
+	fse->max_width = format.width;
+	fse->max_height = format.height;
+
+	return 0;
+}
+
+static int vin_get_format(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __vin_get_format(line, state, fmt->pad, fmt->which);
+	if (!format)
+		return -EINVAL;
+
+	fmt->format = *format;
+
+	return 0;
+}
+
+static int vin_set_format(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	st_debug(ST_VIDEO, "%s, pad %d, fmt code  %x\n",
+		 __func__, fmt->pad, fmt->format.code);
+
+	format = __vin_get_format(line, state, fmt->pad, fmt->which);
+	if (!format)
+		return -EINVAL;
+
+	mutex_lock(&line->stream_lock);
+	if (line->stream_count) {
+		fmt->format = *format;
+		mutex_unlock(&line->stream_lock);
+		goto out;
+	} else {
+		vin_try_format(line, state, fmt->pad, &fmt->format, fmt->which);
+		*format = fmt->format;
+	}
+	mutex_unlock(&line->stream_lock);
+
+	if (fmt->pad == STF_VIN_PAD_SINK) {
+		/* Propagate the format from sink to source */
+		format = __vin_get_format(line, state, STF_VIN_PAD_SRC,
+					  fmt->which);
+
+		*format = fmt->format;
+		vin_try_format(line, state, STF_VIN_PAD_SRC, format,
+			       fmt->which);
+	}
+
+out:
+	return 0;
+}
+
+static int vin_init_formats(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_fh *fh)
+{
+	struct v4l2_subdev_format format = {
+		.pad = STF_VIN_PAD_SINK,
+		.which = fh ?
+			 V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_RGB565_2X8_LE,
+			.width = 1920,
+			.height = 1080
+		}
+	};
+
+	return vin_set_format(sd, fh ? fh->state : NULL, &format);
+}
+
+static void vin_output_init_addrs(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+	struct stf_vin_dev *vin_dev = line_to_vin_dev(line);
+	dma_addr_t ping_addr;
+	dma_addr_t pong_addr;
+	dma_addr_t y_addr, uv_addr;
+
+	output->active_buf = 0;
+
+	if (output->buf[0]) {
+		ping_addr = output->buf[0]->addr[0];
+		y_addr = output->buf[0]->addr[0];
+		uv_addr = output->buf[0]->addr[1];
+	} else {
+		return;
+	}
+
+	if (output->buf[1])
+		pong_addr = output->buf[1]->addr[0];
+	else
+		pong_addr = ping_addr;
+
+	switch (vin_map_isp_line(line->id)) {
+	case STF_ISP_LINE_SRC:
+		vin_dev->hw_ops->vin_isp_set_yuv_addr(vin_dev, y_addr, uv_addr);
+		break;
+	case STF_ISP_LINE_SRC_SS0:
+		vin_dev->hw_ops->vin_isp_set_ss0_addr(vin_dev, y_addr, uv_addr);
+		break;
+	case STF_ISP_LINE_SRC_SS1:
+		vin_dev->hw_ops->vin_isp_set_ss1_addr(vin_dev, y_addr, uv_addr);
+		break;
+	case STF_ISP_LINE_SRC_RAW:
+		vin_dev->hw_ops->vin_isp_set_raw_addr(vin_dev, y_addr);
+		break;
+	default:
+		if (line->id == VIN_LINE_WR) {
+			vin_dev->hw_ops->vin_wr_set_ping_addr(vin_dev,
+							      ping_addr);
+			vin_dev->hw_ops->vin_wr_set_pong_addr(vin_dev,
+							      ping_addr);
+		}
+		break;
+	}
+}
+
+static void vin_init_outputs(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+
+	output->state = VIN_OUTPUT_OFF;
+	output->buf[0] = NULL;
+	output->buf[1] = NULL;
+	output->active_buf = 0;
+	INIT_LIST_HEAD(&output->pending_bufs);
+	INIT_LIST_HEAD(&output->ready_bufs);
+}
+
+static void vin_buf_add_ready(struct vin_output *output,
+			      struct stfcamss_buffer *buffer)
+{
+	INIT_LIST_HEAD(&buffer->queue);
+	list_add_tail(&buffer->queue, &output->ready_bufs);
+}
+
+static struct stfcamss_buffer *vin_buf_get_ready(struct vin_output *output)
+{
+	struct stfcamss_buffer *buffer = NULL;
+
+	if (!list_empty(&output->ready_bufs)) {
+		buffer = list_first_entry(&output->ready_bufs,
+					  struct stfcamss_buffer,
+					  queue);
+		list_del(&buffer->queue);
+	}
+
+	return buffer;
+}
+
+static void vin_buf_add_pending(struct vin_output *output,
+				struct stfcamss_buffer *buffer)
+{
+	INIT_LIST_HEAD(&buffer->queue);
+	list_add_tail(&buffer->queue, &output->pending_bufs);
+}
+
+static struct stfcamss_buffer *vin_buf_get_pending(struct vin_output *output)
+{
+	struct stfcamss_buffer *buffer = NULL;
+
+	if (!list_empty(&output->pending_bufs)) {
+		buffer = list_first_entry(&output->pending_bufs,
+					  struct stfcamss_buffer,
+					  queue);
+		list_del(&buffer->queue);
+	}
+
+	return buffer;
+}
+
+static void vin_buf_update_on_last(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+
+	switch (output->state) {
+	case VIN_OUTPUT_CONTINUOUS:
+		output->state = VIN_OUTPUT_SINGLE;
+		output->active_buf = !output->active_buf;
+		break;
+	case VIN_OUTPUT_SINGLE:
+		output->state = VIN_OUTPUT_STOPPING;
+		break;
+	default:
+		st_err_ratelimited(ST_VIN, "Last buff in wrong state! %d\n",
+				   output->state);
+		break;
+	}
+}
+
+static void vin_buf_update_on_next(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+
+	switch (output->state) {
+	case VIN_OUTPUT_CONTINUOUS:
+		output->active_buf = !output->active_buf;
+		break;
+	case VIN_OUTPUT_SINGLE:
+	default:
+		break;
+	}
+}
+
+static void vin_buf_update_on_new(struct vin_line *line,
+				  struct vin_output *output,
+				  struct stfcamss_buffer *new_buf)
+{
+	switch (output->state) {
+	case VIN_OUTPUT_SINGLE:
+		vin_buf_add_pending(output, new_buf);
+		break;
+	case VIN_OUTPUT_IDLE:
+		st_warn(ST_VIN,	"Output idle buffer set!\n");
+		if (!output->buf[0]) {
+			output->buf[0] = new_buf;
+			vin_output_init_addrs(line);
+			output->state = VIN_OUTPUT_SINGLE;
+		} else {
+			vin_buf_add_pending(output, new_buf);
+			st_warn(ST_VIN,	"Output idle with buffer set!\n");
+		}
+		break;
+	case VIN_OUTPUT_STOPPING:
+		if (output->last_buffer) {
+			output->buf[output->active_buf] = output->last_buffer;
+			output->last_buffer = NULL;
+		} else {
+			st_err(ST_VIN,	"stop state lost lastbuffer!\n");
+		}
+		output->state = VIN_OUTPUT_SINGLE;
+		vin_buf_add_pending(output, new_buf);
+		break;
+	case VIN_OUTPUT_CONTINUOUS:
+	default:
+		vin_buf_add_pending(output, new_buf);
+		break;
+	}
+}
+
+static void vin_buf_flush(struct vin_output *output,
+			  enum vb2_buffer_state state)
+{
+	struct stfcamss_buffer *buf;
+	struct stfcamss_buffer *t;
+
+	list_for_each_entry_safe(buf, t, &output->pending_bufs, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		list_del(&buf->queue);
+	}
+	list_for_each_entry_safe(buf, t, &output->ready_bufs, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		list_del(&buf->queue);
+	}
+}
+
+static void vin_buffer_done(struct vin_line *line)
+{
+	struct stfcamss_buffer *ready_buf;
+	struct vin_output *output = &line->output;
+	unsigned long flags;
+	u64 ts = ktime_get_ns();
+
+	if (output->state == VIN_OUTPUT_OFF ||
+	    output->state == VIN_OUTPUT_RESERVED)
+		return;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	while ((ready_buf = vin_buf_get_ready(output))) {
+		ready_buf->vb.vb2_buf.timestamp = ts;
+		ready_buf->vb.sequence = output->sequence++;
+
+		vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+	}
+
+	spin_unlock_irqrestore(&line->output_lock, flags);
+}
+
+static void vin_change_buffer(struct vin_line *line)
+{
+	struct stfcamss_buffer *ready_buf;
+	struct vin_output *output = &line->output;
+	struct stf_vin_dev *vin_dev = line_to_vin_dev(line);
+	dma_addr_t *new_addr;
+	unsigned long flags;
+	u32 active_index;
+
+	if (output->state == VIN_OUTPUT_OFF ||
+	    output->state == VIN_OUTPUT_STOPPING ||
+	    output->state == VIN_OUTPUT_RESERVED ||
+	    output->state == VIN_OUTPUT_IDLE)
+		return;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	active_index = output->active_buf;
+
+	ready_buf = output->buf[active_index];
+	if (!ready_buf) {
+		st_err_ratelimited(ST_VIN, "Missing ready buf %d %d!\n",
+				   active_index, output->state);
+		active_index = !active_index;
+		ready_buf = output->buf[active_index];
+		if (!ready_buf) {
+			st_err_ratelimited(ST_VIN, "Missing ready buf2 %d %d!\n",
+					   active_index, output->state);
+			goto out_unlock;
+		}
+	}
+
+	/* Get next buffer */
+	output->buf[active_index] = vin_buf_get_pending(output);
+	if (!output->buf[active_index]) {
+		/* No next buffer - set same address */
+		new_addr = ready_buf->addr;
+		vin_buf_update_on_last(line);
+	} else {
+		new_addr = output->buf[active_index]->addr;
+		vin_buf_update_on_next(line);
+	}
+
+	if (output->state == VIN_OUTPUT_STOPPING) {
+		output->last_buffer = ready_buf;
+	} else {
+		switch (vin_map_isp_line(line->id)) {
+		case STF_ISP_LINE_SRC:
+			vin_dev->hw_ops->vin_isp_set_yuv_addr(vin_dev,
+							      new_addr[0],
+							      new_addr[1]);
+			break;
+		case STF_ISP_LINE_SRC_SS0:
+			vin_dev->hw_ops->vin_isp_set_ss0_addr(vin_dev,
+							      new_addr[0],
+							      new_addr[1]);
+			break;
+		case STF_ISP_LINE_SRC_SS1:
+			vin_dev->hw_ops->vin_isp_set_ss1_addr(vin_dev,
+							      new_addr[0],
+							      new_addr[1]);
+			break;
+		case STF_ISP_LINE_SRC_RAW:
+			vin_dev->hw_ops->vin_isp_set_raw_addr(vin_dev,
+							      new_addr[0]);
+			break;
+		default:
+			if (line->id == VIN_LINE_WR) {
+				vin_dev->hw_ops->vin_wr_set_ping_addr(vin_dev,
+								new_addr[0]);
+				vin_dev->hw_ops->vin_wr_set_pong_addr(vin_dev,
+								new_addr[0]);
+			}
+			break;
+		}
+
+		vin_buf_add_ready(output, ready_buf);
+	}
+
+	spin_unlock_irqrestore(&line->output_lock, flags);
+	return;
+
+out_unlock:
+	spin_unlock_irqrestore(&line->output_lock, flags);
+}
+
+static int vin_queue_buffer(struct stfcamss_video *vid,
+			    struct stfcamss_buffer *buf)
+{
+	struct vin_line *line = container_of(vid, struct vin_line, video_out);
+	struct vin_output *output;
+	unsigned long flags;
+
+	output = &line->output;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	vin_buf_update_on_new(line, output, buf);
+
+	spin_unlock_irqrestore(&line->output_lock, flags);
+
+	return 0;
+}
+
+static int vin_flush_buffers(struct stfcamss_video *vid,
+			     enum vb2_buffer_state state)
+{
+	struct vin_line *line = container_of(vid, struct vin_line, video_out);
+	struct vin_output *output = &line->output;
+	unsigned long flags;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	vin_buf_flush(output, state);
+	if (output->buf[0])
+		vb2_buffer_done(&output->buf[0]->vb.vb2_buf, state);
+
+	if (output->buf[1])
+		vb2_buffer_done(&output->buf[1]->vb.vb2_buf, state);
+
+	if (output->last_buffer) {
+		vb2_buffer_done(&output->last_buffer->vb.vb2_buf, state);
+		output->last_buffer = NULL;
+	}
+	output->buf[0] = NULL;
+	output->buf[1] = NULL;
+
+	spin_unlock_irqrestore(&line->output_lock, flags);
+	return 0;
+}
+
+static int vin_link_setup(struct media_entity *entity,
+			  const struct media_pad *local,
+			  const struct media_pad *remote, u32 flags)
+{
+	if (flags & MEDIA_LNK_FL_ENABLED)
+		if (media_pad_remote_pad_first(local))
+			return -EBUSY;
+	return 0;
+}
+
+static const struct v4l2_subdev_core_ops vin_core_ops = {
+	.s_power = vin_set_power,
+};
+
+static const struct v4l2_subdev_video_ops vin_video_ops = {
+	.s_stream = vin_set_stream,
+};
+
+static const struct v4l2_subdev_pad_ops vin_pad_ops = {
+	.enum_mbus_code   = vin_enum_mbus_code,
+	.enum_frame_size  = vin_enum_frame_size,
+	.get_fmt          = vin_get_format,
+	.set_fmt          = vin_set_format,
+};
+
+static const struct v4l2_subdev_ops vin_v4l2_ops = {
+	.core = &vin_core_ops,
+	.video = &vin_video_ops,
+	.pad = &vin_pad_ops,
+};
+
+static const struct v4l2_subdev_internal_ops vin_v4l2_internal_ops = {
+	.open = vin_init_formats,
+};
+
+static const struct stfcamss_video_ops stfcamss_vin_video_ops = {
+	.queue_buffer = vin_queue_buffer,
+	.flush_buffers = vin_flush_buffers,
+};
+
+static const struct media_entity_operations vin_media_ops = {
+	.link_setup = vin_link_setup,
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+int stf_vin_register(struct stf_vin_dev *vin_dev, struct v4l2_device *v4l2_dev)
+{
+	struct v4l2_subdev *sd;
+	struct stfcamss_video *video_out;
+	struct media_pad *pads;
+	int ret;
+	int i;
+
+	for (i = 0; i < STF_ISP_LINE_MAX + 1; i++) {
+		char name[32];
+		char *sub_name = vin_get_line_subdevname(i);
+
+		sd = &vin_dev->line[i].subdev;
+		pads = vin_dev->line[i].pads;
+		video_out = &vin_dev->line[i].video_out;
+		video_out->id = i;
+
+		v4l2_subdev_init(sd, &vin_v4l2_ops);
+		sd->internal_ops = &vin_v4l2_internal_ops;
+		sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+		snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d_%s",
+			 STF_VIN_NAME, 0, sub_name);
+		v4l2_set_subdevdata(sd, &vin_dev->line[i]);
+
+		ret = vin_init_formats(sd, NULL);
+		if (ret < 0) {
+			st_err(ST_VIN, "Failed to init format: %d\n", ret);
+			goto err_init;
+		}
+
+		pads[STF_VIN_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+		pads[STF_VIN_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+
+		sd->entity.function =
+			MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
+		sd->entity.ops = &vin_media_ops;
+		ret = media_entity_pads_init(&sd->entity,
+					     STF_VIN_PADS_NUM, pads);
+		if (ret < 0) {
+			st_err(ST_VIN, "Failed to init media entity: %d\n",
+			       ret);
+			goto err_init;
+		}
+
+		ret = v4l2_device_register_subdev(v4l2_dev, sd);
+		if (ret < 0) {
+			st_err(ST_VIN, "Failed to register subdev: %d\n", ret);
+			goto err_reg_subdev;
+		}
+
+		video_out->ops = &stfcamss_vin_video_ops;
+		video_out->bpl_alignment = 16 * 8;
+
+		snprintf(name, ARRAY_SIZE(name), "%s_%s%d",
+			 sd->name, "video", i);
+		ret = stf_video_register(video_out, v4l2_dev, name);
+		if (ret < 0) {
+			st_err(ST_VIN, "Failed to register video node: %d\n",
+			       ret);
+			goto err_vid_reg;
+		}
+
+		ret = media_create_pad_link(
+			&sd->entity, STF_VIN_PAD_SRC,
+			&video_out->vdev.entity, 0,
+			MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
+		if (ret < 0) {
+			st_err(ST_VIN, "Failed to link %s->%s entities: %d\n",
+			       sd->entity.name, video_out->vdev.entity.name,
+			       ret);
+			goto err_create_link;
+		}
+	}
+
+	return 0;
+
+err_create_link:
+	stf_video_unregister(video_out);
+err_vid_reg:
+	v4l2_device_unregister_subdev(sd);
+err_reg_subdev:
+	media_entity_cleanup(&sd->entity);
+err_init:
+	for (i--; i >= 0; i--) {
+		sd = &vin_dev->line[i].subdev;
+		video_out = &vin_dev->line[i].video_out;
+
+		stf_video_unregister(video_out);
+		v4l2_device_unregister_subdev(sd);
+		media_entity_cleanup(&sd->entity);
+	}
+	return ret;
+}
+
+int stf_vin_unregister(struct stf_vin_dev *vin_dev)
+{
+	struct v4l2_subdev *sd;
+	struct stfcamss_video *video_out;
+	int i;
+
+	mutex_destroy(&vin_dev->power_lock);
+	for (i = 0; i < STF_DUMMY_MODULE_NUMS; i++)
+		mutex_destroy(&vin_dev->dummy_buffer[i].stream_lock);
+
+	for (i = 0; i < STF_ISP_LINE_MAX + 1; i++) {
+		sd = &vin_dev->line[i].subdev;
+		video_out = &vin_dev->line[i].video_out;
+
+		stf_video_unregister(video_out);
+		v4l2_device_unregister_subdev(sd);
+		media_entity_cleanup(&sd->entity);
+		mutex_destroy(&vin_dev->line[i].stream_lock);
+		mutex_destroy(&vin_dev->line[i].power_lock);
+	}
+	return 0;
+}
diff --git a/drivers/media/platform/starfive/stf_vin.h b/drivers/media/platform/starfive/stf_vin.h
new file mode 100644
index 000000000000..7a0f39e6d2b9
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_vin.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * stf_vin.h
+ *
+ * StarFive Camera Subsystem - VIN Module
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_VIN_H
+#define STF_VIN_H
+
+#include <linux/interrupt.h>
+#include <linux/spinlock_types.h>
+#include <media/v4l2-subdev.h>
+
+#include "stf_video.h"
+
+#define SYSCONSAIF_SYSCFG(x)	(x)
+
+/* syscon offset 0 */
+#define U0_VIN_CNFG_AXI_DVP_EN	BIT(2)
+
+/* syscon offset 20 */
+#define U0_VIN_CNFG_AXIWR0_CHANNEL_SEL	GENMASK(3, 0)
+#define U0_VIN_CNFG_AXIWR0_EN	BIT(4)
+
+/* syscon offset 32 */
+#define U0_VIN_CNFG_AXIWR0_INTR_CLEAN	BIT(0)
+#define U0_VIN_CNFG_AXIWR0_INTR_MASK	BIT(1)
+#define U0_VIN_CNFG_AXIWR0_PIX_CNT_END	GENMASK(12, 2)
+#define U0_VIN_CNFG_AXIWR0_PIX_CT	GENMASK(14, 13)
+#define U0_VIN_CNFG_AXIWR0_PIXEL_HEIGH_BIT_SEL	GENMASK(16, 15)
+
+/* syscon offset 36 */
+#define U0_VIN_CNFG_DVP_HS_POS	BIT(1)
+#define U0_VIN_CNFG_DVP_SWAP_EN	BIT(2)
+#define U0_VIN_CNFG_DVP_VS_POS	BIT(3)
+#define U0_VIN_CNFG_GEN_EN_AXIRD	BIT(4)
+#define U0_VIN_CNFG_ISP_DVP_EN0		BIT(5)
+#define U0_VIN_CNFG_MIPI_BYTE_EN_ISP0	GENMASK(7, 6)
+#define U0_VIN_CNFG_MIPI_CHANNEL_SEL0	GENMASK(11, 8)
+#define U0_VIN_CNFG_P_I_MIPI_HAEDER_EN0	BIT(12)
+#define U0_VIN_CNFG_PIX_NUM	GENMASK(16, 13)
+
+#define STF_VIN_PAD_SINK   0
+#define STF_VIN_PAD_SRC    1
+#define STF_VIN_PADS_NUM   2
+
+#define ISP_DUMMY_BUFFER_NUMS  STF_ISP_PAD_MAX
+#define VIN_DUMMY_BUFFER_NUMS  1
+
+enum {
+	STF_DUMMY_VIN,
+	STF_DUMMY_ISP,
+	STF_DUMMY_MODULE_NUMS,
+};
+
+enum link {
+	LINK_ERROR = -1,
+	LINK_DVP_TO_WR,
+	LINK_DVP_TO_ISP,
+	LINK_CSI_TO_WR,
+	LINK_CSI_TO_ISP,
+};
+
+struct vin_format {
+	u32 code;
+	u8 bpp;
+};
+
+struct vin_format_table {
+	const struct vin_format *fmts;
+	int nfmts;
+};
+
+enum vin_output_state {
+	VIN_OUTPUT_OFF,
+	VIN_OUTPUT_RESERVED,
+	VIN_OUTPUT_SINGLE,
+	VIN_OUTPUT_CONTINUOUS,
+	VIN_OUTPUT_IDLE,
+	VIN_OUTPUT_STOPPING
+};
+
+struct vin_output {
+	int active_buf;
+	struct stfcamss_buffer *buf[2];
+	struct stfcamss_buffer *last_buffer;
+	struct list_head pending_bufs;
+	struct list_head ready_bufs;
+	enum vin_output_state state;
+	unsigned int sequence;
+	unsigned int frame_skip;
+};
+
+/*
+ * The vin output lines include all isp controller lines,
+ * and one vin_wr output line.
+ */
+enum vin_line_id {
+	VIN_LINE_NONE = -1,
+	VIN_LINE_WR = 0,
+	VIN_LINE_ISP,
+	VIN_LINE_ISP_SS0,
+	VIN_LINE_ISP_SS1,
+	VIN_LINE_ISP_RAW,
+	VIN_LINE_MAX,
+};
+
+struct vin_line {
+	enum subdev_type sdev_type;  /* must be frist */
+	enum vin_line_id id;
+	struct v4l2_subdev subdev;
+	struct media_pad pads[STF_VIN_PADS_NUM];
+	struct v4l2_mbus_framefmt fmt[STF_VIN_PADS_NUM];
+	struct stfcamss_video video_out;
+	struct mutex stream_lock;	/* serialize stream control */
+	int stream_count;
+	struct mutex power_lock; /* serialize pipeline control in power process*/
+	int power_count;
+	struct vin_output output;	/* pipeline and stream states */
+	spinlock_t output_lock;
+	const struct vin_format *formats;
+	unsigned int nformats;
+};
+
+struct vin_dummy_buffer {
+	dma_addr_t paddr[3];
+	void *vaddr;
+	u32 buffer_size;
+	u32 width;
+	u32 height;
+	u32 mcode;
+};
+
+struct dummy_buffer {
+	struct vin_dummy_buffer *buffer;
+	u32 nums;
+	struct mutex stream_lock;	/* protects buffer data */
+	int stream_count;
+	atomic_t frame_skip;
+};
+
+struct vin_isr_ops {
+	void (*isr_buffer_done)(struct vin_line *line);
+	void (*isr_change_buffer)(struct vin_line *line);
+};
+
+struct stf_vin_dev {
+	struct stfcamss *stfcamss;
+	struct vin_line line[VIN_LINE_MAX];
+	struct dummy_buffer dummy_buffer[STF_DUMMY_MODULE_NUMS];
+	const struct vin_hw_ops *hw_ops;
+	struct vin_isr_ops *isr_ops;
+	atomic_t ref_count;
+	struct mutex power_lock;	/* serialize power control*/
+	int power_count;
+};
+
+struct vin_hw_ops {
+	int (*vin_clk_enable)(struct stf_vin_dev *vin_dev, enum link link);
+	int (*vin_clk_disable)(struct stf_vin_dev *vin_dev, enum link link);
+	int (*vin_wr_stream_set)(struct stf_vin_dev *vin_dev, int on);
+	int (*vin_stream_set)(struct stf_vin_dev *vin_dev, int on,
+			      struct v4l2_subdev_format sensor_fmt,
+			      enum link link);
+	void (*vin_wr_irq_enable)(struct stf_vin_dev *vin_dev, int enable);
+	void (*vin_wr_set_ping_addr)(struct stf_vin_dev *vin_dev,
+				     dma_addr_t addr);
+	void (*vin_wr_set_pong_addr)(struct stf_vin_dev *vin_dev,
+				     dma_addr_t addr);
+	void (*vin_isp_set_yuv_addr)(struct stf_vin_dev *vin_dev,
+				     dma_addr_t y_addr, dma_addr_t uv_addr);
+	void (*vin_isp_set_raw_addr)(struct stf_vin_dev *vin_dev,
+				     dma_addr_t raw_addr);
+	void (*vin_isp_set_ss0_addr)(struct stf_vin_dev *vin_dev,
+				     dma_addr_t y_addr, dma_addr_t uv_addr);
+	void (*vin_isp_set_ss1_addr)(struct stf_vin_dev *vin_dev,
+				     dma_addr_t y_addr, dma_addr_t uv_addr);
+	irqreturn_t (*vin_wr_irq_handler)(int irq, void *priv);
+	irqreturn_t (*vin_isp_irq_handler)(int irq, void *priv);
+	irqreturn_t (*vin_isp_irq_csi_handler)(int irq, void *priv);
+	irqreturn_t (*vin_isp_irq_csiline_handler)(int irq, void *priv);
+};
+
+extern const struct vin_hw_ops vin_ops;
+
+int stf_vin_subdev_init(struct stfcamss *stfcamss);
+int stf_vin_register(struct stf_vin_dev *vin_dev, struct v4l2_device *v4l2_dev);
+int stf_vin_unregister(struct stf_vin_dev *vin_dev);
+enum isp_pad_id stf_vin_map_isp_pad(enum vin_line_id line, enum isp_pad_id def);
+
+#endif /* STF_VIN_H */
diff --git a/drivers/media/platform/starfive/stf_vin_hw_ops.c b/drivers/media/platform/starfive/stf_vin_hw_ops.c
new file mode 100644
index 000000000000..98306c4d4d89
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_vin_hw_ops.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_vin_hw_ops.c
+ *
+ * Register interface file for StarFive VIN module driver
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+#include "stf_camss.h"
+
+static void vin_intr_clear(void __iomem *syscon_base)
+{
+	reg_set_bit(syscon_base, SYSCONSAIF_SYSCFG(28),
+		    U0_VIN_CNFG_AXIWR0_INTR_CLEAN, 0x1);
+	reg_set_bit(syscon_base, SYSCONSAIF_SYSCFG(28),
+		    U0_VIN_CNFG_AXIWR0_INTR_CLEAN, 0x0);
+}
+
+static irqreturn_t stf_vin_wr_irq_handler(int irq, void *priv)
+{
+	struct stf_vin_dev *vin_dev = priv;
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+	struct dummy_buffer *dummy_buffer =
+			&vin_dev->dummy_buffer[STF_DUMMY_VIN];
+
+	if (atomic_dec_if_positive(&dummy_buffer->frame_skip) < 0) {
+		vin_dev->isr_ops->isr_change_buffer(&vin_dev->line[VIN_LINE_WR]);
+		vin_dev->isr_ops->isr_buffer_done(&vin_dev->line[VIN_LINE_WR]);
+	}
+
+	vin_intr_clear(stfcamss->syscon_base);
+
+	return IRQ_HANDLED;
+}
+
+static void __iomem *stf_vin_get_ispbase(struct stf_vin_dev *vin_dev)
+{
+	void __iomem *base = vin_dev->stfcamss->isp_base;
+
+	return base;
+}
+
+static irqreturn_t stf_vin_isp_irq_handler(int irq, void *priv)
+{
+	struct stf_vin_dev *vin_dev = priv;
+	void __iomem *ispbase = stf_vin_get_ispbase(vin_dev);
+	u32 int_status;
+
+	int_status = reg_read(ispbase, ISP_REG_ISP_CTRL_0);
+
+	if (int_status & BIT(24)) {
+		if ((int_status & BIT(11)))
+			vin_dev->isr_ops->isr_buffer_done(
+				&vin_dev->line[VIN_LINE_ISP_SS0]);
+
+		if ((int_status & BIT(12)))
+			vin_dev->isr_ops->isr_buffer_done(
+				&vin_dev->line[VIN_LINE_ISP_SS1]);
+
+		if ((int_status & BIT(20)))
+			vin_dev->isr_ops->isr_buffer_done(
+				&vin_dev->line[VIN_LINE_ISP]);
+
+		if (int_status & BIT(25))
+			vin_dev->isr_ops->isr_buffer_done(
+				&vin_dev->line[VIN_LINE_ISP_RAW]);
+
+		/* clear interrupt */
+		reg_write(ispbase,
+			  ISP_REG_ISP_CTRL_0,
+			  (int_status & ~EN_INT_ALL) |
+			  EN_INT_ISP_DONE |
+			  EN_INT_CSI_DONE |
+			  EN_INT_SC_DONE);
+
+	} else {
+		st_debug(ST_VIN, "%s, Unknown interrupt!\n", __func__);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t stf_vin_isp_irq_csi_handler(int irq, void *priv)
+{
+	struct stf_vin_dev *vin_dev = priv;
+	void __iomem *ispbase = stf_vin_get_ispbase(vin_dev);
+	u32 int_status;
+
+	int_status = reg_read(ispbase, ISP_REG_ISP_CTRL_0);
+
+	if (int_status & BIT(25)) {
+		vin_dev->isr_ops->isr_buffer_done(
+			&vin_dev->line[VIN_LINE_ISP_RAW]);
+
+		/* clear interrupt */
+		reg_write(ispbase,
+			  ISP_REG_ISP_CTRL_0,
+			  (int_status & ~EN_INT_ALL) | EN_INT_CSI_DONE);
+	} else {
+		st_debug(ST_VIN, "%s, Unknown interrupt!!!\n", __func__);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t stf_vin_isp_irq_csiline_handler(int irq, void *priv)
+{
+	struct stf_vin_dev *vin_dev = priv;
+	struct stf_isp_dev *isp_dev;
+	void __iomem *ispbase = stf_vin_get_ispbase(vin_dev);
+	u32 int_status, value;
+
+	isp_dev = vin_dev->stfcamss->isp_dev;
+
+	int_status = reg_read(ispbase, ISP_REG_ISP_CTRL_0);
+	if (int_status & BIT(27)) {
+		struct dummy_buffer *dummy_buffer =
+			&vin_dev->dummy_buffer[STF_DUMMY_ISP];
+
+		if (!atomic_read(&isp_dev->shadow_count)) {
+			if (atomic_dec_if_positive(&dummy_buffer->frame_skip) < 0) {
+				if ((int_status & BIT(11)))
+					vin_dev->isr_ops->isr_change_buffer(
+						&vin_dev->line[VIN_LINE_ISP_SS0]);
+				if ((int_status & BIT(12)))
+					vin_dev->isr_ops->isr_change_buffer(
+						&vin_dev->line[VIN_LINE_ISP_SS1]);
+				if ((int_status & BIT(20)))
+					vin_dev->isr_ops->isr_change_buffer(
+						&vin_dev->line[VIN_LINE_ISP]);
+				value = reg_read(ispbase,
+						 ISP_REG_CSI_MODULE_CFG);
+				if ((value & BIT(19)))
+					vin_dev->isr_ops->isr_change_buffer(
+						&vin_dev->line[VIN_LINE_ISP_RAW]);
+			}
+
+			/* shadow update */
+			reg_set_bit(ispbase, ISP_REG_CSIINTS_ADDR,
+				    0x30000, 0x30000);
+			reg_set_bit(ispbase, ISP_REG_IESHD_ADDR,
+				    BIT(1) | BIT(0), 0x3);
+		} else {
+			st_err_ratelimited(ST_VIN, "skip this frame\n");
+		}
+
+		/* clear interrupt */
+		reg_write(ispbase, ISP_REG_ISP_CTRL_0,
+			  (int_status & ~EN_INT_ALL) | EN_INT_LINE_INT);
+	} else {
+		st_debug(ST_VIN, "%s, Unknown interrupt!!!\n", __func__);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int stf_vin_clk_enable(struct stf_vin_dev *vin_dev, enum link link)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	clk_set_rate(stfcamss->sys_clk[STF_CLK_APB_FUNC].clk, 49500000);
+
+	switch (link) {
+	case LINK_DVP_TO_WR:
+		break;
+	case LINK_DVP_TO_ISP:
+		break;
+	case LINK_CSI_TO_WR:
+		clk_set_rate(stfcamss->sys_clk[STF_CLK_MIPI_RX0_PXL].clk,
+			     198000000);
+		reset_control_deassert(stfcamss->sys_rst[STF_RST_AXIWR].rstc);
+		clk_set_parent(stfcamss->sys_clk[STF_CLK_AXIWR].clk,
+			       stfcamss->sys_clk[STF_CLK_MIPI_RX0_PXL].clk);
+		break;
+	case LINK_CSI_TO_ISP:
+		clk_set_rate(stfcamss->sys_clk[STF_CLK_MIPI_RX0_PXL].clk,
+			     198000000);
+		clk_set_parent(stfcamss->sys_clk[STF_CLK_WRAPPER_CLK_C].clk,
+			       stfcamss->sys_clk[STF_CLK_MIPI_RX0_PXL].clk);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int stf_vin_clk_disable(struct stf_vin_dev *vin_dev, enum link link)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	switch (link) {
+	case LINK_DVP_TO_WR:
+		break;
+	case LINK_DVP_TO_ISP:
+		break;
+	case LINK_CSI_TO_WR:
+		reset_control_assert(stfcamss->sys_rst[STF_RST_AXIWR].rstc);
+		break;
+	case LINK_CSI_TO_ISP:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int stf_vin_wr_stream_set(struct stf_vin_dev *vin_dev, int on)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	/* make the axiwr alway on */
+	if (on)
+		reg_set(stfcamss->syscon_base,
+			SYSCONSAIF_SYSCFG(20), U0_VIN_CNFG_AXIWR0_EN);
+
+	return 0;
+}
+
+static int stf_vin_stream_set(struct stf_vin_dev *vin_dev, int on,
+			      struct v4l2_subdev_format sensor_fmt,
+			      enum link link)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	switch (link) {
+	case LINK_DVP_TO_WR:
+		break;
+	case LINK_DVP_TO_ISP:
+		break;
+	case LINK_CSI_TO_WR:
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(20),
+			    U0_VIN_CNFG_AXIWR0_CHANNEL_SEL, 0 << 0);
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(28),
+			    U0_VIN_CNFG_AXIWR0_PIX_CT, 1 << 13);
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(28),
+			    U0_VIN_CNFG_AXIWR0_PIXEL_HEIGH_BIT_SEL, 0 << 15);
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(28),
+			    U0_VIN_CNFG_AXIWR0_PIX_CNT_END,
+			    (sensor_fmt.format.width / 4 - 1) << 2);
+		break;
+	case LINK_CSI_TO_ISP:
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(36),
+			    U0_VIN_CNFG_MIPI_BYTE_EN_ISP0, 0 << 6);
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(36),
+			    U0_VIN_CNFG_MIPI_CHANNEL_SEL0, 0 << 8);
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(36),
+			    U0_VIN_CNFG_PIX_NUM, 0 << 13);
+
+		if (sensor_fmt.format.code == MEDIA_BUS_FMT_SRGGB10_1X10 ||
+		    sensor_fmt.format.code == MEDIA_BUS_FMT_SGRBG10_1X10 ||
+		    sensor_fmt.format.code == MEDIA_BUS_FMT_SGBRG10_1X10 ||
+		    sensor_fmt.format.code == MEDIA_BUS_FMT_SBGGR10_1X10)
+			reg_set_bit(stfcamss->syscon_base,
+				    SYSCONSAIF_SYSCFG(36),
+				    U0_VIN_CNFG_P_I_MIPI_HAEDER_EN0,
+				    1 << 12);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void stf_vin_wr_irq_enable(struct stf_vin_dev *vin_dev, int enable)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+	unsigned int value = 0;
+
+	if (enable) {
+		value = ~(0x1 << 1);
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(28),
+			    U0_VIN_CNFG_AXIWR0_INTR_MASK, value);
+	} else {
+		/* clear vin interrupt */
+		value = 0x1 << 1;
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(28),
+			    U0_VIN_CNFG_AXIWR0_INTR_CLEAN, 0x1);
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(28),
+			    U0_VIN_CNFG_AXIWR0_INTR_CLEAN, 0x0);
+		reg_set_bit(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(28),
+			    U0_VIN_CNFG_AXIWR0_INTR_MASK, value);
+	}
+}
+
+static void stf_vin_wr_set_ping_addr(struct stf_vin_dev *vin_dev,
+				     dma_addr_t addr)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	/* set the start address */
+	reg_write(stfcamss->syscon_base,  SYSCONSAIF_SYSCFG(32), (long)addr);
+}
+
+static void stf_vin_wr_set_pong_addr(struct stf_vin_dev *vin_dev,
+				     dma_addr_t addr)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	/* set the start address */
+	reg_write(stfcamss->syscon_base, SYSCONSAIF_SYSCFG(24), (long)addr);
+}
+
+static void stf_vin_isp_set_yuv_addr(struct stf_vin_dev *vin_dev,
+				     dma_addr_t y_addr, dma_addr_t uv_addr)
+{
+	void __iomem *ispbase = stf_vin_get_ispbase(vin_dev);
+
+	reg_write(ispbase, ISP_REG_Y_PLANE_START_ADDR, y_addr);
+	reg_write(ispbase, ISP_REG_UV_PLANE_START_ADDR, uv_addr);
+}
+
+static void stf_vin_isp_set_raw_addr(struct stf_vin_dev *vin_dev,
+				     dma_addr_t raw_addr)
+{
+	void __iomem *ispbase = stf_vin_get_ispbase(vin_dev);
+
+	reg_write(ispbase, ISP_REG_DUMP_CFG_0, raw_addr);
+}
+
+static void stf_vin_isp_set_ss0_addr(struct stf_vin_dev *vin_dev,
+				     dma_addr_t y_addr, dma_addr_t uv_addr)
+{
+	void __iomem *ispbase = stf_vin_get_ispbase(vin_dev);
+
+	reg_write(ispbase, ISP_REG_SS0AY, y_addr);
+	reg_write(ispbase, ISP_REG_SS0AUV, uv_addr);
+}
+
+static void stf_vin_isp_set_ss1_addr(struct stf_vin_dev *vin_dev,
+				     dma_addr_t y_addr, dma_addr_t uv_addr)
+{
+	void __iomem *ispbase = stf_vin_get_ispbase(vin_dev);
+
+	reg_write(ispbase, ISP_REG_SS1AY, y_addr);
+	reg_write(ispbase, ISP_REG_SS1AUV, uv_addr);
+}
+
+const struct vin_hw_ops vin_ops = {
+	.vin_clk_enable        = stf_vin_clk_enable,
+	.vin_clk_disable       = stf_vin_clk_disable,
+	.vin_wr_stream_set     = stf_vin_wr_stream_set,
+	.vin_wr_irq_enable     = stf_vin_wr_irq_enable,
+	.vin_stream_set        = stf_vin_stream_set,
+	.vin_wr_set_ping_addr  = stf_vin_wr_set_ping_addr,
+	.vin_wr_set_pong_addr  = stf_vin_wr_set_pong_addr,
+	.vin_isp_set_yuv_addr  = stf_vin_isp_set_yuv_addr,
+	.vin_isp_set_raw_addr  = stf_vin_isp_set_raw_addr,
+	.vin_isp_set_ss0_addr  = stf_vin_isp_set_ss0_addr,
+	.vin_isp_set_ss1_addr  = stf_vin_isp_set_ss1_addr,
+	.vin_wr_irq_handler    = stf_vin_wr_irq_handler,
+	.vin_isp_irq_handler   = stf_vin_isp_irq_handler,
+	.vin_isp_irq_csi_handler   = stf_vin_isp_irq_csi_handler,
+	.vin_isp_irq_csiline_handler   = stf_vin_isp_irq_csiline_handler,
+};
diff --git a/include/uapi/linux/stf_isp_ioctl.h b/include/uapi/linux/stf_isp_ioctl.h
new file mode 100644
index 000000000000..3f302ef235d2
--- /dev/null
+++ b/include/uapi/linux/stf_isp_ioctl.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * stf_isp_ioctl.h
+ *
+ * StarFive Camera Subsystem - ISP Module
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_ISP_IOCTL_H
+#define STF_ISP_IOCTL_H
+
+#include <media/v4l2-ctrls.h>
+
+#define FILENAME_MAX_LEN     30
+
+#define ISP_IOC                         ('V')
+#define STF_ISP_REG_BUF_SIZE            (768)
+#define STF_ISP_REG_TBL_BUF_SIZE        (STF_ISP_REG_BUF_SIZE / 2)
+#define STF_ISP_REG_TBL_2_BUF_SIZE      (STF_ISP_REG_BUF_SIZE / 3)
+#define STF_ISP_REG_TBL_3_BUF_SIZE      (STF_ISP_REG_BUF_SIZE / 4)
+#define STF_ISP_REG_SMPL_PACK_BUF_SIZE  (STF_ISP_REG_BUF_SIZE / 2)
+#define RDMA_WR_ONE                     (0xA0)
+#define RDMA_WR_SRL                     (0xA1)
+#define RDMA_LINK                       (0xA2)
+#define RDMA_SINT                       (0xA3)
+#define RDMA_END                        (0xAF)
+#define ENABLE_SS0_SS1
+
+enum _STF_ISP_IOCTL {
+	STF_ISP_IOCTL_LOAD_FW = BASE_VIDIOC_PRIVATE + 1,
+	STF_ISP_IOCTL_DMABUF_ALLOC,
+	STF_ISP_IOCTL_DMABUF_FREE,
+	STF_ISP_IOCTL_GET_HW_VER,
+	STF_ISP_IOCTL_REG,
+	STF_ISP_IOCTL_SHADOW_LOCK,
+	STF_ISP_IOCTL_SHADOW_UNLOCK,
+	STF_ISP_IOCTL_SHADOW_UNLOCK_N_TRIGGER,
+	STF_ISP_IOCTL_SET_USER_CONFIG_ISP,
+	STF_ISP_IOCTL_MAX
+};
+
+enum _STF_ISP_REG_METHOD {
+	STF_ISP_REG_METHOD_ONE_REG = 0,
+	STF_ISP_REG_METHOD_SERIES,
+	STF_ISP_REG_METHOD_MODULE,
+	STF_ISP_REG_METHOD_TABLE,
+	STF_ISP_REG_METHOD_TABLE_2,
+	STF_ISP_REG_METHOD_TABLE_3,
+	STF_ISP_REG_METHOD_SMPL_PACK,
+	STF_ISP_REG_METHOD_SOFT_RDMA,
+	STF_ISP_REG_METHOD_MAX
+};
+
+struct stfisp_fw_info {
+	char __user filename[FILENAME_MAX_LEN];
+};
+
+struct dmabuf_create {
+	__u32 fd;
+	__u32 size;
+	__u32 paddr;
+};
+
+struct isp_rdma_info {
+	u32 param;
+	union {
+		u32 value;
+		struct {
+			u32 offset  : 24;
+			u32 tag     : 8;
+		};
+	};
+};
+
+struct isp_reg_info {
+	/* access method of register */
+	u8 method;
+	/* offset indicated which register will be read/write */
+	u32 offset;
+	/* length for indicated how much register will be read/write */
+	u32 length;
+};
+
+union reg_buf {
+	u32 buffer[STF_ISP_REG_BUF_SIZE];
+	struct {
+		u32 offset;
+		u32 value;
+	} reg_tbl[STF_ISP_REG_TBL_BUF_SIZE];
+	struct {
+		u32 offset;
+		u32 value;
+		u32 mask;
+	} reg_tbl2[STF_ISP_REG_TBL_2_BUF_SIZE];
+	struct {
+		u32 offset;
+		u32 value;
+		u32 mask;
+		u32 delay_ms;
+	} reg_tbl3[STF_ISP_REG_TBL_3_BUF_SIZE];
+	struct isp_rdma_info rdma_cmd[STF_ISP_REG_SMPL_PACK_BUF_SIZE];
+};
+
+struct isp_reg_param {
+	/* register read/write information */
+	struct isp_reg_info reg_info;
+	/* buffer */
+	union reg_buf *reg_buf;
+};
+
+#define VIDIOC_STFISP_LOAD_FW \
+	_IOW(ISP_IOC, STF_ISP_IOCTL_LOAD_FW, struct stfisp_fw_info)
+#define VIDIOC_STFISP_GET_REG \
+	_IOWR(ISP_IOC, STF_ISP_IOCTL_REG, struct isp_reg_param)
+#define VIDIOC_STFISP_SET_REG \
+	_IOW(ISP_IOC, STF_ISP_IOCTL_REG, struct isp_reg_param)
+#define VIDIOC_STFISP_SHADOW_LOCK \
+	_IO(ISP_IOC, STF_ISP_IOCTL_SHADOW_LOCK)
+#define VIDIOC_STFISP_SHADOW_UNLOCK \
+	_IO(ISP_IOC, STF_ISP_IOCTL_SHADOW_UNLOCK)
+#define VIDIOC_STFISP_SHADOW_UNLOCK_N_TRIGGER \
+	_IO(ISP_IOC, STF_ISP_IOCTL_SHADOW_UNLOCK_N_TRIGGER)
+#define VIDIOC_STFISP_SET_USER_CONFIG_ISP \
+	_IO(ISP_IOC, STF_ISP_IOCTL_SET_USER_CONFIG_ISP)
+
+#endif /* STF_ISP_IOCTL_H */
-- 
2.34.1

