Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5E05BF1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiIUADq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiIUADh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:03:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACBF61D58
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663718613; x=1695254613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7KHhyE4Efbrqzs9lFu7BF+zhitaN/KB2G1cy6LOV/rw=;
  b=GaWSAJhpmDUQWqoC6Ux+2KTvpnZROryKXlPP0U2Fi/vKMubEkjLgmZIm
   tTdybDFh04KtWtuFJUWyjwnPmI2WXe+BkSuFkp1HxxJJro5eMNt7qJljR
   SNC5Dvzz5fHN7EMMkzI5JbzE6Bua0maSJdOiOeNgmG6wrILaa1jqKMC6r
   ubqlq4h/YMrqc477ho4Qnwzm1wMo1SYLG9R/O8wVPsuHQ0UvoVLWtMIXh
   a6bJel4PmrahoHpqfbBh0PDoYG5RW1Wu2nTAmtbXXU7XBRLAFrkjaXP2M
   2ppluit6m/E06ztFFcQGyDSX0GeXDCUegUWgLYIV6YJ2QZyQzjwSw1O4W
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="297448366"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="297448366"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 17:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="596728933"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Sep 2022 17:03:30 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oanD7-00033Z-1a;
        Wed, 21 Sep 2022 00:03:29 +0000
Date:   Wed, 21 Sep 2022 08:03:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/scsi/megaraid.c:4470:26: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202209210702.mgBl7VIG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   60891ec99e141b74544d11e897a245ef06263052
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   3 months ago
config: arm-randconfig-s031-20220921 (https://download.01.org/0day-ci/archive/20220921/202209210702.mgBl7VIG-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/megaraid.c:4470:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void * @@
   drivers/scsi/megaraid.c:4470:26: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/megaraid.c:4470:26: sparse:     got void *
   drivers/scsi/megaraid.c:4529:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void * @@
   drivers/scsi/megaraid.c:4529:26: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/megaraid.c:4529:26: sparse:     got void *
--
   drivers/scsi/hptiop.c:150:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:171:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:171:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:171:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:208:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:208:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:208:18: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:209:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:209:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:209:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:244:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] result @@     got int @@
   drivers/scsi/hptiop.c:244:44: sparse:     expected restricted __le32 [usertype] result
   drivers/scsi/hptiop.c:244:44: sparse:     got int
   drivers/scsi/hptiop.c:289:35: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:276:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:277:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cur_rptr @@     got restricted __le32 [usertype] outlist_rptr @@
   drivers/scsi/hptiop.c:277:34: sparse:     expected unsigned int [usertype] cur_rptr
   drivers/scsi/hptiop.c:277:34: sparse:     got restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:283:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] _tag @@     got restricted __le32 [usertype] val @@
   drivers/scsi/hptiop.c:283:38: sparse:     expected unsigned int [usertype] _tag
   drivers/scsi/hptiop.c:283:38: sparse:     got restricted __le32 [usertype] val
   drivers/scsi/hptiop.c:288:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int [assigned] [usertype] cur_rptr @@
   drivers/scsi/hptiop.c:288:52: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:288:52: sparse:     got unsigned int [assigned] [usertype] cur_rptr
   drivers/scsi/hptiop.c:369:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:369:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:369:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:370:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:370:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:370:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:453:64: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct hpt_iop_request_get_config *info @@     got struct hpt_iop_request_get_config [noderef] __iomem *config @@
   drivers/scsi/hptiop.c:453:64: sparse:     expected struct hpt_iop_request_get_config *info
   drivers/scsi/hptiop.c:453:64: sparse:     got struct hpt_iop_request_get_config [noderef] __iomem *config
   drivers/scsi/hptiop.c:455:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:557:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:557:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:557:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:637:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hpt_iopmv_regs *regs @@     got void [noderef] __iomem * @@
   drivers/scsi/hptiop.c:637:24: sparse:     expected struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:637:24: sparse:     got void [noderef] __iomem *
>> drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:643:34: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/hptiop.c:643:34: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:667:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:667:26: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/hptiop.c:667:26: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:933:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:938:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:939:30: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:943:43: sparse: sparse: invalid assignment: &=
   drivers/scsi/hptiop.c:943:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:943:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:944:43: sparse: sparse: invalid assignment: ^=
   drivers/scsi/hptiop.c:944:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:944:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:949:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:949:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] intrfc_len @@     got unsigned int @@
   drivers/scsi/hptiop.c:949:48: sparse:     expected restricted __le32 [usertype] intrfc_len
   drivers/scsi/hptiop.c:949:48: sparse:     got unsigned int
   drivers/scsi/hptiop.c:950:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:975:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:977:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:980:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:982:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:985:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:987:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:990:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] inlist_wptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:990:35: sparse:     expected restricted __le32 [usertype] inlist_wptr
   drivers/scsi/hptiop.c:990:35: sparse:     got unsigned int
   drivers/scsi/hptiop.c:991:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int @@
   drivers/scsi/hptiop.c:991:37: sparse:     expected restricted __le32 [usertype]
   drivers/scsi/hptiop.c:991:37: sparse:     got unsigned int
   drivers/scsi/hptiop.c:992:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:992:36: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:992:36: sparse:     got unsigned int
   drivers/scsi/hptiop.c:1534:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1534:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1534:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:1535:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1535:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1535:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:150:17: sparse: sparse: dereference of noderef expression
   drivers/scsi/hptiop.c:150:17: sparse: sparse: dereference of noderef expression
--
>> drivers/scsi/pcmcia/nsp_cs.c:1683:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void * @@
   drivers/scsi/pcmcia/nsp_cs.c:1683:34: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/pcmcia/nsp_cs.c:1683:34: sparse:     got void *
   drivers/scsi/pcmcia/nsp_cs.c: note: in included file:
   drivers/scsi/pcmcia/nsp_io.h:231:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned long *ptr @@
   drivers/scsi/pcmcia/nsp_io.h:231:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/pcmcia/nsp_io.h:231:24: sparse:     got unsigned long *ptr
   drivers/scsi/pcmcia/nsp_io.h:257:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned long *ptr @@
   drivers/scsi/pcmcia/nsp_io.h:257:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/pcmcia/nsp_io.h:257:17: sparse:     got unsigned long *ptr

vim +4470 drivers/scsi/megaraid.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  4443  
^1da177e4c3f415 Linus Torvalds 2005-04-16  4444  	pci_set_drvdata(pdev, host);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4445  
^1da177e4c3f415 Linus Torvalds 2005-04-16  4446  	mega_create_proc_entry(hba_count, mega_proc_dir_entry);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4447  
^1da177e4c3f415 Linus Torvalds 2005-04-16  4448  	error = scsi_add_host(host, &pdev->dev);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4449  	if (error)
^1da177e4c3f415 Linus Torvalds 2005-04-16  4450  		goto out_free_mbox;
^1da177e4c3f415 Linus Torvalds 2005-04-16  4451  
^1da177e4c3f415 Linus Torvalds 2005-04-16  4452  	scsi_scan_host(host);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4453  	hba_count++;
^1da177e4c3f415 Linus Torvalds 2005-04-16  4454  	return 0;
^1da177e4c3f415 Linus Torvalds 2005-04-16  4455  
^1da177e4c3f415 Linus Torvalds 2005-04-16  4456   out_free_mbox:
ec090ef8cd1c230 Suraj Upadhyay 2020-07-29  4457  	dma_free_coherent(&adapter->dev->dev, sizeof(mbox64_t),
^1da177e4c3f415 Linus Torvalds 2005-04-16  4458  			  adapter->una_mbox64, adapter->una_mbox64_dma);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4459   out_free_irq:
^1da177e4c3f415 Linus Torvalds 2005-04-16  4460  	free_irq(adapter->host->irq, adapter);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4461   out_free_scb_list:
^1da177e4c3f415 Linus Torvalds 2005-04-16  4462  	kfree(adapter->scb_list);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4463   out_free_cmd_buffer:
ec090ef8cd1c230 Suraj Upadhyay 2020-07-29  4464  	dma_free_coherent(&adapter->dev->dev, MEGA_BUFFER_SIZE,
^1da177e4c3f415 Linus Torvalds 2005-04-16  4465  			  adapter->mega_buffer, adapter->buf_dma_handle);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4466   out_host_put:
^1da177e4c3f415 Linus Torvalds 2005-04-16  4467  	scsi_host_put(host);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4468   out_iounmap:
^1da177e4c3f415 Linus Torvalds 2005-04-16  4469  	if (flag & BOARD_MEMMAP)
^1da177e4c3f415 Linus Torvalds 2005-04-16 @4470  		iounmap((void *)mega_baseport);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4471   out_release_region:
^1da177e4c3f415 Linus Torvalds 2005-04-16  4472  	if (flag & BOARD_MEMMAP)
^1da177e4c3f415 Linus Torvalds 2005-04-16  4473  		release_mem_region(tbase, 128);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4474  	else
^1da177e4c3f415 Linus Torvalds 2005-04-16  4475  		release_region(mega_baseport, 16);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4476   out_disable_device:
^1da177e4c3f415 Linus Torvalds 2005-04-16  4477  	pci_disable_device(pdev);
^1da177e4c3f415 Linus Torvalds 2005-04-16  4478   out:
^1da177e4c3f415 Linus Torvalds 2005-04-16  4479  	return error;
^1da177e4c3f415 Linus Torvalds 2005-04-16  4480  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  4481  

:::::: The code at line 4470 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
