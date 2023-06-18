Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013FC734863
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjFRUvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFRUuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB6EE54;
        Sun, 18 Jun 2023 13:50:09 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:50:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MrEQ3I65cqng6jyKbh0tu2RLyql6fYc51c1USigvkrU=;
        b=W+inexBV4Pp2XLD4WPfjL7bLFSrAmJHKux4gQimypHtXVUf54QX+7dXy+L8c67WXTBIrQY
        Eiz1R+6hc8QdRr2/GqFnrKJmPQzJKlZJLQKcaw0WfK+w0tihTOt4qfLADSuFEej8LWf2XB
        SXKNLOq3n7Bad+9jhpVhlEgr8R7EsnH8XKa6HRLqstmOraGykR6rurK1Oe627rMzqcjPjG
        iMoGPatlUCBgEKqeLKLqeWz174ckD/8F9zH1PORBrUVAwi4K8HxxZuGByUYSvp9spa3q/z
        vPB1EK8EVp9xruNqKS0RjDqXhcqtW4g3VuFjW0xv8d3oTT8UIJIn+13Q2KJQ/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MrEQ3I65cqng6jyKbh0tu2RLyql6fYc51c1USigvkrU=;
        b=rpe3sI96Otmw2MHpyCFZ059UrXFmrgLYuc2McEmOv3o53JmuDoJJfGSdwkEE1sIGiMurOG
        XOV3F2geZiH8fnBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Cleanup comments about timer ID tracking
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.038444551@linutronix.de>
References: <20230425183313.038444551@linutronix.de>
MIME-Version: 1.0
Message-ID: <168712140755.404.17638032400776880983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8d44b958a1a088195524c884f0437660e0522380
Gitweb:        https://git.kernel.org/tip/8d44b958a1a088195524c884f0437660e0522380
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:48 +02:00

posix-timers: Cleanup comments about timer ID tracking

Describe the hash table properly and remove the IDR leftover comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.038444551@linutronix.de

---
 kernel/time/posix-timers.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0c61f29..79909a2 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -35,20 +35,17 @@
 #include "timekeeping.h"
 #include "posix-timers.h"
 
-/*
- * Management arrays for POSIX timers. Timers are now kept in static hash table
- * with 512 entries.
- * Timer ids are allocated by local routine, which selects proper hash head by
- * key, constructed from current->signal address and per signal struct counter.
- * This keeps timer ids unique per process, but now they can intersect between
- * processes.
- */
+static struct kmem_cache *posix_timers_cache;
 
 /*
- * Lets keep our timers in a slab cache :-)
+ * Timers are managed in a hash table for lockless lookup. The hash key is
+ * constructed from current::signal and the timer ID and the timer is
+ * matched against current::signal and the timer ID when walking the hash
+ * bucket list.
+ *
+ * This allows checkpoint/restore to reconstruct the exact timer IDs for
+ * a process.
  */
-static struct kmem_cache *posix_timers_cache;
-
 static DEFINE_HASHTABLE(posix_timers_hashtable, 9);
 static DEFINE_SPINLOCK(hash_lock);
 
@@ -66,15 +63,6 @@ static const struct k_clock clock_realtime, clock_monotonic;
 #endif
 
 /*
- * The timer ID is turned into a timer address by idr_find().
- * Verifying a valid ID consists of:
- *
- * a) checking that idr_find() returns other than -1.
- * b) checking that the timer id matches the one in the timer itself.
- * c) that the timer owner is in the callers thread group.
- */
-
-/*
  * CLOCKs: The POSIX standard calls for a couple of clocks and allows us
  *	    to implement others.  This structure defines the various
  *	    clocks.
