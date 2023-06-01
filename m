Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB01719CC2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjFAM4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjFAM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:56:38 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E0EC13D;
        Thu,  1 Jun 2023 05:56:37 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8E82A92009D; Thu,  1 Jun 2023 14:56:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8B0FB92009B;
        Thu,  1 Jun 2023 13:56:36 +0100 (BST)
Date:   Thu, 1 Jun 2023 13:56:36 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Manuel Lauss <manuel.lauss@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "MIPS: unhide PATA_PLATFORM"
In-Reply-To: <alpine.DEB.2.21.2306011327300.59991@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2306011335100.59991@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2306011327300.59991@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert commit 75b18aac6fa3 ("MIPS: unhide PATA_PLATFORM") now that 
HAVE_PATA_PLATFORM is set selectively for all the relevant platforms.

Verified with `db1xxx_defconfig' and `sb1250_swarm_defconfig' by making 
sure PATA_PLATFORM is still there in `.config' with this change applied, 
and with `malta_defconfig' by making sure it's now gone.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 arch/mips/Kconfig |    1 -
 1 file changed, 1 deletion(-)

linux-mips-no-pata-platform.diff
Index: linux-macro/arch/mips/Kconfig
===================================================================
--- linux-macro.orig/arch/mips/Kconfig
+++ linux-macro/arch/mips/Kconfig
@@ -79,7 +79,6 @@ config MIPS
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
-	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
