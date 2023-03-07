Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FE96AF915
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCGWmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCGWmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:42:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8328E067;
        Tue,  7 Mar 2023 14:41:34 -0800 (PST)
Date:   Tue, 07 Mar 2023 22:41:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678228891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Xiq36lhSlNiseP0WTmMpu68gwuLw9OrGsva/Do0jn4=;
        b=ldaN9TcITf4hIAJ7xEz12w+jU30flaYXGCExiBTRExzmPrZ/UFfueItvZCjWbDAhx5RyEt
        /fQL10hkqC+XP1kRJptGWkhkrsV3ca8yWBxCfaJ20J3gAOmf8T3doHEXLwoNUqVxdYunlQ
        xkgjtZ734Ef/kqK1NFZJOb0klOBZN5u0L/1fONRNgCVaxhf4uEi0ut6smcOdymUVBzCqqe
        GS7RvVkWH8y+EbhygC+FuA7sdzytPSSXoCcOfJw0R6Wa2GpbimWj819QtFCYlCRsf+jSNs
        IkfgqG7EZvR1zrFaig7aWT5pjdy6/iSWf2/qqp4xB9fTNQSvEgd+btaDXoK4/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678228891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Xiq36lhSlNiseP0WTmMpu68gwuLw9OrGsva/Do0jn4=;
        b=V6dR8z9obSteUh/NbbQrC0dgxSVsmvajF/8qbrcXyPwkqYSPMCPmp/B2MREh3wosJkpEI3
        R0p7yICuer/T0SAg==
From:   "tip-bot2 for Terry Bowman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Update AMD leaf Fn80000001
Cc:     Terry Bowman <terry.bowman@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Feng Tang <feng.tang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230206141832.4162264-3-terry.bowman@amd.com>
References: <20230206141832.4162264-3-terry.bowman@amd.com>
MIME-Version: 1.0
Message-ID: <167822889065.5837.6609204421153241300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     ce22e4346ff5c2f2ce6b6a43b16d336c5c6df245
Gitweb:        https://git.kernel.org/tip/ce22e4346ff5c2f2ce6b6a43b16d336c5c6df245
Author:        Terry Bowman <terry.bowman@amd.com>
AuthorDate:    Mon, 06 Feb 2023 08:18:31 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Mar 2023 23:29:07 +01:00

tools/x86/kcpuid: Update AMD leaf Fn80000001

Add missing features to sub-leafs EAX, ECX, and EDX of 'Extended
Processor Signature and Feature Bits' leaf Fn80000001.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Link: https://lore.kernel.org/r/20230206141832.4162264-3-terry.bowman@amd.com
---
 tools/arch/x86/kcpuid/cpuid.csv | 57 ++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 9914bdf..e0c25b7 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -340,19 +340,70 @@
 # According to SDM
 # 40000000H - 4FFFFFFFH is invalid range
 
-
 # Leaf 80000001H
 # Extended Processor Signature and Feature Bits
 
+0x80000001,    0,  EAX,  27:20, extfamily, Extended family
+0x80000001,    0,  EAX,  19:16, extmodel, Extended model
+0x80000001,    0,  EAX,   11:8, basefamily, Description of Family
+0x80000001,    0,  EAX,   11:8, basemodel, Model numbers vary with product
+0x80000001,    0,  EAX,    3:0, stepping, Processor stepping (revision) for a specific model
+
+0x80000001,    0,  EBX,  31:28, pkgtype, Specifies the package type
+
 0x80000001,    0,  ECX,      0, lahf_lm, LAHF/SAHF available in 64-bit mode
+0x80000001,    0,  ECX,      1, cmplegacy, Core multi-processing legacy mode
+0x80000001,    0,  ECX,      2, svm, Indicates support for: VMRUN, VMLOAD, VMSAVE, CLGI, VMMCALL, and INVLPGA
+0x80000001,    0,  ECX,      3, extapicspace, Extended APIC register space
+0x80000001,    0,  ECX,      4, altmovecr8, Indicates support for LOCK MOV CR0 means MOV CR8
 0x80000001,    0,  ECX,      5, lzcnt, LZCNT
+0x80000001,    0,  ECX,      6, sse4a, EXTRQ, INSERTQ, MOVNTSS, and MOVNTSD instruction support
+0x80000001,    0,  ECX,      7, misalignsse, Misaligned SSE Mode
 0x80000001,    0,  ECX,      8, prefetchw, PREFETCHW
-
+0x80000001,    0,  ECX,      9, osvw, OS Visible Work-around support
+0x80000001,    0,  ECX,     10, ibs, Instruction Based Sampling
+0x80000001,    0,  ECX,     11, xop, Extended operation support
+0x80000001,    0,  ECX,     12, skinit, SKINIT and STGI support
+0x80000001,    0,  ECX,     13, wdt, Watchdog timer support
+0x80000001,    0,  ECX,     15, lwp, Lightweight profiling support
+0x80000001,    0,  ECX,     16, fma4, Four-operand FMA instruction support
+0x80000001,    0,  ECX,     17, tce, Translation cache extension
+0x80000001,    0,  ECX,     22, TopologyExtensions, Indicates support for Core::X86::Cpuid::CachePropEax0 and Core::X86::Cpuid::ExtApicId
+0x80000001,    0,  ECX,     23, perfctrextcore, Indicates support for Core::X86::Msr::PERF_CTL0 - 5 and Core::X86::Msr::PERF_CTR
+0x80000001,    0,  ECX,     24, perfctrextdf, Indicates support for Core::X86::Msr::DF_PERF_CTL and Core::X86::Msr::DF_PERF_CTR
+0x80000001,    0,  ECX,     26, databreakpointextension, Indicates data breakpoint support for Core::X86::Msr::DR0_ADDR_MASK, Core::X86::Msr::DR1_ADDR_MASK, Core::X86::Msr::DR2_ADDR_MASK and Core::X86::Msr::DR3_ADDR_MASK
+0x80000001,    0,  ECX,     27, perftsc, Performance time-stamp counter supported
+0x80000001,    0,  ECX,     28, perfctrextllc, Indicates support for L3 performance counter extensions
+0x80000001,    0,  ECX,     29, mwaitextended, MWAITX and MONITORX capability is supported
+0x80000001,    0,  ECX,     30, admskextn, Indicates support for address mask extension (to 32 bits and to all 4 DRs) for instruction breakpoints
+
+0x80000001,    0,  EDX,      0, fpu, x87 floating point unit on-chip
+0x80000001,    0,  EDX,      1, vme, Virtual-mode enhancements
+0x80000001,    0,  EDX,      2, de, Debugging extensions, IO breakpoints, CR4.DE
+0x80000001,    0,  EDX,      3, pse, Page-size extensions (4 MB pages)
+0x80000001,    0,  EDX,      4, tsc, Time stamp counter, RDTSC/RDTSCP instructions, CR4.TSD
+0x80000001,    0,  EDX,      5, msr, Model-specific registers (MSRs), with RDMSR and WRMSR instructions
+0x80000001,    0,  EDX,      6, pae, Physical-address extensions (PAE)
+0x80000001,    0,  EDX,      7, mce, Machine Check Exception, CR4.MCE
+0x80000001,    0,  EDX,      8, cmpxchg8b, CMPXCHG8B instruction
+0x80000001,    0,  EDX,      9, apic, advanced programmable interrupt controller (APIC) exists and is enabled
 0x80000001,    0,  EDX,     11, sysret, SYSCALL/SYSRET supported
+0x80000001,    0,  EDX,     12, mtrr, Memory-type range registers
+0x80000001,    0,  EDX,     13, pge, Page global extension, CR4.PGE
+0x80000001,    0,  EDX,     14, mca, Machine check architecture, MCG_CAP
+0x80000001,    0,  EDX,     15, cmov, Conditional move instructions, CMOV, FCOMI, FCMOV
+0x80000001,    0,  EDX,     16, pat, Page attribute table
+0x80000001,    0,  EDX,     17, pse36, Page-size extensions
 0x80000001,    0,  EDX,     20, exec_dis, Execute Disable Bit available
+0x80000001,    0,  EDX,     22, mmxext, AMD extensions to MMX instructions
+0x80000001,    0,  EDX,     23, mmx, MMX instructions
+0x80000001,    0,  EDX,     24, fxsr, FXSAVE and FXRSTOR instructions
+0x80000001,    0,  EDX,     25, ffxsr, FXSAVE and FXRSTOR instruction optimizations
 0x80000001,    0,  EDX,     26, 1gb_page, 1GB page supported
 0x80000001,    0,  EDX,     27, rdtscp, RDTSCP and IA32_TSC_AUX are available
-#0x80000001,    0,  EDX,     29, 64b, 64b Architecture supported
+0x80000001,    0,  EDX,     29, lm, 64b Architecture supported
+0x80000001,    0,  EDX,     30, threednowext, AMD extensions to 3DNow! instructions
+0x80000001,    0,  EDX,     31, threednow, 3DNow! instructions
 
 # Leaf 80000002H/80000003H/80000004H
 # Processor Brand String
