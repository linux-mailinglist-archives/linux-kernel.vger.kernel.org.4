Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45A6484CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiLIPOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLIPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:14:05 -0500
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC48B23;
        Fri,  9 Dec 2022 07:14:00 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 94E2E40C50;
        Fri,  9 Dec 2022 09:24:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1670595868;
        bh=AkujCOqlCBh/Wqo+C89qWbHonovtZeEVLzoTUTs+GFg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=V5H844dlyLdvpaePF5wQp/OAbvZ+/Mm5Shj6thMOrlWZU/J8fV1Dqmn+tiFVeANEr
         Pqv3gorB1VrVmDmkyx9nLI9o8iWAHA6KwUJeA9YsrwGJK1WXDpVTf2muU38h6qfB9p
         KDWkZPE4q2MDxn+PPtxxPAYEV+4GK3q6cfXqCH7z0zHsz9LFX3rK77/SX4gNnhixoe
         /Q7Jfn8KP4u6XrUSzCjZe4r0+dcIq+QOk52mfnTODm2VOyS5JgIKhHMOdjzq9qfRP7
         ShPqsBO7tyP2Q/0mbfaraKK8w5Y//7ka4ZSJcfcTWcv6hgMDgfm9oRLCCJi5Vlu1QX
         HcJ05nhEYPwRQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:24:23 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 19/21] block, blksnap: Kconfig and Makefile
Date:   Fri, 9 Dec 2022 15:23:29 +0100
Message-ID: <20221209142331.26395-20-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209142331.26395-1-sergei.shtepa@veeam.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031556627C62
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..2f726fd3295a
--- /dev/null
+++ b/drivers/block/blksnap/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Block device snapshot module configuration
+#
+
+config BLK_SNAP
+	tristate "Block Devices Snapshots Module (blksnap)"
+	help
+	  Allow to create snapshots and track block changes for block devices.
+	  Designed for creating backups for simple block devices. Snapshots are
+	  temporary and are released then backup is completed. Change block
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

