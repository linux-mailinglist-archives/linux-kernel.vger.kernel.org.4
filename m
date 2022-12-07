Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0446450AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLGBCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLGBCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:02:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305FD65AE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:02:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e202-20020a2550d3000000b006f9d739c724so17271018ybb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 17:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qY65PLc6zHsJD/cqwYCmdutorWBhwj9IJtq2nl4qVh0=;
        b=N5JtHkFJu7EcrIkzhRX8/1J/XJJxYi8LLh2X9EJO+I5Bp9wooXQ+/J56glpbSKKHJY
         TiIkF68szGjOggKORR16V6ZfGu4b+cbrxQ9Jfu8eN3LoXwfSnCi4W5l2e+KHPeXnBIyt
         6fN4qkFNL/Jg2ntVUA/ajNI0wNapuKVqheulg/rOwVuUR4L61aD04Cdw6sblC71tDgYn
         J89lf8e7miOheJ7q/p0ukdsn0U8/xD0M7c2sOX/vV1JmcjE7UlvdbKmZ4ebtJdNSDXjn
         B6X/L81oP0qxNl+TKEdv1qLj+JFkgo4tWqiZid0ie7XcfMmKb82chnksBp7QedpL5Y5q
         uPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qY65PLc6zHsJD/cqwYCmdutorWBhwj9IJtq2nl4qVh0=;
        b=1TzmCJj4/ocIjGCSVOI73kQOwqCNMV3E3uIvsl30KG3UK2W/HW6Ot1WP/mhvW9otQ7
         UBC37yhhF3BdLk+ZsZqBWAVWA9nqIpQ7hbX2GDMbMKWsVvBnnQqqy1bqeNuvjHHj/WnJ
         AfuBbMB4MdWT94fpUnxdMW40DuBfDSFIuT0tOCO9z2QtjdUBxRpUVvZgewkwRTPmtir/
         Tl/S3ZQVoLRMG/WKQUkDvw2JB3ZKL1fg906ZZbwrckzB6/8mZmpPK48XYTC98fnk5znz
         blEMMA/sFEQu4vksVQTiMWsHrHd9e9uuJwwqzqBSzVIAxFzVX5dFWMf/LFdXzkPPMoIM
         y10g==
X-Gm-Message-State: ANoB5pkgfP5ufXoVYdR3WdEEk5gTns0W2vzdBvjQ5aVMQcM2spoEPbxk
        EcRXryWafaHFMqgOHo8+BPg/Grnp5b9hGH8Gmy0zNFCqlqP0DZQrkXLTdcdOrdZoXovgQ5WDPnJ
        hOnmT3+7j84aOubdOuvvM/goR7DymqB5r7G5NlFQJOaQDxwdF9E+diFjxyn5CHsI5hJSdeBDdqi
        CWttR195s=
X-Google-Smtp-Source: AA0mqf4nARsrbJ+BCZvEiNFaJC5TVn0q06r3enoph2iD8nzvZ8Qtq8gNSGhkVpLKa6Q2oRHUrKDwZAoBvWMSSn1DcA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a25:391:0:b0:706:d51a:bf7e with SMTP
 id 139-20020a250391000000b00706d51abf7emr3049290ybd.416.1670374958257; Tue,
 06 Dec 2022 17:02:38 -0800 (PST)
Date:   Wed,  7 Dec 2022 01:02:10 +0000
In-Reply-To: <20221207010210.2563293-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221207010210.2563293-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207010210.2563293-5-dionnaglaze@google.com>
Subject: [PATCH v9 4/4] virt: sev-guest: interpret VMM errors from guest request
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Haowen Bai <baihaowen@meizu.com>
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
small. Add BIT_ULL(33) for "host refused the request for throttling
reasons".

The driver interprets the upper 32 bits of exitinfo2 for the user
anyway in case the request gets throttled. For safety, since the
encryption algorithm in GHCBv2 is AES_GCM, control must remain in the
kernel to complete the request with the current sequence number.
Returning without finishing the request allows the the guest to make
another request but with different message contents. This is IV reuse,
and breaks cryptographic protections.

When throttled, the driver will reschedule itself and then try
again after sleeping half its ratelimit time to avoid a big wait queue.
The ioctl may block indefinitely, but that has always been the case
when deferring these requests to the host.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Liam Merwick <liam.merwick@oracle.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Haowen Bai <baihaowen@meizu.com>

Reviewed-by: Tom Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 Documentation/virt/coco/sev-guest.rst   | 21 +++++++----
 drivers/virt/coco/sev-guest/sev-guest.c | 49 ++++++++++++++++++++-----
 include/uapi/linux/sev-guest.h          | 18 ++++++++-
 3 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index e76393e389eb..fd8bf833f1cd 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -37,11 +37,12 @@ along with a description:
       the return value.  General error numbers (-ENOMEM, -EINVAL)
       are not detailed, but errors with specific meanings are.
 
-The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
-The ioctl accepts struct snp_user_guest_request. The input and output structure is
-specified through the req_data and resp_data field respectively. If the ioctl fails
-to execute due to a firmware error, then fw_err code will be set otherwise the
-fw_err will be set to 0x00000000ffffffff, i.e., the lower 32-bits are -1.
+The guest ioctl should be issued on a file descriptor of the
+/dev/sev-guest device.  The ioctl accepts struct
+snp_user_guest_request. The input and output structure is specified
+through the req_data and resp_data field respectively. If the ioctl
+fails to execute due to a firmware error, then the fw_error code will
+be set, otherwise fw_error will be set to -1.
 
 The firmware checks that the message sequence counter is one greater than
 the guests message sequence counter. If guest driver fails to increment message
@@ -57,8 +58,14 @@ counter (e.g. counter overflow), then -EIO will be returned.
                 __u64 req_data;
                 __u64 resp_data;
 
-                /* firmware error code on failure (see psp-sev.h) */
-                __u64 fw_err;
+		/* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
+		union {
+			__u64 exitinfo2;
+			struct {
+				__u32 fw_error;
+		                __u32 vmm_error;
+			};
+		};
         };
 
 2.1 SNP_GET_REPORT
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4a2a0a02985f..6f62b90de4da 100644
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
 
+static int rate_s = 1;
+module_param(rate_s, int, 0444);
+MODULE_PARM_DESC(rate_s, "The rate limit interval in seconds to limit requests to.");
+
+static int rate_burst = 2;
+module_param(rate_burst, int, 0444);
+MODULE_PARM_DESC(rate_burst, "The rate limit burst amount to limit requests to.");
+
 /* Mutex to serialize the shared buffer access and command handling. */
 static DEFINE_MUTEX(snp_cmd_mutex);
 
@@ -341,6 +352,16 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	if (rc)
 		return rc;
 
+retry:
+	/*
+	 * Rate limit commands internally since the host can also throttle, and
+	 * the guest shouldn't create a tight request spin that could end up
+	 * getting this VM throttled more heavily.
+	 */
+	if (!__ratelimit(&snp_dev->rs)) {
+		schedule_timeout_interruptible((rate_s * HZ) / 2);
+		goto retry;
+	}
 	/*
 	 * Call firmware to process the request. In this function the encrypted
 	 * message enters shared memory with the host. So after this call the
@@ -348,7 +369,15 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 * prevent reuse of the IV.
 	 */
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input,
-				     &arg->fw_err);
+				     &arg->exitinfo2);
+
+	/*
+	 * The host may return EBUSY if the request has been throttled.
+	 * We retry in the driver to avoid returning and reusing the message
+	 * sequence number on a different message.
+	 */
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_BUSY)
+		goto retry;
 
 	/*
 	 * If the extended guest request fails due to having too small of a
@@ -357,7 +386,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 * and thus avoid IV reuse.
 	 */
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-	    err == SNP_GUEST_REQ_INVALID_LEN) {
+	    arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		const unsigned int certs_npages = snp_dev->input.data_npages;
 
 		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
@@ -371,21 +400,21 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		 * user as an ioctl() return code.
 		 */
 		rc = snp_issue_guest_request(exit_code, &snp_dev->input,
-					     &arg->fw_err);
+					     &arg->exitinfo2);
 
 		/*
 		 * Override the error to inform callers the given extended
 		 * request buffer size was too small and give the caller the
 		 * required buffer size.
 		 */
-		arg->fw_err = SNP_GUEST_REQ_INVALID_LEN;
+		arg->vmm_error = SNP_GUEST_VMM_ERR_INVALID_LEN;
 		snp_dev->input.data_npages = certs_npages;
 	}
 
 	if (rc) {
 		dev_alert(snp_dev->dev,
-			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
-			  rc, arg->fw_err);
+			  "Detected error from ASP request. rc: %d, exitinfo2: %llu\n",
+			  rc, arg->exitinfo2);
 		goto disable_vmpck;
 	}
 
@@ -538,7 +567,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 				   sizeof(req.data), resp->data, resp_len);
 
 	/* If certs length is invalid then copy the returned length */
-	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
@@ -573,7 +602,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = SEV_RET_NO_FW_CALL;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -604,7 +633,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	mutex_unlock(&snp_cmd_mutex);
 
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
 	return ret;
@@ -754,6 +783,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (ret)
 		goto e_free_cert_data;
 
+	ratelimit_state_init(&snp_dev->rs, rate_s * HZ, rate_burst);
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
2.39.0.rc0.267.gcb52ba06e7-goog

