Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15DE719FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjFAOUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjFAOUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:20:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE28D18F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629237; x=1717165237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V3aEMThk1aOvzxlN2qMLUYHQSrj7IvusSGmojZBE7Fk=;
  b=lVf0tOZNrkzc+9+KT8m+djXJiQL2WT4JmZGUkVunGmeqgqGGS+rfZcL7
   c4Qwg8pGjMN1DqT0DO4B9zvgABCgYyBwDxOqi3Lmt0mOt72ErXUHyM/xC
   KsgMbi+UbSzR/iq3SD015Y65XCtmkXvgQuEKldjwpasesBx+FbiXGU9NZ
   LG40ElprJLbG9qPhBUNVvcXxOHQ3frAfSYJDbCNv5cPW+FEDWOuHWIuCn
   7cE7Vx0RlM/qsqUlKTYJFPt7E8RF1ZAzm/20YQd0CJa1yw8/yjVJzcWix
   f5xyrkkqlVjjCaHi4dWpOZ0rfGgy5SqtQDFhtDMgj/GEsab8OU+fRGL3I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="357989671"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="357989671"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881625227"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881625227"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2023 07:18:15 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4j82-0002Lg-38;
        Thu, 01 Jun 2023 14:18:14 +0000
Date:   Thu, 1 Jun 2023 22:18:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 40/43] ARM: ep93xx: soc: drop defines
Message-ID: <202306011611.BkjkqkuR-lkp@intel.com>
References: <20230601054549.10843-22-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601054549.10843-22-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.4-rc4]
[cannot apply to soc/for-next robh/for-next next-20230601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikita-Shubin/dt-bindings-soc-Add-Cirrus-EP93xx/20230601-143415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230601054549.10843-22-nikita.shubin%40maquefel.me
patch subject: [PATCH v1 40/43] ARM: ep93xx: soc: drop defines
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230601/202306011611.BkjkqkuR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/372fa9eb75b475c6b8f26079e8716c95622ae9b7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nikita-Shubin/dt-bindings-soc-Add-Cirrus-EP93xx/20230601-143415
        git checkout 372fa9eb75b475c6b8f26079e8716c95622ae9b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/input/keyboard/ sound/soc/cirrus/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306011611.BkjkqkuR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/input/keyboard/ep93xx_keypad.c:30:
   include/linux/soc/cirrus/ep93xx.h: In function 'ep93xx_devcfg_set_clear':
   include/linux/soc/cirrus/ep93xx.h:22:16: error: 'return' with a value, in function returning void [-Werror=return-type]
      22 |         return 0;
         |                ^
   include/linux/soc/cirrus/ep93xx.h:19:20: note: declared here
      19 | static inline void ep93xx_devcfg_set_clear(unsigned int set_bits,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/soc/cirrus/ep93xx.h: At top level:
>> include/linux/soc/cirrus/ep93xx.h:24:6: warning: no previous prototype for 'ep93xx_syscon_swlocked_write' [-Wmissing-prototypes]
      24 | void ep93xx_syscon_swlocked_write(unsigned int val, unsigned int reg)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/soc/cirrus/ep93xx.h: In function 'ep93xx_syscon_swlocked_write':
   include/linux/soc/cirrus/ep93xx.h:26:16: error: 'return' with a value, in function returning void [-Werror=return-type]
      26 |         return 0;
         |                ^
   include/linux/soc/cirrus/ep93xx.h:24:6: note: declared here
      24 | void ep93xx_syscon_swlocked_write(unsigned int val, unsigned int reg)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/soc/cirrus/ep93xx.h: At top level:
>> include/linux/soc/cirrus/ep93xx.h:28:6: warning: no previous prototype for 'ep93xx_swlocked_update_bits' [-Wmissing-prototypes]
      28 | void ep93xx_swlocked_update_bits(unsigned int reg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/soc/cirrus/ep93xx.h: In function 'ep93xx_swlocked_update_bits':
   include/linux/soc/cirrus/ep93xx.h:31:16: error: 'return' with a value, in function returning void [-Werror=return-type]
      31 |         return 0;
         |                ^
   include/linux/soc/cirrus/ep93xx.h:28:6: note: declared here
      28 | void ep93xx_swlocked_update_bits(unsigned int reg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/ep93xx_keypad.c: In function 'ep93xx_keypad_probe':
   drivers/input/keyboard/ep93xx_keypad.c:262:9: error: implicit declaration of function 'of_property_read_u32' [-Werror=implicit-function-declaration]
     262 |         of_property_read_u32(np, "cirrus,debounce-delay-ms", &keypad->debounce);
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from sound/soc/cirrus/ep93xx-i2s.c:28:
   include/linux/soc/cirrus/ep93xx.h: In function 'ep93xx_devcfg_set_clear':
   include/linux/soc/cirrus/ep93xx.h:22:16: error: 'return' with a value, in function returning void [-Werror=return-type]
      22 |         return 0;
         |                ^
   include/linux/soc/cirrus/ep93xx.h:19:20: note: declared here
      19 | static inline void ep93xx_devcfg_set_clear(unsigned int set_bits,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/soc/cirrus/ep93xx.h: At top level:
>> include/linux/soc/cirrus/ep93xx.h:24:6: warning: no previous prototype for 'ep93xx_syscon_swlocked_write' [-Wmissing-prototypes]
      24 | void ep93xx_syscon_swlocked_write(unsigned int val, unsigned int reg)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/soc/cirrus/ep93xx.h: In function 'ep93xx_syscon_swlocked_write':
   include/linux/soc/cirrus/ep93xx.h:26:16: error: 'return' with a value, in function returning void [-Werror=return-type]
      26 |         return 0;
         |                ^
   include/linux/soc/cirrus/ep93xx.h:24:6: note: declared here
      24 | void ep93xx_syscon_swlocked_write(unsigned int val, unsigned int reg)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/soc/cirrus/ep93xx.h: At top level:
>> include/linux/soc/cirrus/ep93xx.h:28:6: warning: no previous prototype for 'ep93xx_swlocked_update_bits' [-Wmissing-prototypes]
      28 | void ep93xx_swlocked_update_bits(unsigned int reg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/soc/cirrus/ep93xx.h: In function 'ep93xx_swlocked_update_bits':
   include/linux/soc/cirrus/ep93xx.h:31:16: error: 'return' with a value, in function returning void [-Werror=return-type]
      31 |         return 0;
         |                ^
   include/linux/soc/cirrus/ep93xx.h:28:6: note: declared here
      28 | void ep93xx_swlocked_update_bits(unsigned int reg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ep93xx_syscon_swlocked_write +24 include/linux/soc/cirrus/ep93xx.h

    10	
    11	#if defined(CONFIG_ARCH_EP93XX)
    12	unsigned int ep93xx_chip_revision(void);
    13	void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits);
    14	void ep93xx_syscon_swlocked_write(unsigned int val, unsigned int reg);
    15	void ep93xx_swlocked_update_bits(unsigned int reg,
    16					 unsigned int mask, unsigned int val);
    17	#else
    18	static inline unsigned int ep93xx_chip_revision(void) { return 0; }
    19	static inline void ep93xx_devcfg_set_clear(unsigned int set_bits,
    20					unsigned int clear_bits)
    21	{
  > 22		return 0;
    23	}
  > 24	void ep93xx_syscon_swlocked_write(unsigned int val, unsigned int reg)
    25	{
  > 26		return 0;
    27	}
  > 28	void ep93xx_swlocked_update_bits(unsigned int reg,
    29					unsigned int mask, unsigned int val)
    30	{
    31		return 0;
    32	}
    33	#endif
    34	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
