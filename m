Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B981468FC4B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 01:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjBIA7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 19:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjBIA7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 19:59:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A393122A2B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 16:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kaXjEiR8MQAfw5oKDquIV0GNyX8JtwAmD302ym/uziI=; b=tfvsP7Or1Pp1HQ8HPBeW4hx10u
        0bcFuX7NBinoJUyBZXBFGeuOnU5lmoMOFeCyUTC0W4tMt0XDG7YNnvT9mz3hHN7utVc804M1fRV9a
        PBw4Rlx0exBy7vQ0TNaWfxh3M6KX9H/Hwo1tpsS2DTlnG4PtMlZ5YhfqQrBTgaZnncl7qzhFX5uNF
        sF3K/f4JEDozpMwgqcl07S55g1JZ55iZlK6+0mtOdFK3lcuRWP8UIHTXnMj/a2BfYVCoQmeNmsk11
        hpYZlQ+d1uUkVnJ8YU4qwHTe5YD3bV7dQm6leoUaE3A/0N76MHMlqRdx2cFhTp98Ly0qsWHpFvcyI
        L757oT2A==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPvHr-00HM4n-Ih; Thu, 09 Feb 2023 00:59:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] firewire: init_ohci1394_dma: use correct function names in comments
Date:   Wed,  8 Feb 2023 16:59:42 -0800
Message-Id: <20230209005942.23566-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent kernel-doc complaints by using the correct function names in
kernel-doc comments:

drivers/firewire/init_ohci1394_dma.c:258: warning: expecting prototype for debug_init_ohci1394_dma(). Prototype was for init_ohci1394_dma_on_all_controllers() instead
drivers/firewire/init_ohci1394_dma.c:289: warning: expecting prototype for setup_init_ohci1394_early(). Prototype was for setup_ohci1394_dma() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>
---
v2: rebase/resend, add note to Andrew

@Andrew: Please merge this patch. Stefan hasn't been active lately AFAIK.

 drivers/firewire/init_ohci1394_dma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/firewire/init_ohci1394_dma.c b/drivers/firewire/init_ohci1394_dma.c
--- a/drivers/firewire/init_ohci1394_dma.c
+++ b/drivers/firewire/init_ohci1394_dma.c
@@ -251,7 +251,7 @@ static inline void __init init_ohci1394_
 }
 
 /**
- * debug_init_ohci1394_dma - scan for OHCI1394 controllers and init DMA on them
+ * init_ohci1394_dma_on_all_controllers - scan for OHCI1394 controllers and init DMA on them
  * Scans the whole PCI space for OHCI1394 controllers and inits DMA on them
  */
 void __init init_ohci1394_dma_on_all_controllers(void)
@@ -283,7 +283,7 @@ void __init init_ohci1394_dma_on_all_con
 }
 
 /**
- * setup_init_ohci1394_early - enables early OHCI1394 DMA initialization
+ * setup_ohci1394_dma - enables early OHCI1394 DMA initialization
  */
 static int __init setup_ohci1394_dma(char *opt)
 {
