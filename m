Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C8061A54C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKDXBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKDXBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:01:12 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D589142F6A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:01:10 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t3-20020a170902e84300b00186ab03043dso4504759plg.20
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdK/VRyCPwKThqqRcg2usy4G2FHLW3I2lPiI0d9S9hA=;
        b=C7B2GiACclUr4bSg9eCOuhvdwXQYkHErdquyDfYepWM9YWiqvNxBWnp29ohwvvLYN4
         GnDjmvJX5GD3n177DQptp7GYjzQGqISK8F8yU4xsUd6iy1ZGj6NqGpebAGtNt4RFPK4T
         IE+V7+os77Wmpj6D91LoVxk5YMR3Y2p5d1/WWEUo7glcCyu66lPXC3r5o0LW3+IAsmDg
         nWh0zX9F1uzSo0YmRLBjGB6e7YoRxPB4FeH4lheU7UbCfRTDwws40b9ax/2P5LCCVBLX
         sXJq81RnQjUEaF9nSzceSAXsNNUQ+G7bOnIXJ4broNDCJEzpfGZJGFeYkBVSri4SSF35
         BcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdK/VRyCPwKThqqRcg2usy4G2FHLW3I2lPiI0d9S9hA=;
        b=MW2Yl6cXZNNH8RFX8OJH+IP+zxm+kJVdrtW7+tZoM7YZLctE+3cf/Xu36RVAQrILus
         QzK9aAt8/QK0/3ru0Ks5VQO3O9U0aVZUXG2t2zcoJFqiRQ3JtR+fq2r7TzCZdTTB77tW
         WzzaWG0ONhv6pwekfgSXtVu3JjwU7toshlfSopBl8pZ/s4keV2jNO7yFIOy1YucWNlYv
         +KlgEQ5VoYqUlQREiSeToTFdjK9Fbd+Ndxb1G8ZnXAsNYhD4PRy7It1zQXCyCgTavY26
         JPbE36rySvBYR1okWJcu7u1kkIyuUzxN5/tiFqRv7lFD9SbmyIR0zckKyTGBS1nl5uG1
         oBwg==
X-Gm-Message-State: ACrzQf3tgJS8SanrNWaFgyOjoHg89yTdhouHy6xWZA8u7u+17gQTvzoB
        rBDuKpxzHoRPuarjIzKS0qk9CqpOA36XRC2KpF9bRN/gke3bO2SKe1wJCywvxFvTcqJVjVQd8pR
        R/o6TmoDBo26N5hdNODuC7f4bssHWz786goaBqoITcZX1yR2KNHE2xep/bHHU0wH91HWEBdXWrD
        6DipELZA4=
X-Google-Smtp-Source: AMsMyM508YuCorHCUtQKEGbYgmmaFX4hLFktsADWFnWvPxqJbs2mfRNbMWJg4Y8uLJGlKRK5lZ0TRo2UvmZlwqxKtA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90b:1881:b0:213:1f29:2d0a with
 SMTP id mn1-20020a17090b188100b002131f292d0amr396847pjb.154.1667602869918;
 Fri, 04 Nov 2022 16:01:09 -0700 (PDT)
Date:   Fri,  4 Nov 2022 23:00:39 +0000
In-Reply-To: <20221104230040.2346862-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104230040.2346862-4-dionnaglaze@google.com>
Subject: [PATCH v8 3/4] virt: sev-guest: Remove err in handle_guest_request
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
snp_issue_guest_request, so we do that by passing along the ioctl
argument. This removes the need for an argument to handle_guest_request.

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
 drivers/virt/coco/sev-guest/sev-guest.c | 37 ++++++++++++-------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index d08ff87c2dac..5615d349b378 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -320,11 +320,11 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	return __enc_payload(snp_dev, req, payload, sz);
 }
 
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
+static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
+				struct snp_guest_request_ioctl *arg,
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+				u32 resp_sz)
 {
-	unsigned long err;
 	u64 seqno;
 	int rc;
 
@@ -336,12 +336,14 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, arg->msg_version, type, req_buf,
+			 req_sz);
 	if (rc)
 		return rc;
 
 	/* Call firmware to process the request */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input,
+				     &arg->fw_err);
 
 	/*
 	 * If the extended guest request fails due to having to small of a
@@ -349,23 +351,21 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * extended data request.
 	 */
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-		err == SNP_GUEST_REQ_INVALID_LEN) {
+		arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
 		const unsigned int certs_npages = snp_dev->input.data_npages;
 
 		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
-		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+		rc = snp_issue_guest_request(exit_code, &snp_dev->input,
+					     &arg->fw_err);
 
-		err = SNP_GUEST_REQ_INVALID_LEN;
+		arg->fw_err = SNP_GUEST_REQ_INVALID_LEN;
 		snp_dev->input.data_npages = certs_npages;
 	}
 
-	if (fw_err)
-		*fw_err = err;
-
 	if (rc) {
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
-			  rc, *fw_err);
+			  rc, arg->fw_err);
 		goto disable_vmpck;
 	}
 
@@ -412,9 +412,9 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!resp)
 		return -ENOMEM;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len);
 	if (rc)
 		goto e_free;
 
@@ -452,9 +452,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
 		return -EFAULT;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
-				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
+				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
 	if (rc)
 		return rc;
 
@@ -514,9 +513,9 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 		return -ENOMEM;
 
 	snp_dev->input.data_npages = npages;
-	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
+	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
 				   SNP_MSG_REPORT_REQ, &req.data,
-				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
+				   sizeof(req.data), resp->data, resp_len);
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
-- 
2.38.1.431.g37b22c650d-goog

