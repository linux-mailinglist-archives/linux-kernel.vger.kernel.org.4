Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7047C74F47F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjGKQKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjGKQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:10:11 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C75E10F0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:09:45 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4R0m5P4Z6Hz9sFM;
        Tue, 11 Jul 2023 18:08:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7h6PuQNjCwxH; Tue, 11 Jul 2023 18:08:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4R0m5C4m0pz9sFK;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D2608B77A;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ApjKmr9blWDq; Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.184])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E75B98B783;
        Tue, 11 Jul 2023 18:08:46 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 36BG8inM3696801
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 18:08:44 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 36BG8hr53696798;
        Tue, 11 Jul 2023 18:08:43 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 02/15] objtool: Move back misplaced comment
Date:   Tue, 11 Jul 2023 18:08:28 +0200
Message-ID: <ef65962348c12705b291a6e06ad63aaa29ae5213.1689091394.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689091394.git.christophe.leroy@csgroup.eu>
References: <cover.1689091394.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689091705; l=1925; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=4ExwdTByGoB2+8hlDUXdUlnHvdx3p3zBzyXw0Z2vUVg=; b=gIH6fljQ7rT92xPZWkRaTFrAS8KnWZjltM17fd/9Swn12qYCdIetVOAhY6tEGKUvHVjtGQkcQ hWmyJCc3ZZkAj/b4UCCbIIk1jXr/asR3uHbHZElbAm619yeirANyCD0
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A comment was introduced by commit 113d4bc90483 ("objtool: Fix
clang switch table edge case") and wrongly moved by
commit d871f7b5a6a2 ("objtool: Refactor jump table code to support
other architectures") without the piece of code added with the
comment in the original commit.

Fixes: d871f7b5a6a2 ("objtool: Refactor jump table code to support other architectures")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/objtool/arch/x86/special.c | 5 -----
 tools/objtool/check.c            | 6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 29e949579ede..8e8302fe909f 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -118,11 +118,6 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	    strcmp(table_sec->name, C_JUMP_TABLE_SECTION))
 		return NULL;
 
-	/*
-	 * Each table entry has a rela associated with it.  The rela
-	 * should reference text in the same function as the original
-	 * instruction.
-	 */
 	rodata_reloc = find_reloc_by_dest(file->elf, table_sec, table_offset);
 	if (!rodata_reloc)
 		return NULL;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8936a05f0e5a..25f6df4713ed 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2072,6 +2072,12 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 		table_reloc = arch_find_switch_table(file, insn);
 		if (!table_reloc)
 			continue;
+
+		/*
+		 * Each table entry has a rela associated with it.  The rela
+		 * should reference text in the same function as the original
+		 * instruction.
+		 */
 		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
 		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
-- 
2.41.0

