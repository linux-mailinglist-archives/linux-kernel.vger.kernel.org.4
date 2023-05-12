Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749E6700C43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbjELPub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbjELPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:50:26 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9511A420F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:50:25 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4QHt62161jz9shH;
        Fri, 12 May 2023 17:31:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BlC2JZywGvGI; Fri, 12 May 2023 17:31:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4QHt602kq3z9shJ;
        Fri, 12 May 2023 17:31:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D6978B790;
        Fri, 12 May 2023 17:31:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AxLlpteNQTxU; Fri, 12 May 2023 17:31:36 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 19CB88B78C;
        Fri, 12 May 2023 17:31:36 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 34CFVXsu027577
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 17:31:33 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 34CFVXIc027576;
        Fri, 12 May 2023 17:31:33 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, Rohan McLure <rmclure@linux.ibm.com>
Subject: [PATCH 3/3] xtensa: Remove 64 bits atomic builtins stubs
Date:   Fri, 12 May 2023 17:31:19 +0200
Message-Id: <a6834980e58c5e2cdf25b3db061f34975de46437.1683892665.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683892665.git.christophe.leroy@csgroup.eu>
References: <cover.1683892665.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683905477; l=2118; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=+zyncwZLQ3bafvCzHRcocRICLz4v7K33Eyqpmw+0Z2E=; b=JGBCBZPW/4L73BEPJbW1KwIUbjfFExLBpY/nshWqN/Q3w4BLyRscY1dA9vrUm3r816IXE7y6r XtQ6o6yaePVDp1dFY392FH1J8IjuLr2gpqzL4lLyIYMnnB99KMOjdi1
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stubs were provided by commit 725aea873261 ("xtensa: enable KCSAN")
to make linker happy allthought they are not meant to be used at all.

KCSAN core has been fixed to not require them anymore on
32 bits architectures.

Then they can be removed.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/xtensa/lib/Makefile      |  2 --
 arch/xtensa/lib/kcsan-stubs.c | 54 -----------------------------------
 2 files changed, 56 deletions(-)
 delete mode 100644 arch/xtensa/lib/kcsan-stubs.c

diff --git a/arch/xtensa/lib/Makefile b/arch/xtensa/lib/Makefile
index 7ecef0519a27..23c22411d1d9 100644
--- a/arch/xtensa/lib/Makefile
+++ b/arch/xtensa/lib/Makefile
@@ -8,5 +8,3 @@ lib-y	+= memcopy.o memset.o checksum.o \
 	   divsi3.o udivsi3.o modsi3.o umodsi3.o mulsi3.o umulsidi3.o \
 	   usercopy.o strncpy_user.o strnlen_user.o
 lib-$(CONFIG_PCI) += pci-auto.o
-lib-$(CONFIG_KCSAN) += kcsan-stubs.o
-KCSAN_SANITIZE_kcsan-stubs.o := n
diff --git a/arch/xtensa/lib/kcsan-stubs.c b/arch/xtensa/lib/kcsan-stubs.c
deleted file mode 100644
index 2b08faa62b86..000000000000
--- a/arch/xtensa/lib/kcsan-stubs.c
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/bug.h>
-#include <linux/types.h>
-
-void __atomic_store_8(volatile void *p, u64 v, int i)
-{
-	BUG();
-}
-
-u64 __atomic_load_8(const volatile void *p, int i)
-{
-	BUG();
-}
-
-u64 __atomic_exchange_8(volatile void *p, u64 v, int i)
-{
-	BUG();
-}
-
-bool __atomic_compare_exchange_8(volatile void *p1, void *p2, u64 v, bool b, int i1, int i2)
-{
-	BUG();
-}
-
-u64 __atomic_fetch_add_8(volatile void *p, u64 v, int i)
-{
-	BUG();
-}
-
-u64 __atomic_fetch_sub_8(volatile void *p, u64 v, int i)
-{
-	BUG();
-}
-
-u64 __atomic_fetch_and_8(volatile void *p, u64 v, int i)
-{
-	BUG();
-}
-
-u64 __atomic_fetch_or_8(volatile void *p, u64 v, int i)
-{
-	BUG();
-}
-
-u64 __atomic_fetch_xor_8(volatile void *p, u64 v, int i)
-{
-	BUG();
-}
-
-u64 __atomic_fetch_nand_8(volatile void *p, u64 v, int i)
-{
-	BUG();
-}
-- 
2.40.1

