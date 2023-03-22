Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CC96C45F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCVJOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjCVJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:14:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C2846099;
        Wed, 22 Mar 2023 02:14:36 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:14:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679476475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1R+76IA9gjM5bDVWhken4vpqokxQEhtrA9x7OyJ4SWs=;
        b=MveqEprTuHhzTj8gqsTBDjyRBYW22uRmUa5555cnufy7tslyJAS/5OWhOi6AmRuvv/R1Iz
        hFMzcCiAumMYlu26Ot1L9qEsRSE4ZfhNfGFPl8r2WDpikovbu+gQwxvUCbCo+do4k4QsLz
        bTJPjWgcOGxQUOwfpN4ml+oozYFrhX1WtasJKvyRO8XxDwAo/njZkx0zK5djDH4BuKvRzI
        l+Lp0TcSte/e9bOi93b0+nf5WR546jVDcJI8AHS868GApSBmDdVsU6NkSlTFKfErQIMK3a
        sRAw0YyaAoXFg6EuoYd/MiY97yyDpM96WvrG1bWtXRL1FkXfDy2Pl1Awr8jSmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679476475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1R+76IA9gjM5bDVWhken4vpqokxQEhtrA9x7OyJ4SWs=;
        b=YaSuQ7h6mZjpcsSFDBdrVth4E5mpXzzZJriKc/ytSNrBncM9P4nuHPjPr0ahJxIABIzyCj
        MGMHyd0qqxvPW8Cg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/msr: Add Granite Rapids
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230314170041.2967712-2-kan.liang@linux.intel.com>
References: <20230314170041.2967712-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167947647519.5837.2418911139525900027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5a796d5cb5d11f5aad4893a59f22715810769928
Gitweb:        https://git.kernel.org/tip/5a796d5cb5d11f5aad4893a59f22715810769928
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 14 Mar 2023 10:00:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Mar 2023 14:43:08 +01:00

perf/x86/msr: Add Granite Rapids

The same as Sapphire Rapids, the SMI_COUNT MSR is also supported on
Granite Rapids. Add Granite Rapids model.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230314170041.2967712-2-kan.liang@linux.intel.com
---
 arch/x86/events/msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index c65d890..0feaaa5 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -70,6 +70,8 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 	case INTEL_FAM6_EMERALDRAPIDS_X:
+	case INTEL_FAM6_GRANITERAPIDS_X:
+	case INTEL_FAM6_GRANITERAPIDS_D:
 
 	case INTEL_FAM6_ATOM_SILVERMONT:
 	case INTEL_FAM6_ATOM_SILVERMONT_D:
