Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823AC651DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiLTJki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTJkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:40:36 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CEAB5F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:40:35 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Nbs4x545Zz9t3C;
        Tue, 20 Dec 2022 10:40:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4p6MqhzodcQa; Tue, 20 Dec 2022 10:40:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Nbs4n3SlGz9t3s;
        Tue, 20 Dec 2022 10:40:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 670CA8B775;
        Tue, 20 Dec 2022 10:40:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gIfRY9ue1cED; Tue, 20 Dec 2022 10:40:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.18])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B3F58B763;
        Tue, 20 Dec 2022 10:40:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2BJIkGOQ1709624
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 19:46:16 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2BJIkGWu1709623;
        Mon, 19 Dec 2022 19:46:16 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, jbglaw@lug-owl.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/5] powerpc/64: Replace -mcpu=e500mc64 by -mcpu=e5500
Date:   Mon, 19 Dec 2022 19:45:58 +0100
Message-Id: <fa71ed20d22c156225436374f0ab847daac893bc.1671475543.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671475558; l=926; s=20211009; h=from:subject:message-id; bh=yFcy4yQyPXy8ByNm8RJbyVUH3o5z+fowyjmAJaMaIwA=; b=YBrIlEbG/KQW5XSJsU/8dixIgfLhXxBKQtkERAFp1TwiDfsGIRnQvKMOvUKGcx2Dm43wlZTqOKLm DbL1WJDaAzMi5sfNb/uifjaLG/pQP+flAI3CqzuKK2qLMJY5wpaZ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E500MC64 is a processor pre-dating E5500 that has never been
commercialised. Use -mcpu=e5500 for E5500 core.

More details at https://gcc.gnu.org/PR108149

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/Kconfig.cputype | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 31cea2eeb59e..29d6be033576 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -249,7 +249,7 @@ config TARGET_CPU
 	default "power8" if POWER8_CPU
 	default "power9" if POWER9_CPU
 	default "power10" if POWER10_CPU
-	default "e500mc64" if E5500_CPU
+	default "e5500" if E5500_CPU
 	default "e6500" if E6500_CPU
 	default "power4" if POWERPC64_CPU && !CPU_LITTLE_ENDIAN
 	default "power8" if POWERPC64_CPU && CPU_LITTLE_ENDIAN
-- 
2.38.1

