Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F648694DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjBMRZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjBMRZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:25:42 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF51C7CC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:25:38 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id l22-20020a17090aaa9600b00230aa3c1350so5271591pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYE72wBBiiOIkmNR0IrAMfqVr0bNZRZsH4P2ozCWwdQ=;
        b=XzDjeyTNmEDOZv1J/GMs95ZuzhvulIeIqWoUHNGOsgRgWyTt+AocuqO5nfR+mrAcUz
         +Oj9pRKKHPyqnfYZinkiSKQ80ySWox36cHyDVfkICTeF1Y8hukafGwcvuSN3KAMWHXvh
         gEuKGzfT8UUP9WVl7IjFCE8l2AUjgYhALQmpcNMRXurYdtX8NlYodqmZdcKsXVLCkPbF
         GfBTJ1eq1DCA0Fz6DVvS9JH8XE49FeSQVzp4QjDAcXtqIBHZU+AN6yRrW5qk5MeQ8YtL
         Pxex0Kn3lmFXr4LHdTwyQxjKL+5EGV4XFTHnXBPtfm0ltCSSll+o98NeNL2/9hP8P+/y
         0F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYE72wBBiiOIkmNR0IrAMfqVr0bNZRZsH4P2ozCWwdQ=;
        b=RsPaEnDeOGWTreFy/eLaWYLPDooMhBoKoJXpswHDckMzFCZE5ZQANeLB+kJXkFLjvv
         02dRcJZgpKHRey7KMIcJpcAWthvEc1r4F+RvykzqamRrZgykpMbTDBsPupTiiDibqKQ8
         Xr7CgVINH9O60CMxky0vYrhS2hrbF8mxZNuUvaTcBqMBCVlE5K7Bd4bynzVFlufVpT2v
         1Qu8O7f/krpdPJbdBnUIOK5v36InTzpe5KNaXybFjMClgBk/0gFyD/kL4nt8zOOindn+
         FwqeOgraeSCSuCYUWdJIVbAiAQWl37C6l5C5aC4YhdGRjKeFcJwIf5L8aY7HBn83z95m
         MYMg==
X-Gm-Message-State: AO0yUKUDHKfozMrXPX1kGbK1YhvMz1Oke9wZw6S0jizi5b1TvjXogY7G
        6Gg3lk0/7QnYwO5UGv/xqIO31bEzyaO3/mJiB4+8vNLdzQgQfcVf6yLJg90BnC0dlaTedmny4Ws
        O5n06FaxDF5kzxliG8eh7P6fZY+OpOIPoWnlB16TxupaBlrTSByeNX52yymIF0m2xxombYce2Mr
        05L1zBXIY=
X-Google-Smtp-Source: AK7set+/oMa/eDJWr+19ncnngdr8XtJvjuAuV5fho2BWwctkEs+8VHtYjt9MAsnyggJSg9nUmKaR5wCPC3vHstNkKw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:5914:b0:234:13a2:c91f with
 SMTP id k20-20020a17090a591400b0023413a2c91fmr460783pji.19.1676309137611;
 Mon, 13 Feb 2023 09:25:37 -0800 (PST)
Date:   Mon, 13 Feb 2023 17:25:23 +0000
In-Reply-To: <20230213172525.575766-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230213172525.575766-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213172525.575766-3-dionnaglaze@google.com>
Subject: [PATCH v14 2/3] crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL
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
        Borislav Petkov <Borislav.Petkov@amd.com>,
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
Cc: Borislav Petkov <Borislav.Petkov@amd.com>

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
2.39.1.581.gbfd45094c4-goog

