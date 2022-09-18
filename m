Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207295BBFB8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 22:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIRUE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 16:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIRUEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 16:04:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80072641
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663531486; x=1695067486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d2Ag9jTvvitHstHZy6WjlCUEvPShOtS8VeC9ZZelxd4=;
  b=Vne2D+TwpAeQOGcsavXtTGyF/zEvFQV36masKVOYzOMSTovAxkhN5jqm
   9K3I4h8qps/CwjO6YgKU+TJTyyR+AnnZPgSucWiEoi13WupmrqhXEzCJ4
   cJP483xp+4KgO01H3N+IGuFXWs4Mj8aJ3aJxCQ7Xdckg+kdzz5ra/tehZ
   ZT4KRz1bvB7dECwwnwonra1IdqAxqIGqqV28TGZC5c7z0pFVsTCstLS/h
   ftcWiZGOovnMxH8jh1WdPf1WYzflFWS+DX9kH0eCyIewsFghb5JuGRFd6
   mdMHcglAVEz6Mtu/HNFdqooFm2oQHO6xlNbIe/5taU2+I7syAqgsllJ6B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="385550701"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="385550701"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 13:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="686738112"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2022 13:04:45 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oa0Wy-0001RJ-2O;
        Sun, 18 Sep 2022 20:04:44 +0000
Date:   Mon, 19 Sep 2022 04:04:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 16/22]
 drivers/soc/apple/dockchannel.c:225:25: sparse: sparse: cast removes address
 space '__iomem' of expression
Message-ID: <202209190428.CeFvhMYP-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   ecf1fb81499a2f1724cb90497ca3c1cec831c9b6
commit: 47ac6f2f8d709398ea9d50e20f9babc21ef6ea47 [16/22] soc: apple: Add DockChannel driver
config: arm64-randconfig-s052-20220918 (https://download.01.org/0day-ci/archive/20220919/202209190428.CeFvhMYP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/47ac6f2f8d709398ea9d50e20f9babc21ef6ea47
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 47ac6f2f8d709398ea9d50e20f9babc21ef6ea47
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hid/ drivers/soc/apple/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/apple/dockchannel.c:225:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/soc/apple/dockchannel.c:229:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/soc/apple/dockchannel.c: note: in included file (through arch/arm64/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]

vim +/__iomem +225 drivers/soc/apple/dockchannel.c

   211	
   212	struct dockchannel *dockchannel_init(struct platform_device *pdev)
   213	{
   214		struct device *dev = &pdev->dev;
   215		struct dockchannel *dockchannel;
   216		int ret;
   217	
   218		dockchannel = devm_kzalloc(dev, sizeof(*dockchannel), GFP_KERNEL);
   219		if (!dockchannel)
   220			return ERR_PTR(-ENOMEM);
   221	
   222		dockchannel->dev = dev;
   223		dockchannel->config_base = devm_platform_ioremap_resource_byname(pdev, "config");
   224		if (IS_ERR(dockchannel->config_base))
 > 225			return (void *)dockchannel->config_base;
   226	
   227		dockchannel->data_base = devm_platform_ioremap_resource_byname(pdev, "data");
   228		if (IS_ERR(dockchannel->data_base))
   229			return (void *)dockchannel->data_base;
   230	
   231		ret = of_property_read_u32(dev->of_node, "apple,fifo-size", &dockchannel->fifo_size);
   232		if (ret)
   233			return ERR_PTR(dev_err_probe(dev, ret, "Missing apple,fifo-size property"));
   234	
   235		init_completion(&dockchannel->tx_comp);
   236		init_completion(&dockchannel->rx_comp);
   237	
   238		dockchannel->tx_irq = platform_get_irq_byname(pdev, "tx");
   239		if (dockchannel->tx_irq <= 0) {
   240			return ERR_PTR(dev_err_probe(dev, dockchannel->tx_irq,
   241					     "Failed to get TX IRQ"));
   242		}
   243	
   244		dockchannel->rx_irq = platform_get_irq_byname(pdev, "rx");
   245		if (dockchannel->rx_irq <= 0) {
   246			return ERR_PTR(dev_err_probe(dev, dockchannel->rx_irq,
   247					     "Failed to get RX IRQ"));
   248		}
   249	
   250		ret = devm_request_irq(dev, dockchannel->tx_irq, dockchannel_tx_irq, IRQF_NO_AUTOEN,
   251				       "apple-dockchannel-tx", dockchannel);
   252		if (ret)
   253			return ERR_PTR(dev_err_probe(dev, ret, "Failed to request TX IRQ"));
   254	
   255		ret = devm_request_threaded_irq(dev, dockchannel->rx_irq, dockchannel_rx_irq,
   256						dockchannel_rx_irq_thread, IRQF_NO_AUTOEN,
   257						"apple-dockchannel-rx", dockchannel);
   258		if (ret)
   259			return ERR_PTR(dev_err_probe(dev, ret, "Failed to request RX IRQ"));
   260	
   261		return dockchannel;
   262	}
   263	EXPORT_SYMBOL(dockchannel_init);
   264	
   265	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
