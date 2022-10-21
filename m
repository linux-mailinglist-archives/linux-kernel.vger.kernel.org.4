Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D88607D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJURAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJURAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:00:02 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E851A2C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:59:52 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p3-20020a170902e74300b0018546b77dccso2003175plf.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPzkRYiEhEJdjJcMQc6JBwHg+TKgr2BSOIUTw0Esdx8=;
        b=Ve1rHl0wvmEV+BaAo+AZbIjJY+aKHDudtiZg5pxgxHHbv7Q0LZBBxX+1Yiw80ft0dw
         oY/2D4LjoidfZcWSyCzI2syNgkKzsj2IAzeJr1OOW80f5ZT9JcFnjInJbv86ng3khx20
         KbFmr0M4xkf8SFMrlNv8cmgZ3FNM6AibVN1EU5h9lB8rsHb3F8T/A+W+fpLz+ZsHw81i
         EqP77QJWylrgiUEa9miAw3OSBdvannh2tWWi/8dIc8XARg65nbUBGtRcwF5YFIcY5R/3
         aeBM1Z6vjh/F7UxPwOMWf57HtQLAVM3g5gKG/M2jB0nONJynwHMwTpmuhazhaV3UGr52
         VY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPzkRYiEhEJdjJcMQc6JBwHg+TKgr2BSOIUTw0Esdx8=;
        b=CrqoR3C7URS7CY7DshfBCb6fnTck3Km94grg1KFSxAOFBTO9v+HX6ApbO1Eqci+AGl
         9cW/hLZPVdsPmN9XRQK3fMTd+VL16ylrABx+yadx/Fyw1ET0srM99d/QvtZWZ+oAgHaq
         W8OvtFcsJ5HkeO+015SETRoxwCsNpeIgQVs9PQrinSCQwumrNxS5BuSu1PPAmZO2gD0k
         67jQBAeszRgnJWSIwU0BuTwnCUM64JGRmHHjiQEyOc3w7hcfW9yA6YuUuJM6fX0RnwH1
         idqq+uokPkv29EuZqaS1QLCWOfQRHw5VjVFjP0u6OuYse6KmL14VadguhrxtF5lHvzf5
         wAiQ==
X-Gm-Message-State: ACrzQf0FQBbxVb3qlb0v3aRCw1FhwxGlABINC87BfKbAxypJpQ0H8xgc
        y+pKy0x1jYxN4Ym3vzASIWcMa91Im1AGYJScBloTrUAWSAvuLdDNUINYuE8EZz7vwQc/qiEK7il
        99Lrsp9oMZDttffXBlkDzjQ0FqNAohLfYB5E1mUK1hfXvfKConv7yaglS+kKYh98XPYxZMk17N2
        MnIkymrZc=
X-Google-Smtp-Source: AMsMyM7NCrLMS8GdS8uHY/f+MxHXxD95CbgBq+2SDTqbQy1u+eMm83WwjL2+OgnooK9v60giRJXbsFMQhPUd5Q3kvw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:ec83:b0:17c:afb3:d1ec with
 SMTP id x3-20020a170902ec8300b0017cafb3d1ecmr20014781plg.172.1666371592336;
 Fri, 21 Oct 2022 09:59:52 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:59:41 +0000
In-Reply-To: <20221021165943.1968044-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221021165943.1968044-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021165943.1968044-3-dionnaglaze@google.com>
Subject: [PATCH v3 2/4] x86/sev: Change snp_guest_issue_request's fw_err
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev.h |  4 ++--
 arch/x86/kernel/sev.c      | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ebc271bb6d8e..8ebd78b6a57c 100644
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
+					  unsigned long *exitinfo2)
 {
 	return -ENOTTY;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a428c62330d3..5a402df7549e 100644
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
@@ -2218,9 +2221,11 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
 			input->data_npages = ghcb_get_rbx(ghcb);
 
-		*fw_err = ghcb->save.sw_exit_info_2;
+		*exitinfo2 = ghcb->save.sw_exit_info_2;
 
 		ret = -EIO;
+	} else {
+		*exitinfo2 = 0;
 	}
 
 e_put:
-- 
2.38.0.135.g90850a2211-goog

