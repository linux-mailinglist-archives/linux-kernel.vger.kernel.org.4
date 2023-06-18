Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAAB734857
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFRUuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFRUuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB39E4E;
        Sun, 18 Jun 2023 13:50:00 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:49:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+poXMllneohhrgOgquiA/XGrGyhuMfgxXypp486YF1g=;
        b=Z6VgrdCadpMQG0dgsfTZKxxGpXS9X2tnAv8aQgAZOBYnqP745PxxOqFmWg9quUW2Yhz7p4
        fCtUAUf1v0cdcOHiF+6FpquFE4SUt8wy7gP7VC+PJxLEWm/gbTS0BO8z1xlWSopq7QzeJ7
        pgSETKCUJ5fL+eGqmVCnMjfhumjdGLic2D82dPqq6WEomtY4PqEUxNLQNSLUtPYF7rGfiC
        IKqtEOgL3Xq4vzzS56O/Z/LsGUBKFuhok/KeK+obT9e+fjEfCwdM2X/KSkYh279GHp3/ue
        188bG4YnfLvLggLewbmaoHyesYP+W466YE9ihgWeI9nYhD/iwE7bCDf5qyFf9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+poXMllneohhrgOgquiA/XGrGyhuMfgxXypp486YF1g=;
        b=Jy6zv55Gj+OIXzPoFioY/I8jbBsCWDJqzLoW6lTOymj/dRW1mjV4QeaZGot2Pog87ry1eb
        EZYeKnOS1cAm2kDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Comment SIGEV_THREAD_ID properly
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.672220780@linutronix.de>
References: <20230425183313.672220780@linutronix.de>
MIME-Version: 1.0
Message-ID: <168712139850.404.17042898181563886129.tip-bot2@tip-bot2>
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

Commit-ID:     c575689d66378611bb04137b96e67ebb3ac8482b
Gitweb:        https://git.kernel.org/tip/c575689d66378611bb04137b96e67ebb3ac8482b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:51 +02:00

posix-timers: Comment SIGEV_THREAD_ID properly

Replace the word salad.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.672220780@linutronix.de

---
 kernel/time/posix-timers.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 20d3b99..c8b0f52 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -53,12 +53,9 @@ static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
 static const struct k_clock clock_realtime, clock_monotonic;
 
-/*
- * we assume that the new SIGEV_THREAD_ID shares no bits with the other
- * SIGEV values.  Here we put out an error if this assumption fails.
- */
+/* SIGEV_THREAD_ID cannot share a bit with the other SIGEV values. */
 #if SIGEV_THREAD_ID != (SIGEV_THREAD_ID & \
-                       ~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
+			~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
 #error "SIGEV_THREAD_ID must not share bit with other SIGEV values!"
 #endif
 
