Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0215BD345
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiISRHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiISRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:06:33 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607323C8CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:05:05 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MWWF20Y10z9skq;
        Mon, 19 Sep 2022 19:02:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cl5ZsW_MmXyQ; Mon, 19 Sep 2022 19:02:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MWWDr5v7Sz9sl8;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BC83C8B770;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eowxUp_MYp4M; Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.8])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 76E438B780;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28JH1wfW1549616
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 19:01:58 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28JH1wSN1549615;
        Mon, 19 Sep 2022 19:01:58 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 10/19] powerpc: Remove redundant selection of E500 and E500MC
Date:   Mon, 19 Sep 2022 19:01:34 +0200
Message-Id: <44f03fa1506892fabf626dceb2f47a049908b6af.1663606876.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
References: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663606899; l=1210; s=20211009; h=from:subject:message-id; bh=bCO7XormJklivVehpnJeLfAum9uOGASIj/COfl21tMo=; b=ZkaOjxwfXR0lxGpC1Ys5S9SGZQRadFTxCg8gaK0is04PDoImgwwXqqK82leTN73LhcU0l9W/UffW Ojk/mMAjAg27+3lp9MLoiAmn72MNc/RFbp+a0lFpQ0ZdZdsZAQdd
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC_85xx and PPC_BOOK3E_64 already select E500 so no need
to select it again by PPC_QEMU_E500 and CORENET_GENERIC
as they depend on PPC_85xx || PPC_BOOK3E_64.

PPC_BOOK3E_64 already selects E500MC so no need to
select it again by PPC_QEMU_E500 if PPC64, PPC_BOOK3E_64
is the only way into PPC_QEMU_E500 with PPC64.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/85xx/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 069628670a0c..63fec86e41b4 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -241,8 +241,6 @@ endif # PPC32
 config PPC_QEMU_E500
 	bool "QEMU generic e500 platform"
 	select DEFAULT_UIMAGE
-	select E500
-	select PPC_E500MC if PPC64
 	help
 	  This option enables support for running as a QEMU guest using
 	  QEMU's generic e500 machine.  This is not required if you're
@@ -258,7 +256,6 @@ config PPC_QEMU_E500
 config CORENET_GENERIC
 	bool "Freescale CoreNet Generic"
 	select DEFAULT_UIMAGE
-	select E500
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
-- 
2.37.1

