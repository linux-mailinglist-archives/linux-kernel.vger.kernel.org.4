Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F2F722A69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjFEPI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjFEPIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798FF2;
        Mon,  5 Jun 2023 08:08:29 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoWJhGlkrPutICGc7rmHeduSzyk5VXIUCCAZUGIdmZA=;
        b=yrqU0qkFFGzc4V6akX08luOHlQqbf/KLaqDtUCSA27p+ZZsRXsjedaFxvz+4kNQnzxdEd9
        yJ/0acy+CIvXIjwnNMi9mAZdU5bN5fB7ZqPj9Bs0518QOIl5ycJ9m/lNComD1SPM2Bms76
        F2OHZrR7K+PsihaeP1jWkSMYuox1JtbkEP638Il5Lm4z6TvEOVeRo6GT/kdWa0mqCciH/W
        eXnTGc3XfxIVBJmSqPZrd08v8+DRQeVN9+k7yvAUFXoG4Mc8Cu+XJTphJ6VhA5sTYlrl53
        lvJvl8OOjkjTbVLL58sxeNORL+6282WO1XzGmrR1Soh47OEkICvu6NRDEDCJJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoWJhGlkrPutICGc7rmHeduSzyk5VXIUCCAZUGIdmZA=;
        b=B/QUh7fArb2UmWGkSRWf/MhK1jd8fQpPDmOeNe1kLHyHUBefnTU4l96crT16VgrhHBZjki
        0f6NzRxpzYqBTiAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Document nanosleep() details
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.567072835@linutronix.de>
References: <20230425183313.567072835@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597770779.404.11242027713171629061.tip-bot2@tip-bot2>
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

Commit-ID:     13da885685d6ae339f2924d3c8a1f4fe16a904cc
Gitweb:        https://git.kernel.org/tip/13da885685d6ae339f2924d3c8a1f4fe16a904cc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:38 +02:00

posix-timers: Document nanosleep() details

The descriptions for common_nsleep() is wrong and common_nsleep_timens()
lacks any form of comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.567072835@linutronix.de

---
 kernel/time/posix-timers.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 9d99d4b..9ce13c9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1370,7 +1370,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 #endif
 
 /*
- * nanosleep for monotonic and realtime clocks
+ * sys_clock_nanosleep() for CLOCK_REALTIME and CLOCK_TAI
  */
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 const struct timespec64 *rqtp)
@@ -1382,8 +1382,13 @@ static int common_nsleep(const clockid_t which_clock, int flags,
 				 which_clock);
 }
 
+/*
+ * sys_clock_nanosleep() for CLOCK_MONOTONIC and CLOCK_BOOTTIME
+ *
+ * Absolute nanosleeps for these clocks are time-namespace adjusted.
+ */
 static int common_nsleep_timens(const clockid_t which_clock, int flags,
-			 const struct timespec64 *rqtp)
+				const struct timespec64 *rqtp)
 {
 	ktime_t texp = timespec64_to_ktime(*rqtp);
 
