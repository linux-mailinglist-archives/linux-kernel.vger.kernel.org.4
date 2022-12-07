Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF9D6450AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLGBCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLGBC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:02:28 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574A44F18E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:02:27 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d3-20020a056a0010c300b005728633819aso14053316pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 17:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq4nsNsu12aUA8GuDAR6Rk/S1sw8FFUkbgn/FDY4oJQ=;
        b=jHhlxV/UdgCOLo3JvbhKjdSCPKfo+9YiKMvILOwzfOeo+1FL0arji+cdZXGjyGCoxB
         M36Mkfxno3gFNpEf4awKk+CQ6qVw/+bPB9N3JN7odi6kusKJ8pMqmLoTFH9hxcnRsdl6
         lBG+/2HEsd9cwAnxSD2pSZT/LKUNUXn/GcXYbDPLpFZ8z8bk1r8bxD3gx9bszDl+gPst
         xRs8ai9nkPxFjAFwtWY2MqlhWQsLn7BG8YMcnELOd5ziGzib4Kj6KqCSf2NJOmwP2TOM
         7PLlqgNyqF3z7iuoect4es25mOXHQeCRutMjntilg60uY0KsLhwrUTGi9uV+m0oaynkI
         UMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq4nsNsu12aUA8GuDAR6Rk/S1sw8FFUkbgn/FDY4oJQ=;
        b=l1oQkxw+lxtNXr+IRJHRULuLLCTFSSmmHVnrl1bGpjs+koHn9EqF6/uUzKzZCV0pxU
         9/5Gy/TSjFM3W7Do8MKOtZFUDj9LbszNo3TSj1PzpVpy6Q0lVrDfDb+hXzg2MdY5Xh0N
         2ksCcfDYywFULZ1SYPp6x1JlbvdxHE4HXf9v7dWcZ0mceBtQjUYH2LgjIFCuP1P5zeLU
         1pqaJIiQ9Jh7BVq/KwvGzfdqY1/9hUA3Pqgu56J8d+f4GYY4ao25lpkzw2eu89wGGCJN
         6mufmyHsgKXkJruhkUnQZyTJHWPWnJDx6ktF1Jf9QcsNWEk0Qj7ti9KGjpoXR1bfUcTY
         Lf3w==
X-Gm-Message-State: ANoB5pl8sYUBV8jv7r5G2pHuPuhK+rVVFZ4UtwAI33azhnOlXCAebJ5H
        6BN1w7EnCSnn/skFTC6t014qfmyed+Tu3kRPTdSFsgNaJ77M4KsIH5KKfEZubvKtuoPPgjVj3NH
        No9gnHEQXqt7NTpHW0P6PgrMNqyNMiSXGkZW+H4dTulg/3iK1EXNvi5e3GYPo4ooU/Pw+eH5uxj
        JpssOroQE=
X-Google-Smtp-Source: AA0mqf7KPhbYWHDviXrCu4S/UJq0eb4mK4Ff0kr7Wz7VyQepAfO88MjO7fplHFKp5jjSMC9Zds9mF0OxKsOTXNqQhQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:1f0f:b0:56e:7424:bc0f with
 SMTP id be15-20020a056a001f0f00b0056e7424bc0fmr81486148pfb.11.1670374946793;
 Tue, 06 Dec 2022 17:02:26 -0800 (PST)
Date:   Wed,  7 Dec 2022 01:02:07 +0000
In-Reply-To: <20221207010210.2563293-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221207010210.2563293-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207010210.2563293-2-dionnaglaze@google.com>
Subject: [PATCH v9 1/4] crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Glaze <dionnaglaze@google.com>
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

From: Peter Gonda <pgonda@google.com>

The PSP can return a "firmware error" code of -1 in circumstances where
the PSP is not actually called. To make this protocol unambiguous, the
value is named SEV_RET_NO_FW_CALL.

Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: John Allen <john.allen@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Borislav Petkov <bp@alien8.de>

Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 Documentation/virt/coco/sev-guest.rst |  2 +-
 drivers/crypto/ccp/sev-dev.c          | 22 ++++++++++++++--------
 include/uapi/linux/psp-sev.h          |  7 +++++++
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index bf593e88cfd9..e76393e389eb 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -41,7 +41,7 @@ The guest ioctl should be issued on a file descriptor of the /dev/sev-guest devi
 The ioctl accepts struct snp_user_guest_request. The input and output structure is
 specified through the req_data and resp_data field respectively. If the ioctl fails
 to execute due to a firmware error, then fw_err code will be set otherwise the
-fw_err will be set to 0x00000000000000ff.
+fw_err will be set to 0x00000000ffffffff, i.e., the lower 32-bits are -1.
 
 The firmware checks that the message sequence counter is one greater than
 the guests message sequence counter. If guest driver fails to increment message
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 06fc7156c04f..ac205f78a595 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -440,12 +440,19 @@ static int __sev_init_ex_locked(int *error)
 	return __sev_do_cmd_locked(SEV_CMD_INIT_EX, &data, error);
 }
 
+static inline int __sev_do_init_locked(int *psp_ret)
+{
+	if (sev_init_ex_buffer)
+		return __sev_init_ex_locked(psp_ret);
+	else
+		return __sev_init_locked(psp_ret);
+}
+
 static int __sev_platform_init_locked(int *error)
 {
 	struct psp_device *psp = psp_master;
 	struct sev_device *sev;
-	int rc = 0, psp_ret = -1;
-	int (*init_function)(int *error);
+	int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
 
 	if (!psp || !psp->sev_data)
 		return -ENODEV;
@@ -456,15 +463,12 @@ static int __sev_platform_init_locked(int *error)
 		return 0;
 
 	if (sev_init_ex_buffer) {
-		init_function = __sev_init_ex_locked;
 		rc = sev_read_init_ex_file();
 		if (rc)
 			return rc;
-	} else {
-		init_function = __sev_init_locked;
 	}
 
-	rc = init_function(&psp_ret);
+	rc = __sev_do_init_locked(&psp_ret);
 	if (rc && psp_ret == SEV_RET_SECURE_DATA_INVALID) {
 		/*
 		 * Initialization command returned an integrity check failure
@@ -473,9 +477,11 @@ static int __sev_platform_init_locked(int *error)
 		 * initialization function should succeed by replacing the state
 		 * with a reset state.
 		 */
-		dev_err(sev->dev, "SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
-		rc = init_function(&psp_ret);
+		dev_err(sev->dev,
+"SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
+		rc = __sev_do_init_locked(&psp_ret);
 	}
+
 	if (error)
 		*error = psp_ret;
 
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 91b4c63d5cbf..e8cfb8bde0d7 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -36,6 +36,13 @@ enum {
  * SEV Firmware status code
  */
 typedef enum {
+	/*
+	 * This error code is not in the SEV spec but is added to convey that
+	 * there was an error that prevented the SEV Firmware from being called.
+	 * The SEV API error codes are 16 bits, so the -1 value will not overlap
+	 * with possible values from the specification.
+	 */
+	SEV_RET_NO_FW_CALL = -1,
 	SEV_RET_SUCCESS = 0,
 	SEV_RET_INVALID_PLATFORM_STATE,
 	SEV_RET_INVALID_GUEST_STATE,
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

