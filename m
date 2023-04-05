Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B2A6D85DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjDESTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjDESTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:19:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD36E9F;
        Wed,  5 Apr 2023 11:19:43 -0700 (PDT)
Date:   Wed, 05 Apr 2023 18:19:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680718780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMui9Fr9c1VBh2UjQht4/dyIn0riU7J1nVklvg3Cw5A=;
        b=xVTZ/4X/7P00O6yJ7TC4HgOkya7axkeIWGgvbznKaxdiKoreF/Twf43eEGc+cTKkwmoBUP
        WhPXXV4Ovxi2KBwFC/09IEHRnrJZLdVua/Jl+D7CXbZmpUyXQj2mqZL0uVBUDC2G19XM6m
        zWZHX3Nsw1Mns1ITjLUB4O6/Z34XzEzmPVNM9i9JJGZapi5/x/X4QhI3ncO5WYmVEqkmUe
        0+7FlwyPjt7XeFn2KBpTspFjT/jrdcMm58TZMnwpFGYk/k4emrgnP551oeCbyL4c93uuYh
        NK1mdY90a7RbJYTPE7cg1ZKd1iBoXEX1TjP61nKCZa0Wfqfb+mkKoPHgZyA5Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680718780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMui9Fr9c1VBh2UjQht4/dyIn0riU7J1nVklvg3Cw5A=;
        b=eJ9EPoM12Ws4wQYukXXGEfpZPNnwWBTth1oS/MoA06YhPuGv9xnKu7iN1deOrIkKmkzFYK
        /lXjmkVOHl5WjHBQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add Xeon Emerald Rapids to list of CPUs that
 support PPIN
Cc:     Tony Luck <tony.luck@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230404212124.428118-1-tony.luck@intel.com>
References: <20230404212124.428118-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <168071877680.404.6240417347613164470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     36168bc061b4368ad19e82b06a6463c95d3bb9a7
Gitweb:        https://git.kernel.org/tip/36168bc061b4368ad19e82b06a6463c95d3bb9a7
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 04 Apr 2023 14:21:24 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Apr 2023 20:01:52 +02:00

x86/cpu: Add Xeon Emerald Rapids to list of CPUs that support PPIN

This should be the last addition to this table. Future CPUs will
enumerate PPIN support using CPUID.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230404212124.428118-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8cd4126..80710a6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -121,6 +121,7 @@ static const struct x86_cpu_id ppin_cpuids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, &ppin_info[X86_VENDOR_INTEL]),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D, &ppin_info[X86_VENDOR_INTEL]),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, &ppin_info[X86_VENDOR_INTEL]),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, &ppin_info[X86_VENDOR_INTEL]),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL, &ppin_info[X86_VENDOR_INTEL]),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM, &ppin_info[X86_VENDOR_INTEL]),
 
