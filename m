Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F2F68FE49
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBIEPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBIEPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:15:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDB41A97E;
        Wed,  8 Feb 2023 20:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916090; x=1707452090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1qxftDUuR4Z4M+K0ibVCn0KYirP/c/PVNRzQtTRRLqM=;
  b=J/ivOfJGWziJR6i2YZOvZsso7wrFge6Elw5eOAxmbgQZMMnrqkUp9Xxb
   Zu6wa8MupaKF592HkpXHFnLPVKC8DmYlAXcr4gqzZR9M4Hh3F1ckBn7xI
   VewK2tB2zEDfzsB4+kM/O0+QjAjrFs06QfTEW1QYUqsSWrQ1Q158aspv3
   0WM3GB7qNOc1BxFVZc3anUlJzOWli0l9xM1TKhyYs0d0ommpQzB3qkkNF
   0Bq17o45ZYosJ3tlIe75+UsvAxYddlM33rTXUdBvZaewPyApDWhqlMv8s
   sl3DFd56mz50Dg330ThuQ7ldRuzeii6KM179sIt1dwU8f4pBGlKtDhhFd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394599997"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394599997"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:13:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="791449413"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="791449413"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Feb 2023 20:13:23 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPyJG-0004og-26;
        Thu, 09 Feb 2023 04:13:22 +0000
Date:   Thu, 9 Feb 2023 12:13:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/verisilicon/hantro_drv.c:618:34: warning:
 unused variable 'of_hantro_match'
Message-ID: <202302091243.rvRjqigX-lkp@intel.com>
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

Hi Ezequiel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: fbb6c848dd89786fe24856ee6b5e773910ded29c media: destage Hantro VPU driver
date:   5 months ago
config: s390-randconfig-r014-20230209 (https://download.01.org/0day-ci/archive/20230209/202302091243.rvRjqigX-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fbb6c848dd89786fe24856ee6b5e773910ded29c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fbb6c848dd89786fe24856ee6b5e773910ded29c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/platform/verisilicon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302091243.rvRjqigX-lkp@intel.com

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/verisilicon/hantro_drv.c:23:
   In file included from include/media/v4l2-mem2mem.h:16:
   In file included from include/media/videobuf2-v4l2.h:16:
   In file included from include/media/videobuf2-core.h:18:
   In file included from include/linux/dma-buf.h:16:
   In file included from include/linux/iosys-map.h:10:
   In file included from include/linux/io.h:13:
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
   In file included from drivers/media/platform/verisilicon/hantro_drv.c:23:
   In file included from include/media/v4l2-mem2mem.h:16:
   In file included from include/media/videobuf2-v4l2.h:16:
   In file included from include/media/videobuf2-core.h:18:
   In file included from include/linux/dma-buf.h:16:
   In file included from include/linux/iosys-map.h:10:
   In file included from include/linux/io.h:13:
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
   In file included from drivers/media/platform/verisilicon/hantro_drv.c:23:
   In file included from include/media/v4l2-mem2mem.h:16:
   In file included from include/media/videobuf2-v4l2.h:16:
   In file included from include/media/videobuf2-core.h:18:
   In file included from include/linux/dma-buf.h:16:
   In file included from include/linux/iosys-map.h:10:
   In file included from include/linux/io.h:13:
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
>> drivers/media/platform/verisilicon/hantro_drv.c:618:34: warning: unused variable 'of_hantro_match' [-Wunused-const-variable]
   static const struct of_device_id of_hantro_match[] = {
                                    ^
   13 warnings generated.


vim +/of_hantro_match +618 drivers/media/platform/verisilicon/hantro_drv.c

775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia    2018-12-05  617  
a29add8c9bb29d drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2019-06-12 @618  static const struct of_device_id of_hantro_match[] = {
a29add8c9bb29d drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2019-06-12  619  #ifdef CONFIG_VIDEO_HANTRO_ROCKCHIP
fb7cb344b96938 drivers/staging/media/hantro/hantro_drv.c             Paul Kocialkowski  2021-07-19  620  	{ .compatible = "rockchip,px30-vpu",   .data = &px30_vpu_variant, },
4f34591568e7a1 drivers/staging/media/hantro/hantro_drv.c             Alex Bee           2021-06-14  621  	{ .compatible = "rockchip,rk3036-vpu", .data = &rk3036_vpu_variant, },
78bb1ae5472cab drivers/staging/media/hantro/hantro_drv.c             Alex Bee           2021-06-14  622  	{ .compatible = "rockchip,rk3066-vpu", .data = &rk3066_vpu_variant, },
775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia    2018-12-05  623  	{ .compatible = "rockchip,rk3288-vpu", .data = &rk3288_vpu_variant, },
4b898fedeb26c4 drivers/staging/media/hantro/hantro_drv.c             Alex Bee           2021-06-14  624  	{ .compatible = "rockchip,rk3328-vpu", .data = &rk3328_vpu_variant, },
4b898fedeb26c4 drivers/staging/media/hantro/hantro_drv.c             Alex Bee           2021-06-14  625  	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
6f1ae821a6c4aa drivers/staging/media/hantro/hantro_drv.c             Nicolas Frattaroli 2022-06-12  626  	{ .compatible = "rockchip,rk3568-vepu", .data = &rk3568_vepu_variant, },
5f6bfab6da6531 drivers/staging/media/hantro/hantro_drv.c             Piotr Oniszczuk    2022-02-14  627  	{ .compatible = "rockchip,rk3568-vpu", .data = &rk3568_vpu_variant, },
8e4aaa68786319 drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2020-03-20  628  #endif
8e4aaa68786319 drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2020-03-20  629  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
cf1abc501a5c76 drivers/staging/media/hantro/hantro_drv.c             Adam Ford          2022-01-25  630  	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
8e4aaa68786319 drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2020-03-20  631  	{ .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
6971efb70ac3e4 drivers/staging/media/hantro/hantro_drv.c             Adam Ford          2022-01-25  632  	{ .compatible = "nxp,imx8mq-vpu-g1", .data = &imx8mq_vpu_g1_variant },
45040f67504195 drivers/staging/media/hantro/hantro_drv.c             Benjamin Gaignard  2021-06-03  633  	{ .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
82ad940c009499 drivers/staging/media/hantro/hantro_drv.c             Emil Velikov       2021-04-01  634  #endif
82ad940c009499 drivers/staging/media/hantro/hantro_drv.c             Emil Velikov       2021-04-01  635  #ifdef CONFIG_VIDEO_HANTRO_SAMA5D4
82ad940c009499 drivers/staging/media/hantro/hantro_drv.c             Emil Velikov       2021-04-01  636  	{ .compatible = "microchip,sama5d4-vdec", .data = &sama5d4_vdec_variant, },
86790a4fdf4b3d drivers/staging/media/hantro/hantro_drv.c             Jernej Skrabec     2021-11-29  637  #endif
86790a4fdf4b3d drivers/staging/media/hantro/hantro_drv.c             Jernej Skrabec     2021-11-29  638  #ifdef CONFIG_VIDEO_HANTRO_SUNXI
86790a4fdf4b3d drivers/staging/media/hantro/hantro_drv.c             Jernej Skrabec     2021-11-29  639  	{ .compatible = "allwinner,sun50i-h6-vpu-g2", .data = &sunxi_vpu_variant, },
a29add8c9bb29d drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2019-06-12  640  #endif
775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia    2018-12-05  641  	{ /* sentinel */ }
775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia    2018-12-05  642  };
a29add8c9bb29d drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2019-06-12  643  MODULE_DEVICE_TABLE(of, of_hantro_match);
775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia    2018-12-05  644  

:::::: The code at line 618 was first introduced by commit
:::::: a29add8c9bb29dfa8dc47c71b2702e9cc4f332a6 media: rockchip/vpu: rename from rockchip to hantro

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
