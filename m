Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0196E671C06
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjARM0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjARMZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:25:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E316921D;
        Wed, 18 Jan 2023 03:45:31 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:45:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674042329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jslfW1OvRCt7/DfRxprNQorH2whL+UX/wx6UAWNvckg=;
        b=pSWNJCKkIX3rfnOWIPOExnunMXHnTIZMQ9kKUJ8ZW8wmrm/wHvyogFLsLZIzdIHwOk6oU/
        Jmbbtxr0vXIFwYliXFVeyTYYfRc167lA+VKyI+XiHc2GtrlhI/hVCEyyrjTtxoAeTfloNn
        wY4NXFezrBFuJlox9Zrfz4r/v8ozWd3gpajGnO2ej2h9wjXc8LTU88RdMIEY/azfOCgdx+
        1h1BbnPZK1q6erd2cs16DzwdZxAMyBSq40yafjb4qShOoJVxTc3fh01l1A7rmKyumHk3Wf
        DsvNR9yAt1SvspjeD7FXtTrQVNyk0zwUPrmwae6PyF4S8mKakC1A1ijdLIIEvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674042329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jslfW1OvRCt7/DfRxprNQorH2whL+UX/wx6UAWNvckg=;
        b=bbmYQnNTuREVnzhR2PHQGQz7z/iYGG9cMJmFlCo1NGbEIc4eik5GpyoryWyrQJQiFvDA44
        8vTRoGVkyV4wL+BA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Add Emerald Rapids
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230106160449.3566477-1-kan.liang@linux.intel.com>
References: <20230106160449.3566477-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167404232910.4906.13341675837800056015.tip-bot2@tip-bot2>
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

Commit-ID:     6795e558e9cc6123c24e2100a2ebe88e58a792bc
Gitweb:        https://git.kernel.org/tip/6795e558e9cc6123c24e2100a2ebe88e58a792bc
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 06 Jan 2023 08:04:46 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 12:42:49 +01:00

perf/x86/intel: Add Emerald Rapids

>From core PMU's perspective, Emerald Rapids is the same as the Sapphire
Rapids. The only difference is the event list, which will be
supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230106160449.3566477-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dfd2c12..bafdc2b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6339,6 +6339,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+	case INTEL_FAM6_EMERALDRAPIDS_X:
 		pmem = true;
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(hw_cache_event_ids));
