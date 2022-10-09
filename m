Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92515F88CD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJICOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJICOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:14:39 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B16B79
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:14:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VRgG7Hn_1665281594;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VRgG7Hn_1665281594)
          by smtp.aliyun-inc.com;
          Sun, 09 Oct 2022 10:14:35 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] ring-buffer: Fix kernel-doc
Date:   Sun,  9 Oct 2022 10:06:42 +0800
Message-Id: <20221009020642.12506-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/trace/ring_buffer.c:895: warning: expecting prototype for ring_buffer_nr_pages_dirty(). Prototype was for ring_buffer_nr_dirty_pages() instead.
kernel/trace/ring_buffer.c:5313: warning: expecting prototype for ring_buffer_reset_cpu(). Prototype was for ring_buffer_reset_online_cpus() instead.
kernel/trace/ring_buffer.c:5382: warning: expecting prototype for rind_buffer_empty(). Prototype was for ring_buffer_empty() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2340
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Get rid of the parenthesis.

 kernel/trace/ring_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c3f354cfc5ba..199759c73519 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -885,7 +885,7 @@ size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu)
 }
 
 /**
- * ring_buffer_nr_pages_dirty - get the number of used pages in the ring buffer
+ * ring_buffer_nr_dirty_pages - get the number of used pages in the ring buffer
  * @buffer: The ring_buffer to get the number of pages from
  * @cpu: The cpu of the ring_buffer to get the number of pages from
  *
@@ -5305,7 +5305,7 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 
 /**
- * ring_buffer_reset_cpu - reset a ring buffer per CPU buffer
+ * ring_buffer_reset_online_cpus - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
  * @cpu: The CPU buffer to be reset
  */
@@ -5375,7 +5375,7 @@ void ring_buffer_reset(struct trace_buffer *buffer)
 EXPORT_SYMBOL_GPL(ring_buffer_reset);
 
 /**
- * rind_buffer_empty - is the ring buffer empty?
+ * ring_buffer_empty - is the ring buffer empty?
  * @buffer: The ring buffer to test
  */
 bool ring_buffer_empty(struct trace_buffer *buffer)
-- 
2.20.1.7.g153144c

