Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381DA5B4CAE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiIKIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIKIqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:46:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80283135F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:46:13 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MQNX564KTzmV74;
        Sun, 11 Sep 2022 16:42:29 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 11 Sep 2022 16:46:10 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <willy@infradead.org>,
        <zuoqilin@yulong.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc: pseries: add __init/__exit annotations to module init/exit funcs
Date:   Sun, 11 Sep 2022 16:42:41 +0800
Message-ID: <20220911084241.196091-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 arch/powerpc/platforms/pseries/cmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 5f4037c1d7fe..3c56c5cb0fa9 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -565,7 +565,7 @@ static void cmm_balloon_compaction_init(void)
  * Return value:
  * 	0 on success / other on failure
  **/
-static int cmm_init(void)
+static int __init cmm_init(void)
 {
 	int rc;
 
@@ -615,7 +615,7 @@ static int cmm_init(void)
  * Return value:
  * 	nothing
  **/
-static void cmm_exit(void)
+static void __exit cmm_exit(void)
 {
 	if (cmm_thread_ptr)
 		kthread_stop(cmm_thread_ptr);
-- 
2.17.1

