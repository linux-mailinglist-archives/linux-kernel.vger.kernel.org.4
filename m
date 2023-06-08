Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271967279DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjFHIXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjFHIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:23:19 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3992EE43
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:23:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkdXoEh_1686212593;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VkdXoEh_1686212593)
          by smtp.aliyun-inc.com;
          Thu, 08 Jun 2023 16:23:14 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] kernel: Remove duplicated include in posix-stubs.c
Date:   Thu,  8 Jun 2023 16:23:12 +0800
Message-Id: <20230608082312.123939-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./kernel/time/posix-stubs.c: linux/syscalls.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5463
Fixes: c1956519cd7e ("syscalls: add sys_ni_posix_timers prototype")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/time/posix-stubs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 39769b2d1005..828aeecbd1e8 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -16,7 +16,6 @@
 #include <linux/posix-timers.h>
 #include <linux/time_namespace.h>
 #include <linux/compat.h>
-#include <linux/syscalls.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 /* Architectures may override SYS_NI and COMPAT_SYS_NI */
-- 
2.20.1.7.g153144c

