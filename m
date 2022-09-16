Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271B5BB34A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIPUMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIPUMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:12:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25793B9FB1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663359160; x=1694895160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xna7jyMhT1HB16k1UaayCkxajztgOu17kio3kJdsK5Y=;
  b=npo1EUpSPAi0DvvFGxfiPx0kd1iZ2VkuzXzsYi2m025GSamB2NH+1Gjj
   Jhh2xcEqxYoYBep+K966Dsj2y1lguj9WnPF0/iEjOfwGguqBOjU4XWtNz
   ropESG6fJ3dM9n6alPpV/aNDctVAwRKiOyWtc8Y25DTssI/ImChD9Fzf9
   hxJnO7HY1MpYExsctbi+YOcxRbZpEx+A0qNMRX+EeNxK/0ad17j4NhAtO
   AlH9yFUfu273rYVZKFpDDqnrv3YxpNTcC1PP5BKIU9Y5FHiedqNGXK2Er
   kYMN3s+V/rIMGrW4X+R3ClxYTGXBQK3x4fijlvWCPb+MhrSFZb3glfHB3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="363031802"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="363031802"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 13:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="595371668"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2022 13:12:38 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZHhV-00027S-2O;
        Fri, 16 Sep 2022 20:12:37 +0000
Date:   Sat, 17 Sep 2022 04:12:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202209170452.5M3D5XuI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6879c2d3b96039ff1668b4328a4d0dd3ea952cff
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   7 months ago
config: arm-randconfig-s033-20220916 (https://download.01.org/0day-ci/archive/20220917/202209170452.5M3D5XuI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     got void [noderef] __iomem *
>> drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     got void [noderef] __iomem *
>> drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     expected void *
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     got void [noderef] __iomem *

vim +385 drivers/mtd/nand/onenand/onenand_omap2.c

3621311695f5b1 drivers/mtd/onenand/omap2.c              Peter Ujfalusi  2018-01-12  359  
fb25070afdf07c drivers/mtd/onenand/omap2.c              Ladislav Michl  2018-01-12  360  static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  361  					unsigned char *buffer, int offset,
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  362  					size_t count)
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  363  {
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  364  	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  365  	struct onenand_chip *this = mtd->priv;
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  366  	struct device *dev = &c->pdev->dev;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  367  	void *buf = (void *)buffer;
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  368  	dma_addr_t dma_src, dma_dst;
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  369  	int bram_offset, err;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  370  	size_t xtra;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  371  
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  372  	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  373  	/*
875330f87a057a drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  374  	 * If the buffer address is not DMA-able, len is not long enough to
875330f87a057a drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  375  	 * make DMA transfers profitable or if invoked from panic_write()
875330f87a057a drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  376  	 * fallback to PIO mode.
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  377  	 */
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  378  	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
875330f87a057a drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  379  	    count < 384 || mtd->oops_panic_write)
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  380  		goto out_copy;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  381  
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  382  	xtra = count & 3;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  383  	if (xtra) {
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  384  		count -= xtra;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06 @385  		memcpy(buf + count, this->base + bram_offset + count, xtra);
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  386  	}
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  387  
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  388  	dma_dst = dma_map_single(dev, buf, count, DMA_FROM_DEVICE);
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  389  	dma_src = c->phys_base + bram_offset;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  390  
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  391  	if (dma_mapping_error(dev, dma_dst)) {
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  392  		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  393  		goto out_copy;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  394  	}
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  395  
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  396  	err = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  397  	dma_unmap_single(dev, dma_dst, count, DMA_FROM_DEVICE);
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  398  	if (!err)
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  399  		return 0;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  400  
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  401  	dev_err(dev, "timeout waiting for DMA\n");
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  402  
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  403  out_copy:
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  404  	memcpy(buf, this->base + bram_offset, count);
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  405  	return 0;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  406  }
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  407  
fb25070afdf07c drivers/mtd/onenand/omap2.c              Ladislav Michl  2018-01-12  408  static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  409  					 const unsigned char *buffer,
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  410  					 int offset, size_t count)
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  411  {
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  412  	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  413  	struct onenand_chip *this = mtd->priv;
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  414  	struct device *dev = &c->pdev->dev;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  415  	void *buf = (void *)buffer;
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  416  	dma_addr_t dma_src, dma_dst;
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  417  	int bram_offset, err;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  418  
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  419  	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  420  	/*
875330f87a057a drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  421  	 * If the buffer address is not DMA-able, len is not long enough to
875330f87a057a drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  422  	 * make DMA transfers profitable or if invoked from panic_write()
875330f87a057a drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  423  	 * fallback to PIO mode.
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  424  	 */
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  425  	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
875330f87a057a drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  426  	    count < 384 || mtd->oops_panic_write)
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  427  		goto out_copy;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  428  
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  429  	dma_src = dma_map_single(dev, buf, count, DMA_TO_DEVICE);
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  430  	dma_dst = c->phys_base + bram_offset;
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  431  	if (dma_mapping_error(dev, dma_src)) {
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  432  		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  433  		goto out_copy;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  434  	}
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  435  
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  436  	err = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  437  	dma_unmap_page(dev, dma_src, count, DMA_TO_DEVICE);
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  438  	if (!err)
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  439  		return 0;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  440  
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  441  	dev_err(dev, "timeout waiting for DMA\n");
6732cfd4cac514 drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  442  
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  443  out_copy:
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06 @444  	memcpy(this->base + bram_offset, buf, count);
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  445  	return 0;
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  446  }
36cd4fb5d277f3 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  447  

:::::: The code at line 385 was first introduced by commit
:::::: 36cd4fb5d277f34fe9e4db0deac2d4efd7dff735 [MTD] [OneNAND] Add OMAP2 / OMAP3 OneNAND driver

:::::: TO: Adrian Hunter <ext-adrian.hunter@nokia.com>
:::::: CC: David Woodhouse <David.Woodhouse@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
