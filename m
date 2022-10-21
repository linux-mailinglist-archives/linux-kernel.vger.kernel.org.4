Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90857607D22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJURAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJURAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:00:13 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A085603D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:59:56 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id s82-20020a632c55000000b0046b2491aa95so1615040pgs.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dO505Xy9Iu56vKjLdviNHzvPncOQ05EfhM0+fDYGP1k=;
        b=FFU2BCN+saMvG81c5ljwwxLZW9Rg/pTM6PuXKjVDcrafO80Nr5q1EKQ3MVmcJBTiNZ
         cSQLSGI3Tl+6MUwr6kngSsT3+lthevNxl2FW72nusDJ56Dez1OFahtdrdyAn77+0zeAH
         dglUnvnlJDB2n3QMWzc/yZHme2KTNjD5P2OvH1q2yoH5Pm2NHaMTZDmLSsfeYCq51jUA
         BuudSfVO55MgZqeWXMUC56jfGhiG9SemjaZynM1T+gwcQgzSvVX9TAqvw2FcAiXDPRGY
         xJ7QvAZ+GkX/cSaMcYfVguBMjJTkyH0xYF3eUgvXweV52j64YsvNChJ6g0k7IF34I3RT
         8Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dO505Xy9Iu56vKjLdviNHzvPncOQ05EfhM0+fDYGP1k=;
        b=P7nSXHSChrpJjFDwGvQ6ZByuyVAVNIihrLeqlBx9Fanqq2cxrgvSYHK6wW8ycxSTDB
         0DXfpUIOCg9l0kG1oy9En1kqilV5Ogo1TCzllRvkeXHEAxtCX6X5IJGU+QukRs2M2XXf
         Ns/2y0/mnA9J7jepWrQ0ln0wdpPQWWMsoU1bl+kW38fc/+i+jTHrzfLzKb3HwDTALwNZ
         f2wRRaLSF+sKc1OYeTY9HKw3zfEnTtgUbl+d8cNvSSDGFAKHiukrF3ubm0Z6WD5WLMG0
         pbmYRQHf6KwUB64z22BL4kEeNyE1TrXI4bwRc6r6cdT6bbxni1TibJHfJjYdR2URYF9M
         UR1A==
X-Gm-Message-State: ACrzQf1e4FjXKFttdC7svbwzR1gFZtb7U9uvIVKwm4RJ4ljvAy1wi7EK
        XN+eo167HukacV5ERr19moIdB8a8any0S0byPaUwrDWyXQR04XXDvSOYY3gXWf+u/j/6NyG8aYY
        vtzPwaOhNpleiwrGR5mj4JB3jjcpVuI0P1MztRCfj/WRqLMb34x6op6mJ9sVpHmASc45DEYftXb
        6yT5ek1g4=
X-Google-Smtp-Source: AMsMyM6ItkNqnZQ4CmJW2S3yXVjmRSrfg8LdIO09glRF3ObAtc2d3k5zOr4U+nksJtS5q4SSAMkiGq1SGmNv+Pfj0w==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:d70e:b0:178:2d9d:ba7b with
 SMTP id w14-20020a170902d70e00b001782d9dba7bmr20349417ply.90.1666371595675;
 Fri, 21 Oct 2022 09:59:55 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:59:43 +0000
In-Reply-To: <20221021165943.1968044-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221021165943.1968044-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021165943.1968044-5-dionnaglaze@google.com>
Subject: [PATCH v3 4/4] virt/coco/sev-guest: interpret VMM errors from guest request
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

The GHCB specification states that the upper 32 bits of exitinfo2 are
for the VMM's error codes. The sev-guest ABI has already locked in
that the fw_err status of the input will be 64 bits, and that
BIT_ULL(32) means that the extended guest request's data buffer was too
small, so we have to keep that ABI.

We can still interpret the upper 32 bits of exitinfo2 for the user
anyway in case the request gets throttled. For safety, since the
encryption algorithm in GHCBv2 is AES_GCM, we cannot return to user
space without having completed the request with the current sequence
number. If we were to return and the guest were to make another request
but with different message contents, then that would be IV reuse.

When throttled, the driver will reschedule itself and then try
again. The ioctl may block indefinitely, but that has always been the
case when deferring these requests to the host.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 32 ++++++++++++++++++++-----
 include/uapi/linux/sev-guest.h          | 18 ++++++++++++--
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 0508c2f46f6b..7abf4c3daa6d 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -305,9 +305,12 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *exitinfo2)
 {
+	unsigned int vmm_err;
 	u64 seqno;
 	int rc;
 
+	might_resched();
+
 	/* Get message sequence and verify that its a non-zero */
 	seqno = snp_get_msg_seqno(snp_dev);
 	if (!seqno)
@@ -320,9 +323,26 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	if (rc)
 		return rc;
 
+retry:
 	/* Call firmware to process the request */
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input, exitinfo2);
 
+	vmm_err = *exitinfo2 >> SNP_GUEST_VMM_ERR_SHIFT;
+	/*
+	 * The host may return EBUSY if the request has been throttled.
+	 * We retry in the driver to avoid returning and reusing the message
+	 * sequence number on a different message.
+	 */
+	if (vmm_err == SNP_GUEST_VMM_ERR_BUSY) {
+		cond_resched();
+		goto retry;
+	}
+
+	if (vmm_err && vmm_err != SNP_GUEST_VMM_ERR_INVALID_LEN) {
+		pr_err("sev-guest: host returned unknown error code: %d\n",
+		       vmm_err);
+		return -EINVAL;
+	}
 	if (rc)
 		return rc;
 
@@ -375,7 +395,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len, &arg->exitinfo2);
 	if (rc)
 		goto e_free;
 
@@ -415,7 +435,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
 				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+				  &arg->exitinfo2);
 	if (rc)
 		return rc;
 
@@ -477,10 +497,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	snp_dev->input.data_npages = npages;
 	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
 				   SNP_MSG_REPORT_REQ, &req.data,
-				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
+				   sizeof(req.data), resp->data, resp_len, &arg->exitinfo2);
 
 	/* If certs length is invalid then copy the returned length */
-	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
@@ -515,7 +535,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = SEV_RET_NO_FW_CALL;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -546,7 +566,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	mutex_unlock(&snp_cmd_mutex);
 
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
 	return ret;
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 256aaeff7e65..8e4144aa78c9 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -52,8 +52,15 @@ struct snp_guest_request_ioctl {
 	__u64 req_data;
 	__u64 resp_data;
 
-	/* firmware error code on failure (see psp-sev.h) */
-	__u64 fw_err;
+	/* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
+	union {
+		__u64 exitinfo2;
+		__u64 fw_err; /* Name deprecated in favor of others */
+		struct {
+			__u32 fw_error;
+			__u32 vmm_error;
+		};
+	};
 };
 
 struct snp_ext_report_req {
@@ -77,4 +84,11 @@ struct snp_ext_report_req {
 /* Get SNP extended report as defined in the GHCB specification version 2. */
 #define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
 
+/* Guest message request EXIT_INFO_2 constants */
+#define SNP_GUEST_FW_ERR_MASK		GENMASK_ULL(31, 0)
+#define SNP_GUEST_VMM_ERR_SHIFT		32
+
+#define SNP_GUEST_VMM_ERR_INVALID_LEN	1
+#define SNP_GUEST_VMM_ERR_BUSY		2
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.38.0.135.g90850a2211-goog

