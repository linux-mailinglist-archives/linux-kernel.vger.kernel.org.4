Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB16BF7D5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 05:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCREzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 00:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjCREzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 00:55:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAE35A6E0;
        Fri, 17 Mar 2023 21:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679115335; x=1710651335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZoOoKSNk9CA4TE6nM8tAJ9g+6sxpEX6EcZivLYL6CX0=;
  b=n2KJGfILdZO7L1ylb9lhKT/pRP75KmTjz5zdD9VdPgjCUq7WjhraYa+S
   uSapD7rCZn3fPCWdQPPuyxDJn9sBPQMZTaQGrsQzoxk3cwnYPUX+7DE26
   W2/YEL8IWZu74wZS1R2EfOUPHRALS+HpoeOCsJXes7sS++SbP35AYTL4w
   skY86zNbMB+4CnNO6NTUSp3lOC0C78WhZpGiuD4p0RxJbicDaNSl+RE2p
   0ACphd/Zk0V+5S8DadOYVZADAsm3ctzbFoNjCYAQ04xRKI9v9vo+6bgCu
   Zyx87mEilynnpfWIIdPQu6NV4P4LqNy+DJHcRDNq486AzdpVVN1uGKky0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="335903279"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="335903279"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 21:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="854696000"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="854696000"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2023 21:55:32 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdObL-0009oY-2P;
        Sat, 18 Mar 2023 04:55:31 +0000
Date:   Sat, 18 Mar 2023 12:54:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bogdan Ionescu <bogdan.ionescu.work@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-leds@vger.kernel.or, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
Subject: Re: [PATCH 2/2] leds: Add support for rohm,bd65b60 led driver
Message-ID: <202303181228.ZP7Ig92k-lkp@intel.com>
References: <20230308201451.11629-2-bogdan.ionescu.work@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308201451.11629-2-bogdan.ionescu.work@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bogdan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on lee-leds/for-leds-next]
[also build test WARNING on robh/for-next pavel-leds/for-next linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bogdan-Ionescu/leds-Add-support-for-rohm-bd65b60-led-driver/20230309-041730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20230308201451.11629-2-bogdan.ionescu.work%40gmail.com
patch subject: [PATCH 2/2] leds: Add support for rohm,bd65b60 led driver
config: s390-randconfig-r003-20230318 (https://download.01.org/0day-ci/archive/20230318/202303181228.ZP7Ig92k-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/72417c0228f115628b1ad307be9d8e53532de6a6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bogdan-Ionescu/leds-Add-support-for-rohm-bd65b60-led-driver/20230309-041730
        git checkout 72417c0228f115628b1ad307be9d8e53532de6a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/leds/ drivers/net/usb/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303181228.ZP7Ig92k-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/leds/leds-bd65b60.c:14:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/leds/leds-bd65b60.c:14:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/leds/leds-bd65b60.c:14:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   drivers/leds/leds-bd65b60.c:111:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (led->state != BD65B60_KEEP) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/leds/leds-bd65b60.c:116:2: note: uninitialized use occurs here
           ret |= regmap_update_bits(led->regmap, REG_COMSET1, OVP_MASK, led->ovp);
           ^~~
   drivers/leds/leds-bd65b60.c:111:2: note: remove the 'if' if its condition is always true
           if (led->state != BD65B60_KEEP) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/leds/leds-bd65b60.c:107:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
>> drivers/leds/leds-bd65b60.c:266:34: warning: unused variable 'of_bd65b60_leds_match' [-Wunused-const-variable]
   static const struct of_device_id of_bd65b60_leds_match[] = {
                                    ^
   14 warnings generated.


vim +/of_bd65b60_leds_match +266 drivers/leds/leds-bd65b60.c

   265	
 > 266	static const struct of_device_id of_bd65b60_leds_match[] = {
   267		{ .compatible = "rohm,bd65b60" },
   268		{},
   269	};
   270	MODULE_DEVICE_TABLE(of, of_bd65b60_leds_match);
   271	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
