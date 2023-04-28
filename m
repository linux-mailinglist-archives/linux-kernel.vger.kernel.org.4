Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2F6F10B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 05:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344984AbjD1DMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 23:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344947AbjD1DLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 23:11:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8430B3C24
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=iPaNTRr4YG/Sa60FYBv4xjWiredPl874QL6Kp29pXgA=; b=c2UtG5vz34cTtmPnNN9tMfsZrG
        sZo3oPG8rn0EzKN8JGMj5ssvBOK6Jr/tR2rQ0ZRvokxojShaLG58AZVRVhRNe6ThCu+OeNTGC8yed
        JHg6ZSpBnXhFxnmq5Hf3V8hXShiaa6kdJCfZUn80Pq9yDTj3IWzqLnQt1yvcv5Td55+IjjAP38HD5
        FD9xumFNW8vkL2Xr+K7CKnV7NjzZYY3CpXzFWbShtEYpJG0PHWS58kBEuN9r+suS2GmMzY6tN7cQK
        bzh8995whBVqaQFQJDaewRURgmEFlsAlznGxzR1uoovYPDu289BV8UkUEH8UMJYTQtW0xutFwACO2
        bWiA//6A==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psEVs-0082rS-0n;
        Fri, 28 Apr 2023 03:11:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH -next] sched: fix cid_lock kernel-doc warnings
Date:   Thu, 27 Apr 2023 20:11:11 -0700
Message-Id: <20230428031111.322-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings for cid_lock and use_cid_lock.
These comments are not in kernel-doc format.

kernel/sched/core.c:11496: warning: Cannot understand  * @cid_lock: Guarantee forward-progress of cid allocation.
 on line 11496 - I thought it was a doc line
kernel/sched/core.c:11505: warning: Cannot understand  * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
 on line 11505 - I thought it was a doc line

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/kernel/sched/core.c b/kernel/sched/core.c
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11492,7 +11492,7 @@ void call_trace_sched_update_nr_running(
 
 #ifdef CONFIG_SCHED_MM_CID
 
-/**
+/*
  * @cid_lock: Guarantee forward-progress of cid allocation.
  *
  * Concurrency ID allocation within a bitmap is mostly lock-free. The cid_lock
@@ -11501,7 +11501,7 @@ void call_trace_sched_update_nr_running(
  */
 DEFINE_RAW_SPINLOCK(cid_lock);
 
-/**
+/*
  * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
  *
  * When @use_cid_lock is 0, the cid allocation is lock-free. When contention is
