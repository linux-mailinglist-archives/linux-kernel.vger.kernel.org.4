Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D716BE1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCQHAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQHAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:00:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F4D51FA6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679036402; x=1710572402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HmUuQQWsDjqrwKPydo5APzukhRwHmoaeu4nkVvVcBhE=;
  b=Si6PH+AQdJQZlc0HS2WxdIDrpd0QtB0ZtL5mH01QdCPKHPkndRi8t1s0
   hNa5otGwukB0sKTobaGRou5vkju3Y7po23Q86qysFp7mYF/uMoc1fnF0l
   /NF1BNZcB7G+CJoJB9qKIH9KkKx782YDIlFST3wSmjlZMFthkKDj9rtL/
   dvlUSZmhaaG2vU7swQni4A27/XKemuq4QxJZI1Lym5kRmVtfrR+UrPwLF
   RTrUmcNj48QBK55iKt8PDu5s7iokF8XjzbJiNh/8TTs7En0iplcPaV7ug
   k1FY77W+jL6olgeyZ4A1JpEefjhaFXEWr7LMaTCqujhwFmJmdBTXHe+c4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="318592998"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="318592998"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 00:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="657456549"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="657456549"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2023 00:00:00 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pd44F-0009AH-1l;
        Fri, 17 Mar 2023 06:59:59 +0000
Date:   Fri, 17 Mar 2023 14:59:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <202303171454.sScrVVOh-lkp@intel.com>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Khadija,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Khadija-Kamran/staging-axis-fifo-initialize-timeouts-in-probe-only/20230316-205814
patch link:    https://lore.kernel.org/r/ZBMR4s8xyHGqMm72%40khadija-virtual-machine
patch subject: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
config: hexagon-randconfig-r033-20230312 (https://download.01.org/0day-ci/archive/20230317/202303171454.sScrVVOh-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7e359baa2318b55e12a0c099b75fbd0d799907cf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Khadija-Kamran/staging-axis-fifo-initialize-timeouts-in-probe-only/20230316-205814
        git checkout 7e359baa2318b55e12a0c099b75fbd0d799907cf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/staging/axis-fifo/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303171454.sScrVVOh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/axis-fifo/axis-fifo.c:25:
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
   In file included from drivers/staging/axis-fifo/axis-fifo.c:25:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/staging/axis-fifo/axis-fifo.c:25:
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
>> drivers/staging/axis-fifo/axis-fifo.c:958:3: warning: format specifies type 'int' but the argument has type 'long' [-Wformat]
                   read_timeout, write_timeout);
                   ^~~~~~~~~~~~
   include/linux/printk.h:528:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                   ~~~     ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   drivers/staging/axis-fifo/axis-fifo.c:958:17: warning: format specifies type 'int' but the argument has type 'long' [-Wformat]
                   read_timeout, write_timeout);
                                 ^~~~~~~~~~~~~
   include/linux/printk.h:528:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                   ~~~     ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   8 warnings generated.


vim +958 drivers/staging/axis-fifo/axis-fifo.c

4a965c5f89decd Jacob Feder 2018-07-22  954  
4a965c5f89decd Jacob Feder 2018-07-22  955  static int __init axis_fifo_init(void)
4a965c5f89decd Jacob Feder 2018-07-22  956  {
4a965c5f89decd Jacob Feder 2018-07-22  957  	pr_info("axis-fifo driver loaded with parameters read_timeout = %i, write_timeout = %i\n",
4a965c5f89decd Jacob Feder 2018-07-22 @958  		read_timeout, write_timeout);
4a965c5f89decd Jacob Feder 2018-07-22  959  	return platform_driver_register(&axis_fifo_driver);
4a965c5f89decd Jacob Feder 2018-07-22  960  }
4a965c5f89decd Jacob Feder 2018-07-22  961  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
