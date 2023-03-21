Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262DA6C35AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjCUP3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjCUP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:28:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDF9113C4;
        Tue, 21 Mar 2023 08:28:28 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:28:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679412507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irVXUrexhjwqxjsn3+Qqg46NzZR3tUhU2ORep83Lm4c=;
        b=SfGMJxfQKHYhrOVdxHg6wmpcX+M0y3AiHngHrmkIVuBcaLIP3p55fzKzzKP/EDOrdXMlKC
        qXXJC/cGaxH8XsRAlq1LoQu+YAa4qR/bBHxF9eVBZv8FtBIBkLaeHsAILxPszxKDYn3Z2F
        fORN1bBFilg1EkqeZXTG3mok0v7Gxo9iReP/5n/pL2HDkp3OaVK9HhNkCBEIhZvjjWzoIb
        +dKUFt5/9OuFlfkAxOvVnZyYAieDxAg5c5U7Yu5RE+Cl0/xqgqtzvixy4u6DfUTnLiIsh2
        et78CL8jaC/xjZ/R/EYOIpTTm52xBl0d62V8Bmibz4zUczqvJLdeAevKjViA6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679412507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irVXUrexhjwqxjsn3+Qqg46NzZR3tUhU2ORep83Lm4c=;
        b=ID+O38O07tAUDxidRPxV2+NGSDPjKHh1VcTUMeQ7AZzpMHYxXL7uGVN89M3Ie19P6b6YDe
        gLkoqjcPW3jPgXCQ==
From:   "tip-bot2 for Peter Gonda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL
Cc:     Peter Gonda <pgonda@google.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221207010210.2563293-2-dionnaglaze@google.com>
References: <20221207010210.2563293-2-dionnaglaze@google.com>
MIME-Version: 1.0
Message-ID: <167941250712.5837.17612643714782256267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     efb339a83368ab25de1a18c0fdff85e01c13a1ea
Gitweb:        https://git.kernel.org/tip/efb339a83368ab25de1a18c0fdff85e01c13a1ea
Author:        Peter Gonda <pgonda@google.com>
AuthorDate:    Tue, 07 Mar 2023 20:24:39 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 21 Mar 2023 11:37:32 +01:00

crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

The PSP can return a "firmware error" code of -1 in circumstances where
the PSP has not actually been called. To make this protocol unambiguous,
name the value SEV_RET_NO_FW_CALL.

  [ bp: Massage a bit. ]

Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20221207010210.2563293-2-dionnaglaze@google.com
---
 Documentation/virt/coco/sev-guest.rst | 4 ++--
 drivers/crypto/ccp/sev-dev.c          | 8 +++++---
 include/uapi/linux/psp-sev.h          | 7 +++++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index bf593e8..aa3e4c6 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -40,8 +40,8 @@ along with a description:
 The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
 The ioctl accepts struct snp_user_guest_request. The input and output structure is
 specified through the req_data and resp_data field respectively. If the ioctl fails
-to execute due to a firmware error, then fw_err code will be set otherwise the
-fw_err will be set to 0x00000000000000ff.
+to execute due to a firmware error, then fw_err code will be set. Otherwise, fw_err
+will be set to 0x00000000ffffffff, i.e., the lower 32-bits are -1.
 
 The firmware checks that the message sequence counter is one greater than
 the guests message sequence counter. If guest driver fails to increment message
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e2f2592..823c67a 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -444,10 +444,10 @@ static int __sev_init_ex_locked(int *error)
 
 static int __sev_platform_init_locked(int *error)
 {
+	int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
 	struct psp_device *psp = psp_master;
-	struct sev_device *sev;
-	int rc = 0, psp_ret = -1;
 	int (*init_function)(int *error);
+	struct sev_device *sev;
 
 	if (!psp || !psp->sev_data)
 		return -ENODEV;
@@ -475,9 +475,11 @@ static int __sev_platform_init_locked(int *error)
 		 * initialization function should succeed by replacing the state
 		 * with a reset state.
 		 */
-		dev_err(sev->dev, "SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
+		dev_err(sev->dev,
+"SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
 		rc = init_function(&psp_ret);
 	}
+
 	if (error)
 		*error = psp_ret;
 
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 91b4c63..1c9da48 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -36,6 +36,13 @@ enum {
  * SEV Firmware status code
  */
 typedef enum {
+	/*
+	 * This error code is not in the SEV spec. Its purpose is to convey that
+	 * there was an error that prevented the SEV firmware from being called.
+	 * The SEV API error codes are 16 bits, so the -1 value will not overlap
+	 * with possible values from the specification.
+	 */
+	SEV_RET_NO_FW_CALL = -1,
 	SEV_RET_SUCCESS = 0,
 	SEV_RET_INVALID_PLATFORM_STATE,
 	SEV_RET_INVALID_GUEST_STATE,
