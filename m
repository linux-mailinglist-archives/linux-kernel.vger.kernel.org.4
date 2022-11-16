Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3918062CCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiKPVgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiKPVg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:36:28 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C306F12744
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:36:22 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2A14892009C; Wed, 16 Nov 2022 22:36:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2318F92009B;
        Wed, 16 Nov 2022 21:36:22 +0000 (GMT)
Date:   Wed, 16 Nov 2022 21:36:22 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] parport_pc: Limit the number of PCI BAR pairs to 2
Message-ID: <alpine.DEB.2.21.2209260132340.29493@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_HDRS_LCASE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decrease the number of PCI BAR pair slots allocated for port subdrivers 
from 4 to 2 as none wants more than 2 at this time, reducing the memory 
footprint a little.  No functional change.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/parport/parport_pc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-parport-pc-pci-bars.diff
Index: linux-macro/drivers/parport/parport_pc.c
===================================================================
--- linux-macro.orig/drivers/parport/parport_pc.c
+++ linux-macro/drivers/parport/parport_pc.c
@@ -2657,7 +2657,7 @@ static struct parport_pc_pci {
 		int lo;
 		int hi;
 		/* -1 if not there, >6 for offset-method (max BAR is 6) */
-	} addr[4];
+	} addr[2];
 
 	/* Bit field of parport modes to exclude. */
 	unsigned int mode_mask;
