Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14056FDE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjEJN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbjEJN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:26:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB01900E;
        Wed, 10 May 2023 06:26:14 -0700 (PDT)
Date:   Wed, 10 May 2023 13:26:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683725172;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVknTNt976+E+pdbpfYQXjSnp9XJ60CYSW5lA/PZPHM=;
        b=cLDXYrkpHLmSM/skeWKoU11K/+DdhDzAusCKxSaZLyWK+8rmpt0m6+yquIX9eANZDWgJjM
        vhrjLf0YcSu/k3lFSm9/zlujC3LkEwymTv5105T+s3ZBLgV2FlpPoaVy3Xdqg7bpAU1vgd
        kONDcnRoZIaeX9Qy8xnNpZ9EPMHxdWclP0tWo+piEvRpJLKc9sGTBEpYi1iNKyElfiWXih
        ZLHslBxLZ+42+z0DKOsxwMVODosPz075rzlIzPipdxbU4ThoKNq+czdu+Rkltzijc6D7tG
        /ocUbiL7Fn+bP3dHN1ReXsPPkjzg8SV3C+aLLs2cVN8tF0GtCSHFFQj2hrBxaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683725172;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVknTNt976+E+pdbpfYQXjSnp9XJ60CYSW5lA/PZPHM=;
        b=RCyDWHA7HXCrvYKuRRrsFNqHDqPoLMqlGuBnPWXexleJpTnv7HJeHZTLt5WGvZ7ZJG+9bH
        WdUsqI8BJds+UjBw==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: fix cid_lock kernel-doc warnings
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230428031111.322-1-rdunlap@infradead.org>
References: <20230428031111.322-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <168372517178.404.13654987530273728202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0019a2d4b7e37a983d133d42b707b8a3018ae6f4
Gitweb:        https://git.kernel.org/tip/0019a2d4b7e37a983d133d42b707b8a3018ae6f4
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Thu, 27 Apr 2023 20:11:11 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:28 +02:00

sched: fix cid_lock kernel-doc warnings

Fix kernel-doc warnings for cid_lock and use_cid_lock.
These comments are not in kernel-doc format.

kernel/sched/core.c:11496: warning: Cannot understand  * @cid_lock: Guarantee forward-progress of cid allocation.
 on line 11496 - I thought it was a doc line
kernel/sched/core.c:11505: warning: Cannot understand  * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
 on line 11505 - I thought it was a doc line

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230428031111.322-1-rdunlap@infradead.org
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 944c3ae..a68d127 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11492,7 +11492,7 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 
 #ifdef CONFIG_SCHED_MM_CID
 
-/**
+/*
  * @cid_lock: Guarantee forward-progress of cid allocation.
  *
  * Concurrency ID allocation within a bitmap is mostly lock-free. The cid_lock
@@ -11501,7 +11501,7 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
  */
 DEFINE_RAW_SPINLOCK(cid_lock);
 
-/**
+/*
  * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
  *
  * When @use_cid_lock is 0, the cid allocation is lock-free. When contention is
