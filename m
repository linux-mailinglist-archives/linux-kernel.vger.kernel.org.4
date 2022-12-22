Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6236548BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiLVW5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiLVW5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:57:52 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33152331A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:57:51 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id h2-20020a170902f54200b0018e56572a4eso2202348plf.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bf2X1QulTABAjppphK1WtbbKetIcc9UEvFPDSkChvOM=;
        b=ARX3aIgXzy6h9kdLi36xCFWthR2eJFlU1dfQGCxpJb5ElYCAbrbHrbstanVqlv3QO7
         kAaHD6zMDzmX6B8EEwQ+ao225uZjam1YWYIPHVkigpMngikShSBcZL0H0BQP/BqdewQB
         TA8padtw69JP56cbSr14OlltB6qAMwzijIoJpGJR2KwFfca5OaZkoyRQEANshN7PS/Gf
         EWpX3vEqwJUeYWUeSLsNtjWKa1HaQPTare+FAG0tVLIR2olLc/Ll434PEvfJQxSiMrG3
         hxqhuu8cEOMLr1O41Cpt9rbnjYiSBkKDCmajnyfhGzXF8kLSUNtodLA972LfUN6JXYmD
         8F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf2X1QulTABAjppphK1WtbbKetIcc9UEvFPDSkChvOM=;
        b=8MlGpOH6/8V2Et3VgZsoYWxAPXuiq+SzhOZ+MniTW+f1xym2w2YgpKZUdJ16fY4tTu
         lYKliGN5ZikE+rGcSwjFd0Dtb/QJqVhAYf3I1eJDPsYBS2Qg5hiK+ZmXZbXT/Qsw/pSz
         9HmEnqBUFqWsD8tDHSwP2p3RVACA39dCrfN+B6WTd7mk5y6rOXXSMT73CUoRbCIPUV+W
         w34kfo6y0Np52hzhpa/S8jnK8mYGeUTAlXi+j1PLrA1u7m21U9pgOuQtlnX/eiD4c74j
         ZmM8YwZa7lv9wVtJDOXeyBUAfykBdoxz0cwwI4wxloiHP3vBPYxq1XiYjiZCKLjM2vQO
         tPYA==
X-Gm-Message-State: AFqh2kpRjYg4Yrt7oYFm415Hbd+39Kak728/UgwmQWrPwpSgMEBZM+k6
        6kKtrIsDd4tDib5KRIlDXRDVfgvYK6TKj4WI5Ss=
X-Google-Smtp-Source: AMrXdXsVYAD3T62OrRCTqfeAXFvIh5kzJ2n4pwU4wj2lmcZ0om268gKJaKJWZbdxud6UsawILWRXpdbUZqw8vj/tYBQ=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:b708:b0:186:e222:9f05 with
 SMTP id d8-20020a170902b70800b00186e2229f05mr357108pls.61.1671749871054; Thu,
 22 Dec 2022 14:57:51 -0800 (PST)
Date:   Thu, 22 Dec 2022 22:57:47 +0000
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=samitolvanen@google.com;
 h=from:subject; bh=8djKtpmItzJSdoedHo/r14Z1ICB7PLl41D0EoxSDHUo=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjpODrW5EdBK+WDX1K+cl9BXXwO2qz7Y6LdRFfb7oL
 z3ZHFHiJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCY6Tg6wAKCRBMtfaEi7xW7iJoDA
 Cku9VbQc4bt5+ibFTmeKQ8AJhgIQwAAQkKJyhBdboiejtn4LSSMoUCeC5iMFy97m4i1G3ExMvO9Gzh
 0NDnkKc0VoCxOD03z9lVa4Tn/CQmAJ9IkPCjGmqIz0a0D79vbgjOyLnz9h3GAk+BaYq09b1dIJyqN7
 HxcMXEv5L8TeuThzGT3/llNp5YblOOCuxjNB+ivyDcNl+C2rgfBBHjTR5DEGAFw+L9toR/3UOpposb
 mbIhqhIgHuT6AterKsLFYQGu+vAFtM3iV3tVMJ7lI5Ut/yOz0r6nTcgCB9G0rsqnP7JoOXMI5g6fY+
 NV2qJVzNgvzJQIZvIr9PB0yqEF74H0qmQLWjU+DJop1qtyTR3tJbd6ufwmfYEDuePLFktHtEv2yYIM
 X1izCoo5WWFHD3LjWWIhf8JJ/rf4+Re70CfIX/73IcOiAdNcskvJ2RP0EHGRYGmxiHI6G4gvQy3QNc
 ZCjHURfFTkuck16HOOUuxkXcoNd0SI26lpiq6krmZS3Gk=
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222225747.3538676-1-samitolvanen@google.com>
Subject: [PATCH] cfi: Fix CFI failure with KASAN
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>
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

When CFI_CLANG and KASAN are both enabled, LLVM doesn't generate a
CFI type hash for asan.module_ctor functions in translation units
where CFI is disabled, which leads to a CFI failure during boot when
do_ctors calls the affected constructors:

  CFI failure at do_basic_setup+0x64/0x90 (target:
  asan.module_ctor+0x0/0x28; expected type: 0xa540670c)

Specifically, this happens because CFI is disabled for
kernel/cfi.c. There's no reason to keep CFI disabled here anymore, so
fix the failure by not filtering out CC_FLAGS_CFI for the file.

Note that https://reviews.llvm.org/rG3b14862f0a96 fixed the issue
where LLVM didn't emit CFI type hashes for any sanitizer constructors,
but now type hashes are emitted correctly for TUs that use CFI.

Link: https://github.com/ClangBuiltLinux/linux/issues/1742
Fixes: 89245600941e ("cfi: Switch to -fsanitize=kcfi")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index e7fc37a68069..10ef068f598d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -41,9 +41,6 @@ UBSAN_SANITIZE_kcov.o := n
 KMSAN_SANITIZE_kcov.o := n
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
 
-# Don't instrument error handlers
-CFLAGS_REMOVE_cfi.o := $(CC_FLAGS_CFI)
-
 obj-y += sched/
 obj-y += locking/
 obj-y += power/

base-commit: 8395ae05cb5a2e31d36106e8c85efa11cda849be
-- 
2.39.0.314.g84b9a713c41-goog

