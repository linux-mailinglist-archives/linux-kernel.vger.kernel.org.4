Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38316165ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiKBPTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiKBPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:18:53 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5787EE12
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:18:49 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id w191-20020a6382c8000000b0045bf92a0b5aso9655380pgd.22
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qaiHnucIuESfgaU82SYs4BBLu5lj4TzR9ZvyujAVUhw=;
        b=ks6DEiY7Yjv82ixwPD+aLivrFmZgJi9a6H7mv4TZxFHnfBcEscfr1HjMkr3s1Q8bP0
         YC66C654TPJ69cHNKSx7a2UoJEJJ7g6Gv4c3ZevWz0zmyxZNNyM9YjKRE4lC7j3Nw9VZ
         xzTxMEEYkKLl6EmAI/vhSViP+b3XePn0rvF9X3B0hfB0wauSF52j7MS1gbHNwsN4SQqI
         uvnLLDqIJg2jayeD1MWWpMPUxB+BYIlwj2uK0l6mphmMC4eEcGPXtuBE4SPXja20hh9C
         96PrBNEPSJolYqCA2NXwQx04/zZwjH5vRQDKJxDBQ8a/BQXwAUDGY4O/JPjYh7+gr1Ho
         Bn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaiHnucIuESfgaU82SYs4BBLu5lj4TzR9ZvyujAVUhw=;
        b=E9UQzz3nDxlTLOQCVXD0O0+AojOwFMZ8h3/krttzz6lShm5P+9OB5IhH2e03l7yCvf
         PKude57O9lZPIluJrgOdSaQR5wJRYNsgbzEfbtLVGabr02NEXkznQzPAxUK3VqsONwTZ
         prrqtG8UjnWTdqWOYcHpPJbrnVct4Mt/HmDJkucCWZ2sgSgy+t+BktGY6mqpU3GKesal
         dwWTaHS97DcvqItzIf2a19420UFk3Txoig3JCmmcJaaLcVE4Cnec6bHn487ntgn0hc1Y
         fg1VKJeV0LTggFEPdhvLzyUs/SDwPJMxh+prQH2BHt39jlwqfHjwKx+y2pdpBbz5fDBs
         ZSSg==
X-Gm-Message-State: ACrzQf0kuUozVQO5Zx6OaiCe7NCEKcDRR4yxhnttsgWNFQ87HaZ7jVEP
        pZJqKpIZOSnS0F9SCRvwN3NtAJh8axiPquRJKSSCygKtX9LZFxKEhdB7v6CKYdqWrQbrY511tdO
        F92gvYe8XrwVW+UnLrCeA3pWA3skfNjXpFy9p3Fj77hRUdb4bTwcXm4+6BzT6ybF/rLgoqe3Jh2
        rChIowSeU=
X-Google-Smtp-Source: AMsMyM7l8krDcdu95IlWeiGEMc7ghRttgd/8fL8ps9BgNBAbMwb5TlsoMItVIGuun6d0S0GN9ruKVqzTfko9ou6pjw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:10cf:b0:563:34ce:412f with
 SMTP id d15-20020a056a0010cf00b0056334ce412fmr26111677pfu.67.1667402329297;
 Wed, 02 Nov 2022 08:18:49 -0700 (PDT)
Date:   Wed,  2 Nov 2022 15:18:33 +0000
In-Reply-To: <20221102151836.1310509-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221102151836.1310509-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102151836.1310509-2-dionnaglaze@google.com>
Subject: [PATCH v5 1/4] ccp: Name -1 return value as SEV_RET_NO_FW_CALL
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>
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

The PSP can return a "firmware error" code of -1 in circumstances where
the PSP is not actually called. To make this protocol unambiguous, we
add a constant naming the return value.

From: Peter Gonda <pgonda@google.com>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andy Lutomirsky <luto@kernel.org>

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

