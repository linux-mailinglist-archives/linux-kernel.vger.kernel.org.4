Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014C466D693
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjAQHCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjAQHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:02:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD7C23C59
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cRt07Q3+pdSD2gi7rtN4qDUns/M6O0v8riQ6d6t9SAk=; b=blYYTCI71bhsKSDYIcB6uHRxdE
        GreHgDxFAiS9bl0Y6SC1DJcpDkvQC0cu+OWIDaM3P55BPnsFQG0LI/JylBF4JT9G8jKIUqq+I4G/l
        ugMpKdFXuNAoPJszeqSiXjVzRKt+9tRohD2QTH8sDTTNQA+1AR1bX3hCg77qC/T7eIG0KU6TE9zto
        iDGFZfbKoHluQ7TffId9ilH23eogwZLPUngkpUu69lwbHt02oT5VmdZVrp83uWheRFulGXBJVKUXd
        7gOje+cNbUa1wyFau0Qc+MpI/+3W/lXIqsideqVNbfMchlkJT91okQUKZ6INfZYajbDJpI/cteJIt
        J1dNDeSw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHfyq-00D79d-A0; Tue, 17 Jan 2023 07:02:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] firewire: init_ohci1394_dma: use correct function names in comments
Date:   Mon, 16 Jan 2023 23:01:59 -0800
Message-Id: <20230117070159.29763-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
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
