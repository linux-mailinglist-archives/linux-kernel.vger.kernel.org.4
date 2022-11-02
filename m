Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633016165EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKBPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiKBPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:18:58 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC7167E2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:18:54 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id u3-20020a056a00124300b0056d4ab0c7cbso5270677pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsTBbsttl90Fa+N19NVctUh1BzwZcwgswyZuI7qyxHk=;
        b=NYrwyTkAcp/4ElX1vA9LUtq4zvk9flLUJtFdLplOY2Vey+8UYvBYzFPe9J/IqbYjba
         f9i1mdiFc05FBu6DOHdZpBaFOMLehkwHxZLU5pXqIQwb+8hwNHxzpFvw7pvqVgF1dM+O
         VNeRzrra+5VeID/LqLW5iANI88adDScQlLnXXPI3aqkFAvkZaxAeWJb6u/Do09dDbF+o
         e3Q4DuW1FlEhb7uPeeOp5BbDGWmjPnkboJvssNrSSg8CPYnFLZD0/GsP9ytx3TB3ZgEZ
         NFIR8BjsZTNPkxzNxSvNLA43UqZV2fTWfl/JPKxdwknbSR3IITt0XTHGsvsmFH76wu+/
         T0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsTBbsttl90Fa+N19NVctUh1BzwZcwgswyZuI7qyxHk=;
        b=7eXGsTwYcM+IaqzqkAvMtqX/8VOHHcHgQyAkPXqHJywTDgJY3Fw+kpn5ZxWeFQLxsF
         ChpLreuoLiZwgvXRE9QRCwpUwOJCqYqBCmKNWL/Ua+OJWP6j8iIiBTVUJ83RPl+RlxFT
         /Yb2p7wEVX3hPUroIWGvDbOzaQ3/0RokyT4hnu5oXn/72ZKM7vJNqKf3eG2bgjgDWv1j
         NfsZ/to0nrpotblDDwpDTfC0ntPyYVEOb02/PdNdd/sV12yg6bn+WZeWzHNjsdR7J0KP
         ja7B3eVvKiovf3CfpBQ/FUBoYVILU+2DcI86dsuVNCdtNPDmrrTNM2/74KY7056mwYKj
         pTtw==
X-Gm-Message-State: ACrzQf02M0DaU7Jn+NMFw/KrUoq95uVOXbCZ0jNDZnHYgF7gaTTDwNAz
        WctJUo9KgDmn7qvGb+eZpPk8gHzrWqow9zpRGaZbSfAAbdGy5C3Z/eVzV4k1Is5IpGeEiIUpv+V
        2Oj3gnctdRzjgBcniOX3qeyLuupTOasJGI4Wqdj1RNlc+kMJ9T0ClpQ4Y/RXd85KIZxSTfeYhy6
        PEAkg2mm8=
X-Google-Smtp-Source: AMsMyM6G3cNXhg1xnlTNdgHyoJAE9tueaFF9ca2neboJEhQZ5QkDMxCmmCloXJOICVn+QSrdSwJN964qEbO3BKC18A==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:860a:b0:186:7eab:afa2 with
 SMTP id f10-20020a170902860a00b001867eabafa2mr25212259plo.46.1667402334319;
 Wed, 02 Nov 2022 08:18:54 -0700 (PDT)
Date:   Wed,  2 Nov 2022 15:18:36 +0000
In-Reply-To: <20221102151836.1310509-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221102151836.1310509-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102151836.1310509-5-dionnaglaze@google.com>
Subject: [PATCH v5 4/4] virt/coco/sev-guest: interpret VMM errors from guest request
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
again after sleeping half its ratelimit time to avoid a big wait queue.
The ioctl may block indefinitely, but that has always been the case
when deferring these requests to the host.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 50 ++++++++++++++++++++++---
 include/uapi/linux/sev-guest.h          | 18 ++++++++-
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 0508c2f46f6b..43e110ad4aa9 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
+#include <linux/ratelimit.h>
 #include <linux/set_memory.h>
 #include <linux/fs.h>
 #include <crypto/aead.h>
@@ -48,12 +49,22 @@ struct snp_guest_dev {
 	struct snp_req_data input;
 	u32 *os_area_msg_seqno;
 	u8 *vmpck;
+
+	struct ratelimit_state rs;
 };
 
 static u32 vmpck_id;
 module_param(vmpck_id, uint, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
+static int rate_hz = 2;
+module_param(rate_hz, int, 0444);
+MODULE_PARM_DESC(vmpck_id, "The rate limit frequency to limit requests to.");
+
+static int rate_burst = 1;
+module_param(rate_burst, int, 0444);
+MODULE_PARM_DESC(rate_burst, "The rate limit burst amount to limit requests to.");
+
 /* Mutex to serialize the shared buffer access and command handling. */
 static DEFINE_MUTEX(snp_cmd_mutex);
 
@@ -305,6 +316,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *exitinfo2)
 {
+	unsigned int vmm_err;
 	u64 seqno;
 	int rc;
 
@@ -320,9 +332,33 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	if (rc)
 		return rc;
 
+retry:
+	/*
+	 * Rate limit commands internally since the host can also throttle, and
+	 * we don't want to create a tight request spin that could end up
+	 * getting this VM throttled more heavily.
+	 */
+	if (!__ratelimit(&snp_dev->rs)) {
+		sleep_timeout_interruptible((rate_hz * HZ) / 2);
+		goto retry;
+	}
 	/* Call firmware to process the request */
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input, exitinfo2);
 
+	vmm_err = *exitinfo2 >> SNP_GUEST_VMM_ERR_SHIFT;
+	/*
+	 * The host may return EBUSY if the request has been throttled.
+	 * We retry in the driver to avoid returning and reusing the message
+	 * sequence number on a different message.
+	 */
+	if (vmm_err == SNP_GUEST_VMM_ERR_BUSY)
+		goto retry;
+
+	if (vmm_err && vmm_err != SNP_GUEST_VMM_ERR_INVALID_LEN) {
+		pr_err("sev-guest: host returned unknown error code: %d\n",
+		       vmm_err);
+		return -EINVAL;
+	}
 	if (rc)
 		return rc;
 
@@ -375,7 +411,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len, &arg->exitinfo2);
 	if (rc)
 		goto e_free;
 
@@ -415,7 +451,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
 				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+				  &arg->exitinfo2);
 	if (rc)
 		return rc;
 
@@ -477,10 +513,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
@@ -515,7 +551,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = SEV_RET_NO_FW_CALL;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -546,7 +582,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	mutex_unlock(&snp_cmd_mutex);
 
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
 	return ret;
@@ -696,6 +732,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (ret)
 		goto e_free_cert_data;
 
+	ratelimit_state_init(&snp_dev->rs, rate_hz * HZ, rate_burst);
+
 	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
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
2.38.1.273.g43a17bfeac-goog

