Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E087673EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjASQeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjASQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:34:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A60C4DBE3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674146066; x=1705682066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+pzVIm+NVVCm+tED07C3lguimSN2uvhe+hLPduJWTdc=;
  b=nwgC6IVmMhV387h5HGFj/c/8TKWHf90aC82s4F7TugKSsgvWiB7MeOBm
   V2tXwQLWwgCwg2xiUef3FkW8danihOZIGo+sksIVPC/ihfG2hthHl0/DX
   bIHvasy8JBbXFcY3PcCinzKajxOyIFMbbxBRqfv6uOYfQU4HHt9/c3YYj
   IMoOy04aTYacnztnbQ7FdbisZEKEs8vN2JlEwjOf12wobRYfKmHXfFVmd
   IpeqpVSb/1kIzY/k84pFVibHGR6Jjjj9XlWShWOfEptM/8maO6CbXj5K0
   xoSVRbD6hZCJ/sUl+QRsVARYUNIxWhH0Nh0eVRbgG/ArDt+dMBU1HXNhb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="325377957"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="325377957"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:33:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="784119242"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="784119242"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2023 08:33:00 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIXqV-0001dA-10;
        Thu, 19 Jan 2023 16:32:59 +0000
Date:   Fri, 20 Jan 2023 00:32:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/net/dsa/microchip/ksz9477_i2c.c:89:34: warning: unused
 variable 'ksz9477_dt_ids'
Message-ID: <202301200026.knQAJz4B-lkp@intel.com>
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

Hi Arun,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7287904c8771b77b9504f53623bb477065c19a58
commit: 07bca160469b4d19ca0a35bc83b26ed18fcbd96d net: dsa: microchip: common menuconfig for ksz series switch
date:   7 months ago
config: s390-buildonly-randconfig-r001-20230119 (https://download.01.org/0day-ci/archive/20230120/202301200026.knQAJz4B-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07bca160469b4d19ca0a35bc83b26ed18fcbd96d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 07bca160469b4d19ca0a35bc83b26ed18fcbd96d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/dsa/microchip/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/dsa/microchip/ksz9477_i2c.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/net/dsa/microchip/ksz9477_i2c.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/net/dsa/microchip/ksz9477_i2c.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
>> drivers/net/dsa/microchip/ksz9477_i2c.c:89:34: warning: unused variable 'ksz9477_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id ksz9477_dt_ids[] = {
                                    ^
   13 warnings generated.


vim +/ksz9477_dt_ids +89 drivers/net/dsa/microchip/ksz9477_i2c.c

20e03777d70923 Tristram Ha   2019-09-10   88  
20e03777d70923 Tristram Ha   2019-09-10  @89  static const struct of_device_id ksz9477_dt_ids[] = {
eee16b147121ce Arun Ramadoss 2022-05-17   90  	{
eee16b147121ce Arun Ramadoss 2022-05-17   91  		.compatible = "microchip,ksz9477",
eee16b147121ce Arun Ramadoss 2022-05-17   92  		.data = &ksz_switch_chips[KSZ9477]
eee16b147121ce Arun Ramadoss 2022-05-17   93  	},
eee16b147121ce Arun Ramadoss 2022-05-17   94  	{
eee16b147121ce Arun Ramadoss 2022-05-17   95  		.compatible = "microchip,ksz9897",
eee16b147121ce Arun Ramadoss 2022-05-17   96  		.data = &ksz_switch_chips[KSZ9897]
eee16b147121ce Arun Ramadoss 2022-05-17   97  	},
eee16b147121ce Arun Ramadoss 2022-05-17   98  	{
eee16b147121ce Arun Ramadoss 2022-05-17   99  		.compatible = "microchip,ksz9893",
eee16b147121ce Arun Ramadoss 2022-05-17  100  		.data = &ksz_switch_chips[KSZ9893]
eee16b147121ce Arun Ramadoss 2022-05-17  101  	},
eee16b147121ce Arun Ramadoss 2022-05-17  102  	{
eee16b147121ce Arun Ramadoss 2022-05-17  103  		.compatible = "microchip,ksz9563",
eee16b147121ce Arun Ramadoss 2022-05-17  104  		.data = &ksz_switch_chips[KSZ9893]
eee16b147121ce Arun Ramadoss 2022-05-17  105  	},
eee16b147121ce Arun Ramadoss 2022-05-17  106  	{
eee16b147121ce Arun Ramadoss 2022-05-17  107  		.compatible = "microchip,ksz8563",
eee16b147121ce Arun Ramadoss 2022-05-17  108  		.data = &ksz_switch_chips[KSZ9893]
eee16b147121ce Arun Ramadoss 2022-05-17  109  	},
eee16b147121ce Arun Ramadoss 2022-05-17  110  	{
eee16b147121ce Arun Ramadoss 2022-05-17  111  		.compatible = "microchip,ksz9567",
eee16b147121ce Arun Ramadoss 2022-05-17  112  		.data = &ksz_switch_chips[KSZ9567]
eee16b147121ce Arun Ramadoss 2022-05-17  113  	},
20e03777d70923 Tristram Ha   2019-09-10  114  	{},
20e03777d70923 Tristram Ha   2019-09-10  115  };
20e03777d70923 Tristram Ha   2019-09-10  116  MODULE_DEVICE_TABLE(of, ksz9477_dt_ids);
20e03777d70923 Tristram Ha   2019-09-10  117  

:::::: The code at line 89 was first introduced by commit
:::::: 20e03777d70923fe7eae0d7f043ef9488393ab95 net: dsa: microchip: add KSZ9477 I2C driver

:::::: TO: Tristram Ha <Tristram.Ha@microchip.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
