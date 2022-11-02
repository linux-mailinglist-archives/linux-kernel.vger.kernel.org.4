Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207626168FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiKBQbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiKBQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:30 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ABB2DAA7;
        Wed,  2 Nov 2022 09:27:08 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id E88B741D21;
        Wed,  2 Nov 2022 11:52:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1667404339;
        bh=IfOElk0hNoFig8+azSf08eGqMsXWLWYLHgqPaZFWgoA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=wq4O7AN/NkuX8r4iqdxZagOVoxItk+b5xatQLzV2Ht6aS8wQkXTOI1A1H4tKGLhL8
         GV+4lagHFveJxlM7S5/VpxmopADJDMI+VvEenMn3O26yFNq+W1Pks1LroK4S8Wno10
         M1YkeVkUGdf/OvFXGd/BVgKcTs/FmAWYJTXop8K07Nnk26N6WHAogswnCvbn9ITQ9H
         TIHPMOUhk7mEPXjrOqzcdvtSi0e7YC/iSs7vVVUceww/OSrTYjHZ63j0E9hf7Tuj/r
         iOctczQ5YPh2RCFXfAqu/0S6EJfvZgGvkk++NDKStOVVEgeHIoey+JT5xvuvWj5lUo
         FoH1EpQpRhDLw==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 2 Nov 2022 16:51:40 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v1 16/17] block, blksnap: Kconfig and Makefile
Date:   Wed, 2 Nov 2022 16:51:00 +0100
Message-ID: <20221102155101.4550-17-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221102155101.4550-1-sergei.shtepa@veeam.com>
References: <20221102155101.4550-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155666726A
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to build a module.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/Kconfig  | 12 ++++++++++++
 drivers/block/blksnap/Makefile | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 drivers/block/blksnap/Kconfig
 create mode 100644 drivers/block/blksnap/Makefile

diff --git a/drivers/block/blksnap/Kconfig b/drivers/block/blksnap/Kconfig
new file mode 100644
index 000000000000..3a6ecb5fc13d
--- /dev/null
+++ b/drivers/block/blksnap/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Block device snapshot module configuration
+#
+
+config BLK_SNAP
+	tristate "Module for snapshots of block devices."
+	help
+	  Allow to create snapshots and track block changes for block devices.
+	  Designed for creating backups for a simple block devices. Snapshots
+	  are temporary and are released then backup is completed. Change block
+	  tracking allows to create incremental or differential backups.
diff --git a/drivers/block/blksnap/Makefile b/drivers/block/blksnap/Makefile
new file mode 100644
index 000000000000..b196b17f9d9d
--- /dev/null
+++ b/drivers/block/blksnap/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+blksnap-y := 		\
+	cbt_map.o	\
+	chunk.o		\
+	ctrl.o		\
+	diff_io.o	\
+	diff_area.o	\
+	diff_buffer.o	\
+	diff_storage.o	\
+	event_queue.o	\
+	main.o		\
+	snapimage.o	\
+	snapshot.o	\
+	sysfs.o		\
+	tracker.o
+
+obj-$(CONFIG_BLK_SNAP)	 += blksnap.o
-- 
2.20.1

