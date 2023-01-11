Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6C56663E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjAKTlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjAKTkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:40:19 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B06C21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:10 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id lk5-20020a17090b33c500b00228cb369d7aso4147951pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CyDQzH8B4WJdBMW81eQkpbu/YWlEf9SB9vsrKC6q4xQ=;
        b=qPbA8oIAcRy5vJzj3QtgCHMJPGGHNJVazVkddYaNjg3idQ4ieHDf9OMfXNBTgvEMnZ
         HZa0pc4hmfv2LmhCdZZvDKBBc5eDvKA1ztKxz40+FElmtEiA1Ki1yEsc7LxSFqTaHzYx
         yZNtrZnJ4WOeWulIfMmACopQ/VZ4KfkNaHSI0TYs+gpZ5n2od3wXJAOR7ZMoqCG8keyA
         AJ+TdxZOGCNBpiRsGZUttVALfXVnESnme0WsLJ2ezL8mZJBDncYOnti7bc6tyhvf6O0f
         bbkF+iSWCMHekaO30et+SUkWfk7YLvEnSsJUCx6fcLvgkn0XPZDQzDLxpRtKyI+NHKd8
         imIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CyDQzH8B4WJdBMW81eQkpbu/YWlEf9SB9vsrKC6q4xQ=;
        b=NXqOd8PoUOiNuQfmropCGJ3EYu2CXvAwqiIY4aJe3PO1bHtQqDmxGm4yRbAw/abaxU
         1sd6ujE9QYAdn6s3guDh8pkU0uPXfX1ZIEZ8i64oBuJ+sFUZT3gsUkeNu88NKS9V7vm1
         luOtNDLluN8UiuHSCINX4oZqzn2LrDY5HEJ2z/gpgTNRdOaAVG8B79aZ/Oa+OjSEW823
         1lk8eHGVe5sNUvJM7qvK9QhigCxwqtr131p6/cUO1AwkvWsV4YiYZLwXSpuB0HRevBet
         SChDl4DXPFJLQjqCADCqioTNq2yheatlRj26vwo+OkLXAz/EBpONId3vE6HN8TYZ3rr0
         fXuw==
X-Gm-Message-State: AFqh2krzA/tqvxTxVRaYzoV6Wd8GbfE0UpYxBuiw6qD7UCow3IYJrsys
        1hewMftK9uUGJ41p8tuB66wZlnbqASVGYVF4fodM0TH1wwSV0joSlDn9kwx8VSyTECYrnmUfqog
        30d7/PZPEx5Djdk0RznhaXbdZVXF2KpDxU5Fv8mq5EPIBd10svVyhGJWimiuFpfl2Nl0fo4dtzF
        WiTdUdVxc=
X-Google-Smtp-Source: AMrXdXvbY9VNIj2T2E710zA7GJLFvt3spPkxUpEpDdRT1wLK6CNm/+1GPi0rf2FCasQXURZqssqPG2KprH9cqeJXMA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a62:3081:0:b0:562:86a3:12fc with SMTP
 id w123-20020a623081000000b0056286a312fcmr5420493pfw.8.1673466009438; Wed, 11
 Jan 2023 11:40:09 -0800 (PST)
Date:   Wed, 11 Jan 2023 19:39:58 +0000
In-Reply-To: <20230111194001.1947849-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230111194001.1947849-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111194001.1947849-5-dionnaglaze@google.com>
Subject: [PATCH v11 4/7] virt: sev-guest: interpret VMM errors from guest request
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
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
Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Liam Merwick <liam.merwick@oracle.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Haowen Bai <baihaowen@meizu.com>

Reviewed-by: Tom Lendacky <Thomas.Lendacky@amd.com>
Reviewed-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 Documentation/virt/coco/sev-guest.rst   | 21 +++++++++-----
 drivers/virt/coco/sev-guest/sev-guest.c | 37 +++++++++++++++++++++++--
 include/uapi/linux/sev-guest.h          |  7 +++++
 3 files changed, 55 insertions(+), 10 deletions(-)

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
index e2fcb5215630..04c30e4da642 100644
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
 
@@ -339,6 +350,16 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
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
@@ -348,6 +369,14 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input,
 				     &arg->exitinfo2);
 
+	/*
+	 * The host may return EBUSY if the request has been throttled.
+	 * We retry in the driver to avoid returning and reusing the message
+	 * sequence number on a different message.
+	 */
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_BUSY)
+		goto retry;
+
 	/*
 	 * If the extended guest request fails due to having too small of a
 	 * certificate data buffer, retry the same guest request without the
@@ -355,7 +384,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 * and thus avoid IV reuse.
 	 */
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-	    err == SNP_GUEST_REQ_INVALID_LEN) {
+	    arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		const unsigned int certs_npages = snp_dev->input.data_npages;
 
 		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
@@ -376,7 +405,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		 * request buffer size was too small and give the caller the
 		 * required buffer size.
 		 */
-		arg->exitinfo2 = SNP_GUEST_REQ_INVALID_LEN;
+		arg->vmm_error = SNP_GUEST_VMM_ERR_INVALID_LEN;
 		snp_dev->input.data_npages = certs_npages;
 	}
 
@@ -536,7 +565,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 				   sizeof(req.data), resp->data, resp_len);
 
 	/* If certs length is invalid then copy the returned length */
-	if (arg->exitinfo2 == SNP_GUEST_REQ_INVALID_LEN) {
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
@@ -752,6 +781,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (ret)
 		goto e_free_cert_data;
 
+	ratelimit_state_init(&snp_dev->rs, rate_s * HZ, rate_burst);
+
 	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 52e994b68d90..49fc4341ac93 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -85,4 +85,11 @@ struct snp_ext_report_req {
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
2.39.0.314.g84b9a713c41-goog

