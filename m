Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A186889D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjBBWeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjBBWeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:34:19 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7786A32A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:34:18 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f15-20020a62380f000000b0058db55a8d7aso1633006pfa.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt4n7TrebHBHw1pv+f/VYH1/nL9tMmkgabnkwlM1MoM=;
        b=lkvfRnCR9L4p48JCZwFZKWUKHGN61Q3m0t7AYSHtCynD8fd/3R0LutY7M8PjtUNTAF
         75GpSew/2QQYyvsc6dNLfGFaHsNxWUjTbvbWHaFPATihKYBfAoSzg9TsANL2ayno0iFW
         DQ31W/I3W0ZEpyBr6VhnMbXBU2b44i0YGfsCzylRXeCADASPJJxwtrSsFKLhGEhwLPLP
         RvHmLd3iUMU5hPOfHF9wp3JwzOML0GCzI9DJkY1X4gTtAX40FiJnjMD/UeQKBD6NMPkA
         99baXrHXLS6CEfsAYP7QHJs8HVLMWw7JxF3ekZQE0Rs96QAt2qP570o51O3gKemcHTj+
         FPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt4n7TrebHBHw1pv+f/VYH1/nL9tMmkgabnkwlM1MoM=;
        b=3Pt3rSGf3pggcUaUG9dJLUdXD5IMxGaTljuKdCauxBOBPX72QwlCJ5Sbr51vQC78K1
         V9gU46BIU/tUF0g/H9gPWykDnDPz+FI4Qlze3MZaTvDS7E7SfBCDXQYEMZUA+QKgP/w3
         2JE4rtKkmmYlxKM7uSIY2d8yosZWJ+qnH8jkAd+SzR0yHZW/AOysF8VAw+3G2rbnhtAC
         a3c0V0otDncHiqPRBJ8PHgYPOP5obgE5SWbZB3gfQwX7kBAVufu4Xxk0JcsXPM+B9cFY
         9oKwP3L6Pz+fSK91Xxog0TdC74mUfx0Y/rmYGV8f3PIB2NydQtAQqXpXUqMWCtWff8Dt
         qfXw==
X-Gm-Message-State: AO0yUKXe4Qf1mxaF/oH+4u0ZGuzku9/RHJfph5a7+vaHHpbAXzE+c7Bm
        yFgUNkzt2m6KM48q9qiqTMManmTZpeEnNozKE9C++4s28UDuuuvwQBqCqHzj0trNW7/P9kEm8vl
        LGsBZN5G3SfsJ+ZwL3RTIlV1ZLE1U27LMh4YLCoJ16yQZkdb97IwYZgcw7sMyY/IyjTQkSKQ=
X-Google-Smtp-Source: AK7set+R97mddCZGv1IhfXta/gy3VCxqtqeUPTjtG8Pp4TJe21qhJ7rG/KaX0KI/oSZdaHpUcWH6FXRYqRdG
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:aa7:84c5:0:b0:593:37d6:dcb8 with SMTP id
 x5-20020aa784c5000000b0059337d6dcb8mr1853562pfn.30.1675377257642; Thu, 02 Feb
 2023 14:34:17 -0800 (PST)
Date:   Thu,  2 Feb 2023 22:34:09 +0000
In-Reply-To: <20230202223409.2812443-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230202223409.2812443-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202223409.2812443-4-jstultz@google.com>
Subject: [RFC][PATCH 4/4] locktorture: With nested locks, occasionally skip
 main lock
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

