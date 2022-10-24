Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EAD60BF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJYAYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJYAX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:23:28 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760FCC827
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:47:06 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id cb7-20020a056a00430700b00561b86e0265so5287228pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t50s+W2sjRzmfaqPHM8BWoKuylKuq2NrCynpVhPS9Gk=;
        b=VukVbYSP3OxCt2Aov1s0MXfB7/bJ8+HJOcG+qkdTnvVwyqSeEysxQibuYGQUZ3GZHb
         LQo/uctV2e8+FXtRqm1w3rlwt5gYx58CGxPrKqoR0yeaP8JfVnpR+nP6OXi9wVTzBBl9
         AXKCdAMTHbE1mKJISj2iUiRLdw6PTThAzbg+o+a8LaRJc82/oAFNbu6ylNV6osG+qHp8
         m5CycDkb++iVbaZA3ZFPyLWI3Z7GFGvKnDD+R/CQ2yo1ag9cs5xDXCH6qE743Q8S1mOq
         S/kRVHwrJWzq6x1OLj+u3ATxd/9s8S1RZ3/NisX1JirkpZVY76wYTLHgmfhH45U6kaxx
         3HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t50s+W2sjRzmfaqPHM8BWoKuylKuq2NrCynpVhPS9Gk=;
        b=Bul4N3EFuhyyXyM0v7Gbm1d9wFFgTUVjuIKWIHKOuppIg2F7Bz4nkx+J5o4POFYv3l
         HYnOtvcWFn3OKCabFBUFiqc2aTg8cydtGotepVr3ywQdg8v8idvrP6oOOo/Bf4+OD1Hx
         FqFoHRM0cLfN7GPcPnsKqrYMkS7t0vLU2Yqay4avMQ9195DYH4f/HON/Ev13b+HkGzEc
         936fs5uRUjEVUHI0VHmTPG99aj8ZZ07YyDx0YtJYwCadf502dnuizn04jYhuI1mV9iz6
         blKSsvjcEgzARRO85DZfwQ322W2OovDd5zV3qvFuqc5yUrXsu9MjSnjDuSiQ99N9eE6L
         H0tw==
X-Gm-Message-State: ACrzQf09eT6O4CMoDHFdqin1H9KQ/hzLVQprOQjK28iSmSaKlYSpPgjj
        yjX3a+Rw/cjFPLv+x7DjALe8zPxdu0iDUV51U+aE0+D/Il00jy9enBD6RpdVHjSkrnp7Yn0HEWt
        3Zcqgx9EsHJeTIl/NyLftAJjZ2ZoHM4BKFFF1VuwwogUF0qLKIQQghOcMN2UepqRMwxq9mr55J9
        wtW/Hipn4=
X-Google-Smtp-Source: AMsMyM5bE+DXOug7SxNNmWpiYtjeZTIN+bvNMw2JNHpElWmuN0VO5+l1lT7ilIZJh0kInbRZL3+ELwZyoHO3AcbztQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:4811:b0:20a:fee1:8f69 with
 SMTP id a17-20020a17090a481100b0020afee18f69mr4038806pjh.0.1666651625380;
 Mon, 24 Oct 2022 15:47:05 -0700 (PDT)
Date:   Mon, 24 Oct 2022 22:46:56 +0000
In-Reply-To: <20221024224657.2917482-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221024224657.2917482-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221024224657.2917482-4-dionnaglaze@google.com>
Subject: [PATCH v4 3/4] virt/coco/sev-guest: Remove err in handle_guest_request
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

