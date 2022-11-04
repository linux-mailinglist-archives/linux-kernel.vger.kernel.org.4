Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D3561A54D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKDXBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKDXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:01:15 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F534090F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:01:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id my9-20020a17090b4c8900b002130d29fd7cso6282919pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1B6bg0/4gt5SV65d/ktqlMru3581z5R83TjA3sPr58=;
        b=RjgBpaTzWWE7Wem4Ad1h+0w0yWytdCt0H+nmLMsNbpNoDv83vWEDTwTRH7BE/lMNu6
         YR/R2SYKF4NsTtGAhrJFvryv5WBOaNnth8PJD4jtPt0D8omx0df2m74V7T/8ifKO8UpP
         jA5WNSvRNCelax8WJIoNXExY69oEchfmAXrDrP27HhajLcmUZhEoKzIgP92GEYn2/QbD
         HPptYFWI2xRGTlHpkmRTXzNKplV5TOxuQf8AQ1XQW1SGiaSUTtu8kYIW1u3Wa1tT8qFO
         sji+u6CJUR/FWblJqpFF9AS2Kk6RrZJW0yJ7JtBWI+29h+CuGz4zPAMwNy+USyLGVmb4
         Eh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1B6bg0/4gt5SV65d/ktqlMru3581z5R83TjA3sPr58=;
        b=F4vC81XNhglcBWecDZs1jcL7wQ2vUT5Y6hNmOCQ4OoRv6ISAoVXW8H/Dk+1niNY4PW
         pE49ZHaNOqFpRFPijF4Zh5tOuuuikoJKUrhowRSoB3xE3hwwmJiKYGEA2jBlkevH8kSq
         eqgJzpzJyQrCzNO3NasoTj9JjyMh4LZw+LwKqrdqrWW+lTed2s+19p25DS/AGah7leBV
         kVUc0bcr28mcFSPCG2f19UvZU3xa2Dy3LoaqIoCFm/LIQccy82i2691HJTbyztUYBJRh
         eTxfSXCOMWYHTLmQXMswVVqp4hjHeHtY7zAWBbjquQSXiBgfnZKfjx5+4nO5/EVgdTuD
         jAfA==
X-Gm-Message-State: ANoB5pkXHQeAKBHmG3bf9T/3mT6LYMAM0rnrvA3wbIpCtj8vJ8/EhwX4
        4tSVcc9jNmMNbY9/KeNkEwxzitniwf6EXbESN6+CkFEhynsRvt4jtPHYaZTpgMNzqKsgbBth0B1
        auvCr436sDsrD/AaXa80KFzVB7PaMsZqget79uLJvi34g469Yc5bOFgrgkl3x3ESfIYKPTcW+nw
        UXSHBpbfQ=
X-Google-Smtp-Source: AA0mqf5qoqn941PNfnGG6kwZzBz3eSXajRdGQ/Co9HAKgbnyQuBtnIp14vqXzayUcZDAY7K79PQ2hwR5pzgW6ARmzw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90b:1081:b0:20a:fee1:8f69 with
 SMTP id gj1-20020a17090b108100b0020afee18f69mr187016pjb.0.1667602871519; Fri,
 04 Nov 2022 16:01:11 -0700 (PDT)
Date:   Fri,  4 Nov 2022 23:00:40 +0000
In-Reply-To: <20221104230040.2346862-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104230040.2346862-5-dionnaglaze@google.com>
Subject: [PATCH v8 4/4] virt: sev-guest: interpret VMM errors from guest request
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
 drivers/virt/coco/sev-guest/sev-guest.c | 49 ++++++++++++++++++++-----
 include/uapi/linux/sev-guest.h          | 18 ++++++++-
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 5615d349b378..e8a9c07ea897 100644
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
 
@@ -341,9 +352,27 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
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
 	 * If the extended guest request fails due to having to small of a
@@ -351,21 +380,21 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 * extended data request.
 	 */
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-		arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+		arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		const unsigned int certs_npages = snp_dev->input.data_npages;
 
 		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 		rc = snp_issue_guest_request(exit_code, &snp_dev->input,
-					     &arg->fw_err);
+					     &arg->exitinfo2);
 
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
 
@@ -518,7 +547,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 				   sizeof(req.data), resp->data, resp_len);
 
 	/* If certs length is invalid then copy the returned length */
-	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
@@ -553,7 +582,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = SEV_RET_NO_FW_CALL;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -584,7 +613,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	mutex_unlock(&snp_cmd_mutex);
 
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
 	return ret;
@@ -734,6 +763,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
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

