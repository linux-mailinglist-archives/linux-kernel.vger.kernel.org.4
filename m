Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674D06450AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiLGBCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLGBCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:02:32 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8540B4F18B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:02:30 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m2-20020a17090a730200b0021020cce6adso18762pjk.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 17:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMGURl9LxXOJnwuiD/Ha/hCLoLpmM+oX4OEPqCyeymM=;
        b=UnmJAc0+Og3g47jm5MGaU3e4YuK2OhTwtsGRAnE+9pvMlfCuaTzH7EZE7WcSBRX0Wh
         AKLocDxsjvMLxJJkLhsGKnNDEx1JQWlzXUWnR61gNweuPVmV1CzHsx4+uUV4/OnyJO0s
         MLMNsP1LAQA8Cxn+sBx0w9M5RouMTpSjk21NvueI3YPQMpCHuGvJXnlp2rZDFYP8VeTz
         Mqlj1ni5AQ4UNXQadNqMHpmCXmZKiEN3nBvCualsOb/PBMliLpe4hOxRrudAeL6vX6VC
         mBp0DxpFy1jKjHmy29BB1UOiMIxKMG3eJJV9hTsQVYNV/kSHCmoPNYJ8sb1zMOKoZqC0
         CHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMGURl9LxXOJnwuiD/Ha/hCLoLpmM+oX4OEPqCyeymM=;
        b=NGYcBwwl3uP1mblqrSLOI9YD75O0YYi/9aXcQqaw3ugvP9DhCI8JBTFHI4iB/4vsMu
         QtlY8WHI2+0/LjAhhw6NZ5ITcBOgWlw5q4KnUIGowKcrijsTer+HoQRA4viQh1sEgRte
         pfmfWl2ZBnk+3L1xw1Lo5SEMRRVuXeAk+PEOzGYsoFq107p0+lfyv3W5XVugiYy3V9U9
         GWzwboppmdctthGlGNbsYHmai0xROo1Egn1puO/n0Q5Rro8OnY10aihp3zDUN8FxmfSE
         4z8kQrAoorGopLu3DJ7ml8gWeRygnv/ywWYnvVKSMCqxMd9MqHHxJAxN1LTplK+owKMs
         6qCQ==
X-Gm-Message-State: ANoB5plyYI2Mw8cp1xetcmMyjKejvLCzTBEjugV0AfLCsWxvtpPQ9gaO
        t+ytMtj4sSVoiIyMf/nHSTdYXPF+f1UAZ4bT4n0LeabogNa6GvtttRCifY1JtVA8b3Kkw2yrE0E
        kF7tZCxJZ5h+hXx8QrXiwXCLXDruQR/Ffiq8AporzRAgmBICydrXuIK0DRglvvJ2SUgdgu/YZGm
        QzgyWdq9k=
X-Google-Smtp-Source: AA0mqf6qnUoKXk5tirgCkojnoRDceiVqwr4B00hVzZ9eumlk28+jh+JCxJkTyE8o26JIiCFIwgzT1AOM9ltZJKSC5g==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a65:6385:0:b0:478:e68b:7969 with SMTP
 id h5-20020a656385000000b00478e68b7969mr3710242pgv.574.1670374949949; Tue, 06
 Dec 2022 17:02:29 -0800 (PST)
Date:   Wed,  7 Dec 2022 01:02:08 +0000
In-Reply-To: <20221207010210.2563293-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221207010210.2563293-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207010210.2563293-3-dionnaglaze@google.com>
Subject: [PATCH v9 2/4] x86/sev: Change snp_guest_issue_request's fw_err
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

The firmware might not even be called, so the call is bookended with
the no firmware call error and clearing the error.

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
Reviewed-by: Tom Lendacky <Thomas.Lendacky@amd.com>
Reviewed-by: Borislav Petkov <bp@alien8.de>
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
2.39.0.rc0.267.gcb52ba06e7-goog

