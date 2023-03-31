Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A846D1FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjCaMTS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 08:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjCaMS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:18:59 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC051EFE0;
        Fri, 31 Mar 2023 05:18:35 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id EEF9024E36E;
        Fri, 31 Mar 2023 20:18:31 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 31 Mar
 2023 20:18:31 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 31 Mar
 2023 20:18:31 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v3 9/9] media: starfive: Add Starfive Camera Subsystem driver
Date:   Fri, 31 Mar 2023 20:18:26 +0800
Message-ID: <20230331121826.96973-10-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331121826.96973-1-jack.zhu@starfivetech.com>
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=unavailable
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
 MAINTAINERS                                   |    1 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/starfive/Kconfig       |   18 +
 drivers/media/platform/starfive/Makefile      |   14 +
 drivers/media/platform/starfive/stf_camss.c   |  477 +++++++
 drivers/media/platform/starfive/stf_camss.h   |  150 +++
 drivers/media/platform/starfive/stf_common.h  |   18 +
 drivers/media/platform/starfive/stf_isp.c     |  737 +++++++++++
 drivers/media/platform/starfive/stf_isp.h     |  999 ++++++++++++++
 .../media/platform/starfive/stf_isp_hw_ops.c  |  715 ++++++++++
 drivers/media/platform/starfive/stf_video.c   |  989 ++++++++++++++
 drivers/media/platform/starfive/stf_video.h   |   89 ++
 drivers/media/platform/starfive/stf_vin.c     | 1151 +++++++++++++++++
 drivers/media/platform/starfive/stf_vin.h     |  174 +++
 .../media/platform/starfive/stf_vin_hw_ops.c  |  211 +++
 16 files changed, 5745 insertions(+)
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

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f3ed2a51158..bb0800c1d9eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19916,6 +19916,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/starfive_camss.rst
 F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
+F:	drivers/media/platform/starfive/
 
 STARFIVE DEVICETREES
 M:	Emil Renner Berthing <kernel@esmil.dk>
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
index 000000000000..f9b9cc418b55
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_camss.c
@@ -0,0 +1,477 @@
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
+static const char * const stfcamss_clocks[] = {
+	"clk_apb_func",
+	"clk_wrapper_clk_c",
+	"clk_dvp_inv",
+	"clk_axiwr",
+	"clk_mipi_rx0_pxl",
+	"clk_ispcore_2x",
+	"clk_isp_axi",
+};
+
+static const char * const stfcamss_resets[] = {
+	"rst_wrapper_p",
+	"rst_wrapper_c",
+	"rst_axird",
+	"rst_axiwr",
+	"rst_isp_top_n",
+	"rst_isp_top_axi",
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
+	dev_dbg(dev, "vep.base.port = 0x%x, id = 0x%x\n",
+		vep.base.port, vep.base.id);
+
+	csd->port = vep.base.port;
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
+			dev_err(dev, "Cannot get remote parent\n");
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
+		dev_err(stfcamss->dev, "Failed to init isp subdev: %d\n", ret);
+		return ret;
+	}
+
+	ret = stf_vin_subdev_init(stfcamss);
+	if (ret < 0) {
+		dev_err(stfcamss->dev, "Failed to init vin subdev: %d\n", ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int stfcamss_register_subdevices(struct stfcamss *stfcamss)
+{
+	int ret;
+	struct stf_vin_dev *vin_dev = &stfcamss->vin_dev;
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+
+	ret = stf_isp_register(isp_dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(stfcamss->dev,
+			"Failed to register stf isp%d entity: %d\n", 0, ret);
+		goto err_reg_isp;
+	}
+
+	ret = stf_vin_register(vin_dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(stfcamss->dev,
+			"Failed to register vin entity: %d\n", ret);
+		goto err_reg_vin;
+	}
+
+	ret = media_create_pad_link(&isp_dev->subdev.entity,
+				    STF_ISP_PAD_SRC,
+				    &vin_dev->line[VIN_LINE_ISP].subdev.entity,
+				    STF_VIN_PAD_SINK,
+				    0);
+	if (ret < 0) {
+		dev_err(stfcamss->dev,
+			"Failed to link %s->%s entities: %d\n",
+			isp_dev->subdev.entity.name,
+			vin_dev->line[VIN_LINE_ISP].subdev.entity.name, ret);
+		goto err_link;
+	}
+
+	return ret;
+
+err_link:
+	stf_vin_unregister(&stfcamss->vin_dev);
+err_reg_vin:
+	stf_isp_unregister(&stfcamss->isp_dev);
+err_reg_isp:
+	return ret;
+}
+
+static void stfcamss_unregister_subdevices(struct stfcamss *stfcamss)
+{
+	stf_isp_unregister(&stfcamss->isp_dev);
+	stf_vin_unregister(&stfcamss->vin_dev);
+}
+
+static int stfcamss_reg_media_subdev_node(struct v4l2_async_notifier *async,
+					  struct v4l2_subdev *sd,
+					  struct host_data *host_data)
+{
+	struct stfcamss *stfcamss =
+		container_of(async, struct stfcamss, notifier);
+	struct media_entity *source;
+	int ret, i, j;
+
+	source = &sd->entity;
+
+	for (i = 0; i < source->num_pads; i++) {
+		if (source->pads[i].flags & MEDIA_PAD_FL_SOURCE)
+			break;
+	}
+
+	if (i == source->num_pads) {
+		dev_err(stfcamss->dev, "No source pad in external entity\n");
+		return -EINVAL;
+	}
+
+	for (j = 0; host_data->host_entity[j] && (j < HOST_ENTITY_MAX); j++) {
+		struct media_entity *input;
+
+		input = host_data->host_entity[j];
+
+		ret = media_create_pad_link(
+			source,
+			i,
+			input,
+			STF_PAD_SINK,
+			source->function == MEDIA_ENT_F_CAM_SENSOR ?
+			MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED :
+			0);
+		if (ret < 0) {
+			dev_err(stfcamss->dev,
+				"Failed to link %s->%s entities: %d\n",
+				source->name, input->name, ret);
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
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+	struct stf_vin_dev *vin_dev = &stfcamss->vin_dev;
+	struct host_data *host_data = &stfcamss->host_data;
+
+	if (port == PORT_NUMBER_CSI2RX) {
+		host_data->host_entity[0] =
+			&vin_dev->line[VIN_LINE_WR].subdev.entity;
+		host_data->host_entity[1] = &isp_dev->subdev.entity;
+	} else if (port == PORT_NUMBER_DVP_SENSOR) {
+		dev_err(stfcamss->dev, "Not support DVP sensor\n");
+		return -EPERM;
+	}
+
+	stfcamss_reg_media_subdev_node(async, subdev, host_data);
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
+static void stfcamss_mc_init(struct platform_device *pdev,
+			     struct stfcamss *stfcamss)
+{
+	stfcamss->media_dev.dev = stfcamss->dev;
+	strscpy(stfcamss->media_dev.model, "Starfive Camera Subsystem",
+		sizeof(stfcamss->media_dev.model));
+	snprintf(stfcamss->media_dev.bus_info,
+		 sizeof(stfcamss->media_dev.bus_info),
+		 "%s:%s", dev_bus_name(&pdev->dev), pdev->name);
+	stfcamss->media_dev.hw_revision = 0x01;
+	stfcamss->media_dev.ops = &stfcamss_media_ops;
+	media_device_init(&stfcamss->media_dev);
+
+	stfcamss->v4l2_dev.mdev = &stfcamss->media_dev;
+}
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
+	int ret = 0, i, num_subdevs;
+
+	stfcamss = devm_kzalloc(dev, sizeof(*stfcamss), GFP_KERNEL);
+	if (!stfcamss)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(stfcamss->irq); ++i) {
+		stfcamss->irq[i] = platform_get_irq(pdev, i);
+		if (stfcamss->irq[i] < 0)
+			return dev_err_probe(&pdev->dev, stfcamss->irq[i],
+					     "Failed to get clock%d", i);
+	}
+
+	stfcamss->nclks = ARRAY_SIZE(stfcamss->sys_clk);
+	for (i = 0; i < ARRAY_SIZE(stfcamss->sys_clk); ++i)
+		stfcamss->sys_clk[i].id = stfcamss_clocks[i];
+	ret = devm_clk_bulk_get(dev, stfcamss->nclks, stfcamss->sys_clk);
+	if (ret) {
+		dev_err(dev, "Failed to get clk controls\n");
+		return ret;
+	}
+
+	stfcamss->nrsts = ARRAY_SIZE(stfcamss->sys_rst);
+	for (i = 0; i < ARRAY_SIZE(stfcamss->sys_rst); ++i)
+		stfcamss->sys_rst[i].id = stfcamss_resets[i];
+	ret = devm_reset_control_bulk_get_shared(dev, stfcamss->nrsts,
+						 stfcamss->sys_rst);
+	if (ret) {
+		dev_err(dev, "Failed to get reset controls\n");
+		return ret;
+	}
+
+	ret = stfcamss_get_mem_res(pdev, stfcamss);
+	if (ret) {
+		dev_err(dev, "Could not map registers\n");
+		return ret;
+	}
+
+	stfcamss->dev = dev;
+	platform_set_drvdata(pdev, stfcamss);
+
+	v4l2_async_nf_init(&stfcamss->notifier);
+
+	num_subdevs = stfcamss_of_parse_ports(stfcamss);
+	if (num_subdevs < 0) {
+		dev_err(dev, "Failed to find subdevices\n");
+		return -ENODEV;
+	}
+
+	ret = stfcamss_init_subdevices(stfcamss);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init subdevice: %d\n", ret);
+		goto err_cleanup_notifier;
+	}
+
+	stfcamss_mc_init(pdev, stfcamss);
+
+	ret = v4l2_device_register(stfcamss->dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
+		goto err_cleanup_media_device;
+	}
+
+	ret = stfcamss_register_subdevices(stfcamss);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register subdevice: %d\n", ret);
+		goto err_unregister_device;
+	}
+
+	stfcamss->notifier.ops = &stfcamss_subdev_notifier_ops;
+	ret = v4l2_async_nf_register(&stfcamss->v4l2_dev, &stfcamss->notifier);
+	if (ret) {
+		dev_err(dev, "Failed to register async subdev nodes: %d\n",
+			ret);
+		goto err_unregister_subdevs;
+	}
+
+	pm_runtime_enable(dev);
+
+	return 0;
+
+err_unregister_subdevs:
+	stfcamss_unregister_subdevices(stfcamss);
+err_unregister_device:
+	v4l2_device_unregister(&stfcamss->v4l2_dev);
+err_cleanup_media_device:
+	media_device_cleanup(&stfcamss->media_dev);
+err_cleanup_notifier:
+	v4l2_async_nf_cleanup(&stfcamss->notifier);
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
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, stfcamss_of_match);
+
+static int __maybe_unused stfcamss_runtime_suspend(struct device *dev)
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
+static int __maybe_unused stfcamss_runtime_resume(struct device *dev)
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
+
+static const struct dev_pm_ops stfcamss_pm_ops = {
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
index 000000000000..c066e4405211
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_camss.h
@@ -0,0 +1,150 @@
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
+enum stf_irq {
+	STF_IRQ_VINWR = 0,
+	STF_IRQ_ISP,
+	STF_IRQ_ISPCSIL,
+	STF_IRQ_NUM
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
+	struct stf_vin_dev vin_dev;
+	struct stf_isp_dev isp_dev;
+	struct v4l2_async_notifier notifier;
+	struct host_data host_data;
+	void __iomem *syscon_base;
+	void __iomem *isp_base;
+	int irq[STF_IRQ_NUM];
+	struct clk_bulk_data sys_clk[STF_CLK_NUM];
+	int nclks;
+	struct reset_control_bulk_data sys_rst[STF_RST_NUM];
+	int nrsts;
+};
+
+struct stfcamss_async_subdev {
+	struct v4l2_async_subdev asd;  /* must be first */
+	enum port_num port;
+};
+
+static inline u32 stf_isp_reg_read(struct stfcamss *stfcamss, u32 reg)
+{
+	return ioread32(stfcamss->isp_base + reg);
+}
+
+static inline void stf_isp_reg_write(struct stfcamss *stfcamss,
+				     u32 reg, u32 val)
+{
+	iowrite32(val, stfcamss->isp_base + reg);
+}
+
+static inline void stf_isp_reg_set_bit(struct stfcamss *stfcamss,
+				       u32 reg, u32 mask, u32 val)
+{
+	u32 value;
+
+	value = ioread32(stfcamss->isp_base + reg) & ~mask;
+	val &= mask;
+	val |= value;
+	iowrite32(val, stfcamss->isp_base + reg);
+}
+
+static inline void stf_isp_reg_set(struct stfcamss *stfcamss, u32 reg, u32 mask)
+{
+	iowrite32(ioread32(stfcamss->isp_base + reg) | mask,
+		  stfcamss->isp_base + reg);
+}
+
+static inline u32 stf_syscon_reg_read(struct stfcamss *stfcamss, u32 reg)
+{
+	return ioread32(stfcamss->syscon_base + reg);
+}
+
+static inline void stf_syscon_reg_write(struct stfcamss *stfcamss,
+					u32 reg, u32 val)
+{
+	iowrite32(val, stfcamss->syscon_base + reg);
+}
+
+static inline void stf_syscon_reg_set_bit(struct stfcamss *stfcamss,
+					  u32 reg, u32 mask, u32 val)
+{
+	u32 value;
+
+	value = ioread32(stfcamss->syscon_base + reg) & ~mask;
+	val &= mask;
+	val |= value;
+	iowrite32(val, stfcamss->syscon_base + reg);
+}
+
+static inline void stf_syscon_reg_set(struct stfcamss *stfcamss,
+				      u32 reg, u32 mask)
+{
+	iowrite32(ioread32(stfcamss->syscon_base + reg) | mask,
+		  stfcamss->syscon_base + reg);
+}
+
+#endif /* STF_CAMSS_H */
diff --git a/drivers/media/platform/starfive/stf_common.h b/drivers/media/platform/starfive/stf_common.h
new file mode 100644
index 000000000000..e04fca2d9cd4
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_common.h
@@ -0,0 +1,18 @@
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
+enum stf_subdev_type {
+	STF_SUBDEV_TYPE_VIN,
+	STF_SUBDEV_TYPE_ISP,
+};
+
+#endif /* STF_COMMON_H */
diff --git a/drivers/media/platform/starfive/stf_isp.c b/drivers/media/platform/starfive/stf_isp.c
new file mode 100644
index 000000000000..efc687d94f1b
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_isp.c
@@ -0,0 +1,737 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_isp.c
+ *
+ * StarFive Camera Subsystem - ISP Module
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+#include <linux/firmware.h>
+#include <media/v4l2-event.h>
+
+#include "stf_camss.h"
+
+#define SINK_FORMATS_INDEX    0
+#define UO_FORMATS_INDEX      1
+#define RAW_FORMATS_INDEX     2
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
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+
+	isp_dev->sdev_type = STF_SUBDEV_TYPE_ISP;
+	isp_dev->stfcamss = stfcamss;
+	isp_dev->formats = isp_formats_st7110;
+	isp_dev->nformats = ARRAY_SIZE(isp_formats_st7110);
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
+			dev_dbg(isp_dev->stfcamss->dev, "turn on isp\n");
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
+			stf_isp_clk_enable(isp_dev);
+			stf_isp_config_set(isp_dev);
+			interface_type = isp_get_interface_type(&sd->entity);
+			if (interface_type < 0) {
+				dev_err(isp_dev->stfcamss->dev,
+					"%s, pipeline not config\n", __func__);
+				goto exit;
+			}
+			stf_isp_set_format(isp_dev, isp_dev->rect,
+					   fmt->code, interface_type);
+			stf_isp_reset(isp_dev);
+			stf_isp_stream_set(isp_dev, enable);
+		}
+		isp_dev->stream_count++;
+	} else {
+		if (isp_dev->stream_count == 0)
+			goto exit;
+		if (isp_dev->stream_count == 1) {
+			stf_isp_stream_set(isp_dev, enable);
+			stf_isp_clk_disable(isp_dev);
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
+static int isp_fmt_to_index(const struct isp_format_table *f_table,
+			    __u32 mbus_code, unsigned int pad)
+{
+	int i;
+
+	for (i = 0; i < f_table->nfmts; i++) {
+		if (mbus_code == f_table->fmts[i].code)
+			break;
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
+		formats = &isp_dev->formats[UO_FORMATS_INDEX];
+		break;
+	}
+
+	i = isp_fmt_to_index(formats, fmt->code, pad);
+
+	if (pad != STF_ISP_PAD_SINK)
+		*fmt = *__isp_get_format(isp_dev, state,
+					 STF_ISP_PAD_SINK, which);
+
+	if (i >= formats->nfmts) {
+		fmt->code = formats->fmts[0].code;
+		bpp = formats->fmts[0].bpp;
+	} else {
+		fmt->code = code;
+		bpp = formats->fmts[i].bpp;
+	}
+
+	switch (pad) {
+	case STF_ISP_PAD_SINK:
+		break;
+
+	case STF_ISP_PAD_SRC:
+		isp_dev->rect[ISP_COMPOSE].bpp = bpp;
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
+		if (sel->pad > STF_ISP_PAD_SRC)
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
+		if (sel->pad > STF_ISP_PAD_SRC)
+			return -EINVAL;
+
+		rect = __isp_get_compose(isp_dev, state, sel->which);
+		if (!rect)
+			return -EINVAL;
+
+		sel->r = *rect;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
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
+	} else if (sel->target == V4L2_SEL_TGT_CROP) {
+		struct v4l2_subdev_selection compose = { 0 };
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
+	} else {
+		ret = -EINVAL;
+	}
+
+	dev_dbg(isp_dev->stfcamss->dev, "%s pad = %d, left = %d, %d, %d, %d\n",
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
+int isp_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+
+	while (atomic_dec_if_positive(&isp_dev->shadow_count) > 0)
+		dev_warn(isp_dev->stfcamss->dev, "unlock the shadow lock!\n");
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
+		return -EINVAL;
+	}
+}
+
+static const struct v4l2_subdev_core_ops isp_core_ops = {
+	.s_power = isp_set_power,
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
+		dev_err(isp_dev->stfcamss->dev, "Failed to init format: %d\n",
+			ret);
+		return ret;
+	}
+
+	pads[STF_ISP_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	pads[STF_ISP_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+
+	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
+	sd->entity.ops = &isp_media_ops;
+	ret = media_entity_pads_init(&sd->entity, STF_ISP_PAD_MAX, pads);
+	if (ret < 0) {
+		dev_err(isp_dev->stfcamss->dev,
+			"Failed to init media entity: %d\n", ret);
+		return ret;
+	}
+
+	ret = v4l2_device_register_subdev(v4l2_dev, sd);
+	if (ret < 0) {
+		dev_err(isp_dev->stfcamss->dev,
+			"Failed to register subdev: %d\n", ret);
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
index 000000000000..75feff8ac83f
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_isp.h
@@ -0,0 +1,999 @@
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
+#define STF_ISP_REG_OFFSET_MAX  0x0fff
+#define STF_ISP_REG_DELAY_MAX   100
+
+/* isp registers */
+#define ISP_REG_CSI_INPUT_EN_AND_STATUS	0x000
+#define CSI_SCD_ERR	BIT(6)
+#define CSI_ITU656_ERR	BIT(4)
+#define CSI_ITU656_F	BIT(3)
+#define CSI_SCD_DONE	BIT(2)
+#define CSI_BUSY_S	BIT(1)
+#define CSI_EN_S	BIT(0)
+
+#define ISP_REG_CSIINTS_ADDR	0x008
+#define CSI_INTS(n)	((n) << 16)
+#define CSI_SHA_M(n)	((n) << 0)
+#define CSI_INTS_MASK	GENMASK(17, 16)
+
+#define ISP_REG_CSI_MODULE_CFG	0x010
+#define CSI_DUMP_EN	BIT(19)
+#define CSI_VS_EN	BIT(18)
+#define CSI_SC_EN	BIT(17)
+#define CSI_OBA_EN	BIT(16)
+#define CSI_AWB_EN	BIT(7)
+#define CSI_LCCF_EN	BIT(6)
+#define CSI_OECFHM_EN	BIT(5)
+#define CSI_OECF_EN	BIT(4)
+#define CSI_LCBQ_EN	BIT(3)
+#define CSI_OBC_EN	BIT(2)
+#define CSI_DEC_EN	BIT(1)
+#define CSI_DC_EN	BIT(0)
+
+#define ISP_REG_SENSOR	0x014
+#define DVP_SYNC_POL(n)	((n) << 2)
+#define ITU656_EN(n)	((n) << 1)
+#define IMAGER_SEL(n)	((n) << 0)
+
+#define ISP_REG_RAW_FORMAT_CFG	0x018
+#define SMY13(n)	((n) << 14)
+#define SMY12(n)	((n) << 12)
+#define SMY11(n)	((n) << 10)
+#define SMY10(n)	((n) << 8)
+#define SMY3(n)	((n) << 6)
+#define SMY2(n)	((n) << 4)
+#define SMY1(n)	((n) << 2)
+#define SMY0(n)	((n) << 0)
+
+#define ISP_REG_PIC_CAPTURE_START_CFG	0x01c
+#define VSTART_CAP(n)	((n) << 16)
+#define HSTART_CAP(n)	((n) << 0)
+
+#define ISP_REG_PIC_CAPTURE_END_CFG	0x020
+#define VEND_CAP(n)	((n) << 16)
+#define HEND_CAP(n)	((n) << 0)
+
+#define ISP_REG_DUMP_CFG_0	0x024
+#define ISP_REG_DUMP_CFG_1	0x028
+#define DUMP_ID(n)	((n) << 24)
+#define DUMP_SHT(n)	((n) << 20)
+#define DUMP_BURST_LEN(n)	((n) << 16)
+#define DUMP_SD(n)	((n) << 0)
+#define DUMP_BURST_LEN_MASK	GENMASK(17, 16)
+#define DUMP_SD_MASK	GENMASK(15, 0)
+
+#define ISP_REG_DEC_CFG	0x030
+#define DEC_V_KEEP(n)	((n) << 24)
+#define DEC_V_PERIOD(n)	((n) << 16)
+#define DEC_H_KEEP(n)	((n) << 8)
+#define DEC_H_PERIOD(n)	((n) << 0)
+
+#define ISP_REG_OBC_CFG	0x034
+#define OBC_W_H(y)	((y) << 4)
+#define OBC_W_W(x)	((x) << 0)
+
+#define ISP_REG_DC_CFG_1	0x044
+#define DC_AXI_ID(n)	((n) << 0)
+
+#define ISP_REG_LCCF_CFG_0	0x050
+#define Y_DISTANCE(y)	((y) << 16)
+#define X_DISTANCE(x)	((x) << 16)
+
+#define ISP_REG_LCCF_CFG_1	0x058
+#define LCCF_MAX_DIS(n)	((n) << 0)
+
+#define ISP_REG_LCBQ_CFG_0	0x074
+#define H_LCBQ(y)	((y) << 12)
+#define W_LCBQ(x)	((x) << 8)
+
+#define ISP_REG_LCBQ_CFG_1	0x07c
+#define Y_COOR(y)	((y) << 16)
+#define X_COOR(x)	((x) << 0)
+
+#define ISP_REG_OBA_CFG_0	0x090
+#define VSTART(n)	((n) << 16)
+#define HSTART(n)	((n) << 0)
+
+#define ISP_REG_OBA_CFG_1	0x094
+#define VEND(n)	((n) << 16)
+#define HEND(n)	((n) << 0)
+
+#define ISP_REG_SCD_CFG_0	0x098
+#define ISP_REG_SCD_CFG_1	0x09c
+#define AXI_ID(n)	((n) << 24)
+
+#define ISP_REG_SC_CFG_0	0x0b8
+#define VSTART_SC(n)	((n) << 16)
+#define HSTART_SC(n)	((n) << 0)
+
+#define ISP_REG_SC_CFG_1	0x0bc
+#define SEL_SC(n)	((n) << 30)
+#define AWB_PS_GRB_BA(n)	((n) << 16)
+#define HEIGHT_SC(n)	((n) << 8)
+#define WIDTH_SC(n)	((n) << 0)
+
+#define ISP_REG_SC_AF	0x0c0
+#define AF_ES_HTHR(n)	((n) << 16)
+#define AF_ES_VTHR(n)	((n) << 8)
+#define AF_ES_VE(n)	((n) << 3)
+#define AF_ES_HE(n)	((n) << 2)
+#define AF_ES_SM(n)	((n) << 1)
+#define AF_ES_HM(n)	((n) << 0)
+
+#define ISP_REG_SC_AWB_PS_CFG_0	0x0c4
+#define AWB_PS_GU(n)	((n) << 24)
+#define AWB_PS_GL(n)	((n) << 16)
+#define AWB_PS_RU(n)	((n) << 8)
+#define AWB_PS_RL(n)	((n) << 0)
+#define ISP_REG_SC_AWB_PS_CFG_1	0x0c8
+#define AWB_PS_YU(n)	((n) << 24)
+#define AWB_PS_YL(n)	((n) << 16)
+#define AWB_PS_BU(n)	((n) << 8)
+#define AWB_PS_BL(n)	((n) << 0)
+#define ISP_REG_SC_AWB_PS_CFG_2	0x0cc
+#define AWB_PS_GRU(n)	((n) << 16)
+#define AWB_PS_GRL(n)	((n) << 0)
+#define ISP_REG_SC_AWB_PS_CFG_3	0x0d0
+#define AWB_PS_GBU(n)	((n) << 16)
+#define AWB_PS_GBL(n)	((n) << 0)
+#define ISP_REG_SC_AWB_PS_CFG_4	0x0d4
+#define AWB_PS_GRBU(n)	((n) << 16)
+#define AWB_PS_GRBL(n)	((n) << 0)
+
+#define ISP_REG_SC_DEC	0x0d8
+#define VKEEP(n)	((n) << 24)
+#define VPERIOD(n)	((n) << 16)
+#define HKEEP(n)	((n) << 8)
+#define HPERIOD(n)	((n) << 0)
+
+#define ISP_REG_LCCF_CFG_2	0x0e0
+#define ISP_REG_LCCF_CFG_3	0x0e4
+#define ISP_REG_LCCF_CFG_4	0x0e8
+#define ISP_REG_LCCF_CFG_5	0x0ec
+#define LCCF_F2_PAR(n)	((n) << 16)
+#define LCCF_F1_PAR(n)	((n) << 0)
+
+#define ISP_REG_OECF_X0_CFG_0	0x100
+#define ISP_REG_OECF_X0_CFG_1	0x104
+#define ISP_REG_OECF_X0_CFG_2	0x108
+#define ISP_REG_OECF_X0_CFG_3	0x10c
+#define ISP_REG_OECF_X0_CFG_4	0x110
+#define ISP_REG_OECF_X0_CFG_5	0x114
+#define ISP_REG_OECF_X0_CFG_6	0x118
+#define ISP_REG_OECF_X0_CFG_7	0x11c
+#define ISP_REG_OECF_X1_CFG_0	0x120
+#define ISP_REG_OECF_X1_CFG_1	0x124
+#define ISP_REG_OECF_X1_CFG_2	0x128
+#define ISP_REG_OECF_X1_CFG_3	0x12c
+#define ISP_REG_OECF_X1_CFG_4	0x130
+#define ISP_REG_OECF_X1_CFG_5	0x134
+#define ISP_REG_OECF_X1_CFG_6	0x138
+#define ISP_REG_OECF_X1_CFG_7	0x13c
+#define ISP_REG_OECF_X2_CFG_0	0x140
+#define ISP_REG_OECF_X2_CFG_1	0x144
+#define ISP_REG_OECF_X2_CFG_2	0x148
+#define ISP_REG_OECF_X2_CFG_3	0x14c
+#define ISP_REG_OECF_X2_CFG_4	0x150
+#define ISP_REG_OECF_X2_CFG_5	0x154
+#define ISP_REG_OECF_X2_CFG_6	0x158
+#define ISP_REG_OECF_X2_CFG_7	0x15c
+#define ISP_REG_OECF_X3_CFG_0	0x160
+#define ISP_REG_OECF_X3_CFG_1	0x164
+#define ISP_REG_OECF_X3_CFG_2	0x168
+#define ISP_REG_OECF_X3_CFG_3	0x16c
+#define ISP_REG_OECF_X3_CFG_4	0x170
+#define ISP_REG_OECF_X3_CFG_5	0x174
+#define ISP_REG_OECF_X3_CFG_6	0x178
+#define ISP_REG_OECF_X3_CFG_7	0x17c
+#define OCEF_X_PAR_H(n)	((n) << 16)
+#define OCEF_X_PAR_L(n)	((n) << 0)
+
+#define ISP_REG_OECF_Y0_CFG_0	0x180
+#define ISP_REG_OECF_Y0_CFG_1	0x184
+#define ISP_REG_OECF_Y0_CFG_2	0x188
+#define ISP_REG_OECF_Y0_CFG_3	0x18c
+#define ISP_REG_OECF_Y0_CFG_4	0x190
+#define ISP_REG_OECF_Y0_CFG_5	0x194
+#define ISP_REG_OECF_Y0_CFG_6	0x198
+#define ISP_REG_OECF_Y0_CFG_7	0x19c
+#define ISP_REG_OECF_Y1_CFG_0	0x1a0
+#define ISP_REG_OECF_Y1_CFG_1	0x1a4
+#define ISP_REG_OECF_Y1_CFG_2	0x1a8
+#define ISP_REG_OECF_Y1_CFG_3	0x1ac
+#define ISP_REG_OECF_Y1_CFG_4	0x1b0
+#define ISP_REG_OECF_Y1_CFG_5	0x1b4
+#define ISP_REG_OECF_Y1_CFG_6	0x1b8
+#define ISP_REG_OECF_Y1_CFG_7	0x1bc
+#define ISP_REG_OECF_Y2_CFG_0	0x1c0
+#define ISP_REG_OECF_Y2_CFG_1	0x1c4
+#define ISP_REG_OECF_Y2_CFG_2	0x1c8
+#define ISP_REG_OECF_Y2_CFG_3	0x1cc
+#define ISP_REG_OECF_Y2_CFG_4	0x1d0
+#define ISP_REG_OECF_Y2_CFG_5	0x1d4
+#define ISP_REG_OECF_Y2_CFG_6	0x1d8
+#define ISP_REG_OECF_Y2_CFG_7	0x1dc
+#define ISP_REG_OECF_Y3_CFG_0	0x1e0
+#define ISP_REG_OECF_Y3_CFG_1	0x1e4
+#define ISP_REG_OECF_Y3_CFG_2	0x1e8
+#define ISP_REG_OECF_Y3_CFG_3	0x1ec
+#define ISP_REG_OECF_Y3_CFG_4	0x1f0
+#define ISP_REG_OECF_Y3_CFG_5	0x1f4
+#define ISP_REG_OECF_Y3_CFG_6	0x1f8
+#define ISP_REG_OECF_Y3_CFG_7	0x1fc
+#define OCEF_Y_PAR_H(n)	((n) << 16)
+#define OCEF_Y_PAR_L(n)	((n) << 0)
+
+#define ISP_REG_OECF_S0_CFG_0	0x200
+#define ISP_REG_OECF_S0_CFG_1	0x204
+#define ISP_REG_OECF_S0_CFG_2	0x208
+#define ISP_REG_OECF_S0_CFG_3	0x20c
+#define ISP_REG_OECF_S0_CFG_4	0x210
+#define ISP_REG_OECF_S0_CFG_5	0x214
+#define ISP_REG_OECF_S0_CFG_6	0x218
+#define ISP_REG_OECF_S0_CFG_7	0x21c
+#define ISP_REG_OECF_S1_CFG_0	0x220
+#define ISP_REG_OECF_S1_CFG_1	0x224
+#define ISP_REG_OECF_S1_CFG_2	0x228
+#define ISP_REG_OECF_S1_CFG_3	0x22c
+#define ISP_REG_OECF_S1_CFG_4	0x230
+#define ISP_REG_OECF_S1_CFG_5	0x234
+#define ISP_REG_OECF_S1_CFG_6	0x238
+#define ISP_REG_OECF_S1_CFG_7	0x23c
+#define ISP_REG_OECF_S2_CFG_0	0x240
+#define ISP_REG_OECF_S2_CFG_1	0x244
+#define ISP_REG_OECF_S2_CFG_2	0x248
+#define ISP_REG_OECF_S2_CFG_3	0x24c
+#define ISP_REG_OECF_S2_CFG_4	0x250
+#define ISP_REG_OECF_S2_CFG_5	0x254
+#define ISP_REG_OECF_S2_CFG_6	0x258
+#define ISP_REG_OECF_S2_CFG_7	0x25c
+#define ISP_REG_OECF_S3_CFG_0	0x260
+#define ISP_REG_OECF_S3_CFG_1	0x264
+#define ISP_REG_OECF_S3_CFG_2	0x268
+#define ISP_REG_OECF_S3_CFG_3	0x26c
+#define ISP_REG_OECF_S3_CFG_4	0x270
+#define ISP_REG_OECF_S3_CFG_5	0x274
+#define ISP_REG_OECF_S3_CFG_6	0x278
+#define ISP_REG_OECF_S3_CFG_7	0x27c
+#define OCEF_S_PAR_H(n)	((n) << 16)
+#define OCEF_S_PAR_L(n)	((n) << 0)
+
+#define ISP_REG_AWB_X0_CFG_0	0x280
+#define ISP_REG_AWB_X0_CFG_1	0x284
+#define ISP_REG_AWB_X1_CFG_0	0x288
+#define ISP_REG_AWB_X1_CFG_1	0x28c
+#define ISP_REG_AWB_X2_CFG_0	0x290
+#define ISP_REG_AWB_X2_CFG_1	0x294
+#define ISP_REG_AWB_X3_CFG_0	0x298
+#define ISP_REG_AWB_X3_CFG_1	0x29c
+#define AWB_X_SYMBOL1(n)	((n) << 16)
+#define AWB_X_SYMBOL0(n)	((n) << 0)
+
+#define ISP_REG_AWB_Y0_CFG_0	0x2a0
+#define ISP_REG_AWB_Y0_CFG_1	0x2a4
+#define ISP_REG_AWB_Y1_CFG_0	0x2a8
+#define ISP_REG_AWB_Y1_CFG_1	0x2ac
+#define ISP_REG_AWB_Y2_CFG_0	0x2b0
+#define ISP_REG_AWB_Y2_CFG_1	0x2b4
+#define ISP_REG_AWB_Y3_CFG_0	0x2b8
+#define ISP_REG_AWB_Y3_CFG_1	0x2bc
+#define AWB_Y_SYMBOL1(n)	((n) << 16)
+#define AWB_Y_SYMBOL0(n)	((n) << 0)
+
+#define ISP_REG_AWB_S0_CFG_0	0x2c0
+#define ISP_REG_AWB_S0_CFG_1	0x2c4
+#define ISP_REG_AWB_S1_CFG_0	0x2c8
+#define ISP_REG_AWB_S1_CFG_1	0x2cc
+#define ISP_REG_AWB_S2_CFG_0	0x2d0
+#define ISP_REG_AWB_S2_CFG_1	0x2d4
+#define ISP_REG_AWB_S3_CFG_0	0x2d8
+#define ISP_REG_AWB_S3_CFG_1	0x2dc
+#define AWB_S_SYMBOL1(n)	((n) << 16)
+#define AWB_S_SYMBOL0(n)	((n) << 0)
+
+#define ISP_REG_OBCG_CFG_0	0x2e0
+#define ISP_REG_OBCG_CFG_1	0x2e4
+#define ISP_REG_OBCG_CFG_2	0x2e8
+#define ISP_REG_OBCG_CFG_3	0x2ec
+#define ISP_REG_OBCO_CFG_0	0x2f0
+#define ISP_REG_OBCO_CFG_1	0x2f4
+#define ISP_REG_OBCO_CFG_2	0x2f8
+#define ISP_REG_OBCO_CFG_3	0x2fc
+#define D_S0(x)	((x) << 24)
+#define C_S0(x)	((x) << 16)
+#define B_S0(x)	((x) << 8)
+#define A_S0(x)	((x) << 0)
+
+#define ISP_REG_LCBQ_GAIN0_CFG_0	0x300
+#define ISP_REG_LCBQ_GAIN0_CFG_1	0x304
+#define ISP_REG_LCBQ_GAIN0_CFG_2	0x308
+#define ISP_REG_LCBQ_GAIN0_CFG_3	0x30c
+#define ISP_REG_LCBQ_GAIN0_CFG_4	0x310
+#define ISP_REG_LCBQ_GAIN0_CFG_5	0x314
+#define ISP_REG_LCBQ_GAIN0_CFG_6	0x318
+#define ISP_REG_LCBQ_GAIN0_CFG_7	0x31c
+#define ISP_REG_LCBQ_GAIN0_CFG_8	0x320
+#define ISP_REG_LCBQ_GAIN0_CFG_9	0x324
+#define ISP_REG_LCBQ_GAIN0_CFG_10	0x328
+#define ISP_REG_LCBQ_GAIN0_CFG_11	0x32c
+#define ISP_REG_LCBQ_GAIN0_CFG_12	0x330
+#define ISP_REG_LCBQ_GAIN1_CFG_0	0x334
+#define ISP_REG_LCBQ_GAIN1_CFG_1	0x338
+#define ISP_REG_LCBQ_GAIN1_CFG_2	0x33c
+#define ISP_REG_LCBQ_GAIN1_CFG_3	0x340
+#define ISP_REG_LCBQ_GAIN1_CFG_4	0x344
+#define ISP_REG_LCBQ_GAIN1_CFG_5	0x348
+#define ISP_REG_LCBQ_GAIN1_CFG_6	0x34c
+#define ISP_REG_LCBQ_GAIN1_CFG_7	0x350
+#define ISP_REG_LCBQ_GAIN1_CFG_8	0x354
+#define ISP_REG_LCBQ_GAIN1_CFG_9	0x358
+#define ISP_REG_LCBQ_GAIN1_CFG_10	0x35c
+#define ISP_REG_LCBQ_GAIN1_CFG_11	0x360
+#define ISP_REG_LCBQ_GAIN1_CFG_12	0x364
+#define ISP_REG_LCBQ_GAIN2_CFG_0	0x368
+#define ISP_REG_LCBQ_GAIN2_CFG_1	0x36c
+#define ISP_REG_LCBQ_GAIN2_CFG_2	0x370
+#define ISP_REG_LCBQ_GAIN2_CFG_3	0x374
+#define ISP_REG_LCBQ_GAIN2_CFG_4	0x378
+#define ISP_REG_LCBQ_GAIN2_CFG_5	0x37c
+#define ISP_REG_LCBQ_GAIN2_CFG_6	0x380
+#define ISP_REG_LCBQ_GAIN2_CFG_7	0x384
+#define ISP_REG_LCBQ_GAIN2_CFG_8	0x388
+#define ISP_REG_LCBQ_GAIN2_CFG_9	0x38c
+#define ISP_REG_LCBQ_GAIN2_CFG_10	0x390
+#define ISP_REG_LCBQ_GAIN2_CFG_11	0x394
+#define ISP_REG_LCBQ_GAIN2_CFG_12	0x398
+#define ISP_REG_LCBQ_GAIN3_CFG_0	0x39c
+#define ISP_REG_LCBQ_GAIN3_CFG_1	0x3a0
+#define ISP_REG_LCBQ_GAIN3_CFG_2	0x3a4
+#define ISP_REG_LCBQ_GAIN3_CFG_3	0x3a8
+#define ISP_REG_LCBQ_GAIN3_CFG_4	0x3ac
+#define ISP_REG_LCBQ_GAIN3_CFG_5	0x3b0
+#define ISP_REG_LCBQ_GAIN3_CFG_6	0x3b4
+#define ISP_REG_LCBQ_GAIN3_CFG_7	0x3b8
+#define ISP_REG_LCBQ_GAIN3_CFG_8	0x3bc
+#define ISP_REG_LCBQ_GAIN3_CFG_9	0x3c0
+#define ISP_REG_LCBQ_GAIN3_CFG_10	0x3c4
+#define ISP_REG_LCBQ_GAIN3_CFG_11	0x3c8
+#define ISP_REG_LCBQ_GAIN3_CFG_12	0x3cc
+#define GAIN_H(n)	((n) << 16)
+#define GAIN_L(n)	((n) << 0)
+
+#define ISP_REG_OECFHM_Y_CFG_0	0x3d0
+#define ISP_REG_OECFHM_Y_CFG_1	0x3d4
+#define ISP_REG_OECFHM_Y_CFG_2	0x3d8
+#define ISP_REG_OECFHM_S_CFG_0	0x3dc
+#define ISP_REG_OECFHM_S_CFG_1	0x3e0
+#define ISP_REG_OECFHM_S_CFG_2	0x3e4
+#define OECFHM_H(n)	((n) << 16)
+#define OECFHM_L(n)	((n) << 0)
+
+#define ISP_REG_LCBQ_OFFSET0_CFG_0	0x400
+#define ISP_REG_LCBQ_OFFSET0_CFG_1	0x404
+#define ISP_REG_LCBQ_OFFSET0_CFG_2	0x408
+#define ISP_REG_LCBQ_OFFSET0_CFG_3	0x40c
+#define ISP_REG_LCBQ_OFFSET0_CFG_4	0x410
+#define ISP_REG_LCBQ_OFFSET0_CFG_5	0x414
+#define ISP_REG_LCBQ_OFFSET0_CFG_6	0x418
+#define ISP_REG_LCBQ_OFFSET0_CFG_7	0x41c
+#define ISP_REG_LCBQ_OFFSET0_CFG_8	0x420
+#define ISP_REG_LCBQ_OFFSET0_CFG_9	0x424
+#define ISP_REG_LCBQ_OFFSET0_CFG_10	0x428
+#define ISP_REG_LCBQ_OFFSET0_CFG_11	0x42c
+#define ISP_REG_LCBQ_OFFSET0_CFG_12	0x430
+#define ISP_REG_LCBQ_OFFSET1_CFG_0	0x434
+#define ISP_REG_LCBQ_OFFSET1_CFG_1	0x438
+#define ISP_REG_LCBQ_OFFSET1_CFG_2	0x43c
+#define ISP_REG_LCBQ_OFFSET1_CFG_3	0x440
+#define ISP_REG_LCBQ_OFFSET1_CFG_4	0x444
+#define ISP_REG_LCBQ_OFFSET1_CFG_5	0x448
+#define ISP_REG_LCBQ_OFFSET1_CFG_6	0x44c
+#define ISP_REG_LCBQ_OFFSET1_CFG_7	0x450
+#define ISP_REG_LCBQ_OFFSET1_CFG_8	0x454
+#define ISP_REG_LCBQ_OFFSET1_CFG_9	0x458
+#define ISP_REG_LCBQ_OFFSET1_CFG_10	0x45c
+#define ISP_REG_LCBQ_OFFSET1_CFG_11	0x460
+#define ISP_REG_LCBQ_OFFSET1_CFG_12	0x464
+#define ISP_REG_LCBQ_OFFSET2_CFG_0	0x468
+#define ISP_REG_LCBQ_OFFSET2_CFG_1	0x46c
+#define ISP_REG_LCBQ_OFFSET2_CFG_2	0x470
+#define ISP_REG_LCBQ_OFFSET2_CFG_3	0x474
+#define ISP_REG_LCBQ_OFFSET2_CFG_4	0x478
+#define ISP_REG_LCBQ_OFFSET2_CFG_5	0x47c
+#define ISP_REG_LCBQ_OFFSET2_CFG_6	0x480
+#define ISP_REG_LCBQ_OFFSET2_CFG_7	0x484
+#define ISP_REG_LCBQ_OFFSET2_CFG_8	0x488
+#define ISP_REG_LCBQ_OFFSET2_CFG_9	0x48c
+#define ISP_REG_LCBQ_OFFSET2_CFG_10	0x490
+#define ISP_REG_LCBQ_OFFSET2_CFG_11	0x494
+#define ISP_REG_LCBQ_OFFSET2_CFG_12	0x498
+#define ISP_REG_LCBQ_OFFSET3_CFG_0	0x49c
+#define ISP_REG_LCBQ_OFFSET3_CFG_1	0x4a0
+#define ISP_REG_LCBQ_OFFSET3_CFG_2	0x4a4
+#define ISP_REG_LCBQ_OFFSET3_CFG_3	0x4a8
+#define ISP_REG_LCBQ_OFFSET3_CFG_4	0x4ac
+#define ISP_REG_LCBQ_OFFSET3_CFG_5	0x4b0
+#define ISP_REG_LCBQ_OFFSET3_CFG_6	0x4b4
+#define ISP_REG_LCBQ_OFFSET3_CFG_7	0x4b8
+#define ISP_REG_LCBQ_OFFSET3_CFG_8	0x4bc
+#define ISP_REG_LCBQ_OFFSET3_CFG_9	0x4c0
+#define ISP_REG_LCBQ_OFFSET3_CFG_10	0x4c4
+#define ISP_REG_LCBQ_OFFSET3_CFG_11	0x4c8
+#define ISP_REG_LCBQ_OFFSET3_CFG_12	0x4cc
+
+#define ISP_REG_SC_AWB_WS_CW0_CFG_0	0x4d0
+#define ISP_REG_SC_AWB_WS_CW0_CFG_1	0x4d4
+#define ISP_REG_SC_AWB_WS_CW1_CFG_0	0x4d8
+#define ISP_REG_SC_AWB_WS_CW1_CFG_1	0x4dc
+#define ISP_REG_SC_AWB_WS_CW2_CFG_0	0x4e0
+#define ISP_REG_SC_AWB_WS_CW2_CFG_1	0x4e4
+#define ISP_REG_SC_AWB_WS_CW3_CFG_0	0x4e8
+#define ISP_REG_SC_AWB_WS_CW3_CFG_1	0x4ec
+#define ISP_REG_SC_AWB_WS_CW4_CFG_0	0x4f0
+#define ISP_REG_SC_AWB_WS_CW4_CFG_1	0x4f4
+#define ISP_REG_SC_AWB_WS_CW5_CFG_0	0x4f8
+#define ISP_REG_SC_AWB_WS_CW5_CFG_1	0x4fc
+#define ISP_REG_SC_AWB_WS_CW6_CFG_0	0x500
+#define ISP_REG_SC_AWB_WS_CW6_CFG_1	0x504
+#define ISP_REG_SC_AWB_WS_CW7_CFG_0	0x508
+#define ISP_REG_SC_AWB_WS_CW7_CFG_1	0x50c
+#define ISP_REG_SC_AWB_WS_CW8_CFG_0	0x510
+#define ISP_REG_SC_AWB_WS_CW8_CFG_1	0x514
+#define ISP_REG_SC_AWB_WS_CW9_CFG_0	0x518
+#define ISP_REG_SC_AWB_WS_CW9_CFG_1	0x51c
+#define ISP_REG_SC_AWB_WS_CW10_CFG_0	0x520
+#define ISP_REG_SC_AWB_WS_CW10_CFG_1	0x524
+#define ISP_REG_SC_AWB_WS_CW11_CFG_0	0x528
+#define ISP_REG_SC_AWB_WS_CW11_CFG_1	0x52c
+#define ISP_REG_SC_AWB_WS_CW12_CFG_0	0x530
+#define ISP_REG_SC_AWB_WS_CW12_CFG_1	0x534
+#define AWB_WS_CW_W_7(n)	((n) << 28)
+#define AWB_WS_CW_W_6(n)	((n) << 24)
+#define AWB_WS_CW_W_5(n)	((n) << 20)
+#define AWB_WS_CW_W_4(n)	((n) << 16)
+#define AWB_WS_CW_W_3(n)	((n) << 12)
+#define AWB_WS_CW_W_2(n)	((n) << 8)
+#define AWB_WS_CW_W_1(n)	((n) << 4)
+#define AWB_WS_CW_W_0(n)	((n) << 0)
+
+#define ISP_REG_SC_AWB_WS_IWV_CFG_0	0x538
+#define ISP_REG_SC_AWB_WS_IWV_CFG_1	0x53c
+#define AWB_WS_IW_V_7(n)	((n) << 28)
+#define AWB_WS_IW_V_6(n)	((n) << 24)
+#define AWB_WS_IW_V_5(n)	((n) << 20)
+#define AWB_WS_IW_V_4(n)	((n) << 16)
+#define AWB_WS_IW_V_3(n)	((n) << 12)
+#define AWB_WS_IW_V_2(n)	((n) << 8)
+#define AWB_WS_IW_V_1(n)	((n) << 4)
+#define AWB_WS_IW_V_0(n)	((n) << 0)
+
+#define ISP_REG_SC_AWB_WS_IWS_CFG_0	0x540
+#define ISP_REG_SC_AWB_WS_IWS_CFG_1	0x544
+#define ISP_REG_SC_AWB_WS_IWS_CFG_2	0x548
+#define ISP_REG_SC_AWB_WS_IWS_CFG_3	0x54c
+#define AWB_WS_IW_S3(n)	((n) << 24)
+#define AWB_WS_IW_S2(n)	((n) << 16)
+#define AWB_WS_IW_S1(n)	((n) << 8)
+#define AWB_WS_IW_S0(n)	((n) << 0)
+
+#define ISP_REG_SC_AWB_WS_CFG_0	0x5d0
+#define AWB_WS_GRU(n)	((n) << 24)
+#define AWB_WS_GRL(n)	((n) << 16)
+#define AWB_WS_RU(n)	((n) << 8)
+#define AWB_WS_RL(n)	((n) << 0)
+#define ISP_REG_SC_AWB_WS_CFG_1	0x5d4
+#define AWB_WS_BU(n)	((n) << 24)
+#define AWB_WS_BL(n)	((n) << 16)
+#define AWB_WS_GBU(n)	((n) << 8)
+#define AWB_WS_GBL(n)	((n) << 0)
+
+#define ISP_REG_CBAR0	0x600
+#define ISP_REG_CBAR1	0x604
+#define ISP_REG_CBAR2	0x608
+#define ISP_REG_CBAR3	0x60c
+#define ISP_REG_CBAR4	0x610
+#define ISP_REG_CBAR5	0x614
+#define ISP_REG_CBAR6	0x618
+#define ISP_REG_CBAR7	0x61c
+#define ISP_REG_CBAR8	0x620
+#define ISP_REG_CBAR9	0x624
+#define ISP_REG_CBAR10	0x628
+#define ISP_REG_CBAR11	0x62c
+#define ISP_REG_CBAR12	0x630
+#define ISP_REG_CBAR13	0x634
+#define ISP_REG_CBAR14	0x638
+#define ISP_REG_CBAR15	0x63c
+#define ISP_REG_CBAR16	0x640
+#define ISP_REG_CBAR17	0x644
+#define ISP_REG_CBAR18	0x648
+#define ISP_REG_CBAR19	0x64c
+#define ISP_REG_CBAR20	0x650
+#define CBAR_PAR_H(n)	((n) << 16)
+#define CBAR_PAR_L(n)	((n) << 0)
+
+#define ISP_REG_ISP_CTRL_0	0xa00
+#define ISPC_VSFWINT	BIT(26)
+#define ISPC_VSINT	BIT(25)
+#define ISPC_INTS	BIT(24)
+#define ISPC_ENUO	BIT(20)
+#define ISPC_ENLS	BIT(17)
+#define ISPC_ENSS1	BIT(12)
+#define ISPC_ENSS0	BIT(11)
+#define ISPC_RST	BIT(1)
+#define ISPC_EN	BIT(0)
+#define ISPC_RST_MASK	BIT(1)
+
+#define ISP_REG_ISP_CTRL_1	0xa08
+#define CTRL_SAT(n)	((n) << 28)
+#define CTRL_DBC	BIT(22)
+#define CTRL_CTC	BIT(21)
+#define CTRL_YHIST	BIT(20)
+#define CTRL_YCURVE	BIT(19)
+#define CTRL_CTM	BIT(18)
+#define CTRL_BIYUV	BIT(17)
+#define CTRL_SCE	BIT(8)
+#define CTRL_EE	BIT(7)
+#define CTRL_CCE	BIT(5)
+#define CTRL_RGE	BIT(4)
+#define CTRL_CME	BIT(3)
+#define CTRL_AE	BIT(2)
+#define CTRL_CE	BIT(1)
+#define CTRL_SAT_MASK	GENMASK(31, 28)
+
+#define ISP_REG_PIPELINE_XY_SIZE	0xa0c
+#define H_ACT_CAP(n)	((n) << 16)
+#define W_ACT_CAP(n)	((n) << 0)
+
+#define ISP_REG_ICTC	0xa10
+#define MAXGT(n)	((n) << 16)
+#define MINGT(n)	((n) << 0)
+
+#define ISP_REG_IDBC	0xa14
+#define BADGT(n)	((n) << 16)
+#define BADXT(n)	((n) << 0)
+
+#define ISP_REG_ICFAM	0xa1c
+#define CROSS_COV(n)	((n) << 4)
+#define HV_W(n)	((n) << 0)
+
+#define ISP_REG_ISAT0	0xa30
+#define CMMD(n)	((n) << 16)
+#define CMAB(n)	((n) << 0)
+
+#define ISP_REG_ISAT1	0xa34
+#define CMD(n)	((n) << 16)
+#define CMB(n)	((n) << 0)
+
+#define ISP_REG_ISAT2	0xa38
+#define VOFF(n)	((n) << 16)
+#define UOFF(n)	((n) << 0)
+
+#define ISP_REG_ISAT3	0xa3c
+#define SIN(n)	((n) << 16)
+#define COS(n)	((n) << 0)
+
+#define ISP_REG_ISAT4	0xa40
+#define CMSF(n)	((n) << 0)
+
+#define ISP_REG_IESHD_ADDR	0xa50
+#define SHAD_UP_M	BIT(1)
+#define SHAD_UP_EN	BIT(0)
+
+#define ISP_REG_IYADJ0	0xa54
+#define YOIR(n)	((n) << 16)
+#define YIMIN(n)	((n) << 0)
+
+#define ISP_REG_IYADJ1	0xa58
+#define YOMAX(n)	((n) << 16)
+#define YOMIN(n)	((n) << 0)
+
+#define ISP_REG_Y_PLANE_START_ADDR	0xa80
+#define ISP_REG_UV_PLANE_START_ADDR	0xa84
+
+#define ISP_REG_STRIDE	0xa88
+#define IMG_STR(n)	((n) << 0)
+
+#define ISP_REG_PIXEL_COORDINATE_GEN	0xa8c
+#define OUT_SCANH(n)	((n) << 4)
+
+#define ISP_REG_UOAXI	0xa90
+#define OUT_AXI_W_ID(n)	((n) << 8)
+
+#define ISP_REG_SS0AY	0xa94
+#define ISP_REG_SS0AUV	0xa98
+#define ISP_REG_SS0S	0xa9c
+#define SD_IMG(n)	((n) << 0)
+
+#define ISP_REG_SS0HF	0xaa0
+#define H_SF_SCAL(n)	((n) << 16)
+#define H_SM_SCAL(n)	((n) << 0)
+
+#define ISP_REG_SS0VF	0xaa4
+#define V_SF_SCAL(n)	((n) << 16)
+#define V_SM_SCAL(n)	((n) << 0)
+
+#define ISP_REG_SS0IW	0xaa8
+#define W_OUT(n)	((n) << 16)
+#define H_OUT(n)	((n) << 0)
+
+#define ISP_REG_SS1AY	0xaac
+#define Y_PLANE_SAD(n)	((n) << 0)
+
+#define ISP_REG_SS1AUV	0xab0
+#define UV_PLANE_SAD(n)	((n) << 0)
+
+#define ISP_REG_SS1S	0xab4
+#define OUT_IMG_STR(n)	((n) << 0)
+
+#define ISP_REG_SS1HF	0xab8
+#define H_SCAL_FACTOR(n)	((n) << 16)
+#define H_SCAL_MODE(n)	((n) << 0)
+
+#define ISP_REG_SS1VF	0xabc
+#define V_SCAL_FACTOR(n)	((n) << 16)
+#define V_SCAL_MODE(n)	((n) << 0)
+
+#define ISP_REG_SS1IW	0xac0
+#define W_OUT_IMG(n)	((n) << 16)
+#define H_OUT_IMG(n)	((n) << 0)
+
+#define ISP_REG_SSAXI	0xac4
+#define SS1WID(n)	((n) << 8)
+#define SS0WID(n)	((n) << 0)
+
+#define ISP_REG_YHIST_CFG_4	0xcd8
+
+#define ISP_REG_ITIIWSR	0xb20
+#define ITI_HSIZE(n)	((n) << 16)
+#define ITI_WSIZE(n)	((n) << 0)
+
+#define ISP_REG_ITIDWLSR	0xb24
+#define ITI_WSTRIDE(n)	((n) << 0)
+
+#define ISP_REG_ITIDWYSAR	0xb28
+#define ISP_REG_ITIDWUSAR	0xb2C
+#define ISP_REG_ITIDRYSAR	0xb30
+#define ISP_REG_ITIDRUSAR	0xb34
+
+#define ISP_REG_ITIPDFR	0xb38
+#define ITI_PACKAGE_FMT(n)	((n) << 0)
+
+#define ISP_REG_ITIDRLSR	0xb3C
+#define ITI_STRIDE_L(n)	((n) << 0)
+
+#define ISP_REG_ITIBSR	0xb40
+
+#define ISP_REG_ITIAIR	0xb44
+#define ITI_UVRID(n)	((n) << 24)
+#define ITI_YRID(n)	((n) << 16)
+#define ITI_UVWID(n)	((n) << 8)
+#define ITI_YWID(n)	((n) << 0)
+
+#define ISP_REG_ITIDPSR	0xb48
+#define ITI_W_INDEX(n)	((n) << 8)
+#define ITI_R_INDEX(n)	((n) << 0)
+
+#define ISP_REG_DNYUV_YSWR0	0xc00
+#define ISP_REG_DNYUV_YSWR1	0xc04
+#define ISP_REG_DNYUV_CSWR0	0xc08
+#define ISP_REG_DNYUV_CSWR1	0xc0c
+#define YUVSW5(n)	((n) << 20)
+#define YUVSW4(n)	((n) << 16)
+#define YUVSW3(n)	((n) << 12)
+#define YUVSW2(n)	((n) << 8)
+#define YUVSW1(n)	((n) << 4)
+#define YUVSW0(n)	((n) << 0)
+
+#define ISP_REG_DNYUV_YDR0	0xc10
+#define ISP_REG_DNYUV_YDR1	0xc14
+#define ISP_REG_DNYUV_YDR2	0xc18
+#define ISP_REG_DNYUV_CDR0	0xc1c
+#define ISP_REG_DNYUV_CDR1	0xc20
+#define ISP_REG_DNYUV_CDR2	0xc24
+#define CURVE_D_H(n)	((n) << 16)
+#define CURVE_D_L(n)	((n) << 0)
+
+#define ISP_REG_ICAMD_0	0xc40
+#define DNRM(n)	((n) << 16)
+#define ISP_REG_ICAMD_1	0xc44
+#define ISP_REG_ICAMD_2	0xc48
+#define ISP_REG_ICAMD_3	0xc4c
+#define ISP_REG_ICAMD_4	0xc50
+#define ISP_REG_ICAMD_5	0xc54
+#define ISP_REG_ICAMD_6	0xc58
+#define ISP_REG_ICAMD_7	0xc5c
+#define ISP_REG_ICAMD_8	0xc60
+#define ISP_REG_ICAMD_9	0xc64
+#define ISP_REG_ICAMD_10	0xc68
+#define ISP_REG_ICAMD_11	0xc6c
+#define ISP_REG_ICAMD_12	0xc70
+#define ISP_REG_ICAMD_13	0xc74
+#define ISP_REG_ICAMD_14	0xc78
+#define ISP_REG_ICAMD_15	0xc7c
+#define ISP_REG_ICAMD_16	0xc80
+#define ISP_REG_ICAMD_17	0xc84
+#define ISP_REG_ICAMD_18	0xc88
+#define ISP_REG_ICAMD_19	0xc8c
+#define ISP_REG_ICAMD_20	0xc90
+#define ISP_REG_ICAMD_21	0xc94
+#define ISP_REG_ICAMD_22	0xc98
+#define ISP_REG_ICAMD_23	0xc9c
+#define ISP_REG_ICAMD_24	0xca0
+#define ISP_REG_ICAMD_25	0xca4
+#define CCM_M_DAT(n)	((n) << 0)
+
+#define ISP_REG_YHIST_CFG_0	0xcc8
+#define YH_VSTART(n)	((n) << 16)
+#define YH_HSTART(n)	((n) << 0)
+#define ISP_REG_YHIST_CFG_1	0xccc
+#define YH_HEIGHT(n)	((n) << 16)
+#define YH_WIDTH(n)	((n) << 0)
+#define ISP_REG_YHIST_CFG_2	0xcd0
+#define YH_DEC_ETH(n)	((n) << 16)
+#define YH_DEC_ETW(n)	((n) << 0)
+#define ISP_REG_YHIST_CFG_3	0xcd4
+#define YH_MUX(n)	((n) << 0)
+
+#define ISP_REG_IGRVAL_0	0xe00
+#define ISP_REG_IGRVAL_1	0xe04
+#define ISP_REG_IGRVAL_2	0xe08
+#define ISP_REG_IGRVAL_3	0xe0c
+#define ISP_REG_IGRVAL_4	0xe10
+#define ISP_REG_IGRVAL_5	0xe14
+#define ISP_REG_IGRVAL_6	0xe18
+#define ISP_REG_IGRVAL_7	0xe1c
+#define ISP_REG_IGRVAL_8	0xe20
+#define ISP_REG_IGRVAL_9	0xe24
+#define ISP_REG_IGRVAL_10	0xe28
+#define ISP_REG_IGRVAL_11	0xe2c
+#define ISP_REG_IGRVAL_12	0xe30
+#define ISP_REG_IGRVAL_13	0xe34
+#define ISP_REG_IGRVAL_14	0xe38
+#define SGVAL(n)	((n) << 16)
+#define GVAL(n)	((n) << 0)
+
+#define ISP_REG_ICCONV_0	0xe40
+#define ISP_REG_ICCONV_1	0xe44
+#define ISP_REG_ICCONV_2	0xe48
+#define ISP_REG_ICCONV_3	0xe4c
+#define ISP_REG_ICCONV_4	0xe50
+#define ISP_REG_ICCONV_5	0xe54
+#define ISP_REG_ICCONV_6	0xe58
+#define ISP_REG_ICCONV_7	0xe5c
+#define ISP_REG_ICCONV_8	0xe60
+#define CSC_M(n)	((n) << 0)
+
+#define ISP_REG_ISHRP1_0	0xe80
+#define ISP_REG_ISHRP1_1	0xe84
+#define ISP_REG_ISHRP1_2	0xe88
+#define ISP_REG_ISHRP1_3	0xe8c
+#define ISP_REG_ISHRP1_4	0xe90
+#define ISP_REG_ISHRP1_5	0xe94
+#define ISP_REG_ISHRP1_6	0xe98
+#define ISP_REG_ISHRP1_7	0xe9c
+#define ISP_REG_ISHRP1_8	0xea0
+#define ISP_REG_ISHRP1_9	0xea4
+#define ISP_REG_ISHRP1_10	0xea8
+#define ISP_REG_ISHRP1_11	0xeac
+#define ISP_REG_ISHRP1_12	0xeb0
+#define ISP_REG_ISHRP1_13	0xeb4
+#define ISP_REG_ISHRP1_14	0xeb8
+#define DIFF(n)	((n) << 16)
+#define SHRP_W(n)	((n) << 8)
+
+#define ISP_REG_ISHRP2_0	0xebc
+#define ISP_REG_ISHRP2_1	0xec0
+#define ISP_REG_ISHRP2_2	0xec4
+#define ISP_REG_ISHRP2_3	0xec8
+#define ISP_REG_ISHRP2_4	0xecc
+#define ISP_REG_ISHRP2_5	0xed0
+#define F_AMP(n)	((n) << 24)
+#define S_AMP(n)	((n) << 0)
+
+#define ISP_REG_ISHRP3	0xed4
+#define PDIRF(n)	((n) << 28)
+#define NDIRF(n)	((n) << 24)
+#define WSUM(n)	((n) << 0)
+
+#define ISP_REG_IUVS1	0xed8
+#define UVDIFF2(n)	((n) << 16)
+#define UVDIFF1(n)	((n) << 0)
+
+#define ISP_REG_IUVS2	0xedc
+#define UVF(n)	((n) << 24)
+#define UVSLOPE(n)	((n) << 0)
+
+#define ISP_REG_IUVCKS1	0xee0
+#define UVCKDIFF2(n)	((n) << 16)
+#define UVCKDIFF1(n)	((n) << 0)
+
+#define ISP_REG_IUVCKS2	0xee4
+#define UVCKSLOPE(n)	((n) << 0)
+
+#define ISP_REG_ISHRPET	0xee8
+#define TH(n)	((n) << 8)
+#define EN(n)	((n) << 0)
+
+#define ISP_REG_YCURVE_0	0xf00
+#define ISP_REG_YCURVE_1	0xf04
+#define ISP_REG_YCURVE_2	0xf08
+#define ISP_REG_YCURVE_3	0xf0c
+#define ISP_REG_YCURVE_4	0xf10
+#define ISP_REG_YCURVE_5	0xf14
+#define ISP_REG_YCURVE_6	0xf18
+#define ISP_REG_YCURVE_7	0xf1c
+#define ISP_REG_YCURVE_8	0xf20
+#define ISP_REG_YCURVE_9	0xf24
+#define ISP_REG_YCURVE_10	0xf28
+#define ISP_REG_YCURVE_11	0xf2c
+#define ISP_REG_YCURVE_12	0xf30
+#define ISP_REG_YCURVE_13	0xf34
+#define ISP_REG_YCURVE_14	0xf38
+#define ISP_REG_YCURVE_15	0xf3c
+#define ISP_REG_YCURVE_16	0xf40
+#define ISP_REG_YCURVE_17	0xf44
+#define ISP_REG_YCURVE_18	0xf48
+#define ISP_REG_YCURVE_19	0xf4c
+#define ISP_REG_YCURVE_20	0xf50
+#define ISP_REG_YCURVE_21	0xf54
+#define ISP_REG_YCURVE_22	0xf58
+#define ISP_REG_YCURVE_23	0xf5c
+#define ISP_REG_YCURVE_24	0xf60
+#define ISP_REG_YCURVE_25	0xf64
+#define ISP_REG_YCURVE_26	0xf68
+#define ISP_REG_YCURVE_27	0xf6c
+#define ISP_REG_YCURVE_28	0xf70
+#define ISP_REG_YCURVE_29	0xf74
+#define ISP_REG_YCURVE_30	0xf78
+#define ISP_REG_YCURVE_31	0xf7c
+#define ISP_REG_YCURVE_32	0xf80
+#define ISP_REG_YCURVE_33	0xf84
+#define ISP_REG_YCURVE_34	0xf88
+#define ISP_REG_YCURVE_35	0xf8c
+#define ISP_REG_YCURVE_36	0xf90
+#define ISP_REG_YCURVE_37	0xf94
+#define ISP_REG_YCURVE_38	0xf98
+#define ISP_REG_YCURVE_39	0xf9c
+#define ISP_REG_YCURVE_40	0xfa0
+#define ISP_REG_YCURVE_41	0xfa4
+#define ISP_REG_YCURVE_42	0xfa8
+#define ISP_REG_YCURVE_43	0xfac
+#define ISP_REG_YCURVE_44	0xfb0
+#define ISP_REG_YCURVE_45	0xfb4
+#define ISP_REG_YCURVE_46	0xfb8
+#define ISP_REG_YCURVE_47	0xfbc
+#define ISP_REG_YCURVE_48	0xfc0
+#define ISP_REG_YCURVE_49	0xfc4
+#define ISP_REG_YCURVE_50	0xfc8
+#define ISP_REG_YCURVE_51	0xfcc
+#define ISP_REG_YCURVE_52	0xfd0
+#define ISP_REG_YCURVE_53	0xfd4
+#define ISP_REG_YCURVE_54	0xfd8
+#define ISP_REG_YCURVE_55	0xfdc
+#define ISP_REG_YCURVE_56	0xfe0
+#define ISP_REG_YCURVE_57	0xfe4
+#define ISP_REG_YCURVE_58	0xfe8
+#define ISP_REG_YCURVE_59	0xfec
+#define ISP_REG_YCURVE_60	0xff0
+#define ISP_REG_YCURVE_61	0xff4
+#define ISP_REG_YCURVE_62	0xff8
+#define ISP_REG_YCURVE_63	0xffc
+#define L_PARAM(n)	((n) << 0)
+
+/* The output line of ISP */
+enum isp_line_id {
+	STF_ISP_LINE_INVALID = -1,
+	STF_ISP_LINE_SRC = 1,
+	STF_ISP_LINE_MAX = STF_ISP_LINE_SRC
+};
+
+/* pad id for media framework */
+enum isp_pad_id {
+	STF_ISP_PAD_SINK = 0,
+	STF_ISP_PAD_SRC,
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
+	ISP_RECT_MAX
+};
+
+struct stf_isp_dev {
+	enum stf_subdev_type sdev_type;  /* This member must be first */
+	struct stfcamss *stfcamss;
+	struct v4l2_subdev subdev;
+	struct media_pad pads[STF_ISP_PAD_MAX];
+	struct v4l2_mbus_framefmt fmt[STF_ISP_PAD_MAX];
+	struct isp_stream_format rect[ISP_RECT_MAX];
+	const struct isp_format_table *formats;
+	unsigned int nformats;
+	struct mutex power_lock;	/* serialize power control*/
+	int power_count;
+	struct mutex stream_lock;	/* serialize stream control */
+	int stream_count;
+	atomic_t shadow_count;
+
+	struct mutex setfile_lock;	/* protects setting files */
+	struct isp_setfile setfile;
+};
+
+int stf_isp_clk_enable(struct stf_isp_dev *isp_dev);
+int stf_isp_clk_disable(struct stf_isp_dev *isp_dev);
+int stf_isp_reset(struct stf_isp_dev *isp_dev);
+int stf_isp_config_set(struct stf_isp_dev *isp_dev);
+int stf_isp_set_format(struct stf_isp_dev *isp_dev,
+		       struct isp_stream_format *crop_array,
+		       u32 mcode, int type);
+int stf_isp_stream_set(struct stf_isp_dev *isp_dev, int on);
+int stf_isp_subdev_init(struct stfcamss *stfcamss);
+int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
+int stf_isp_unregister(struct stf_isp_dev *isp_dev);
+
+#endif /* STF_ISP_H */
diff --git a/drivers/media/platform/starfive/stf_isp_hw_ops.c b/drivers/media/platform/starfive/stf_isp_hw_ops.c
new file mode 100644
index 000000000000..97258d0b6dbd
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_isp_hw_ops.c
@@ -0,0 +1,715 @@
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
+
+#include "stf_camss.h"
+
+static const struct regval_t isp_reg_init_config_list[] = {
+	/* config DC */
+	{ISP_REG_DC_CFG_1,	DC_AXI_ID(0x0), 0},
+	/* config DEC */
+	{ISP_REG_DEC_CFG,	DEC_V_KEEP(0x0) | DEC_V_PERIOD(0x0) |
+				DEC_H_KEEP(0x0) | DEC_H_PERIOD(0x0), 0},
+	/* config OBC */
+	{ISP_REG_OBC_CFG,	OBC_W_H(11) | OBC_W_W(11), 0},
+	{ISP_REG_OBCG_CFG_0,	D_S0(0x40) | C_S0(0x40) |
+				B_S0(0x40) | A_S0(0x40), 0},
+	{ISP_REG_OBCG_CFG_1,	D_S0(0x40) | C_S0(0x40) |
+				B_S0(0x40) | A_S0(0x40), 0},
+	{ISP_REG_OBCG_CFG_2,	D_S0(0x40) | C_S0(0x40) |
+				B_S0(0x40) | A_S0(0x40), 0},
+	{ISP_REG_OBCG_CFG_3,	D_S0(0x40) | C_S0(0x40) |
+				B_S0(0x40) | A_S0(0x40), 0},
+	/* config LCBQ */
+	{ISP_REG_LCBQ_CFG_0,	H_LCBQ(0x9) | W_LCBQ(0x9), 0},
+	{ISP_REG_LCBQ_CFG_1,	Y_COOR(0x1e4) | Y_COOR(0x40), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_0,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_1,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_2,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_3,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_4,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_5,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_6,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_7,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_8,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_9,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_10,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_11,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN0_CFG_12,	GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_0,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_1,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_2,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_3,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_4,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_5,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_6,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_7,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_8,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_9,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_10,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_11,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN1_CFG_12,	GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_0,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_1,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_2,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_3,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_4,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_5,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_6,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_7,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_8,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_9,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_10,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_11,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN2_CFG_12,	GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_0,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_1,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_2,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_3,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_4,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_5,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_6,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_7,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_8,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_9,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_10,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_11,	GAIN_H(0x100) | GAIN_L(0x100), 0},
+	{ISP_REG_LCBQ_GAIN3_CFG_12,	GAIN_L(0x100), 0},
+	/* config OECF */
+	{ISP_REG_OECF_X0_CFG_0,	OCEF_X_PAR_H(0x10) | OCEF_X_PAR_L(0x0), 0},
+	{ISP_REG_OECF_X0_CFG_1,	OCEF_X_PAR_H(0x40) | OCEF_X_PAR_L(0x20), 0},
+	{ISP_REG_OECF_X0_CFG_2,	OCEF_X_PAR_H(0x80) | OCEF_X_PAR_L(0x60), 0},
+	{ISP_REG_OECF_X0_CFG_4,	OCEF_X_PAR_H(0x100) | OCEF_X_PAR_L(0xe0), 0},
+	{ISP_REG_OECF_X0_CFG_5,	OCEF_X_PAR_H(0x200) | OCEF_X_PAR_L(0x180), 0},
+	{ISP_REG_OECF_X0_CFG_6,	OCEF_X_PAR_H(0x300) | OCEF_X_PAR_L(0x280), 0},
+	{ISP_REG_OECF_X0_CFG_7,	OCEF_X_PAR_H(0x3fe) | OCEF_X_PAR_L(0x380), 0},
+	{ISP_REG_OECF_X1_CFG_0,	OCEF_X_PAR_H(0x10) | OCEF_X_PAR_L(0x0), 0},
+	{ISP_REG_OECF_X1_CFG_1,	OCEF_X_PAR_H(0x40) | OCEF_X_PAR_L(0x20), 0},
+	{ISP_REG_OECF_X1_CFG_2,	OCEF_X_PAR_H(0x80) | OCEF_X_PAR_L(0x60), 0},
+	{ISP_REG_OECF_X1_CFG_3,	OCEF_X_PAR_H(0xc0) | OCEF_X_PAR_L(0xa0), 0},
+	{ISP_REG_OECF_X1_CFG_4,	OCEF_X_PAR_H(0x100) | OCEF_X_PAR_L(0xe0), 0},
+	{ISP_REG_OECF_X1_CFG_5,	OCEF_X_PAR_H(0x200) | OCEF_X_PAR_L(0x180), 0},
+	{ISP_REG_OECF_X1_CFG_6,	OCEF_X_PAR_H(0x300) | OCEF_X_PAR_L(0x280), 0},
+	{ISP_REG_OECF_X1_CFG_7,	OCEF_X_PAR_H(0x3fe) | OCEF_X_PAR_L(0x380), 0},
+	{ISP_REG_OECF_X2_CFG_0,	OCEF_X_PAR_H(0x10) | OCEF_X_PAR_L(0x0), 0},
+	{ISP_REG_OECF_X2_CFG_1,	OCEF_X_PAR_H(0x40) | OCEF_X_PAR_L(0x20), 0},
+	{ISP_REG_OECF_X2_CFG_2,	OCEF_X_PAR_H(0x80) | OCEF_X_PAR_L(0x60), 0},
+	{ISP_REG_OECF_X2_CFG_3,	OCEF_X_PAR_H(0xc0) | OCEF_X_PAR_L(0xa0), 0},
+	{ISP_REG_OECF_X2_CFG_4,	OCEF_X_PAR_H(0x100) | OCEF_X_PAR_L(0xe0), 0},
+	{ISP_REG_OECF_X2_CFG_5,	OCEF_X_PAR_H(0x200) | OCEF_X_PAR_L(0x180), 0},
+	{ISP_REG_OECF_X2_CFG_6,	OCEF_X_PAR_H(0x300) | OCEF_X_PAR_L(0x280), 0},
+	{ISP_REG_OECF_X2_CFG_7,	OCEF_X_PAR_H(0x3fe) | OCEF_X_PAR_L(0x380), 0},
+	{ISP_REG_OECF_X3_CFG_0,	OCEF_X_PAR_H(0x10) | OCEF_X_PAR_L(0x0), 0},
+	{ISP_REG_OECF_X3_CFG_1,	OCEF_X_PAR_H(0x40) | OCEF_X_PAR_L(0x20), 0},
+	{ISP_REG_OECF_X3_CFG_2,	OCEF_X_PAR_H(0x80) | OCEF_X_PAR_L(0x60), 0},
+	{ISP_REG_OECF_X3_CFG_3,	OCEF_X_PAR_H(0xc0) | OCEF_X_PAR_L(0xa0), 0},
+	{ISP_REG_OECF_X3_CFG_4,	OCEF_X_PAR_H(0x100) | OCEF_X_PAR_L(0xe0), 0},
+	{ISP_REG_OECF_X3_CFG_5,	OCEF_X_PAR_H(0x200) | OCEF_X_PAR_L(0x180), 0},
+	{ISP_REG_OECF_X3_CFG_6,	OCEF_X_PAR_H(0x300) | OCEF_X_PAR_L(0x280), 0},
+	{ISP_REG_OECF_X3_CFG_7,	OCEF_X_PAR_H(0x3fe) | OCEF_X_PAR_L(0x380), 0},
+
+	{ISP_REG_OECF_Y0_CFG_0,	OCEF_Y_PAR_H(0x10) | OCEF_Y_PAR_L(0x0), 0},
+	{ISP_REG_OECF_Y0_CFG_1,	OCEF_Y_PAR_H(0x40) | OCEF_Y_PAR_L(0x20), 0},
+	{ISP_REG_OECF_Y0_CFG_2,	OCEF_Y_PAR_H(0x80) | OCEF_Y_PAR_L(0x60), 0},
+	{ISP_REG_OECF_Y0_CFG_3,	OCEF_Y_PAR_H(0xc0) | OCEF_Y_PAR_L(0xa0), 0},
+	{ISP_REG_OECF_Y0_CFG_4,	OCEF_Y_PAR_H(0x100) | OCEF_Y_PAR_L(0xe0), 0},
+	{ISP_REG_OECF_Y0_CFG_5,	OCEF_Y_PAR_H(0x200) | OCEF_Y_PAR_L(0x180), 0},
+	{ISP_REG_OECF_Y0_CFG_6,	OCEF_Y_PAR_H(0x300) | OCEF_Y_PAR_L(0x280), 0},
+	{ISP_REG_OECF_Y0_CFG_7,	OCEF_Y_PAR_H(0x3fe) | OCEF_Y_PAR_L(0x380), 0},
+	{ISP_REG_OECF_Y1_CFG_0,	OCEF_Y_PAR_H(0x10) | OCEF_Y_PAR_L(0x0), 0},
+	{ISP_REG_OECF_Y1_CFG_1,	OCEF_Y_PAR_H(0x40) | OCEF_Y_PAR_L(0x20), 0},
+	{ISP_REG_OECF_Y1_CFG_2,	OCEF_Y_PAR_H(0x80) | OCEF_Y_PAR_L(0x60), 0},
+	{ISP_REG_OECF_Y1_CFG_3,	OCEF_Y_PAR_H(0xc0) | OCEF_Y_PAR_L(0xa0), 0},
+	{ISP_REG_OECF_Y1_CFG_4,	OCEF_Y_PAR_H(0x100) | OCEF_Y_PAR_L(0xe0), 0},
+	{ISP_REG_OECF_Y1_CFG_5,	OCEF_Y_PAR_H(0x200) | OCEF_Y_PAR_L(0x180), 0},
+	{ISP_REG_OECF_Y1_CFG_6,	OCEF_Y_PAR_H(0x300) | OCEF_Y_PAR_L(0x280), 0},
+	{ISP_REG_OECF_Y1_CFG_7,	OCEF_Y_PAR_H(0x3fe) | OCEF_Y_PAR_L(0x380), 0},
+	{ISP_REG_OECF_Y2_CFG_0,	OCEF_Y_PAR_H(0x10) | OCEF_Y_PAR_L(0x0), 0},
+	{ISP_REG_OECF_Y2_CFG_1,	OCEF_Y_PAR_H(0x40) | OCEF_Y_PAR_L(0x20), 0},
+	{ISP_REG_OECF_Y2_CFG_2,	OCEF_Y_PAR_H(0x80) | OCEF_Y_PAR_L(0x60), 0},
+	{ISP_REG_OECF_Y2_CFG_3,	OCEF_Y_PAR_H(0xc0) | OCEF_Y_PAR_L(0xa0), 0},
+	{ISP_REG_OECF_Y2_CFG_4,	OCEF_Y_PAR_H(0x100) | OCEF_Y_PAR_L(0xe0), 0},
+	{ISP_REG_OECF_Y2_CFG_5,	OCEF_Y_PAR_H(0x200) | OCEF_Y_PAR_L(0x180), 0},
+	{ISP_REG_OECF_Y2_CFG_6,	OCEF_Y_PAR_H(0x300) | OCEF_Y_PAR_L(0x280), 0},
+	{ISP_REG_OECF_Y2_CFG_7,	OCEF_Y_PAR_H(0x3fe) | OCEF_Y_PAR_L(0x380), 0},
+	{ISP_REG_OECF_Y3_CFG_0,	OCEF_Y_PAR_H(0x10) | OCEF_Y_PAR_L(0x0), 0},
+	{ISP_REG_OECF_Y3_CFG_1,	OCEF_Y_PAR_H(0x40) | OCEF_Y_PAR_L(0x20), 0},
+	{ISP_REG_OECF_Y3_CFG_2,	OCEF_Y_PAR_H(0x80) | OCEF_Y_PAR_L(0x60), 0},
+	{ISP_REG_OECF_Y3_CFG_3,	OCEF_Y_PAR_H(0xc0) | OCEF_Y_PAR_L(0xa0), 0},
+	{ISP_REG_OECF_Y3_CFG_4,	OCEF_Y_PAR_H(0x100) | OCEF_Y_PAR_L(0xe0), 0},
+	{ISP_REG_OECF_Y3_CFG_5,	OCEF_Y_PAR_H(0x200) | OCEF_Y_PAR_L(0x180), 0},
+	{ISP_REG_OECF_Y3_CFG_6,	OCEF_Y_PAR_H(0x300) | OCEF_Y_PAR_L(0x280), 0},
+	{ISP_REG_OECF_Y3_CFG_7,	OCEF_Y_PAR_H(0x3fe) | OCEF_Y_PAR_L(0x380), 0},
+
+	{ISP_REG_OECF_S0_CFG_0,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S0_CFG_1,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S0_CFG_2,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S0_CFG_3,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S0_CFG_4,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S0_CFG_5,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S0_CFG_6,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S0_CFG_7,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S1_CFG_0,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S1_CFG_1,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S1_CFG_2,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S1_CFG_3,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S1_CFG_4,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S1_CFG_5,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S1_CFG_6,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S1_CFG_7,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S2_CFG_0,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S2_CFG_1,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S2_CFG_2,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S2_CFG_3,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S2_CFG_4,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S2_CFG_5,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S2_CFG_6,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S2_CFG_7,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S3_CFG_0,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S3_CFG_1,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S3_CFG_2,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S3_CFG_3,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S3_CFG_4,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S3_CFG_5,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S3_CFG_6,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	{ISP_REG_OECF_S3_CFG_7,	OCEF_S_PAR_H(0x80) | OCEF_S_PAR_L(0x80), 0},
+	/* config OECFHM */
+	{ISP_REG_OECFHM_Y_CFG_0,	OECFHM_H(0x400) | OECFHM_H(0x0), 0},
+	{ISP_REG_OECFHM_Y_CFG_1,	OECFHM_H(0xC00) | OECFHM_H(0x800), 0},
+	{ISP_REG_OECFHM_Y_CFG_2,	OECFHM_H(0x0) | OECFHM_H(0xfff), 0},
+	{ISP_REG_OECFHM_S_CFG_0,	OECFHM_H(0x800) | OECFHM_H(0x800), 0},
+	{ISP_REG_OECFHM_S_CFG_1,	OECFHM_H(0x800) | OECFHM_H(0x800), 0},
+	{ISP_REG_OECFHM_S_CFG_2,	OECFHM_H(0x0) | OECFHM_H(0x800), 0},
+	/* config LCCF */
+	{ISP_REG_LCCF_CFG_0,	Y_DISTANCE(0x21C) | X_DISTANCE(0x3C0), 0},
+	{ISP_REG_LCCF_CFG_1,	LCCF_MAX_DIS(0xb), 0},
+	{ISP_REG_LCCF_CFG_2,	LCCF_F2_PAR(0x0) | LCCF_F1_PAR(0x0), 0},
+	{ISP_REG_LCCF_CFG_3,	LCCF_F2_PAR(0x0) | LCCF_F1_PAR(0x0), 0},
+	{ISP_REG_LCCF_CFG_4,	LCCF_F2_PAR(0x0) | LCCF_F1_PAR(0x0), 0},
+	{ISP_REG_LCCF_CFG_5,	LCCF_F2_PAR(0x0) | LCCF_F1_PAR(0x0), 0},
+	/* config AWB */
+	{ISP_REG_AWB_X0_CFG_0,	AWB_X_SYMBOL1(0x0) | AWB_X_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_X0_CFG_1,	AWB_X_SYMBOL1(0x0) | AWB_X_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_X1_CFG_0,	AWB_X_SYMBOL1(0x0) | AWB_X_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_X1_CFG_1,	AWB_X_SYMBOL1(0x0) | AWB_X_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_X2_CFG_0,	AWB_X_SYMBOL1(0x0) | AWB_X_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_X2_CFG_1,	AWB_X_SYMBOL1(0x0) | AWB_X_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_X3_CFG_0,	AWB_X_SYMBOL1(0x0) | AWB_X_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_X3_CFG_1,	AWB_X_SYMBOL1(0x0) | AWB_X_SYMBOL0(0x0), 0},
+
+	{ISP_REG_AWB_Y0_CFG_0,	AWB_Y_SYMBOL1(0x0) | AWB_Y_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_Y0_CFG_1,	AWB_Y_SYMBOL1(0x0) | AWB_Y_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_Y1_CFG_0,	AWB_Y_SYMBOL1(0x0) | AWB_Y_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_Y1_CFG_1,	AWB_Y_SYMBOL1(0x0) | AWB_Y_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_Y2_CFG_0,	AWB_Y_SYMBOL1(0x0) | AWB_Y_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_Y2_CFG_1,	AWB_Y_SYMBOL1(0x0) | AWB_Y_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_Y3_CFG_0,	AWB_Y_SYMBOL1(0x0) | AWB_Y_SYMBOL0(0x0), 0},
+	{ISP_REG_AWB_Y3_CFG_1,	AWB_Y_SYMBOL1(0x0) | AWB_Y_SYMBOL0(0x0), 0},
+
+	{ISP_REG_AWB_S0_CFG_0,	AWB_S_SYMBOL1(0x80) | AWB_S_SYMBOL0(0x80), 0},
+	{ISP_REG_AWB_S0_CFG_1,	AWB_S_SYMBOL1(0x80) | AWB_S_SYMBOL0(0x80), 0},
+	{ISP_REG_AWB_S1_CFG_0,	AWB_S_SYMBOL1(0x80) | AWB_S_SYMBOL0(0x80), 0},
+	{ISP_REG_AWB_S1_CFG_1,	AWB_S_SYMBOL1(0x80) | AWB_S_SYMBOL0(0x80), 0},
+	{ISP_REG_AWB_S2_CFG_0,	AWB_S_SYMBOL1(0x80) | AWB_S_SYMBOL0(0x80), 0},
+	{ISP_REG_AWB_S2_CFG_1,	AWB_S_SYMBOL1(0x80) | AWB_S_SYMBOL0(0x80), 0},
+	{ISP_REG_AWB_S3_CFG_0,	AWB_S_SYMBOL1(0x80) | AWB_S_SYMBOL0(0x80), 0},
+	{ISP_REG_AWB_S3_CFG_1,	AWB_S_SYMBOL1(0x80) | AWB_S_SYMBOL0(0x80), 0},
+	/* config CTC and DBC filter */
+	{ISP_REG_ICTC,	MAXGT(0x4140) | MINGT(0x40), 0},
+	{ISP_REG_IDBC,	BADGT(0x200) | BADXT(0x200), 0},
+	/* config CFA */
+	{ISP_REG_RAW_FORMAT_CFG,	SMY13(0) | SMY12(1) | SMY11(0) |
+					SMY10(1) | SMY3(2) | SMY2(3) |
+					SMY1(2) | SMY0(3), 0},
+	{ISP_REG_ICFAM,	CROSS_COV(3) | HV_W(2), 0},
+	/* config CCM */
+	{ISP_REG_ICAMD_0,	DNRM(6) | CCM_M_DAT(0), 0},
+	{ISP_REG_ICAMD_12,	CCM_M_DAT(0x80), 0},
+	{ISP_REG_ICAMD_16,	CCM_M_DAT(0x80), 0},
+	{ISP_REG_ICAMD_20,	CCM_M_DAT(0x80), 0},
+	{ISP_REG_ICAMD_24,	CCM_M_DAT(0x700), 0},
+	{ISP_REG_ICAMD_25,	CCM_M_DAT(0x200), 0},
+	/* config GMARGB */
+	{ISP_REG_IGRVAL_0,	SGVAL(0x2400) | GVAL(0x0), 0},
+	{ISP_REG_IGRVAL_1,	SGVAL(0x800) | GVAL(0x20), 0},
+	{ISP_REG_IGRVAL_2,	SGVAL(0x800) | GVAL(0x40), 0},
+	{ISP_REG_IGRVAL_3,	SGVAL(0x800) | GVAL(0x60), 0},
+	{ISP_REG_IGRVAL_4,	SGVAL(0x800) | GVAL(0x80), 0},
+	{ISP_REG_IGRVAL_5,	SGVAL(0x800) | GVAL(0xa0), 0},
+	{ISP_REG_IGRVAL_6,	SGVAL(0x800) | GVAL(0xc0), 0},
+	{ISP_REG_IGRVAL_7,	SGVAL(0x800) | GVAL(0xe0), 0},
+	{ISP_REG_IGRVAL_8,	SGVAL(0x800) | GVAL(0x100), 0},
+	{ISP_REG_IGRVAL_9,	SGVAL(0x800) | GVAL(0x180), 0},
+	{ISP_REG_IGRVAL_10,	SGVAL(0x800) | GVAL(0x200), 0},
+	{ISP_REG_IGRVAL_11,	SGVAL(0x800) | GVAL(0x280), 0},
+	{ISP_REG_IGRVAL_12,	SGVAL(0x800) | GVAL(0x300), 0},
+	{ISP_REG_IGRVAL_13,	SGVAL(0x800) | GVAL(0x380), 0},
+	{ISP_REG_IGRVAL_14,	SGVAL(0x800) | GVAL(0x3fe), 0},
+	/* config R2Y */
+	{ISP_REG_ICCONV_0,	CSC_M(0x4C), 0},
+	{ISP_REG_ICCONV_1,	CSC_M(0x97), 0},
+	{ISP_REG_ICCONV_2,	CSC_M(0x1d), 0},
+	{ISP_REG_ICCONV_3,	CSC_M(0x1d5), 0},
+	{ISP_REG_ICCONV_4,	CSC_M(0x1ac), 0},
+	{ISP_REG_ICCONV_5,	CSC_M(0x80), 0},
+	{ISP_REG_ICCONV_6,	CSC_M(0x80), 0},
+	{ISP_REG_ICCONV_7,	CSC_M(0x194), 0},
+	{ISP_REG_ICCONV_8,	CSC_M(0x1ec), 0},
+	/* config YCRV */
+	{ISP_REG_YCURVE_0,	L_PARAM(0x0), 0},
+	{ISP_REG_YCURVE_1,	L_PARAM(0x10), 0},
+	{ISP_REG_YCURVE_2,	L_PARAM(0x20), 0},
+	{ISP_REG_YCURVE_3,	L_PARAM(0x30), 0},
+	{ISP_REG_YCURVE_4,	L_PARAM(0x40), 0},
+	{ISP_REG_YCURVE_5,	L_PARAM(0x50), 0},
+	{ISP_REG_YCURVE_6,	L_PARAM(0x60), 0},
+	{ISP_REG_YCURVE_7,	L_PARAM(0x70), 0},
+	{ISP_REG_YCURVE_8,	L_PARAM(0x80), 0},
+	{ISP_REG_YCURVE_9,	L_PARAM(0x90), 0},
+	{ISP_REG_YCURVE_10,	L_PARAM(0xa0), 0},
+	{ISP_REG_YCURVE_11,	L_PARAM(0xb0), 0},
+	{ISP_REG_YCURVE_12,	L_PARAM(0xc0), 0},
+	{ISP_REG_YCURVE_13,	L_PARAM(0xd0), 0},
+	{ISP_REG_YCURVE_14,	L_PARAM(0xe0), 0},
+	{ISP_REG_YCURVE_15,	L_PARAM(0xf0), 0},
+	{ISP_REG_YCURVE_16,	L_PARAM(0x100), 0},
+	{ISP_REG_YCURVE_17,	L_PARAM(0x110), 0},
+	{ISP_REG_YCURVE_18,	L_PARAM(0x120), 0},
+	{ISP_REG_YCURVE_19,	L_PARAM(0x130), 0},
+	{ISP_REG_YCURVE_20,	L_PARAM(0x140), 0},
+	{ISP_REG_YCURVE_21,	L_PARAM(0x150), 0},
+	{ISP_REG_YCURVE_22,	L_PARAM(0x160), 0},
+	{ISP_REG_YCURVE_23,	L_PARAM(0x170), 0},
+	{ISP_REG_YCURVE_24,	L_PARAM(0x180), 0},
+	{ISP_REG_YCURVE_25,	L_PARAM(0x190), 0},
+	{ISP_REG_YCURVE_26,	L_PARAM(0x1a0), 0},
+	{ISP_REG_YCURVE_27,	L_PARAM(0x1b0), 0},
+	{ISP_REG_YCURVE_28,	L_PARAM(0x1c0), 0},
+	{ISP_REG_YCURVE_29,	L_PARAM(0x1d0), 0},
+	{ISP_REG_YCURVE_30,	L_PARAM(0x1e0), 0},
+	{ISP_REG_YCURVE_31,	L_PARAM(0x1f0), 0},
+	{ISP_REG_YCURVE_32,	L_PARAM(0x200), 0},
+	{ISP_REG_YCURVE_33,	L_PARAM(0x210), 0},
+	{ISP_REG_YCURVE_34,	L_PARAM(0x220), 0},
+	{ISP_REG_YCURVE_35,	L_PARAM(0x230), 0},
+	{ISP_REG_YCURVE_36,	L_PARAM(0x240), 0},
+	{ISP_REG_YCURVE_37,	L_PARAM(0x250), 0},
+	{ISP_REG_YCURVE_38,	L_PARAM(0x260), 0},
+	{ISP_REG_YCURVE_39,	L_PARAM(0x270), 0},
+	{ISP_REG_YCURVE_40,	L_PARAM(0x280), 0},
+	{ISP_REG_YCURVE_41,	L_PARAM(0x290), 0},
+	{ISP_REG_YCURVE_42,	L_PARAM(0x2a0), 0},
+	{ISP_REG_YCURVE_43,	L_PARAM(0x2b0), 0},
+	{ISP_REG_YCURVE_44,	L_PARAM(0x2c0), 0},
+	{ISP_REG_YCURVE_45,	L_PARAM(0x2d0), 0},
+	{ISP_REG_YCURVE_46,	L_PARAM(0x2e0), 0},
+	{ISP_REG_YCURVE_47,	L_PARAM(0x2f0), 0},
+	{ISP_REG_YCURVE_48,	L_PARAM(0x300), 0},
+	{ISP_REG_YCURVE_49,	L_PARAM(0x310), 0},
+	{ISP_REG_YCURVE_50,	L_PARAM(0x320), 0},
+	{ISP_REG_YCURVE_51,	L_PARAM(0x330), 0},
+	{ISP_REG_YCURVE_52,	L_PARAM(0x340), 0},
+	{ISP_REG_YCURVE_53,	L_PARAM(0x350), 0},
+	{ISP_REG_YCURVE_54,	L_PARAM(0x360), 0},
+	{ISP_REG_YCURVE_55,	L_PARAM(0x370), 0},
+	{ISP_REG_YCURVE_56,	L_PARAM(0x380), 0},
+	{ISP_REG_YCURVE_57,	L_PARAM(0x390), 0},
+	{ISP_REG_YCURVE_58,	L_PARAM(0x3a0), 0},
+	{ISP_REG_YCURVE_59,	L_PARAM(0x3b0), 0},
+	{ISP_REG_YCURVE_60,	L_PARAM(0x3c0), 0},
+	{ISP_REG_YCURVE_61,	L_PARAM(0x3d0), 0},
+	{ISP_REG_YCURVE_62,	L_PARAM(0x3e0), 0},
+	{ISP_REG_YCURVE_63,	L_PARAM(0x3f0), 0},
+	/* config Sharp */
+	{ISP_REG_ISHRP1_0,	DIFF(0x7) | SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_1,	DIFF(0x18) | SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_2,	DIFF(0x80) | SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_3,	DIFF(0x100) | SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_4,	DIFF(0x10) | SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_5,	DIFF(0x60) | SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_6,	DIFF(0x100) | SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_7,	DIFF(0x190) | SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_8,	DIFF(0x0) | SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_9,	SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_10,	SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_11,	SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_12,	SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_13,	SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP1_14,	SHRP_W(0xf), 0},
+	{ISP_REG_ISHRP2_0,	F_AMP(0x10) | S_AMP(0x0), 0},
+	{ISP_REG_ISHRP2_1,	F_AMP(0x10) | S_AMP(0x0), 0},
+	{ISP_REG_ISHRP2_2,	F_AMP(0x10) | S_AMP(0x0), 0},
+	{ISP_REG_ISHRP2_3,	F_AMP(0x10) | S_AMP(0x0), 0},
+	{ISP_REG_ISHRP2_4,	F_AMP(0x10) | S_AMP(0x0), 0},
+	{ISP_REG_ISHRP2_5,	F_AMP(0x10) | S_AMP(0x0), 0},
+	{ISP_REG_ISHRP3,	PDIRF(0x8) | NDIRF(0x8) | WSUM(0xd7c), 0},
+
+	{ISP_REG_IUVS1,	UVDIFF2(0xC0) | UVDIFF1(0x40), 0},
+	{ISP_REG_IUVS2,	UVF(0xff) | UVSLOPE(0x0), 0},
+	{ISP_REG_IUVCKS1,	UVCKDIFF2(0xa0) | UVCKDIFF1(0x40), 0},
+	/* config DNYUV */
+	{ISP_REG_DNYUV_YSWR0,	YUVSW5(7) | YUVSW4(7) | YUVSW3(7) | YUVSW2(7) |
+				YUVSW1(7) | YUVSW0(7), 0},
+	{ISP_REG_DNYUV_YSWR1,	YUVSW3(7) | YUVSW2(7) | YUVSW1(7) |
+				YUVSW0(7), 0},
+	{ISP_REG_DNYUV_CSWR0,	YUVSW5(7) | YUVSW4(7) | YUVSW3(7) | YUVSW2(7) |
+				YUVSW1(7) | YUVSW0(7), 0},
+	{ISP_REG_DNYUV_CSWR1,	YUVSW3(7) | YUVSW2(7) | YUVSW1(7) |
+				YUVSW0(7), 0},
+	{ISP_REG_DNYUV_YDR0,	CURVE_D_H(0x60) | CURVE_D_L(0x40), 0},
+	{ISP_REG_DNYUV_YDR1,	CURVE_D_H(0xd8) | CURVE_D_L(0x90), 0},
+	{ISP_REG_DNYUV_YDR2,	CURVE_D_H(0x1e6) | CURVE_D_L(0x144), 0},
+	{ISP_REG_DNYUV_CDR0,	CURVE_D_H(0x60) | CURVE_D_L(0x40), 0},
+	{ISP_REG_DNYUV_CDR1,	CURVE_D_H(0xd8) | CURVE_D_L(0x90), 0},
+	{ISP_REG_DNYUV_CDR2,	CURVE_D_H(0x1e6) | CURVE_D_L(0x144), 0},
+	/* config SAT */
+	{ISP_REG_ISAT0,	CMMD(0x0) | CMAB(0x100), 0},
+	{ISP_REG_ISAT1,	CMD(0x1f) | CMB(0x1), 0},
+	{ISP_REG_ISAT2,	VOFF(0x0) | UOFF(0x0), 0},
+	{ISP_REG_ISAT3,	SIN(0x0) | COS(0x100), 0},
+	{ISP_REG_ISAT4,	CMSF(0x8), 0},
+	{ISP_REG_IYADJ0,	YOIR(0x401) | YIMIN(0x1), 0},
+	{ISP_REG_IYADJ1,	YOMAX(0x3ff) | YOMIN(0x1), 0},
+	/* config OBA */
+	{ISP_REG_OBA_CFG_0,	VSTART(0x438) | HSTART(0x0), 0},
+	{ISP_REG_OBA_CFG_1,	VEND(0x439) | HEND(0x780), 0},
+	/* config SC */
+	{ISP_REG_SCD_CFG_1,	AXI_ID(0x01), 0},
+	{ISP_REG_SC_CFG_0,	VSTART_SC(0xc) | HSTART_SC(0x0), 0},
+	{ISP_REG_SC_CFG_1,	SEL_SC(3) | AWB_PS_GRB_BA(0x10) |
+				HEIGHT_SC(0x15) | WIDTH_SC(0x1d), 0},
+	{ISP_REG_SC_AF,	AF_ES_HTHR(0x1f1) | AF_ES_VTHR(0xbf) |
+			AF_ES_VE(0x1), 0},
+	{ISP_REG_SC_AWB_PS_CFG_0,	AWB_PS_GU(0xff) | AWB_PS_GL(0x0) |
+					AWB_PS_RU(0xff) | AWB_PS_RL(0x0), 0},
+	{ISP_REG_SC_AWB_PS_CFG_1,	AWB_PS_YU(0xff) | AWB_PS_YL(0x0) |
+					AWB_PS_BU(0xff) | AWB_PS_BL(0x0), 0},
+	{ISP_REG_SC_AWB_PS_CFG_2,	AWB_PS_GRU(0xffff) |
+					AWB_PS_GRL(0x0), 0},
+	{ISP_REG_SC_AWB_PS_CFG_3,	AWB_PS_GBU(0xffff) |
+					AWB_PS_GBL(0x0), 0},
+	{ISP_REG_SC_AWB_PS_CFG_4,	AWB_PS_GRBU(0xffff) |
+					AWB_PS_GRBL(0x0), 0},
+	{ISP_REG_SC_DEC,	VKEEP(0x1) | VPERIOD(0x5) | HKEEP(0x1) |
+				HPERIOD(0x7), 0},
+	{ISP_REG_SC_AWB_WS_CW4_CFG_0,	AWB_WS_CW_W_5(0x1), 0},
+	{ISP_REG_SC_AWB_WS_CW5_CFG_0,	AWB_WS_CW_W_6(0x3) |
+					AWB_WS_CW_W_5(0xd) |
+					AWB_WS_CW_W_4(0x2), 0},
+	{ISP_REG_SC_AWB_WS_CW6_CFG_0,	AWB_WS_CW_W_5(0x9) |
+					AWB_WS_CW_W_4(0x5), 0},
+	{ISP_REG_SC_AWB_WS_CW7_CFG_0,	AWB_WS_CW_W_5(0x2) |
+					AWB_WS_CW_W_4(0x5) |
+					AWB_WS_CW_W_3(0x3), 0},
+	{ISP_REG_SC_AWB_WS_IWV_CFG_0,	AWB_WS_IW_V_7(0xf) |
+					AWB_WS_IW_V_6(0xf) |
+					AWB_WS_IW_V_5(0xf) |
+					AWB_WS_IW_V_4(0xf) |
+					AWB_WS_IW_V_3(0xf) |
+					AWB_WS_IW_V_2(0xf) |
+					AWB_WS_IW_V_1(0xf) |
+					AWB_WS_IW_V_0(0x0), 0},
+	{ISP_REG_SC_AWB_WS_IWV_CFG_1,	AWB_WS_IW_V_7(0x8) |
+					AWB_WS_IW_V_6(0xf) |
+					AWB_WS_IW_V_5(0xf) |
+					AWB_WS_IW_V_4(0xf) |
+					AWB_WS_IW_V_3(0xf) |
+					AWB_WS_IW_V_2(0xf) |
+					AWB_WS_IW_V_1(0xf) |
+					AWB_WS_IW_V_0(0xf), 0},
+	{ISP_REG_SC_AWB_WS_IWS_CFG_0,	AWB_WS_IW_S0(0x1e), 0},
+	{ISP_REG_SC_AWB_WS_IWS_CFG_3,	AWB_WS_IW_S3(0xf0) |
+					AWB_WS_IW_S2(0xf2), 0},
+	{ISP_REG_SC_AWB_WS_CFG_0,	AWB_WS_GRU(0xff) | AWB_WS_GRL(0x0) |
+					AWB_WS_RU(0xff) | AWB_WS_RL(0x0), 0},
+	{ISP_REG_SC_AWB_WS_CFG_1,	AWB_WS_BU(0xff) | AWB_WS_BL(0x0) |
+					AWB_WS_GBU(0xff) | AWB_WS_GBL(0x0), 0},
+	/* config YHIST */
+	{ISP_REG_YHIST_CFG_0,	YH_VSTART(0x0) | YH_HSTART(0x0), 0},
+	{ISP_REG_YHIST_CFG_1,	YH_HEIGHT(0x437) | YH_WIDTH(0x77f), 0},
+	{ISP_REG_YHIST_CFG_2,	YH_DEC_ETH(0x1) | YH_DEC_ETW(0x2), 0},
+	{ISP_REG_YHIST_CFG_3,	YH_MUX(0x0), 0},
+	/* config CBAR */
+	{ISP_REG_CBAR0,	CBAR_PAR_H(0x43e) | CBAR_PAR_L(0x782), 0},
+	{ISP_REG_CBAR1,	CBAR_PAR_H(0x0) | CBAR_PAR_L(0x0), 0},
+	{ISP_REG_CBAR2,	CBAR_PAR_H(0x437) | CBAR_PAR_L(0x77f), 0},
+	{ISP_REG_CBAR3,	CBAR_PAR_H(0x44) | CBAR_PAR_L(0x3150), 0},
+	{ISP_REG_CBAR4,	CBAR_PAR_H(0x0) | CBAR_PAR_L(0x0), 0},
+	{ISP_REG_CBAR5,	CBAR_PAR_H(0x0888) | CBAR_PAR_L(0x0888), 0},
+	{ISP_REG_CBAR6,	CBAR_PAR_H(0x0222) | CBAR_PAR_L(0x0222), 0},
+	{ISP_REG_CBAR7,	CBAR_PAR_H(0x0444) | CBAR_PAR_L(0x0444), 0},
+	{ISP_REG_CBAR8,	CBAR_PAR_H(0x0888) | CBAR_PAR_L(0x0888), 0},
+	{ISP_REG_CBAR9,	CBAR_PAR_H(0x0aaa) | CBAR_PAR_L(0x0aaa), 0},
+	{ISP_REG_CBAR10,	CBAR_PAR_H(0x0ccc) | CBAR_PAR_L(0x0ccc), 0},
+	{ISP_REG_CBAR11,	CBAR_PAR_H(0x0eee) | CBAR_PAR_L(0x0eee), 0},
+	{ISP_REG_CBAR12,	CBAR_PAR_H(0x0fff) | CBAR_PAR_L(0x0fff), 0},
+	{ISP_REG_CBAR13,	CBAR_PAR_H(0x0888) | CBAR_PAR_L(0x0888), 0},
+	{ISP_REG_CBAR14,	CBAR_PAR_H(0x0222) | CBAR_PAR_L(0x0222), 0},
+	{ISP_REG_CBAR15,	CBAR_PAR_H(0x0444) | CBAR_PAR_L(0x0444), 0},
+	{ISP_REG_CBAR16,	CBAR_PAR_H(0x0888) | CBAR_PAR_L(0x0888), 0},
+	{ISP_REG_CBAR17,	CBAR_PAR_H(0x0aaa) | CBAR_PAR_L(0x0aaa), 0},
+	{ISP_REG_CBAR18,	CBAR_PAR_H(0x0ccc) | CBAR_PAR_L(0x0ccc), 0},
+	{ISP_REG_CBAR19,	CBAR_PAR_H(0x0eee) | CBAR_PAR_L(0x0eee), 0},
+	{ISP_REG_CBAR20,	CBAR_PAR_H(0x0fff) | CBAR_PAR_L(0x0fff), 0},
+	/* config sensor */
+	{ISP_REG_SENSOR,	DVP_SYNC_POL(0x3) | ITU656_EN(0) |
+				IMAGER_SEL(0), 0},
+	/* config CROP */
+	{ISP_REG_PIC_CAPTURE_START_CFG,	VSTART_CAP(0x0) | HSTART_CAP(0x0), 0},
+	{ISP_REG_PIC_CAPTURE_END_CFG,	VEND_CAP(0x0437) |
+					HEND_CAP(0x077f), 0},
+	/* config isp pileline X/Y size */
+	{ISP_REG_PIPELINE_XY_SIZE,	H_ACT_CAP(0x0438) |
+					W_ACT_CAP(0x0780), 0},
+	/* config CSI dump */
+	{ISP_REG_DUMP_CFG_1,	DUMP_BURST_LEN(0x3) | DUMP_SD(0x0b80), 0},
+	/* config UO */
+	{ISP_REG_STRIDE,	IMG_STR(0x0780), 0},
+	/* NV12 */
+	{ISP_REG_PIXEL_COORDINATE_GEN,	OUT_SCANH(0x0), 0},
+
+	{ISP_REG_UOAXI,	OUT_AXI_W_ID(0x0), 0},
+	{ISP_REG_SS0S,	SD_IMG(0x780), 0},
+	{ISP_REG_SS0HF,	H_SF_SCAL(0x0) | H_SM_SCAL(0x2), 0},
+	{ISP_REG_SS0VF,	V_SF_SCAL(0x0) | V_SM_SCAL(0x2), 0},
+	{ISP_REG_SS0IW,	W_OUT(0x0780) | H_OUT(0x0438), 0},
+	{ISP_REG_SS1S,	OUT_IMG_STR(0x780), 0},
+	{ISP_REG_SS1HF,	H_SCAL_FACTOR(0x0) | H_SCAL_MODE(0x2), 0},
+	{ISP_REG_SS1VF,	V_SCAL_FACTOR(0x0) | V_SCAL_MODE(0x2), 0},
+	{ISP_REG_SS1IW,	W_OUT_IMG(0x780) | H_OUT_IMG(0x438), 0},
+	{ISP_REG_SSAXI,	SS1WID(0x0) | SS0WID(0x0), 0},
+	/* config TIL */
+	{ISP_REG_ITIIWSR,	ITI_HSIZE(0x0438) | ITI_WSIZE(0x0780), 0},
+	{ISP_REG_ITIDWLSR,	ITI_WSTRIDE(0x960), 0},
+	{ISP_REG_ITIPDFR,	ITI_PACKAGE_FMT(0x30003), 0},
+	{ISP_REG_ITIDRLSR,	ITI_STRIDE_L(0x960), 0},
+	{ISP_REG_ITIAIR,	ITI_UVRID(0x0) | ITI_YRID(0x0) |
+				ITI_UVWID(0x0) | ITI_YWID(0x0), 0},
+	{ISP_REG_ITIDPSR,	ITI_W_INDEX(0x0) | ITI_R_INDEX(0x0), 0},
+	/* Enable DEC/OBC/OECF/LCCF/AWB/SC/DUMP */
+	{ISP_REG_CSI_MODULE_CFG,	CSI_DUMP_EN | CSI_SC_EN | CSI_AWB_EN |
+					CSI_LCCF_EN | CSI_OECF_EN | CSI_OBC_EN |
+					CSI_DEC_EN, 0},
+	/* Enable CFA/CAR/CCM/GMARGB/R2Y/SHRP/SAT/DNYUV/YCRV/YHIST/CTC/DBC */
+	{ISP_REG_ISP_CTRL_1,	CTRL_SAT(1) | CTRL_DBC | CTRL_CTC | CTRL_YHIST |
+				CTRL_YCURVE | CTRL_BIYUV | CTRL_SCE | CTRL_EE |
+				CTRL_CCE | CTRL_RGE | CTRL_CME | CTRL_AE |
+				CTRL_CE, 0},
+};
+
+const struct reg_table isp_reg_init_settings[] = {
+	{isp_reg_init_config_list, ARRAY_SIZE(isp_reg_init_config_list)},
+};
+
+static const struct regval_t isp_reg_start_config_list[] = {
+	/* ENABLE UO/Multi-Frame and Reset ISP */
+	{ISP_REG_ISP_CTRL_0,	ISPC_ENUO | ISPC_ENLS | ISPC_RST, 0xa},
+	/* ENABLE UO/Multi-Frame and Leave ISP reset */
+	{ISP_REG_ISP_CTRL_0,	ISPC_ENUO | ISPC_ENLS, 0xa},
+	/* Config ISP shadow mode as next-vsync */
+	{ISP_REG_IESHD_ADDR,	SHAD_UP_M, 0},
+	/* ENABLE UO/Multi-Frame and Enable ISP */
+	{ISP_REG_ISP_CTRL_0,	ISPC_ENUO | ISPC_ENLS | ISPC_EN, 0xa},
+	/* Config CSI shadow mode as immediate to fetch current setting */
+	{ISP_REG_CSIINTS_ADDR,	CSI_SHA_M(0x10004), 0xa},
+	/* Config CSI shadow mode as next-vsync */
+	{ISP_REG_CSIINTS_ADDR,	CSI_SHA_M(0x20004), 0xa},
+	/* Enable CSI */
+	{ISP_REG_CSI_INPUT_EN_AND_STATUS,	CSI_EN_S, 0xa},
+};
+
+const struct reg_table isp_reg_start_settings[] = {
+	{isp_reg_start_config_list, ARRAY_SIZE(isp_reg_start_config_list)},
+};
+
+static void isp_load_regs(struct stfcamss *stfcamss,
+			  const struct reg_table *table)
+{
+	int j;
+	u32 delay_ms, reg_addr, val;
+
+	for (j = 0; j < table->regval_num; j++) {
+		delay_ms = table->regval[j].delay_ms;
+		reg_addr = table->regval[j].addr;
+		val = table->regval[j].val;
+
+		if (reg_addr % 4 ||
+		    reg_addr > STF_ISP_REG_OFFSET_MAX ||
+		    delay_ms > STF_ISP_REG_DELAY_MAX)
+			continue;
+
+		stf_isp_reg_write(stfcamss, reg_addr, val);
+
+		if (delay_ms)
+			usleep_range(1000 * delay_ms, 1000 * delay_ms + 100);
+	}
+}
+
+static void isp_load_regs_exclude_csi_isp_enable(struct stfcamss *stfcamss,
+						 const struct reg_table *table)
+{
+	int j;
+	u32 delay_ms, reg_addr, val;
+
+	for (j = 0; j < table->regval_num; j++) {
+		delay_ms = table->regval[j].delay_ms;
+		reg_addr = table->regval[j].addr;
+		val = table->regval[j].val;
+
+		if (reg_addr % 4 ||
+		    reg_addr > STF_ISP_REG_OFFSET_MAX ||
+		    delay_ms > STF_ISP_REG_DELAY_MAX ||
+		    (reg_addr == ISP_REG_CSI_INPUT_EN_AND_STATUS && (val & 0x01)) ||
+		    (reg_addr == ISP_REG_ISP_CTRL_0 && (val & 0x01)))
+			continue;
+
+		stf_isp_reg_write(stfcamss, reg_addr, val);
+
+		if (delay_ms)
+			usleep_range(1000 * delay_ms, 1000 * delay_ms + 100);
+	}
+}
+
+int stf_isp_clk_enable(struct stf_isp_dev *isp_dev)
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
+int stf_isp_clk_disable(struct stf_isp_dev *isp_dev)
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
+int stf_isp_reset(struct stf_isp_dev *isp_dev)
+{
+	stf_isp_reg_set_bit(isp_dev->stfcamss, ISP_REG_ISP_CTRL_0,
+			    ISPC_RST_MASK, ISPC_RST);
+	stf_isp_reg_set_bit(isp_dev->stfcamss, ISP_REG_ISP_CTRL_0,
+			    ISPC_RST_MASK, 0);
+
+	return 0;
+}
+
+int stf_isp_config_set(struct stf_isp_dev *isp_dev)
+{
+	mutex_lock(&isp_dev->setfile_lock);
+	isp_load_regs(isp_dev->stfcamss, isp_reg_init_settings);
+	if (isp_dev->setfile.state)
+		isp_load_regs_exclude_csi_isp_enable(isp_dev->stfcamss,
+						     &isp_dev->setfile.settings);
+
+	mutex_unlock(&isp_dev->setfile_lock);
+
+	return 0;
+}
+
+int stf_isp_set_format(struct stf_isp_dev *isp_dev,
+		       struct isp_stream_format *crop_array,
+		       u32 mcode, int type)
+{
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+	struct v4l2_rect *crop = &crop_array[ISP_COMPOSE].rect;
+	u32 bpp = crop_array[ISP_COMPOSE].bpp;
+	u32 val, val1;
+
+	val = VSTART_CAP(crop->top) | HSTART_CAP(crop->left);
+	stf_isp_reg_write(stfcamss, ISP_REG_PIC_CAPTURE_START_CFG, val);
+
+	val = VEND_CAP(crop->height + crop->top - 1) |
+	      HEND_CAP(crop->width + crop->left - 1);
+	stf_isp_reg_write(stfcamss, ISP_REG_PIC_CAPTURE_END_CFG, val);
+
+	val = H_ACT_CAP(crop->height) | W_ACT_CAP(crop->width);
+	stf_isp_reg_write(stfcamss, ISP_REG_PIPELINE_XY_SIZE, val);
+
+	val = ALIGN(crop->width * bpp / 8, STFCAMSS_FRAME_WIDTH_ALIGN_8);
+	stf_isp_reg_write(stfcamss, ISP_REG_STRIDE, val);
+
+	switch (mcode) {
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		/* 3 2 3 2 1 0 1 0 B Gb B Gb Gr R Gr R */
+		val = SMY13(3) | SMY12(2) | SMY11(3) | SMY10(2) |
+		      SMY3(1) | SMY2(0) | SMY1(1) | SMY0(0);
+		val1 = CTRL_SAT(0x0);
+		break;
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+		/* 2 3 2 3 0 1 0 1, Gb B Gb B R Gr R Gr */
+		val = SMY13(2) | SMY12(3) | SMY11(2) | SMY10(3) |
+		      SMY3(0) | SMY2(1) | SMY1(0) | SMY0(1);
+		val1 = CTRL_SAT(0x2);
+		break;
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+		/* 1 0 1 0 3 2 3 2, Gr R Gr R B Gb B Gb */
+		val = SMY13(1) | SMY12(0) | SMY11(1) | SMY10(0) |
+		      SMY3(3) | SMY2(2) | SMY1(3) | SMY0(2);
+		val1 = CTRL_SAT(0x3);
+		break;
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+		/* 0 1 0 1 2 3 2 3 R Gr R Gr Gb B Gb B */
+		val = SMY13(0) | SMY12(1) | SMY11(0) | SMY10(1) |
+		      SMY3(2) | SMY2(3) | SMY1(2) | SMY0(3);
+		val1 = CTRL_SAT(0x1);
+		break;
+	default:
+		dev_warn(isp_dev->stfcamss->dev, "UNKNOWN format\n");
+		val = SMY13(0) | SMY12(1) | SMY11(0) | SMY10(1) |
+		      SMY3(2) | SMY2(3) | SMY1(2) | SMY0(3);
+		val1 = CTRL_SAT(0x1);
+		break;
+	}
+	stf_isp_reg_write(stfcamss, ISP_REG_RAW_FORMAT_CFG, val);
+	stf_isp_reg_set_bit(stfcamss, ISP_REG_ISP_CTRL_1, CTRL_SAT_MASK, val1);
+
+	crop = &crop_array[ISP_CROP].rect;
+	bpp = crop_array[ISP_CROP].bpp;
+	val = ALIGN(crop->width * bpp / 8, STFCAMSS_FRAME_WIDTH_ALIGN_128);
+	val |= DUMP_BURST_LEN(3);
+	stf_isp_reg_set_bit(stfcamss, ISP_REG_DUMP_CFG_1,
+			    DUMP_BURST_LEN_MASK | DUMP_SD_MASK, val);
+
+	val = ITI_HSIZE(0x0438) | ITI_WSIZE(0x0780);
+	stf_isp_reg_write(stfcamss, ISP_REG_ITIIWSR, val);
+
+	val = ITI_WSTRIDE(0x960);
+	stf_isp_reg_write(stfcamss, ISP_REG_ITIDWLSR, val);
+
+	val = ITI_STRIDE_L(0x960);
+	stf_isp_reg_write(stfcamss, ISP_REG_ITIDRLSR, val);
+
+	val = 0x0;
+	if (type == INTERFACE_CSI)
+		val = 0x1;
+	stf_isp_reg_write(stfcamss, ISP_REG_SENSOR, val);
+
+	return 0;
+}
+
+int stf_isp_stream_set(struct stf_isp_dev *isp_dev, int on)
+{
+	if (on)
+		isp_load_regs(isp_dev->stfcamss, isp_reg_start_settings);
+	return 0;
+}
diff --git a/drivers/media/platform/starfive/stf_video.c b/drivers/media/platform/starfive/stf_video.c
new file mode 100644
index 000000000000..6290aaf32aed
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_video.c
@@ -0,0 +1,989 @@
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
+		dev_err(video->stfcamss->dev,
+			"%s: error size is zero!!!\n", __func__);
+
+	dev_dbg(video->stfcamss->dev, "planes = %d, size = %d\n",
+		*num_planes, sizes[0]);
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
+		dev_err(video->stfcamss->dev,
+			"sizeimage = %d, plane size = %d\n",
+			fmt->sizeimage, (unsigned int)vb2_plane_size(vb, 0));
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
+		dev_err(video->stfcamss->dev,
+			"%s, not match:\n"
+			"0x%x 0x%x\n0x%x 0x%x\n0x%x 0x%x\n",
+			__func__,
+			pix->pixelformat, sd_pix->pixelformat,
+			pix->height, sd_pix->height,
+			pix->field, format.fmt.pix.field);
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
+		dev_err(video->stfcamss->dev,
+			"Failed to media_pipeline_start: %d\n", ret);
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
+	struct stfcamss_video *video = video_drvdata(file);
+	int i;
+
+	if (fsize->index)
+		return -EINVAL;
+
+	for (i = 0; i < video->nformats; i++) {
+		if (video->formats[i].pixelformat == fsize->pixel_format)
+			break;
+	}
+
+	if (i == video->nformats)
+		return -EINVAL;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
+	fsize->stepwise.min_width = STFCAMSS_FRAME_MIN_WIDTH;
+	fsize->stepwise.max_width = STFCAMSS_FRAME_MAX_WIDTH;
+	fsize->stepwise.min_height = STFCAMSS_FRAME_MIN_HEIGHT;
+	fsize->stepwise.max_height = STFCAMSS_FRAME_MAX_HEIGHT;
+	fsize->stepwise.step_width = 1;
+	fsize->stepwise.step_height = 1;
+
+	return 0;
+}
+
+static int video_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+
+	*f = video->active_fmt;
+
+	return 0;
+}
+
+static int video_getcrop_pad_id(int video_id)
+{
+	return stf_vin_map_isp_pad(video_id, STF_ISP_PAD_SRC);
+}
+
+static int video_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	int ret;
+
+	if (vb2_is_busy(&video->vb2_q))
+		return -EBUSY;
+
+	ret = __video_try_fmt(video, f);
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
+	return ret;
+}
+
+static const struct v4l2_ioctl_ops stf_vid_vin_ioctl_ops = {
+	.vidioc_querycap                = video_querycap,
+	.vidioc_enum_fmt_vid_cap        = video_enum_fmt,
+	.vidioc_enum_fmt_vid_out        = video_enum_fmt,
+	.vidioc_enum_framesizes         = video_enum_framesizes,
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
+};
+
+static const struct v4l2_ioctl_ops stf_vid_isp_ioctl_ops = {
+	.vidioc_querycap                = video_querycap,
+	.vidioc_enum_fmt_vid_cap        = video_enum_fmt,
+	.vidioc_enum_fmt_vid_out        = video_enum_fmt,
+	.vidioc_enum_framesizes         = video_enum_framesizes,
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
+		dev_err(video->stfcamss->dev,
+			"Failed to power up pipeline: %d\n", ret);
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
+		dev_err(video->stfcamss->dev,
+			"Failed to init vb2 queue: %d\n", ret);
+		goto err_vb2_init;
+	}
+
+	pad->flags = MEDIA_PAD_FL_SINK;
+	ret = media_entity_pads_init(&vdev->entity, 1, pad);
+	if (ret < 0) {
+		dev_err(video->stfcamss->dev,
+			"Failed to init video entity: %d\n", ret);
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
+	} else if (isp_pad == STF_ISP_PAD_SRC) {
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
+		dev_err(video->stfcamss->dev,
+			"Failed to init format: %d\n", ret);
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
+		dev_err(video->stfcamss->dev,
+			"Failed to register video device: %d\n", ret);
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
index 000000000000..54a12c9d610f
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_vin.c
@@ -0,0 +1,1151 @@
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
+	if (line > VIN_LINE_WR && line < VIN_LINE_MAX)
+		line_id = STF_ISP_LINE_SRC;
+	else
+		line_id = STF_ISP_LINE_INVALID;
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
+	struct stf_vin_dev *vin_dev = &stfcamss->vin_dev;
+	int i, ret = 0;
+
+	vin_dev->stfcamss = stfcamss;
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
+			       stfcamss->irq[STF_IRQ_VINWR],
+			       stf_vin_wr_irq_handler,
+			       0, "vin_axiwr_irq", vin_dev);
+	if (ret) {
+		dev_err(dev, "Failed to request irq\n");
+		goto out;
+	}
+
+	ret = devm_request_irq(dev,
+			       stfcamss->irq[STF_IRQ_ISP],
+			       stf_vin_isp_irq_handler,
+			       0, "vin_isp_irq", vin_dev);
+	if (ret) {
+		dev_err(dev, "Failed to request isp irq\n");
+		goto out;
+	}
+
+	ret = devm_request_irq(dev,
+			       stfcamss->irq[STF_IRQ_ISPCSIL],
+			       stf_vin_isp_irq_csiline_handler,
+			       0, "vin_isp_irq_csiline", vin_dev);
+	if (ret) {
+		dev_err(dev, "failed to request isp irq csiline\n");
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
+	for (i = VIN_LINE_WR; i < STF_ISP_LINE_MAX + 1; i++) {
+		struct vin_line *l = &vin_dev->line[i];
+
+		l->video_out.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		l->video_out.stfcamss = stfcamss;
+		l->id = i;
+		l->sdev_type = STF_SUBDEV_TYPE_VIN;
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
+			dev_err(stfcamss->dev,
+				"line power off on power_count = 0\n");
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
+			stf_vin_clk_enable(vin_dev, link);
+		}
+		vin_dev->power_count++;
+	} else {
+		if (vin_dev->power_count == 0) {
+			dev_err(stfcamss->dev,
+				"vin_dev power off on power_count=0\n");
+			goto exit;
+		}
+		if (vin_dev->power_count == 1)
+			pm_runtime_put_sync(stfcamss->dev);
+
+		vin_dev->power_count--;
+	}
+exit:
+
+	mutex_unlock(&vin_dev->power_lock);
+
+	return 0;
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
+		} else if (i == STF_ISP_PAD_SRC) {
+			aligns = ALIGN(fmt->width,
+				       STFCAMSS_FRAME_WIDTH_ALIGN_8);
+			buffer->buffer_size =
+				PAGE_ALIGN(aligns * fmt->height * 3 / 2);
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
+			if (i == STF_ISP_PAD_SRC)
+				buffer->paddr[1] =
+					(dma_addr_t)(buffer->paddr[0] + aligns * fmt->height);
+			else
+				dev_dbg(dev, "signal plane\n");
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
+			stf_vin_wr_set_ping_addr(vin_dev, buffer->paddr[0]);
+			stf_vin_wr_set_pong_addr(vin_dev, buffer->paddr[0]);
+		} else {
+			buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC];
+			stf_vin_isp_set_yuv_addr(vin_dev,
+						 buffer->paddr[0],
+						 buffer->paddr[1]);
+		}
+		break;
+	case STF_ISP_PAD_SRC:
+		buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC];
+		stf_vin_isp_set_yuv_addr(vin_dev,
+					 buffer->paddr[0],
+					 buffer->paddr[1]);
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
+	enum link link;
+
+	fmt = __vin_get_format(line, NULL,
+			       STF_VIN_PAD_SINK, V4L2_SUBDEV_FORMAT_ACTIVE);
+	mutex_lock(&dummy_buffer->stream_lock);
+	if (enable) {
+		if (dummy_buffer->stream_count == 0) {
+			vin_alloc_dummy_buffer(vin_dev, fmt, dummy_module);
+			vin_set_dummy_buffer(line, STF_VIN_PAD_SINK);
+			atomic_set(&dummy_buffer->frame_skip,
+				   VIN_FRAME_DROP_MIN_VAL + 30);
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
+			stf_vin_stream_set(vin_dev, 1, link);
+			if (line->id == VIN_LINE_WR) {
+				stf_vin_wr_irq_enable(vin_dev, 1);
+				stf_vin_wr_stream_set(vin_dev, 1);
+			}
+		}
+		line->stream_count++;
+	} else {
+		if (line->stream_count == 1) {
+			if (line->id == VIN_LINE_WR) {
+				stf_vin_wr_irq_enable(vin_dev, 0);
+				stf_vin_wr_stream_set(vin_dev, 0);
+			}
+			stf_vin_stream_set(vin_dev, 0, link);
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
+		stf_vin_isp_set_yuv_addr(vin_dev, y_addr, uv_addr);
+		break;
+	default:
+		if (line->id == VIN_LINE_WR) {
+			stf_vin_wr_set_ping_addr(vin_dev, ping_addr);
+			stf_vin_wr_set_pong_addr(vin_dev, ping_addr);
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
+		if (!output->buf[0]) {
+			output->buf[0] = new_buf;
+			vin_output_init_addrs(line);
+			output->state = VIN_OUTPUT_SINGLE;
+		} else {
+			vin_buf_add_pending(output, new_buf);
+		}
+		break;
+	case VIN_OUTPUT_STOPPING:
+		if (output->last_buffer) {
+			output->buf[output->active_buf] = output->last_buffer;
+			output->last_buffer = NULL;
+		}
+
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
+		dev_warn(vin_dev->stfcamss->dev, "Missing ready buf %d %d!\n",
+			 active_index, output->state);
+		active_index = !active_index;
+		ready_buf = output->buf[active_index];
+		if (!ready_buf) {
+			dev_err(vin_dev->stfcamss->dev,
+				"Missing ready buf2 %d %d!\n",
+				active_index, output->state);
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
+			stf_vin_isp_set_yuv_addr(vin_dev,
+						 new_addr[0],
+						 new_addr[1]);
+			break;
+		default:
+			if (line->id == VIN_LINE_WR) {
+				stf_vin_wr_set_ping_addr(vin_dev, new_addr[0]);
+				stf_vin_wr_set_pong_addr(vin_dev, new_addr[0]);
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
+			dev_err(vin_dev->stfcamss->dev,
+				"Failed to init format: %d\n", ret);
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
+			dev_err(vin_dev->stfcamss->dev,
+				"Failed to init media entity: %d\n",
+				ret);
+			goto err_init;
+		}
+
+		ret = v4l2_device_register_subdev(v4l2_dev, sd);
+		if (ret < 0) {
+			dev_err(vin_dev->stfcamss->dev,
+				"Failed to register subdev: %d\n", ret);
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
+			dev_err(vin_dev->stfcamss->dev,
+				"Failed to register video node: %d\n", ret);
+			goto err_vid_reg;
+		}
+
+		ret = media_create_pad_link(
+			&sd->entity, STF_VIN_PAD_SRC,
+			&video_out->vdev.entity, 0,
+			MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
+		if (ret < 0) {
+			dev_err(vin_dev->stfcamss->dev,
+				"Failed to link %s->%s entities: %d\n",
+				sd->entity.name, video_out->vdev.entity.name,
+				ret);
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
index 000000000000..f83fb0ad5dcf
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_vin.h
@@ -0,0 +1,174 @@
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
+#define U0_VIN_CNFG_MIPI_BYTE_EN_ISP0(n)	((n) << 6)
+#define U0_VIN_CNFG_MIPI_CHANNEL_SEL0(n)	((n) << 8)
+#define U0_VIN_CNFG_P_I_MIPI_HAEDER_EN0(n)	((n) << 12)
+#define U0_VIN_CNFG_PIX_NUM(n)	((n) << 13)
+#define U0_VIN_CNFG_MIPI_BYTE_EN_ISP0_MASK	GENMASK(7, 6)
+#define U0_VIN_CNFG_MIPI_CHANNEL_SEL0_MASK	GENMASK(11, 8)
+#define U0_VIN_CNFG_P_I_MIPI_HAEDER_EN0_MASK	BIT(12)
+#define U0_VIN_CNFG_PIX_NUM_MASK	GENMASK(16, 13)
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
+/* The vin output lines */
+enum vin_line_id {
+	VIN_LINE_NONE = -1,
+	VIN_LINE_WR = 0,
+	VIN_LINE_ISP,
+	VIN_LINE_MAX,
+};
+
+struct vin_line {
+	enum stf_subdev_type sdev_type;  /* must be frist */
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
+	struct vin_isr_ops *isr_ops;
+	atomic_t ref_count;
+	struct mutex power_lock;	/* serialize power control*/
+	int power_count;
+};
+
+int stf_vin_clk_enable(struct stf_vin_dev *vin_dev, enum link link);
+int stf_vin_wr_stream_set(struct stf_vin_dev *vin_dev, int on);
+int stf_vin_stream_set(struct stf_vin_dev *vin_dev, int on, enum link link);
+void stf_vin_wr_irq_enable(struct stf_vin_dev *vin_dev, int enable);
+void stf_vin_wr_set_ping_addr(struct stf_vin_dev *vin_dev, dma_addr_t addr);
+void stf_vin_wr_set_pong_addr(struct stf_vin_dev *vin_dev, dma_addr_t addr);
+void stf_vin_isp_set_yuv_addr(struct stf_vin_dev *vin_dev,
+			      dma_addr_t y_addr, dma_addr_t uv_addr);
+irqreturn_t stf_vin_wr_irq_handler(int irq, void *priv);
+irqreturn_t stf_vin_isp_irq_handler(int irq, void *priv);
+irqreturn_t stf_vin_isp_irq_csiline_handler(int irq, void *priv);
+int stf_vin_subdev_init(struct stfcamss *stfcamss);
+int stf_vin_register(struct stf_vin_dev *vin_dev, struct v4l2_device *v4l2_dev);
+int stf_vin_unregister(struct stf_vin_dev *vin_dev);
+enum isp_pad_id stf_vin_map_isp_pad(enum vin_line_id line, enum isp_pad_id def);
+
+#endif /* STF_VIN_H */
diff --git a/drivers/media/platform/starfive/stf_vin_hw_ops.c b/drivers/media/platform/starfive/stf_vin_hw_ops.c
new file mode 100644
index 000000000000..bdea548a061c
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_vin_hw_ops.c
@@ -0,0 +1,211 @@
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
+static void vin_intr_clear(struct stfcamss *stfcamss)
+{
+	stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+			       U0_VIN_CNFG_AXIWR0_INTR_CLEAN, 0x1);
+	stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+			       U0_VIN_CNFG_AXIWR0_INTR_CLEAN, 0x0);
+}
+
+irqreturn_t stf_vin_wr_irq_handler(int irq, void *priv)
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
+	vin_intr_clear(stfcamss);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t stf_vin_isp_irq_handler(int irq, void *priv)
+{
+	struct stf_vin_dev *vin_dev = priv;
+	u32 int_status;
+
+	int_status = stf_isp_reg_read(vin_dev->stfcamss, ISP_REG_ISP_CTRL_0);
+
+	if (int_status & BIT(24)) {
+		if ((int_status & BIT(20)))
+			vin_dev->isr_ops->isr_buffer_done(
+				&vin_dev->line[VIN_LINE_ISP]);
+
+		/* clear interrupt */
+		stf_isp_reg_write(vin_dev->stfcamss,
+				  ISP_REG_ISP_CTRL_0,
+				  (int_status & ~EN_INT_ALL) |
+				  EN_INT_ISP_DONE |
+				  EN_INT_CSI_DONE |
+				  EN_INT_SC_DONE);
+	}
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t stf_vin_isp_irq_csiline_handler(int irq, void *priv)
+{
+	struct stf_vin_dev *vin_dev = priv;
+	struct stf_isp_dev *isp_dev;
+	u32 int_status;
+
+	isp_dev = &vin_dev->stfcamss->isp_dev;
+
+	int_status = stf_isp_reg_read(vin_dev->stfcamss, ISP_REG_ISP_CTRL_0);
+	if (int_status & BIT(27)) {
+		struct dummy_buffer *dummy_buffer =
+			&vin_dev->dummy_buffer[STF_DUMMY_ISP];
+
+		if (!atomic_read(&isp_dev->shadow_count)) {
+			if (atomic_dec_if_positive(&dummy_buffer->frame_skip) < 0) {
+				if ((int_status & BIT(20)))
+					vin_dev->isr_ops->isr_change_buffer(
+						&vin_dev->line[VIN_LINE_ISP]);
+			}
+
+			/* shadow update */
+			stf_isp_reg_set_bit(isp_dev->stfcamss,
+					    ISP_REG_CSIINTS_ADDR,
+					    CSI_INTS_MASK, CSI_INTS(0x3));
+			stf_isp_reg_set_bit(isp_dev->stfcamss,
+					    ISP_REG_IESHD_ADDR,
+					    SHAD_UP_M | SHAD_UP_EN, 0x3);
+		}
+
+		/* clear interrupt */
+		stf_isp_reg_write(vin_dev->stfcamss, ISP_REG_ISP_CTRL_0,
+				  (int_status & ~EN_INT_ALL) | EN_INT_LINE_INT);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int stf_vin_clk_enable(struct stf_vin_dev *vin_dev, enum link link)
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
+int stf_vin_wr_stream_set(struct stf_vin_dev *vin_dev, int on)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	/* make the axiwr alway on */
+	if (on)
+		stf_syscon_reg_set(stfcamss, SYSCONSAIF_SYSCFG(20),
+				   U0_VIN_CNFG_AXIWR0_EN);
+
+	return 0;
+}
+
+int stf_vin_stream_set(struct stf_vin_dev *vin_dev, int on, enum link link)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	switch (link) {
+	case LINK_DVP_TO_WR:
+		break;
+	case LINK_DVP_TO_ISP:
+		break;
+	case LINK_CSI_TO_WR:
+		break;
+	case LINK_CSI_TO_ISP:
+		stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(36),
+				       U0_VIN_CNFG_MIPI_BYTE_EN_ISP0_MASK,
+				       U0_VIN_CNFG_MIPI_BYTE_EN_ISP0(0));
+		stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(36),
+				       U0_VIN_CNFG_MIPI_CHANNEL_SEL0_MASK,
+				       U0_VIN_CNFG_MIPI_CHANNEL_SEL0(0));
+		stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(36),
+				       U0_VIN_CNFG_PIX_NUM_MASK,
+				       U0_VIN_CNFG_PIX_NUM(0));
+		stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(36),
+				       U0_VIN_CNFG_P_I_MIPI_HAEDER_EN0_MASK,
+				       U0_VIN_CNFG_P_I_MIPI_HAEDER_EN0(1));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void stf_vin_wr_irq_enable(struct stf_vin_dev *vin_dev, int enable)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+	unsigned int value = 0;
+
+	if (enable) {
+		value = ~(0x1 << 1);
+		stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+				       U0_VIN_CNFG_AXIWR0_INTR_MASK, value);
+	} else {
+		/* clear vin interrupt */
+		value = 0x1 << 1;
+		stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+				       U0_VIN_CNFG_AXIWR0_INTR_CLEAN, 0x1);
+		stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+				       U0_VIN_CNFG_AXIWR0_INTR_CLEAN, 0x0);
+		stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+				       U0_VIN_CNFG_AXIWR0_INTR_MASK, value);
+	}
+}
+
+void stf_vin_wr_set_ping_addr(struct stf_vin_dev *vin_dev, dma_addr_t addr)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	/* set the start address */
+	stf_syscon_reg_write(stfcamss, SYSCONSAIF_SYSCFG(32), (long)addr);
+}
+
+void stf_vin_wr_set_pong_addr(struct stf_vin_dev *vin_dev, dma_addr_t addr)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	/* set the start address */
+	stf_syscon_reg_write(stfcamss, SYSCONSAIF_SYSCFG(24), (long)addr);
+}
+
+void stf_vin_isp_set_yuv_addr(struct stf_vin_dev *vin_dev,
+			      dma_addr_t y_addr, dma_addr_t uv_addr)
+{
+	stf_isp_reg_write(vin_dev->stfcamss,
+			  ISP_REG_Y_PLANE_START_ADDR, y_addr);
+	stf_isp_reg_write(vin_dev->stfcamss,
+			  ISP_REG_UV_PLANE_START_ADDR, uv_addr);
+}
-- 
2.34.1

