Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56EB717F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjEaMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbjEaMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:04:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7F410B;
        Wed, 31 May 2023 05:04:51 -0700 (PDT)
Date:   Wed, 31 May 2023 12:04:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685534690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ldt2eBdZjUhBa/gsmh/4m1hI9n4EcmmtGa8p/lsAqBI=;
        b=RnxiO3Ys2tdSFDNKjjdH5udvVrKlGOTJeyIpBgqPuMtStfiXgNUCWjqwuhZrdc0ACfErLD
        eqkeaCGhWSRA6q9p9u2aaipVW2vYAO/Ochwx4g4Nh0f01/BaHZMbqKzaEFDB08wajk8DYj
        GQd0Fkd2FOxaQIvHNSNjVGZ+4K8beSiFZdv5b+bVIn/MGSokS/U5IE0b0JwlcCUJyn7EPe
        bokl1LldS1XlEdToTbLjCLZWftHrVGLbiytoKbBG4gaJOtDGYA3CrHp2tZ9lLohLpwJZ5D
        9iBgMNGS891X3v50vcESrTa0kF9TcObQkSpy0D2dPmRvC1/dlv2N1jXEJp8qcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685534690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ldt2eBdZjUhBa/gsmh/4m1hI9n4EcmmtGa8p/lsAqBI=;
        b=iAKG8byCxOUveQS47vtSgcG7qFYutbrlZdE2bZz8w46mXAahHT/NbvATHRSlwYFt8RE6y6
        njw7gmJfP77egkBw==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Hide unused init_cfs_bandwidth() stub
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230522195021.3456768-4-arnd@kernel.org>
References: <20230522195021.3456768-4-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168553469008.404.7937834671472850266.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c0bdfd72fbfb7319581bd5bb09b4f10979385bac
Gitweb:        https://git.kernel.org/tip/c0bdfd72fbfb7319581bd5bb09b4f10979385bac
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 May 2023 21:50:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 May 2023 22:46:25 +02:00

sched/fair: Hide unused init_cfs_bandwidth() stub

init_cfs_bandwidth() is only used when CONFIG_FAIR_GROUP_SCHED is
enabled, and without this causes a W=1 warning for the missing prototype:

kernel/sched/fair.c:6131:6: error: no previous prototype for 'init_cfs_bandwidth'

The normal implementation is only defined for CONFIG_CFS_BANDWIDTH,
so the stub exists when CFS_BANDWIDTH is disabled but FAIR_GROUP_SCHED
is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230522195021.3456768-4-arnd@kernel.org
---
 kernel/sched/fair.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c1b345..a7a8ccd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6169,9 +6169,8 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	return 0;
 }
 
-void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
+void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 #endif
 
