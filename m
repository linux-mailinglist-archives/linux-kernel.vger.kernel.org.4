Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1365E96F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjAEK7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjAEK7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:59:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539E354713;
        Thu,  5 Jan 2023 02:59:09 -0800 (PST)
Date:   Thu, 05 Jan 2023 10:59:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672916348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRSZUNHOweE8Gbgz6Bx7yitBQCc4aVsvA+KeqzR9PJQ=;
        b=Tenx/PkHx2f/Fzgd6hifUtgIw5jZSI41cl9aNKrMsF3gSq2+CJEb6aBQxJJlp9naRzFnmb
        jGK0O5Kda6GkmrmNKSefXzNwZRT5ViHV4/3TBh6MEiNFPLZfaCHq5tcq0NJaEuIuS2l5kW
        gu8536ZUqt567ErCQBQV/+9m6Lmtz03opmOhV231xWvcFWz+ohwNkY7VOwn8iJUegr//vN
        E++O5IzJPyArz48VgixPjfyfU1fudfyshsuck9AfbY9/7FCuN/uenU1nz4vgdvecWTPgD1
        bnq4KEbT9MPtPMpt6BvnkPwzSNTAanAz0Ud0BqYySYbRphxSpi2HyKK8yucrSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672916348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRSZUNHOweE8Gbgz6Bx7yitBQCc4aVsvA+KeqzR9PJQ=;
        b=9VVgMjgjvk8UUSQeb4jt/9C36uMGct/SOdRtecOg7GJllZ6Hj27Nlk4oUNf0SZXP/CxiFl
        +GfwKZzlt1cISvBQ==
From:   "tip-bot2 for Bing Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Add __init for sched_init_domains()
Cc:     Bing Huang <huangbing@kylinos.cn>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230105014943.9857-1-huangbing775@126.com>
References: <20230105014943.9857-1-huangbing775@126.com>
MIME-Version: 1.0
Message-ID: <167291634746.4906.10815870728779627297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ef90cf2281a013d359d24d51732af990badf6e03
Gitweb:        https://git.kernel.org/tip/ef90cf2281a013d359d24d51732af990badf6e03
Author:        Bing Huang <huangbing@kylinos.cn>
AuthorDate:    Thu, 05 Jan 2023 09:49:43 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Jan 2023 11:42:13 +01:00

sched/topology: Add __init for sched_init_domains()

sched_init_domains() is only used in initialization

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230105014943.9857-1-huangbing775@126.com
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index dea9fa3..d93c337 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2451,7 +2451,7 @@ void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms)
  * Set up scheduler domains and groups.  For now this just excludes isolated
  * CPUs, but could be used to exclude other special cases in the future.
  */
-int sched_init_domains(const struct cpumask *cpu_map)
+int __init sched_init_domains(const struct cpumask *cpu_map)
 {
 	int err;
 
