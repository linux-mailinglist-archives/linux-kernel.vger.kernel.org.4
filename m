Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE872AB88
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjFJMpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjFJMpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:45:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA70C35A9;
        Sat, 10 Jun 2023 05:45:32 -0700 (PDT)
Date:   Sat, 10 Jun 2023 12:45:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686401131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kmq5gX6ZPbnBJQ6HB2titUQycKci8ucePYtjBr899Rc=;
        b=ktPmw1LM6OYdzfPb8FmStksFLQ/1E6A45Q1W7sQ7C1aTE3Y72Z3Tn+TdRB6f1Gjl8mRguu
        mfqzmjitA7jcP218qSe9q8+Hss7fc3oCRSI7Q8xuCIo8ZynXKjjArGAXmVUtsRaOwA7Jux
        Q5m/XQtwF37JknvBijExXoy9pFc2mY/iIpOlP64I29SRbPRXImTEdgr5weoM3MF1D8diQh
        /Zzb9g+3vLMreaTukWO11dmTOybkFld3MPyzWJHeoGLvGXoUNfeajNhOH1f4o00mwvqieB
        JjDzXHWhURKU6IMNBjkGMRBcnZQsw8DJP+wqCfAJWHA2fvuLNRGICIvBqyoBhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686401131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kmq5gX6ZPbnBJQ6HB2titUQycKci8ucePYtjBr899Rc=;
        b=CHdyrVTOvBYphDkDcPWO8qrwqRlnONQ1vPs8AQVpKKyDxrfVFHnf19zmchnmbYIiWzLFG2
        vnORkBjrZlD30jDw==
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
Message-ID: <168640113089.404.17920315921648070254.tip-bot2@tip-bot2>
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

Commit-ID:     ace380b014f338834d55082820a475e7c5b2c952
Gitweb:        https://git.kernel.org/tip/ace380b014f338834d55082820a475e7c5b2c952
Author:        Li zeming <zeming@nfschina.com>
AuthorDate:    Sat, 10 Jun 2023 02:28:56 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 10 Jun 2023 14:36:17 +02:00

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
