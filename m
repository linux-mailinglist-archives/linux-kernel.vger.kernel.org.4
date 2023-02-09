Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB456900CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBIHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBIHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327D1A24A;
        Wed,  8 Feb 2023 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UTc/0gPEdbjnt4HuiZAiziwGQpl7mfEOD3uErCKTETU=; b=prhxdat9pJvA9F7HJDv5nKOyes
        BGlq4lcltX1sl9kmfkkIhxerU7L27U01mG39RHazOv6/WKOGH2eQuDhJ2gZhnB0qc1HjQu/WL4wKR
        6KhiHOUx5ZNwNPcgSDaME8YSIrJkNfy5lk9Zhwaflb21U6T803udEF6rUsxDcU3VYcdZFO78KNXxR
        igJPT9q/YZncVm1q9tSxmUB8nrkBP+XLFRRHwFOtit4Vle9BSsRAP+KsDlOsnxSq/Q4VHmy3kKeEI
        6WY9dn801p7+nDmF8nM0K2j+8KeVh3g6hQaXg+9V3PsC5VQZBiV8+Z2hhCcvkrN7m5dAcHfM5lwMM
        ZWcHvfrw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ189-000LPt-I2; Thu, 09 Feb 2023 07:14:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 01/24] Documentation: arm: correct spelling
Date:   Wed,  8 Feb 2023 23:13:37 -0800
Message-Id: <20230209071400.31476-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/arm/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/arm/arm.rst                           |    2 +-
 Documentation/arm/ixp4xx.rst                        |    4 ++--
 Documentation/arm/keystone/knav-qmss.rst            |    2 +-
 Documentation/arm/stm32/stm32-dma-mdma-chaining.rst |    6 +++---
 Documentation/arm/sunxi/clocks.rst                  |    2 +-
 Documentation/arm/swp_emulation.rst                 |    2 +-
 Documentation/arm/tcm.rst                           |    2 +-
 Documentation/arm/vlocks.rst                        |    2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff -- a/Documentation/arm/ixp4xx.rst b/Documentation/arm/ixp4xx.rst
--- a/Documentation/arm/ixp4xx.rst
+++ b/Documentation/arm/ixp4xx.rst
@@ -78,9 +78,9 @@ IXP4xx provides two methods of accessing
 1) A direct mapped window from 0x48000000 to 0x4bffffff (64MB).
    To access PCI via this space, we simply ioremap() the BAR
    into the kernel and we can use the standard read[bwl]/write[bwl]
-   macros. This is the preffered method due to speed but it
+   macros. This is the preferred method due to speed but it
    limits the system to just 64MB of PCI memory. This can be
-   problamatic if using video cards and other memory-heavy devices.
+   problematic if using video cards and other memory-heavy devices.
 
 2) If > 64MB of memory space is required, the IXP4xx can be
    configured to use indirect registers to access PCI This allows
diff -- a/Documentation/arm/swp_emulation.rst b/Documentation/arm/swp_emulation.rst
--- a/Documentation/arm/swp_emulation.rst
+++ b/Documentation/arm/swp_emulation.rst
@@ -1,7 +1,7 @@
 Software emulation of deprecated SWP instruction (CONFIG_SWP_EMULATE)
 ---------------------------------------------------------------------
 
-ARMv6 architecture deprecates use of the SWP/SWPB instructions, and recommeds
+ARMv6 architecture deprecates use of the SWP/SWPB instructions, and recommends
 moving to the load-locked/store-conditional instructions LDREX and STREX.
 
 ARMv7 multiprocessing extensions introduce the ability to disable these
diff -- a/Documentation/arm/tcm.rst b/Documentation/arm/tcm.rst
--- a/Documentation/arm/tcm.rst
+++ b/Documentation/arm/tcm.rst
@@ -71,7 +71,7 @@ in <asm/tcm.h>. Using this interface it
 
 - Have the remaining TCM RAM added to a special
   allocation pool with gen_pool_create() and gen_pool_add()
-  and provice tcm_alloc() and tcm_free() for this
+  and provide tcm_alloc() and tcm_free() for this
   memory. Such a heap is great for things like saving
   device state when shutting off device power domains.
 
diff -- a/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst b/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst
--- a/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst
+++ b/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst
@@ -359,7 +359,7 @@ Driver updates for STM32 DMA-MDMA chaini
     descriptor you want a callback to be called at the end of the transfer
     (dmaengine_prep_slave_sg()) or the period (dmaengine_prep_dma_cyclic()).
     Depending on the direction, set the callback on the descriptor that finishes
-    the overal transfer:
+    the overall transfer:
 
     * DMA_DEV_TO_MEM: set the callback on the "MDMA" descriptor
     * DMA_MEM_TO_DEV: set the callback on the "DMA" descriptor
@@ -371,7 +371,7 @@ Driver updates for STM32 DMA-MDMA chaini
   As STM32 MDMA channel transfer is triggered by STM32 DMA, you must issue
   STM32 MDMA channel before STM32 DMA channel.
 
-  If any, your callback will be called to warn you about the end of the overal
+  If any, your callback will be called to warn you about the end of the overall
   transfer or the period completion.
 
   Don't forget to terminate both channels. STM32 DMA channel is configured in
@@ -412,4 +412,4 @@ Resources
 
 :Authors:
 
-- Amelie Delaunay <amelie.delaunay@foss.st.com>
\ No newline at end of file
+- Amelie Delaunay <amelie.delaunay@foss.st.com>
diff -- a/Documentation/arm/arm.rst b/Documentation/arm/arm.rst
--- a/Documentation/arm/arm.rst
+++ b/Documentation/arm/arm.rst
@@ -141,7 +141,7 @@ ST506 hard drives
   `*configure` harddrive set to 2). I've got an internal 20MB and a great
   big external 5.25" FH 64MB drive (who could ever want more :-) ).
 
-  I've just got 240K/s off it (a dd with bs=128k); thats about half of what
+  I've just got 240K/s off it (a dd with bs=128k); that's about half of what
   RiscOS gets; but it's a heck of a lot better than the 50K/s I was getting
   last week :-)
 
diff -- a/Documentation/arm/keystone/knav-qmss.rst b/Documentation/arm/keystone/knav-qmss.rst
--- a/Documentation/arm/keystone/knav-qmss.rst
+++ b/Documentation/arm/keystone/knav-qmss.rst
@@ -39,7 +39,7 @@ CPPI/QMSS Low Level Driver document (doc
 
 	git://git.ti.com/keystone-rtos/qmss-lld.git
 
-k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin firmware supports upto 48 accumulator
+k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin firmware supports up to 48 accumulator
 channels. This firmware is available under ti-keystone folder of
 firmware.git at
 
diff -- a/Documentation/arm/sunxi/clocks.rst b/Documentation/arm/sunxi/clocks.rst
--- a/Documentation/arm/sunxi/clocks.rst
+++ b/Documentation/arm/sunxi/clocks.rst
@@ -5,7 +5,7 @@ Frequently asked questions about the sun
 This document contains useful bits of information that people tend to ask
 about the sunxi clock system, as well as accompanying ASCII art when adequate.
 
-Q: Why is the main 24MHz oscillator gatable? Wouldn't that break the
+Q: Why is the main 24MHz oscillator gateable? Wouldn't that break the
    system?
 
 A: The 24MHz oscillator allows gating to save power. Indeed, if gated
diff -- a/Documentation/arm/vlocks.rst b/Documentation/arm/vlocks.rst
--- a/Documentation/arm/vlocks.rst
+++ b/Documentation/arm/vlocks.rst
@@ -155,7 +155,7 @@ the basic algorithm:
    optimisation.
 
    If there are too many CPUs to read the currently_voting array in
-   one transaction then multiple transations are still required.  The
+   one transaction then multiple transactions are still required.  The
    implementation uses a simple loop of word-sized loads for this
    case.  The number of transactions is still fewer than would be
    required if bytes were loaded individually.
