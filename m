Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055D46663D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjAKTkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjAKTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:40:08 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62FA14037
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:06 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id y37-20020a634b25000000b004b1d90ea947so5023497pga.15
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgJJjf3XhaPlMIkedvk8DADSWPbDqjPvpDq99Cffqu0=;
        b=ha/GpuIffF2aT3mhbf29pv+Ym+Was4HCFTAuAmQDlgBVlIamCt+tSl9DvjtGywyInX
         Xb7HOyujW5KQA0LiKUpE3Iclpq4JrPXm9wUBiPFO/TPrUUhX4CrfaJP5VwSyUK1pT84N
         5InKtJrL3tObd50tUyGbOnViU/aPxwawhw2hksh8q3WK+drkIdqAKFXkhYA/MuN4gQV7
         nVkVwgklJHLvHdb5x9yEEk2GhG74Kxpbj3w8aaH+mIGY43iaygfq4uEOAswtvZToC59G
         4p5wXBypQJ1jxHnkPn81IATCKIH/cFPfUAeJ3Sai/MV73D4BAGIKXyBA+xt7LFN+Fmod
         oCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgJJjf3XhaPlMIkedvk8DADSWPbDqjPvpDq99Cffqu0=;
        b=FRvEa8vJiySm6WdEjAdXt1O7g3eJxoMrN6zDaI90JGCMyh1/tHTMBK6vJnqohsdspE
         Y0IIvb5hb0L5qAt2rIfIUS6ibSZG7XtUAAqttozB/xnx+EnRKCQY0W2jyOCwEX7eb7Gy
         fT+dvyjwf4dzrt4/GySoZHVATvXGl3uJLIagtGOQuziImLXYJqkwq8iMEYdhU6a+FPqY
         nDRNx5qb3KL9aqSgvorR7sP6sb5SxeaV428mXcTiRlCVQ64ioT9b3HmjUPUT+IrNRMCE
         WLTMlHTRD0Pi0dTgk78caQv7HRnKNCjHsBe5rzKndOtX2FYmFO0pnQRcGe3Gi7XMHuo/
         O1sg==
X-Gm-Message-State: AFqh2kp8O9TEKQocILmIMgXZm15Bxdh/ch/FVrTX+luFewscq4ceDyDE
        QYGyvxWi4F/5O2QA+FM73YT0RgzVMTNi37ijSgG/AoXa3RlqchncPtXmgBbgkWP37jo76VD5K+g
        XWxr0GYnv+HtcDmGwys6TeZCHv6rgLOtBduwg7XITxF6z8ZRB8O1AGjWCM/GwlK3ZwqwsxMKhif
        hyWNqyY+0=
X-Google-Smtp-Source: AMrXdXuikOzUTMv9Br9/QRekPPGn/a7pAzNRpV2qQ0EkhLBBv4sw5QYcprpz5S6EiWS+MtWsGfqvCec9a18YSlenjw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:8b0b:b0:219:5a12:e1eb with
 SMTP id y11-20020a17090a8b0b00b002195a12e1ebmr7312208pjn.88.1673466006301;
 Wed, 11 Jan 2023 11:40:06 -0800 (PST)
Date:   Wed, 11 Jan 2023 19:39:56 +0000
In-Reply-To: <20230111194001.1947849-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230111194001.1947849-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111194001.1947849-3-dionnaglaze@google.com>
Subject: [PATCH v11 2/7] x86/sev: Change snp_guest_issue_request's fw_err
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
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
u64 (unsigned long long) vs the argument's unsigned long*. A temporary
typedef is introduced for the err argument so it can be changed in a
later patch more cleanly.

The firmware might not even be called, so the call is bookended with
the no firmware call error and clearing the error.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Michael Sterritt <sterritt@google.com>

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
Reviewed-by: Tom Lendacky <Thomas.Lendacky@amd.com>
Reviewed-by: Borislav Petkov <Borislav.Petkov@amd.com>
Reviewed-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev.h | 10 ++++++++--
 arch/x86/kernel/sev.c      | 10 ++++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ebc271bb6d8e..5b03ba18fee7 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -133,6 +133,12 @@ struct snp_secrets_page_layout {
 	u8 rsvd3[3840];
 } __packed;
 
+/*
+ * Use a type alias temporarily to cleanly change the snp_issue_guest_request
+ * signature cleanly over multiple patches.
+ */
+typedef unsigned long sev_guestreq_err_t;
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -196,7 +202,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, sev_guestreq_err_t *exitinfo2);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -217,7 +223,7 @@ static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
 static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
-					  unsigned long *fw_err)
+					  sev_guestreq_err_t *exitinfo2)
 {
 	return -ENOTTY;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 679026a640ef..d1a6092b1e03 100644
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
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, sev_guestreq_err_t *exitinfo2)
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
2.39.0.314.g84b9a713c41-goog

