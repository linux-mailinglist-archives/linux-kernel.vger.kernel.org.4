Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEBE65D46A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjADNh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbjADNgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:36:46 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E853AF16;
        Wed,  4 Jan 2023 05:34:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qk9so82398314ejc.3;
        Wed, 04 Jan 2023 05:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwgBB8ONyjEjJPW1Sn3HtyKR+YCtKR8/Kp0A/PtHw48=;
        b=exuCv3xcprgME102Ifi3+WWd0TKGoXQxO9jLEPxmLnD9fA0ucUc1cGgB3vl9MvYtwl
         JyVRKeHRe8DWoXHhZQ42N39CYWbsi/IRbwC09c/gPrbvs97Hg5GQZ2mwRUTUzt40btWz
         J+BsjvfmRkvHe/xCGSdeyFe+Yjl+khNvm6zet2RajwBWzM7FWlBMMTin6nPYlXxOA2J3
         B5j2m6A5PrlcDD1KGbhlS0XBZ11UyiR+5DcipA+opsfa67KdeGknemAd/IGfQy5xOOG9
         6SegrrLemd3955E/0ZhbgfVMNKOP7rH8DeCjlswen9hG8fLYmPSqGUpsoemBr55Ms81l
         uj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwgBB8ONyjEjJPW1Sn3HtyKR+YCtKR8/Kp0A/PtHw48=;
        b=o+GjLTqo7a7lLNJGDazO7s/Wxgw9UeLDOJGbncR8UwyQXzczm9ProrSpnWPdW/g/nj
         lC0y+65/JCzMOFtbFZSPer7fnMR8O4qGzqObDxkM8WroH41AjU+kwgxVxWg8bC/bd8Dc
         //k2bPvw3C2YGVrMsKUq0vKn6reo9Yva6+iM2JYsFFaRIQRULLhLpVSjEboIKbjsxvMl
         kzw8Ygs2Q4dsjeOwo19aUfpb/PfkSNtHc/giVBVqKZ+aZGxt9l956CeSHRxYv8bKQINl
         R4/TXyavq3XCGoe/sqUr4eN3Stj7VXuGuB95XJ4DE/butLr4S9r0HBbf5k7yG/EnVTcC
         vnzQ==
X-Gm-Message-State: AFqh2koj6vgTe3jO3HPvoDSxmL7dwPdk5byXXwfx4zXl+5FYAQFNdWgk
        GBTlDY1FpZEtspYDCdhrh/K+kto90cnCJA==
X-Google-Smtp-Source: AMrXdXt9f7aAv+SAafS/Cxtz5Jtq9F6M7YxT5myuDPBN2cILSDzKVD48RtUUJLdTZZq2tOXzLl48Bg==
X-Received: by 2002:a17:906:cb99:b0:7c0:f5d7:cac7 with SMTP id mf25-20020a170906cb9900b007c0f5d7cac7mr48917499ejb.67.1672839275216;
        Wed, 04 Jan 2023 05:34:35 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id sb20-20020a170906edd400b0073dbaeb50f6sm15211659ejb.169.2023.01.04.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:34:34 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mani@kernel.org,
        hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCH 2/3] bus: add Wiegand bus driver
Date:   Wed,  4 Jan 2023 14:34:13 +0100
Message-Id: <20230104133414.39305-3-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104133414.39305-1-m.zatovic1@gmail.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bus driver for Wiegand protocol. The bus driver handles
Wiegand controller and Wiegand device managemement and driver
matching. The bus driver defines the structures for Wiegand
controllers and Wiegand devices. Wiegand controller structure
contains the format and payload_len fields to add support for
different format messages. This should be handled by the
controller driver.

Each Wiegand controller should be associated with one Wiegand
device, as Wiegand is typically a point-to-point bus.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 MAINTAINERS             |   2 +
 drivers/bus/Kconfig     |   5 +
 drivers/bus/Makefile    |   1 +
 drivers/bus/wiegand.c   | 768 ++++++++++++++++++++++++++++++++++++++++
 include/linux/wiegand.h | 228 ++++++++++++
 5 files changed, 1004 insertions(+)
 create mode 100644 drivers/bus/wiegand.c
 create mode 100644 include/linux/wiegand.h

diff --git a/MAINTAINERS b/MAINTAINERS
index db9624d93af0..b6e68e92f0e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22432,6 +22432,8 @@ WIEGAND BUS DRIVER
 M:	Martin Zaťovič <m.zatovic1@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
+F:	drivers/bus/wiegand.c
+F:	include/linux/wiegand.h
 
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7bfe998f3514..360e55abc311 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -241,6 +241,11 @@ config VEXPRESS_CONFIG
 	  Platform configuration infrastructure for the ARM Ltd.
 	  Versatile Express.
 
+config WIEGAND
+        tristate "Wiegand Bus driver"
+        help
+          Driver for low-level 2-wire serial protocol communication.
+
 config DA8XX_MSTPRI
 	bool "TI da8xx master peripheral priority driver"
 	depends on ARCH_DAVINCI_DA8XX
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index d90eed189a65..bde17c8ceedb 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_TI_SYSC)		+= ti-sysc.o
 obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
+obj-$(CONFIG_WIEGAND_GPIO)      += wiegand.o
 
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
 
diff --git a/drivers/bus/wiegand.c b/drivers/bus/wiegand.c
new file mode 100644
index 000000000000..062d2f74979f
--- /dev/null
+++ b/drivers/bus/wiegand.c
@@ -0,0 +1,768 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/wiegand.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/property.h>
+
+static DEFINE_IDR(wiegand_controller_idr);
+
+static struct bus_type wiegand_bus_type;
+
+struct boardinfo {
+	struct list_head list;
+	struct wiegand_board_info board_info;
+};
+
+static LIST_HEAD(board_list);
+static LIST_HEAD(wiegand_controller_list);
+
+int wiegand_calc_parity8(u8 v)
+{
+	v = (v >> 4) ^ (v & ((1 << 4)-1));
+	v = (v >> 2) ^ (v & ((1 << 2)-1));
+	v = (v >> 1) ^ (v & ((1 << 1)-1));
+	return v;
+}
+EXPORT_SYMBOL_GPL(wiegand_calc_parity8);
+
+/*
+ * This function prepends the first and appends the last bit of a message.
+ * It is up to the caller to allocate a buffer such that these bits fit.
+ */
+void wiegand_add_parity_to_data(unsigned char *tmp, u8 *data,
+						enum wiegand_format fmt)
+{
+	switch (fmt) {
+	case WIEGAND_V26:
+		data[0] = (tmp[0] >> 1) | (wiegand_calc_parity8(
+						tmp[0] ^ (tmp[1] & 0xf0)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (!wiegand_calc_parity8(
+						(tmp[1] & 0x0f) ^ tmp[2]) << 6);
+		break;
+	case WIEGAND_V36:
+		tmp[4] &= 0xc0;
+		data[0] = (tmp[0] >> 1) | (wiegand_calc_parity8(
+				tmp[0] ^ tmp[1] ^ (tmp[2] & 0x80)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (tmp[3] >> 1);
+		data[4] = (tmp[3] << 7) | (tmp[4] >> 1) |
+			(!wiegand_calc_parity8(
+				(tmp[2] & 0x7f) ^ tmp[3] ^ tmp[4]) << 4);
+		break;
+	case WIEGAND_V37:
+		tmp[4] &= 0xe0;
+		data[0] = (tmp[0] >> 1) | (wiegand_calc_parity8(
+				tmp[0] ^ tmp[1] ^ (tmp[2] & 0xc0)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (tmp[3] >> 1);
+		data[4] = (tmp[3] << 7) | (tmp[4] >> 1) |
+			(!wiegand_calc_parity8(
+				(tmp[2] & 0x7f) ^ tmp[3] ^ tmp[4]) << 3);
+		break;
+	default:
+		WARN_ON(fmt != WIEGAND_V37 &&
+			fmt != WIEGAND_V36 &&
+			fmt != WIEGAND_V26);
+	}
+}
+EXPORT_SYMBOL_GPL(wiegand_add_parity_to_data);
+
+
+static void devm_wiegand_release_controller(struct device *dev, void *ctlr)
+{
+	wiegand_controller_put(*(struct wiegand_controller **)ctlr);
+}
+
+static void wiegand_controller_release(struct device *dev)
+{
+	struct wiegand_controller *ctlr;
+
+	ctlr = container_of(dev, struct wiegand_controller, dev);
+	kfree(ctlr);
+}
+
+static struct class wiegand_controller_class = {
+	.name = "wiegand_master",
+	.owner = THIS_MODULE,
+	.dev_release = wiegand_controller_release,
+};
+
+static DEFINE_MUTEX(board_lock);
+
+struct wiegand_controller *__wiegand_alloc_controller(struct device *dev,
+						unsigned int size, bool slave)
+{
+	struct wiegand_controller *ctlr;
+	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());
+
+	if (!dev)
+		return NULL;
+
+	ctlr = kzalloc(size + ctlr_size, GFP_KERNEL);
+	if (!ctlr)
+		return NULL;
+
+	device_initialize(&ctlr->dev);
+	ctlr->bus_num = -1;
+	ctlr->slave = slave;
+	ctlr->dev.class = &wiegand_controller_class;
+	ctlr->dev.parent = dev;
+	wiegand_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
+
+	return ctlr;
+}
+EXPORT_SYMBOL_GPL(__wiegand_alloc_controller);
+
+struct wiegand_controller *__devm_wiegand_alloc_controller(struct device *dev,
+							unsigned int size,
+							bool slave)
+{
+	struct wiegand_controller **ptr, *ctlr;
+
+	ptr = devres_alloc(devm_wiegand_release_controller, sizeof(*ptr),
+								GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	ctlr = __wiegand_alloc_controller(dev, size, slave);
+	if (ctlr) {
+		ctlr->devm_allocated = true;
+		*ptr = ctlr;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ctlr;
+}
+EXPORT_SYMBOL_GPL(__devm_wiegand_alloc_controller);
+
+static int wiegand_controller_check_ops(struct wiegand_controller *ctlr)
+{
+	if (!ctlr->transfer_message)
+		return -EINVAL;
+	return 0;
+}
+
+static void wiegand_match_controller_to_boardinfo(
+					struct wiegand_controller *ctlr,
+					struct wiegand_board_info *bi)
+{
+	struct wiegand_device *dev;
+
+	if (ctlr->bus_num != bi->bus_num)
+		return;
+
+	dev = wiegand_new_device(ctlr, bi);
+	if (dev == NULL)
+		dev_err(ctlr->dev.parent, "can't create new device for %s\n",
+				bi->modalias);
+	bi->dev = dev;
+
+	/* check if more devices are connected to the bus */
+	if (ctlr->device_count > 1)
+		dev_warn(&ctlr->dev, "Wiegand is a point-to-point bus, it is advised to only connect one device per Wiegand bus. The devices may not communicate using the same pulse length, format or else, devcnt = %u.\n",
+							ctlr->device_count);
+}
+
+static struct wiegand_device *of_register_wiegand_device(
+						struct wiegand_controller *ctlr,
+						struct device_node *nc)
+{
+	struct wiegand_device *wiegand;
+	int rc;
+
+	wiegand = wiegand_alloc_device(ctlr);
+	if (!wiegand) {
+		dev_err(&ctlr->dev, "wiegad_device alloc error for %pOF\n", nc);
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	rc = of_modalias_node(nc, wiegand->modalias, sizeof(wiegand->modalias));
+	if (rc < 0) {
+		dev_err(&ctlr->dev, "cannot find modalias for %pOF\n", nc);
+		goto err_out;
+	}
+
+	of_node_get(nc);
+	wiegand->dev.of_node = nc;
+	wiegand->dev.fwnode = of_fwnode_handle(nc);
+
+	rc = wiegand_add_device(wiegand);
+	if (rc) {
+		dev_err(&ctlr->dev, "wiegand_device register error %pOF\n", nc);
+		goto err_of_node_put;
+	}
+
+	/* check if more devices are connected to the bus */
+	if (ctlr->device_count > 1)
+		dev_warn(&ctlr->dev, "Wiegand is a point-to-point bus, it is advised to only connect one device per Wiegand bus. The devices may not communicate using the same pulse length, format or else.\n");
+
+	return wiegand;
+
+err_of_node_put:
+	of_node_put(nc);
+err_out:
+	wiegand_dev_put(wiegand);
+	return ERR_PTR(rc);
+}
+
+static void of_register_wiegand_devices(struct wiegand_controller *ctlr)
+{
+	struct wiegand_device *wiegand;
+	struct device_node *nc;
+
+	if (!ctlr->dev.of_node)
+		return;
+
+	for_each_available_child_of_node(ctlr->dev.of_node, nc) {
+		if (of_node_test_and_set_flag(nc, OF_POPULATED))
+			continue;
+		wiegand = of_register_wiegand_device(ctlr, nc);
+		if (IS_ERR(wiegand)) {
+			dev_warn(&ctlr->dev,
+				 "Failed to create wiegand device for %pOF\n",
+								nc);
+			of_node_clear_flag(nc, OF_POPULATED);
+		}
+	}
+}
+
+/*
+ * Controllers that do not have a devicetree entry need to initialize the
+ * following struct wiegand_controller attributes: pulse_len, interval_len and
+ * frame_gap.
+ */
+int wiegand_register_controller(struct wiegand_controller *ctlr)
+{
+	struct device *dev = ctlr->dev.parent;
+	struct boardinfo *bi;
+	int status, id, first_dynamic;
+
+	if (!dev)
+		return -ENODEV;
+
+	status = wiegand_controller_check_ops(ctlr);
+	if (status)
+		return status;
+
+	if (ctlr->dev.of_node) {
+		id = of_alias_get_id(ctlr->dev.of_node, "wiegand");
+		if (id > 0) {
+			ctlr->bus_num = id;
+			mutex_lock(&board_lock);
+			id = idr_alloc(&wiegand_controller_idr, ctlr,
+							ctlr->bus_num,
+							ctlr->bus_num + 1,
+							GFP_KERNEL);
+			mutex_unlock(&board_lock);
+			if (WARN(id < 0, "couldn't get idr"))
+				return id == -ENOSPC ? -EBUSY : id;
+		}
+		device_property_read_u32(&ctlr->dev, "pulse-len-us",
+							&ctlr->pulse_len);
+		device_property_read_u32(&ctlr->dev, "interval-len-us",
+							&ctlr->interval_len);
+		device_property_read_u32(&ctlr->dev, "frame-gap-us",
+							&ctlr->frame_gap);
+	}
+	if (ctlr->bus_num < 0) {
+		first_dynamic = of_alias_get_highest_id("wiegand");
+		if (first_dynamic < 0)
+			first_dynamic = 0;
+		else
+			first_dynamic++;
+
+		mutex_lock(&board_lock);
+		id = idr_alloc(&wiegand_controller_idr, ctlr, first_dynamic,
+								0, GFP_KERNEL);
+		mutex_unlock(&board_lock);
+		if (WARN(id < 0, "couldn't get idr\n"))
+			return id;
+		ctlr->bus_num = id;
+	}
+
+	if (ctlr->pulse_len == 0)
+		dev_warn(&ctlr->dev, "pulse_len is not initialized\n");
+	if (ctlr->interval_len == 0)
+		dev_warn(&ctlr->dev, "interval_len is not initialized\n");
+	if (ctlr->frame_gap == 0)
+		dev_warn(&ctlr->dev, "frame_gap is not initialized\n");
+
+	dev_set_name(&ctlr->dev, "wiegand%u", ctlr->bus_num);
+	ctlr->device_count = 0;
+
+	status = device_add(&ctlr->dev);
+	if (status < 0)
+		goto free_bus_id;
+
+	mutex_lock(&board_lock);
+	list_add_tail(&ctlr->list, &wiegand_controller_list);
+	list_for_each_entry(bi, &board_list, list)
+		wiegand_match_controller_to_boardinfo(ctlr, &bi->board_info);
+	mutex_unlock(&board_lock);
+
+	of_register_wiegand_devices(ctlr);
+
+	return status;
+
+free_bus_id:
+	mutex_lock(&board_lock);
+	idr_remove(&wiegand_controller_idr, ctlr->bus_num);
+	mutex_unlock(&board_lock);
+	return status;
+}
+
+static int __unregister(struct device *dev, void *null)
+{
+	wiegand_unregister_device(to_wiegand_device(dev));
+	return 0;
+}
+
+void wiegand_unregister_controller(struct wiegand_controller *ctlr)
+{
+	struct wiegand_controller *found;
+	int id = ctlr->bus_num;
+
+	device_for_each_child(&ctlr->dev, NULL, __unregister);
+	found = idr_find(&wiegand_controller_idr, id);
+	device_del(&ctlr->dev);
+
+	mutex_lock(&board_lock);
+	if (found == ctlr)
+		idr_remove(&wiegand_controller_idr, id);
+	mutex_unlock(&board_lock);
+
+	if (!ctlr->devm_allocated)
+		put_device(&ctlr->dev);
+}
+EXPORT_SYMBOL_GPL(wiegand_unregister_controller);
+
+static void devm_wiegand_unregister(struct device *dev, void *res)
+{
+	wiegand_unregister_controller(*(struct wiegand_controller **)res);
+}
+
+int devm_wiegand_register_controller(struct device *dev,
+				     struct wiegand_controller *ctlr)
+{
+	struct wiegand_controller **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_wiegand_unregister, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = wiegand_register_controller(ctlr);
+	if (!ret) {
+		*ptr = ctlr;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_wiegand_register_controller);
+
+/* Payload length is not regarded for standard formats.
+ * Setting format for a device sets the format of a controller associated
+ * with it.
+ */
+void wiegand_ctlr_set_format_and_paylen(struct wiegand_controller *ctlr,
+					enum wiegand_format format,
+					u16 payload_len)
+{
+	switch (format) {
+	case WIEGAND_V26:
+		ctlr->payload_len = WIEGAND_V26_PAYLEN;
+		break;
+	case WIEGAND_V36:
+		ctlr->payload_len = WIEGAND_V36_PAYLEN;
+		break;
+	case WIEGAND_V37:
+		ctlr->payload_len = WIEGAND_V37_PAYLEN;
+		break;
+	case WIEGAND_CUSTOM:
+		ctlr->payload_len = payload_len;
+		break;
+	default:
+		dev_warn(&ctlr->dev, "tried to set invalid format\n");
+		return;
+	};
+	ctlr->format = format;
+}
+EXPORT_SYMBOL_GPL(wiegand_ctlr_set_format_and_paylen);
+
+static int __wiegand_master_match(struct device *dev, const void *data)
+{
+	struct wiegand_master *master;
+	const u16 *bus_num = data;
+
+	master = container_of(dev, struct wiegand_master, dev);
+	return master->bus_num == *bus_num;
+}
+
+struct wiegand_master *wiegand_busnum_to_master(u16 bus_num)
+{
+	struct device *dev;
+	struct wiegand_master *master = NULL;
+
+	dev = class_find_device(&wiegand_controller_class, NULL, &bus_num,
+				__wiegand_master_match);
+	if (dev)
+		master = container_of(dev, struct wiegand_master, dev);
+
+	return master;
+}
+EXPORT_SYMBOL_GPL(wiegand_busnum_to_master);
+
+/* Device section */
+
+static void wieganddev_release(struct device *dev)
+{
+	struct wiegand_device *wiegand = to_wiegand_device(dev);
+
+	wiegand_controller_put(wiegand->controller);
+	kfree(wiegand);
+}
+
+struct wiegand_device *wiegand_alloc_device(struct wiegand_controller *ctlr)
+{
+	struct wiegand_device *wiegand;
+
+	if (!wiegand_controller_get(ctlr))
+		return NULL;
+
+	wiegand = kzalloc(sizeof(*wiegand), GFP_KERNEL);
+	if (!wiegand) {
+		wiegand_controller_put(ctlr);
+		return NULL;
+	}
+
+	wiegand->controller = ctlr;
+	wiegand->dev.parent = &ctlr->dev;
+	wiegand->dev.bus = &wiegand_bus_type;
+	wiegand->dev.release = wieganddev_release;
+
+	device_initialize(&wiegand->dev);
+	return wiegand;
+}
+EXPORT_SYMBOL_GPL(wiegand_alloc_device);
+
+struct wiegand_device *wiegand_new_device(struct wiegand_controller *ctlr,
+						struct wiegand_board_info *chip)
+{
+	struct wiegand_device *proxy;
+	int status;
+
+	proxy = wiegand_alloc_device(ctlr);
+	if (!proxy)
+		return NULL;
+
+	WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
+
+	strscpy(proxy->modalias, chip->modalias, sizeof(proxy->modalias));
+	proxy->dev.platform_data = (void *) chip->platform_data;
+
+	/* set the format to default 26-bit */
+	wiegand_ctlr_set_format_and_paylen(ctlr, WIEGAND_V26, 0);
+
+	status = wiegand_add_device(proxy);
+	if (status < 0)
+		goto err_dev_put;
+
+	return proxy;
+
+err_dev_put:
+	wiegand_dev_put(proxy);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(wiegand_new_device);
+
+static void wiegand_cleanup(struct wiegand_device *wiegand)
+{
+	if (wiegand->controller->cleanup)
+		wiegand->controller->cleanup(wiegand);
+}
+
+static int __wiegand_add_device(struct wiegand_device *wiegand)
+{
+	struct wiegand_controller *ctlr = wiegand->controller;
+	struct device *dev = ctlr->dev.parent;
+	int status;
+
+	status = wiegand_setup(wiegand);
+	if (status < 0) {
+		dev_err(dev, "can't setup %s, status %d\n",
+			dev_name(&wiegand->dev), status);
+		return status;
+	}
+
+	status = device_add(&wiegand->dev);
+	if (status < 0) {
+		dev_err(dev, "can't add %s, status %d\n",
+			dev_name(&wiegand->dev), status);
+		wiegand_cleanup(wiegand);
+	} else {
+		dev_dbg(dev, "registered child %s\n", dev_name(&wiegand->dev));
+	}
+
+	return status;
+}
+
+static void wiegand_dev_set_name(struct wiegand_device *wiegand, u8 id)
+{
+	dev_set_name(&wiegand->dev, "%s.%u",
+			dev_name(&wiegand->controller->dev), id);
+}
+
+int wiegand_add_device(struct wiegand_device *wiegand)
+{
+	struct wiegand_controller *ctlr = wiegand->controller;
+	int status;
+
+	wiegand_dev_set_name(wiegand, ctlr->device_count);
+
+	status = __wiegand_add_device(wiegand);
+	if (!status) {
+		ctlr->device_count++;
+		wiegand->id = wiegand->controller->device_count;
+	}
+
+	return status;
+}
+
+int wiegand_setup(struct wiegand_device *wiegand)
+{
+	int status = 0;
+
+	if (wiegand->controller->setup) {
+		status = wiegand->controller->setup(wiegand);
+		if (status) {
+			dev_err(&wiegand->controller->dev,
+						"Failed to setup device: %d\n",
+									status);
+			return status;
+		}
+	}
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(wiegand_setup);
+
+void wiegand_unregister_device(struct wiegand_device *wiegand)
+{
+	if (!wiegand)
+		return;
+
+	if (wiegand->dev.of_node) {
+		of_node_clear_flag(wiegand->dev.of_node, OF_POPULATED);
+		of_node_put(wiegand->dev.of_node);
+	}
+	device_del(&wiegand->dev);
+	wiegand_cleanup(wiegand);
+	put_device(&wiegand->dev);
+}
+EXPORT_SYMBOL_GPL(wiegand_unregister_device);
+
+void wiegand_set_format_and_paylen(struct wiegand_device *wdev,
+					enum wiegand_format fmt,
+					u16 payload_len)
+{
+	struct wiegand_controller *ctlr = wdev->controller;
+
+	wiegand_ctlr_set_format_and_paylen(ctlr, fmt, payload_len);
+}
+EXPORT_SYMBOL_GPL(wiegand_set_format_and_paylen);
+
+struct wiegand_device *wiegand_get_device_by_board_info(
+				struct wiegand_board_info *boardinfo)
+{
+	return boardinfo->dev;
+}
+EXPORT_SYMBOL_GPL(wiegand_get_device_by_board_info);
+
+int wiegand_register_board_info(struct wiegand_board_info *info, u8 n)
+{
+	struct boardinfo *bi;
+	int i;
+
+	if (!n)
+		return 0;
+
+	bi = kcalloc(n, sizeof(*bi), GFP_KERNEL);
+	if (!bi)
+		return -ENOMEM;
+
+	for (i = 0; i < n; i++, bi++, info++) {
+		struct wiegand_controller *ctlr;
+
+		memcpy(&bi->board_info, info, sizeof(*info));
+
+		mutex_lock(&board_lock);
+		list_add_tail(&bi->list, &board_list);
+		list_for_each_entry(ctlr, &wiegand_controller_list, list)
+			wiegand_match_controller_to_boardinfo(ctlr,
+							  &bi->board_info);
+		info->dev = bi->board_info.dev;
+		mutex_unlock(&board_lock);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wiegand_register_board_info);
+
+int wiegand_send_message(struct wiegand_device *wiegand, u8 *message)
+{
+	struct wiegand_master *master = wiegand->controller;
+
+	if (message == NULL || message == 0)
+		return -EINVAL;
+
+	if (master->transfer_message)
+		master->transfer_message(wiegand, message);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wiegand_send_message);
+
+static const struct wiegand_device_id *wiegand_match_id(
+					const struct wiegand_device_id *id,
+					const char *name)
+{
+	while (id->name[0]) {
+		if (!strcmp(name, id->name))
+			return id;
+		id++;
+	}
+	return NULL;
+}
+
+static int wiegand_match_device(struct device *dev, struct device_driver *drv)
+{
+	const struct wiegand_device *wiegand = to_wiegand_device(dev);
+	const struct wiegand_driver *wdrv = to_wiegand_driver(drv);
+
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	if (wdrv->id_table)
+		return !!wiegand_match_id(wdrv->id_table, wiegand->modalias);
+
+	return strcmp(wiegand->modalias, drv->name) == 0;
+}
+
+static int wiegand_probe(struct device *dev)
+{
+	struct wiegand_device *wiegand = to_wiegand_device(dev);
+	const struct wiegand_driver *wdrv = to_wiegand_driver(dev->driver);
+	int ret = 0;
+
+	if (wdrv->probe)
+		ret = wdrv->probe(wiegand);
+
+	return ret;
+}
+
+static int wiegand_remove(struct device *dev)
+{
+	const struct wiegand_driver *wdrv = to_wiegand_driver(dev->driver);
+
+	if (wdrv->remove)
+		wdrv->remove(to_wiegand_device(dev));
+
+	return 0;
+}
+
+static struct bus_type wiegand_bus_type = {
+	.name		= "wiegand",
+	.match		= wiegand_match_device,
+	.probe		= wiegand_probe,
+	.remove		= wiegand_remove,
+};
+
+int __wiegand_register_driver(struct module *owner, struct wiegand_driver *wdrv)
+{
+	wdrv->driver.owner = owner;
+	wdrv->driver.bus = &wiegand_bus_type;
+
+	if (wdrv->driver.of_match_table) {
+		const struct of_device_id *of_id;
+
+		for (of_id = wdrv->driver.of_match_table; of_id->compatible[0];
+		     of_id++) {
+			const char *of_name;
+
+			/* remove vendor prefix */
+			of_name = strnchr(of_id->compatible,
+					  sizeof(of_id->compatible), ',');
+			if (of_name)
+				of_name++;
+			else
+				of_name = of_id->compatible;
+
+			if (wdrv->id_table) {
+				const struct wiegand_device_id *wiegand_id;
+
+				wiegand_id = wiegand_match_id(wdrv->id_table,
+								of_name);
+				if (wiegand_id)
+					continue;
+			} else {
+				if (strcmp(wdrv->driver.name, of_name) == 0)
+					continue;
+			}
+
+			pr_warn("Wiegand driver %s has no wiegand_device_id for %s\n",
+				wdrv->driver.name, of_id->compatible);
+		}
+	}
+
+	return driver_register(&wdrv->driver);
+}
+EXPORT_SYMBOL_GPL(__wiegand_register_driver);
+
+static int __init wiegand_init(void)
+{
+	int ret;
+
+	ret = bus_register(&wiegand_bus_type);
+	if (ret < 0) {
+		pr_err("Wiegand bus registration failed: %d\n", ret);
+		goto err0;
+	}
+
+	ret = class_register(&wiegand_controller_class);
+	if (ret < 0)
+		goto err1;
+
+	return 0;
+
+err1:
+	bus_unregister(&wiegand_bus_type);
+err0:
+	return ret;
+}
+
+static void __exit wiegand_exit(void)
+{
+	bus_unregister(&wiegand_bus_type);
+	class_unregister(&wiegand_controller_class);
+}
+postcore_initcall_sync(wiegand_init);
+module_exit(wiegand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand bus driver");
+MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
diff --git a/include/linux/wiegand.h b/include/linux/wiegand.h
new file mode 100644
index 000000000000..0b991c4a7903
--- /dev/null
+++ b/include/linux/wiegand.h
@@ -0,0 +1,228 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef H_LINUX_INCLUDE_LINUX_WIEGAND_H
+#define H_LINUX_INCLUDE_LINUX_WIEGAND_H
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/mod_devicetable.h>
+
+#define WIEGAND_NAME_SIZE 32
+
+extern struct bus_type wiegand_type;
+
+/* The used wiegand format; when data does not end at octet boundaries, the
+ * lower bits of the last octet will be ignored and only the upper ones will be
+ * used.
+ */
+enum wiegand_format {
+	WIEGAND_CUSTOM = 0,
+	WIEGAND_V26 = 26,
+	WIEGAND_V36 = 36,
+	WIEGAND_V37 = 37,
+};
+
+enum wiegand_paylen {
+	WIEGAND_V26_PAYLEN = 24,
+	WIEGAND_V36_PAYLEN = 34,
+	WIEGAND_V37_PAYLEN = 35,
+};
+
+/**
+ * struct wiegand_device - Wiegand listener device
+ * @dev - drivers structure of the device
+ * @id - unique device id
+ * @controller - Wiegand controller associated with the device
+ * @modalias - Name of the driver to use with this device, or its alias.
+ */
+struct wiegand_device {
+	struct device dev;
+	u8 id;
+	struct wiegand_controller *controller;
+	char modalias[WIEGAND_NAME_SIZE];
+};
+
+/**
+ * struct wiegand_board_info - description of a Wiegand device
+ * @modalias - Identifies the driver.
+ * @platform_data - Driver-specific data.
+ * @swnode - Software node for the device. TODO
+ * @bus_num - Identifies the controller parent of the device.
+ * @dev - Wiegand device structure. Should be initialized by board_info
+ *	registration.
+ */
+struct wiegand_board_info {
+	char modalias[WIEGAND_NAME_SIZE];
+	const void *platform_data;
+	const struct software_node *swnode;
+	u16 bus_num;
+	struct wiegand_device *dev;
+};
+
+
+/**
+ * struct wiegand_controller - Wiegand master or slave interface
+ * @dev - Device interface of the controller
+ * @list - Link with the global wiegand_controller list
+ * @bus_num - Board-specific identifier for Wiegand controller
+ * @pulse_len: length of the low pulse in usec; defaults to 50us
+ * @interval_len: length of a whole bit (both the pulse and the high phase) in
+ *	usec; defaults to 2000us
+ * @frame_gap: length of the last bit of a frame (both the pulse and the high
+ *	phase) in usec; defaults to interval_len
+ * @format - TODO
+ * @payload_len - TODO
+ * device_count - Counter of devices connected to the same Wiegand
+ *	bus(controller).
+ * devm_allocated - Whether the allocation of this struct is devres-managed
+ * slave - Whether the controller is a slave(receives data).
+ * transfer_message - Send a message on the bus.
+ * setup - Setup a device.
+ * cleanup - Cleanup after a device.
+ */
+struct wiegand_controller {
+	struct device dev;
+	struct list_head list;
+
+	s16 bus_num;
+
+	u32 pulse_len;
+	u32 interval_len;
+	u32 frame_gap;
+	enum wiegand_format format;
+	u32 payload_len;
+
+	u8 device_count;
+
+	bool devm_allocated;
+	bool slave;
+
+	int (*transfer_message)(struct wiegand_device *dev, u8 *message);
+
+	int (*setup)(struct wiegand_device *wiegand);
+	void (*cleanup)(struct wiegand_device *wiegand);
+};
+
+struct wiegand_driver {
+	const struct wiegand_device_id *id_table;
+	int (*probe)(struct wiegand_device *wiegand);
+	void (*remove)(struct wiegand_device *wiegand);
+	struct device_driver driver;
+};
+
+extern int wiegand_calc_parity8(u8 v);
+extern void wiegand_add_parity_to_data(unsigned char *tmp, u8 *data,
+						enum wiegand_format fmt);
+
+/* Wiegand controller section */
+
+#define wiegand_master wiegand_controller
+extern struct wiegand_controller *__wiegand_alloc_controller(
+							struct device *host,
+							unsigned int size,
+							bool slave);
+
+struct wiegand_controller *__devm_wiegand_alloc_controller(struct device *dev,
+						   unsigned int size,
+						   bool slave);
+struct wiegand_controller *__wiegand_alloc_controller(struct device *dev,
+							unsigned int size,
+							bool slave);
+static inline struct wiegand_controller *devm_wiegand_alloc_master(
+							struct device *dev,
+							unsigned int size)
+{
+	return __devm_wiegand_alloc_controller(dev, size, false);
+}
+extern int wiegand_register_controller(struct wiegand_controller *ctlr);
+extern int devm_wiegand_register_controller(struct device *dev,
+					struct wiegand_controller *ctlr);
+#define wiegand_register_master(_ctlr) wiegand_register_controller(_ctlr)
+#define devm_wiegand_register_master(_dev, _ctlr) \
+	devm_wiegand_register_controller(_dev, _ctlr)
+extern void wiegand_unregister_controller(struct wiegand_controller *ctlr);
+#define wiegand_unregister_master(_ctlr) wiegand_unregister_controller(_ctlr)
+extern struct wiegand_master *wiegand_busnum_to_master(u16 bus_num);
+extern void wiegand_ctlr_set_format_and_paylen(struct wiegand_controller *ctlr,
+						enum wiegand_format format,
+						u16 payload_len);
+
+static inline void *wiegand_controller_get_devdata(
+						struct wiegand_controller *ctlr)
+{
+	return dev_get_drvdata(&ctlr->dev);
+}
+
+static inline void wiegand_controller_set_devdata(
+						struct wiegand_controller *ctlr,
+						void *data)
+{
+	dev_set_drvdata(&ctlr->dev, data);
+}
+
+#define wiegand_master_get_devdata(_ctlr) \
+	wiegand_controller_get_devdata(_ctlr)
+#define wiegand_master_set_devdata(_ctlr, _data) \
+	wiegand_controller_set_devdata(_ctlr, _data)
+
+static inline struct wiegand_controller *wiegand_controller_get(
+						struct wiegand_controller *ctlr)
+{
+	if (!ctlr || !get_device(&ctlr->dev))
+		return NULL;
+	return ctlr;
+}
+
+static inline void wiegand_controller_put(struct wiegand_controller *ctlr)
+{
+	if (ctlr)
+		put_device(&ctlr->dev);
+}
+
+/* Wiegand device section */
+
+extern struct wiegand_device *wiegand_alloc_device(
+					struct wiegand_controller *ctlr);
+extern struct wiegand_device *wiegand_new_device(
+					struct wiegand_controller *ctlr,
+					struct wiegand_board_info *chip);
+extern int wiegand_add_device(struct wiegand_device *wiegand);
+extern int wiegand_setup(struct wiegand_device *wiegand);
+extern void wiegand_unregister_device(struct wiegand_device *wiegand);
+
+extern void wiegand_set_format_and_paylen(struct wiegand_device *wdev,
+						enum wiegand_format fmt,
+						u16 payload_len);
+extern struct wiegand_device *wiegand_get_device_by_board_info(
+						struct wiegand_board_info *bi);
+extern int wiegand_send_message(struct wiegand_device *wiegand, u8 *message);
+
+static inline struct wiegand_device *to_wiegand_device(struct device *dev)
+{
+	return dev ? container_of(dev, struct wiegand_device, dev) : NULL;
+}
+static inline void wiegand_dev_put(struct wiegand_device *wiegand)
+{
+	if (wiegand)
+		put_device(&wiegand->dev);
+}
+extern int wiegand_register_board_info(struct wiegand_board_info *info, u8 n);
+
+/* Wiegand driver section  */
+
+static inline struct wiegand_driver *to_wiegand_driver(struct device_driver *drv)
+{
+	return drv ? container_of(drv, struct wiegand_driver, driver) : NULL;
+}
+extern int __wiegand_register_driver(struct module *owner,
+				     struct wiegand_driver *wdrv);
+#define wiegand_register_driver(driver) \
+	__wiegand_register_driver(THIS_MODULE, driver)
+
+static inline void wiegand_unregister_driver(struct wiegand_driver *wdrv)
+{
+	if (wdrv)
+		driver_unregister(&wdrv->driver);
+}
+
+#endif	/* H_LINUX_INCLUDE_LINUX_WIEGAND_H */
-- 
2.38.1

