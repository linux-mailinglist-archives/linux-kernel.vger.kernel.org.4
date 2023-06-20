Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB37B7363E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjFTG6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFTG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:58:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D067310E0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687244282; x=1718780282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=llTCWhOhR58T/sQpxEMD9zJnBcRiKi5Uwg2/ZHUp1zU=;
  b=Dwp2s39jN0LCqHK7XDPmz6aQ0CsN3OPfV6yf0ZTpWcKkH2FJY3iqxGkR
   4288EteTXsNoOH6aU2dPNuPPQBRzToVv3BpTIpp2dggi3We6RhGXLQHGK
   GHzUBsVH5PreeJenWUYxwPNfnZYjJ7ROaWb+T8uVa4O8Vj9Srcy/sUqld
   COIZP/nPwFqGvsgZoyXU4cYsYbgTCM7N5pNanRsy0J8DbwWfaDV5CrVLn
   yl5ZnbIbmFSzYE5ZCHfHfoCIkRSGtlqkVtFBmvBbStKi4g7Sr6MQ1Btnh
   b+eUf0+9XzhG9OF8F0a+MUXl/8EtHqf0czBl7k0k+lQ1Eg9TZehpCsOwu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="344527437"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="344527437"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 23:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838104196"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838104196"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jun 2023 23:58:00 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBVJQ-0005cG-00;
        Tue, 20 Jun 2023 06:58:00 +0000
Date:   Tue, 20 Jun 2023 14:57:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/fsl_uli1575.c:236:39: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202306201429.YCHG0znZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   692b7dc87ca6d55ab254f8259e6f970171dc9d01
commit: 22fdf79171e8509db54599fd2c05ef0022ee83f5 powerpc/fsl_uli1575: Allow to disable FSL_ULI1575 support
date:   9 weeks ago
config: powerpc-randconfig-s043-20230620 (https://download.01.org/0day-ci/archive/20230620/202306201429.YCHG0znZ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306201429.YCHG0znZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306201429.YCHG0znZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/fsl_uli1575.c:236:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *dummy @@     got void [noderef] __iomem * @@
   arch/powerpc/platforms/fsl_uli1575.c:236:39: sparse:     expected unsigned char [usertype] *dummy
   arch/powerpc/platforms/fsl_uli1575.c:236:39: sparse:     got void [noderef] __iomem *
   arch/powerpc/platforms/fsl_uli1575.c:238:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *dummy @@     got void [noderef] __iomem * @@
   arch/powerpc/platforms/fsl_uli1575.c:238:39: sparse:     expected unsigned char [usertype] *dummy
   arch/powerpc/platforms/fsl_uli1575.c:238:39: sparse:     got void [noderef] __iomem *
>> arch/powerpc/platforms/fsl_uli1575.c:240:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char const volatile [noderef] [usertype] __iomem *addr @@     got unsigned char [usertype] *dummy @@
   arch/powerpc/platforms/fsl_uli1575.c:240:38: sparse:     expected unsigned char const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/fsl_uli1575.c:240:38: sparse:     got unsigned char [usertype] *dummy
>> arch/powerpc/platforms/fsl_uli1575.c:241:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *dummy @@
   arch/powerpc/platforms/fsl_uli1575.c:241:41: sparse:     expected void volatile [noderef] __iomem *addr
   arch/powerpc/platforms/fsl_uli1575.c:241:41: sparse:     got unsigned char [usertype] *dummy
>> arch/powerpc/platforms/fsl_uli1575.c:338:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *addr @@     got unsigned int * @@
   arch/powerpc/platforms/fsl_uli1575.c:338:26: sparse:     expected restricted __be32 const [usertype] *addr
   arch/powerpc/platforms/fsl_uli1575.c:338:26: sparse:     got unsigned int *

vim +236 arch/powerpc/platforms/fsl_uli1575.c

b66510cb9992d2 Kumar Gala         2007-08-16  217  
b66510cb9992d2 Kumar Gala         2007-08-16  218  /* We have to do a dummy read on the P2P for the RTC to work, WTF */
cad5cef62a5a0c Greg Kroah-Hartman 2012-12-21  219  static void quirk_final_uli5249(struct pci_dev *dev)
b66510cb9992d2 Kumar Gala         2007-08-16  220  {
b66510cb9992d2 Kumar Gala         2007-08-16  221  	int i;
b66510cb9992d2 Kumar Gala         2007-08-16  222  	u8 *dummy;
b66510cb9992d2 Kumar Gala         2007-08-16  223  	struct pci_bus *bus = dev->bus;
89a74ecccd1f78 Bjorn Helgaas      2010-02-23  224  	struct resource *res;
1fce2d01dff65a Kumar Gala         2008-10-02  225  	resource_size_t end = 0;
1fce2d01dff65a Kumar Gala         2008-10-02  226  
1fce2d01dff65a Kumar Gala         2008-10-02  227  	for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCES+3; i++) {
1fce2d01dff65a Kumar Gala         2008-10-02  228  		unsigned long flags = pci_resource_flags(dev, i);
1fce2d01dff65a Kumar Gala         2008-10-02  229  		if ((flags & (IORESOURCE_MEM|IORESOURCE_PREFETCH)) == IORESOURCE_MEM)
1fce2d01dff65a Kumar Gala         2008-10-02  230  			end = pci_resource_end(dev, i);
1fce2d01dff65a Kumar Gala         2008-10-02  231  	}
b66510cb9992d2 Kumar Gala         2007-08-16  232  
89a74ecccd1f78 Bjorn Helgaas      2010-02-23  233  	pci_bus_for_each_resource(bus, res, i) {
89a74ecccd1f78 Bjorn Helgaas      2010-02-23  234  		if (res && res->flags & IORESOURCE_MEM) {
89a74ecccd1f78 Bjorn Helgaas      2010-02-23  235  			if (res->end == end)
89a74ecccd1f78 Bjorn Helgaas      2010-02-23 @236  				dummy = ioremap(res->start, 0x4);
1fce2d01dff65a Kumar Gala         2008-10-02  237  			else
89a74ecccd1f78 Bjorn Helgaas      2010-02-23  238  				dummy = ioremap(res->end - 3, 0x4);
b66510cb9992d2 Kumar Gala         2007-08-16  239  			if (dummy) {
b66510cb9992d2 Kumar Gala         2007-08-16 @240  				in_8(dummy);
b66510cb9992d2 Kumar Gala         2007-08-16 @241  				iounmap(dummy);
b66510cb9992d2 Kumar Gala         2007-08-16  242  			}
b66510cb9992d2 Kumar Gala         2007-08-16  243  			break;
b66510cb9992d2 Kumar Gala         2007-08-16  244  		}
b66510cb9992d2 Kumar Gala         2007-08-16  245  	}
b66510cb9992d2 Kumar Gala         2007-08-16  246  }
b66510cb9992d2 Kumar Gala         2007-08-16  247  
b66510cb9992d2 Kumar Gala         2007-08-16  248  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
b66510cb9992d2 Kumar Gala         2007-08-16  249  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
b66510cb9992d2 Kumar Gala         2007-08-16  250  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
b66510cb9992d2 Kumar Gala         2007-08-16  251  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
b66510cb9992d2 Kumar Gala         2007-08-16  252  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5249, quirk_final_uli5249);
b66510cb9992d2 Kumar Gala         2007-08-16  253  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x1575, quirk_final_uli1575);
1433fa7d8da608 Jason Jin          2008-12-04  254  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
b66510cb9992d2 Kumar Gala         2007-08-16  255  
cad5cef62a5a0c Greg Kroah-Hartman 2012-12-21  256  static void hpcd_quirk_uli1575(struct pci_dev *dev)
52ddd1cdc92380 Anton Vorontsov    2008-06-12  257  {
52ddd1cdc92380 Anton Vorontsov    2008-06-12  258  	u32 temp32;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  259  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  260  	if (!machine_is(mpc86xx_hpcd))
52ddd1cdc92380 Anton Vorontsov    2008-06-12  261  		return;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  262  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  263  	/* Disable INTx */
52ddd1cdc92380 Anton Vorontsov    2008-06-12  264  	pci_read_config_dword(dev, 0x48, &temp32);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  265  	pci_write_config_dword(dev, 0x48, (temp32 | 1<<26));
52ddd1cdc92380 Anton Vorontsov    2008-06-12  266  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  267  	/* Enable sideband interrupt */
52ddd1cdc92380 Anton Vorontsov    2008-06-12  268  	pci_read_config_dword(dev, 0x90, &temp32);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  269  	pci_write_config_dword(dev, 0x90, (temp32 | 1<<22));
52ddd1cdc92380 Anton Vorontsov    2008-06-12  270  }
52ddd1cdc92380 Anton Vorontsov    2008-06-12  271  
cad5cef62a5a0c Greg Kroah-Hartman 2012-12-21  272  static void hpcd_quirk_uli5288(struct pci_dev *dev)
52ddd1cdc92380 Anton Vorontsov    2008-06-12  273  {
52ddd1cdc92380 Anton Vorontsov    2008-06-12  274  	unsigned char c;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  275  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  276  	if (!machine_is(mpc86xx_hpcd))
52ddd1cdc92380 Anton Vorontsov    2008-06-12  277  		return;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  278  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  279  	pci_read_config_byte(dev, 0x83, &c);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  280  	c |= 0x80;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  281  	pci_write_config_byte(dev, 0x83, c);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  282  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  283  	pci_write_config_byte(dev, PCI_CLASS_PROG, 0x01);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  284  	pci_write_config_byte(dev, PCI_CLASS_DEVICE, 0x06);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  285  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  286  	pci_read_config_byte(dev, 0x83, &c);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  287  	c &= 0x7f;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  288  	pci_write_config_byte(dev, 0x83, c);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  289  }
52ddd1cdc92380 Anton Vorontsov    2008-06-12  290  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  291  /*
52ddd1cdc92380 Anton Vorontsov    2008-06-12  292   * Since 8259PIC was disabled on the board, the IDE device can not
52ddd1cdc92380 Anton Vorontsov    2008-06-12  293   * use the legacy IRQ, we need to let the IDE device work under
52ddd1cdc92380 Anton Vorontsov    2008-06-12  294   * native mode and use the interrupt line like other PCI devices.
52ddd1cdc92380 Anton Vorontsov    2008-06-12  295   * IRQ14 is a sideband interrupt from IDE device to CPU and we use this
52ddd1cdc92380 Anton Vorontsov    2008-06-12  296   * as the interrupt for IDE device.
52ddd1cdc92380 Anton Vorontsov    2008-06-12  297   */
cad5cef62a5a0c Greg Kroah-Hartman 2012-12-21  298  static void hpcd_quirk_uli5229(struct pci_dev *dev)
52ddd1cdc92380 Anton Vorontsov    2008-06-12  299  {
52ddd1cdc92380 Anton Vorontsov    2008-06-12  300  	unsigned char c;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  301  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  302  	if (!machine_is(mpc86xx_hpcd))
52ddd1cdc92380 Anton Vorontsov    2008-06-12  303  		return;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  304  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  305  	pci_read_config_byte(dev, 0x4b, &c);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  306  	c |= 0x10;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  307  	pci_write_config_byte(dev, 0x4b, c);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  308  }
52ddd1cdc92380 Anton Vorontsov    2008-06-12  309  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  310  /*
52ddd1cdc92380 Anton Vorontsov    2008-06-12  311   * SATA interrupt pin bug fix
52ddd1cdc92380 Anton Vorontsov    2008-06-12  312   * There's a chip bug for 5288, The interrupt pin should be 2,
52ddd1cdc92380 Anton Vorontsov    2008-06-12  313   * not the read only value 1, So it use INTB#, not INTA# which
52ddd1cdc92380 Anton Vorontsov    2008-06-12  314   * actually used by the IDE device 5229.
52ddd1cdc92380 Anton Vorontsov    2008-06-12  315   * As of this bug, during the PCI initialization, 5288 read the
52ddd1cdc92380 Anton Vorontsov    2008-06-12  316   * irq of IDE device from the device tree, this function fix this
52ddd1cdc92380 Anton Vorontsov    2008-06-12  317   * bug by re-assigning a correct irq to 5288.
52ddd1cdc92380 Anton Vorontsov    2008-06-12  318   *
52ddd1cdc92380 Anton Vorontsov    2008-06-12  319   */
cad5cef62a5a0c Greg Kroah-Hartman 2012-12-21  320  static void hpcd_final_uli5288(struct pci_dev *dev)
52ddd1cdc92380 Anton Vorontsov    2008-06-12  321  {
52ddd1cdc92380 Anton Vorontsov    2008-06-12  322  	struct pci_controller *hose = pci_bus_to_host(dev->bus);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  323  	struct device_node *hosenode = hose ? hose->dn : NULL;
530210c7814e83 Grant Likely       2013-09-15  324  	struct of_phandle_args oirq;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  325  	u32 laddr[3];
52ddd1cdc92380 Anton Vorontsov    2008-06-12  326  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  327  	if (!machine_is(mpc86xx_hpcd))
52ddd1cdc92380 Anton Vorontsov    2008-06-12  328  		return;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  329  
52ddd1cdc92380 Anton Vorontsov    2008-06-12  330  	if (!hosenode)
52ddd1cdc92380 Anton Vorontsov    2008-06-12  331  		return;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  332  
2361613206e66c Grant Likely       2013-09-15  333  	oirq.np = hosenode;
2361613206e66c Grant Likely       2013-09-15  334  	oirq.args[0] = 2;
2361613206e66c Grant Likely       2013-09-15  335  	oirq.args_count = 1;
52ddd1cdc92380 Anton Vorontsov    2008-06-12  336  	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(31, 0) << 8);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  337  	laddr[1] = laddr[2] = 0;
2361613206e66c Grant Likely       2013-09-15 @338  	of_irq_parse_raw(laddr, &oirq);
e6d30ab1e7d128 Grant Likely       2013-09-15  339  	dev->irq = irq_create_of_mapping(&oirq);
52ddd1cdc92380 Anton Vorontsov    2008-06-12  340  }
52ddd1cdc92380 Anton Vorontsov    2008-06-12  341  

:::::: The code at line 236 was first introduced by commit
:::::: 89a74ecccd1f78e51faf6287e5c0e93a92ac096e PCI: add pci_bus_for_each_resource(), remove direct bus->resource[] refs

:::::: TO: Bjorn Helgaas <bjorn.helgaas@hp.com>
:::::: CC: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
