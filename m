Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9B5BD33B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiISRGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiISRFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:05:47 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FF525FA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:04:34 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MWWDw1N4Gz9sks;
        Mon, 19 Sep 2022 19:02:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 53w_NbSJURwN; Mon, 19 Sep 2022 19:02:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MWWDr5M6Pz9skw;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A17688B775;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CTXTBdxGq5kH; Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.8])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 528858B774;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28JH1vBj1549590
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 19:01:57 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28JH1vLS1549587;
        Mon, 19 Sep 2022 19:01:57 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 04/19] powerpc/cputable: Remove __machine_check_early_realmode_p{7/8/9} prototypes
Date:   Mon, 19 Sep 2022 19:01:28 +0200
Message-Id: <b77fc0f90e3a9c065324cbff549b718ccf0809f8.1663606875.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
References: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663606898; l=1067; s=20211009; h=from:subject:message-id; bh=DgPTHMdcz9L+rKHTAuGAhKEz9zw+3lh+FcsaKJHphmA=; b=XUp2g85X0pHVC2isVSOb+5ik85upTcB3Ulfn81x18Cpz+11nfEoHUgT5fnhuM1lbvTlRqHfSabeQ 5gBAXGz/Cb7pjz0+aX0JHnpPQU5CBAjRgPRyvg71UJvFAtwlIJfe
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__machine_check_early_realmode_p{7/8/9} are already in mce.h
which is included. Remove them from cputable.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/cputable.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 2829ea537277..5ace97cccad8 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -64,9 +64,6 @@ extern void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_pa6t(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_pa6t(void);
 extern void __restore_cpu_ppc970(void);
-extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
-extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
-extern long __machine_check_early_realmode_p9(struct pt_regs *regs);
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_E500)
 extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
-- 
2.37.1

