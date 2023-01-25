Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B9267B961
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbjAYSbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjAYSbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:31:06 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAFC59B53
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:30:53 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y8-20020a170902b48800b00192a600df83so11115492plr.15
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LDihqDdjJzBFwlE6EGb/YMKGvnMoJPM29h5JVaD3qZ8=;
        b=WY2OkWUAGsYQB8fUh0kueSfOifgWZoAgnIHbgApXWLzv6IvLxLIkktAFKRFXWR9ttk
         CAKIeXpyx5SNCSnhz6Id3ty4Bf30YhqHJJJLb/bIjWEiAW0Xt8eI6/xLPCj6HNHket6i
         DUS8d2snBUPx6BFHPTdSaSSPEP08sufRGqyVwZpvV4elB4r4xOlVS+tSxXBgz1w72OT+
         NmLeaWXIjRh5mHn8RZ3AOw02xf0adg9SBvqAKzu62v1M6BRX1OtamfZV1H0JtVGVxClJ
         v9kbmlIhTfqQ4pwdpKiYwlW9fbhbguhiN4PYHEt5PLX4rm+8uJYzVzStuGalQQQJSSza
         CvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDihqDdjJzBFwlE6EGb/YMKGvnMoJPM29h5JVaD3qZ8=;
        b=xTNUnTttubGGlrObxMCXcb61xYLDS32d/AgqKSfnOKIyNfEsXRFZ4bL6leQU5ru2Lo
         KgMrk/GZPsAWARo4spDY73sxvsufWLf1g7FUQozbcST2ZtenlbiuGnzrXsqb80o41Lkl
         7GQ0LnGu7czAwPF6Es0W5AlPCf4rOtjWlKY/s9xY3OJy5lKtTLCK6YSoZQznwGhgyAE/
         4FwVLHRECq8hW5BLxVSXoy7AOsiTiUzj4egrIdEZUTVevEFZok/M9Awu1dRb0fDvifir
         umQU7fxReznVaABmfGtReClKdFDQJG34nW9AQS21AwHgnmRhQ/o19S48FQqfIDoIpFmO
         oYMg==
X-Gm-Message-State: AFqh2krcYrWjKMuDrvtUyDqFADb2ggcPFHxMpTNYcNZU75Oi1HIIWcOs
        4y6Y8NohR2MuefApFby192QnWEemyVpjBQ==
X-Google-Smtp-Source: AMrXdXs3K6C/DKfsGkslkNYNCtKzmbn+z5Tfc5Hjp/uw1zTNrtdJq3DKR9fR6aqN5xXcdi0C2EY0xXOMY3zQ5A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:d0d:0:b0:477:31bc:348f with SMTP id
 c13-20020a630d0d000000b0047731bc348fmr3096187pgl.72.1674671452544; Wed, 25
 Jan 2023 10:30:52 -0800 (PST)
Date:   Wed, 25 Jan 2023 18:30:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125183047.2679976-1-cmllamas@google.com>
Subject: [PATCH] kbuild: fix trivial typo in comment
From:   Carlos Llamas <cmllamas@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing underscore in CONFIG_DEBUG_INFO_BTF_MODULES.

Fixes: f73edc8951b2 ("kbuild: unify two modpost invocations")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c1ead4cd2342..561cf98f6889 100644
--- a/Makefile
+++ b/Makefile
@@ -1542,7 +1542,7 @@ endif
 # Build modules
 #
 
-# *.ko are usually independent of vmlinux, but CONFIG_DEBUG_INFOBTF_MODULES
+# *.ko are usually independent of vmlinux, but CONFIG_DEBUG_INFO_BTF_MODULES
 # is an exception.
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 KBUILD_BUILTIN := 1
-- 
2.39.1.456.gfc5497dd1b-goog

