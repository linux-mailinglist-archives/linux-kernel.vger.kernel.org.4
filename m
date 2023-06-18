Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E664D734846
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjFRUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFRUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:49:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAE1E49;
        Sun, 18 Jun 2023 13:49:56 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:49:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w361mZKaVFHOMcQz6y0EclZKFDtawC9mE3iwVFvBeJU=;
        b=a+nt65ISRspHmNz6EUMFWhLoSz/2eE3cDYrXdROUujBrsX+Nh4KzYpEYxJOS/Yyz7bDXvn
        MC6iES2zNbzGjs8NpDJSP75rtkuvG1ymJur+Vb6TWnUrfM/cSd2OYuJhgLWcYvsWvRwq7g
        VKgOP6PT/1U0sLu2fAhSFbQTptTPR+NGcPXLDDzwMjO5BhNTvzpJsTRQX4fqaLaB4c3U3D
        45A9i80Hn262rrAjR8R8+MLjLR8yiSIlGtOvn9TA+P7I6KSbXwpZRI5PAnUdDE/xHzEsqC
        7CEkM8LnSEo7cbOsmoxfyldujt1LOhncOUNTJvX0s+NeOZqA83dS+LsKdh23QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w361mZKaVFHOMcQz6y0EclZKFDtawC9mE3iwVFvBeJU=;
        b=Z1wdEtNge7as4oHLVW3ZDxpipRItO9LOY6iD5VAtUGk7M2jC1O+/OmlA43fzlcKNwd2eZ+
        A05ZpW3YtbbBSdCw==
From:   "tip-bot2 for Li zeming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Remove unnecessary initialization of
 variable 'ret'
Cc:     Li zeming <zeming@nfschina.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230609182856.4660-1-zeming@nfschina.com>
References: <20230609182856.4660-1-zeming@nfschina.com>
MIME-Version: 1.0
Message-ID: <168712139462.404.10986834065061459424.tip-bot2@tip-bot2>
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

Commit-ID:     986af8dc5af834071a8a7afdf2c3b7a57d562df2
Gitweb:        https://git.kernel.org/tip/986af8dc5af834071a8a7afdf2c3b7a57d562df2
Author:        Li zeming <zeming@nfschina.com>
AuthorDate:    Sat, 10 Jun 2023 02:28:56 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:53 +02:00

alarmtimer: Remove unnecessary initialization of variable 'ret'

ret is assigned before checked, so it does not need to initialize the
variable

Signed-off-by: Li zeming <zeming@nfschina.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230609182856.4660-1-zeming@nfschina.com

---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 82b28ab..09c9cde 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -847,7 +847,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	struct restart_block *restart = &current->restart_block;
 	struct alarm alarm;
 	ktime_t exp;
-	int ret = 0;
+	int ret;
 
 	if (!alarmtimer_get_rtcdev())
 		return -EOPNOTSUPP;
