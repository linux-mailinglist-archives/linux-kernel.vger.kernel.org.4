Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7E974521B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjGBUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjGBUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:08:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354A44A9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688328410; x=1719864410;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m7Tnn3iBRte6BDuPLg/jUeGa3Fqcc0ZEH3Det3i8X5w=;
  b=GpzDueQ3QLG7JG63JDakSDwLaagklcWTI/fdiND4pBlsZzFaML4GNPAU
   sEcPH5aTyIfayg3mGGiyxPJWTr8d3yYo4jpYwBlGalwV2d8ARdy32fFl6
   idlZHTKkOLYTnSfOelrgr81ZiL3cMT0jRlvTuyukRxEhzwUHzHXo4q/+v
   LoT39pwfa1/drSZiPtO19Soet4x3o+RYneLaQzyNR/Rdw52obpmK59JPU
   A9ExZvgyvVrKY/Bn9ZKM5N3AcFMkTGaujdWkC6ZHDXLrpm3eZYdWKft+r
   id0R8xbNIMKnBPCeYMAA7ZMjwLQkipzVsHcWdFQduzXv4yxa+I+CDANMr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="393476133"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="393476133"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 13:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="788303134"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="788303134"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2023 13:06:47 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qG3LK-000GrH-2M;
        Sun, 02 Jul 2023 20:06:46 +0000
Date:   Mon, 3 Jul 2023 04:06:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/mux/mmio.c:76:20: error: variable has incomplete type
 'struct reg_field'
Message-ID: <202307030449.fwsrHOMh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
commit: e4d4371253029528c02bfb43a46c252e1c3d035f phy: phy-can-transceiver: Add support for setting mux
date:   1 year, 3 months ago
config: s390-randconfig-r026-20230703 (https://download.01.org/0day-ci/archive/20230703/202307030449.fwsrHOMh-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230703/202307030449.fwsrHOMh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307030449.fwsrHOMh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/mux/mmio.c:16:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     464 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     477 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/mux/mmio.c:16:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     490 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/mux/mmio.c:16:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     501 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     511 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     521 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     609 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     617 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     625 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     634 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     643 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     652 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/mux/mmio.c:76:20: error: variable has incomplete type 'struct reg_field'
      76 |                 struct reg_field field;
         |                                  ^
   drivers/mux/mmio.c:76:10: note: forward declaration of 'struct reg_field'
      76 |                 struct reg_field field;
         |                        ^
>> drivers/mux/mmio.c:102:15: error: call to undeclared function 'devm_regmap_field_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     102 |                 fields[i] = devm_regmap_field_alloc(dev, regmap, field);
         |                             ^
   12 warnings and 2 errors generated.


vim +76 drivers/mux/mmio.c

73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   35  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   36  static int mux_mmio_probe(struct platform_device *pdev)
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   37  {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   38  	struct device *dev = &pdev->dev;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   39  	struct device_node *np = dev->of_node;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   40  	struct regmap_field **fields;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   41  	struct mux_chip *mux_chip;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   42  	struct regmap *regmap;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   43  	int num_fields;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   44  	int ret;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   45  	int i;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   46  
8ecfaca7926f4b drivers/mux/mmio.c     Pankaj Bansal 2019-06-12   47  	if (of_device_is_compatible(np, "mmio-mux"))
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   48  		regmap = syscon_node_to_regmap(np->parent);
8ecfaca7926f4b drivers/mux/mmio.c     Pankaj Bansal 2019-06-12   49  	else
8ecfaca7926f4b drivers/mux/mmio.c     Pankaj Bansal 2019-06-12   50  		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   51  	if (IS_ERR(regmap)) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   52  		ret = PTR_ERR(regmap);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   53  		dev_err(dev, "failed to get regmap: %d\n", ret);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   54  		return ret;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   55  	}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   56  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   57  	ret = of_property_count_u32_elems(np, "mux-reg-masks");
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   58  	if (ret == 0 || ret % 2)
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   59  		ret = -EINVAL;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   60  	if (ret < 0) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   61  		dev_err(dev, "mux-reg-masks property missing or invalid: %d\n",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   62  			ret);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   63  		return ret;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   64  	}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   65  	num_fields = ret / 2;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   66  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   67  	mux_chip = devm_mux_chip_alloc(dev, num_fields, num_fields *
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   68  				       sizeof(*fields));
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   69  	if (IS_ERR(mux_chip))
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   70  		return PTR_ERR(mux_chip);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   71  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   72  	fields = mux_chip_priv(mux_chip);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   73  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   74  	for (i = 0; i < num_fields; i++) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   75  		struct mux_control *mux = &mux_chip->mux[i];
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  @76  		struct reg_field field;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   77  		s32 idle_state = MUX_IDLE_AS_IS;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   78  		u32 reg, mask;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   79  		int bits;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   80  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   81  		ret = of_property_read_u32_index(np, "mux-reg-masks",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   82  						 2 * i, &reg);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   83  		if (!ret)
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   84  			ret = of_property_read_u32_index(np, "mux-reg-masks",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   85  							 2 * i + 1, &mask);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   86  		if (ret < 0) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   87  			dev_err(dev, "bitfield %d: failed to read mux-reg-masks property: %d\n",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   88  				i, ret);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   89  			return ret;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   90  		}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   91  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   92  		field.reg = reg;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   93  		field.msb = fls(mask) - 1;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   94  		field.lsb = ffs(mask) - 1;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   95  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   96  		if (mask != GENMASK(field.msb, field.lsb)) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   97  			dev_err(dev, "bitfield %d: invalid mask 0x%x\n",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   98  				i, mask);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   99  			return -EINVAL;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  100  		}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  101  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14 @102  		fields[i] = devm_regmap_field_alloc(dev, regmap, field);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  103  		if (IS_ERR(fields[i])) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  104  			ret = PTR_ERR(fields[i]);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  105  			dev_err(dev, "bitfield %d: failed allocate: %d\n",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  106  				i, ret);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  107  			return ret;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  108  		}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  109  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  110  		bits = 1 + field.msb - field.lsb;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  111  		mux->states = 1 << bits;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  112  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  113  		of_property_read_u32_index(np, "idle-states", i,
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  114  					   (u32 *)&idle_state);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  115  		if (idle_state != MUX_IDLE_AS_IS) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  116  			if (idle_state < 0 || idle_state >= mux->states) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  117  				dev_err(dev, "bitfield: %d: out of range idle state %d\n",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  118  					i, idle_state);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  119  				return -EINVAL;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  120  			}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  121  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  122  			mux->idle_state = idle_state;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  123  		}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  124  	}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  125  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  126  	mux_chip->ops = &mux_mmio_ops;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  127  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  128  	return devm_mux_chip_register(dev, mux_chip);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  129  }
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  130  

:::::: The code at line 76 was first introduced by commit
:::::: 73726380a26fa1ed490f30fccee10ed9da28dc0c mux: mmio-based syscon mux controller

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
