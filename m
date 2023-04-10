Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B576DC242
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 03:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDJBNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 21:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDJBNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 21:13:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A0535A8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 18:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/Er8ywl5bE4dJ7WJe8NshHVWK4m5x+uPSc3wvx5Wahs=; b=32HUnOsbmPEBVAWTjU/8ZNBGqK
        Yrc2xscmsV8yVDbVPamGfskG2LHaj9J9d2/OsyijKXBABFHH6Gt9A4OIZTFlKkGC8ceDCR+DROI7C
        SQdWAuxyksaUjYBbCwI1/bpK8MUcW9NNe9jYmaafnS6KmIf7gbPFTLCmWXW2/hRA1TXR460Ak73cS
        qKWq5wE3IWjVPvOt6XsjD3RBSfULGmAFxsqDTJyy5S0Qg0KAIE3Id7TJ16iutYoIiUR0KFJIQHZZv
        wd/xVu8tTJcPduQ1AZry2bqYPK1HdJ2+4y7UVyusO/IJ+4yJYjdVLSM/BToX1duW15BjM+clAFSsD
        3+j+qMqQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1plg5j-00EPc1-0I;
        Mon, 10 Apr 2023 01:13:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3] firewire: init_ohci1394_dma: use correct function names in comments
Date:   Sun,  9 Apr 2023 18:13:06 -0700
Message-Id: <20230410011306.26268-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
v2: rebase/resend, add note to Andrew
v3: add Takashi-san

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
