Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E07A6CD254
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjC2Gyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjC2Gyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:54:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D6211D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680072881; x=1711608881;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2U1kB9oMofmHoH+Qc95RTF5OfZY5++ztDjUYysDdWYo=;
  b=KKV5P4jW9130fEk/FsrsPh55GJbflUGckKtluudpjWITvd72egJx/Riw
   NjWlJYTPd6jtlmRfK+n3Mojclh/c2FSBbCdvPU+LW2YL31+e3PRL27p00
   vTcs3BnOIMpyMIOXHAxN3NHJGpvMmBXaIXjfGtoEYErIwlPBMgkKh3kGT
   yyj4BJBPFVeoX2PxppXXVDEV85KWMVifyqKaO+mHISsttE8fcA160q7qX
   DcPY/+4kG00f0WzzKNCvGmawS0u2/t57j6liEUSccRmFpUQkhHCOsXJNk
   2b/2C/6bmNsOMppW691EJgJEth1RbPHivwcJX5ZdHYh86q90kVxk17e+T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="339521870"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="339521870"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 23:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="930186782"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="930186782"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Mar 2023 23:54:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phPhf-000JHu-0e;
        Wed, 29 Mar 2023 06:54:39 +0000
Date:   Wed, 29 Mar 2023 14:54:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>
Subject: drivers/scsi/megaraid.c:4470:26: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202303291426.ytmoBEcz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fcd476ea6a888ef6e6627f4c21a2ea8cca3e9312
commit: c44f15c1c09481d50fd33478ebb5b8284f8f5edb arc: iounmap() arg is volatile
date:   5 months ago
config: arc-randconfig-s031-20230329 (https://download.01.org/0day-ci/archive/20230329/202303291426.ytmoBEcz-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c44f15c1c09481d50fd33478ebb5b8284f8f5edb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c44f15c1c09481d50fd33478ebb5b8284f8f5edb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/isdn/hardware/mISDN/ drivers/scsi/ scripts/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303291426.ytmoBEcz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/megaraid.c:4470:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:4470:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4470:26: sparse:     got void *
   drivers/scsi/megaraid.c:4529:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:4529:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4529:26: sparse:     got void *
--
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse:     expected unsigned int [usertype] value
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse:     got restricted __le32 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse:     expected unsigned short [usertype] value
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse:     got restricted __le16 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:17: sparse:     expected unsigned int [usertype] val
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:17: sparse:     got restricted __le32 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:17: sparse: sparse: cast from restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:17: sparse: sparse: cast from restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:17: sparse: sparse: cast from restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:17: sparse: sparse: cast from restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:17: sparse:     expected unsigned short [usertype] val
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:17: sparse:     got restricted __le16 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:17: sparse: sparse: cast from restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:17: sparse: sparse: cast from restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:496:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:496:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:496:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:496:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:496:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:496:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:501:32: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:501:32: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:501:32: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:501:32: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:518:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:518:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:518:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:518:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:518:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:518:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:524:25: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:524:25: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:524:25: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:524:25: sparse: sparse: cast to restricted __le16
>> drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse:     got void *

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
https://github.com/intel/lkp-tests
