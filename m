Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E9B6F7C53
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjEEFVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjEEFVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:21:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5904E1FF2;
        Thu,  4 May 2023 22:21:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-643990c5373so1066670b3a.1;
        Thu, 04 May 2023 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683264094; x=1685856094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EKL5kLsFZ+sGZTRgz40hRJ00ZAZDAzqUio/KlP62gi4=;
        b=lHpwsCFdfLgDiplHfTzxQjsbRim2o7ukHfbDAPIlptK1Jmla8UZFX2AfNek4kGW8uj
         qnSmAjc4B/hHU2uZtWDt3r9BXaTbbvpy6AT4lco7A0ovtse5VPRwwxYqrPSQXNejt9RX
         KRLYprgjuZYdEpGrdD8DaICU4cNIw6AsviY9fX1Z/XLBnfjROiIIaVkWsAuZbqGtRoYx
         /syt6W5igYfaZiAPrkOD3YMOogB/re5D7BP17ugXLSFzE3uhH3aUXXkPeApg7BSb49ND
         eMtAJ+4bbgaaBqaRbgjPL4g7tSLJVPmAFszyglARcGRMvr3iMVstWslTXFC9pixf3RQe
         vRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683264094; x=1685856094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKL5kLsFZ+sGZTRgz40hRJ00ZAZDAzqUio/KlP62gi4=;
        b=djdbNrexzWjplHe/acUV6y9mlCV9vHhAdsKXrL3PJd3KJw32G8asSWGaEBXYAWsRuv
         i1Q7Vpgl9Ff6G1mTaBmyiGFF8Aj3zZ5Xkj8aFUSuAe6xGgCVJ0c0EubzVtLuUraRqMnJ
         gjWyRmmGPHvQTfT1D1N1ssiEpcqZDqvCVF4MWO+3t1b11Rhqve8dh7Qo/+5RoZLRm9AX
         C0I4ZQ+X02rYgNNb9ZCOVeKM3n13lhDEPZriK9hSh420eZYRnuWMJzLSZuM3Uksadqm/
         jdmkhqXY8agHq+YGVNHPBN95t0AFZumDe+DiIae3+lb6aQI4J4nB1AbGdPVGu1o4DB1R
         GuJQ==
X-Gm-Message-State: AC+VfDxRQ0gi3OLb6yXWN2bE77Qq5eqyLDpWr0NRJtypG96SAbEResCj
        oIubCSFSyjrSanezMOqA2ac=
X-Google-Smtp-Source: ACHHUZ4V1vC1xXnS7doNxpBX8QO+KvFXRYeR1afGEHLiVH2VTtdsgHCy9fyGnxeXcRxiRP9nB4rieA==
X-Received: by 2002:a05:6a00:168b:b0:63d:2d7d:b6f2 with SMTP id k11-20020a056a00168b00b0063d2d7db6f2mr1021223pfc.4.1683264093548;
        Thu, 04 May 2023 22:21:33 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79249000000b006430aa24dd7sm678036pfp.73.2023.05.04.22.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 22:21:33 -0700 (PDT)
From:   Genjian <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian <zhanggenjian@kylinos.cn>
To:     tsbogend@alpha.franken.de, rdunlap@infradead.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanggenjian123@gmail.com, Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v3] fix ___SYNC () build error when PROFILE_ALL_BRANCHES is enabled
Date:   Fri,  5 May 2023 13:19:53 +0800
Message-Id: <20230505051953.331080-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Genjian Zhang <zhanggenjian@kylinos.cn>

compiler error (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110):

{standard input}: Assembler messages:
{standard input}:171: Error: found '(', expected: ')'
{standard input}:171: Error: found '(', expected: ')'
{standard input}:171: Error: non-constant expression in ".if" statement
{standard input}:171: Error: junk at end of line, first unrecognized
character is `('

Expands ___SYNC() macros. However, 'if' statement will be wrong
assembly. This Compilers report a lot of errors like the above.
The problem is caused by the #define of if() in
include/linux/compiler.h when CONFIG_PROFILE_ALL_BRANCHES
is set. Move '.if' into quoted strings to fix it.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 arch/mips/include/asm/sync.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/sync.h b/arch/mips/include/asm/sync.h
index aabd097933fe..fab3ae758ea6 100644
--- a/arch/mips/include/asm/sync.h
+++ b/arch/mips/include/asm/sync.h
@@ -173,9 +173,8 @@
  * when we detect at runtime that we're running on a CPU that doesn't need
  * them.
  */
-#ifdef CONFIG_CPU_HAS_SYNC
 # define ____SYNC(_type, _reason, _else)			\
-	.if	(( _type ) != -1) && ( _reason );		\
+	((_type) != -1) && (_reason);				\
 	.set	push;						\
 	.set	MIPS_ISA_LEVEL_RAW;				\
 	.rept	__SYNC_rpt(_type);				\
@@ -185,21 +184,28 @@
 	.else;							\
 	_else;							\
 	.endif
-#else
-# define ____SYNC(_type, _reason, _else)
-#endif
 
 /*
  * Preprocessor magic to expand macros used as arguments before we insert them
  * into assembly code.
+ * In addition,'if' cannot be enabled.
  */
+#ifdef CONFIG_CPU_HAS_SYNC
 #ifdef __ASSEMBLY__
 # define ___SYNC(type, reason, else)				\
-	____SYNC(type, reason, else)
+	.if	____SYNC(type, reason, else)
+#else
+# define ___SYNC(type, reason, else)				\
+	".if"	__stringify(____SYNC(type, reason, else))
+#endif
+#else /* CONFIG_CPU_HAS_SYNC */
+#ifdef __ASSEMBLY__
+# define ___SYNC(type, reason, else)
 #else
 # define ___SYNC(type, reason, else)				\
-	__stringify(____SYNC(type, reason, else))
+	__stringify()
 #endif
+#endif /* CONFIG_CPU_HAS_SYNC */
 
 #define __SYNC(type, reason)					\
 	___SYNC(__SYNC_##type, __SYNC_##reason, )
-- 
2.25.1

