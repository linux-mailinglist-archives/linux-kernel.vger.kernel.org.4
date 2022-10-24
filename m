Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35C060BF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiJYAX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJYAX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:23:26 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B4812D805
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:47:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id oo18-20020a17090b1c9200b0020bdba475afso9534960pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+6LJgKl0wRgTRLkq4f9veim6S7HXx9ZKXbkLf1zrmQ=;
        b=qAquYynksnnVrt4f8uMTPnplyMcJL6gGvw6BcX9ETlFFAXWc7XeOmnjigS6Hk0RpJM
         GkCMlq1TCF5o28LCAPZ/RuFkgTw9BdSBEt+bB7lbM52ppb6/Yt+jFvxxbnjjHWjcSGrh
         VJskB3Gdm/nLTkw0sS7BvyHSiL7wCAKdIYi1qs0i4ppvBISk+DnFFu00la9g6j+qws5a
         fU8qzKJnoDartK3Pz7Sv7YvzJnvp7lA8bng0iZ+KH6an/Hg4Yl4gJ+huobq7QOG6AbGZ
         WqvhLddmwlZqkHd8u97quSJZEYRPRm8j8QMlyLpL1/B134pcwlnlm0jCJiIg82Dgakep
         hQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+6LJgKl0wRgTRLkq4f9veim6S7HXx9ZKXbkLf1zrmQ=;
        b=OWN1HgyUXLRXjJH0iRpe51f98cZbyz4R0hiUrqwrONN57n2j5ZK3khVudp1UBHCqof
         I/u25VoDo4Tm00RpVnuvq2JPUVzRFaveHomoufT0Tk6tGrynwq0l7ddkJza44eZUh9pG
         h6cX9DxbshXPtD9WL+0tUH2vdBTUEh01MpmFtECrP8iUmwlO1/j1xTRvwiduVNDlH92V
         1JEgpbCO9D24wkLAdC/PSZJkBAIeMVoWHnLAn+bGcL/4jbP9dBtKsuP6aal//j+wm4f5
         DTDbNE9MEeGUd7Tu1M1/BZ5+1NCL+oVgR9OvnxjoJbFv4+c7V/i9/nZP4qjBGJeMTxoz
         6mWA==
X-Gm-Message-State: ACrzQf2/XqYMs5A1EBvhxWKa7tOlOIL8TbTaJZsJvlT+1N5a0MG3CthT
        PwYZmnhlpK5FXnB4XUnYu+jvLVQX4oAV2IIvPZg9oBedoNULzeL1ckhDPaeMA9OIU63GBUZpZ4r
        4WS70tGqwaKgh69jTjPw66kecG/CKKwzMcwRfvF89nv41iuW+F94YahCBvg1QwvXXXy0Lxy8DoI
        H3Bve1peE=
X-Google-Smtp-Source: AMsMyM7CJZBoRqR8Rytppb1gpLhmlHZT9T5SzOmgibjmwfUnYFqXwfE3g796HdY6J/oimW0q4kHND83XELy9Wz78/A==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:ced0:b0:17f:92d6:f5ec with
 SMTP id d16-20020a170902ced000b0017f92d6f5ecmr35114513plg.34.1666651622229;
 Mon, 24 Oct 2022 15:47:02 -0700 (PDT)
Date:   Mon, 24 Oct 2022 22:46:54 +0000
In-Reply-To: <20221024224657.2917482-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221024224657.2917482-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221024224657.2917482-2-dionnaglaze@google.com>
Subject: [PATCH v4 1/4] ccp: Name -1 return value as SEV_RET_NO_FW_CALL
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
index 91b4c63d5cbf..fb61e083d42e 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -36,6 +36,13 @@ enum {
  * SEV Firmware status code
  */
 typedef enum {
+	/*
+	 * This error code is not in the SEV spec but is added to convey that
+	 * there was an error that prevented the SEV Firmware from being called.
+	 * This is (u32)-1 since the firmware error code part of EXIT_INFO_2 is
+	 * the lower 32 bits.
+	 */
+	SEV_RET_NO_FW_CALL = 0xffffffff,
 	SEV_RET_SUCCESS = 0,
 	SEV_RET_INVALID_PLATFORM_STATE,
 	SEV_RET_INVALID_GUEST_STATE,
-- 
2.38.0.135.g90850a2211-goog

