Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BB45FDDD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJMQBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJMQBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:01:02 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C481A103DA8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:01:01 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id p24-20020a63f458000000b0043cd718c49dso1208377pgk.15
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y7BIlHgNQlvppQZ+CGwKN1fA9G9Eb8Xq4ktO1Quy358=;
        b=W7bVmX6RVPsZzOCX5yzg+9+z9D6fOazH4u8HtiPlmGwkDgHBCdyCbX+aKrFHKozu4I
         0qAiaymzLZ7vUFoizZ0Cyo+vdMKsV3TDkw3EBe2ZKc7/skO48lcCISQNR15VShyQ6M/Y
         RKQQ89vfC89cBdy3V5LyC/0Zzz2Dt+xF2CEhWLGVxxXmWwhLDsGx8ogQBLM7dt3vOUyo
         rRpKUHCEfVjRUDPJouCQLPTliqHexJ7L82oYWzsBwrgv7fhaUrc9FcVHZx5AB5nSankc
         Q5Sgf97YDzq3/IyCyS/0fP1AkrW6ert8DnEfASQxm0EdmT3kQLTBJ4j2jJUDKS7OX8kH
         jb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7BIlHgNQlvppQZ+CGwKN1fA9G9Eb8Xq4ktO1Quy358=;
        b=4GbNTqrzw5W/vrdPuh/wQzmnPNSPAI7a8A0RodltGWxeTQ5g2IeuOI8X9NJItqX5oF
         E8SW7epNCmpsgf0+pErkzTK3G3e0MpTxDavfD9ZCo2w/1po+5yUL1KXs1nBP0kkX36oQ
         CMPJ9NSksrWrDdKTUCG6JIGlsjOP55hrggwLOXhkqaMCmaGEuhE1MHDH6TDcZHQz5gxS
         KxRF5/uj7QFirG82EHni1/g2uvPvbiXszoVOHhoAP25BXhj6qgeHcQGZ9aa3OVJhHTvZ
         Q1MsJs1VphlBDVyXs5lcJPOkjGuFeemaMPzgVhFmhieFZpdkVBZ6lLOwPW9waTg22BA1
         T+Fw==
X-Gm-Message-State: ACrzQf1yqeefNHt7MfGSMK2En3VdQpagH3JVSpcwrHfsilJ0HTxsyz8f
        dH9aZqfpLn7PA+Jur/hbdzgOuFpjARLUX4lsOrrrm4IPMhsK9Eu+KFb4ZDM9LiVObjygWibEyBk
        H0XRr1Akj9cDra/mMODXDdModeUyJXOkmcOgkkDBrDUT3xby4jk84FyKRVd032BSD6Hm1ofaSr4
        lmA41aEXo=
X-Google-Smtp-Source: AMsMyM4XU/8MvA7h3nQrVPvs7EiSDlHRc5b09reVv1Z/fyI3XJOgDbhqz9/LTDa0QpGVoemE95byvaQE/6tt0KrGuA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a62:2985:0:b0:544:77d4:f43b with SMTP
 id p127-20020a622985000000b0054477d4f43bmr199173pfp.9.1665676861215; Thu, 13
 Oct 2022 09:01:01 -0700 (PDT)
Date:   Thu, 13 Oct 2022 16:00:40 +0000
In-Reply-To: <20221013160040.2858732-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221013160040.2858732-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013160040.2858732-3-dionnaglaze@google.com>
Subject: [PATCH 2/2] virt/coco/sev-guest: interpret VMM errors from guest request
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
small, so we have to keep that ABI. This patch deprecates the fw_err
field name in the request to exitinfo2.

We can still interpret the upper 32 bits of exitinfo2 for the user
anyway in case the request gets throttled. That makes the interface more
user-friendly.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 34 +++++++++++++++++--------
 include/uapi/linux/sev-guest.h          | 17 +++++++++++--
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f422f9c58ba7..8bc435cbd7e3 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -303,9 +303,10 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 
 static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+				u32 resp_sz, __u64 *exitinfo2)
 {
-	unsigned long err;
+	unsigned long _exitinfo2 = 0;
+	unsigned int vmm_err;
 	u64 seqno;
 	int rc;
 
@@ -322,9 +323,20 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		return rc;
 
 	/* Call firmware to process the request */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
-	if (fw_err)
-		*fw_err = err;
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &_exitinfo2);
+	if (exitinfo2)
+		*exitinfo2 = _exitinfo2;
+
+	vmm_err = _exitinfo2 >> SNP_GUEST_VMM_ERR_SHIFT;
+	/* The host may return EBUSY if the request has been throttled. */
+	if (vmm_err == SNP_GUEST_VMM_ERR_BUSY)
+		return -EAGAIN;
+
+	if (vmm_err && vmm_err != SNP_GUEST_VMM_ERR_INVALID_LEN) {
+		pr_err("sev-guest: host returned unknown error code: %d\n",
+		       vmm_err);
+		return -EINVAL;
+	}
 
 	if (rc)
 		return rc;
@@ -378,7 +390,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len, &arg->exitinfo2);
 	if (rc)
 		goto e_free;
 
@@ -418,7 +430,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
 				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+				  &arg->exitinfo2);
 	if (rc)
 		return rc;
 
@@ -480,10 +492,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
@@ -518,7 +530,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = 0xff;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -549,7 +561,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	mutex_unlock(&snp_cmd_mutex);
 
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
 	return ret;
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 256aaeff7e65..0654a652e4dc 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -12,6 +12,7 @@
 #ifndef __UAPI_LINUX_SEV_GUEST_H_
 #define __UAPI_LINUX_SEV_GUEST_H_
 
+#include <linux/errno.h>
 #include <linux/types.h>
 
 struct snp_report_req {
@@ -52,8 +53,15 @@ struct snp_guest_request_ioctl {
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
@@ -77,4 +85,9 @@ struct snp_ext_report_req {
 /* Get SNP extended report as defined in the GHCB specification version 2. */
 #define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
 
+
+#define SNP_GUEST_VMM_ERR_SHIFT		32
+#define SNP_GUEST_VMM_ERR_INVALID_LEN	1
+#define SNP_GUEST_VMM_ERR_BUSY		EBUSY
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.38.0.rc1.362.ged0d419d3c-goog

