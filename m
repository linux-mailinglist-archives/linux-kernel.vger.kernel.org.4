Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F3D62CCB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiKPVf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiKPVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:35:53 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2710CD2F1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:35:53 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7EAC792009C; Wed, 16 Nov 2022 22:35:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 788DC92009B;
        Wed, 16 Nov 2022 21:35:52 +0000 (GMT)
Date:   Wed, 16 Nov 2022 21:35:52 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] parport_pc: Remove stale `parport_pc_ecp_read_block_pio'
 reference
In-Reply-To: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2211160000140.54611@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complement commit 991214386dee ("parport: remove unused dead code from 
lowlevel drivers") and remove a stale piece of commented-out code that 
refers to a function removed with said commit.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/parport/parport_pc.c |    2 --
 1 file changed, 2 deletions(-)

linux-parport-pc-ecp-read-block-pio-call.diff
Index: linux-macro/drivers/parport/parport_pc.c
===================================================================
--- linux-macro.orig/drivers/parport/parport_pc.c
+++ linux-macro/drivers/parport/parport_pc.c
@@ -2119,8 +2119,6 @@ struct parport *parport_pc_probe_port(un
 		p->ops->compat_write_data = parport_pc_compat_write_block_pio;
 #ifdef CONFIG_PARPORT_1284
 		p->ops->ecp_write_data = parport_pc_ecp_write_block_pio;
-		/* currently broken, but working on it.. (FB) */
-		/* p->ops->ecp_read_data = parport_pc_ecp_read_block_pio; */
 #endif /* IEEE 1284 support */
 		if (p->dma != PARPORT_DMA_NONE) {
 			pr_cont(", dma %d", p->dma);
