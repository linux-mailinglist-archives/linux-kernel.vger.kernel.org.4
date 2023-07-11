Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD4774F990
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGKVHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjGKVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:07:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED69133
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689109652; x=1720645652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NS6ylPPDPqDG4pzjShZQj5Tc6X4ToP+oaHO0kIRiOc8=;
  b=XMsGVeAiHthtSrCTBOeB4iBT3Pxj2+jUJ+SKu5BTZPQUi+dC/HeEF7jB
   qdaK0YF/TAcOt0I8Ga0jzkU8kOcMZ/ZNWjJOfcgywWvv+meUH1Pm499PR
   QlERcepJ8XfBoYTF6WUOabOqbYb9oaSNt+ADVwJ1+ZsfCi2G7kvjP3y/3
   GS3ARvwbWHUvf8oqnHfVODjch1u4S7uQqLmRGzjTwtItrBTCuRQx7X0b/
   NX9ofIdGvKb18yO6rLN7YR1DsYoFY7/muYtqbEYwFeoC8s8E6t+YMgPra
   aIVjEUQOb+hiLGEFNaR4/3Qnj0QiJNzTv484IGMvFz6RcdOWO61OfvCMs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363600783"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="363600783"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 14:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="671580420"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="671580420"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2023 14:06:21 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJKYu-00057h-23;
        Tue, 11 Jul 2023 21:06:20 +0000
Date:   Wed, 12 Jul 2023 05:05:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: drivers/input/touchscreen/edt-ft5x06.c:156:35: error: variable has
 incomplete type 'const struct regmap_config'
Message-ID: <202307120543.B9WVQ1NL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
commit: 70a640c0efa7667453c3911b13335304ce46ad8b regmap: REGMAP_KUNIT should not select REGMAP
date:   9 weeks ago
config: s390-randconfig-r034-20230711 (https://download.01.org/0day-ci/archive/20230712/202307120543.B9WVQ1NL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230712/202307120543.B9WVQ1NL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307120543.B9WVQ1NL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/input/touchscreen/edt-ft5x06.c:25:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/input/touchscreen/edt-ft5x06.c:25:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/input/touchscreen/edt-ft5x06.c:25:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/input/touchscreen/edt-ft5x06.c:156:35: error: variable has incomplete type 'const struct regmap_config'
     156 | static const struct regmap_config edt_ft5x06_i2c_regmap_config = {
         |                                   ^
   drivers/input/touchscreen/edt-ft5x06.c:156:21: note: forward declaration of 'struct regmap_config'
     156 | static const struct regmap_config edt_ft5x06_i2c_regmap_config = {
         |                     ^
   drivers/input/touchscreen/edt-ft5x06.c:292:35: error: variable has incomplete type 'const struct regmap_config'
     292 | static const struct regmap_config edt_M06_i2c_regmap_config = {
         |                                   ^
   drivers/input/touchscreen/edt-ft5x06.c:156:21: note: forward declaration of 'struct regmap_config'
     156 | static const struct regmap_config edt_ft5x06_i2c_regmap_config = {
         |                     ^
>> drivers/input/touchscreen/edt-ft5x06.c:896:3: error: call to undeclared function 'regmap_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     896 |                 regmap_exit(tsdata->regmap);
         |                 ^
   drivers/input/touchscreen/edt-ft5x06.c:896:3: note: did you mean 'regmap_write'?
   include/linux/regmap.h:1716:19: note: 'regmap_write' declared here
    1716 | static inline int regmap_write(struct regmap *map, unsigned int reg,
         |                   ^
>> drivers/input/touchscreen/edt-ft5x06.c:897:20: error: call to undeclared function 'regmap_init_i2c'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     897 |                 tsdata->regmap = regmap_init_i2c(client,
         |                                  ^
   drivers/input/touchscreen/edt-ft5x06.c:1154:19: error: call to undeclared function 'regmap_init_i2c'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1154 |         tsdata->regmap = regmap_init_i2c(client, &edt_ft5x06_i2c_regmap_config);
         |                          ^
   drivers/input/touchscreen/edt-ft5x06.c:1360:2: error: call to undeclared function 'regmap_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1360 |         regmap_exit(tsdata->regmap);
         |         ^
   12 warnings and 6 errors generated.


vim +156 drivers/input/touchscreen/edt-ft5x06.c

b1d2a3ecb9cbf9 Franklin S Cooper Jr 2015-10-16  155  
9dfd9708ffba1e Dario Binacchi       2023-04-02 @156  static const struct regmap_config edt_ft5x06_i2c_regmap_config = {
9dfd9708ffba1e Dario Binacchi       2023-04-02  157  	.reg_bits = 8,
9dfd9708ffba1e Dario Binacchi       2023-04-02  158  	.val_bits = 8,
9dfd9708ffba1e Dario Binacchi       2023-04-02  159  };
43c4d13e901a8f Simon Budig          2012-07-24  160  

:::::: The code at line 156 was first introduced by commit
:::::: 9dfd9708ffba1e7969af5e4ecda660151146de98 Input: edt-ft5x06 - convert to use regmap API

:::::: TO: Dario Binacchi <dario.binacchi@amarulasolutions.com>
:::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
