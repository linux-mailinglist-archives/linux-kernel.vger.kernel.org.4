Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB162B628
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiKPJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiKPJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:14:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7275F53;
        Wed, 16 Nov 2022 01:14:30 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:14:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668590069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J12AjfEBxw2JDdQGKt0HHv0EWetLXI3s7cHu6+Akp4Q=;
        b=ghmcLyDP+ZZU6BBDzV00+CF1UCkm8+ZNXXExorCB3i7MjdtCCVcruxKMLZxXlEKW1xFPFo
        ZO/46eTVig8qgiCRxaLfFgb7uP7T39OkAmXEo/C5Bnju0bOJdDF/yWq1kz3nt4nVVPobNG
        QsrbgeeXcritYzR/M3cZEVm9yop/Ts89MaY9gAglBfy7aqiDRthPWwXy99jPQ2MnU6xtYO
        wQwd8ZE2LhqmV9yikZp34aYp81HzcYO1+6XG52Di3xPFKdrFYzRG8SNH2xW++uaz0en8/2
        /wXvq78Iw/mvae2guCkgGfCRkiztRO34Rc4/I07qJaLcane4519Bh62dMSdppA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668590069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J12AjfEBxw2JDdQGKt0HHv0EWetLXI3s7cHu6+Akp4Q=;
        b=K5NnJKtJXNp5OHP9VhXrsBuI5h0AR2ADGAOeR8PJ+bfAmXTUx3otKyNrgDtQIG+k2hRpvp
        XexyCvD/1LgvGcAA==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Remove unused pointer task_ctx
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221028122545.528999-1-colin.i.king@gmail.com>
References: <20221028122545.528999-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Message-ID: <166859006830.4906.14078018053226238074.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3ce1cb7eee70335b6d4f50fadec264473e9566c3
Gitweb:        https://git.kernel.org/tip/3ce1cb7eee70335b6d4f50fadec264473e9566c3
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Fri, 28 Oct 2022 13:25:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:30:11 +01:00

perf: Remove unused pointer task_ctx

The pointer task_ctx is being assigned a value that is not read, the
assignment is redundant and so is the pointer. Remove it

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221028122545.528999-1-colin.i.king@gmail.com
---
 kernel/events/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ec2abc5..baa2997 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4215,7 +4215,6 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_pmu_context *cpu_epc, *task_epc = NULL;
 	struct perf_event *cpu_event = NULL, *task_event = NULL;
-	struct perf_event_context *task_ctx = NULL;
 	int cpu_rotate, task_rotate;
 	struct pmu *pmu;
 
@@ -4229,7 +4228,6 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 	task_epc = cpc->task_epc;
 
 	cpu_rotate = cpu_epc->rotate_necessary;
-	task_ctx = cpuctx->task_ctx;
 	task_rotate = task_epc ? task_epc->rotate_necessary : 0;
 
 	if (!(cpu_rotate || task_rotate))
