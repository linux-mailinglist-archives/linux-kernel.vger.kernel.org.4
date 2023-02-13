Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72C96952FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBMVZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:25:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A866E88;
        Mon, 13 Feb 2023 13:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fTVN4/NtVKmlHmLQMz38v0+ZWbz86Q/AXyRmD1TocDU=; b=lCnmvRlcZu5WWBw68m+FAq1whV
        fbRbhg8FiSODgMUKbdhoRirZZojWW98jbW8sRR1nsQNsJyQuKm0gVvSiabc2URGY6WXZt7y4+owpq
        Wp9JplI+vuTnzQycB8QywbxDhtj/C+2Hdbz6r/a2uLL7ad6oOP3DRyZ/AGEsKnwO5je1vnO8ULr/c
        haJ9JYPDxNlqY7qkk3AejetbQX69xbvAqo7vlaL0htqUKtzUfkvuRVNzW9xanyZ+/sITIOmiavSlI
        r6HawK8BJ7FcphjMpGbxmLqvuUT3rsvILleeflK6zE6wZmHnYRqre2KxpKeA4PdjYFLi3ql1LRvo+
        HauxGZIQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRgKe-00GL6v-71; Mon, 13 Feb 2023 21:25:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH] ata: pata_octeon_cf: drop kernel-doc notation
Date:   Mon, 13 Feb 2023 13:25:49 -0800
Message-Id: <20230213212549.29914-1-rdunlap@infradead.org>
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

Fix a slew of kernel-doc warnings in pata_octeon_cf.c by changing
all "/**" comments to "/*" since they are not in kernel-doc format.

Fixes: 3c929c6f5aa7 ("libata: New driver for OCTEON SOC Compact Flash interface (v7).")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202302101722.5O56RClE-lkp@intel.com/
Cc: David Daney <ddaney@caviumnetworks.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/pata_octeon_cf.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -- a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -67,7 +67,7 @@ module_param(enable_dma, int, 0444);
 MODULE_PARM_DESC(enable_dma,
 		 "Enable use of DMA on interfaces that support it (0=no dma [default], 1=use dma)");
 
-/**
+/*
  * Convert nanosecond based time to setting used in the
  * boot bus timing register, based on timing multiple
  */
@@ -114,7 +114,7 @@ static void octeon_cf_set_boot_reg_cfg(i
 	cvmx_write_csr(CVMX_MIO_BOOT_REG_CFGX(cs), reg_cfg.u64);
 }
 
-/**
+/*
  * Called after libata determines the needed PIO mode. This
  * function programs the Octeon bootbus regions to support the
  * timing requirements of the PIO mode.
@@ -278,7 +278,7 @@ static void octeon_cf_set_dmamode(struct
 	cvmx_write_csr(cf_port->dma_base + DMA_TIM, dma_tim.u64);
 }
 
-/**
+/*
  * Handle an 8 bit I/O request.
  *
  * @qc:         Queued command
@@ -317,7 +317,7 @@ static unsigned int octeon_cf_data_xfer8
 	return buflen;
 }
 
-/**
+/*
  * Handle a 16 bit I/O request.
  *
  * @qc:         Queued command
@@ -372,7 +372,7 @@ static unsigned int octeon_cf_data_xfer1
 	return buflen;
 }
 
-/**
+/*
  * Read the taskfile for 16bit non-True IDE only.
  */
 static void octeon_cf_tf_read16(struct ata_port *ap, struct ata_taskfile *tf)
@@ -453,7 +453,7 @@ static int octeon_cf_softreset16(struct
 	return 0;
 }
 
-/**
+/*
  * Load the taskfile for 16bit non-True IDE only.  The device_addr is
  * not loaded, we do this as part of octeon_cf_exec_command16.
  */
@@ -525,7 +525,7 @@ static void octeon_cf_dma_setup(struct a
 	ap->ops->sff_exec_command(ap, &qc->tf);
 }
 
-/**
+/*
  * Start a DMA transfer that was already setup
  *
  * @qc:     Information about the DMA
@@ -580,7 +580,7 @@ static void octeon_cf_dma_start(struct a
 	cvmx_write_csr(cf_port->dma_base + DMA_CFG, mio_boot_dma_cfg.u64);
 }
 
-/**
+/*
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
