Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA035E86D6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiIXA4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIXAz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:55:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0661011E95E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:55:57 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZ9VS3YKJzpTsG;
        Sat, 24 Sep 2022 08:53:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 08:55:56 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <jk@ozlabs.org>, <joel@jms.id.au>, <alistair@popple.id.au>,
        <eajames@linux.ibm.com>
CC:     <linux-fsi@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fsi: Add __init/__exit annotations to module init/exit funcs
Date:   Sat, 24 Sep 2022 08:52:14 +0800
Message-ID: <20220924005214.186304-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/fsi/fsi-occ.c     | 4 ++--
 drivers/fsi/fsi-sbefifo.c | 4 ++--
 drivers/fsi/fsi-scom.c    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 8f7f602b909d..69273575f61f 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -719,12 +719,12 @@ static struct platform_driver occ_driver = {
 	.remove = occ_remove,
 };
 
-static int occ_init(void)
+static int __init occ_init(void)
 {
 	return platform_driver_register(&occ_driver);
 }
 
-static void occ_exit(void)
+static void __exit occ_exit(void)
 {
 	platform_driver_unregister(&occ_driver);
 
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 5f93a53846aa..bf313689012a 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -1124,12 +1124,12 @@ static struct fsi_driver sbefifo_drv = {
 	}
 };
 
-static int sbefifo_init(void)
+static int __init sbefifo_init(void)
 {
 	return fsi_driver_register(&sbefifo_drv);
 }
 
-static void sbefifo_exit(void)
+static void __exit sbefifo_exit(void)
 {
 	fsi_driver_unregister(&sbefifo_drv);
 }
diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index bcb756dc9866..10f071255a85 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -605,12 +605,12 @@ static struct fsi_driver scom_drv = {
 	}
 };
 
-static int scom_init(void)
+static int __init scom_init(void)
 {
 	return fsi_driver_register(&scom_drv);
 }
 
-static void scom_exit(void)
+static void __exit scom_exit(void)
 {
 	fsi_driver_unregister(&scom_drv);
 }
-- 
2.17.1

