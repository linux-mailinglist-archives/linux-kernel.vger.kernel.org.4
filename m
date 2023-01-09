Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8A0662C11
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbjAIRDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbjAIRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:02:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6805E41003;
        Mon,  9 Jan 2023 09:02:12 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:02:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673283729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAy6sXqdrKzuX855d4/xvEbJ+w+/B0tSZLNMp00X6CA=;
        b=vjGY9/mgAwC3Cj1A7Gf0/S16y2ADBhLEm+TGmXhU69cEdc0qIht+wONZ6pjx6VPWGh4Ij5
        1HYBtZld3w/nCIFnGfaca/z1jGtknV1KBtPVXLhAwrAbOJNhCTL44RiVfwmMf4ZT2cchUS
        2FVHLVskIy2armaJiALo+/V+Z0Qv/lyDf5ZsF6eMg3y0UQi0lVFDWjb9a82AHrxWqdtJkt
        Kz27oaAN6IQN6RF7j6y6F72UY/5fdJrw2A9scrJVOFjBGKph6tWTbp8g9RPXHSSxS4jSXd
        1AtJ9OHkXt3AUchfBgCKG+SbgQN7h4vHhzP+cSJU0Bgtm6904dTE83LukcICJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673283729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAy6sXqdrKzuX855d4/xvEbJ+w+/B0tSZLNMp00X6CA=;
        b=klIGM9q117WJEVRh4pao1EkNTq+lPwTuZCNyEcQD5zu1v19KsYhWO7YnMESvHhmw/v21uY
        67ew8vp6BjBPa2DA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpufeatures: Add Architectural PerfMon Extension bit
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230104201349.1451191-4-kan.liang@linux.intel.com>
References: <20230104201349.1451191-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167328372884.4906.4718586705719688817.tip-bot2@tip-bot2>
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

Commit-ID:     a018d2e3d4b1abc4a3cb64415c5d204fc5d2eafd
Gitweb:        https://git.kernel.org/tip/a018d2e3d4b1abc4a3cb64415c5d204fc5d2eafd
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 Jan 2023 12:13:44 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:22:08 +01:00

x86/cpufeatures: Add Architectural PerfMon Extension bit

CPUID.(EAX=07H, ECX=1):EAX[8] indicates whether the Architectural
PerfMon Extension leaf (CPUID leaf 23) is supported.

The "X86_FEATURE_..., word 12" is already mirrored from CPUID
"0x00000007:1 (EAX)". Add X86_FEATURE_ARCH_PERFMON_EXT under the
"word 12" section.

The new Architectural PerfMon Extension leaf (CPUID leaf 23) will be
supported in the perf_events subsystem later.

The feature will not appear in /proc/cpuinfo.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230104201349.1451191-4-kan.liang@linux.intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6101247..b64555b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -312,6 +312,7 @@
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
+#define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* "" Intel Architectural PerfMon Extension */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 
