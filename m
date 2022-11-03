Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7727617393
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKCBKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKCBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:10:47 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18755FBD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:10:46 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x11-20020a056a000bcb00b0056c6ec11eefso90431pfu.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 18:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HyZsB0Vwzo7IzN1ked5Cd3Ddxr3Z9Vwhd+P65i1+rEk=;
        b=edynv05y2slAK4iCYIit3g9z2RR+Y6QMecSPtEGQR0+8ha7AuDLA97NGcz95GzONLO
         k0ANPukr5J2zLboMfgShqvPwiBp+n50l4D1AZYt6a+O27iPXVurz3lz38g4SOMYjDb2t
         RSNdECxviz+jT1YbNLiPZ1Yz6719zBOWazm1hTtTvdFVxJixV6bt2Gd9inbsgiveLJtZ
         /zobthD+X74SJbAgD3Fqd9qpxqVUmZlKjJ8k6omSGe7u0dcvWzfjDQvYIBXsubMKdFEa
         1tzvKfQ7eCcwFVE3B6Uvd9mY4OqkUG0ICnCZshGigfbxQ4VlPvBN41W2GYcfOwZy53dW
         gUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyZsB0Vwzo7IzN1ked5Cd3Ddxr3Z9Vwhd+P65i1+rEk=;
        b=aWvz7+JgBtcJfbf5resqzM0JlH+gIH9ePIKDu2Ws4i70IOVO2udShgAWH30M+y+bb1
         meOXtTBpSI9RJeQaWel5aSDuNssIRji+bkIY/XLLczoPi19RZoPsfzFh8vQtEX2BkLiN
         tGLTKAUf4wZF6Im2sE91sRMgmJQKbYf0fzu+IPkhqGoAGba7eJwv4IQC0U/apEMAmJQf
         7YelUvZfnPJykTuFRsrAoIqTZYh/83G9doakihHf1HnqLA/SfZnq1D+fqqk0aXrRiUwB
         aLP8zR/H6UA3PAKCg1nxViyk5lHM2syIHc//plVdikzzxbEheJ/P0p8Dk+WtFAWG3lO3
         SjQQ==
X-Gm-Message-State: ACrzQf0xL5DlXMt8Ny3x+N+xCCuq5NfvgvisgnkAB3vde4bTTIWv0pT0
        J0w982NV0UWx8kPaTjLdGI0XBvhc60Z8JGVMjZqhsV++Z2WekAtpi0kE5VYs3XneXb+97nkOetq
        7agSh8KzgRIam8hzpvxwvI75b+0B5dJIWzBnWB67T19lzXxAkNdW9lgQSz7l4+5ov4PkGcQ8e+q
        sGPyzFGp4=
X-Google-Smtp-Source: AMsMyM6fEe2bVHRFbmcR7fCQ27rLiW3HNabOApfW1eCUErHAbpaVeuYFoosRjYIWtOiAG+2z6Ldf42MPyQ69OyQcug==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:aa7:9212:0:b0:562:b5f6:f7d7 with SMTP
 id 18-20020aa79212000000b00562b5f6f7d7mr28251603pfo.70.1667437846061; Wed, 02
 Nov 2022 18:10:46 -0700 (PDT)
Date:   Thu,  3 Nov 2022 01:10:35 +0000
In-Reply-To: <20221103011038.1542614-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221103011038.1542614-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221103011038.1542614-2-dionnaglaze@google.com>
Subject: [PATCH v6 1/4] crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL
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
2.38.1.273.g43a17bfeac-goog

