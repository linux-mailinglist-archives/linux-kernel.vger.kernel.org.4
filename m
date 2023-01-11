Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371F26663DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjAKTlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjAKTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:40:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647FA3AB08
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w9-20020a05690210c900b007b20e8d0c99so17056753ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jROFcMIOfREA4pvBEWsXvm2O06wrZcKQPogWOWVjrB0=;
        b=D1MUSWv+xcYp+8e8Z93OPrpXvAir7Vsy73rFaZnOnoCTIrqkRpOChaQSjhD/yjeua9
         +IAYEJHPIv1/YczH/BFC+yEEpDzSs21d93HLLE39mdFDiIc45V4OBQQ8hvDJNQJvbVkp
         5g9eaq0cQITh9qq7seexRWvL+yWohet9ZckS2zebI7/hKYi1d2IHju9ERumA6+KqhPby
         LwxUdbf4vj3GpSf9oc2JbViesADCGEWh6rYwKnNad+luQKFl5bZLbBgKTy4s9zS1rHaF
         CbVbjN2V4mJcjNqBy4SHsJOZJ88//N2OxsNWsGEccWmvK71CHSjq0F6aOZFQ3y/quuXU
         S5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jROFcMIOfREA4pvBEWsXvm2O06wrZcKQPogWOWVjrB0=;
        b=T7fx1cxhrPcHord0EF+g9IAok/OL5QSpLvnmcjorN9WmLm89Ihw+frhgI9fAYXczm8
         uLv7o0OKUfq0XQYBI75j/avmPkvj+dd/ychBdBFuaMsWFcLkXYO06FzOFg6N3bprnPCI
         mxlrg/AWoeuLKeqHB7nIn8MMpMswGIYM5UBWgemxgjIAOmxgD7GWBzTvYeMu2xWBed0X
         O5K08MHm/6wqz9/dZAOJwsBT9+I2sTNPaHUG7+o1vYNRbxBchZG6i5+0KdKcJg4Iq5yP
         yXsqapnq0UOq0aayi0KhHNF07YGQRdbHjXuh+NoyEzRrPnAqv0fJJPu5UUbj08dIHav6
         8idg==
X-Gm-Message-State: AFqh2krGIdvbFLpoJxwcQcSdjbS8HYSK5MWrZkK7hJSmz1OGEFqRsUSX
        6mDVEInZ9429tzS58VUDvp859YLnO/4Blt1xmvD/ZKPfL+UNmXXHqIzjVD/3Jw/Z/XgRxOvZQ2G
        ztDL+FlHmS3z0eY5B+72B4P3ULpnS/Vrf73Us5Ciay/2naRtf9dRSDVI7QDzHgKfBnRRkgwALEN
        kSNtacZbM=
X-Google-Smtp-Source: AMrXdXvkfBHdMJmj+IxdpeRTnzrsi0sV/DAsHHhqwy47u7Iv+f7pKLZaetm63WfSMKybAxSdEe1qLT1ZuR7gQljR5w==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a25:7694:0:b0:7bf:45f0:3ebb with SMTP
 id r142-20020a257694000000b007bf45f03ebbmr1096041ybc.599.1673466014555; Wed,
 11 Jan 2023 11:40:14 -0800 (PST)
Date:   Wed, 11 Jan 2023 19:40:01 +0000
In-Reply-To: <20230111194001.1947849-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230111194001.1947849-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111194001.1947849-8-dionnaglaze@google.com>
Subject: [PATCH v11 7/7] x86/sev: Remove temporary typedef
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
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

The sev_guestreq_err_t typedef has served its purpose for cleanly
changing the sev_issue_guest_request signature, so it's no longer
needed.

Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev.h | 10 ++--------
 arch/x86/kernel/sev.c      |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 301e3b69f477..05de34d10d89 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -133,12 +133,6 @@ struct snp_secrets_page_layout {
 	u8 rsvd3[3840];
 } __packed;
 
-/*
- * Use a type alias temporarily to cleanly change the snp_issue_guest_request
- * signature cleanly over multiple patches.
- */
-typedef u64 sev_guestreq_err_t;
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -202,7 +196,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, sev_guestreq_err_t *exitinfo2);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -223,7 +217,7 @@ static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
 static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
-					  sev_guestreq_err_t *exitinfo2)
+					  u64 *exitinfo2)
 {
 	return -ENOTTY;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index d1a6092b1e03..70b4cbd33c45 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2176,7 +2176,7 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, sev_guestreq_err_t *exitinfo2)
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
-- 
2.39.0.314.g84b9a713c41-goog

