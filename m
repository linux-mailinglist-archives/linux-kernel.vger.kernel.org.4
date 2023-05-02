Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45306F4A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 21:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjEBTan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEBTak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 15:30:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3755910E5;
        Tue,  2 May 2023 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683055839; x=1714591839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fqVAFC1aALlJtYtuv9Mqx4JsMxvXvaDX4yanOKMFwaA=;
  b=RKrYlMZqpI338p/Au0MQfdL70AVDFdbpNO+xdz56xZukqD9v2BDWwQLD
   Q0gsYwKtcMq2HS5GthGjddk5wZSDAII/5IOAyPwJ0D2OJDqfmNhs6ztuU
   mNhpXE5Uwtk7FJbUsSzghpE9d8xdu64b0cFdqAWA1QfCUOu5Ov8JWKthU
   iIb5dzrRjAaN3gdm7PtIHOudNG7FU6bLN5/4eC8bqPlxBPeJRL/gEcI2a
   XE2qbWAc4W2sJf7SrRiwhQK8qKeLdukNgadowYh+XOyWzl2qKIUUOwzxk
   sdOGjNEijQj1FSkqQ1cCGhSuzhh0rb5IEpwWdfrrYCZvlk/zk7KtUC5nR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="413939432"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="413939432"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 12:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="1026199976"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="1026199976"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 May 2023 12:30:36 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptvhr-0001Fo-2P;
        Tue, 02 May 2023 19:30:35 +0000
Date:   Wed, 3 May 2023 03:30:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     minyard@acm.org, im Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     oe-kbuild-all@lists.linux.dev,
        openipmi-developer@lists.sourceforge.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] watchdog: Add an IPMI watchdog driver in the watchdog
 framework
Message-ID: <202305030305.ZLru06GG-lkp@intel.com>
References: <20230502150215.1266526-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502150215.1266526-1-minyard@acm.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cminyard-ipmi/for-next]
[also build test WARNING on groeck-staging/hwmon-next linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/minyard-acm-org/watchdog-Add-an-IPMI-watchdog-driver-in-the-watchdog-framework/20230502-230545
base:   https://github.com/cminyard/linux-ipmi for-next
patch link:    https://lore.kernel.org/r/20230502150215.1266526-1-minyard%40acm.org
patch subject: [PATCH] watchdog: Add an IPMI watchdog driver in the watchdog framework
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230503/202305030305.ZLru06GG-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3138708f587acacac7e95f3098e7a9587866a66e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review minyard-acm-org/watchdog-Add-an-IPMI-watchdog-driver-in-the-watchdog-framework/20230502-230545
        git checkout 3138708f587acacac7e95f3098e7a9587866a66e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305030305.ZLru06GG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/watchdog/ipmi_wdt.c:515:5: warning: no previous prototype for 'ipmi_wdt_start' [-Wmissing-prototypes]
     515 | int ipmi_wdt_start(struct watchdog_device *wd)
         |     ^~~~~~~~~~~~~~
>> drivers/watchdog/ipmi_wdt.c:529:5: warning: no previous prototype for 'ipmi_wdt_stop' [-Wmissing-prototypes]
     529 | int ipmi_wdt_stop(struct watchdog_device *wd)
         |     ^~~~~~~~~~~~~
>> drivers/watchdog/ipmi_wdt.c:539:5: warning: no previous prototype for 'ipmi_wdt_ping' [-Wmissing-prototypes]
     539 | int ipmi_wdt_ping(struct watchdog_device *wd)
         |     ^~~~~~~~~~~~~
>> drivers/watchdog/ipmi_wdt.c:550:5: warning: no previous prototype for 'ipmi_wdt_set_timeout' [-Wmissing-prototypes]
     550 | int ipmi_wdt_set_timeout(struct watchdog_device *wd, unsigned int to)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/watchdog/ipmi_wdt.c:204:17: warning: 'preop_panic_excl' defined but not used [-Wunused-variable]
     204 | static atomic_t preop_panic_excl = ATOMIC_INIT(-1);
         |                 ^~~~~~~~~~~~~~~~


vim +/ipmi_wdt_start +515 drivers/watchdog/ipmi_wdt.c

   514	
 > 515	int ipmi_wdt_start(struct watchdog_device *wd)
   516	{
   517		int rv;
   518	
   519		mutex_lock(&ipmi_watchdog_mutex);
   520		ipmi_watchdog_state = action_val;
   521		rv = _ipmi_set_timeout(IPMI_SET_TIMEOUT_FORCE_HB);
   522		if (rv)
   523			ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
   524		mutex_unlock(&ipmi_watchdog_mutex);
   525	
   526		return rv;
   527	}
   528	
 > 529	int ipmi_wdt_stop(struct watchdog_device *wd)
   530	{
   531		mutex_lock(&ipmi_watchdog_mutex);
   532		ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
   533		_ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
   534		mutex_unlock(&ipmi_watchdog_mutex);
   535	
   536		return 0;
   537	}
   538	
 > 539	int ipmi_wdt_ping(struct watchdog_device *wd)
   540	{
   541		int rv;
   542	
   543		mutex_lock(&ipmi_watchdog_mutex);
   544		rv = _ipmi_heartbeat();
   545		mutex_unlock(&ipmi_watchdog_mutex);
   546	
   547		return rv;
   548	}
   549	
 > 550	int ipmi_wdt_set_timeout(struct watchdog_device *wd, unsigned int to)
   551	{
   552		int rv;
   553	
   554		mutex_lock(&ipmi_watchdog_mutex);
   555		timeout = to;
   556		rv = _ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
   557		mutex_unlock(&ipmi_watchdog_mutex);
   558	
   559		return rv;
   560	}
   561	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
