Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B3A5B4B6E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 05:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiIKDZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 23:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIKDZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 23:25:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6182B252
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 20:25:45 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MQFPM0V4PzNm8p;
        Sun, 11 Sep 2022 11:21:11 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 11 Sep 2022 11:25:43 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <arjan@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] backtrace-test: add __init/__exit annotations to module init/exit funcs
Date:   Sun, 11 Sep 2022 11:22:15 +0800
Message-ID: <20220911032215.111211-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/backtracetest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/backtracetest.c b/kernel/backtracetest.c
index 370217dd7e39..c90b55cc4a07 100644
--- a/kernel/backtracetest.c
+++ b/kernel/backtracetest.c
@@ -60,7 +60,7 @@ static void backtrace_test_saved(void)
 }
 #endif
 
-static int backtrace_regression_test(void)
+static int __init backtrace_regression_test(void)
 {
 	pr_info("====[ backtrace testing ]===========\n");
 
@@ -72,7 +72,7 @@ static int backtrace_regression_test(void)
 	return 0;
 }
 
-static void exitf(void)
+static void __exit exitf(void)
 {
 }
 
-- 
2.17.1

