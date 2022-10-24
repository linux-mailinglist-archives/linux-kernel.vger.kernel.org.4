Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438C260BF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiJYAYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJYAX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:23:27 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAAA140E42
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:47:04 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id p24-20020a63f458000000b0043cd718c49dso5321307pgk.15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GW6bKm1YVuify4X/GJIm5kxchqqZUANlG9YPqARl8Y4=;
        b=GXi04bfYEXBKhCuN7uwjEYmDrIoZzYqOX2Mvi1/Sbp7GVhLP2729ISTmTNHgq0UPzD
         QdkUUp8oNaiED1z1HJmLGcsjXwRIlgWHHfNP2aQPtyKmKObqdKVA5b/8/pphKUQfxNy4
         pLKYdKUvy/a9AY38lRSlZeB74GTCNNMRqe11mTvN6Tz3X6msV3tHKGTD5n96WaKTr+fg
         KNBtBHUgWhKJb25HDSr5v10AO0ZKUgcK1mr5QQE1lpOfeVUaDjmyTHxBMdx4hXRpGVfc
         88iEq6MMZwAiixYehQff7Foc5VlkXny6vlMpCdd9ZMD65zU4wXG0DS6S7tyf/8Wcvab1
         MgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GW6bKm1YVuify4X/GJIm5kxchqqZUANlG9YPqARl8Y4=;
        b=eAEngaaO5hNWJeESoVypdfUr9D/MVN9xPOFqcMWTWGe0xkD7U7MpfflSF96ighDtH0
         EFP5KtIBSgYlwL6A/CQqCm4FOvVMaKtJACf74KVIsPmWcQO+RDaP/no0LEAtJbwgIMab
         6iPC9FCx/7kHukO0QNtUt++mstRmOWA4V+YSLONO/SJOWYBRjRYtzt9SOI4DunjDB0Fk
         Gki7lAcKI/KM++spotxKjQuCUlhIHlrPw+H9MCshKFxj2+4C+nfU4zRxHPUkr+CEgZt6
         AXwDcn2C1BS3yco/VMJI0434dijCGZ45PNhcs4Nc9ySF7DIKW5M9EUBRMFs4hST9fPB1
         BgAQ==
X-Gm-Message-State: ACrzQf0KD9wE7FIG22pF7AFxVVkHrJGNHV3zAcFoYK0vNXF54fH5xLc/
        zYKKoHhisTcFw58gYpeXKyXF5pKkGIa212c6qmumy/BirzU6Z8L+pYiBb7FLZd6PyF9aT45NT2U
        UOgKJB0517zPdF1KySaSMI5/UFWxXLIuDgyYT05BpYP/As0Gdur/J0VKP7jHXcs0WtGVdfZ5nTw
        4lHE8GdsU=
X-Google-Smtp-Source: AMsMyM5tiupo1BbgtTxfdpzLJJRXiUfxvy6iHib1yOpAlrdgL6qIDQ+O9eY82l6oNlfjnfD7dLq5cn9tugq642H4HA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90b:1e51:b0:212:d06b:b5fa with
 SMTP id pi17-20020a17090b1e5100b00212d06bb5famr21668968pjb.171.1666651623675;
 Mon, 24 Oct 2022 15:47:03 -0700 (PDT)
Date:   Mon, 24 Oct 2022 22:46:55 +0000
In-Reply-To: <20221024224657.2917482-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221024224657.2917482-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221024224657.2917482-3-dionnaglaze@google.com>
Subject: [PATCH v4 2/4] x86/sev: Change snp_guest_issue_request's fw_err
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
2.38.0.135.g90850a2211-goog

