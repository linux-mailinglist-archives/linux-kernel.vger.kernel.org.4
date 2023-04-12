Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51C6DE8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDLBLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLBLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:11:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B501C40EE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681261900; x=1712797900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ygX0J2yls6M2rJhV8GWWjRszSuOk6QXDwu4jmtDY+TE=;
  b=E6axfhwnSs2PO7EpBvPM7X796mA1J/096UCJykQf2XflTni6IgqAxxOA
   pqM+lGaM8YE9Klk0kKau0RtP3dS3HmNLmJ+0V1HPth95jjGksn1Gj9Vdu
   MyfWxD6LYQ5l8fymSMrh7WU0ugqayU/qax06Ww5vw6gma5SAl4Tz1LS2h
   vDqaDqugx8ho1XT+a5qQmR8+0kzvbAc4aF+ztqn4JJYZHEH0kByJNcIaf
   aajFEBq8Z9srs1BCe5mpIMp1K56qvybheYCxUMQ/W/4gNtDgzN8mGiKSV
   5UkFfGFIByNt7NXix3AtEb0YlD3Wr/6yFcyA0J9cRLBgjj8cDJSBptQP4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="430059118"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="430059118"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="753334468"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="753334468"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2023 18:11:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmP1L-000Wtq-2r;
        Wed, 12 Apr 2023 01:11:35 +0000
Date:   Wed, 12 Apr 2023 09:11:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gaurav.jain@nxp.com,
        sahil.malhotra@nxp.com, aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     oe-kbuild-all@lists.linux.dev, Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: Re: [NXP ELE-MUAP 6/7] firmware: imx: add ELE MU driver support
Message-ID: <202304120902.bP52A56z-lkp@intel.com>
References: <20230411162536.30604-7-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411162536.30604-7-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pankaj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on robh/for-next arm/for-next arm/fixes arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next soc/for-next linus/master v6.3-rc6 next-20230411]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Gupta/doc-device-tree-binding-addition-for-ele-MU/20230411-231913
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20230411162536.30604-7-pankaj.gupta%40nxp.com
patch subject: [NXP ELE-MUAP 6/7] firmware: imx: add ELE MU driver support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230412/202304120902.bP52A56z-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/80f6b85e97e7f7eb4b5d59c638adb2bdbe6d48d1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pankaj-Gupta/doc-device-tree-binding-addition-for-ele-MU/20230411-231913
        git checkout 80f6b85e97e7f7eb4b5d59c638adb2bdbe6d48d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/firmware/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120902.bP52A56z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:564,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/firmware/imx/ele_mu.c:6:
   drivers/firmware/imx/ele_mu.c: In function 'ele_mu_fops_write':
>> drivers/firmware/imx/ele_mu.h:17:47: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      17 |                 dev_dbg((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                                               ^~~~~~
   include/linux/dynamic_debug.h:223:29: note: in definition of macro '__dynamic_func_call_cls'
     223 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
     249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:272:9: note: in expansion of macro '_dynamic_func_call'
     272 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/firmware/imx/ele_mu.h:17:17: note: in expansion of macro 'dev_dbg'
      17 |                 dev_dbg((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                 ^~~~~~~
   drivers/firmware/imx/ele_mu.h:36:9: note: in expansion of macro 'miscdev_dbg'
      36 |         miscdev_dbg(&((p_devctx)->miscdev), fmt, ##va_args)
         |         ^~~~~~~~~~~
   drivers/firmware/imx/ele_mu.c:303:9: note: in expansion of macro 'devctx_dbg'
     303 |         devctx_dbg(dev_ctx, "write from buf (%p)%ld, ppos=%lld\n", buf, size,
         |         ^~~~~~~~~~
   drivers/firmware/imx/ele_mu.h:31:47: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      31 |                 dev_err((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                                               ^~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/firmware/imx/ele_mu.h:31:17: note: in expansion of macro 'dev_err'
      31 |                 dev_err((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                 ^~~~~~~
   drivers/firmware/imx/ele_mu.h:40:9: note: in expansion of macro 'miscdev_err'
      40 |         miscdev_err((&(p_devctx)->miscdev), fmt, ##va_args)
         |         ^~~~~~~~~~~
   drivers/firmware/imx/ele_mu.c:315:17: note: in expansion of macro 'devctx_err'
     315 |                 devctx_err(dev_ctx, "User buffer too small(%ld < %x)\n",
         |                 ^~~~~~~~~~
   drivers/firmware/imx/ele_mu.h:31:47: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      31 |                 dev_err((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                                               ^~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/firmware/imx/ele_mu.h:31:17: note: in expansion of macro 'dev_err'
      31 |                 dev_err((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                 ^~~~~~~
   drivers/firmware/imx/ele_mu.h:40:9: note: in expansion of macro 'miscdev_err'
      40 |         miscdev_err((&(p_devctx)->miscdev), fmt, ##va_args)
         |         ^~~~~~~~~~~
   drivers/firmware/imx/ele_mu.c:322:17: note: in expansion of macro 'devctx_err'
     322 |                 devctx_err(dev_ctx, "User buffer too big(%ld > %lu)\n", size,
         |                 ^~~~~~~~~~
>> drivers/firmware/imx/ele_mu.h:31:47: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]
      31 |                 dev_err((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                                               ^~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/firmware/imx/ele_mu.h:31:17: note: in expansion of macro 'dev_err'
      31 |                 dev_err((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                 ^~~~~~~
   drivers/firmware/imx/ele_mu.h:40:9: note: in expansion of macro 'miscdev_err'
      40 |         miscdev_err((&(p_devctx)->miscdev), fmt, ##va_args)
         |         ^~~~~~~~~~~
   drivers/firmware/imx/ele_mu.c:322:17: note: in expansion of macro 'devctx_err'
     322 |                 devctx_err(dev_ctx, "User buffer too big(%ld > %lu)\n", size,
         |                 ^~~~~~~~~~
   drivers/firmware/imx/ele_mu.c: In function 'ele_mu_fops_read':
>> drivers/firmware/imx/ele_mu.h:17:47: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      17 |                 dev_dbg((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                                               ^~~~~~
   include/linux/dynamic_debug.h:223:29: note: in definition of macro '__dynamic_func_call_cls'
     223 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
     249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:272:9: note: in expansion of macro '_dynamic_func_call'
     272 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/firmware/imx/ele_mu.h:17:17: note: in expansion of macro 'dev_dbg'
      17 |                 dev_dbg((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                 ^~~~~~~
   drivers/firmware/imx/ele_mu.h:36:9: note: in expansion of macro 'miscdev_dbg'
      36 |         miscdev_dbg(&((p_devctx)->miscdev), fmt, ##va_args)
         |         ^~~~~~~~~~~
   drivers/firmware/imx/ele_mu.c:410:9: note: in expansion of macro 'devctx_dbg'
     410 |         devctx_dbg(dev_ctx, "read to buf %p(%ld), ppos=%lld\n", buf, size,
         |         ^~~~~~~~~~
   drivers/firmware/imx/ele_mu.h:17:47: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      17 |                 dev_dbg((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                                               ^~~~~~
   include/linux/dynamic_debug.h:223:29: note: in definition of macro '__dynamic_func_call_cls'
     223 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
     249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:272:9: note: in expansion of macro '_dynamic_func_call'
     272 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/firmware/imx/ele_mu.h:17:17: note: in expansion of macro 'dev_dbg'
      17 |                 dev_dbg((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
         |                 ^~~~~~~
   drivers/firmware/imx/ele_mu.h:36:9: note: in expansion of macro 'miscdev_dbg'
      36 |         miscdev_dbg(&((p_devctx)->miscdev), fmt, ##va_args)
         |         ^~~~~~~~~~~
   drivers/firmware/imx/ele_mu.c:437:17: note: in expansion of macro 'devctx_dbg'
     437 |                 devctx_dbg(dev_ctx, "User buffer too small (%ld < %d)\n",
         |                 ^~~~~~~~~~
   drivers/firmware/imx/ele_mu.c:408:23: warning: variable 'header' set but not used [-Wunused-but-set-variable]
     408 |         struct mu_hdr header;
         |                       ^~~~~~
   drivers/firmware/imx/ele_mu.c:404:29: warning: unused variable 'ele_mu_priv' [-Wunused-variable]
     404 |         struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
         |                             ^~~~~~~~~~~


vim +17 drivers/firmware/imx/ele_mu.h

    12	
    13	/* macro to log operation of a misc device */
    14	#define miscdev_dbg(p_miscdev, fmt, va_args...)                                \
    15		({                                                                     \
    16			struct miscdevice *_p_miscdev = p_miscdev;                     \
  > 17			dev_dbg((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
    18			##va_args);                                                    \
    19		})
    20	
    21	#define miscdev_info(p_miscdev, fmt, va_args...)                               \
    22		({                                                                     \
    23			struct miscdevice *_p_miscdev = p_miscdev;                     \
    24			dev_info((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name, \
    25			##va_args);                                                    \
    26		})
    27	
    28	#define miscdev_err(p_miscdev, fmt, va_args...)                                \
    29		({                                                                     \
    30			struct miscdevice *_p_miscdev = p_miscdev;                     \
  > 31			dev_err((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
    32			##va_args);                                                    \
    33		})
    34	/* macro to log operation of a device context */
    35	#define devctx_dbg(p_devctx, fmt, va_args...) \
    36		miscdev_dbg(&((p_devctx)->miscdev), fmt, ##va_args)
    37	#define devctx_info(p_devctx, fmt, va_args...) \
    38		miscdev_info(&((p_devctx)->miscdev), fmt, ##va_args)
    39	#define devctx_err(p_devctx, fmt, va_args...) \
    40		miscdev_err((&(p_devctx)->miscdev), fmt, ##va_args)
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
