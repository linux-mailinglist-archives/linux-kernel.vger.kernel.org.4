Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA065BD262
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiISQpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiISQo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:44:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E7695AC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663605896; x=1695141896;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hUcMdwTIKiZGTFS47dTPqobbD/dz4a5d5cp5ufL9HX0=;
  b=WAX7lRl61F+8HTDVNKxdQJZK5a2xhz8WFBCvTSgywB6pyWPLkU5dExl7
   pPS4PZQ4OGLueogvDp22gWat2upYoEYaQMkOUSUoSp+G4WaIhaH+Fl3LU
   hpiNuHpF5UB1qXuC5HEN9dashqffp6M6aQZD9TezoHulf2H4osQAArTMH
   J7ZwQDb3hbgBxuhOS3BuTKeI2nj8llqEXZA26wQBljjl3qHZrtLNQ/NGG
   VdqIqGn3QkcMU4ordvp+xe/FNGA6W43OyVuNK3t+S2ebE7UquHzCBBkio
   2Jfe9GiodFj0Qo7rLkngDXed+NgMxd2vDATWceQO4cf/aN1pturNkOyP0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="298180502"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="298180502"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="618556773"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2022 09:44:46 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaJsz-00026J-2r;
        Mon, 19 Sep 2022 16:44:45 +0000
Date:   Tue, 20 Sep 2022 00:43:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/scsi/megaraid.c:4470:26: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202209200047.cnJE8pPV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   521a547ced6477c54b4b0cc206000406c221b4d6
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   3 months ago
config: arm-randconfig-s042-20220919 (https://download.01.org/0day-ci/archive/20220920/202209200047.cnJE8pPV-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-omap2/ drivers/scsi/ kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/megaraid.c:4470:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void * @@
   drivers/scsi/megaraid.c:4470:26: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/megaraid.c:4470:26: sparse:     got void *
   drivers/scsi/megaraid.c:4529:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void * @@
   drivers/scsi/megaraid.c:4529:26: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/megaraid.c:4529:26: sparse:     got void *

vim +4470 drivers/scsi/megaraid.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  4443  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4444  	pci_set_drvdata(pdev, host);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4445  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4446  	mega_create_proc_entry(hba_count, mega_proc_dir_entry);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4447  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4448  	error = scsi_add_host(host, &pdev->dev);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4449  	if (error)
^1da177e4c3f41 Linus Torvalds 2005-04-16  4450  		goto out_free_mbox;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4451  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4452  	scsi_scan_host(host);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4453  	hba_count++;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4454  	return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4455  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4456   out_free_mbox:
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  4457  	dma_free_coherent(&adapter->dev->dev, sizeof(mbox64_t),
^1da177e4c3f41 Linus Torvalds 2005-04-16  4458  			  adapter->una_mbox64, adapter->una_mbox64_dma);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4459   out_free_irq:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4460  	free_irq(adapter->host->irq, adapter);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4461   out_free_scb_list:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4462  	kfree(adapter->scb_list);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4463   out_free_cmd_buffer:
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  4464  	dma_free_coherent(&adapter->dev->dev, MEGA_BUFFER_SIZE,
^1da177e4c3f41 Linus Torvalds 2005-04-16  4465  			  adapter->mega_buffer, adapter->buf_dma_handle);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4466   out_host_put:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4467  	scsi_host_put(host);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4468   out_iounmap:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4469  	if (flag & BOARD_MEMMAP)
^1da177e4c3f41 Linus Torvalds 2005-04-16 @4470  		iounmap((void *)mega_baseport);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4471   out_release_region:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4472  	if (flag & BOARD_MEMMAP)
^1da177e4c3f41 Linus Torvalds 2005-04-16  4473  		release_mem_region(tbase, 128);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4474  	else
^1da177e4c3f41 Linus Torvalds 2005-04-16  4475  		release_region(mega_baseport, 16);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4476   out_disable_device:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4477  	pci_disable_device(pdev);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4478   out:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4479  	return error;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4480  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  4481  

:::::: The code at line 4470 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
