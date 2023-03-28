Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A0B6CB7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjC1H0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjC1H0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:26:09 -0400
Received: from out0-194.mail.aliyun.com (out0-194.mail.aliyun.com [140.205.0.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233012D64;
        Tue, 28 Mar 2023 00:26:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=yanyan.yan@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.S0hatNe_1679988361;
Received: from localhost(mailfrom:yanyan.yan@antgroup.com fp:SMTPD_---.S0hatNe_1679988361)
          by smtp.aliyun-inc.com;
          Tue, 28 Mar 2023 15:26:01 +0800
From:   "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>,
        "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>
Subject: [PATCH] Documentation: update kernel stack for x86_64
Date:   Tue, 28 Mar 2023 15:25:37 +0800
Message-Id: <20230328072537.20188-1-yanyan.yan@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6538b8ea886e ("x86_64: expand kernel stack to 16K")
expanded kernel stack for x86_64 but left the wrong documentation,
update it.

Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
---
 Documentation/x86/kernel-stacks.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/kernel-stacks.rst b/Documentation/x86/kernel-stacks.rst
index 6b0bcf027ff1..738671a4070b 100644
--- a/Documentation/x86/kernel-stacks.rst
+++ b/Documentation/x86/kernel-stacks.rst
@@ -12,7 +12,7 @@ Most of the text from Keith Owens, hacked by AK
 x86_64 page size (PAGE_SIZE) is 4K.
 
 Like all other architectures, x86_64 has a kernel stack for every
-active thread.  These thread stacks are THREAD_SIZE (2*PAGE_SIZE) big.
+active thread.  These thread stacks are THREAD_SIZE (4*PAGE_SIZE) big.
 These stacks contain useful data as long as a thread is alive or a
 zombie. While the thread is in user space the kernel stack is empty
 except for the thread_info structure at the bottom.
-- 
2.32.0.3.g01195cf9f

