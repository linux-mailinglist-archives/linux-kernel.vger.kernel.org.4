Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBB36623EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjAILPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjAILPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:15:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9FF14D0B;
        Mon,  9 Jan 2023 03:15:07 -0800 (PST)
Date:   Mon, 09 Jan 2023 11:15:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673262905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1QiYnqduO8UGXfUzsm/9IZigCU7WGnvIarGYqNxeNEg=;
        b=IKFx9xNT9bmgJg4a0q8wlQoERL+l4ucL9hblOryWz2Shca8s9tD+7GZWH5EkVqAV5W/hYV
        PkZudL7CTQD8bHcmAlhoMeCPRcq6E1IRQk7vkT1N9EX61Z8YqVR3a3Eqv/tJtlpHsoaOY/
        6q38R0kFOC5gcfxrq4KjtvHyB8r7AA0Yz+85UTxubkW4xsAbBjfDKxY1SPqPbFeHnmZa9K
        pCtswQi/tOAh8fweTArZt7jumKLOCiPpq2ETsmxcl2QlcRvYl4KKA1k9t/wC/W5zzApICq
        0YG/DxOz3W3ZFhu0GKQUCnxvdgkZJvUKixk/wdWjKyLJ2K6A0QNAuiTNbISxzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673262905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1QiYnqduO8UGXfUzsm/9IZigCU7WGnvIarGYqNxeNEg=;
        b=uhQ94FzweVVa3VOeCgW9P0xvtX9QqTfJeZRi4PI5ZK/x5vrZtVwxp3rtig8y4dr1Rj8MrG
        blLO+BhrhzG04GDQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/msr: Add Emerald Rapids
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230106160449.3566477-3-kan.liang@linux.intel.com>
References: <20230106160449.3566477-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167326290498.4906.8201130223514026003.tip-bot2@tip-bot2>
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

Commit-ID:     69ced4160969025821f2999ff92163ed26568f1c
Gitweb:        https://git.kernel.org/tip/69ced4160969025821f2999ff92163ed26568f1c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 06 Jan 2023 08:04:48 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:00:52 +01:00

perf/x86/msr: Add Emerald Rapids

The same as Sapphire Rapids, the SMI_COUNT MSR is also supported on
Emerald Rapids. Add Emerald Rapids model.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230106160449.3566477-3-kan.liang@linux.intel.com
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 074150d..c65d890 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -69,6 +69,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+	case INTEL_FAM6_EMERALDRAPIDS_X:
 
 	case INTEL_FAM6_ATOM_SILVERMONT:
 	case INTEL_FAM6_ATOM_SILVERMONT_D:
