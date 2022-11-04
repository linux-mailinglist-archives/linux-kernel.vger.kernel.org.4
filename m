Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36761A206
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiKDUQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiKDUQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:16:32 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE34045EDE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:16:31 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id f189-20020a6238c6000000b0056e3400fdc0so2941197pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw7Ul5f27jSNcm6KBKc7sXnYAWm8yJrh7zk3qUYUCYY=;
        b=Il1wC+xW4V9ldzvEHntjxeveeNBukzQwgnx6gzRlwbIvwfuGMJVlqiruprMfTz88Dd
         xvy5YV5RGoMrccjmm31d0Qom8iTNLwQpVpZ98/re1X218bG9GO+98pG2U5CPoH4U8Eqy
         FDoJjtaLe1MXJv3LhC0UumN5tvBzw44DeHfxvRkE7KXEP+LYLXb096fcc5UFs2x8zRkU
         LBUTP6TCP2mcB4fQEVYnxM6k6iUgpW016AazEVmWLE9D5DqriUS5/LoH3OIBmvSVvp6X
         A9CF6Jf7YRsPzoXPkhcnwgFrHIwKgc379OqRVqTghG2vfDiAd3661KiYlMyGOpUZ02CI
         xgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw7Ul5f27jSNcm6KBKc7sXnYAWm8yJrh7zk3qUYUCYY=;
        b=sOA/xoa5azVvW0MzICnIn1pT+FKX/ioJbGrM3CnxUubnrM8PGipJl5vHd6D7GQf3gq
         yJSGH+yqTD/n03CROgr50O/5J6A9GXf/pQhIg8ZNwfVWxjH6vzSRoRApx3wwiol0yRdD
         m4duMJGLZ56RZ5rtLFjX8q85CyYSgXsNNz3ltbdAWT2abJXC+DgmSwP74EPbA3rB53Lx
         ttE0PKm1ntU7Mhw0hZX8ijHFpKdFwvvBq9yzF/3SuqwHLPekIxz0FcFLcM82jNJCxMfz
         CoerRqV41bSN6h1VPrWJfU5esjPfDfptB1U6ULtORDapZeoHrwj6tY9FDpB1tPhAqyQ2
         JbTQ==
X-Gm-Message-State: ACrzQf3Bh1ik2CCwZg9mgNYAmkw2sfhaE6/+KOSDZVCe9jS5Rm9NiWeM
        A6/j6PA9t74ONXP86T9SLaG4UI2y/igtHYh6l+cu7bjjXJ/9eQawe4Q/JDoon3KzpomszcL9t3b
        LDduP9zGJuyKffFZ0IRu9ookTUEzxiqznTp7f2YppjlfD73JhjyH9oJXUQGKGofO4UlOuiiYGjH
        0gq8RdLd0=
X-Google-Smtp-Source: AMsMyM4GgyBoekcX1bBRDD+sWG0dLd823DITt4nxbL4V22LF2TrKZ3AJxz/vhte1Yzl335VWqptHYiH9KRZW7MYdFw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:df8e:b0:213:8283:ac7f with
 SMTP id p14-20020a17090adf8e00b002138283ac7fmr356850pjv.220.1667592991086;
 Fri, 04 Nov 2022 13:16:31 -0700 (PDT)
Date:   Fri,  4 Nov 2022 20:16:14 +0000
In-Reply-To: <20221104201616.2268815-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221104201616.2268815-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104201616.2268815-3-dionnaglaze@google.com>
Subject: [PATCH v7 2/4] x86/sev: Change snp_guest_issue_request's fw_err
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GHCB specification declares that the firmware error value for a
guest request will be stored in the lower 32 bits of EXIT_INFO_2.
The upper 32 bits are for the VMM's own error code. The fw_err argument
is thus a misnomer, and callers will need access to all 64 bits.

The type of unsigned long also causes problems, since sw_exit_info2 is
u64 (unsigned long long) vs the argument's previous unsigned long*.
The signature change requires the follow-up change to
drivers/virt/coco/sev-guest to use the new expected type in order to
compile.

The firmware might not even be called, so we bookend the call with the
no firmware call error and clearing the error.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Michael Sterritt <sterritt@google.com>

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev.h |  4 ++--
 arch/x86/kernel/sev.c      | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ebc271bb6d8e..05de34d10d89 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -196,7 +196,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -217,7 +217,7 @@ static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
 static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
-					  unsigned long *fw_err)
+					  u64 *exitinfo2)
 {
 	return -ENOTTY;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a428c62330d3..148f17cb07b5 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -22,6 +22,7 @@
 #include <linux/efi.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/psp-sev.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -2175,7 +2176,7 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
@@ -2186,9 +2187,11 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-	if (!fw_err)
+	if (!exitinfo2)
 		return -EINVAL;
 
+	*exitinfo2 = SEV_RET_NO_FW_CALL;
+
 	/*
 	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
 	 * a per-CPU GHCB.
@@ -2212,14 +2215,13 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (ret)
 		goto e_put;
 
+	*exitinfo2 = ghcb->save.sw_exit_info_2;
 	if (ghcb->save.sw_exit_info_2) {
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
 		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
 			input->data_npages = ghcb_get_rbx(ghcb);
 
-		*fw_err = ghcb->save.sw_exit_info_2;
-
 		ret = -EIO;
 	}
 
-- 
2.38.1.431.g37b22c650d-goog

