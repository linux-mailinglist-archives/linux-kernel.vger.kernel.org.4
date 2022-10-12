Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E85FCE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJLWEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJLWDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:03:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAE910B743
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0AF56149B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDEBC43140;
        Wed, 12 Oct 2022 22:00:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oijmV-0049BW-2M;
        Wed, 12 Oct 2022 18:00:51 -0400
Message-ID: <20221012220051.576066367@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Oct 2022 17:59:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [for-linus][PATCH 2/5] ring-buffer: Fix kernel-doc
References: <20221012215911.735621065@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

kernel/trace/ring_buffer.c:895: warning: expecting prototype for ring_buffer_nr_pages_dirty(). Prototype was for ring_buffer_nr_dirty_pages() instead.
kernel/trace/ring_buffer.c:5313: warning: expecting prototype for ring_buffer_reset_cpu(). Prototype was for ring_buffer_reset_online_cpus() instead.
kernel/trace/ring_buffer.c:5382: warning: expecting prototype for rind_buffer_empty(). Prototype was for ring_buffer_empty() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2340
Link: https://lkml.kernel.org/r/20221009020642.12506-1-jiapeng.chong@linux.alibaba.com

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
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
2.35.1
