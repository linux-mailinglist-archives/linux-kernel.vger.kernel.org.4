Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10966663DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjAKTkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjAKTkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:40:10 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24C39F96
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:08 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id b196-20020a621bcd000000b0058a63dc105eso3482114pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8W4FH7mFIpVRdnY5skujk6nCPAJ4sesqHc9zDdEW0s=;
        b=IF6bG7y6P+/fyh2juFdCBqZAZykQrxC8/Vm0GE5HmM6OxW12uKLT/dtRZAWDhMxB+d
         dkiawoVtjIwhjo34pV/6UTuHh0u2ClKSRJnWy1XwXXBJcrHGAIp0OeWebvNjf+1+f+0i
         7ILSBx7UCXoHIsBP2UMpqG3sBq7p/t/VdawaoUWPYzAnd0DJIeAS5kmj561hIyiu1Uob
         I5gM9i5f5bh+uesfHys7f9yRa6RlGAFF1A4PTwCEXb5xzpkV9vWbtWfCv9t6B1+drSBR
         WG3GNCUByYQBO6Jc9AQvYimY2JAtUvyfWo2IDqPU0bFEDaV78SJQD+g8FtStiP67tMvk
         Vx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8W4FH7mFIpVRdnY5skujk6nCPAJ4sesqHc9zDdEW0s=;
        b=IIO9DAjYYmZ9KcoqlWFwlWNWTTOaGZZEOMcxOp4TgKYCwKqwuT4EY1gRlu7Mgggr77
         C2oszkHODLRZcL71+MrBp6py3nntPp/FxMo/xbVxwHCt9e0D+wK+bpyh0FV4zL7grjs3
         6rOZJN+Ubp7CIsy0gMKGEoNM5Tfi0khDuZpGcu1yZCvijLnMhRclzZHN/1FsTKkU7qUu
         IRaF5nOLBlLGdGJvVVyWApYp8JchL6d2EpQur6EcGMdZCIiW0G0ewaP9w86rj5vDkwsZ
         /scuYwlHtEbUp5QZkm/zxA/gWIqzIowQbrwp76P38z0CNRb2+8vqxI170zkGuE6PYCfJ
         yDyg==
X-Gm-Message-State: AFqh2krj+iul/5kte+2MXibgJAIkZJsConTF7n9WuxpfsStxQqVA2dUw
        7hRjFRao+Abcrt9cefX/KGAgzWVkJ4I3tkJGll2WAAq3zgNr8IUuTOkdHnHXNLk37r3D6gt9s+L
        y0vK1H0LvcaETK7oY4TP+zwv/PRVtZn6LwFRIS32OPc0exsMXa6stwfYD0l53wlM6CaLixsE+Hk
        s02H5ytOk=
X-Google-Smtp-Source: AMrXdXullgIk5Od9JoOE6RkbMRJw+bgqLxHKZ1NwCMe5CScZ7ktTdffp1urqcFQ6zinZNL53fnPSTQkPGlsBkNkRxg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:7c02:b0:192:fb0a:35aa with
 SMTP id x2-20020a1709027c0200b00192fb0a35aamr1611751pll.78.1673466007663;
 Wed, 11 Jan 2023 11:40:07 -0800 (PST)
Date:   Wed, 11 Jan 2023 19:39:57 +0000
In-Reply-To: <20230111194001.1947849-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230111194001.1947849-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111194001.1947849-4-dionnaglaze@google.com>
Subject: [PATCH v11 3/7] virt: sev-guest: Remove err in handle_guest_request
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        Haowen Bai <baihaowen@meizu.com>,
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

Instead of using the fw_err field of the argument, which is a bit of a
misnomer, instead change to exitinfo2. The exitinfo2 field type is a
temporary typedef that will be removed.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: Liam Merwick <liam.merwick@oracle.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Reviewed-by: Tom Lendacky <Thomas.Lendacky@amd.com>
Reviewed-by: Borislav Petkov <Borislav.Petkov@amd.com>
Reviewed-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 43 ++++++++++++-------------
 include/uapi/linux/sev-guest.h          | 12 +++++--
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4ec4174e05a3..e2fcb5215630 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -318,11 +318,11 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
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
 
@@ -334,7 +334,8 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, arg->msg_version, type, req_buf,
+			 req_sz);
 	if (rc)
 		return rc;
 
@@ -344,7 +345,8 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input,
+				     &arg->exitinfo2);
 
 	/*
 	 * If the extended guest request fails due to having too small of a
@@ -366,24 +368,22 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		 * of the VMPCK and the error code being propagated back to the
 		 * user as an ioctl() return code.
 		 */
-		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+		rc = snp_issue_guest_request(exit_code, &snp_dev->input,
+					     &arg->exitinfo2);
 
 		/*
 		 * Override the error to inform callers the given extended
 		 * request buffer size was too small and give the caller the
 		 * required buffer size.
 		 */
-		err = SNP_GUEST_REQ_INVALID_LEN;
+		arg->exitinfo2 = SNP_GUEST_REQ_INVALID_LEN;
 		snp_dev->input.data_npages = certs_npages;
 	}
 
-	if (fw_err)
-		*fw_err = err;
-
 	if (rc) {
 		dev_alert(snp_dev->dev,
-			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
-			  rc, *fw_err);
+			  "Detected error from ASP request. rc: %d, exitinfo2: %llu\n",
+			rc, (u64)arg->exitinfo2);
 		goto disable_vmpck;
 	}
 
@@ -430,9 +430,9 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!resp)
 		return -ENOMEM;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len);
 	if (rc)
 		goto e_free;
 
@@ -470,9 +470,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
 		return -EFAULT;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
-				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
+				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
 	if (rc)
 		return rc;
 
@@ -532,12 +531,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 		return -ENOMEM;
 
 	snp_dev->input.data_npages = npages;
-	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
+	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
 				   SNP_MSG_REPORT_REQ, &req.data,
-				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
+				   sizeof(req.data), resp->data, resp_len);
 
 	/* If certs length is invalid then copy the returned length */
-	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+	if (arg->exitinfo2 == SNP_GUEST_REQ_INVALID_LEN) {
 		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
@@ -572,7 +571,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = 0xff;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -603,7 +602,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	mutex_unlock(&snp_cmd_mutex);
 
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
 	return ret;
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 256aaeff7e65..52e994b68d90 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -52,8 +52,16 @@ struct snp_guest_request_ioctl {
 	__u64 req_data;
 	__u64 resp_data;
 
-	/* firmware error code on failure (see psp-sev.h) */
-	__u64 fw_err;
+        /* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
+
+        union {
+                __u64 fw_err; /* Name deprecated in favor of others */
+		sev_guestreq_err_t exitinfo2;
+		struct {
+			__u32 fw_error;
+			__u32 vmm_error;
+		};
+	};
 };
 
 struct snp_ext_report_req {
-- 
2.39.0.314.g84b9a713c41-goog

