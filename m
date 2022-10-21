Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A64607D21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJURAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJURAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:00:04 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505AE558F4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:59:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o17-20020a170902d4d100b0018552c4f4bcso1996722plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t50s+W2sjRzmfaqPHM8BWoKuylKuq2NrCynpVhPS9Gk=;
        b=D9gJIDipIbDmmnhQPtT5HvABc6SjejzqBT5yiNYUXkric3SrAQON1oJaySHETkWhRF
         PX+KXKZ8JyA88v5tE4EMTFFJ56/REmpBVnlywvFa42c+E/x0SheZzLwiWE2jhqQ+ldz/
         enUDwkgtlYTXMR/moT5KYh1uSh5HqP4f5+krbjx7kwfdJGvD8LMPgse7XWYz84ecIap3
         Gm1jQw7vlBv3YOHYsL+3u0MKUTb4Wr9w9Kl/hnfs7pZzn9geE9pgrSyKDnTu2C10Z9vr
         7m2WMljG5b0dphDbKtqSD/H50W5Ti5sTtcWvFUQJcn/fzKGTVFPvaTkkgPtnH78qD43g
         NoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t50s+W2sjRzmfaqPHM8BWoKuylKuq2NrCynpVhPS9Gk=;
        b=Z84mbLYoaaHWZQaHkhTVpLqYOUqgFTVFYMRIs1sCb0pCFGSpKBQcN0cwBHylTIedwG
         tnSF81C+Dn6LD/iPXM1v/8ig6D9uBMTLaTkaw5y+Z6JWCj6C44N/SHo7sfjCH2SPJ4Gx
         QunKNEQFhFD5+i+vjXGPGbbxkut/rnlA9zhtQxCP8jjeIYNWBvEy9Qnn/no6NgOysimm
         A9Z6XcD44midn81meKuoISjBAQaEDpjmJCzBzG/UTes7w0BCmFQ7+kVL4tZwVAnf0qh6
         r074J8pKTH5jZHwxmOLNl6E5AqWFtmH1p7oon0Li9R5g5dEkyUpihODhXZ8jJNYQr0dy
         poxg==
X-Gm-Message-State: ACrzQf0M3EsiZ/lMmAUi9oIbTQ0JPTdLdbtpIrDo0yIkzTuTydrXgP7o
        b7br5YS2kDVfWZFNp7odBRR1h0WHOfCGNcLPlV4DJhOnotSmb3YowWZx4Pp6S+umrLYc8/bP6s2
        arAw2G25RZRhUXaXXXP44HF8eJxSx8lwabJuzK6PqseLRyCBfI8Zjxpftzgcgr+xnr7u+br/T3K
        6GdCBLXkQ=
X-Google-Smtp-Source: AMsMyM4zZpV9dAcanrqUynT/VJyO6LIMwgrP7u0kvBFaYYHeHm3KSrfk67+lQwgxAr4mTFyMYrpqm2P+vU5fXAEPAg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:e191:b0:181:b25e:9c17 with
 SMTP id y17-20020a170902e19100b00181b25e9c17mr20441665pla.57.1666371593958;
 Fri, 21 Oct 2022 09:59:53 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:59:42 +0000
In-Reply-To: <20221021165943.1968044-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221021165943.1968044-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021165943.1968044-4-dionnaglaze@google.com>
Subject: [PATCH v3 3/4] virt/coco/sev-guest: Remove err in handle_guest_request
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

The err variable may not be set in the call to snp_issue_guest_request,
yet it is unconditionally written back to fw_err if fw_err is non-null.
This is undefined behavior, and currently returns uninitialized kernel
stack memory to user space.

The fw_err argument is better to just pass through to
snp_issue_guest_request, so we do that. Since the issue_request's
signature has changed fw_err to exitinfo2, we change the argument name
here.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f422f9c58ba7..0508c2f46f6b 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -303,9 +303,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 
 static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+				u32 resp_sz, __u64 *exitinfo2)
 {
-	unsigned long err;
 	u64 seqno;
 	int rc;
 
@@ -322,9 +321,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		return rc;
 
 	/* Call firmware to process the request */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
-	if (fw_err)
-		*fw_err = err;
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input, exitinfo2);
 
 	if (rc)
 		return rc;
-- 
2.38.0.135.g90850a2211-goog

