Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105CB68C83D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBFVGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBFVGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:06:13 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B42C649
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:06:12 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id j14-20020aa7928e000000b00593bca77b0dso6953694pfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 13:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3e/s9avw1m4n0KoQjfHLWE3N93DXhuhhva7XCYBBqk=;
        b=HokxCYxl6SUv/u4i1B4MSvdUni65+hHCahZPbRel82LgW2njrOIL7KZFDtMGa2VnyB
         hjXqVcyejXgPnAaMv1Kw/Lp68BU18saa2DNpXrpbwTGKsIXGJ1m96FQCxVoSPPt7C73m
         QNRsKo4r3cEHT2TFXE616xDky8i59SO/oncU7xwwfpQf1Wh2BSAluLwHHEuLUBHbZoeP
         Or6cJNi27gxZtDmrE+saH7xQ+Qp4PHgTwkYow3D8qjAhunNPK8xDXjAnx2LuX2zwwV0N
         v01sCwU/VwSi8+mkz7wwO/6NK5S8XebVV5Dny08dA4B8VvyiL6TNbKitMq/p2MHkgD30
         xX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3e/s9avw1m4n0KoQjfHLWE3N93DXhuhhva7XCYBBqk=;
        b=RO6To3HoGfjHsT5//iLr01GsQeXFtfHq3KJ8hHZs1JUZQMKLWvN1WoQ/mTLkdyntLK
         Wiqmw6b6yt8zh1cL2OhAcMOb1i0UjECDaVgzfumnpoMjdmlks+XbV6FXJegr1K16gtXA
         c/lsDehbldMSY0WHtj0dZfMmHi1nScNWMlITdf6g9FrKfbnZ5RgWw2Sdr1TwvMK3QGBw
         migRrAmtkbxVXoe11PK7UhlSbxR+A7CDuKXN1KyP1MddTqilOyB88dIOSDhmQXnMoakC
         5FUNnNHXsubjvDsu91aeHDpL2uhbDxerzgKndJw24ytTaljOBYRxNcbpqBPBLWyfUTgq
         JTGA==
X-Gm-Message-State: AO0yUKU/8GE+ef7Ms+Y2WUrArzSoR72fS028GAl1qER32uzApLZDIXFx
        Ixa5sgiKgJV1GTksmw+ckqDlca5tBt5ucCoFyIdQDFnqjvpdjcCBX0JDGCQ8hRAj2d5M+vMTHeR
        DjAcpz6jAoHkETWVi8jSDxMDD4aUGI7kee+DF1pl2saOBMbbCQhoYBV89llNYRFOsRTOHHUw=
X-Google-Smtp-Source: AK7set+5my3NkgMIE16XbedPOzN0cF/L+0rAX1s0+7Q7AvdwUhOxe5usq3D1qCXqJCcxIxD6Ct9xaIxcvyc9
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90b:e97:b0:22c:5369:8a36 with SMTP id
 fv23-20020a17090b0e9700b0022c53698a36mr11794pjb.0.1675717571605; Mon, 06 Feb
 2023 13:06:11 -0800 (PST)
Date:   Mon,  6 Feb 2023 21:05:56 +0000
In-Reply-To: <20230206210556.660318-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230206210556.660318-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230206210556.660318-4-jstultz@google.com>
Subject: [PATCH v3 4/4] locktorture: With nested locks, occasionally skip main lock
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

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v3:
* Minor rework for naming changes suggested by Davidlohr Bueso
* Added comment explaining why we skip the main lock, as
  suggested by Davidlohr Bueso
---
 kernel/locking/locktorture.c | 37 ++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index fd8b2b007c26..ab896cc42b87 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -745,6 +745,7 @@ static int lock_torture_writer(void *arg)
 	int tid = lwsp - cxt.lwsa;
 	DEFINE_TORTURE_RANDOM(rand);
 	u32 lockset_mask;
+	bool skip_main_lock;
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
 	set_user_nice(current, MAX_NICE);
@@ -754,21 +755,37 @@ static int lock_torture_writer(void *arg)
 			schedule_timeout_uninterruptible(1);
 
 		lockset_mask = torture_random(&rand);
+		/*
+		 * When using nested_locks, we want to occasionally
+		 * skip the main lock so we can avoid always serializing
+		 * the lock chains on that central lock. By skipping the
+		 * main lock occasionally, we can create different
+		 * contention patterns (allowing for multiple disjoint
+		 * blocked trees)
+		 */
+		skip_main_lock = (nested_locks &&
+				 !(torture_random(&rand) % 100));
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

