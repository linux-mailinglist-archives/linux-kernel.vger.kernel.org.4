Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E956165EC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiKBPTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKBPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:18:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B46313
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:18:52 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id w191-20020a6382c8000000b0045bf92a0b5aso9655446pgd.22
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AavPz2fIPJd5HTECnX2371PWGJ0eVVzEztf+ROklkx8=;
        b=VZx/B4fHe5VKpfQ1EWWSzaJLFLB66q59VLDUukhzNaMykE3L+PNSKEJfdLGnw/6cdr
         pL1pmWnddTsNdT7OweskWXcyOY1TPGf0/5d17ofiJ3ds/I26a66SaQUsAxbvRT86LNr7
         xOVpPCUE2d84+MtaKGR6F/N47bJMgdZk2vukv+1/LfJhmcssmi1wGkzBTvIgAA56EQSF
         KKVXYWevJGjh1038KwyvziVoP9t6n8LelgtjgtLQa63RIn25rsoUduaafAcZuXBUajVi
         77jmzzCID+qRue5A/ZqPnH11zQJYu7mgkjDHxgau7uX7z+HrVBPao+TMtE2nxT5+m9HT
         yC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AavPz2fIPJd5HTECnX2371PWGJ0eVVzEztf+ROklkx8=;
        b=TqIzhz8U4amLNI3KlGddyLBgYcXSbMmejpXg88LYxFNG/QxQ7hcMDLm4cfdNHNPjml
         u+n+QCwIm4vDYy2L9rPeACYiR/hmcX6I4PTXk5wAq3CvAgcd/s7wRIa9/JwzsA1DDnLW
         8jHGwAGmZcBvOD6Ze4/o+fkmrIcZvGKsqvtZbxaOHyF4BenB3kG1/Nz+EXLc++vF8QXr
         CR74u1KwivSugTBW71tIcapQ6qpiTz20dq/T0Lh0pI5gEXjD/TyHgfv3Pc34tQ11xNGs
         PFF3jUttMIjkM7hd4jy7X7WldECpbAq3qtm1HLrfpxyw9L5bvQo9iOCsHUDjUzVgorp5
         sgbw==
X-Gm-Message-State: ACrzQf2Sfls4VYX1+J3bdUaEFHRcFLUbraEyZVH0olHVBU3T4tUeZft9
        NuogozOj0NcvmyPaZ2PAz3sDcwF6ehxRAweJwKPNQtKVqLTaRHlZzZUl3Cq+16PqUEfkwr82Zfx
        aEVHZkgz9imH7dmqhw4g40K7PC981a8NlV6RslkM7Wm0kHb8dWfbvZ+4KdSi+oH6wgGG3VnBFui
        hSFTGreQc=
X-Google-Smtp-Source: AMsMyM6IuXu8xWVRiNhMRI7Vbt1uAthmEPpeaSBjIoxVYW0rYfeBb5nx51HCEcqjG4FbJbOTSmXK67bxi/A9jXMYXw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:1822:b0:56b:f29d:cca1 with
 SMTP id y34-20020a056a00182200b0056bf29dcca1mr25958788pfa.65.1667402332595;
 Wed, 02 Nov 2022 08:18:52 -0700 (PDT)
Date:   Wed,  2 Nov 2022 15:18:35 +0000
In-Reply-To: <20221102151836.1310509-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221102151836.1310509-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102151836.1310509-4-dionnaglaze@google.com>
Subject: [PATCH v5 3/4] virt/coco/sev-guest: Remove err in handle_guest_request
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
2.38.1.273.g43a17bfeac-goog

