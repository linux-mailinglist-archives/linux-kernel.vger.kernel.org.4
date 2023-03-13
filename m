Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA536B8151
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCMTAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCMTAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:00:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B8622A27
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678734041; x=1710270041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+VSeNz27rcTgOCdWE+PjGAqFqgtaImjieT21IBpCMQ=;
  b=ltqEb6EFO/9/NalTiQHE5HGYZ0n8VY611QW4IkHLvfcaxP95f2flU1E/
   yIie8j8COAFzLEK5yM6EsrAm2x9YFTVuYGebLv15PyOzUHYyBsHhAHR6F
   LxVFrHfvYFU5WDZWJxXedKQUHhC1hXAu908qloBCayZmuQlekXdfSdXqi
   qEAkoOgyA5x8BA4NNx3LaTCcWfNx4DBk083gyc2iOIY7JnPJ/Pq6WEFyc
   6gMpxa6wId1qvXWJyzLbtlZMQvxtPbzSNjSn7DCzbwghWy9kJqLM4V4uu
   J3mMbF52ibRFXUa5e8A42UNxRfJW1XsEwpGx+d1Hxb3s817coZ2nP1rjK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399827095"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="399827095"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 12:00:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="628741978"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="628741978"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Mar 2023 12:00:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbnPS-00061U-1p;
        Mon, 13 Mar 2023 19:00:38 +0000
Date:   Tue, 14 Mar 2023 03:00:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <202303140222.Ku4vFjgO-lkp@intel.com>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Khadija-Kamran/staging-axis-fifo-initialize-timeouts-in-probe-only/20230314-020827
patch link:    https://lore.kernel.org/r/ZA9mThZ7NyRrQAMX%40khadija-virtual-machine
patch subject: [PATCH] staging: axis-fifo: initialize timeouts in probe only
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230314/202303140222.Ku4vFjgO-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9d186f6c9f9bf467b48da3e28b0e9aa31fc3faf3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Khadija-Kamran/staging-axis-fifo-initialize-timeouts-in-probe-only/20230314-020827
        git checkout 9d186f6c9f9bf467b48da3e28b0e9aa31fc3faf3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303140222.Ku4vFjgO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/limits.h:7,
                    from include/linux/kernel.h:16,
                    from drivers/staging/axis-fifo/axis-fifo.c:17:
   drivers/staging/axis-fifo/axis-fifo.c: In function 'axis_fifo_probe':
>> include/vdso/limits.h:11:25: warning: overflow in conversion from 'long int' to 'int' changes value from '9223372036854775807' to '-1' [-Woverflow]
      11 | #define LONG_MAX        ((long)(~0UL >> 1))
         |                         ^
   include/linux/sched.h:296:41: note: in expansion of macro 'LONG_MAX'
     296 | #define MAX_SCHEDULE_TIMEOUT            LONG_MAX
         |                                         ^~~~~~~~
   drivers/staging/axis-fifo/axis-fifo.c:817:32: note: in expansion of macro 'MAX_SCHEDULE_TIMEOUT'
     817 |                 read_timeout = MAX_SCHEDULE_TIMEOUT;
         |                                ^~~~~~~~~~~~~~~~~~~~
>> include/vdso/limits.h:11:25: warning: overflow in conversion from 'long int' to 'int' changes value from '9223372036854775807' to '-1' [-Woverflow]
      11 | #define LONG_MAX        ((long)(~0UL >> 1))
         |                         ^
   include/linux/sched.h:296:41: note: in expansion of macro 'LONG_MAX'
     296 | #define MAX_SCHEDULE_TIMEOUT            LONG_MAX
         |                                         ^~~~~~~~
   drivers/staging/axis-fifo/axis-fifo.c:822:33: note: in expansion of macro 'MAX_SCHEDULE_TIMEOUT'
     822 |                 write_timeout = MAX_SCHEDULE_TIMEOUT;
         |                                 ^~~~~~~~~~~~~~~~~~~~


vim +11 include/vdso/limits.h

3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20   4  
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20   5  #define USHRT_MAX	((unsigned short)~0U)
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20   6  #define SHRT_MAX	((short)(USHRT_MAX >> 1))
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20   7  #define SHRT_MIN	((short)(-SHRT_MAX - 1))
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20   8  #define INT_MAX		((int)(~0U >> 1))
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20   9  #define INT_MIN		(-INT_MAX - 1)
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20  10  #define UINT_MAX	(~0U)
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20 @11  #define LONG_MAX	((long)(~0UL >> 1))
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20  12  #define LONG_MIN	(-LONG_MAX - 1)
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20  13  #define ULONG_MAX	(~0UL)
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20  14  #define LLONG_MAX	((long long)(~0ULL >> 1))
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20  15  #define LLONG_MIN	(-LLONG_MAX - 1)
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20  16  #define ULLONG_MAX	(~0ULL)
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20  17  #define UINTPTR_MAX	ULONG_MAX
3e0e9f8c6e3ca9 Vincenzo Frascino 2020-03-20  18  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
