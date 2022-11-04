Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5579761A208
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiKDUQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiKDUQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:16:38 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AE148762
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:16:33 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q63-20020a632a42000000b0045724b1dfb9so2998118pgq.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nK/94Sb1beqtM8XT82Q9haSgN6Gg90IfYFCDs+/l04Q=;
        b=gD4uBppbQwFb6mzboPS+LsD9PYZUuN8/clt/XIhPCFu1284keiCeM33V3amJCXDA1p
         UHh9XdWGEIOK+r/aYqaAgXeqHBvUeUKULrNrsX/v+Tiry9/SWdtgyumpXnyTtoeEONV8
         sJ3gxEvkq0VOu7/LX2v1vHO4aS5cZbXk13KJwjgFgSB8D6WXo5e7ElSkaLed1zBBDdhO
         45rcW6a+SFoplxfbQ+bazqHmeRqBYxIqYt0rUquGNq4xl2bW0Ap9aghRZgqYG6bxzGiS
         7Q7FESTo4Q6FV/RcIZBcNd8cN629rHx0Cz5X3uMtcMtBuTqXRHHtMfyq1amjB6E4dSvp
         tM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nK/94Sb1beqtM8XT82Q9haSgN6Gg90IfYFCDs+/l04Q=;
        b=TIud7UMXHDuhBuEisSCtuO1SNpslvP3qMjKg/BA7CDX7VvkEmZKR6c6IFr0xceduNJ
         U95NWBQ7iQ2GoXpr4zKA/Y8efUwgv/lXOhq+1fWVVNGVQnnFCgC+J1BmOYr5dcqwnPJu
         Q/glCpLWTKZWo/c17ymktyaX2G+GpUnTI7lPaJDKM4Ff5udW6DHm3yXoATWz35/YC+zC
         JHTvHzYP7kcAjWgs4OpJqx4KbOomIaVDsJ6LcGk01eliu502eXGrI+tGn/KNzbXkTIqs
         ZktyJIDH9gZrVxsHMUSWsuH4V1bSaPohNaNm81+6nhEyZOQpabP10zuqW3nZMBBVDywx
         4kfA==
X-Gm-Message-State: ACrzQf1ZFYitz+85hBBpyELxi0F1TyX2zCNQQYpCNADzq1210AeuZpsc
        hFouBpSEkogcuANRgTWcFkmCQtQJ9IcAXT3i0Mn0v60+QOu/Uca2fHyX21PeRxgozklpn+Jkhep
        w1yZslwH3gQqJ5ypFTLzr222hT2CUugQPd3GlJFDCazcQoPRyePNvRW1uF5GpR77xMwiwdA46Mx
        wLiPg3Zd0=
X-Google-Smtp-Source: AMsMyM7k3NkUNQaSMnsZnQXjKcsd3HT0Bsg9kKJyG7NJdJBKkzG/tNRQW9EBZHGPlRnflF3tQ6LZwdmhK+gieg8/KQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:4dce:b0:213:9d22:8870 with
 SMTP id r14-20020a17090a4dce00b002139d228870mr40202745pjl.7.1667592993039;
 Fri, 04 Nov 2022 13:16:33 -0700 (PDT)
Date:   Fri,  4 Nov 2022 20:16:15 +0000
In-Reply-To: <20221104201616.2268815-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221104201616.2268815-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104201616.2268815-4-dionnaglaze@google.com>
Subject: [PATCH v7 3/4] virt: sev-guest: Remove err in handle_guest_request
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Haowen Bai <baihaowen@meizu.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>
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
Cc: Borislav Petkov <bp@suse.de>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: Liam Merwick <liam.merwick@oracle.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index d08ff87c2dac..5ebf87651299 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -322,9 +322,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 
 static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+				u32 resp_sz, __u64 *exitinfo2)
 {
-	unsigned long err;
 	u64 seqno;
 	int rc;
 
@@ -341,7 +340,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		return rc;
 
 	/* Call firmware to process the request */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input, exitinfo2);
 
 	/*
 	 * If the extended guest request fails due to having to small of a
@@ -349,19 +348,16 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * extended data request.
 	 */
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-		err == SNP_GUEST_REQ_INVALID_LEN) {
+		*exitinfo2 == SNP_GUEST_REQ_INVALID_LEN) {
 		const unsigned int certs_npages = snp_dev->input.data_npages;
 
 		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
-		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+		rc = snp_issue_guest_request(exit_code, &snp_dev->input, exitinfo2);
 
-		err = SNP_GUEST_REQ_INVALID_LEN;
+		*exitinfo2 = SNP_GUEST_REQ_INVALID_LEN;
 		snp_dev->input.data_npages = certs_npages;
 	}
 
-	if (fw_err)
-		*fw_err = err;
-
 	if (rc) {
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
-- 
2.38.1.431.g37b22c650d-goog

