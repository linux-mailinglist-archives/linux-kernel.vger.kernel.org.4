Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B717768FC6E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjBIBJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjBIBJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:09:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4561F23840;
        Wed,  8 Feb 2023 17:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675904962; x=1707440962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GI8IwpHrCtLwdiOPxD0L9G1DYq+NLvDgg0Cnzqj/6BM=;
  b=HkNvNb82/Ue86lo8DpYPO9U9JzmrWdlmXu/zcJlokhY/KssRbPeMdjfc
   EfXeUUwlbd6QgU3WU89fLEBcIb3xMZz4/JpnCV2svojv5WaiQE1DcqKs5
   OTUdbD2nYcbHgizXHCdscWNI4osfIXlLVYzDvf2iP78MJqjB/QsmNQ63b
   Pklp5MvzEkxrVYUbtc9kxta7dN7hg1RJGdjwSunvCtKNsK7epythGwoyA
   rBbD66IK2SjBrGgVYTVlPbeyaxbr9Y4a1++mmWr9tcQ2wNKoBgupbdaiG
   uNePGGQABK8KlsiVY6O8s9h8su25kQ2Fpy8qZwy1OE7Qm/P6q4NzEewpx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309625002"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="309625002"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 17:09:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776267162"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776267162"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 17:09:19 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPvR8-0004jS-2X;
        Thu, 09 Feb 2023 01:09:18 +0000
Date:   Thu, 9 Feb 2023 09:09:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:3126:34:
 warning: unused variable 'samsung_jpeg_match'
Message-ID: <202302090840.vIjaH7GJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: f4104b7851a8d8b9a70899dcbecdb393eb16cd8a media: platform: rename s5p-jpeg/ to samsung/s5p-jpeg/
date:   11 months ago
config: s390-randconfig-r014-20230209 (https://download.01.org/0day-ci/archive/20230209/202302090840.vIjaH7GJ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4104b7851a8d8b9a70899dcbecdb393eb16cd8a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f4104b7851a8d8b9a70899dcbecdb393eb16cd8a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/platform/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302090840.vIjaH7GJ-lkp@intel.com

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:15:
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
   In file included from drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:15:
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
   In file included from drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:15:
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
>> drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:3126:34: warning: unused variable 'samsung_jpeg_match' [-Wunused-const-variable]
   static const struct of_device_id samsung_jpeg_match[] = {
                                    ^
   13 warnings generated.


vim +/samsung_jpeg_match +3126 drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c

6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3125  
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18 @3126  static const struct of_device_id samsung_jpeg_match[] = {
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3127  	{
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3128  		.compatible = "samsung,s5pv210-jpeg",
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3129  		.data = &s5p_jpeg_drvdata,
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3130  	}, {
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3131  		.compatible = "samsung,exynos3250-jpeg",
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3132  		.data = &exynos3250_jpeg_drvdata,
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3133  	}, {
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3134  		.compatible = "samsung,exynos4210-jpeg",
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3135  		.data = &exynos4_jpeg_drvdata,
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3136  	}, {
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3137  		.compatible = "samsung,exynos4212-jpeg",
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3138  		.data = &exynos4_jpeg_drvdata,
7c15fd4bf3d367 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-03-09  3139  	}, {
7c15fd4bf3d367 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-03-09  3140  		.compatible = "samsung,exynos5420-jpeg",
7c15fd4bf3d367 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-03-09  3141  		.data = &exynos5420_jpeg_drvdata,
6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3142  	}, {
6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3143  		.compatible = "samsung,exynos5433-jpeg",
6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3144  		.data = &exynos5433_jpeg_drvdata,
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3145  	},
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3146  	{},
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3147  };
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3148  

:::::: The code at line 3126 was first introduced by commit
:::::: 80529ae5c13725e12ba0377e29b2160794ba6b25 [media] s5p-jpeg:  JPEG codec

:::::: TO: Jacek Anaszewski <j.anaszewski@samsung.com>
:::::: CC: Mauro Carvalho Chehab <m.chehab@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
