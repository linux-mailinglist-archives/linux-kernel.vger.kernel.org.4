Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245C9627875
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiKNJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiKNJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:02:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8813F5FFE;
        Mon, 14 Nov 2022 01:02:52 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N9jxg2jBRzmVys;
        Mon, 14 Nov 2022 17:02:31 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 17:02:50 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 17:02:50 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <lpieralisi@kernel.org>,
        <linuxarm@huawei.com>, <yangyicong@huawei.com>,
        <liuqi115@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH v13 2/2] Documentation: Add document for UltraSoc SMB drivers
Date:   Mon, 14 Nov 2022 17:03:16 +0800
Message-ID: <20221114090316.63157-3-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221114090316.63157-1-hejunhao3@huawei.com>
References: <20221114090316.63157-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Liu <liuqi115@huawei.com>

This patch bring in documentation for UltraSoc SMB drivers.
It simply describes the device, sysfs interface and the
firmware bindings.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../sysfs-bus-coresight-devices-ultra_smb     | 31 +++++++
 .../trace/coresight/ultrasoc-smb.rst          | 82 +++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
 create mode 100644 Documentation/trace/coresight/ultrasoc-smb.rst

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
new file mode 100644
index 000000000000..deaefd508105
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
@@ -0,0 +1,31 @@
+What:		/sys/bus/coresight/devices/ultra_smb<N>/enable_sink
+Date:		November 2022
+KernelVersion:	6.2
+Contact:	Junhao He <hejunhao3@huawei.com>
+Description:	(RW) Add/remove a SMB device from a trace path. There can be
+		multiple sources for a single SMB device.
+
+What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/buf_size
+Date:		November 2022
+KernelVersion:	6.2
+Contact:	Junhao He <hejunhao3@huawei.com>
+Description:	(Read) Shows the buffer size of each UltraSoc SMB device.
+
+What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/buf_status
+Date:		November 2022
+KernelVersion:	6.2
+Contact:	Junhao He <hejunhao3@huawei.com>
+Description:	(Read) Shows the value held by UltraSoc SMB status register.
+		BIT(0) is zero means buffer is empty.
+
+What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/read_pos
+Date:		November 2022
+KernelVersion:	6.2
+Contact:	Junhao He <hejunhao3@huawei.com>
+Description:	(Read) Shows the value held by UltraSoc SMB Read Pointer register.
+
+What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/write_pos
+Date:		November 2022
+KernelVersion:	6.2
+Contact:	Junhao He <hejunhao3@huawei.com>
+Description:	(Read) Shows the value held by UltraSoc SMB Write Pointer register.
diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentation/trace/coresight/ultrasoc-smb.rst
new file mode 100644
index 000000000000..b7fe3f5c7f53
--- /dev/null
+++ b/Documentation/trace/coresight/ultrasoc-smb.rst
@@ -0,0 +1,82 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+UltraSoc - HW Assisted Tracing on SoC
+======================================
+   :Author:   Qi Liu <liuqi115@huawei.com>
+   :Date:     March 2022
+
+Introduction
+------------
+
+UltraSoc SMB is a per SCCL(Super CPU Cluster) hardware, and it provides a
+way to buffer and store CPU trace messages in a region of shared system
+memory. SMB is plugged as a coresight sink device and the corresponding
+trace generators (ETM) are plugged in as source devices.
+
+Sysfs files and directories
+---------------------------
+
+The SMB devices appear on the existing coresight bus alongside the other
+coresight devices::
+
+	$# ls /sys/bus/coresight/devices/
+	ultra_smb0   ultra_smb1   ultra_smb2   ultra_smb3
+
+The ``ultra_smb<N>`` named SMB associated with SCCL.::
+
+	$# ls /sys/bus/coresight/devices/ultra_smb0
+	enable_sink   mgmt
+	$# ls /sys/bus/coresight/devices/ultra_smb0/mgmt
+	buf_size  buf_status  read_pos  write_pos
+
+*Key file items are:-*
+   * ``read_pos``: Shows the value held by UltraSoc SMB Read Pointer register.
+   * ``write_pos``: Shows the value held by UltraSoc SMB Write Pointer register.
+   * ``buf_status``: Shows the value held by UltraSoc SMB status register.
+		     BIT(0) is zero means buffer is empty.
+   * ``buf_size``: Shows the buffer size of each UltraSoc SMB device.
+
+Firmware Bindings
+---------------------------
+
+SMB device is only supported with ACPI, and ACPI binding of SMB device
+describes SMB device indentifier, resource information and graph structure.
+
+SMB is identified by ACPI HID "HISI03A1", resource of device is declared using
+the _CRS method. Each SMB must present two base address, the first one is the
+configuration base address of SMB device, the second one is the 32bits base
+address of shared system memory.
+
+examples::
+
+    Device(USMB) {                                               \
+      Name(_HID, "HISI03A1")                                     \
+      Name(_CRS, ResourceTemplate() {                            \
+          QWordMemory (ResourceConsumer, , MinFixed, MaxFixed, NonCacheable, \
+		       ReadWrite, 0x0, 0x95100000, 0x951FFFFF, 0x0, 0x100000) \
+          QWordMemory (ResourceConsumer, , MinFixed, MaxFixed, Cacheable, \
+		       ReadWrite, 0x0, 0x50000000, 0x53FFFFFF, 0x0, 0x4000000) \
+      })                                                         \
+      Name(_DSD, Package() {                                     \
+        ToUUID("ab02a46b-74c7-45a2-bd68-f7d344ef2153"),          \
+	/* Use CoreSight Graph ACPI bindings to describe connections topology */
+        Package() {                                              \
+          0,                                                     \
+          1,                                                     \
+          Package() {                                            \
+            1,                                                   \
+            ToUUID("3ecbc8b6-1d0e-4fb3-8107-e627f805c6cd"),      \
+            8,                                                   \
+            Package() {0x8, 0, \_SB.S00.SL11.CL28.F008, 0},       \
+            Package() {0x9, 0, \_SB.S00.SL11.CL29.F009, 0},       \
+            Package() {0xa, 0, \_SB.S00.SL11.CL2A.F010, 0},       \
+            Package() {0xb, 0, \_SB.S00.SL11.CL2B.F011, 0},       \
+            Package() {0xc, 0, \_SB.S00.SL11.CL2C.F012, 0},       \
+            Package() {0xd, 0, \_SB.S00.SL11.CL2D.F013, 0},       \
+            Package() {0xe, 0, \_SB.S00.SL11.CL2E.F014, 0},       \
+            Package() {0xf, 0, \_SB.S00.SL11.CL2F.F015, 0},       \
+          }                                                      \
+        }                                                        \
+      })                                                         \
+    }
-- 
2.33.0

