Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5F6450AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiLGBCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLGBCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:02:39 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BB7BC6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:02:34 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o31-20020a17090a0a2200b00219a2904952so38173pjo.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 17:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYb5Kkl7KCSyA25o8WI4Ic+8SfxAdiy9vbY0soW+D/8=;
        b=Pi2ZKrH8sVupiZlbc+zhoHxcKrCy9Td9o6yADcsSdTeQ0fbjZ+F/PZxeKNtHfFKZGY
         ya1GLHf7PmNpSghZ/GPX9Ckgrb7ovCtW8nKRE7sej87O/ZIC6c4GJWOQMqjTJNcm6gHi
         UdQy46PkhThDKH+wx7eWq0OeGcGL1LLc/h+wzh/QsRQ2X0RKtlho0JmQP+eZcxVeJM7h
         tbiHXnSgIFf89/MJk69ZIzWPhTSShdVexyk9q42ZCpqQC0vreRf5QBBGQyTpS8ZIzMcf
         HmlC/+ydM+hLQsGT+iSfJc6UU4p/H47/btHjSc7l9DjstB2Seb8YCA4MhPDyKuBsJ57c
         eyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYb5Kkl7KCSyA25o8WI4Ic+8SfxAdiy9vbY0soW+D/8=;
        b=aVpudRnFh1/Uf05xGLXmZUrNcAcPDmq/N7CTG8uHLe0Ed1QhWm7VJQ4/hJp8b4W34Y
         DmROyYk2KHm2MFNIl9bpRL9iGpVbXZg8di+Y5DVQuqfAL9NN+uRmA6lfLdSocowMnf+Y
         ysF64HB0iEgMMFFSSuSFQiv60jMIwaPhyDD/dhA7ty91Ew5942tvAQ1YI9P1ZNmulmm1
         a9PsYsm9dGYwCWDXZzbR3AUuWkYAIwqVGCt2S14HeticaiZ6oiKmPTicgf/FB0+D2VZo
         J8/dknYXDLhtdcjBiyV0+H7Tk0LQnt9It1G93NPYqRzXd0UgCQPrUroJvP3U41KIKmER
         YwPQ==
X-Gm-Message-State: ANoB5pmpFsQebPL1tICr9ULq3mx0iZkGjra9G9Pec+T7LFn1blNNqINM
        T2A1eGK5Ho/BzyRPP1H7k2a+mD3LrJhMDEVYEpehpOIAUPA775rdOAtlIMLlp+M/d6vJzm/ikCt
        PLfW5Hf+4EtfiPdp2XJ3qO2Xj9PuAbn1OyQjXE7XXzpQlnec84y7zli7uS/EsGWzcD8PbteoYf1
        mh2COWhxI=
X-Google-Smtp-Source: AA0mqf79S2a8pHYPXB39OoGONxOXjRLJO03JVGSUEE07nKwCBsq1o57fflyv7qPwTVPzLRSSDqh70drKt+BYeGLeLg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:9004:b0:17c:9a37:72fb with
 SMTP id a4-20020a170902900400b0017c9a3772fbmr83968713plp.82.1670374953834;
 Tue, 06 Dec 2022 17:02:33 -0800 (PST)
Date:   Wed,  7 Dec 2022 01:02:09 +0000
In-Reply-To: <20221207010210.2563293-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221207010210.2563293-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207010210.2563293-4-dionnaglaze@google.com>
Subject: [PATCH v9 3/4] virt: sev-guest: Remove err in handle_guest_request
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
snp_issue_guest_request, so that's done by passing along the ioctl
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
Reviewed-by: Tom Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 35 ++++++++++++-------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 1ea6d2e5b218..4a2a0a02985f 100644
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
 
@@ -336,7 +336,8 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, arg->msg_version, type, req_buf,
+			 req_sz);
 	if (rc)
 		return rc;
 
@@ -346,7 +347,8 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input,
+				     &arg->fw_err);
 
 	/*
 	 * If the extended guest request fails due to having too small of a
@@ -368,24 +370,22 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		 * of the VMPCK and the error code being propagated back to the
 		 * user as an ioctl() return code.
 		 */
-		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+		rc = snp_issue_guest_request(exit_code, &snp_dev->input,
+					     &arg->fw_err);
 
 		/*
 		 * Override the error to inform callers the given extended
 		 * request buffer size was too small and give the caller the
 		 * required buffer size.
 		 */
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
 
@@ -432,9 +432,9 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!resp)
 		return -ENOMEM;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len);
 	if (rc)
 		goto e_free;
 
@@ -472,9 +472,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
 		return -EFAULT;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
-				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
+				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
 	if (rc)
 		return rc;
 
@@ -534,9 +533,9 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
2.39.0.rc0.267.gcb52ba06e7-goog

