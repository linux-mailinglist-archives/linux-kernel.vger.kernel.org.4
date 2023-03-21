Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265EF6C393E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCUSe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCUSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:34:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394D4B774
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679423692; x=1710959692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5x1Og7kqSvgvununIKif6UKcMxpKZfrdZfFOD/sO36U=;
  b=CPz23ESBWhS8OWEDv7b1GsB1l9ShogeBA+VCSq9nwgw5EFHUqgRmef4w
   CWd4YsoQ80JBO/ug4YfkUb5+cJ5cEEfNlDysBvElXXpzDujg0/YajKYO1
   mYKKD+PqiFioMDETMiC0w4nI3zoNSz+l0LNN++VELsFSjOXLZRoufeRb9
   TucNAnyPRLftLRgtr7zuPntm0++L4Cl4A6w7oub/RLp9ktzvF3izulHxp
   t0qgecsPUngWWhdSom/Ao0lLCs+w9LsRQQM1XU5edudOCgWJYyggnC4E2
   W3A3ui+CnUVcDSG02cwfdKcELnb6arwbLEtiG7aAm/T57ndGOqEN41C8q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319419855"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="319419855"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 11:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="711922094"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="711922094"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Mar 2023 11:34:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pegoq-000CHc-0S;
        Tue, 21 Mar 2023 18:34:48 +0000
Date:   Wed, 22 Mar 2023 02:34:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     ye.xingchen@zte.com.cn, miquel.raynal@bootlin.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: =?iso-8859-1?Q?f?=
 =?iso-8859-1?Q?smc=3A_use=A0devm=5Fplatform=5Fioremap=5Fresource=5Fbyname?=
 =?iso-8859-1?B?KCk=?=
Message-ID: <202303220218.hFhiRfHp-lkp@intel.com>
References: <202303211954042531445@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202303211954042531445@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on linus/master v6.3-rc3 next-20230321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ye-xingchen-zte-com-cn/mtd-rawnand-fsmc-use-devm_platform_ioremap_resource_byname/20230321-195547
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/202303211954042531445%40zte.com.cn
patch subject: [PATCH] mtd: rawnand: fsmc: use devm_platform_ioremap_resource_byname()
config: hexagon-randconfig-r045-20230319 (https://download.01.org/0day-ci/archive/20230322/202303220218.hFhiRfHp-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/21cf7720019aa3465edec29a32484a28e786731b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review ye-xingchen-zte-com-cn/mtd-rawnand-fsmc-use-devm_platform_ioremap_resource_byname/20230321-195547
        git checkout 21cf7720019aa3465edec29a32484a28e786731b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/mtd/nand/raw/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303220218.hFhiRfHp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mtd/nand/raw/fsmc_nand.c:19:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/mtd/nand/raw/fsmc_nand.c:19:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/mtd/nand/raw/fsmc_nand.c:19:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/mtd/nand/raw/fsmc_nand.c:1048:30: warning: variable 'res' is uninitialized when used here [-Wuninitialized]
           host->data_pa = (dma_addr_t)res->start;
                                       ^~~
   drivers/mtd/nand/raw/fsmc_nand.c:1026:22: note: initialize the variable 'res' to silence this warning
           struct resource *res;
                               ^
                                = NULL
   7 warnings generated.


vim +/res +1048 drivers/mtd/nand/raw/fsmc_nand.c

ab3ab7b654ae69 drivers/mtd/nand/raw/fsmc_nand.c Linus Walleij                    2019-01-26  1016  
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1017  /*
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1018   * fsmc_nand_probe - Probe function
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1019   * @pdev:       platform device structure
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1020   */
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1021  static int __init fsmc_nand_probe(struct platform_device *pdev)
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1022  {
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1023  	struct fsmc_nand_data *host;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1024  	struct mtd_info *mtd;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1025  	struct nand_chip *nand;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1026  	struct resource *res;
4df6ed4f0ac9a1 drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-02-16  1027  	void __iomem *base;
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1028  	dma_cap_mask_t mask;
4ad916bca7c372 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1029  	int ret = 0;
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1030  	u32 pid;
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1031  	int i;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1032  
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1033  	/* Allocate memory for the device structure (and zero it) */
82b9dbe2e0f687 drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1034  	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
d9a21ae8e5f3fe drivers/mtd/nand/fsmc_nand.c     Jingoo Han                       2013-12-26  1035  	if (!host)
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1036  		return -ENOMEM;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1037  
a1b1e1d5bdfe79 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1038  	nand = &host->nand;
a1b1e1d5bdfe79 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1039  
a1b1e1d5bdfe79 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1040  	ret = fsmc_nand_probe_config_dt(pdev, host, nand);
a1b1e1d5bdfe79 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1041  	if (ret)
a1b1e1d5bdfe79 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1042  		return ret;
a1b1e1d5bdfe79 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1043  
21cf7720019aa3 drivers/mtd/nand/raw/fsmc_nand.c Ye Xingchen                      2023-03-21  1044  	host->data_va = devm_platform_ioremap_resource_byname(pdev, "nand_data");
b0de774c6334dc drivers/mtd/nand/fsmc_nand.c     Thierry Reding                   2013-01-21  1045  	if (IS_ERR(host->data_va))
b0de774c6334dc drivers/mtd/nand/fsmc_nand.c     Thierry Reding                   2013-01-21  1046  		return PTR_ERR(host->data_va);
b0de774c6334dc drivers/mtd/nand/fsmc_nand.c     Thierry Reding                   2013-01-21  1047  
6d7b42a447f92e drivers/mtd/nand/fsmc_nand.c     Jean-Christophe PLAGNIOL-VILLARD 2012-10-04 @1048  	host->data_pa = (dma_addr_t)res->start;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1049  
21cf7720019aa3 drivers/mtd/nand/raw/fsmc_nand.c Ye Xingchen                      2023-03-21  1050  	host->addr_va = devm_platform_ioremap_resource_byname(pdev, "nand_addr");
b0de774c6334dc drivers/mtd/nand/fsmc_nand.c     Thierry Reding                   2013-01-21  1051  	if (IS_ERR(host->addr_va))
b0de774c6334dc drivers/mtd/nand/fsmc_nand.c     Thierry Reding                   2013-01-21  1052  		return PTR_ERR(host->addr_va);
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1053  
21cf7720019aa3 drivers/mtd/nand/raw/fsmc_nand.c Ye Xingchen                      2023-03-21  1054  	host->cmd_va = devm_platform_ioremap_resource_byname(pdev, "nand_cmd");
b0de774c6334dc drivers/mtd/nand/fsmc_nand.c     Thierry Reding                   2013-01-21  1055  	if (IS_ERR(host->cmd_va))
b0de774c6334dc drivers/mtd/nand/fsmc_nand.c     Thierry Reding                   2013-01-21  1056  		return PTR_ERR(host->cmd_va);
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1057  
21cf7720019aa3 drivers/mtd/nand/raw/fsmc_nand.c Ye Xingchen                      2023-03-21  1058  	base = devm_platform_ioremap_resource_byname(pdev, "fsmc_regs");
4df6ed4f0ac9a1 drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-02-16  1059  	if (IS_ERR(base))
4df6ed4f0ac9a1 drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-02-16  1060  		return PTR_ERR(base);
4df6ed4f0ac9a1 drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-02-16  1061  
4df6ed4f0ac9a1 drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-02-16  1062  	host->regs_va = base + FSMC_NOR_REG_SIZE +
4df6ed4f0ac9a1 drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-02-16  1063  		(host->bank * FSMC_NAND_BANK_SZ);
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1064  
fb8ed2ca432443 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1065  	host->clk = devm_clk_get(&pdev->dev, NULL);
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1066  	if (IS_ERR(host->clk)) {
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1067  		dev_err(&pdev->dev, "failed to fetch block clock\n");
82b9dbe2e0f687 drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1068  		return PTR_ERR(host->clk);
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1069  	}
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1070  
e25da1c07dfb31 drivers/mtd/nand/fsmc_nand.c     Viresh Kumar                     2012-04-17  1071  	ret = clk_prepare_enable(host->clk);
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1072  	if (ret)
fb8ed2ca432443 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1073  		return ret;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1074  
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1075  	/*
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1076  	 * This device ID is actually a common AMBA ID as used on the
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1077  	 * AMBA PrimeCell bus. However it is not a PrimeCell.
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1078  	 */
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1079  	for (pid = 0, i = 0; i < 4; i++)
fc43f45ed563f5 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-20  1080  		pid |= (readl(base + resource_size(res) - 0x20 + 4 * i) &
fc43f45ed563f5 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-20  1081  			255) << (i * 8);
fc43f45ed563f5 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-20  1082  
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1083  	host->pid = pid;
fc43f45ed563f5 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-20  1084  
fc43f45ed563f5 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-20  1085  	dev_info(&pdev->dev,
fc43f45ed563f5 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-20  1086  		 "FSMC device partno %03x, manufacturer %02x, revision %02x, config %02x\n",
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1087  		 AMBA_PART_BITS(pid), AMBA_MANF_BITS(pid),
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1088  		 AMBA_REV_BITS(pid), AMBA_CONFIG_BITS(pid));
593cd8711221c9 drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-11-29  1089  
712c4add032771 drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1090  	host->dev = &pdev->dev;
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1091  
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1092  	if (host->mode == USE_DMA_ACCESS)
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1093  		init_completion(&host->dma_access_complete);
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1094  
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1095  	/* Link all private pointers */
bdf3a555015260 drivers/mtd/nand/fsmc_nand.c     Boris Brezillon                  2015-12-10  1096  	mtd = nand_to_mtd(&host->nand);
a1b1e1d5bdfe79 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1097  	nand_set_flash_node(nand, pdev->dev.of_node);
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1098  
bdf3a555015260 drivers/mtd/nand/fsmc_nand.c     Boris Brezillon                  2015-12-10  1099  	mtd->dev.parent = &pdev->dev;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1100  
467e6e7be2e26f drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1101  	nand->badblockbits = 7;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1102  
4da712e702941d drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-02-16  1103  	if (host->mode == USE_DMA_ACCESS) {
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1104  		dma_cap_zero(mask);
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1105  		dma_cap_set(DMA_MEMCPY, mask);
feb1e57ee58350 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1106  		host->read_dma_chan = dma_request_channel(mask, filter, NULL);
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1107  		if (!host->read_dma_chan) {
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1108  			dev_err(&pdev->dev, "Unable to get read dma channel\n");
e7a97528e3c787 drivers/mtd/nand/raw/fsmc_nand.c Dan Carpenter                    2021-02-15  1109  			ret = -ENODEV;
43fab011e93fea drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1110  			goto disable_clk;
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1111  		}
feb1e57ee58350 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1112  		host->write_dma_chan = dma_request_channel(mask, filter, NULL);
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1113  		if (!host->write_dma_chan) {
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1114  			dev_err(&pdev->dev, "Unable to get write dma channel\n");
e7a97528e3c787 drivers/mtd/nand/raw/fsmc_nand.c Dan Carpenter                    2021-02-15  1115  			ret = -ENODEV;
43fab011e93fea drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1116  			goto release_dma_read_chan;
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1117  		}
604e75444fa82c drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1118  	}
604e75444fa82c drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1119  
7a08dbaedd365f drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-11  1120  	if (host->dev_timings) {
6335b509b2b6fb drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-04-29  1121  		fsmc_nand_setup(host, host->dev_timings);
7a08dbaedd365f drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-11  1122  		nand->options |= NAND_KEEP_TIMINGS;
7a08dbaedd365f drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-11  1123  	}
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1124  
ad71148c1804c3 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-20  1125  	nand_controller_init(&host->base);
ad71148c1804c3 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-20  1126  	host->base.ops = &fsmc_nand_controller_ops;
ad71148c1804c3 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-20  1127  	nand->controller = &host->base;
ad71148c1804c3 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-11-20  1128  
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1129  	/*
25985edcedea63 drivers/mtd/nand/fsmc_nand.c     Lucas De Marchi                  2011-03-30  1130  	 * Scan to find existence of the device
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1131  	 */
00ad378f304a09 drivers/mtd/nand/raw/fsmc_nand.c Boris Brezillon                  2018-09-06  1132  	ret = nand_scan(nand, 1);
ad5678ec40764c drivers/mtd/nand/fsmc_nand.c     Masahiro Yamada                  2016-11-04  1133  	if (ret)
43fab011e93fea drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1134  		goto release_dma_write_chan;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1135  
bdf3a555015260 drivers/mtd/nand/fsmc_nand.c     Boris Brezillon                  2015-12-10  1136  	mtd->name = "nand";
ede29a020ec3b4 drivers/mtd/nand/fsmc_nand.c     Thomas Petazzoni                 2017-03-21  1137  	ret = mtd_device_register(mtd, NULL, 0);
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1138  	if (ret)
682cae27b1da05 drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1139  		goto cleanup_nand;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1140  
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1141  	platform_set_drvdata(pdev, host);
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1142  	dev_info(&pdev->dev, "FSMC NAND driver registration successful\n");
43fab011e93fea drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1143  
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1144  	return 0;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1145  
682cae27b1da05 drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1146  cleanup_nand:
682cae27b1da05 drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1147  	nand_cleanup(nand);
43fab011e93fea drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1148  release_dma_write_chan:
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1149  	if (host->mode == USE_DMA_ACCESS)
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1150  		dma_release_channel(host->write_dma_chan);
43fab011e93fea drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1151  release_dma_read_chan:
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1152  	if (host->mode == USE_DMA_ACCESS)
4774fb0a48aacf drivers/mtd/nand/fsmc_nand.c     Vipin Kumar                      2012-03-14  1153  		dma_release_channel(host->read_dma_chan);
43fab011e93fea drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1154  disable_clk:
ab3ab7b654ae69 drivers/mtd/nand/raw/fsmc_nand.c Linus Walleij                    2019-01-26  1155  	fsmc_nand_disable(host);
e25da1c07dfb31 drivers/mtd/nand/fsmc_nand.c     Viresh Kumar                     2012-04-17  1156  	clk_disable_unprepare(host->clk);
43fab011e93fea drivers/mtd/nand/raw/fsmc_nand.c Miquel Raynal                    2018-04-21  1157  
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1158  	return ret;
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1159  }
6c009ab89a212b drivers/mtd/nand/fsmc_nand.c     Linus Walleij                    2010-09-13  1160  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
