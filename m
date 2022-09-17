Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E818F5BB6EE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIQHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIQHYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:11 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3574660A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220917072400epoutp04e9eb24ac7c989968d5d2bd5ec2cf0816~VlPpVXqey2922529225epoutp04a
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:24:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220917072400epoutp04e9eb24ac7c989968d5d2bd5ec2cf0816~VlPpVXqey2922529225epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399440;
        bh=5a/BnlnQRTvHHNMfzW0p6Kh/TK/IEGj6x3FCiDvaWAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Noklfz0/FKyX+BApegXpNZJ2UewOrTFVj+NXIvtdzkrdp8YFhoK1Zp/hiKr/5lWW6
         bCnqMXsQUIeoDICtnrA93x37VwPypAhTgrgrQuLKf99ry8tnda0sOjSlgLpkXTWoot
         auf90EMUbRWzXlzfAc9niyzghjJZYLVvT9NZkHkY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220917072359epcas1p1a8c1c62d85e7ac1d7472c6af6ca9bbdf~VlPouCTi10249402494epcas1p1T;
        Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.136]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MV2Vk5MQzz4x9Pw; Sat, 17 Sep
        2022 07:23:58 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.71.51827.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epcas1p485a1cdcb71cc01274db1c8d00aec197c~VlPnMPIew2368123681epcas1p4P;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220917072357epsmtrp206e5927fc66f6671fd38d22df9072977~VlPnLl12g1654916549epsmtrp2y;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
X-AuditID: b6c32a36-f25ff7000000ca73-29-6325760e3850
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.45.14392.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epsmtip21404d459ae3a75a49891fe7cd5f1c788~VlPm75ucJ3200932009epsmtip2X;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 07/13] trinity: Add sysfs module
Date:   Sat, 17 Sep 2022 16:23:50 +0900
Message-Id: <20220917072356.2255620-8-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTQJevTDXZoKdJ3eLvpGPsFlMfPmGz
        aF68ns3iffduZou9r7eyW1zeNYfN4nbjCjaLfT0fGS2eT7vO4sDp8fvXJEaPTas62TzuXNvD
        5rF/7hp2j74tqxg9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LI
        S8xNtVVy8QnQdcvMAbpKSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhb
        XJqXrpeXWmJlaGBgZApUmJCdsevETqaC+bsZK64tX8TcwPhsCmMXIyeHhICJxLkzs4FsLg4h
        gR2MEh07+5hBEkICnxglVl1UgEh8Y5Q49mMBexcjB1jH37VlEPG9jBJXez+zQTifGSV2LP7O
        DtLNJqAqMXPGGjBbRKBconnjCTCbWSBH4smdJrANwgLGEjMOfwGzWYDq33xeAmbzClhLzLtw
        hQnE5hSwkbi5qYkFIi4ocXLmExaIOfISzVtnM4MslhD4yS4xtbeXCeIfF4kt85czQ9jCEq+O
        b2GHsKUkPr/bywZhZ0tM6VjEAmEXSJx7vpUZ4jNjiYsrUkBMZgFNifW79CEqFCV2/p7LCLGW
        T+Ld1x5WiGpeiY42IYgSJYklfw5DLZKQmDrjG9QxHhLdj7ezQIKnn1Hi+MZvrBMY5Wch+WYW
        km9mIWxewMi8ilEstaA4Nz212LDACB6ryfm5mxjBKVPLbAfjpLcf9A4xMnEwHmKU4GBWEuFV
        9VRJFuJNSaysSi3Kjy8qzUktPsRoCgzficxSosn5wKSdVxJvaGJpYGJmZGxiYWhmqCTOq6fN
        mCwkkJ5YkpqdmlqQWgTTx8TBKdXAJOKYu2Szi+vttPDzYjWciqcKbs9RW7XM6pKAXNuFCx/+
        PGPq5GFY4azYJrkuUPEVj97+76I5LE2i8VbGNr+2/f/MJOz0J2W32szKFhm/+xPOzyuvuzkh
        9L5N3HT7aYGpy1LuPHM4auvpv0okk7t7HvdVjRbt7eesL/85orY3T2nTv5czWn0SQ2a4m2j/
        fzo3MCbx9tTl6T/mveNKWfJvaUL6ylztqbVpM8IkY9dcqhE4yflwrWnRgX9e4oF5D+NfcVj8
        CYms9uvPO6Wkv40r9am/uJ3v6VWMJ2v+M9bMuu9flpHzVOnYBpMAo+fsRmKt/3RXuB1e8r/7
        5hY57Z8m9zPXbpzT1cYxT3VOdG+qEktxRqKhFnNRcSIA/fDP6yIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvC5vmWqywcL1phZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGrhM7mQrm72asuLZ8EXMD47MpjF2M
        HBwSAiYSf9eWdTFycQgJ7GaUmDx/DksXIydQXEJi073lzBA1whKHDxdD1HxklGia8JYJpIZN
        QFVi5ow17CC2iECtxMGj85lBbGaBAonZT2eCzREWMJaYcfgLWJwFqP7N5yVgNq+AtcS8C1fA
        5nAK2Ejc3NQEVi8EFJ89fS4TRI2gxMmZT1ggZspLNG+dzTyBkX8WktQsJKkFjEyrGCVTC4pz
        03OLDQsM81LL9YoTc4tL89L1kvNzNzGCg1tLcwfj9lUf9A4xMnEwHmKU4GBWEuFV9VRJFuJN
        SaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFp2a1nwpY/Xv+9
        rmHk8uq27g+Z9YuWtT1M2rKgxXPD985P0TeEpr+t3PP5WHhatOX9tQU980+vWHnst96Ljyxr
        LTIL/+ruOvPUbPOFp1zPZdlVkvL7ApW8Qu8tONG15d0sFR2L3jQOt7UVBny1q9nO/GBoCio3
        uj5joWdeSK3Pe47nTmLvtrydd91cN9I66PzXat5jx5jmXVcNfr30xN3EeIkdgjWJ/vNOLJys
        kc1vXnmkyOz688pP53fsPPX3t/pK81URnq+FplxZLrJcenq56F+t89cPN3kt9HG7/E1Oe4KB
        s2HDpC2tHEeXBs89cMTlRdA9zro3e3gZudKeb6t3exUX9Y899kTfm6pPh8If2SixFGckGmox
        FxUnAgDt1Ozw3QIAAA==
X-CMS-MailID: 20220917072357epcas1p485a1cdcb71cc01274db1c8d00aec197c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p485a1cdcb71cc01274db1c8d00aec197c
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p485a1cdcb71cc01274db1c8d00aec197c@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes sysfs interfaces.

sysfs interface provides NPU's internal statistics, status and control
attribes.

The sysfs information provided by the Trinity are:
- IDU version
- profiling result
- allocated debugfs buffer

The control attributes are including:
- initialize profile operation
- NPU control (suspend/resume/stop)

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 .../ABI/testing/sysfs-driver-trinity          |  55 ++
 drivers/misc/trinity/Makefile                 |   1 +
 drivers/misc/trinity/trinity_sysfs.c          | 667 ++++++++++++++++++
 3 files changed, 723 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-trinity
 create mode 100644 drivers/misc/trinity/trinity_sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-driver-trinity b/Documentation/ABI/testing/sysfs-driver-trinity
new file mode 100644
index 000000000000..754e6f36a1dc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-trinity
@@ -0,0 +1,55 @@
+What:           /sys/devices/platform/trinity/*.triv2/debug/debugfs_max
+Date:           July 2022
+KernelVersion:  5.19-rc8
+Contact:        Jiho Chu <jiho.chu@samsung.com>
+Description:    Shows current allocated debugfs entry size.
+                Note that, Writing max entry size allocates NPU's hardware
+                memory for debugfs entries.
+
+What:           /sys/devices/platform/trinity/*.triv2/debug/idu_version
+Date:           July 2022
+KernelVersion:  5.19-rc8
+Contact:        Jiho Chu <jiho.chu@samsung.com>
+Description:    Shows IDU version
+
+What:           /sys/devices/platform/trinity/*.triv2/debug/show_profile
+Date:           July 2022
+Contact:        Jiho Chu <jiho.chu@samsung.com>
+KernelVersion:  5.19-rc8
+Description:    Shows profile information.
+                After writing Request ID, it shows information for the
+                request. This includes number of total cycles, number of
+                total operations and further information
+                (read/write count etc.) for each operation.
+
+What:           /sys/devices/platform/trinity/*.triv2/control/profile
+Date:           July 2022
+Contact:        Jiho Chu <jiho.chu@samsung.com>
+Description:    Initialize NPU profile operation with profile size.
+                It allocates NPU's hardware memory and activate profile
+                operation in NPU. Note that, write memory size in Byte.
+
+What:           /sys/devices/platform/trinity/*.triv2/control/reset
+Date:           July 2022
+KernelVersion:  5.19-rc8
+Contact:        Jiho Chu <jiho.chu@samsung.com>
+Description:    Resets NPU and reload IDU binary.
+
+What:           /sys/devices/platform/trinity/*.triv2/control/resume
+Date:           July 2022
+KernelVersion:  5.19-rc8
+Contact:        Jiho Chu <jiho.chu@samsung.com>
+Description:    Resume NPU operation
+
+What:           /sys/devices/platform/trinity/*.triv2/control/suspend
+Date:           July 2022
+KernelVersion:  5.19-rc8
+Contact:        Jiho Chu <jiho.chu@samsung.com>
+Description:    Enter suspend state
+
+What:           /sys/devices/platform/trinity/*.triv2/control/stop
+Date:           July 2022
+KernelVersion:  5.19-rc8
+Contact:        Jiho Chu <jiho.chu@samsung.com>
+Description:    Cancels all NPU workloads.
+
diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index b475938a0db6..462b7c61f39f 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -7,5 +7,6 @@ trinity-y += trinity_dma.o trinity_hwmem.o
 trinity-y += trinity_sched.o
 trinity-y += trinity_debug.o
 trinity-y += trinity_stat.o
+trinity-y += trinity_sysfs.o
 
 trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/trinity_sysfs.c b/drivers/misc/trinity/trinity_sysfs.c
new file mode 100644
index 000000000000..d716607efa28
--- /dev/null
+++ b/drivers/misc/trinity/trinity_sysfs.c
@@ -0,0 +1,667 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sysfs interface for Samsung Research Trinity device family
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/device.h>
+#include <linux/sysfs.h>
+
+#include "trinity_common.h"
+#include "trinity_stat.h"
+
+enum trinity_sysfs_msg {
+	SYSFS_MSG_NORMAL = 0,
+	SYSFS_MSG_PROLOGUE,
+	SYSFS_MSG_EPILOGUE,
+	SYSFS_MSG_EMIT,
+};
+
+static ssize_t debugfs_max_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	unsigned long msg_max;
+	int32_t ret = 0;
+
+	ret = kstrtoul(buf, 10, &msg_max);
+	if (ret != 0)
+		return -EINVAL;
+
+	trinity_debug_clear(drv, msg_max);
+
+	return count;
+}
+
+static ssize_t debugfs_max_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", trinity_debug_get_max(drv));
+}
+static DEVICE_ATTR_RW(debugfs_max);
+
+static ssize_t show_profile_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	unsigned long val;
+	int32_t ret = 0;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret != 0)
+		return -EINVAL;
+
+	drv->profile_req_id = val;
+
+	return count;
+}
+
+static ssize_t show_profile_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+
+	if (!drv->desc->get_profile)
+		return snprintf(buf, PAGE_SIZE, "profile is not supported\n");
+
+	if (drv->profile_req_id < 0)
+		return snprintf(buf, PAGE_SIZE, "invalid request id(%d)\n",
+				drv->profile_req_id);
+
+	return drv->desc->get_profile(drv, buf, drv->profile_req_id);
+}
+static DEVICE_ATTR_RW(show_profile);
+
+static ssize_t idu_version_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+
+	if (drv->desc->idu_version) {
+		uint32_t major, minor, extra;
+
+		if (drv->desc->idu_version(drv, &major, &minor, &extra) == 0)
+			return snprintf(buf, PAGE_SIZE, "v%u.%u.%u\n", major,
+					minor, extra);
+	}
+
+	return snprintf(buf, PAGE_SIZE,
+			"Unknown... v0.30.7 or higher version required.\n");
+}
+static DEVICE_ATTR_RO(idu_version);
+
+static struct attribute *trinity_attrs_debug[] = {
+	&dev_attr_debugfs_max.attr, &dev_attr_show_profile.attr,
+	&dev_attr_idu_version.attr, NULL
+};
+
+/* e.g, /sys/devices/platform/304f0000.triv2/debug/ */
+static struct attribute_group trinity_attrs_debug_group = {
+	.name = "debug",
+	.attrs = trinity_attrs_debug
+};
+
+static ssize_t max_stat_apps_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	unsigned long val;
+	int32_t ret = 0;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret != 0)
+		return -EINVAL;
+
+	trinity_stat_resize(drv, val, 0, 0);
+
+	return count;
+}
+
+static ssize_t max_stat_apps_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n",
+			trinity_stat_get_max_apps(drv));
+}
+static DEVICE_ATTR_RW(max_stat_apps);
+
+static ssize_t max_stat_reqs_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	unsigned long val;
+	int32_t ret = 0;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret != 0)
+		return -EINVAL;
+
+	trinity_stat_resize(drv, 0, val, 0);
+
+	return count;
+}
+
+static ssize_t max_stat_reqs_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n",
+			trinity_stat_get_max_reqs(drv));
+}
+static DEVICE_ATTR_RW(max_stat_reqs);
+
+static ssize_t max_stat_reqs_per_app_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	unsigned long val;
+	int32_t ret = 0;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret != 0)
+		return -EINVAL;
+
+	trinity_stat_resize(drv, 0, 0, val);
+
+	return count;
+}
+
+static ssize_t max_stat_reqs_per_app_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n",
+			trinity_stat_get_max_reqs_per_app(drv));
+}
+static DEVICE_ATTR_RW(max_stat_reqs_per_app);
+
+static ssize_t mem_usage_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	struct trinity_stat_app *stat_app;
+	ssize_t pos = 0;
+	bool first = true;
+
+	trinity_stat_lock(&drv->stat);
+
+	list_for_each_entry(stat_app, &drv->stat.list, lnode) {
+		if (first) {
+			pos += snprintf(
+				buf + pos, PAGE_SIZE,
+				"Memory usage statistics for all opened devices\n");
+			first = false;
+		}
+
+		pos += snprintf(
+			buf + pos, PAGE_SIZE,
+			" [%d] total_alloc: %llu bytes, total_freed: %llu bytes\n",
+			stat_app->app_id, stat_app->total_alloc_mem,
+			stat_app->total_freed_mem);
+	}
+
+	if (first)
+		pos += snprintf(buf + pos, PAGE_SIZE, "No active devices\n");
+
+	trinity_stat_unlock(&drv->stat);
+
+	return pos;
+}
+static DEVICE_ATTR_RO(mem_usage);
+
+#define MODEL_REGISTERED_PROLOGUE                                    \
+	"\n   Model statistics registered in all opened devices\n"   \
+	"+--------------+--------------+-----------+------------+\n" \
+	"|   Model ID   |  Model Size  | Dmabuf FD |   Offset   |\n" \
+	"+--------------+--------------+-----------+------------+\n"
+#define MODEL_REGISTERED_NORMAL "| %#12llx | %#12llx | %9d | %#10llx |\n"
+#define MODEL_REGISTERED_EPILOGUE \
+	"+--------------+--------------+-----------+------------+\n"
+
+static ssize_t print_registered_models(const struct trinity_model *model,
+				       char *buf, enum trinity_sysfs_msg msg)
+{
+	ssize_t pos = 0;
+
+	switch (msg) {
+	case SYSFS_MSG_PROLOGUE:
+		pos = snprintf(buf, PAGE_SIZE, MODEL_REGISTERED_PROLOGUE);
+		break;
+	case SYSFS_MSG_NORMAL:
+		pos = snprintf(buf, PAGE_SIZE, MODEL_REGISTERED_NORMAL,
+			       model->config.id, model->config.program_size,
+			       model->config.dbuf_fd,
+			       model->config.program_offset_addr);
+		break;
+	case SYSFS_MSG_EPILOGUE:
+		pos = snprintf(buf, PAGE_SIZE, MODEL_REGISTERED_EPILOGUE);
+		break;
+	default:
+		break;
+	}
+
+	return pos;
+}
+
+static ssize_t registered_models_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	struct hlist_bl_head *model_htable;
+	struct trinity_model *model;
+	struct hlist_bl_node *hn;
+	ssize_t pos;
+	int i, num_printed = 0;
+
+	model_htable = drv->model_htable;
+
+	pos = print_registered_models(NULL, buf, SYSFS_MSG_PROLOGUE);
+
+	for (i = 0; i < TRINITY_MODEL_HASH_SIZE; i++) {
+		hlist_bl_lock(model_htable + i);
+		hlist_bl_for_each_entry(model, hn, model_htable + i, hnode) {
+			pos += print_registered_models(model, buf + pos,
+						       SYSFS_MSG_NORMAL);
+			num_printed++;
+		}
+		hlist_bl_unlock(model_htable + i);
+	}
+
+	if (num_printed > 0)
+		pos += print_registered_models(NULL, buf + pos,
+					       SYSFS_MSG_EPILOGUE);
+
+	return pos;
+}
+static DEVICE_ATTR_RO(registered_models);
+
+static const char *priority_to_string(enum trinity_req_priority priority)
+{
+	static const char *const priority_strings[] = {
+		[TRINITY_REQ_PRIORITY_LOW] = "Low",
+		[TRINITY_REQ_PRIORITY_MID] = "Mid",
+		[TRINITY_REQ_PRIORITY_HIGH] = "High",
+	};
+	return priority_strings[priority];
+}
+
+static const char *status_to_string(enum trinity_req_status status)
+{
+	static const char *const status_strings[] = {
+		[TRINITY_REQ_STATUS_UNKNOWN] = "Unknown",
+		[TRINITY_REQ_STATUS_ERROR] = "Error",
+		[TRINITY_REQ_STATUS_PENDING] = "Pending",
+		[TRINITY_REQ_STATUS_RUNNING] = "Running",
+		[TRINITY_REQ_STATUS_FINISHED] = "Finished",
+	};
+	return status_strings[status];
+}
+
+#define APP_STATUS_LENGTH (77)
+#define USER_APP_STATUS_PROLOGUE                                                         \
+	"\n\tUser-level request statistics running in %s\n"                              \
+	"+-------+--------+----------+------+----------+--------------+-------------+\n" \
+	"|  PID  | Req ID | Model ID | Prio |  Status  |  Sched (us)  |  Infer (us) |\n" \
+	"+-------+--------+----------+------+----------+--------------+-------------+\n"
+#define USER_APP_STATUS_NORMAL \
+	"| %5d | %6d | %#8llx | %4s | %8s | %12lld | %11lld |\n"
+#define USER_APP_STATUS_EMIT \
+	"|                             ... (emitted) ...                            |\n"
+#define USER_APP_STATUS_EPILOGUE \
+	"+-------+--------+----------+------+----------+--------------+-------------+\n"
+
+static ssize_t print_user_app_status(struct device *dev,
+				     const struct trinity_stat_req *req,
+				     char *buf, enum trinity_sysfs_msg msg)
+{
+	ssize_t pos = 0;
+
+	switch (msg) {
+	case SYSFS_MSG_PROLOGUE:
+		pos = snprintf(buf, APP_STATUS_LENGTH * 4 + 1,
+			       USER_APP_STATUS_PROLOGUE, dev_name(dev));
+		break;
+	case SYSFS_MSG_NORMAL: {
+		ktime_t cur_time = ktime_get();
+		ktime_t submitted = req->submitted;
+		ktime_t scheduled = req->scheduled ? req->scheduled : cur_time;
+		ktime_t completed = req->completed ? req->completed : cur_time;
+
+		int64_t sched_diff = TIME_DIFF_US(scheduled, submitted);
+		int64_t infer_diff = TIME_DIFF_US(completed, scheduled);
+
+		if (req->status == TRINITY_REQ_STATUS_ERROR) {
+			sched_diff = 0;
+			infer_diff = 0;
+		}
+
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       USER_APP_STATUS_NORMAL, req->app_id, req->req_id,
+			       req->model_id, priority_to_string(req->priority),
+			       status_to_string(req->status), sched_diff,
+			       infer_diff);
+	} break;
+	case SYSFS_MSG_EMIT:
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       USER_APP_STATUS_EMIT);
+		break;
+	case SYSFS_MSG_EPILOGUE:
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       USER_APP_STATUS_EPILOGUE);
+		break;
+	default:
+		break;
+	}
+
+	return pos;
+}
+
+#define KERNEL_APP_STATUS_PROLOGUE                                                       \
+	"\n\tKernel-level request statistics running in %s\n"                            \
+	"+-------+--------+----------+------+----------+------------+---------------+\n" \
+	"|  PID  | Req ID | Model ID | Prio |  Status  |   # Runs   | Avg. Lat (us) |\n" \
+	"+-------+--------+----------+------+----------+------------+---------------+\n"
+#define KERNEL_APP_STATUS_NORMAL \
+	"| %5d | %6d | %#8llx | %4s | %8s | %10u | %13u |\n"
+#define KERNEL_APP_STATUS_EMIT \
+	"|                             ... (emitted) ...                            |\n"
+#define KERNEL_APP_STATUS_EPILOGUE \
+	"+-------+--------+----------+------+----------+------------+---------------+\n"
+
+static ssize_t print_kernel_app_status(struct device *dev,
+				       const struct trinity_stat_req *req,
+				       char *buf, enum trinity_sysfs_msg msg)
+{
+	ssize_t pos = 0;
+
+	switch (msg) {
+	case SYSFS_MSG_PROLOGUE:
+		pos = snprintf(buf, APP_STATUS_LENGTH * 4 + 1,
+			       KERNEL_APP_STATUS_PROLOGUE, dev_name(dev));
+		break;
+	case SYSFS_MSG_NORMAL: {
+		uint32_t avg_latency = 0;
+
+		if (req->num_runs > 0)
+			avg_latency = req->total_time / req->num_runs;
+
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       KERNEL_APP_STATUS_NORMAL, req->app_id,
+			       req->req_id, req->model_id,
+			       priority_to_string(req->priority),
+			       status_to_string(req->status), req->num_runs,
+			       avg_latency);
+	} break;
+	case SYSFS_MSG_EMIT:
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       KERNEL_APP_STATUS_EMIT);
+		break;
+	case SYSFS_MSG_EPILOGUE:
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       KERNEL_APP_STATUS_EPILOGUE);
+		break;
+	default:
+		break;
+	}
+
+	return pos;
+}
+
+static ssize_t app_status_user_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	struct trinity_stat_app *stat_app;
+	struct trinity_stat_req *stat_req;
+	int num_printed = 0;
+	ssize_t pos;
+
+	pos = print_user_app_status(dev, NULL, buf, SYSFS_MSG_PROLOGUE);
+
+	trinity_stat_lock(&drv->stat);
+	list_for_each_entry(stat_app, &drv->stat.list, lnode) {
+		list_for_each_entry(stat_req, &stat_app->reqs, list) {
+			if (stat_req->is_kernel)
+				continue;
+
+			pos += print_user_app_status(dev, stat_req, buf + pos,
+						     SYSFS_MSG_NORMAL);
+			num_printed++;
+
+			/* buffer size limit: PAGE_SIZE (also need reserved bytes) */
+			if (pos + APP_STATUS_LENGTH >
+			    PAGE_SIZE - 2 * APP_STATUS_LENGTH) {
+				pos += print_user_app_status(
+					dev, NULL, buf + pos, SYSFS_MSG_EMIT);
+				/* clear old stats */
+				trinity_destroy_stats(&drv->stat, true);
+				goto out;
+			}
+		}
+	}
+out:
+	trinity_stat_unlock(&drv->stat);
+
+	if (num_printed > 0)
+		pos += print_user_app_status(dev, NULL, buf + pos,
+					     SYSFS_MSG_EPILOGUE);
+
+	return pos;
+}
+static DEVICE_ATTR_RO(app_status_user);
+
+static ssize_t app_status_kernel_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	struct trinity_stat_app *stat_app;
+	struct trinity_stat_req *stat_req;
+	int num_printed = 0;
+	ssize_t pos;
+
+	pos = print_kernel_app_status(dev, NULL, buf, SYSFS_MSG_PROLOGUE);
+
+	trinity_stat_lock(&drv->stat);
+	list_for_each_entry(stat_app, &drv->stat.list, lnode) {
+		list_for_each_entry(stat_req, &stat_app->reqs, list) {
+			if (!stat_req->is_kernel)
+				continue;
+
+			pos += print_kernel_app_status(dev, stat_req, buf + pos,
+						       SYSFS_MSG_NORMAL);
+			num_printed++;
+
+			/* buffer size limit: PAGE_SIZE (also need reserved bytes) */
+			if (pos + APP_STATUS_LENGTH >
+			    PAGE_SIZE - 2 * APP_STATUS_LENGTH) {
+				pos += print_kernel_app_status(
+					dev, NULL, buf + pos, SYSFS_MSG_EMIT);
+				/* clear old stats */
+				trinity_destroy_stats(&drv->stat, true);
+				goto out;
+			}
+		}
+	}
+out:
+	trinity_stat_unlock(&drv->stat);
+
+	if (num_printed > 0)
+		pos += print_kernel_app_status(dev, NULL, buf + pos,
+					       SYSFS_MSG_EPILOGUE);
+
+	return pos;
+}
+static DEVICE_ATTR_RO(app_status_kernel);
+
+static ssize_t num_total_reqs_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	struct trinity_stat_app *stat_app;
+	uint32_t num_total_reqs = 0;
+
+	trinity_stat_lock(&drv->stat);
+	list_for_each_entry(stat_app, &drv->stat.list, lnode) {
+		num_total_reqs += stat_app->num_total_reqs;
+	}
+	trinity_stat_unlock(&drv->stat);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", num_total_reqs);
+}
+static DEVICE_ATTR_RO(num_total_reqs);
+
+static ssize_t num_active_reqs_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	struct trinity_stat_app *stat_app;
+	uint32_t num_active_reqs = 0;
+
+	trinity_stat_lock(&drv->stat);
+	list_for_each_entry(stat_app, &drv->stat.list, lnode) {
+		num_active_reqs += stat_app->num_active_reqs;
+	}
+	trinity_stat_unlock(&drv->stat);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", num_active_reqs);
+}
+static DEVICE_ATTR_RO(num_active_reqs);
+
+static struct attribute *trinity_attrs_stat[] = {
+	&dev_attr_max_stat_apps.attr,	      &dev_attr_max_stat_reqs.attr,
+	&dev_attr_max_stat_reqs_per_app.attr, &dev_attr_mem_usage.attr,
+	&dev_attr_registered_models.attr,     &dev_attr_app_status_user.attr,
+	&dev_attr_app_status_kernel.attr,     &dev_attr_num_total_reqs.attr,
+	&dev_attr_num_active_reqs.attr,	      NULL
+};
+
+/* e.g, /sys/devices/platform/304f0000.triv2/stat/ */
+static struct attribute_group trinity_attrs_stat_group = {
+	.name = "stat",
+	.attrs = trinity_attrs_stat
+};
+
+static ssize_t stop_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+
+	if (drv->desc->stop_reqs)
+		schedule_work(&drv->work_stop);
+
+	return count;
+}
+static DEVICE_ATTR_WO(stop);
+
+static ssize_t suspend_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	if (dev->driver->pm)
+		dev->driver->pm->runtime_suspend(dev);
+
+	return count;
+}
+static DEVICE_ATTR_WO(suspend);
+
+static ssize_t resume_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	if (dev->driver->pm)
+		dev->driver->pm->runtime_resume(dev);
+
+	return count;
+}
+static DEVICE_ATTR_WO(resume);
+
+static ssize_t profile_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	unsigned long profile;
+
+	if (kstrtoul(buf, 10, &profile) != 0)
+		return 0;
+
+	/** Note that this interface is used only for testing purpose */
+	if (drv->desc->init_profile)
+		drv->desc->init_profile(drv, profile);
+
+	return count;
+}
+static DEVICE_ATTR_WO(profile);
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	unsigned long reset;
+
+	if (kstrtoul(buf, 10, &reset) != 0)
+		return 0;
+
+	if (reset == 1 && drv->desc->reset)
+		drv->desc->reset(drv);
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static struct attribute *trinity_attrs_control[] = { &dev_attr_stop.attr,
+						     &dev_attr_suspend.attr,
+						     &dev_attr_resume.attr,
+						     &dev_attr_profile.attr,
+						     &dev_attr_reset.attr,
+						     NULL };
+
+/* e.g, /sys/devices/platform/304f0000.triv2/control/ */
+static struct attribute_group trinity_attrs_control_group = {
+	.name = "control",
+	.attrs = trinity_attrs_control
+};
+
+static const struct attribute_group *trinity_attrs_groups[] = {
+	&trinity_attrs_debug_group, &trinity_attrs_stat_group,
+	&trinity_attrs_control_group, NULL
+};
+
+int trinity_sysfs_init(struct trinity_driver *drv)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	int err;
+
+	err = device_add_groups(dev, trinity_attrs_groups);
+	if (err < 0) {
+		dev_err(dev, "failed to create sysfs groups\n");
+		return err;
+	}
+
+	return 0;
+}
+
+int trinity_sysfs_cleanup(struct trinity_driver *drv)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+
+	device_remove_groups(dev, trinity_attrs_groups);
+
+	return 0;
+}
-- 
2.25.1

