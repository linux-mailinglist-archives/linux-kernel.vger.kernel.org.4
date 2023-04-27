Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6628D6F07DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbjD0PFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243444AbjD0PFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:05:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B1D1992;
        Thu, 27 Apr 2023 08:05:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1a92513abebso88028595ad.2;
        Thu, 27 Apr 2023 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682607902; x=1685199902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gex4mcejY+ML9kJqmdxIpGp3zwNecRO+t5VAo3FtdUM=;
        b=rvjBrFTBOhzRXQ6NobP8T0GcD22Ng+4F7E9xbLlKoIVnRUzj+qyq1iTS+p1NqykxA5
         dlgqHNclnv2tg9TM/eWgt/SW+YFQYfGMeRXzJHFFOxeaF448oyaF52MjYhCnStvvWmT3
         HG1MUNH5xP9SnliTp2cwYT4p5e/Zken4ogGQy+8eEzBOUrtaMZoAOAQLb3eHwT6P+EOa
         Yhg/1rGH0tNdxu6i2ClyDfP4PMZbWTY/P6chvcwyUJLyVpnerufM8pqDzpOhSBbujeR+
         A5GGo4acfvllyCVPJ8aCxsS3WTYNz1W8b5LFMpwcbWvumhzrziuLgOpwm5S392mjtR3t
         s2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682607902; x=1685199902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gex4mcejY+ML9kJqmdxIpGp3zwNecRO+t5VAo3FtdUM=;
        b=COVPG6na5mXyOGAe7De4tF/eFK5md5hStZiD3LlgwKaH5eutntbh6FECuGQVob3xi8
         KZxNIINvglfBBNBOVATD+z3teKL/iQNS0hSxPqhPwms/Sj7nBxDWYuLFBDe6I3Y35GyR
         ZHOWJvZ5fHDFTgnrptpFsdN3IP1BF3pPWyYEX9WDcmFltKuAtVZ6ftqp5vPczrPXNqcP
         AlR0gkiEAFKsXrh0HfQ/13EIYt4X61153C6w6v5WdwvCKfwfPNEvC3bZESpj5mthlpOE
         VBYGz/mqqWXJYf9M9LTE0i4Yz7hXWjpeQudoyQhGWlrf1uM+XhDTrmZoYQMq5VSJ0bft
         Lukw==
X-Gm-Message-State: AC+VfDwts7hSm8wGJ2rRI7/LppCkKjZLcvEbKI8+GCxKNExc8qJwojKi
        yRKOtjIlJLvIgMi51VF0jvpiHh3oRUYdmolO
X-Google-Smtp-Source: ACHHUZ4oqWLsf9paLUHIFHbZCz5kq0EyCKnBpkP+qSiWxyZ+Pq1D0bgXMnyav17iuL1evzJivfPzXw==
X-Received: by 2002:a17:902:e84f:b0:1a6:c12d:9020 with SMTP id t15-20020a170902e84f00b001a6c12d9020mr2020049plg.24.1682607902241;
        Thu, 27 Apr 2023 08:05:02 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902bd8700b001a6ff7bd4d9sm11793941pls.15.2023.04.27.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 08:05:01 -0700 (PDT)
From:   Genjian <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian <zhanggenjian@kylinos.cn>
To:     tsbogend@alpha.franken.de, rdunlap@infradead.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanggenjian123@gmail.com, Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] fix ___SYNC () build error when PROFILE_ALL_BRANCHES is enabled
Date:   Thu, 27 Apr 2023 23:03:32 +0800
Message-Id: <20230427150332.2978867-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAOd03yRAmPULzi8fYTnukCpRPHa1Zsv5ZFFeQRcQ7B1abQCGqA@mail.gmail.com>
References: <CAOd03yRAmPULzi8fYTnukCpRPHa1Zsv5ZFFeQRcQ7B1abQCGqA@mail.gmail.com>
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
assembly.This Compilers report a lot of errors like the above.
this problem is caused by the #define of if() in
include/linux/compiler.h when CONFIG_PROFILE_ALL_BRANCHES
is set. Move '.if' into quoted strings to fix it.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 arch/mips/include/asm/sync.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/sync.h b/arch/mips/include/asm/sync.h
index aabd097933fe..56a4f6f6cdef 100644
--- a/arch/mips/include/asm/sync.h
+++ b/arch/mips/include/asm/sync.h
@@ -175,7 +175,7 @@
  */
 #ifdef CONFIG_CPU_HAS_SYNC
 # define ____SYNC(_type, _reason, _else)			\
-	.if	(( _type ) != -1) && ( _reason );		\
+	((_type) != -1) && (_reason);				\
 	.set	push;						\
 	.set	MIPS_ISA_LEVEL_RAW;				\
 	.rept	__SYNC_rpt(_type);				\
@@ -192,13 +192,14 @@
 /*
  * Preprocessor magic to expand macros used as arguments before we insert them
  * into assembly code.
+ * In addition,'if' cannot be enabled.
  */
 #ifdef __ASSEMBLY__
 # define ___SYNC(type, reason, else)				\
-	____SYNC(type, reason, else)
+	.if	____SYNC(type, reason, else)
 #else
 # define ___SYNC(type, reason, else)				\
-	__stringify(____SYNC(type, reason, else))
+	".if"	__stringify(____SYNC(type, reason, else))
 #endif
 
 #define __SYNC(type, reason)					\
-- 
2.25.1

