Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CFB72AB87
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjFJMpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjFJMpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:45:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567FE35B8;
        Sat, 10 Jun 2023 05:45:32 -0700 (PDT)
Date:   Sat, 10 Jun 2023 12:45:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686401130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEzxubQcnLZoG0m9coTklTKk4G+HNneq9lcmAgnyAkI=;
        b=YZXtKb6hDLOPspLe39n+5awamNUWNAgrOUEtGHdClzzkePjpqKc8esCYe8aptUqjXggnZ2
        jA70ULyI7ag5O94okQvgvXaF6X+85bzynm77X+NxugldWkhSO0LgqOJi4zsNRQwkj36ENh
        yyPBFYj4lzwFlNGQg+DEKBdngdE41gUXKXKYtL9LyVSX43DVsZ9qUUrzJsi1kNlyOGBB0H
        OxcJwlMAQVrK2pn2TQMrkkRMOFwDy+28hTd3AdgVnaiwmcNkgQ8iLc15RlBUIOI2UzzpOg
        zNTpsdaT3hTwT+5VibOFK7tDzZ/j1j8pza9jQ4Tkj6t3EgzIJOdf2OOSvt1a3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686401130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEzxubQcnLZoG0m9coTklTKk4G+HNneq9lcmAgnyAkI=;
        b=JmI8KGUhV2NpzYtEvUtDKaMSEE/+2ewN3BGzVkSCjEHBHtKklWCH5aIOj9vgv0asotATW9
        hatTfgiqvkg2PyBA==
From:   "tip-bot2 for Li zeming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Remove unnecessary (void *) cast
Cc:     Li zeming <zeming@nfschina.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230609182059.4509-1-zeming@nfschina.com>
References: <20230609182059.4509-1-zeming@nfschina.com>
MIME-Version: 1.0
Message-ID: <168640113003.404.3362295823712498263.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f319c99c701853dd41c01209855790da288e38ab
Gitweb:        https://git.kernel.org/tip/f319c99c701853dd41c01209855790da288e38ab
Author:        Li zeming <zeming@nfschina.com>
AuthorDate:    Sat, 10 Jun 2023 02:20:59 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 10 Jun 2023 14:36:17 +02:00

alarmtimer: Remove unnecessary (void *) cast

Pointers of type void * do not require a type cast when they are assigned
to a real pointer.

Signed-off-by: Li zeming <zeming@nfschina.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230609182059.4509-1-zeming@nfschina.com

---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 09c9cde..8d9f13d 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -751,7 +751,7 @@ static int alarm_timer_create(struct k_itimer *new_timer)
 static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
 								ktime_t now)
 {
-	struct task_struct *task = (struct task_struct *)alarm->data;
+	struct task_struct *task = alarm->data;
 
 	alarm->data = NULL;
 	if (task)
