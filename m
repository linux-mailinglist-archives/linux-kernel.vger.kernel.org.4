Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2DC6DB956
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDHHpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDHHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:45:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E280D323
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 00:45:17 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PtnL33wYnzrZSJ;
        Sat,  8 Apr 2023 15:43:55 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 8 Apr
 2023 15:45:14 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v10 4/5] Documentation: add debugfs description for vfio
Date:   Sat, 8 Apr 2023 15:42:23 +0800
Message-ID: <20230408074224.62608-5-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20230408074224.62608-1-liulongfang@huawei.com>
References: <20230408074224.62608-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add two debugfs document description file to help users understand
how to use the accelerator live migration driver's debugfs.
2.Update the file paths that need to be maintained in MAINTAINERS

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../ABI/testing/debugfs-hisi-migration        | 39 +++++++++++++++++++
 Documentation/ABI/testing/debugfs-vfio        | 25 ++++++++++++
 MAINTAINERS                                   |  2 +
 3 files changed, 66 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
 create mode 100644 Documentation/ABI/testing/debugfs-vfio

diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
new file mode 100644
index 000000000000..e67478685ed0
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-hisi-migration
@@ -0,0 +1,39 @@
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/data
+Date:		April 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Read the live migration data of the vfio device.
+		The output format of the data is defined by the live
+		migration driver.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/attr
+Date:		April 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Read the live migration attributes of the vfio device.
+		The output format of the attributes is defined by the live
+		migration driver.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/io_test
+Date:		April 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Trigger the HiSilicon accelerator device to perform
+		the io test through the read operation, and directly output
+		the test result.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/save
+Date:		April 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Trigger the Hisilicon accelerator device to perform
+		the state saving operation of live migration through the read
+		operation, and directly output the operation result.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/restore
+Date:		April 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Trigger the Hisilicon accelerator device to perform
+		the state restoration operation of live migration through
+		the read operation, and directly output the operation result.
\ No newline at end of file
diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
new file mode 100644
index 000000000000..85d2b676cb87
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-vfio
@@ -0,0 +1,25 @@
+What:		/sys/kernel/debug/vfio
+Date:		April 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	This debugfs file directory is used for debugging
+		of vfio devices.
+		Each device can create a device subdirectory under this
+		directory by referencing the public registration interface.
+
+What:		/sys/kernel/debug/vfio/<device>/migration
+Date:		April 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	This debugfs file directory is used for debugging
+		of vfio devices that support live migration.
+		The debugfs of each vfio device that supports live migration
+		could be created under this directory.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/state
+Date:		April 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Read the live migration status of the vfio device.
+		The status of these live migrations includes:
+		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.
diff --git a/MAINTAINERS b/MAINTAINERS
index 61d3d019cfc7..147c597c9239 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21860,6 +21860,7 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 T:	git https://github.com/awilliam/linux-vfio.git
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
+F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/driver-api/vfio.rst
 F:	drivers/vfio/
 F:	include/linux/vfio.h
@@ -21877,6 +21878,7 @@ M:	Longfang Liu <liulongfang@huawei.com>
 M:	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/debugfs-hisi-migration
 F:	drivers/vfio/pci/hisilicon/
 
 VFIO MEDIATED DEVICE DRIVERS
-- 
2.24.0

