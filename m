Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37C574024A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjF0Rg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjF0RgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:36:23 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B132D4A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:36:14 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f9b4a71623so47324055e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687887373; x=1690479373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drRkxJWm0mNFiWrAj9eCUAPdwYI3fs9m68bR8DWKZTM=;
        b=VH3XBEI3zVkxhUEfygCu5XLJyio+PN9zeEGfxlqTW1VijJUHLJCSnPMsiE0dCisa/z
         XRG5mJTbrKdyVNBj6ym9HP7pwWwmOcT4V+qpMB2pMPDq3EP27mCWImOC8uBwYnZ/Zuii
         Yb70MzaJ0NK5fo6i70gVaHtPDFPK/9XMlu6pLAuoIo0GvWk+Nqq5HWATi1vmmU4Pu2sl
         kIQNcmSiOPzxAg6WtgJp8zfZJD8kmVx+Arv+dCkGJah6FJIkd1asvw6c5cDfrHP1loJe
         F9cTfpWvyGBbVgRoBHU0Vw/4FM4E+7KIS9BDjracYC+f3VVZNh8PO29swlh1uwHyiJKs
         H/lw==
X-Gm-Message-State: AC+VfDxAzXhduRRPv0qWeIx/JPXxZHkGluoHx88JOEBaFjOrFt2lAy9B
        lVtWLhNsKNPbFbigyJ7FHcg=
X-Google-Smtp-Source: ACHHUZ4oXIFdvIjKHrtfD+Xt/Px+NmRSWC0vGm4/TdUbvxzL7QbHso8VOZR9HvguEJBOxrIeVJ37eQ==
X-Received: by 2002:a1c:ed0b:0:b0:3f5:39:240c with SMTP id l11-20020a1ced0b000000b003f50039240cmr12357542wmh.27.1687887373059;
        Tue, 27 Jun 2023 10:36:13 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id z12-20020a1c4c0c000000b003fa9554fb30sm7019435wmf.44.2023.06.27.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 10:36:12 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:36:10 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Message-ID: <ZJseCvXVKFHu84Sv@gmail.com>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk>
 <ZJMdKUr98H8zPSAl@gmail.com>
 <20230621173135.wiprtgzslhw5z5or@desk>
 <ZJNDRSUZuZ2L+pwo@gmail.com>
 <20230621194101.bmwesljror2yqjxx@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621194101.bmwesljror2yqjxx@desk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pawan,

On Wed, Jun 21, 2023 at 12:41:01PM -0700, Pawan Gupta wrote:
> On Wed, Jun 21, 2023 at 11:36:53AM -0700, Breno Leitao wrote:
> > If I understand where you want to go, you think we should create a
> > single patchset that creates a CONFIG_<MITIGATION> for each mitigation,
> > and move get it under CONFIG_SPECULATION_MITIGATIONS.
> 
> Yes, a single series (or a patch) that adds config for each mitigation
> would be good.

I've been working on this request, and I may need your help to validate
the wordings and dependencies (as in architecture/vendors where the
problem needs to be mitigations) for each entry.

Also, I want to make sure I am not missing anything. Here is what I have
so far. Is it in the right direction?

--
Author: Breno Leitao <leitao@debian.org>
Date:   Thu Jun 15 08:04:16 2023 -0700

    x86/bugs: Break down mitigations configurations
    
    Create an entry for each CPU mitigation under
    CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
    them at compilation time.
    
    If a mitigation is disabled at compilation time, it could be enabled at
    runtime using kernel command line arguments.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..10ea7884eddd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2649,6 +2649,100 @@ config SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
+config MITIGATE_MDS
+	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
+	depends on CPU_SUP_INTEL && X86_64
+	default y
+	help
+	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
+	  a hardware vulnerability which allows unprivileged speculative access
+	  to data which is available in various CPU internal buffer. Deeper
+	  technical information is available in the MDS specific x86 architecture
+	  section: Documentation/arch/x86/mds.rst.
+
+config MITIGATE_TAA
+	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
+	depends on CPU_SUP_INTEL && X86_64
+	default y
+	help
+	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
+	  vulnerability that allows unprivileged speculative access to data
+	  which is available in various CPU internal buffers by using
+	  asynchronous aborts within an Intel TSX transactional region.
+
+config MITIGATE_MMIO_STALE_DATA
+	bool "Mitigate MMIO Stale Data hardware bug"
+	depends on CPU_SUP_INTEL && X86_64
+	default y
+	help
+	  Enable mitigation for MMIO Stale Data hardware bugs.  Processor MMIO
+	  Stale Data Vulnerabilities are a class of memory-mapped I/O (MMIO)
+	  vulnerabilities that can expose data. The vulnerabilities require the
+	  attacker to have access to MMIO.
+
+config MITIGATE_L1TF
+	bool "Mitigate L1 Terminal Fault (L1TF) hardware bug"
+	depends on X86_64
+	default y
+	help
+	  Mitigate L1 Terminal Fault (L1TF) hardware bug. L1 Terminal Fault is a
+	  hardware vulnerability which allows unprivileged speculative access to data
+	  which is available in the Level 1 Data Cache when the page table
+	  entry controlling the virtual address.
+
+config MITIGATE_RETBLEED
+	bool "Mitigate MMIO Stale Data hardware bug"
+	default y
+	help
+	  Enable mitigation for RETBleed (Arbitrary Speculative Code Execution
+	  with Return Instructions) vulnerability.  RETBleed is a speculative
+	  execution attack which takes advantage of microarchitectural behavior
+	  in many modern microprocessors, similar to Spectre v2. An
+	  unprivileged attacker can use these flaws to bypass conventional
+	  memory security restrictions to gain read access to privileged memory
+	  that would otherwise be inaccessible.
+
+config MITIGATE_SPECTRE_V1
+	bool "Mitigate SPECTRE V1 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V1 (Bounds Check Bypass). Spectre V1 is a
+	  class of side channel attacks that takes advantage of speculative
+	  execution that bypasses conditional branch instructions used for
+	  memory access bounds check.
+
+config MITIGATE_SPECTRE_V2
+	bool "Mitigate SPECTRE V2 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V2 (Branch Target Injection). Spectre
+	  V2 is a class of side channel attacks that takes advantage of
+	  indirect branch predictors inside the processor. In Spectre variant 2
+	  attacks, the attacker can steer speculative indirect branches in the
+	  victim to gadget code by poisoning the branch target buffer of a CPU
+	  used for predicting indirect branch addresses.
+
+config MITIGATE_SRBDS
+	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
+	depends on CPU_SUP_INTEL && X86_64
+	default y
+	help
+	  Enable mitigation for Special Register Buffer Data Sampling (SRBDS).
+	  SRBDS is a hardware vulnerability that allows Microarchitectural Data
+	  Sampling (MDS) techniques to infer values returned from special
+	  register accesses. An unprivileged user can extract values returned
+	  from RDRAND and RDSEED executed on another core or sibling thread
+	  using MDS techniques.
+
+config MITIGATE_SSB
+	bool "Mitigate Speculative Store Bypass (SSB) hardware bug"
+	default y
+	help
+	  Enable mitigation for Speculative Store Bypass (SSB). SSB is a
+	  hardware security vulnerability and its exploitation takes advantage
+	  of speculative execution in a similar way to the Meltdown and Spectre
+	  security vulnerabilities.
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2b03e2ff03bb..5482cf33e56d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -270,7 +270,11 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_MDS)
 static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+#else
+static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_OFF;
+#endif
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
@@ -330,7 +334,11 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_TAA)
 static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
+#else
+static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_OFF;
+#endif
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -431,7 +439,11 @@ enum mmio_mitigations {
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
+#if IS_ENABLED(CONFIG_MITIGATE_MMIO_STALE_DATA)
 static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
+#else
+static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_OFF;
+#endif
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
@@ -580,7 +592,11 @@ enum srbds_mitigations {
 	SRBDS_MITIGATION_HYPERVISOR,
 };
 
+#if IS_ENABLED(CONFIG_MITIGATE_SRBDS)
 static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_FULL;
+#else
+static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_OFF;
+#endif
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
@@ -705,8 +721,13 @@ enum spectre_v1_mitigation {
 	SPECTRE_V1_MITIGATION_AUTO,
 };
 
+#if IS_ENABLED(CONFIG_MITIGATE_SPECTRE_V1)
 static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
 	SPECTRE_V1_MITIGATION_AUTO;
+#else
+static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
+	SPECTRE_V1_MITIGATION_NONE;
+#endif
 
 static const char * const spectre_v1_strings[] = {
 	[SPECTRE_V1_MITIGATION_NONE] = "Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers",
@@ -820,8 +841,13 @@ static const char * const retbleed_strings[] = {
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
 	RETBLEED_MITIGATION_NONE;
+#if IS_ENABLED(CONFIG_MITIGATE_RETBLEED)
 static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
 	RETBLEED_CMD_AUTO;
+#else
+static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
+	RETBLEED_CMD_OFF;
+#endif
 
 static int __ro_after_init retbleed_nosmt = false;
 
@@ -1276,7 +1302,11 @@ static void __init spec_v2_print_cond(const char *reason, bool secure)
 
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
+#if IS_ENABLED(CONFIG_MITIGATE_SPECTRE_V2)
 	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
+#else
+	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_NONE;
+#endif
 	char arg[20];
 	int ret, i;
 
@@ -1286,7 +1316,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_CMD_AUTO;
+		return cmd;
 
 	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
 		if (!match_option(arg, ret, mitigation_options[i].option))
@@ -1770,7 +1800,11 @@ static const struct {
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 {
+#if IS_ENABLED(CONFIG_MITIGATE_SSB)
 	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+#else
+	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_NONE;
+#endif
 	char arg[20];
 	int ret, i;
 
@@ -1781,7 +1815,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
 		if (ret < 0)
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			return cmd;
 
 		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
 			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
@@ -1793,7 +1827,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 
 		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
 			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			return cmd;
 		}
 	}
 
@@ -2119,7 +2153,12 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
+
+#if IS_ENABLED(CONFIG_MITIGATE_L1TF)
 enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+#else
+enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_OFF;
+#endif
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
