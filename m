Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A6561A205
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKDUQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKDUQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:16:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A14D45ECA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:16:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3697bd55974so55304827b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzksqxZzngSMnVq4LNIxjbY1eQuHqjVmZsqNyLkHpLQ=;
        b=jhPIbPD5BQTq81GOSTK237jTlF2fdO6oPYPy+cM2vMFS3sS/w17VHxLXqWaLre2baw
         Dg7vRG1TECmSbDjloLx5MYR0wTohEYRdFSI6Le9y/hLxMWYStbgHTcS/8BEY0Mye6mQM
         5RcisHx3NbfpWxsqiQ73t9SFwtfVCqnRVuNd39fTiWo93R/G3mXGXiaoqMQS7qT7C49Z
         /RffMJbCcphU6MVtcGMdXHMCWzCx/6NfqoO7JfmYlrdAkYtyB7WlsWnIPM+KAVphsdCM
         +9Rbm6jEmHJa6iqME4PmT4m0vVBdJGcKfoL+JYMwGtFUikhaeAxiyeEr0rPSJSvn+bNu
         R+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzksqxZzngSMnVq4LNIxjbY1eQuHqjVmZsqNyLkHpLQ=;
        b=6bx/LiigbMv8R+oAgDzxAPgUAVPtRaf0sSTJD6E/l4GJCh2zEpvR3KHOvnxwAwQiVN
         qBfdXRV36QH5/NbXaL8ifv9QObe/jlxqluUum0CNkq5q6K/s6MTNCcMl9rwndeMhPsHF
         4dFjDMRo7gizRLLDydULrECouafHGCePQCJcvr9twXfnueUxR5yV+szTyPOip/KIG8lD
         fBLKIdgOGg4xcpe1VK1MZWYhl8rbxvdMUb0lYFYcEzcmDrfHt5DSu0vGjGWXbsTYQs/W
         KfM07+vNSQu8v1CYkgf0ttEYDQQ3mS54VX6zhY2xjBCikcxoDiH6s6s0r9P96oHJ40sA
         NQRw==
X-Gm-Message-State: ACrzQf1FYV5PiRchYe5NcQWN6UkQumtzOWCXWMMhANjkMashHGasGdem
        MfgkMHN390RanhculwZFRkPzNlEjCpe+iYYMtCcnk+uyRRUAWQl3Pv0tmwLx8GxQhgd5gqjTrHf
        7VM3pBjoTn/yJ4Orc5PtHLIxtzoLn/jIYD2MpRt0OGIDJJ0PNlYd+kM9asWFiakSXBtmH/Xlgpm
        gl8kgsamg=
X-Google-Smtp-Source: AMsMyM5X0sev4Pv04ITUvgt8NibKSAXimserJ6yKIuWolEr0LKxTvByNxl3a3Cmotpmx+rxeQUHTsncxkcLRCVCsnQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a25:9d11:0:b0:66e:4fad:e153 with SMTP
 id i17-20020a259d11000000b0066e4fade153mr35592854ybp.484.1667592989294; Fri,
 04 Nov 2022 13:16:29 -0700 (PDT)
Date:   Fri,  4 Nov 2022 20:16:13 +0000
In-Reply-To: <20221104201616.2268815-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221104201616.2268815-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104201616.2268815-2-dionnaglaze@google.com>
Subject: [PATCH v7 1/4] crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL
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
the PSP is not actually called. To make this protocol unambiguous, we
add a constant naming the return value.

Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: John Allen <john.allen@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>

Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 include/uapi/linux/psp-sev.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 06fc7156c04f..97eb3544ab36 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -444,7 +444,7 @@ static int __sev_platform_init_locked(int *error)
 {
 	struct psp_device *psp = psp_master;
 	struct sev_device *sev;
-	int rc = 0, psp_ret = -1;
+	int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
 	int (*init_function)(int *error);
 
 	if (!psp || !psp->sev_data)
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 91b4c63d5cbf..1ad7f0a7e328 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -36,6 +36,13 @@ enum {
  * SEV Firmware status code
  */
 typedef enum {
+	/*
+	 * This error code is not in the SEV spec but is added to convey that
+	 * there was an error that prevented the SEV Firmware from being called.
+	 * This is (u32)-1 since the firmware error code is represented as a
+	 * 32-bit integer.
+	 */
+	SEV_RET_NO_FW_CALL = 0xffffffff,
 	SEV_RET_SUCCESS = 0,
 	SEV_RET_INVALID_PLATFORM_STATE,
 	SEV_RET_INVALID_GUEST_STATE,
-- 
2.38.1.431.g37b22c650d-goog

