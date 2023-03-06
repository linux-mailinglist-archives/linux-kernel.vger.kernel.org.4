Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2416AB587
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCFEOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCFENu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:13:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8955FF4;
        Sun,  5 Mar 2023 20:13:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ufx+EHkMa6qiLm2uI/ku7UrwLNbZY9jtVFvoBRF2+hicCaxAttm6tIYuQKL6HgtvDyitJfXs8ZUvb+1MrU1l84ua0E0gv/fU7f5CJXRexvklq72v4Xme3HE1KEfLXP2CwWerQDDetyYwN6lqe5WD407vhVPwlBWJc6y2AJ5cTiUo4XsJcngb627wZpWCLkIUMa2nN6DNPY0k3peEjThcPLPU5LTg0B7SZSvUk0vhldQ2q22Pb/YSQW0Kswt5gARGM2eSQdHw4Cldg0hVMY8GMIsPm4tHr9j+dentc9j8+9HHJJAQWSxs5iNAXuBBtjxUtrD2pI9qoqQEUgoTc5zOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qzrs8Sgtm2AhpF32szjMdL1zTsNvO9oq5LYUwlrpHvQ=;
 b=Lh7QmPucxX3vCdlztnYxqcx78qnmti4tIXgdaqudQhJeGFa4XH471zAail6aLEFuUdPi76GIkvEr4ZksNfOPSsK8uFBbTDGRc71WTLo3RnH48tO+id1gkO+I2MsORxBF0WMT9EK6yDHPkWra/YvanvLUF3cOH68bjjCKo+JUd/F3d+XMZFwCU/cmxIVS0fh7wt+7DXyhtHganuFVDGJBmEAl2yX14pAcBZkSKVPnQUv1yHJuB7s7HctTt3fGixRJ32wV4+TQo6jz646mZunszuIabyuYwH+t3/4J6PVyhaUjboptKgX9n1XvUw43HhCI/rW+ZZi2UkyLPQRWmgeOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qzrs8Sgtm2AhpF32szjMdL1zTsNvO9oq5LYUwlrpHvQ=;
 b=GerZy+rWegIOgrofgf8evstyXSCzWkXJieN/38jM1MHlNZB5ozxmJtviys389Iu+UKegVsv/IctsvDKldHD3wXztztdIYmZCTuO2Xxw47dUXUzq5UOCk/xjDOf2wV4SJUkr2zUnBurFyYakLQkjhmaOgj6xIM0eszpWyqyqObRc=
Received: from BN9PR03CA0246.namprd03.prod.outlook.com (2603:10b6:408:ff::11)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 04:11:48 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::fd) by BN9PR03CA0246.outlook.office365.com
 (2603:10b6:408:ff::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 04:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:11:48 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:11:40 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 15/15] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Sun, 5 Mar 2023 20:07:39 -0800
Message-ID: <20230306040739.51488-16-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: d995e9c2-2e0f-4a11-e198-08db1df8e7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UatIACIY8M0yTgZA/pISHgdP124rzPyiFXOGIKYAmA0wiWTYm0CIupIdfC0PdLJzOvLTJyiRobvki5AujTCGY2GdbxX9m9DloysygvEd+Z2lnyyObw6+/pWLKG+Lazib6lGy4RthOykDiOd+6B/xhzMLXkIjkY4xwYvAYvQWIh2rKhvqiL/uzOaWbAFUqBhclzKQXHBwsufeCJr8+gTp7U3d76fsLYyq7G4FJiB83KMn+ILfWq7uqoXUNZOHow/b/wOqfKcQZKZ5ZlbW50kWTja+wYSyEtmnavdEI2sWPtXkOcQzdQglAaxNWEE0ueXkG/c+OV2O/JziYmN97qqT0O4GJR+PXHmP6ic/sP9ZgIx+JXu/eOl/gwXun6AVIQ//GKu1nwrpekb6FhvEZQgj3uHO0Js3xfaG28/J9FqzkZXedhcbrX37Wg/j9vlERfwte09kSYh9DM1Dao5kCPMz6IlbZZChCfBHz8ywQ8ent1o84v8HvFJb496+lqCwn3yRxg3XFj7HPSo0IiRFYWor4s8OmAfAMC465paIYmxrbZ2nu5Ur/g893WE+kjo8VYgDG2BWxHtI8ALJLBXvB3/2GoGJjfFjgpU15Wid7ovrqwcjWPSZDCHrizeLMPJ/l2LpFJl4T0LGIbhvwuMZi75EaNJ0MLfrdx0UBVReqs2jbP7Hc3h9ma0sQ1EbQ040Uykgb8dIqNrmartaVaUY/FrM6akz2FaGkLQo8fHOLdRbdvY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(81166007)(5660300002)(336012)(2906002)(356005)(1076003)(26005)(16526019)(186003)(82740400003)(2616005)(7406005)(7416002)(478600001)(4326008)(6916009)(8676002)(70206006)(70586007)(40460700003)(30864003)(36860700001)(426003)(36756003)(40480700001)(41300700001)(47076005)(316002)(8936002)(83380400001)(82310400005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:11:48.3309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d995e9c2-2e0f-4a11-e198-08db1df8e7f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pensando SoC controller is a SPI connected companion device
that is present in all Pensando SoC board designs.  The essential
board management registers are accessed on chip select 0 with
board mgmt IO support accessed using additional chip selects.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v10 changes:
- Different driver implementation specific to this Pensando controller device.
- Moved to soc/amd directory under new name based on guidance.  This driver is
  of no use to any design other than all Pensando SoC based cards.
- Removed use of builtin_driver, can be built as a module.

v9 changes:
- Previously patch 14/17
- After the change to the device tree node and squashing
  reset-cells into the parent simplified this to not use
  any MFD API and move it to drivers/spi/pensando-sr.c.
- Change the naming to remove elba since this driver is common
  for all Pensando SoC designs .
- Default yes SPI_PENSANDO_SR for ARCH_PENSANDO

---
 drivers/soc/Kconfig                    |   1 +
 drivers/soc/Makefile                   |   1 +
 drivers/soc/amd/Kconfig                |  16 ++
 drivers/soc/amd/Makefile               |   2 +
 drivers/soc/amd/amd-pensando-ctrl.c    | 378 +++++++++++++++++++++++++
 include/uapi/linux/amd-pensando-ctrl.h |  30 ++
 6 files changed, 428 insertions(+)
 create mode 100644 drivers/soc/amd/Kconfig
 create mode 100644 drivers/soc/amd/Makefile
 create mode 100644 drivers/soc/amd/amd-pensando-ctrl.c
 create mode 100644 include/uapi/linux/amd-pensando-ctrl.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 4e176280113a..9e023f74e47c 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -2,6 +2,7 @@
 menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/actions/Kconfig"
+source "drivers/soc/amd/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/apple/Kconfig"
 source "drivers/soc/aspeed/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 3b0f9fb3b5c8..8914530f2721 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
+obj-y				+= amd/
 obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
diff --git a/drivers/soc/amd/Kconfig b/drivers/soc/amd/Kconfig
new file mode 100644
index 000000000000..9fc03de49f11
--- /dev/null
+++ b/drivers/soc/amd/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "AMD Pensando SoC drivers"
+
+config AMD_PENSANDO_CTRL
+	tristate "AMD Pensando SoC Controller"
+	depends on SPI_MASTER=y
+	depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
+	default y if ARCH_PENSANDO
+	select REGMAP_SPI
+	select MFD_SYSCON
+	help
+	  Enables AMD Pensando SoC controller device support.  This is a SPI
+	  attached companion device in all Pensando SoC board designs which
+	  provides essential board control/status registers and management IO
+	  support.
+endmenu
diff --git a/drivers/soc/amd/Makefile b/drivers/soc/amd/Makefile
new file mode 100644
index 000000000000..6505bfe71baf
--- /dev/null
+++ b/drivers/soc/amd/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_AMD_PENSANDO_CTRL)	+= amd-pensando-ctrl.o
diff --git a/drivers/soc/amd/amd-pensando-ctrl.c b/drivers/soc/amd/amd-pensando-ctrl.c
new file mode 100644
index 000000000000..f60ca7375bc1
--- /dev/null
+++ b/drivers/soc/amd/amd-pensando-ctrl.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Pensando SoC Controller Driver
+ *
+ * Userspace interface and reset driver support for SPI connected Pensando SoC
+ * controller device.  This device is present in all Pensando SoC designs and
+ * contains board control/status regsiters and management IO support.
+ *
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/reset-controller.h>
+#include <linux/spi/spi.h>
+#include <linux/amd-pensando-ctrl.h>
+
+struct penctrl_device {
+	struct spi_device *spi_dev;
+	struct reset_controller_dev rcdev;
+};
+
+static DEFINE_MUTEX(spi_lock);
+static dev_t penctrl_devt;
+static struct penctrl_device *penctrl;
+static struct class *penctrl_class;
+
+static long
+penctrl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct spi_transfer t[2] = { 0 };
+	struct penctrl_device *penctrl;
+	struct penctrl_spi_xfer *msg;
+	struct spi_device *spi_dev;
+	unsigned int num_msgs;
+	struct spi_message m;
+	u8 tx_buf[PENCTRL_MAX_MSG_LEN];
+	u8 rx_buf[PENCTRL_MAX_MSG_LEN];
+	u32 size;
+	int ret;
+
+	/* Check for a valid command */
+	if (_IOC_TYPE(cmd) != PENCTRL_IOC_MAGIC)
+		return -ENOTTY;
+
+	if (_IOC_NR(cmd) > PENCTRL_IOC_MAXNR)
+		return -ENOTTY;
+
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+	else if (_IOC_DIR(cmd) & _IOC_WRITE)
+		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+
+	if (ret)
+		return -EFAULT;
+
+	/* Get a reference to the SPI device */
+	penctrl = filp->private_data;
+	if (!penctrl)
+		return -ESHUTDOWN;
+
+	spi_dev = spi_dev_get(penctrl->spi_dev);
+	if (!spi_dev)
+		return -ESHUTDOWN;
+
+	/* Verify and prepare spi message */
+	size = _IOC_SIZE(cmd);
+	if ((size % sizeof(struct penctrl_spi_xfer)) != 0) {
+		ret = -EINVAL;
+		goto done;
+	}
+	num_msgs = size / sizeof(struct penctrl_spi_xfer);
+	if (num_msgs == 0) {
+		ret = -EINVAL;
+		goto done;
+	}
+	msg = memdup_user((struct penctrl_spi_xfer __user *)arg, size);
+	if (!msg) {
+		ret = PTR_ERR(msg);
+		goto done;
+	}
+	if (msg->len > PENCTRL_MAX_MSG_LEN) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	t[0].tx_buf = tx_buf;
+	t[0].len = msg->len;
+	if (copy_from_user(tx_buf, (void __user *)msg->tx_buf, msg->len)) {
+		ret = -EFAULT;
+		goto done;
+	}
+	if (num_msgs > 1) {
+		msg++;
+		if (msg->len > PENCTRL_MAX_MSG_LEN) {
+			ret = -EINVAL;
+			goto done;
+		}
+		t[1].rx_buf = rx_buf;
+		t[1].len = msg->len;
+	}
+	spi_message_init_with_transfers(&m, t, num_msgs);
+
+	/* Perform the transfer */
+	mutex_lock(&spi_lock);
+	ret = spi_sync(spi_dev, &m);
+	mutex_unlock(&spi_lock);
+
+	if (ret || (num_msgs == 1))
+		goto done;
+
+	if (copy_to_user((void __user *)msg->rx_buf, rx_buf, msg->len))
+		ret = -EFAULT;
+
+done:
+	spi_dev_put(spi_dev);
+	return ret;
+}
+
+static int penctrl_open(struct inode *inode, struct file *filp)
+{
+	struct spi_device *spi_dev;
+	u8 current_cs;
+
+	if (!penctrl)
+		return -ENODEV;
+
+	filp->private_data = penctrl;
+	current_cs = iminor(inode);
+	spi_dev = penctrl->spi_dev;
+	spi_dev->chip_select = current_cs;
+	spi_dev->cs_gpiod = spi_dev->controller->cs_gpiods[current_cs];
+	spi_setup(spi_dev);
+	stream_open(inode, filp);
+
+	return 0;
+}
+
+static int penctrl_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations penctrl_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl = penctrl_ioctl,
+	.open		= penctrl_open,
+	.release	= penctrl_release,
+	.llseek		= no_llseek,
+};
+
+static int penctrl_regs_read(struct penctrl_device *penctrl, u32 reg, u32 *val)
+{
+	struct spi_device *spi_dev = penctrl->spi_dev;
+	struct spi_transfer t[2] = { 0 };
+	struct spi_message m;
+	u8 txbuf[3];
+	u8 rxbuf[1];
+	int ret;
+
+	txbuf[0] = PENCTRL_SPI_CMD_REGRD;
+	txbuf[1] = reg;
+	txbuf[2] = 0x0;
+	t[0].tx_buf = txbuf;
+	t[0].len = 3;
+
+	rxbuf[0] = 0x0;
+	t[1].rx_buf = rxbuf;
+	t[1].len = 1;
+
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
+	ret = spi_sync(spi_dev, &m);
+	if (ret == 0)
+		*val = rxbuf[0];
+
+	return ret;
+}
+
+static int penctrl_regs_write(struct penctrl_device *penctrl, u32 reg, u32 val)
+{
+	struct spi_device *spi_dev = penctrl->spi_dev;
+	struct spi_transfer t[1] = { 0 };
+	struct spi_message m;
+	u8 txbuf[4];
+	int ret;
+
+	txbuf[0] = PENCTRL_SPI_CMD_REGWR;
+	txbuf[1] = reg;
+	txbuf[2] = val;
+	txbuf[3] = 0;
+
+	t[0].tx_buf = txbuf;
+	t[0].len = 4;
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
+	ret = spi_sync(spi_dev, &m);
+	return ret;
+}
+
+static int penctrl_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct penctrl_device *penctrl =
+		container_of(rcdev, struct penctrl_device, rcdev);
+	struct spi_device *spi_dev = penctrl->spi_dev;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&spi_lock);
+	spi_dev->chip_select = 0;
+	spi_dev->cs_gpiod = spi_dev->controller->cs_gpiods[0];
+	spi_setup(spi_dev);
+	ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
+	if (ret) {
+		dev_err(&spi_dev->dev, "error reading ctrl0 reg\n");
+		goto done;
+	}
+
+	val |= BIT(6);
+	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
+	if (ret)
+		dev_err(&spi_dev->dev, "error writing ctrl0 reg\n");
+
+done:
+	mutex_unlock(&spi_lock);
+	return ret;
+}
+
+static int penctrl_reset_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct penctrl_device *penctrl =
+		container_of(rcdev, struct penctrl_device, rcdev);
+	struct spi_device *spi_dev = penctrl->spi_dev;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&spi_lock);
+	spi_dev->chip_select = 0;
+	spi_dev->cs_gpiod = spi_dev->controller->cs_gpiods[0];
+	spi_setup(spi_dev);
+	ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
+	if (ret) {
+		dev_err(&spi_dev->dev, "error reading ctrl0 reg\n");
+		goto done;
+	}
+
+	val &= ~BIT(6);
+	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
+	if (ret)
+		dev_err(&spi_dev->dev, "error writing ctrl0 reg\n");
+
+done:
+	mutex_unlock(&spi_lock);
+	return ret;
+}
+
+static const struct reset_control_ops penctrl_reset_ops = {
+	.assert = penctrl_reset_assert,
+	.deassert = penctrl_reset_deassert,
+};
+
+static int penctrl_spi_probe(struct spi_device *spi_dev)
+{
+	struct device_node *np;
+	struct device *dev;
+	struct cdev *cdev;
+	u32 num_cs;
+	int ret;
+	u32 cs;
+
+	np = spi_dev->dev.parent->of_node;
+	ret = of_property_read_u32(np, "num-cs", &num_cs);
+	if (ret)
+		return dev_err_probe(&spi_dev->dev, ret,
+				     "number of chip-selects not defined");
+
+	ret = alloc_chrdev_region(&penctrl_devt, 0, num_cs, "penctrl");
+	if (ret)
+		return dev_err_probe(&spi_dev->dev, ret,
+				     "failed to alloc chrdev region\n");
+
+	penctrl_class = class_create(THIS_MODULE, "penctrl");
+	if (IS_ERR(penctrl_class)) {
+		unregister_chrdev(MAJOR(penctrl_devt), "penctrl");
+		return dev_err_probe(&spi_dev->dev, PTR_ERR(penctrl_class),
+				     "failed to create class\n");
+	}
+
+	cdev = cdev_alloc();
+	if (!cdev) {
+		dev_err(&spi_dev->dev, "allocation of cdev failed");
+		ret = -ENOMEM;
+		goto cdev_failed;
+	}
+	cdev->owner = THIS_MODULE;
+	cdev_init(cdev, &penctrl_fops);
+
+	ret = cdev_add(cdev, penctrl_devt, num_cs);
+	if (ret) {
+		dev_err(&spi_dev->dev, "register of cdev failed");
+		goto cdev_delete;
+	}
+
+	/* Allocate driver data */
+	penctrl = kzalloc(sizeof(*penctrl), GFP_KERNEL);
+	if (!penctrl) {
+		ret = -ENOMEM;
+		dev_err(&spi_dev->dev, "allocate driver data failed");
+		goto cdev_delete;
+	}
+
+	penctrl->spi_dev = spi_dev;
+	mutex_init(&spi_lock);
+
+	/* Create a device for each chip select */
+	for (cs = 0; cs < num_cs; cs++) {
+		dev = device_create(penctrl_class,
+				    &spi_dev->dev,
+				    MKDEV(MAJOR(penctrl_devt), cs),
+				    penctrl,
+				    "penctrl0.%d",
+				    cs);
+		if (IS_ERR(dev)) {
+			ret = IS_ERR(dev);
+			dev_err(&spi_dev->dev, "error creating device\n");
+			goto cdev_delete;
+		}
+		dev_dbg(&spi_dev->dev, "created device major %u, minor %d\n",
+			MAJOR(penctrl_devt), cs);
+	}
+
+	spi_set_drvdata(spi_dev, penctrl);
+
+	/* Register emmc hardware reset */
+	penctrl->rcdev.nr_resets = 1;
+	penctrl->rcdev.owner = THIS_MODULE;
+	penctrl->rcdev.dev = &spi_dev->dev;
+	penctrl->rcdev.ops = &penctrl_reset_ops;
+	penctrl->rcdev.of_node = spi_dev->dev.of_node;
+	ret = reset_controller_register(&penctrl->rcdev);
+	if (ret)
+		return dev_err_probe(&spi_dev->dev, ret,
+				     "failed to register reset controller\n");
+	return ret;
+
+cdev_delete:
+	cdev_del(cdev);
+cdev_failed:
+	device_destroy(penctrl_class, penctrl_devt);
+	return ret;
+}
+
+static const struct of_device_id penctrl_dt_match[] = {
+	{ .compatible = "amd,pensando-ctrl" },
+	{ /* sentinel */ }
+};
+
+static struct spi_driver penctrl_spi_driver = {
+	.probe = penctrl_spi_probe,
+	.driver = {
+		.name = "pensando-ctrl",
+		.of_match_table = penctrl_dt_match,
+	},
+};
+module_spi_driver(penctrl_spi_driver);
+
+MODULE_AUTHOR("Brad Larson <blarson@amd.com>");
+MODULE_DESCRIPTION("AMD Pensando SoC Controller via SPI");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/amd-pensando-ctrl.h b/include/uapi/linux/amd-pensando-ctrl.h
new file mode 100644
index 000000000000..0a6caf3b764c
--- /dev/null
+++ b/include/uapi/linux/amd-pensando-ctrl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for /dev/penctrl
+ *
+ * This file can be used by applications that need to communicate
+ * with the AMD Pensando SoC controller device via the ioctl interface.
+ */
+#ifndef _UAPI_LINUX_AMD_PENSANDO_CTRL_H
+#define _UAPI_LINUX_AMD_PENSANDO_CTRL_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define PENCTRL_SPI_CMD_REGRD	0x0b
+#define PENCTRL_SPI_CMD_REGWR	0x02
+#define PENCTRL_IOC_MAGIC	'k'
+#define PENCTRL_IOC_MAXNR	0
+#define PENCTRL_MAX_MSG_LEN	16
+#define PENCTRL_MAX_REG		0xff
+#define PENCTRL_REG_CTRL0	0x10
+
+struct penctrl_spi_xfer {
+	__u64 tx_buf;
+	__u64 rx_buf;
+	__u32 len;
+	__u32 speed_hz;
+	__u64 compat;
+};
+
+#endif /* _UAPI_LINUX_AMD_PENSANDO_CTRL_H */
-- 
2.17.1

