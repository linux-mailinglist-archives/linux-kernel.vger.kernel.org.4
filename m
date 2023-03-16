Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6111A6BD1C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCPOJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCPOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:08:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3624EDB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678975734; x=1710511734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=st3XNtfhg5o86Dx/8Z5ncGm7eToP7n/Ee0w0PIniNPA=;
  b=jdCAoAkdeOyX+jqUnffelLTZJfWgTHfg4w6FmlIjL8dHkd0jsA365B60
   ci3vr5sd5UkCZOUgCt7KTo3YMgqyXMJcLI13Z6KBeL02U7Lam2RUULFAP
   1P6MQldA7T7fzaO++DLebutI9gX4SHmZ5GAV6zbbtKDN9XcW39J27Sx3/
   7ijJxl4r+C4n6r04LP+Hhf2ulRB+k/dZYf4HQXPCvZHd8x849Ypu4t3/p
   IZ/PLcpbPipiizglGXkV7XdKCrkcv63C9EsjZ2D7oisQYZpkeR37AbTj6
   egg8LlKLPwyyWnd+/Wpl55IGNkY8SWiIqvJ4Ll8zU5NJnZ3Af0Jma/D8s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="318388078"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="318388078"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 07:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="768964342"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="768964342"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2023 07:08:32 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcoHP-0008Yg-0d;
        Thu, 16 Mar 2023 14:08:31 +0000
Date:   Thu, 16 Mar 2023 22:07:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <202303162137.a6Y0CjU8-lkp@intel.com>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230316/202303162137.a6Y0CjU8-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7e359baa2318b55e12a0c099b75fbd0d799907cf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Khadija-Kamran/staging-axis-fifo-initialize-timeouts-in-probe-only/20230316-205814
        git checkout 7e359baa2318b55e12a0c099b75fbd0d799907cf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303162137.a6Y0CjU8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from drivers/staging/axis-fifo/axis-fifo.c:17:
   drivers/staging/axis-fifo/axis-fifo.c: In function 'axis_fifo_init':
>> include/linux/kern_levels.h:5:25: warning: format '%i' expects argument of type 'int', but argument 2 has type 'long int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:427:25: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:528:9: note: in expansion of macro 'printk'
     528 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:528:16: note: in expansion of macro 'KERN_INFO'
     528 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   drivers/staging/axis-fifo/axis-fifo.c:957:9: note: in expansion of macro 'pr_info'
     957 |         pr_info("axis-fifo driver loaded with parameters read_timeout = %i, write_timeout = %i\n",
         |         ^~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%i' expects argument of type 'int', but argument 3 has type 'long int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:427:25: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:528:9: note: in expansion of macro 'printk'
     528 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:528:16: note: in expansion of macro 'KERN_INFO'
     528 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   drivers/staging/axis-fifo/axis-fifo.c:957:9: note: in expansion of macro 'pr_info'
     957 |         pr_info("axis-fifo driver loaded with parameters read_timeout = %i, write_timeout = %i\n",
         |         ^~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
