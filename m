Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AE06BFCD4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 21:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCRUuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 16:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCRUt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 16:49:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E98918AAF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679172597; x=1710708597;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lxn69jdMLWdBZXcfs9smY775evIkzAe/v8NFk3IiMaU=;
  b=FIZm9ZHouCXq5EEoWD5FmNX46mnDTWf3qtkH40uPaUq9gJJgei3rWVTw
   MXaociCH4bVy4fhcr6KbqwfPFsHiHHWg8pDmrz/ZBfy2DSDh7yWkfGFhl
   O0ItNaTVWLhB7usqsJi6z7Nlj0S6aZn954of8wuka3lepltAh9QOzhUys
   KAZBXwMOzWHdbPunlJfWay/uwRlffrKtFx/aTXs3XUhNISFWRxIFAWdCO
   ifrW6m555TJf+G/DXpynKyk1obZ+or+IelvPTaEQ6z2WxvafBzdp6fKyH
   6V77SWkS/b/nLV6Y3qyOshb41PZEll+x0b9e+Jm71YXo2Mnn4KkX4yUmY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="322307178"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="322307178"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 13:49:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="657923990"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="657923990"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2023 13:49:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pddUv-000AGf-2C;
        Sat, 18 Mar 2023 20:49:53 +0000
Date:   Sun, 19 Mar 2023 04:48:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: drivers/iommu/ipmmu-vmsa.c:946:34: warning: unused variable
 'ipmmu_of_ids'
Message-ID: <202303190415.v9Yl9Y57-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   534293368afa1a953c283310b82e4dc58309d51e
commit: b87d6d7fa405e23478f1e1dff6d66b5a533a5433 iommu/ipmmu-vmsa: Clean up bus_set_iommu()
date:   6 months ago
config: s390-randconfig-r044-20230319 (https://download.01.org/0day-ci/archive/20230319/202303190415.v9Yl9Y57-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b87d6d7fa405e23478f1e1dff6d66b5a533a5433
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b87d6d7fa405e23478f1e1dff6d66b5a533a5433
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303190415.v9Yl9Y57-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iommu/ipmmu-vmsa.c:11:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/iommu/ipmmu-vmsa.c:11:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/iommu/ipmmu-vmsa.c:11:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/iommu/ipmmu-vmsa.c:946:34: warning: unused variable 'ipmmu_of_ids' [-Wunused-const-variable]
   static const struct of_device_id ipmmu_of_ids[] = {
                                    ^
   13 warnings generated.


vim +/ipmmu_of_ids +946 drivers/iommu/ipmmu-vmsa.c

7a62ced8ebd0e1 Yoshihiro Shimoda       2021-09-07  945  
33f3ac9b511612 Magnus Damm             2017-10-16 @946  static const struct of_device_id ipmmu_of_ids[] = {
33f3ac9b511612 Magnus Damm             2017-10-16  947  	{
33f3ac9b511612 Magnus Damm             2017-10-16  948  		.compatible = "renesas,ipmmu-vmsa",
33f3ac9b511612 Magnus Damm             2017-10-16  949  		.data = &ipmmu_features_default,
60fb0083c9d43b Fabrizio Castro         2018-08-23  950  	}, {
60fb0083c9d43b Fabrizio Castro         2018-08-23  951  		.compatible = "renesas,ipmmu-r8a774a1",
60fb0083c9d43b Fabrizio Castro         2018-08-23  952  		.data = &ipmmu_features_rcar_gen3,
757f26a3a9ec2c Biju Das                2019-09-27  953  	}, {
757f26a3a9ec2c Biju Das                2019-09-27  954  		.compatible = "renesas,ipmmu-r8a774b1",
757f26a3a9ec2c Biju Das                2019-09-27  955  		.data = &ipmmu_features_rcar_gen3,
b6d39cd82241bf Fabrizio Castro         2018-12-13  956  	}, {
b6d39cd82241bf Fabrizio Castro         2018-12-13  957  		.compatible = "renesas,ipmmu-r8a774c0",
b6d39cd82241bf Fabrizio Castro         2018-12-13  958  		.data = &ipmmu_features_rcar_gen3,
4b2aa7a6f9b793 Marian-Cristian Rotariu 2020-07-14  959  	}, {
4b2aa7a6f9b793 Marian-Cristian Rotariu 2020-07-14  960  		.compatible = "renesas,ipmmu-r8a774e1",
4b2aa7a6f9b793 Marian-Cristian Rotariu 2020-07-14  961  		.data = &ipmmu_features_rcar_gen3,
58b8e8bf409236 Magnus Damm             2017-10-16  962  	}, {
58b8e8bf409236 Magnus Damm             2017-10-16  963  		.compatible = "renesas,ipmmu-r8a7795",
0b8ac1409641e1 Magnus Damm             2018-06-14  964  		.data = &ipmmu_features_rcar_gen3,
0b8ac1409641e1 Magnus Damm             2018-06-14  965  	}, {
0b8ac1409641e1 Magnus Damm             2018-06-14  966  		.compatible = "renesas,ipmmu-r8a7796",
0b8ac1409641e1 Magnus Damm             2018-06-14  967  		.data = &ipmmu_features_rcar_gen3,
17fe1618163980 Yoshihiro Shimoda       2020-06-11  968  	}, {
17fe1618163980 Yoshihiro Shimoda       2020-06-11  969  		.compatible = "renesas,ipmmu-r8a77961",
17fe1618163980 Yoshihiro Shimoda       2020-06-11  970  		.data = &ipmmu_features_rcar_gen3,
98dbffd39a6513 Jacopo Mondi            2018-06-14  971  	}, {
98dbffd39a6513 Jacopo Mondi            2018-06-14  972  		.compatible = "renesas,ipmmu-r8a77965",
98dbffd39a6513 Jacopo Mondi            2018-06-14  973  		.data = &ipmmu_features_rcar_gen3,
3701c123e1c13c Simon Horman            2018-06-14  974  	}, {
3701c123e1c13c Simon Horman            2018-06-14  975  		.compatible = "renesas,ipmmu-r8a77970",
3701c123e1c13c Simon Horman            2018-06-14  976  		.data = &ipmmu_features_rcar_gen3,
1cdeb52e5c245b Nikita Yushchenko       2021-09-23  977  	}, {
1cdeb52e5c245b Nikita Yushchenko       2021-09-23  978  		.compatible = "renesas,ipmmu-r8a77980",
1cdeb52e5c245b Nikita Yushchenko       2021-09-23  979  		.data = &ipmmu_features_rcar_gen3,
b0c32912150565 Hai Nguyen Pham         2018-10-17  980  	}, {
b0c32912150565 Hai Nguyen Pham         2018-10-17  981  		.compatible = "renesas,ipmmu-r8a77990",
b0c32912150565 Hai Nguyen Pham         2018-10-17  982  		.data = &ipmmu_features_rcar_gen3,
3701c123e1c13c Simon Horman            2018-06-14  983  	}, {
3701c123e1c13c Simon Horman            2018-06-14  984  		.compatible = "renesas,ipmmu-r8a77995",
3701c123e1c13c Simon Horman            2018-06-14  985  		.data = &ipmmu_features_rcar_gen3,
7a62ced8ebd0e1 Yoshihiro Shimoda       2021-09-07  986  	}, {
7a62ced8ebd0e1 Yoshihiro Shimoda       2021-09-07  987  		.compatible = "renesas,ipmmu-r8a779a0",
ae684caf465b7d Yoshihiro Shimoda       2022-02-08  988  		.data = &ipmmu_features_rcar_gen4,
ae684caf465b7d Yoshihiro Shimoda       2022-02-08  989  	}, {
9f7d09fe23a011 Yoshihiro Shimoda       2022-06-17  990  		.compatible = "renesas,rcar-gen4-ipmmu-vmsa",
ae684caf465b7d Yoshihiro Shimoda       2022-02-08  991  		.data = &ipmmu_features_rcar_gen4,
33f3ac9b511612 Magnus Damm             2017-10-16  992  	}, {
33f3ac9b511612 Magnus Damm             2017-10-16  993  		/* Terminator */
33f3ac9b511612 Magnus Damm             2017-10-16  994  	},
33f3ac9b511612 Magnus Damm             2017-10-16  995  };
33f3ac9b511612 Magnus Damm             2017-10-16  996  

:::::: The code at line 946 was first introduced by commit
:::::: 33f3ac9b511612153bae1d328b0c84c0367cd08d iommu/ipmmu-vmsa: Introduce features, break out alias

:::::: TO: Magnus Damm <damm+renesas@opensource.se>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
