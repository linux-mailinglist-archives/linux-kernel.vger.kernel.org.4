Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3531967FB01
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjA1UwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1Uv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:51:58 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621BC10A8A;
        Sat, 28 Jan 2023 12:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674939116; x=1706475116;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WpYfIsuLOVrVxIUyF9nq8INZ7YBl/l4P1pDPYeXs4kA=;
  b=ZTUXSEaSWhxzBZVejQvwMBazARaPprBBx9pN6/ywCrfo7X84ajb4pa5b
   pwIIwmJRG9pXWO5bdG43uXKB0OwBLgvfeJopjKWXhxn8Y3fXAxvUdedD/
   O66ymrcBLCPAdLz72ERzDW51KkIPCnVaqEGSB+9lCphf1Rh8GGeD4w16s
   C4SKeT435WTP/xtvl+EOEDaLSB6+FYwAIHDoRZgzKwN/5RRtF4Ckc/FGD
   unnRSdVfu8sxD1n7F1A4BHBJtMqwSHqbeIJsL7rWAyp5/DMcXr5sT1hEY
   8aTSaM0PeAfzijPbTmZNxTjfU54t5Wgvx+Erych88KE5pD2WubbdDhpeq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="413554582"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="413554582"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:51:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="641090569"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="641090569"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2023 12:51:52 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLsAx-00015w-0r;
        Sat, 28 Jan 2023 20:51:51 +0000
Date:   Sun, 29 Jan 2023 04:51:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/pci/sta2x11/sta2x11_vip.c:1053:6: warning: cast from
 'irqreturn_t (*)(int, struct sta2x11_vip *)' (aka 'enum irqreturn (*)(int,
 struct sta2x11_vip *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int,
 void *)') converts to incompatible funct...
Message-ID: <202301290442.ZF2qmZK4-lkp@intel.com>
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

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5af6ce7049365952f7f023155234fe091693ead1
commit: a157802359f7451ed8046b2b6dbaca187797e062 media: sta2x11: remove VIRT_TO_BUS dependency
date:   7 months ago
config: s390-randconfig-r021-20230129 (https://download.01.org/0day-ci/archive/20230129/202301290442.ZF2qmZK4-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a157802359f7451ed8046b2b6dbaca187797e062
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a157802359f7451ed8046b2b6dbaca187797e062
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/pci/sta2x11/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/media/pci/sta2x11/sta2x11_vip.c:18:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/media/pci/sta2x11/sta2x11_vip.c:18:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/media/pci/sta2x11/sta2x11_vip.c:18:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/media/pci/sta2x11/sta2x11_vip.c:1053:6: warning: cast from 'irqreturn_t (*)(int, struct sta2x11_vip *)' (aka 'enum irqreturn (*)(int, struct sta2x11_vip *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int, void *)') converts to incompatible function type [-Wcast-function-type-strict]
                             (irq_handler_t) vip_irq,
                             ^~~~~~~~~~~~~~~~~~~~~~~
   13 warnings generated.


vim +1053 drivers/media/pci/sta2x11/sta2x11_vip.c

efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   936  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   937  /**
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   938   * sta2x11_vip_init_one - init one instance of video device
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   939   * @pdev: PCI device
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   940   * @ent: (not used)
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   941   *
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   942   * allocate reset pins for DAC.
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   943   * Reset video DAC, this is done via reset line.
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   944   * allocate memory for managing device
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   945   * request interrupt
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   946   * map IO region
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   947   * register device
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   948   * find and initialize video DAC
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   949   *
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   950   * return value: 0, no error
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   951   *
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   952   * -ENOMEM, no memory
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   953   *
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   954   * -ENODEV, device could not be detected or registered
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   955   */
4c62e9764ab403 drivers/media/pci/sta2x11/sta2x11_vip.c Greg Kroah-Hartman 2012-12-21   956  static int sta2x11_vip_init_one(struct pci_dev *pdev,
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   957  				const struct pci_device_id *ent)
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   958  {
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   959  	int ret;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   960  	struct sta2x11_vip *vip;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   961  	struct vip_config *config;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   962  
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   963  	/* Check if hardware support 26-bit DMA */
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   964  	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(26))) {
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   965  		dev_err(&pdev->dev, "26-bit DMA addressing not available\n");
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   966  		return -EINVAL;
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   967  	}
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   968  	/* Enable PCI */
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   969  	ret = pci_enable_device(pdev);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   970  	if (ret)
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   971  		return ret;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   972  
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   973  	/* Get VIP platform data */
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   974  	config = dev_get_platdata(&pdev->dev);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   975  	if (!config) {
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   976  		dev_info(&pdev->dev, "VIP slot disabled\n");
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   977  		ret = -EINVAL;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   978  		goto disable;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   979  	}
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   980  
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   981  	/* Power configuration */
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   982  	ret = vip_gpio_reserve(&pdev->dev, config->pwr_pin, 0,
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   983  			       config->pwr_name);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   984  	if (ret)
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   985  		goto disable;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   986  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   987  	ret = vip_gpio_reserve(&pdev->dev, config->reset_pin, 0,
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   988  			       config->reset_name);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   989  	if (ret) {
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   990  		vip_gpio_release(&pdev->dev, config->pwr_pin,
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   991  				 config->pwr_name);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   992  		goto disable;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   993  	}
0bade8b5439520 drivers/media/pci/sta2x11/sta2x11_vip.c Arvind Yadav       2018-04-27   994  
0bade8b5439520 drivers/media/pci/sta2x11/sta2x11_vip.c Arvind Yadav       2018-04-27   995  	if (gpio_is_valid(config->pwr_pin)) {
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   996  		/* Datasheet says 5ms between PWR and RST */
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   997  		usleep_range(5000, 25000);
0bade8b5439520 drivers/media/pci/sta2x11/sta2x11_vip.c Arvind Yadav       2018-04-27   998  		gpio_direction_output(config->pwr_pin, 1);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   999  	}
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1000  
0bade8b5439520 drivers/media/pci/sta2x11/sta2x11_vip.c Arvind Yadav       2018-04-27  1001  	if (gpio_is_valid(config->reset_pin)) {
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1002  		/* Datasheet says 5ms between PWR and RST */
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1003  		usleep_range(5000, 25000);
0bade8b5439520 drivers/media/pci/sta2x11/sta2x11_vip.c Arvind Yadav       2018-04-27  1004  		gpio_direction_output(config->reset_pin, 1);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1005  	}
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1006  	usleep_range(5000, 25000);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1007  
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1008  	/* Allocate a new VIP instance */
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1009  	vip = kzalloc(sizeof(struct sta2x11_vip), GFP_KERNEL);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1010  	if (!vip) {
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1011  		ret = -ENOMEM;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1012  		goto release_gpios;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1013  	}
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1014  	vip->pdev = pdev;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1015  	vip->std = V4L2_STD_PAL;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1016  	vip->format = formats_50[0];
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1017  	vip->config = config;
cd63c0288fd760 drivers/media/pci/sta2x11/sta2x11_vip.c Ezequiel Garcia    2018-06-15  1018  	mutex_init(&vip->v4l_lock);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1019  
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1020  	ret = sta2x11_vip_init_controls(vip);
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1021  	if (ret)
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1022  		goto free_mem;
d017650b40b4cb drivers/media/pci/sta2x11/sta2x11_vip.c Wei Yongjun        2013-05-13  1023  	ret = v4l2_device_register(&pdev->dev, &vip->v4l2_dev);
d017650b40b4cb drivers/media/pci/sta2x11/sta2x11_vip.c Wei Yongjun        2013-05-13  1024  	if (ret)
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1025  		goto free_mem;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1026  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1027  	dev_dbg(&pdev->dev, "BAR #0 at 0x%lx 0x%lx irq %d\n",
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1028  		(unsigned long)pci_resource_start(pdev, 0),
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1029  		(unsigned long)pci_resource_len(pdev, 0), pdev->irq);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1030  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1031  	pci_set_master(pdev);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1032  
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1033  	ret = pci_request_regions(pdev, KBUILD_MODNAME);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1034  	if (ret)
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1035  		goto unreg;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1036  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1037  	vip->iomem = pci_iomap(pdev, 0, 0x100);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1038  	if (!vip->iomem) {
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1039  		ret = -ENOMEM;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1040  		goto release;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1041  	}
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1042  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1043  	pci_enable_msi(pdev);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1044  
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1045  	/* Initialize buffer */
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1046  	ret = sta2x11_vip_init_buffer(vip);
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1047  	if (ret)
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1048  		goto unmap;
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1049  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1050  	spin_lock_init(&vip->slock);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1051  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1052  	ret = request_irq(pdev->irq,
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12 @1053  			  (irq_handler_t) vip_irq,
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1054  			  IRQF_SHARED, KBUILD_MODNAME, vip);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1055  	if (ret) {
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1056  		dev_err(&pdev->dev, "request_irq failed\n");
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1057  		ret = -ENODEV;
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1058  		goto release_buf;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1059  	}
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1060  
4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1061  	/* Initialize and register video device */
4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1062  	vip->video_dev = video_dev_template;
4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1063  	vip->video_dev.v4l2_dev = &vip->v4l2_dev;
4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1064  	vip->video_dev.queue = &vip->vb_vidq;
cd63c0288fd760 drivers/media/pci/sta2x11/sta2x11_vip.c Ezequiel Garcia    2018-06-15  1065  	vip->video_dev.lock = &vip->v4l_lock;
4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1066  	video_set_drvdata(&vip->video_dev, vip);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1067  
3e30a927af3ca8 drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2020-02-03  1068  	ret = video_register_device(&vip->video_dev, VFL_TYPE_VIDEO, -1);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1069  	if (ret)
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1070  		goto vrelease;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1071  
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1072  	/* Get ADV7180 subdevice */
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1073  	vip->adapter = i2c_get_adapter(vip->config->i2c_id);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1074  	if (!vip->adapter) {
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1075  		ret = -ENODEV;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1076  		dev_err(&pdev->dev, "no I2C adapter found\n");
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1077  		goto vunreg;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1078  	}
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1079  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1080  	vip->decoder = v4l2_i2c_new_subdev(&vip->v4l2_dev, vip->adapter,
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1081  					   "adv7180", vip->config->i2c_addr,
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1082  					   NULL);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1083  	if (!vip->decoder) {
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1084  		ret = -ENODEV;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1085  		dev_err(&pdev->dev, "no decoder found\n");
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1086  		goto vunreg;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1087  	}
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1088  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1089  	i2c_put_adapter(vip->adapter);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1090  	v4l2_subdev_call(vip->decoder, core, init, 0);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1091  
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1092  	sta2x11_vip_init_register(vip);
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1093  
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1094  	dev_info(&pdev->dev, "STA2X11 Video Input Port (VIP) loaded\n");
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1095  	return 0;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1096  
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1097  vunreg:
4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1098  	video_set_drvdata(&vip->video_dev, NULL);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1099  vrelease:
11788d9b7e916f drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2020-07-13  1100  	vb2_video_unregister_device(&vip->video_dev);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1101  	free_irq(pdev->irq, vip);
8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1102  release_buf:
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1103  	pci_disable_msi(pdev);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1104  unmap:
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1105  	pci_iounmap(pdev, vip->iomem);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1106  release:
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1107  	pci_release_regions(pdev);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1108  unreg:
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1109  	v4l2_device_unregister(&vip->v4l2_dev);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1110  free_mem:
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1111  	kfree(vip);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1112  release_gpios:
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1113  	vip_gpio_release(&pdev->dev, config->reset_pin, config->reset_name);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1114  	vip_gpio_release(&pdev->dev, config->pwr_pin, config->pwr_name);
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1115  disable:
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1116  	/*
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1117  	 * do not call pci_disable_device on sta2x11 because it break all
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1118  	 * other Bus masters on this EP
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1119  	 */
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1120  	return ret;
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1121  }
efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1122  

:::::: The code at line 1053 was first introduced by commit
:::::: efeb98b4e2b2ce50e008affce4c493e58167144a [media] STA2X11 VIP: new V4L2 driver

:::::: TO: Federico Vaga <federico.vaga@gmail.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
