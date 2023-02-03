Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9968A359
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjBCUBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjBCUBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:01:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48905A77B6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:01:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z9-20020a25ba49000000b007d4416e3667so5825211ybj.23
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 12:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt4n7TrebHBHw1pv+f/VYH1/nL9tMmkgabnkwlM1MoM=;
        b=fMPtyxtz/sSfFNjjRD5ySCffBSUU6QiDEXza5AgFvN0rIoBvkIEdIDVZ+Xg52loddj
         lmMO5IYa+Oj57RacBvop4iZOd1IaD75y1qPByi/w9bsZ/zdHZfGsGOZ9Qrte0R90aW+z
         +XDTYLDbRZkAkDV1zjwqCtzB1z9C0pXgKRSDx0ZzdChO4+QTiY/3Zk/wxQYSWkel5ETr
         HhybkR8UnNvraSI+P09YhdH/r5YZoE/uKJUDE20GAz/+zYnbOQxeicxIjZszOfyRTch/
         P1OxVUgyQb9PbHSjm4Wk39pJeD8LeKD/bNiNep+wU+Kv1258edtOfpPLhloihRh697N7
         KaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt4n7TrebHBHw1pv+f/VYH1/nL9tMmkgabnkwlM1MoM=;
        b=tj9mWDNAc81vCRY6FoxQyA0KRHJNqNhYHQv8+G8ysqaFHJCTrgVZHVuuC3uz18vT5n
         buocjgdlhLzmLfT6uFkC/O4yDDzXOFigjKgEI/AP8o9P/kEJAlcEE58ry+LhjYJVDbc6
         CLtSxC64hfxG3gstwG0w26yr81Ae2mSRG6AxQzC2skefKNkdzbPakm8bFAsD+qa7oV/+
         Poysw3cAeXMdCjTkajhi+qNKZ8pXKHzvT2frj4ijLL2onHvXKmWwO9I6xDRD/krm9jU2
         Dp12NjAursGtAldDuv54OYfgT8iroqGqFCCPfWFFfPVrjc3HPBe7RNMjFhFG8vDi4NwZ
         79qg==
X-Gm-Message-State: AO0yUKWnipBsVCNGeUkTFOsmlsVelfM79CR6Yu/NB4dAqzpIneMHb76h
        v2N6KLOkeUdev5w87YXpDqRabqjxq0j/edzfmLckbMCOpT/7W6Ngk/rgH4boF03jZphLNQazvdI
        8bw7Kw2gGzol8iGnuOq/vHsvjz5XxZvg5yXtHSolm2nA3iB0dtvmqup+UtxbLFSnkmRRcpm8=
X-Google-Smtp-Source: AK7set91fjCEo7tXASurS+5Nz5Rqfgr5fZoXytxmvNkNzTwk5ZFApResIjCRAQ5iz3s59kODUc8qWYLPEloK
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:4c8:b0:87c:45a2:8656 with SMTP id
 v8-20020a05690204c800b0087c45a28656mr52620ybs.86.1675454506493; Fri, 03 Feb
 2023 12:01:46 -0800 (PST)
Date:   Fri,  3 Feb 2023 20:01:38 +0000
In-Reply-To: <20230203200138.3872873-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230203200138.3872873-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230203200138.3872873-4-jstultz@google.com>
Subject: [PATCH v2 4/4] locktorture: With nested locks, occasionally skip main lock
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're using nested locking to stress things, occasionally
skip taking the main lock, so that we can get some different
contention patterns between the writers (to hopefully get two
disjoint blocked trees)

This patch was inspired by earlier work by Connor O'Brien.

Comments or feedback would be greatly appreciated!

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/locktorture.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 5fb17a5057b5..6f56dcb8a496 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -745,6 +745,7 @@ static int lock_torture_writer(void *arg)
 	int tid = lwsp - cxt.lwsa;
 	DEFINE_TORTURE_RANDOM(rand);
 	u32 lockset_mask;
+	bool skip_main_lock;
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
 	set_user_nice(current, MAX_NICE);
@@ -754,21 +755,28 @@ static int lock_torture_writer(void *arg)
 			schedule_timeout_uninterruptible(1);
 
 		lockset_mask = torture_random(&rand);
+		skip_main_lock = nlocks && !(torture_random(&rand) % 100);
+
 		cxt.cur_ops->task_boost(&rand);
 		if (cxt.cur_ops->nested_lock)
 			cxt.cur_ops->nested_lock(tid, lockset_mask);
-		cxt.cur_ops->writelock(tid);
-		if (WARN_ON_ONCE(lock_is_write_held))
-			lwsp->n_lock_fail++;
-		lock_is_write_held = true;
-		if (WARN_ON_ONCE(atomic_read(&lock_is_read_held)))
-			lwsp->n_lock_fail++; /* rare, but... */
 
-		lwsp->n_lock_acquired++;
+		if (!skip_main_lock) {
+			cxt.cur_ops->writelock(tid);
+			if (WARN_ON_ONCE(lock_is_write_held))
+				lwsp->n_lock_fail++;
+			lock_is_write_held = true;
+			if (WARN_ON_ONCE(atomic_read(&lock_is_read_held)))
+				lwsp->n_lock_fail++; /* rare, but... */
+
+			lwsp->n_lock_acquired++;
+		}
 		cxt.cur_ops->write_delay(&rand);
-		lock_is_write_held = false;
-		WRITE_ONCE(last_lock_release, jiffies);
-		cxt.cur_ops->writeunlock(tid);
+		if (!skip_main_lock) {
+			lock_is_write_held = false;
+			WRITE_ONCE(last_lock_release, jiffies);
+			cxt.cur_ops->writeunlock(tid);
+		}
 		if (cxt.cur_ops->nested_unlock)
 			cxt.cur_ops->nested_unlock(tid, lockset_mask);
 
-- 
2.39.1.519.gcb327c4b5f-goog

