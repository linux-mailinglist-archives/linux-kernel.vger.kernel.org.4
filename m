Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832C663A005
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiK1DPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK1DPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:15:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6EAFD39
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:15:07 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NL9YY5P4MzHw6j;
        Mon, 28 Nov 2022 11:14:25 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 11:15:06 +0800
Received: from huawei.com (10.67.164.66) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 11:15:05 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <john.garry@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v3 4/5] Documentation: add debugfs description for hisi_acc_vfio_pci
Date:   Mon, 28 Nov 2022 11:11:59 +0800
Message-ID: <20221128031200.11017-5-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20221128031200.11017-1-liulongfang@huawei.com>
References: <20221128031200.11017-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs document description file to help users understand
how to use the accelerator live migration driver's debugfs.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../ABI/testing/debugfs-hisi-migration        | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration

diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
new file mode 100644
index 000000000000..a8cfc7688b88
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-hisi-migration
@@ -0,0 +1,32 @@
+What:		/sys/kernel/debug/vfio_mig/<bdf>/state
+Date:		Nov 2022
+Contact:	linux-kernel@vger.kernel.org
+Description:	Read the live migration status of the VF device.
+		The status of these live migrations includes:
+		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.
+
+What:		/sys/kernel/debug/vfio_mig/<bdf>/mig_data
+Date:		Nov 2022
+Contact:	linux-kernel@vger.kernel.org
+Description:	Read the live migration data of the VF device.
+		The output format of the data is defined by the live
+		migration driver.
+
+What:		/sys/kernel/debug/vfio_mig/<bdf>/mig_attr
+Date:		Nov 2022
+Contact:	linux-kernel@vger.kernel.org
+Description:	Read the live migration attributes of the VF device.
+		The output format of the attributes is defined by the live
+		migration driver.
+
+What:		/sys/kernel/debug/vfio_mig/<bdf>/debug
+Date:		Nov 2022
+Contact:	linux-kernel@vger.kernel.org
+Description:	This debug file supports "echo" command	write operations.
+		The command is actually represented by an integer number, and the
+		specific meaning is defined by the corresponding device driver.
+		For example, three commands are defined in the HiSilicon accelerator
+		live migration driver:
+		0: State save
+		1: State resume
+		2: IO test
-- 
2.24.0

