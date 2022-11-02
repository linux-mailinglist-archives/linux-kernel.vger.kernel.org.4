Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D8E6165EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiKBPTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiKBPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:18:55 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA6E10555
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:18:51 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r9-20020a17090a2e8900b0021409b8020cso1781684pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMHoFnNXGFOnGHAP/VNY6ptVYxXseOMIKoAz5BRGvX4=;
        b=F1neGZJQJh+XcQN1V567FwoQTGgKI1RIIPQZSlGulHrcZq+/ZMI+51iigU62PFj/ip
         H8Efch/vDH4ZxXm4FCPOWZExPOruNxBxCsCRQWWs7pDqhFvvSwW735RS5jPkEF5GvbL4
         vKSzR7Yc553v2kfoPiv0f0zNWbZTs9JGIBWO/h2mVvNDTS9WFBXcpUQztY1lWd0xaKF9
         2M4fnD3LL85cFvUCeHDpdRXoGpK57Sg3NyelnhiTf3aPN5Cpr+XGEI1d32eBsNBAxpDJ
         ZAvIDm4/IizE+6n03yO2rPMw/B+MVfbMo4H4BwFobxq6IA4NtvnE6BqYZXfXU6P0x3G9
         a8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMHoFnNXGFOnGHAP/VNY6ptVYxXseOMIKoAz5BRGvX4=;
        b=cJu6DB+dTqpGU55T2rTpgdxLyvZIIJ+/k6vFXPwyhcSr0IFTpZi/uk5QUnFiQA/YN8
         Uvk2VUk5uvKX+KoXQyJeAAhUL+tp8paclTdJzIajtzXJUZwWJHPXrmTzsYn0yvNhhvGu
         2Epg6lebCACmSFJE6krVl/2n25XR1oBb+G6PxjmRdqFwNHnjrmEMtimxBNG5xBEiYy+b
         6NDBxXumG6r4oOtwHt//HSbp3poyxWGTKy26T8cxq6QSEq3PfPln/eesJ+tfcC3bnzhU
         HEf/tHN2Re7bavaQmGjXsqFLf30kNpfZQ89ug+sBzrCn33dvd+HkI1uLCsK4NxXLl2MI
         8lww==
X-Gm-Message-State: ACrzQf2X15tiUWcPI/LSsOVaRZ6N2LizYiTIj+8xm+NbzxAFN5kEKPx0
        0ED9BrmRXxMqzZ1wQbPa6bmAkNDToAYxQ/wduDlpiQWkNyta14FGePMiQm+pBQbsh6D7zRXiYpQ
        i7x4Uos2jbM+PzrP+FxmRvb82x4QCXmQT2v5CSCy+izs7LAMPb46cBNuCPZ5xoT3ZF5QNw67vEI
        JRZ1upvbg=
X-Google-Smtp-Source: AMsMyM6vk95Uz/sBYHUOGAI/AisQo7tP6idqrtg6MJeDrRbjNxrgRBI/DmhvC20543+P6v0+IBIxf/dPPbQEhal+ww==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:903:32ce:b0:187:143f:4c4d with
 SMTP id i14-20020a17090332ce00b00187143f4c4dmr20605731plr.135.1667402330963;
 Wed, 02 Nov 2022 08:18:50 -0700 (PDT)
Date:   Wed,  2 Nov 2022 15:18:34 +0000
In-Reply-To: <20221102151836.1310509-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221102151836.1310509-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102151836.1310509-3-dionnaglaze@google.com>
Subject: [PATCH v5 2/4] x86/sev: Change snp_guest_issue_request's fw_err
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
2.38.1.273.g43a17bfeac-goog

