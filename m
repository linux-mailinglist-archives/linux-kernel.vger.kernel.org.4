Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F585B4B69
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 05:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIKDHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 23:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIKDHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 23:07:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094F356FB
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 20:07:48 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MQF1N5DrGzlVj5;
        Sun, 11 Sep 2022 11:03:52 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 11 Sep 2022 11:07:46 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <bristot@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] rv/monitor: add __init/__exit annotations to module init/exit funcs
Date:   Sun, 11 Sep 2022 11:04:17 +0800
Message-ID: <20220911030418.94609-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs.

Fixes: 8812d21219b9 ("rv/monitor: Add the wip monitor skeleton created by dot2k")
Fixes: ccc319dcb450 ("rv/monitor: Add the wwnr monitor")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/trace/rv/monitors/wip/wip.c   | 4 ++--
 kernel/trace/rv/monitors/wwnr/wwnr.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index 83cace53b9fa..6be876e2f405 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -69,13 +69,13 @@ struct rv_monitor rv_wip = {
 	.enabled = 0,
 };
 
-static int register_wip(void)
+static int __init register_wip(void)
 {
 	rv_register_monitor(&rv_wip);
 	return 0;
 }
 
-static void unregister_wip(void)
+static void __exit unregister_wip(void)
 {
 	rv_unregister_monitor(&rv_wip);
 }
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 599225d9cf38..c1fac4808b02 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -68,13 +68,13 @@ struct rv_monitor rv_wwnr = {
 	.enabled = 0,
 };
 
-static int register_wwnr(void)
+static int __init register_wwnr(void)
 {
 	rv_register_monitor(&rv_wwnr);
 	return 0;
 }
 
-static void unregister_wwnr(void)
+static void __exit unregister_wwnr(void)
 {
 	rv_unregister_monitor(&rv_wwnr);
 }
-- 
2.17.1

