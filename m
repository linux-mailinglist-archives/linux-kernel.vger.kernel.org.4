Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55EE7355CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjFSL3H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jun 2023 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjFSL25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:28:57 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4F5137;
        Mon, 19 Jun 2023 04:28:44 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0CD2480A7;
        Mon, 19 Jun 2023 19:28:41 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 19:28:41 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 19:28:40 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v7 3/6] media: starfive: camss: Add basic driver
Date:   Mon, 19 Jun 2023 19:28:35 +0800
Message-ID: <20230619112838.19797-4-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619112838.19797-1-jack.zhu@starfivetech.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic platform driver for StarFive Camera Subsystem.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 MAINTAINERS                                   |   1 +
 drivers/media/platform/Kconfig                |   1 +
 drivers/media/platform/Makefile               |   1 +
 drivers/media/platform/starfive/Kconfig       |   5 +
 drivers/media/platform/starfive/Makefile      |   2 +
 drivers/media/platform/starfive/camss/Kconfig |  16 +
 .../media/platform/starfive/camss/Makefile    |   8 +
 .../media/platform/starfive/camss/stf_camss.c | 338 ++++++++++++++++++
 .../media/platform/starfive/camss/stf_camss.h | 146 ++++++++
 9 files changed, 518 insertions(+)
 create mode 100644 drivers/media/platform/starfive/Kconfig
 create mode 100644 drivers/media/platform/starfive/Makefile
 create mode 100644 drivers/media/platform/starfive/camss/Kconfig
 create mode 100644 drivers/media/platform/starfive/camss/Makefile
 create mode 100644 drivers/media/platform/starfive/camss/stf_camss.c
 create mode 100644 drivers/media/platform/starfive/camss/stf_camss.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 71291dc58671..62f9e3593eab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20077,6 +20077,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/starfive_camss.rst
 F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
+F:	drivers/media/platform/starfive/camss
 
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
index 000000000000..7955c2a0a4a3
--- /dev/null
+++ b/drivers/media/platform/starfive/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+comment "StarFive media platform drivers"
+
+source "drivers/media/platform/starfive/camss/Kconfig"
diff --git a/drivers/media/platform/starfive/Makefile b/drivers/media/platform/starfive/Makefile
new file mode 100644
index 000000000000..4639fa1bca32
--- /dev/null
+++ b/drivers/media/platform/starfive/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += camss/
diff --git a/drivers/media/platform/starfive/camss/Kconfig b/drivers/media/platform/starfive/camss/Kconfig
new file mode 100644
index 000000000000..dafe1d24324b
--- /dev/null
+++ b/drivers/media/platform/starfive/camss/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_STARFIVE_CAMSS
+	tristate "Starfive Camera Subsystem driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && OF
+	depends on HAS_DMA
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
diff --git a/drivers/media/platform/starfive/camss/Makefile b/drivers/media/platform/starfive/camss/Makefile
new file mode 100644
index 000000000000..d56ddd078a71
--- /dev/null
+++ b/drivers/media/platform/starfive/camss/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for StarFive Camera Subsystem driver
+#
+
+starfive-camss-objs += stf_camss.o
+
+obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o
diff --git a/drivers/media/platform/starfive/camss/stf_camss.c b/drivers/media/platform/starfive/camss/stf_camss.c
new file mode 100644
index 000000000000..dc2b5dba7bd4
--- /dev/null
+++ b/drivers/media/platform/starfive/camss/stf_camss.c
@@ -0,0 +1,338 @@
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
+static int stfcamss_get_mem_res(struct platform_device *pdev,
+				struct stfcamss *stfcamss)
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
+	dev_dbg(dev, "vep.base.port = %d, id = %d\n",
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
+	int ret, num_subdevs = 0;
+
+	for_each_endpoint_of_node(dev->of_node, node) {
+		struct stfcamss_async_subdev *csd;
+
+		if (!of_device_is_available(node))
+			continue;
+
+		csd = v4l2_async_nf_add_fwnode_remote(&stfcamss->notifier,
+						      of_fwnode_handle(node),
+						      struct stfcamss_async_subdev);
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
+static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
+					  struct v4l2_subdev *subdev,
+					  struct v4l2_async_subdev *asd)
+{
+	struct media_pad *pad[STF_PADS_NUM];
+	unsigned int i, pad_num = 0;
+
+	for (i = 0; i < pad_num; ++i) {
+		int ret;
+
+		ret = v4l2_create_fwnode_links_to_pad(subdev, pad[i], 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int stfcamss_subdev_notifier_complete(struct v4l2_async_notifier *ntf)
+{
+	struct stfcamss *stfcamss =
+		container_of(ntf, struct stfcamss, notifier);
+
+	return v4l2_device_register_subdev_nodes(&stfcamss->v4l2_dev);
+}
+
+static const struct v4l2_async_notifier_operations
+stfcamss_subdev_notifier_ops = {
+	.bound = stfcamss_subdev_notifier_bound,
+	.complete = stfcamss_subdev_notifier_complete,
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
+	int ret, num_subdevs;
+	unsigned int i;
+
+	stfcamss = devm_kzalloc(dev, sizeof(*stfcamss), GFP_KERNEL);
+	if (!stfcamss)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(stfcamss->irq); ++i) {
+		stfcamss->irq[i] = platform_get_irq(pdev, i);
+		if (stfcamss->irq[i] < 0)
+			return dev_err_probe(&pdev->dev, stfcamss->irq[i],
+					     "Failed to get irq%d", i);
+	}
+
+	stfcamss->nclks = ARRAY_SIZE(stfcamss->sys_clk);
+	for (i = 0; i < stfcamss->nclks; ++i)
+		stfcamss->sys_clk[i].id = stfcamss_clocks[i];
+	ret = devm_clk_bulk_get(dev, stfcamss->nclks, stfcamss->sys_clk);
+	if (ret) {
+		dev_err(dev, "Failed to get clk controls\n");
+		return ret;
+	}
+
+	stfcamss->nrsts = ARRAY_SIZE(stfcamss->sys_rst);
+	for (i = 0; i < stfcamss->nrsts; ++i)
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
+		ret = -ENODEV;
+		goto err_cleanup_notifier;
+	}
+
+	stfcamss_mc_init(pdev, stfcamss);
+
+	ret = v4l2_device_register(stfcamss->dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
+		goto err_cleanup_notifier;
+	}
+
+	ret = media_device_register(&stfcamss->media_dev);
+	if (ret) {
+		dev_err(dev, "Failed to register media device: %d\n", ret);
+		goto err_unregister_device;
+	}
+
+	pm_runtime_enable(dev);
+
+	stfcamss->notifier.ops = &stfcamss_subdev_notifier_ops;
+	ret = v4l2_async_nf_register(&stfcamss->v4l2_dev, &stfcamss->notifier);
+	if (ret) {
+		dev_err(dev, "Failed to register async subdev nodes: %d\n",
+			ret);
+		goto err_unregister_media_dev;
+	}
+
+	return 0;
+
+err_unregister_media_dev:
+	media_device_unregister(&stfcamss->media_dev);
+err_unregister_device:
+	v4l2_device_unregister(&stfcamss->v4l2_dev);
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
+	reset_control_assert(stfcamss->sys_rst[STF_RST_AXIWR].rstc);
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
+	int ret;
+
+	ret = clk_prepare_enable(stfcamss->sys_clk[STF_CLK_ISPCORE_2X].clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(stfcamss->sys_clk[STF_CLK_ISP_AXI].clk);
+	if (ret)
+		return ret;
+
+	reset_control_deassert(stfcamss->sys_rst[STF_RST_ISP_TOP_N].rstc);
+	reset_control_deassert(stfcamss->sys_rst[STF_RST_ISP_TOP_AXI].rstc);
+	reset_control_deassert(stfcamss->sys_rst[STF_RST_AXIWR].rstc);
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
+		.name = "starfive-camss",
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
diff --git a/drivers/media/platform/starfive/camss/stf_camss.h b/drivers/media/platform/starfive/camss/stf_camss.h
new file mode 100644
index 000000000000..15c4f34b9054
--- /dev/null
+++ b/drivers/media/platform/starfive/camss/stf_camss.h
@@ -0,0 +1,146 @@
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
+#include <linux/delay.h>
+#include <linux/reset.h>
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-device.h>
+
+#define STF_DVP_NAME "stf_dvp"
+#define STF_CSI_NAME "cdns_csi2rx"
+#define STF_ISP_NAME "stf_isp"
+#define STF_VIN_NAME "stf_vin"
+
+#define STF_PAD_SINK   0
+#define STF_PAD_SRC    1
+#define STF_PADS_NUM   2
+
+enum stf_port_num {
+	STF_PORT_DVP = 0,
+	STF_PORT_CSI2RX
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
+struct stfcamss {
+	struct v4l2_device v4l2_dev;
+	struct media_device media_dev;
+	struct media_pipeline pipe;
+	struct device *dev;
+	struct v4l2_async_notifier notifier;
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
+	enum stf_port_num port;
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
+static inline void stf_isp_reg_write_delay(struct stfcamss *stfcamss,
+					   u32 reg, u32 val, u32 delay)
+{
+	iowrite32(val, stfcamss->isp_base + reg);
+	usleep_range(1000 * delay, 1000 * delay + 100);
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
+					  u32 reg, u32 bit_mask)
+{
+	u32 value;
+
+	value = ioread32(stfcamss->syscon_base + reg);
+	iowrite32(value | bit_mask, stfcamss->syscon_base + reg);
+}
+
+static inline void stf_syscon_reg_clear_bit(struct stfcamss *stfcamss,
+					    u32 reg, u32 bit_mask)
+{
+	u32 value;
+
+	value = ioread32(stfcamss->syscon_base + reg);
+	iowrite32(value & ~bit_mask, stfcamss->syscon_base + reg);
+}
+#endif /* STF_CAMSS_H */
-- 
2.34.1

