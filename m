Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC146746593
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjGCWCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGCWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:02:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D61A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 15:02:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b80b343178so27839345ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688421737; x=1691013737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAWDleebt7l7zEdHolSBzV/uMqJ/GbmesvF/kh1hWdE=;
        b=IXUFd9b7r8hl56U5SRDsR/9UzGwQrMUhusT7pJ+/s1PMHNHuXpGbV/qH9LSNcb2QCE
         7wWxGUDbHCDaiLI3LCDHk/af2JTtHQKwEb3M6xabA02Q+hHBxzscJLvEUWkL6LYq+C+Q
         wxIcFWk9Fy739XWpsae7KH3EeNO1+thgjWL1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688421737; x=1691013737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAWDleebt7l7zEdHolSBzV/uMqJ/GbmesvF/kh1hWdE=;
        b=LkQ01bM7erlLIpBsJLGaumfI/dR70K9rT+bP++uJpyrpGbQgMdsQJ/qwVVM73+REn8
         GE0xGV+2HxOGFPVQPUswgI91I+LzMhSI4ppJrNpVbNrskyoZPTxZqfaSWhfUjaYBHq7I
         CdEzCtGjV+UIqAsdbMG8j6yLzElY1SdU2PyYpRnw6J7lArjBgO7/qte/9eoBcw/GPhaF
         4fBgGSM6C0q7iZFL0pUhtPbaHmiO6GUV54/YfAlrqTa28peGGEIGw3RULpfyEmOAbXh+
         eealaVdlJUN6IRobho2UKB+sB+OdQXXnVOygFE5FES8LaKahPTy8ms59m6o/jaJqLAFK
         e4TA==
X-Gm-Message-State: ABy/qLZvA7xQ7zp1nc6wtf6E/neBnd1k9uGpcs11NqEXQ61r7x99kV3a
        jGKcAF5UACKXdcYpqRFt59L90Q==
X-Google-Smtp-Source: APBJJlHUHWr2MjXiHeX7bobS1UK0VoqLRvSBRANzQe02d9Qqtt6YW1du4/YXNyR/ImLJVczn5z7Wpg==
X-Received: by 2002:a17:902:e80b:b0:1b7:dfbd:4df0 with SMTP id u11-20020a170902e80b00b001b7dfbd4df0mr11826113plg.45.1688421737271;
        Mon, 03 Jul 2023 15:02:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902760900b001b54a88e6adsm15542571pll.309.2023.07.03.15.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 15:02:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] Revert "fortify: Allow KUnit test to build without FORTIFY"
Date:   Mon,  3 Jul 2023 15:02:13 -0700
Message-Id: <20230703220210.never.615-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2499; i=keescook@chromium.org;
 h=from:subject:message-id; bh=WhBhSzaqPfsnfMGWEUr5gEyNmyjToakD/wquBaPOXCA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBko0Vlt1pEL46RtDsfoMNRHGroygYArBX4j7Rld
 FW/fRc9MOiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZKNFZQAKCRCJcvTf3G3A
 JuoPEACFu2sAmQKtF/kkJeAEikAJMuV0uAcXZ2lN8TFXfGai71DEo5NXH4IIPfqwpB9q3E0aDys
 B6AlSwvYkS79nsy8DVfXqyeNxbDUDw2ZPc58slmqT/JwvDjTG3xp81v1hRYR6yZohOvnn2u59ld
 GILrPRPghL5oCnukkrtsI/1UqOyvwsQPoQSiUuAQ8Lr9Fk/OQFwTvDswfMJYi6n+vvfCD4J4mbm
 imJZfhnbNEyYAI/ZXs2IAVrd0oF8OqqCvA1b4vzIfus2q3cCuYG/sb7j6Wpjj1ZPTis7EgPnmBl
 4LBq/eTYNtCtzsSKgRj+J9x1yW6G1bbk2GoL0+1ZzYKnKihzdp3nI0S+etKF3dTbUZoF8Gr3Lr0
 SKtQiNHxjnaEyoJPjoz+gEEiQLp70Reg3ZdptuqAbvDNMmEJni2DiGc2OEW4mS7txz22ItPtj7S
 TJxWw2aYT7xiI/2fMZQagSaRqmbYzaYZNrE1nC7honDekkLXJCL7sP/49xMuii0TXbLKidjCRa9
 HQH1OY4HgTaBkX2dGMYwihWgKU5soAdKkuIDXwWTnqGmZyvY7kExxZ1YvW+ES8rvRlbMAKDhGTB
 83YWsn8KNqalTYdiG6Xl4FF7SfBnFVWqIXhHxKOUQQY9vFEwelexfCjE29S7Bm1f4108ROMq3Ow
 t03RMeG jtGGMPdQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a9dc8d0442294b426b1ebd4ec6097c82ebe282e0.

The standard for KUnit is to not build tests at all when required
functionality is missing, rather than doing test "skip". Restore this
for the fortify tests, so that architectures without
CONFIG_ARCH_HAS_FORTIFY_SOURCE do not emit unsolvable warnings.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdUrxOEroHVUt7-mAnKSBjY=a-D3jr+XiAifuwv06Ob9Pw@mail.gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'll take this via my hardening tree and send a PR to Linus before -rc1.
---
 lib/Kconfig.debug   |  2 +-
 lib/fortify_kunit.c | 14 --------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c2a7608ff585..6c6a7ee9f1f9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2645,7 +2645,7 @@ config STACKINIT_KUNIT_TEST
 
 config FORTIFY_KUNIT_TEST
 	tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && FORTIFY_SOURCE
 	default KUNIT_ALL_TESTS
 	help
 	  Builds unit tests for checking internals of FORTIFY_SOURCE as used
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 524132f33cf0..c8c33cbaae9e 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -25,11 +25,6 @@ static const char array_of_10[] = "this is 10";
 static const char *ptr_of_11 = "this is 11!";
 static char array_unknown[] = "compiler thinks I might change";
 
-/* Handle being built without CONFIG_FORTIFY_SOURCE */
-#ifndef __compiletime_strlen
-# define __compiletime_strlen __builtin_strlen
-#endif
-
 static void known_sizes_test(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
@@ -312,14 +307,6 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 
-static int fortify_test_init(struct kunit *test)
-{
-	if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
-		kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y");
-
-	return 0;
-}
-
 static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(known_sizes_test),
 	KUNIT_CASE(control_flow_split_test),
@@ -336,7 +323,6 @@ static struct kunit_case fortify_test_cases[] = {
 
 static struct kunit_suite fortify_test_suite = {
 	.name = "fortify",
-	.init = fortify_test_init,
 	.test_cases = fortify_test_cases,
 };
 
-- 
2.34.1

