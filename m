Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9A66A487E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjB0RrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjB0RrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:47:12 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99B24103
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:47:11 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id g13-20020a63f40d000000b005015be7b9faso2188444pgi.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bx7GMwBIOHxrHorivUo24uUgRWemT3+721qT8hA0RRM=;
        b=fL0sCAtJCbBQmUG9K1il5cmtYgU+ic6RembCIXUKuPBlJzRuirBy8XzEmXwgH1PU31
         kkpjFWighHghmJVkVQltONa/wKox7B8FVpYn27OhLvhYDq9l3gFmp2uavdK4dbsIRPIs
         p6hT2TYtw2O1FmzxBjIR6E3nJWQCqGc/ICMdXPprWdFVQlEBTlgYjA8qiVLqAihMPQ25
         K9iFdZVJOJrtL6AugVJN5qR2lA0rJOhOrTeaYjBIryyDheil7WOfb5fzdqMp2ivFylsv
         tjFfvQlIsax/515iS33dcPRRbtggsuz+LI7vS0bZ992wD4rJLMsA6tbdVdfFaiMvE5K+
         9rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bx7GMwBIOHxrHorivUo24uUgRWemT3+721qT8hA0RRM=;
        b=RK0ET4xhhESVHZX6TIwuKwVJdhyeRBtOYrnnc8kuyu+UnY48EPX+sRx6ffKP2zIWnf
         snvN/xXMSMr1aYG645z8/nJXbBNlHLV+RNSykX0qJ2X4lvHf42LOCHGV1ZXH/4h7rZGY
         VKzRIUUP7fD91w0ehRF/jXlKQrZ8x1JaLLSIRMcyUNAL7RDXeOBD9myalru1HymS4BM+
         5Sjysapmq/A9JY3lHMFVxY4uehQBEShdz+58mCwdHJ5rjitkMB8nG0ipEr66Ew74GO93
         DQW3qPvo7snFCboIjReZY+FCVSyM1VopV8oVdyHGidBe07QtN07vK4029uMWwba6Ef99
         vgMg==
X-Gm-Message-State: AO0yUKWnpwRe7z83KAF6DfjMe/s53UFI3TwJxNEPWgsLPlN0nrEwJ93m
        lpcu8djomyNOHMy3TBvH7jQj7gRz48F2fNCMng==
X-Google-Smtp-Source: AK7set+vnOMHR/cn8CdD2DfS9+dSlM7HFryOJfCIJPWETMAvw/+OV5UIcKBg4NX/PtA17R+5rlfEtd6GoQ73nZQ9bA==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a63:921c:0:b0:503:6bbe:20cf with SMTP
 id o28-20020a63921c000000b005036bbe20cfmr606208pgd.0.1677520030680; Mon, 27
 Feb 2023 09:47:10 -0800 (PST)
Date:   Mon, 27 Feb 2023 17:46:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227174654.94641-1-ackerleytng@google.com>
Subject: [PATCH] tools: Copy linux/align.h into tools/
From:   Ackerley Tng <ackerleytng@google.com>
To:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, seanjc@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides alignment macros for use in selftests.

Also clean up tools/include/linux/bitmap.h's inline definition of
IS_ALIGNED().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/include/linux/align.h  | 15 +++++++++++++++
 tools/include/linux/bitmap.h |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/linux/align.h

diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
new file mode 100644
index 000000000000..2b4acec7b95a
--- /dev/null
+++ b/tools/include/linux/align.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ALIGN_H
+#define _LINUX_ALIGN_H
+
+#include <linux/const.h>
+
+/* @a is a power of 2 value */
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
+#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
+#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
+#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif	/* _LINUX_ALIGN_H */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index f3566ea0f932..8c6852dba04f 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -3,6 +3,7 @@
 #define _TOOLS_LINUX_BITMAP_H
 
 #include <string.h>
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/find.h>
 #include <stdlib.h>
@@ -126,7 +127,6 @@ static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 #define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
-#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
 
 static inline bool bitmap_equal(const unsigned long *src1,
 				const unsigned long *src2, unsigned int nbits)
-- 
2.39.2.722.g9855ee24e9-goog

