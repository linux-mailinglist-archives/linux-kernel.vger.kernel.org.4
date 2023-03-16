Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A016BC94F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjCPIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCPIjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:39:22 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3253B7A91A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1678955959; i=@fujitsu.com;
        bh=oZtuWDGunY1ClYYaSiGU19IL3y8YDGQY4nCM0guUtHE=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=C0rmfDS6aGBmoL5j6AikQ4WaKRWM+v+KdMNOcaEGaQ92wFy+0Ug0qBF6LY1R2Pja2
         8n27uzANX5fnqAYoyj3ybH3ZvOti4MnLxtB47gV/NimY+qbsNeTHyxApaIDwzsEHl+
         M24bcL5uO2Jz0sZUpGfD/4Ta3KIJjlIGJx9x0tO3CwaXFOw7dZXMijb93d3l0ph3AL
         f0wOjF72Dtomq9FtbBTlDCgr6CXcsroeMgjE4tzwwqWgJtg4n9gisbdTWh0s+Rnp+Q
         0AcDcBQJOZEM2b720KcHjJfvsGxbphVYa4QviLkk9kCslfSihaC6oYwZq859Lu0r2u
         iqsMtkgKQhOTw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRWlGSWpSXmKPExsViZ8ORpLvtqlC
  Kwb6FshbTp15gtDhxs5HNYv/T5ywWl3fNYbNY+eMPq8WtCceYHNg8Fu95yeTxYvNMRo/Pm+QC
  mKNYM/OS8isSWDNWrV7LWNAkVDFh0gvGBsaT/F2MXBxCAhsZJa6uPMoM4Sxhkpi28CAbhHOAU
  aL3yS0gh5ODTUBD4l7LTUaQhIhAC6PEmanNrCAJZgE3iU1vZrOD2MICkRKT2zcyg9gsAqoSK+
  8vZQSxeQUcJZ5uOAcWlxBQkJjy8D0zRFxQ4uTMJywQcyQkDr54ARTnAKpRkpjZHQ9RXiHROP0
  QE4StJnH13CbmCYz8s5B0z0LSvYCRaRWjWXFqUVlqka6RgV5SUWZ6RkluYmaOXmKVbqJeaqlu
  eWpxia6hXmJ5sV5qcbFecWVuck6KXl5qySZGYEinFDPu3cE4ue+v3iFGSQ4mJVHeP2sEUoT4k
  vJTKjMSizPii0pzUosPMcpwcChJ8E66JJQiJFiUmp5akZaZA4wvmLQEB4+SCO+Es0Bp3uKCxN
  zizHSI1ClGRSlx3r4rQAkBkERGaR5cGyymLzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5k0
  BmcKTmVcCN/0V0GImoMW88wRAFpckIqSkGpi2OotYdm00qHJ9N73hpUXpkYqdbbP9bym/juOJ
  meVbqFHebDJ1bViW7udK9tp5LybGNW1+euh/XqQDj5PYIza35wbpC6ezxZof+OVgPve+lavHd
  9eiCPk5urLNB7aZ5m2on94/+2NOZ4/OL65vV4W0tI8zHqh5KKbfbsbHlZlf8IGTW6d49c8Taa
  zCr1Yu6fbNdBKY/u/cZIMHO7yfCJ2fu2HJ8j2r+2a85RXLZ9Uu+7x6he/SEq3ALskjdsUFZ8O
  qrj99faJMb4O/2DWfXK9Hop8faTQJPKwIbP4+8f3DrC0zFD1MdbTaV7L4+LUbSO0VV07Ufj99
  67KdZzRiVumyR/15fabZ//BUm9klR5RYijMSDbWYi4oTAR22xDJkAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-13.tower-587.messagelabs.com!1678955958!201468!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10356 invoked from network); 16 Mar 2023 08:39:18 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-13.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Mar 2023 08:39:18 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 147131AD;
        Thu, 16 Mar 2023 08:39:18 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 0937E1AC;
        Thu, 16 Mar 2023 08:39:18 +0000 (GMT)
Received: from 79ee2ba95dc2.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 16 Mar 2023 08:39:15 +0000
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <nvdimm@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the unregistered bus
Date:   Thu, 16 Mar 2023 08:38:51 +0000
Message-ID: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvdimm_bus_register() could be called from other modules, such as nfit,
but it can only be called after the nvdimm_bus_type is registered.

 BUG: kernel NULL pointer dereference, address: 0000000000000098
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 0 PID: 117 Comm: systemd-udevd Not tainted 6.2.0-rc6-pmem+ #97
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 RIP: 0010:bus_add_device+0x58/0x150
 Call Trace:
  <TASK>
  device_add+0x3ac/0x980
  nvdimm_bus_register+0x16d/0x1d0
  acpi_nfit_init+0xb72/0x1f90 [nfit]
  acpi_nfit_add+0x1d5/0x200 [nfit]
  acpi_device_probe+0x45/0x160
  really_probe+0xce/0x390
  __driver_probe_device+0x78/0x180
  driver_probe_device+0x1e/0x90
  __driver_attach+0xd6/0x1d0
  bus_for_each_dev+0x7b/0xc0
  bus_add_driver+0x1ac/0x200
  driver_register+0x8f/0xf0
  nfit_init+0x164/0xff0 [nfit]
  do_one_initcall+0x5b/0x320
  do_init_module+0x4c/0x1f0
  __do_sys_finit_module+0xb4/0x130
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/nvdimm/bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index ada61bbf49c1..ea66053072cb 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -28,6 +28,7 @@
 static int nvdimm_bus_major;
 struct class *nd_class;
 static DEFINE_IDA(nd_ida);
+static bool nvdimm_bus_type_registered;
 
 static int to_nd_device_type(struct device *dev)
 {
@@ -337,6 +338,10 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	struct nvdimm_bus *nvdimm_bus;
 	int rc;
 
+	if (!nvdimm_bus_type_registered) {
+		pr_warn("nvdimm bus type is not registered\n");
+		return NULL;
+	}
 	nvdimm_bus = kzalloc(sizeof(*nvdimm_bus), GFP_KERNEL);
 	if (!nvdimm_bus)
 		return NULL;
@@ -1321,6 +1326,7 @@ int __init nvdimm_bus_init(void)
 	if (rc)
 		goto err_nd_bus;
 
+	nvdimm_bus_type_registered = true;
 	return 0;
 
  err_nd_bus:
@@ -1343,4 +1349,5 @@ void nvdimm_bus_exit(void)
 	unregister_chrdev(nvdimm_major, "dimmctl");
 	bus_unregister(&nvdimm_bus_type);
 	ida_destroy(&nd_ida);
+	nvdimm_bus_type_registered = false;
 }
-- 
1.8.3.1

