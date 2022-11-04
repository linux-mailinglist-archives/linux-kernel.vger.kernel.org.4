Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7ED61A209
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiKDUQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiKDUQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:16:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9D449B7A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:16:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so5843636ybj.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpTNvOAKvMITV2ooJfE8EO+LheKjmaYiLAbcqV/4LPU=;
        b=XHyhZ5fN3nHm3SwWdcMmoSVqANSskYo2rtyOrO+JILxrF+COGrKUd4vJgU08yROoLm
         hlFrAa+Li3vm4+pVV75Px+LdDt3u6NUsYvPPW9nxzSLYbNaeC64yIcc2dwN5hoyibUn2
         VCO0L7GGTRqejjE79xumUF37xD79F6K8kGISKM+m+YcVYh5A+SGNpUZo3rY9UGM2Amhv
         NuZAqyH6j8lAILPN2DqeUnFAHlRgEQVq4V0CRZPgo0mN3jaZ1g6E5a6YAZizZYPZLB11
         Im3wZQ6pqBYTfSpWzx9J8aMiRkrQXoYcDs6KQWjB+BVFxlniZXMymhZwdXQ5afdf6eyW
         SW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpTNvOAKvMITV2ooJfE8EO+LheKjmaYiLAbcqV/4LPU=;
        b=wiABPehPHAWir9S6IbIkLqWhamZER77q7CIY+4NpR6NN2jC/OP9g4yxryIe9o7pmyS
         oSqu6os+ryqQUnbyYxjDGMQKsYFO+AgFNL87r6fadTooFyHjXzu9HFW+6Mfg42BfH+GV
         5/qzjweykn5AS8isf494YDErC5ewt63CG5E+km6bEsSV//HsJNZ1HKVKuJOzD+8W0zsw
         ZMwENUIeGuN7eEffMH/3OjBIfSLQn3lUBK2yiNlrSCDsqgszuDTyHjDrMcRB0qjRogac
         iWNoGU/g0XuTzMWyNeOkEOO/e6AoEdC9aTTZS9L7uIJh2UEpHhbr08f/lWF1T+3mkhE7
         Xo6A==
X-Gm-Message-State: ACrzQf1qkp3W1Lb+1QHPGazAUZRI1sVeOhYDXbYW0abd74KKCfaQxDdM
        mw18OM0C9gePryQixI5qREfDPuxNk9WYC3oRHs2tlmHy+F8WomqdOMqqsafAojB9KciM+C+ZeJy
        JsSkFkueeDPKzWAzDpu72jpj8nBBqG3kR067tJH09gtoUCQ/DRmsuhh9jMQWwll4U8Czynle29g
        oU1esmqE0=
X-Google-Smtp-Source: AMsMyM42vNzZTKGUsO66JPJWsEro+Sr0p4YhKgjABXQlUhBV0ymXMrMWnywUVJtAli8kfrm5aK+JLTLW6uNcFsd/BQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a81:6f88:0:b0:35f:df0e:3a7a with SMTP
 id k130-20020a816f88000000b0035fdf0e3a7amr36532680ywc.416.1667592994735; Fri,
 04 Nov 2022 13:16:34 -0700 (PDT)
Date:   Fri,  4 Nov 2022 20:16:16 +0000
In-Reply-To: <20221104201616.2268815-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221104201616.2268815-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104201616.2268815-5-dionnaglaze@google.com>
Subject: [PATCH v7 4/4] virt: sev-guest: interpret VMM errors from guest request
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
Cc: Peter Gonda <pgonda@google.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Liam Merwick <liam.merwick@oracle.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Haowen Bai <baihaowen@meizu.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 51 ++++++++++++++++++++-----
 include/uapi/linux/sev-guest.h          | 18 ++++++++-
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 5ebf87651299..9c49f38aba44 100644
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
 
@@ -324,6 +335,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *exitinfo2)
 {
+	unsigned int vmm_err;
 	u64 seqno;
 	int rc;
 
@@ -339,16 +351,35 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	if (rc)
 		return rc;
 
+retry:
+	/*
+	 * Rate limit commands internally since the host can also throttle, and
+	 * we don't want to create a tight request spin that could end up
+	 * getting this VM throttled more heavily.
+	 */
+	if (!__ratelimit(&snp_dev->rs)) {
+		schedule_timeout_interruptible((rate_s * HZ) / 2);
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
 	/*
 	 * If the extended guest request fails due to having to small of a
 	 * certificate data buffer retry the same guest request without the
 	 * extended data request.
 	 */
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-		*exitinfo2 == SNP_GUEST_REQ_INVALID_LEN) {
+		vmm_err == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		const unsigned int certs_npages = snp_dev->input.data_npages;
 
 		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
@@ -360,8 +391,8 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 
 	if (rc) {
 		dev_alert(snp_dev->dev,
-			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
-			  rc, *fw_err);
+			  "Detected error from ASP request. rc: %d, exitinfo2: %llu\n",
+			  rc, *exitinfo2);
 		goto disable_vmpck;
 	}
 
@@ -410,7 +441,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len, &arg->exitinfo2);
 	if (rc)
 		goto e_free;
 
@@ -450,7 +481,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
 				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+				  &arg->exitinfo2);
 	if (rc)
 		return rc;
 
@@ -512,10 +543,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
@@ -550,7 +581,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = SEV_RET_NO_FW_CALL;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -581,7 +612,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	mutex_unlock(&snp_cmd_mutex);
 
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
 	return ret;
@@ -731,6 +762,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
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
2.38.1.431.g37b22c650d-goog

