Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A766F255C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjD2QkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 12:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjD2QkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 12:40:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58052E75
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682786410; x=1714322410;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xmzzKOvu+aP2cy3ZFi6Mqj8gl7Dl2IXdInHmOoKIdCo=;
  b=fH6QXHpRnwXtrLjHbkeVlkwMjLBscTJa05JfuTSyIwoslZpjM1Zwm0Np
   MG4TauFb1WTk6FPksSXx+ShUwRMTTu0ghwf38DqAAmVVqNciy5t2dm/V+
   RLPF72jiLawAn6dh99vV/sjXe5FCnBcz3IJdY1qZs8DYRJXuqh9xBimuJ
   m16Kv6v5vkRuAaeyhahPgAP4aXXfj5ySTR9xe6wLgD5dS3yWHwZnIr2tg
   yWBVbnk0aablSYlllCuW5c0Y0kdUt26DWkLx1EJUnhql/nx5Y1rjOdukh
   FCzpT1FYW6kjVEDDpEQADdAuCBIiP9ZqD381A7CHs3VAGvwqm85b78C1G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="337051849"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="337051849"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 09:40:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="869622961"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="869622961"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2023 09:40:07 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psncF-0001Fp-0P;
        Sat, 29 Apr 2023 16:40:07 +0000
Date:   Sun, 30 Apr 2023 00:40:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: drivers/bluetooth/btnxpuart.c:1277:34: warning: unused variable
 'nxpuart_of_match_table'
Message-ID: <202304300014.vFGw6Dr0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89d77f71f493a3663b10fa812d17f472935d24be
commit: 689ca16e523278470c38832a3010645a78c544d8 Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets
date:   6 days ago
config: hexagon-randconfig-r045-20230428 (https://download.01.org/0day-ci/archive/20230430/202304300014.vFGw6Dr0-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=689ca16e523278470c38832a3010645a78c544d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 689ca16e523278470c38832a3010645a78c544d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304300014.vFGw6Dr0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/bluetooth/btnxpuart.c:10:
   In file included from include/linux/serdev.h:10:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
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
   In file included from drivers/bluetooth/btnxpuart.c:10:
   In file included from include/linux/serdev.h:10:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/bluetooth/btnxpuart.c:10:
   In file included from include/linux/serdev.h:10:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
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
>> drivers/bluetooth/btnxpuart.c:1277:34: warning: unused variable 'nxpuart_of_match_table' [-Wunused-const-variable]
   static const struct of_device_id nxpuart_of_match_table[] = {
                                    ^
   7 warnings generated.


vim +/nxpuart_of_match_table +1277 drivers/bluetooth/btnxpuart.c

  1276	
> 1277	static const struct of_device_id nxpuart_of_match_table[] = {
  1278		{ .compatible = "nxp,88w8987-bt", .data = &w8987_data },
  1279		{ .compatible = "nxp,88w8997-bt", .data = &w8997_data },
  1280		{ }
  1281	};
  1282	MODULE_DEVICE_TABLE(of, nxpuart_of_match_table);
  1283	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
