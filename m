Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4023F65DD66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbjADUIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbjADUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:08:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3615111C32;
        Wed,  4 Jan 2023 12:08:31 -0800 (PST)
Date:   Wed, 04 Jan 2023 20:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672862909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZV1obDgxLjUh+fB0UGnxusAPClwEZEjOfePLcRM4CY=;
        b=k/rCnHueBbd6pGUmTUVjyCBT0/2e8dcKKFO0M07tsc7gisWAKoHvihQ3I9/0E4uIcBJfxm
        FyUt3eYaN+NyIm5RBDMbe3N+uSbiOVynZMvRQnw7uXBJ+z8pGULrQFUWs7rytGI4pReIyR
        t/BKjUdJnbwW4UToGoH6XF2xqC4U9aP/sb1g0FV2GvvaQhcY54n+4UEFlqi/qrlRARrg5M
        qeadTf1R06HOXECYUaPyK4Bmso+u3FIoI+1W74dona0Q6mCOTvrP9inhGosYikfoQmQVBj
        iRyiW6VjLcPdilTB/VnVI0C74AkCmSpa1lSQHbujV/bFHoHYyryCHsz7VBU6Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672862909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZV1obDgxLjUh+fB0UGnxusAPClwEZEjOfePLcRM4CY=;
        b=ow3Ju0U442OpvGTyRquk+kpiO9JcBVBKA4KuOBtgjzpU1XqVYfsz/ErW/KslYfgeN6jczZ
        i1IL6o7tQ1E7L4Bw==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Add support for Intel Emerald Rapids
Cc:     Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230104145831.25498-2-rui.zhang@intel.com>
References: <20230104145831.25498-2-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <167286290814.4906.5046212985244200585.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     57512b57dcfaf63c52d8ad2fb35321328cde31b0
Gitweb:        https://git.kernel.org/tip/57512b57dcfaf63c52d8ad2fb35321328cde31b0
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Wed, 04 Jan 2023 22:58:31 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 04 Jan 2023 21:00:29 +01:00

perf/x86/rapl: Add support for Intel Emerald Rapids

Emerald Rapids RAPL support is the same as previous Sapphire Rapids.
Add Emerald Rapids model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230104145831.25498-2-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 589c688..52e6e7e 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -806,6 +806,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&model_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
