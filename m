Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C17682462
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjAaGTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAaGTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:19:40 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB307C64F;
        Mon, 30 Jan 2023 22:19:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaVQrZk_1675145976;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VaVQrZk_1675145976)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 14:19:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] tracing: clean up some inconsistent indentings
Date:   Tue, 31 Jan 2023 14:19:35 +0800
Message-Id: <20230131061935.53453-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/trace/trace_events_synth.c:567 trace_event_raw_event_synth() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3892
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/trace/trace_events_synth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index adb630633f31..949d4cbe3f82 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -564,7 +564,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
 					   event->fields[i]->is_dynamic,
 					   data_size, &n_u64);
 			data_size += len; /* only dynamic string increments */
-		} if (event->fields[i]->is_stack) {
+		}
+		if (event->fields[i]->is_stack) {
 		        long *stack = (long *)(long)var_ref_vals[val_idx];
 
 			len = trace_stack(entry, event, stack,
-- 
2.20.1.7.g153144c

