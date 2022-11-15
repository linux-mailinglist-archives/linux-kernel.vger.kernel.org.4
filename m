Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99883628EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiKOBNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKOBNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:13:00 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86482FAC6;
        Mon, 14 Nov 2022 17:12:58 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NB7TN3Gkrz1DDK;
        Tue, 15 Nov 2022 09:12:56 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4NB7TJ38wbz4xD2y;
        Tue, 15 Nov 2022 09:12:52 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4NB7TF08q7zdmc16;
        Tue, 15 Nov 2022 09:12:49 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NB7T95QW7z8RV7D;
        Tue, 15 Nov 2022 09:12:45 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AF1CAIh093991;
        Tue, 15 Nov 2022 09:12:40 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Tue, 15 Nov 2022 09:12:08 +0800 (CST)
Date:   Tue, 15 Nov 2022 09:12:08 +0800 (CST)
X-Zmail-TransId: 2afb6372e7687810efd4
X-Mailer: Zmail v1.0
Message-ID: <202211150912088591872@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <ngupta@vflare.org>
Cc:     <senozhatsky@chromium.org>, <minchan@kernel.org>,
        <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <guo.ziliang@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHpyYW06IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AF1CAIh093991
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 6372E797.000 by FangMail milter!
X-FangMail-Envelope: 1668474776/4NB7TN3Gkrz1DDK/6372E797.000/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6372E797.000/4NB7TN3Gkrz1DDK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guo ziliang <guo.ziliang@zte.com.cn>
Replace the open-code with sysfs_emit() to simplify the code.)

Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
---
 drivers/block/zram/zram_drv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 171eccc..a0399ee 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -255,7 +255,7 @@ static ssize_t initstate_show(struct device *dev,
        val = init_done(zram);
        up_read(&zram->init_lock);

-       return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+       return sysfs_emit(buf, "%u\n", val);
 }

 static ssize_t disksize_show(struct device *dev,
@@ -263,7 +263,7 @@ static ssize_t disksize_show(struct device *dev,
 {
        struct zram *zram = dev_to_zram(dev);

-       return scnprintf(buf, PAGE_SIZE, "%llu\n", zram->disksize);
+       return sysfs_emit(buf, "%llu\n", zram->disksize);
 }

 static ssize_t mem_limit_store(struct device *dev,
@@ -404,7 +404,7 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
        spin_unlock(&zram->wb_limit_lock);
        up_read(&zram->init_lock);

-       return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+       return sysfs_emit(buf, "%d\n", val);
 }

 static ssize_t writeback_limit_store(struct device *dev,
@@ -439,7 +439,7 @@ static ssize_t writeback_limit_show(struct device *dev,
        spin_unlock(&zram->wb_limit_lock);
        up_read(&zram->init_lock);

-       return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+       return sysfs_emit(buf, "%llu\n", val);
 }

 static void reset_bdev(struct zram *zram)
@@ -1021,6 +1021,7 @@ static ssize_t max_comp_streams_show(struct device *dev,
                struct device_attribute *attr, char *buf)
 {
        return scnprintf(buf, PAGE_SIZE, "%d\n", num_online_cpus());
+       return sysfs_emit(buf, "%d\n", num_online_cpus());
 }

 static ssize_t max_comp_streams_store(struct device *dev,
@@ -2504,7 +2505,7 @@ static ssize_t hot_add_show(struct class *class,

        if (ret < 0)
                return ret;
-       return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+       return sysfs_emit(buf, "%d\n", ret);
 }
 static struct class_attribute class_attr_hot_add =
        __ATTR(hot_add, 0400, hot_add_show, NULL);
--
1.8.3.1
