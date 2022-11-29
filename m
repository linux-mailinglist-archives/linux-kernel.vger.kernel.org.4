Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA17263BF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiK2LcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiK2LcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:32:10 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A33C6C8;
        Tue, 29 Nov 2022 03:32:07 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NM0YK4FHGz8QrkZ;
        Tue, 29 Nov 2022 19:32:05 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2ATBVuFj039380;
        Tue, 29 Nov 2022 19:31:56 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 29 Nov 2022 19:31:59 +0800 (CST)
Date:   Tue, 29 Nov 2022 19:31:59 +0800 (CST)
X-Zmail-TransId: 2af96385edaf49f0a0d5
X-Mailer: Zmail v1.0
Message-ID: <202211291931593806484@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <rafael@kernel.org>
Cc:     <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBBQ1BJOiBQQUQ6IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2ATBVuFj039380
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6385EDB5.000 by FangMail milter!
X-FangMail-Envelope: 1669721525/4NM0YK4FHGz8QrkZ/6385EDB5.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6385EDB5.000/4NM0YK4FHGz8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/acpi/acpi_pad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index edbb28faee2a..02f1a1b1143c 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -287,7 +287,7 @@ static ssize_t rrtime_store(struct device *dev,
 static ssize_t rrtime_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", round_robin_time);
+	return sysfs_emit(buf, "%d\n", round_robin_time);
 }
 static DEVICE_ATTR_RW(rrtime);

@@ -309,7 +309,7 @@ static ssize_t idlepct_store(struct device *dev,
 static ssize_t idlepct_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", idle_pct);
+	return sysfs_emit(buf, "%d\n", idle_pct);
 }
 static DEVICE_ATTR_RW(idlepct);

-- 
2.25.1
