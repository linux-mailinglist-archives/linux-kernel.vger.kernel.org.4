Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E595FDDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJMQBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMQBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:01:00 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5012EFE927
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:00:59 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id o1-20020a170902d4c100b00177f59a9889so1549758plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFIZXP+0RvRDVkccAAekEgFLUK+lQGqw03T8y+VqePQ=;
        b=MAazyoS2V7THRiFDYYrrOq38Kf4Z8t7qlDLZXLyAdEelxB2juuPZPHrgmYaXI7/l09
         cC9pivN4wW60IymPa9roTYnEkbv7Lw8k42QPDv6xI+aIwyoXgjCe5dchPx5XvtE5dazN
         NSeoxzxNxRSohb2VJoENXopTKZiZ3LGN95Cs8eRVA/feFNHmkJ547gOMu0aqiynUoAUs
         Ac6j35o9lmhM1rWlUuPtmqQhZwCD3UxlJotuiAOHxXsOY4QbNO2N6KlyXV0y9TDWZPJ1
         eisp1tLqUa8QAjs1IxZSSXTTLY169aJPJPVdF+tor5cdtnZ6WHZRXvJ9zNZ6leYmjXao
         +u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFIZXP+0RvRDVkccAAekEgFLUK+lQGqw03T8y+VqePQ=;
        b=c4XQRTK3HT63HgGsw2MWquFpWxRh9Lr7TpETBOd4bgYTtjCVnn7K7OVxRlGWUizhYt
         O/TDnNAMs+/TVBP49J91yNV/4AvWOYeSSdgkqhnX4zLv4caRS8TKMs2OG+09ttcfGyCR
         IDWgQNgkBZsdyo3nErzHABWhBttIrEBrGrjpHaTbulWClduDlmkqGQI8zhMpRrEm+g7l
         HQA3GGjt03luBjUSJ8SryLyQUxx/7WAx3fDnP7gWZrabjhc0kxWTU7wLg2iX3PQIBbgL
         u7HL0rStmuDQgsnmc8+9pxN1Xm62So627MFpVJO+JjdruoFEq122YaHYejxrq2vpXdKM
         i78w==
X-Gm-Message-State: ACrzQf2p8cDJ0/74ZcLW5O1437zxl0qvs6RlOT7ysubXiUrSH7leOPqb
        1PbyvmCup9wXIwRfwTCCqcZTv8q6D+R2pDpi+ggp3ELrcKviacbCvm6yWpuxQlGG3InPgv+zPdh
        iCRg06vS47ayXjUsU/69Xw3Aj4Z7C3Sd1phFeF/kRfidxi2Kj0eFI2Bs0qqpL1qKELDx7TpJdAF
        HshHU7nm0=
X-Google-Smtp-Source: AMsMyM4PUVo7Xol1CSaEtsAq0hrjEyv1xy8leks5fVsOnLmK8rlbfda9JnmQ+bNpX50kiCQTyT2R9J9WwcveH1r2nA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:17a9:b0:563:3255:8601 with
 SMTP id s41-20020a056a0017a900b0056332558601mr288210pfg.12.1665676858718;
 Thu, 13 Oct 2022 09:00:58 -0700 (PDT)
Date:   Thu, 13 Oct 2022 16:00:39 +0000
In-Reply-To: <20221013160040.2858732-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221013160040.2858732-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013160040.2858732-2-dionnaglaze@google.com>
Subject: [PATCH 1/2] x86/sev: Rename snp_guest_issue_request's fw_err
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

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev.h | 4 ++--
 arch/x86/kernel/sev.c      | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ebc271bb6d8e..4312d6be129f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -196,7 +196,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *exitinfo2);
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
index a428c62330d3..a4eca63e8b90 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2175,7 +2175,7 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *exitinfo2)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
@@ -2186,7 +2186,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-	if (!fw_err)
+	if (!exitinfo2)
 		return -EINVAL;
 
 	/*
@@ -2218,7 +2218,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
 			input->data_npages = ghcb_get_rbx(ghcb);
 
-		*fw_err = ghcb->save.sw_exit_info_2;
+		*exitinfo2 = ghcb->save.sw_exit_info_2;
 
 		ret = -EIO;
 	}
-- 
2.38.0.rc1.362.ged0d419d3c-goog

