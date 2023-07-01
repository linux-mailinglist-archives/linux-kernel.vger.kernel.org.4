Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93591744B13
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 22:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjGAUk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 16:40:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832AA1710
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688244023; x=1719780023;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4oZ4hijys+MOWZ2xfQSlawrbvm73lnsRws1GfE6Vlag=;
  b=hAmipWw7C1PYF3sHS6pAqTeh6WN6wbvkf2uGb051qlUu/lwHYBRNg8iW
   VvCd44TNXuuhLucEVnzjwbLbgccyG6U7lLjiiJ6EqfQMiKTSCTormh/Q0
   ol1rHHN6JOURBkQVXsZ+BLQdTT7vyXj1AKI2Xe0VUofrtS8CPTZ4TbfRH
   xQon7ZbpTYODVKe3kghlG2fnL1FapM55PpMMFBFgpYQQMsuonq8yg/JTt
   tVm/tgN4zRL/kwxRPu+iLBvej8nAxFYuReXi5mSzVprwZPYB0C78FWGDg
   S6QTzmDMWhoYxqa6QJCZuPlXZlnOsHrEBtRaOCIMpgAJ+ov0q20rIRpvx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="393363368"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="393363368"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 13:40:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="668346941"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="668346941"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2023 13:40:21 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFhOG-000GGH-1B;
        Sat, 01 Jul 2023 20:40:20 +0000
Date:   Sun, 2 Jul 2023 04:39:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/dma/mediatek/mtk-hsdma.c:451:17: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202307020421.cjqf74xq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ad2885979ea6657fa8d3da51a301ec0e998ad8e7
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   1 year, 3 months ago
config: arm-randconfig-r092-20230702 (https://download.01.org/0day-ci/archive/20230702/202307020421.cjqf74xq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230702/202307020421.cjqf74xq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307020421.cjqf74xq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/dma/mediatek/mtk-hsdma.c:451:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 volatile @@     got unsigned int [usertype] src @@
   drivers/dma/mediatek/mtk-hsdma.c:451:17: sparse:     expected restricted __le32 volatile
   drivers/dma/mediatek/mtk-hsdma.c:451:17: sparse:     got unsigned int [usertype] src
   drivers/dma/mediatek/mtk-hsdma.c:452:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/dma/mediatek/mtk-hsdma.c:452:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 volatile @@     got unsigned int @@
   drivers/dma/mediatek/mtk-hsdma.c:452:17: sparse:     expected restricted __le32 volatile
   drivers/dma/mediatek/mtk-hsdma.c:452:17: sparse:     got unsigned int
>> drivers/dma/mediatek/mtk-hsdma.c:456:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 volatile @@     got unsigned int [usertype] dest @@
   drivers/dma/mediatek/mtk-hsdma.c:456:17: sparse:     expected restricted __le32 volatile
   drivers/dma/mediatek/mtk-hsdma.c:456:17: sparse:     got unsigned int [usertype] dest
   drivers/dma/mediatek/mtk-hsdma.c:457:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 volatile @@     got int @@
   drivers/dma/mediatek/mtk-hsdma.c:457:17: sparse:     expected restricted __le32 volatile
   drivers/dma/mediatek/mtk-hsdma.c:457:17: sparse:     got int
   drivers/dma/mediatek/mtk-hsdma.c:580:33: sparse: sparse: restricted __le32 degrades to integer
   drivers/dma/mediatek/mtk-hsdma.c:604:26: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/mediatek/mtk-hsdma.c:878:18: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] ddone @@     got unsigned long @@
   drivers/dma/mediatek/mtk-hsdma.c:878:18: sparse:     expected restricted __le32 [usertype] ddone
   drivers/dma/mediatek/mtk-hsdma.c:878:18: sparse:     got unsigned long
   drivers/dma/mediatek/mtk-hsdma.c:879:16: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] ls0 @@     got unsigned long @@
   drivers/dma/mediatek/mtk-hsdma.c:879:16: sparse:     expected restricted __le32 [usertype] ls0
   drivers/dma/mediatek/mtk-hsdma.c:879:16: sparse:     got unsigned long
   drivers/dma/mediatek/mtk-hsdma.c:883:18: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] ddone @@     got unsigned long @@
   drivers/dma/mediatek/mtk-hsdma.c:883:18: sparse:     expected restricted __le32 [usertype] ddone
   drivers/dma/mediatek/mtk-hsdma.c:883:18: sparse:     got unsigned long
   drivers/dma/mediatek/mtk-hsdma.c:884:16: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] ls0 @@     got unsigned long @@
   drivers/dma/mediatek/mtk-hsdma.c:884:16: sparse:     expected restricted __le32 [usertype] ls0
   drivers/dma/mediatek/mtk-hsdma.c:884:16: sparse:     got unsigned long

vim +451 drivers/dma/mediatek/mtk-hsdma.c

548c4597e984b7 Sean Wang 2018-03-15  411  
548c4597e984b7 Sean Wang 2018-03-15  412  static int mtk_hsdma_issue_pending_vdesc(struct mtk_hsdma_device *hsdma,
548c4597e984b7 Sean Wang 2018-03-15  413  					 struct mtk_hsdma_pchan *pc,
548c4597e984b7 Sean Wang 2018-03-15  414  					 struct mtk_hsdma_vdesc *hvd)
548c4597e984b7 Sean Wang 2018-03-15  415  {
548c4597e984b7 Sean Wang 2018-03-15  416  	struct mtk_hsdma_ring *ring = &pc->ring;
548c4597e984b7 Sean Wang 2018-03-15  417  	struct mtk_hsdma_pdesc *txd, *rxd;
548c4597e984b7 Sean Wang 2018-03-15  418  	u16 reserved, prev, tlen, num_sgs;
548c4597e984b7 Sean Wang 2018-03-15  419  	unsigned long flags;
548c4597e984b7 Sean Wang 2018-03-15  420  
548c4597e984b7 Sean Wang 2018-03-15  421  	/* Protect against PC is accessed by multiple VCs simultaneously */
548c4597e984b7 Sean Wang 2018-03-15  422  	spin_lock_irqsave(&hsdma->lock, flags);
548c4597e984b7 Sean Wang 2018-03-15  423  
548c4597e984b7 Sean Wang 2018-03-15  424  	/*
548c4597e984b7 Sean Wang 2018-03-15  425  	 * Reserve rooms, where pc->nr_free is used to track how many free
548c4597e984b7 Sean Wang 2018-03-15  426  	 * rooms in the ring being updated in user and IRQ context.
548c4597e984b7 Sean Wang 2018-03-15  427  	 */
548c4597e984b7 Sean Wang 2018-03-15  428  	num_sgs = DIV_ROUND_UP(hvd->len, MTK_HSDMA_MAX_LEN);
548c4597e984b7 Sean Wang 2018-03-15  429  	reserved = min_t(u16, num_sgs, atomic_read(&pc->nr_free));
548c4597e984b7 Sean Wang 2018-03-15  430  
548c4597e984b7 Sean Wang 2018-03-15  431  	if (!reserved) {
548c4597e984b7 Sean Wang 2018-03-15  432  		spin_unlock_irqrestore(&hsdma->lock, flags);
548c4597e984b7 Sean Wang 2018-03-15  433  		return -ENOSPC;
548c4597e984b7 Sean Wang 2018-03-15  434  	}
548c4597e984b7 Sean Wang 2018-03-15  435  
548c4597e984b7 Sean Wang 2018-03-15  436  	atomic_sub(reserved, &pc->nr_free);
548c4597e984b7 Sean Wang 2018-03-15  437  
548c4597e984b7 Sean Wang 2018-03-15  438  	while (reserved--) {
548c4597e984b7 Sean Wang 2018-03-15  439  		/* Limit size by PD capability for valid data moving */
548c4597e984b7 Sean Wang 2018-03-15  440  		tlen = (hvd->len > MTK_HSDMA_MAX_LEN) ?
548c4597e984b7 Sean Wang 2018-03-15  441  		       MTK_HSDMA_MAX_LEN : hvd->len;
548c4597e984b7 Sean Wang 2018-03-15  442  
548c4597e984b7 Sean Wang 2018-03-15  443  		/*
548c4597e984b7 Sean Wang 2018-03-15  444  		 * Setup PDs using the remaining VD info mapped on those
548c4597e984b7 Sean Wang 2018-03-15  445  		 * reserved rooms. And since RXD is shared memory between the
548c4597e984b7 Sean Wang 2018-03-15  446  		 * host and the device allocated by dma_alloc_coherent call,
548c4597e984b7 Sean Wang 2018-03-15  447  		 * the helper macro WRITE_ONCE can ensure the data written to
548c4597e984b7 Sean Wang 2018-03-15  448  		 * RAM would really happens.
548c4597e984b7 Sean Wang 2018-03-15  449  		 */
548c4597e984b7 Sean Wang 2018-03-15  450  		txd = &ring->txd[ring->cur_tptr];
548c4597e984b7 Sean Wang 2018-03-15 @451  		WRITE_ONCE(txd->desc1, hvd->src);
548c4597e984b7 Sean Wang 2018-03-15  452  		WRITE_ONCE(txd->desc2,
548c4597e984b7 Sean Wang 2018-03-15  453  			   hsdma->soc->ls0 | MTK_HSDMA_DESC_PLEN(tlen));
548c4597e984b7 Sean Wang 2018-03-15  454  
548c4597e984b7 Sean Wang 2018-03-15  455  		rxd = &ring->rxd[ring->cur_tptr];
548c4597e984b7 Sean Wang 2018-03-15 @456  		WRITE_ONCE(rxd->desc1, hvd->dest);
548c4597e984b7 Sean Wang 2018-03-15  457  		WRITE_ONCE(rxd->desc2, MTK_HSDMA_DESC_PLEN(tlen));
548c4597e984b7 Sean Wang 2018-03-15  458  
548c4597e984b7 Sean Wang 2018-03-15  459  		/* Associate VD, the PD belonged to */
548c4597e984b7 Sean Wang 2018-03-15  460  		ring->cb[ring->cur_tptr].vd = &hvd->vd;
548c4597e984b7 Sean Wang 2018-03-15  461  
548c4597e984b7 Sean Wang 2018-03-15  462  		/* Move forward the pointer of TX ring */
548c4597e984b7 Sean Wang 2018-03-15  463  		ring->cur_tptr = MTK_HSDMA_NEXT_DESP_IDX(ring->cur_tptr,
548c4597e984b7 Sean Wang 2018-03-15  464  							 MTK_DMA_SIZE);
548c4597e984b7 Sean Wang 2018-03-15  465  
548c4597e984b7 Sean Wang 2018-03-15  466  		/* Update VD with remaining data */
548c4597e984b7 Sean Wang 2018-03-15  467  		hvd->src  += tlen;
548c4597e984b7 Sean Wang 2018-03-15  468  		hvd->dest += tlen;
548c4597e984b7 Sean Wang 2018-03-15  469  		hvd->len  -= tlen;
548c4597e984b7 Sean Wang 2018-03-15  470  	}
548c4597e984b7 Sean Wang 2018-03-15  471  
548c4597e984b7 Sean Wang 2018-03-15  472  	/*
548c4597e984b7 Sean Wang 2018-03-15  473  	 * Tagging flag for the last PD for VD will be responsible for
548c4597e984b7 Sean Wang 2018-03-15  474  	 * completing VD.
548c4597e984b7 Sean Wang 2018-03-15  475  	 */
548c4597e984b7 Sean Wang 2018-03-15  476  	if (!hvd->len) {
548c4597e984b7 Sean Wang 2018-03-15  477  		prev = MTK_HSDMA_LAST_DESP_IDX(ring->cur_tptr, MTK_DMA_SIZE);
548c4597e984b7 Sean Wang 2018-03-15  478  		ring->cb[prev].flag = MTK_HSDMA_VDESC_FINISHED;
548c4597e984b7 Sean Wang 2018-03-15  479  	}
548c4597e984b7 Sean Wang 2018-03-15  480  
548c4597e984b7 Sean Wang 2018-03-15  481  	/* Ensure all changes indeed done before we're going on */
548c4597e984b7 Sean Wang 2018-03-15  482  	wmb();
548c4597e984b7 Sean Wang 2018-03-15  483  
548c4597e984b7 Sean Wang 2018-03-15  484  	/*
548c4597e984b7 Sean Wang 2018-03-15  485  	 * Updating into hardware the pointer of TX ring lets HSDMA to take
548c4597e984b7 Sean Wang 2018-03-15  486  	 * action for those pending PDs.
548c4597e984b7 Sean Wang 2018-03-15  487  	 */
548c4597e984b7 Sean Wang 2018-03-15  488  	mtk_dma_write(hsdma, MTK_HSDMA_TX_CPU, ring->cur_tptr);
548c4597e984b7 Sean Wang 2018-03-15  489  
548c4597e984b7 Sean Wang 2018-03-15  490  	spin_unlock_irqrestore(&hsdma->lock, flags);
548c4597e984b7 Sean Wang 2018-03-15  491  
548c4597e984b7 Sean Wang 2018-03-15  492  	return 0;
548c4597e984b7 Sean Wang 2018-03-15  493  }
548c4597e984b7 Sean Wang 2018-03-15  494  

:::::: The code at line 451 was first introduced by commit
:::::: 548c4597e984b79aad8190235d664f1c3a433f94 dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622 and MT7623 SoC

:::::: TO: Sean Wang <sean.wang@mediatek.com>
:::::: CC: Vinod Koul <vinod.koul@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
