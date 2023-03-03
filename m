Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6C66A9E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjCCSE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCCSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:04:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CD29E1D;
        Fri,  3 Mar 2023 10:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677866655; x=1709402655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=31fthH7gaoN87g1RZvRQ3R3Y0eJR3PQNczHJsxv31eI=;
  b=Hd1IryWZbcy/wfS4EcArfDmHWlh8cZyuUgRjOlCIsFAaKnRNoCRenVgk
   P2lbwQ9ooJaNcKK4Pl7XDR0fjRbIAkUshPK6k9fBzPH8nwHzg2wDNHTdv
   oXyXknibzw22KUKJ91zW6zWI704zHHIVWB6wKkY2f3V9UguGTyrCIyWjs
   rhjOQtmiJzGVvVqmbO1pTvTUKqgZYxXGXtPeqZqHxCV7tMFtH/0xDicpB
   NC4wzhskf4REdNHag9n2heu+/8yFlXHllkp6KP6Ls5ZUROqeCsnhANg+4
   hRLkkR2zDTYi2MIVeIuS2Gjy22QKZdCbK+reOKww7x7gGP/+tSIHi4jbY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="421381396"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="421381396"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 10:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="707926473"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="707926473"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2023 10:03:22 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pY9kX-0001ak-1X;
        Fri, 03 Mar 2023 18:03:21 +0000
Date:   Sat, 4 Mar 2023 02:02:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Tomi Valkeinen <tomba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: Re: [PATCH v2 2/2] clk: keystone: Add support AM62 DSS clock divider
Message-ID: <202303040131.k7AUxAg5-lkp@intel.com>
References: <20230213115954.553-3-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213115954.553-3-a-bhatia1@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aradhya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.2 next-20230303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aradhya-Bhatia/dt-bindings-clock-Add-binding-documentation-for-TI-AM62-DSS-Clock/20230213-200203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230213115954.553-3-a-bhatia1%40ti.com
patch subject: [PATCH v2 2/2] clk: keystone: Add support AM62 DSS clock divider
config: arm-randconfig-r046-20230302 (https://download.01.org/0day-ci/archive/20230304/202303040131.k7AUxAg5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2ddb7301b11092b73d4a16af06362954f3d5f714
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aradhya-Bhatia/dt-bindings-clock-Add-binding-documentation-for-TI-AM62-DSS-Clock/20230213-200203
        git checkout 2ddb7301b11092b73d4a16af06362954f3d5f714
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/ mm// net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303040131.k7AUxAg5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/include/asm/div64.h:107,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/clk/keystone/clk-am62-dss.c:5:
   drivers/clk/keystone/clk-am62-dss.c: In function 'ti_am62_dss_clk_recalc_rate':
   include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   drivers/clk/keystone/clk-am62-dss.c:24:9: note: in expansion of macro 'do_div'
      24 |         do_div(rate, priv->div);
         |         ^~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12:
   include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   drivers/clk/keystone/clk-am62-dss.c:24:9: note: in expansion of macro 'do_div'
      24 |         do_div(rate, priv->div);
         |         ^~~~~~
   include/asm-generic/div64.h:238:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
         |                                    |
         |                                    long unsigned int *
   drivers/clk/keystone/clk-am62-dss.c:24:9: note: in expansion of macro 'do_div'
      24 |         do_div(rate, priv->div);
         |         ^~~~~~
   arch/arm/include/asm/div64.h:24:45: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'long unsigned int *'
      24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
         |                                   ~~~~~~~~~~^
   drivers/clk/keystone/clk-am62-dss.c: In function 'clk_hw_unregister_am62_dss_clk':
>> drivers/clk/keystone/clk-am62-dss.c:99:9: error: implicit declaration of function 'kfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
      99 |         kfree(priv);
         |         ^~~~~
         |         kvfree
   cc1: some warnings being treated as errors


vim +99 drivers/clk/keystone/clk-am62-dss.c

    91	
    92	static void clk_hw_unregister_am62_dss_clk(struct clk_hw *hw)
    93	{
    94		struct ti_am62_dss_clk *priv;
    95	
    96		priv = to_ti_am62_dss_clk(hw);
    97	
    98		clk_hw_unregister(hw);
  > 99		kfree(priv);
   100	}
   101	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
