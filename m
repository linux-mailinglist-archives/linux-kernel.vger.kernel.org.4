Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713665EC1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiI0Lz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiI0LzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:55:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A432E564D7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:55:20 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McHyV2yfWzWgsp;
        Tue, 27 Sep 2022 19:51:14 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 19:55:18 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paulmck@kernel.org>, <frederic@kernel.org>, <nsaenzju@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpu_pm: Add __init annotation to cpu_pm_init()
Date:   Tue, 27 Sep 2022 19:51:34 +0800
Message-ID: <20220927115134.209490-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a core_initcall entry, add __init annotation to it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index ba4ba71facf9..57d32d73b429 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -205,7 +205,7 @@ static struct syscore_ops cpu_pm_syscore_ops = {
 	.resume = cpu_pm_resume,
 };
 
-static int cpu_pm_init(void)
+static int __init cpu_pm_init(void)
 {
 	register_syscore_ops(&cpu_pm_syscore_ops);
 	return 0;
-- 
2.17.1

