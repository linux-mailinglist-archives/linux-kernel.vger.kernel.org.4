Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F87651DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiLTJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiLTJkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:40:42 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE82E2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:40:41 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Nbs510XP4z9t3x;
        Tue, 20 Dec 2022 10:40:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 32pkwqY0LbxU; Tue, 20 Dec 2022 10:40:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Nbs4n6ZpLz9t43;
        Tue, 20 Dec 2022 10:40:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA0F68B774;
        Tue, 20 Dec 2022 10:40:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DDd5Y44QPcws; Tue, 20 Dec 2022 10:40:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.18])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A65488B763;
        Tue, 20 Dec 2022 10:40:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2BJIkGtg1709629
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 19:46:17 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2BJIkGYK1709627;
        Mon, 19 Dec 2022 19:46:16 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, jbglaw@lug-owl.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 4/5] powerpc: Remove cpu-as-y completely
Date:   Mon, 19 Dec 2022 19:45:59 +0100
Message-Id: <9e43ad8b173c2fdb540e2555a8ba3e375419f3cf.1671475543.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671475558; l=1858; s=20211009; h=from:subject:message-id; bh=TbbVpgGjGpLM0aKHipGO6N97h2hzS9n0S3TlNDngFWw=; b=B0po3xQxGGSdn4RspbZEbUrEo9FNFc3y4DvnyAfGr2hOYLM+vUmb6LgdPp+LoPiEddN3DZqv3tnm Y0zig3wEDcrYUrDFso6GCnE+RiMwfPkoLLwNsUblj3p9Jx6gi9w1
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu-as-y is there to force assembler building options.
But there is no need for that. Gcc is passed the necessary
options and it automatically pass the appropriate option to
GAS.

GCC is given -maltivec when relevant, so no need
for -Wa,-maltivec in addition

And -Wa,-many is wrong as it will hide innapropriate
instructions. Better to detect them and handle them on a
case by case basis.
-Wa,-many was added by commit 960e30029863 ("powerpc/Makefile:
Fix PPC_BOOK3S_64 ASFLAGS") in order to fix an issue with
clang and the passed -Wa,-mpower4 option. But we have now
removed it expecting the compiler to automatically pass the
proper options and instructions based on -mcpu=power4

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Makefile | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 0f9f291895cb..7e67f939a243 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -201,18 +201,6 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 # often slow when they are implemented at all
 KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 
-cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
-
-# When using '-many -mpower4' gas will first try and find a matching power4
-# mnemonic and failing that it will allow any valid mnemonic that GAS knows
-# about. GCC will pass -many to GAS when assembling, clang does not.
-# LLVM IAS doesn't understand either flag: https://github.com/ClangBuiltLinux/linux/issues/675
-# but LLVM IAS only supports ISA >= 2.06 for Book3S 64 anyway...
-cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-many)
-
-KBUILD_AFLAGS += $(cpu-as-y)
-KBUILD_CFLAGS += $(cpu-as-y)
-
 KBUILD_AFLAGS += $(aflags-y)
 KBUILD_CFLAGS += $(cflags-y)
 
-- 
2.38.1

