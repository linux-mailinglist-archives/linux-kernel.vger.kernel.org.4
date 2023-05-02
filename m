Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29606F4B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjEBUmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEBUmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:42:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAEC1BDF;
        Tue,  2 May 2023 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683060161; x=1714596161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zuRYtcFHtmVZ+xkOvP47r2QSjBH2/ZdZZctN4FWn8n8=;
  b=GrGjKlqBGjhcI82SUlLUNJQa68ZUxRB/Tq3zbPKscUJEOfircgXK1JgQ
   VPwT8JZQTV4pXakGNYxLUy06j5Ed/gwg1PzctqXTh70o8CD8O0R+BUJFa
   dNV8z/wayEoO7eA2TW6OVfpraiS9QeEJNJQeqwGYbcpMrz+e/co9Qtdsv
   RCh3G/XLJRnvOVGE1aqRNUDqOgnX4aWNjwfjHEbf/YDS8fVrUECFWgSCN
   iaVghauyX771z0glKb21BhvCR/kHQcfUyFXavCZp+FpTXhb0483+m+2DA
   qX/jDazmVW6wn/Lj5MIF95adlRZWw9eB7ZpbUK2kCYQrQKXuj1KsO3nwW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="337635606"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="337635606"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 13:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="690430355"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="690430355"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 02 May 2023 13:42:38 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptwpZ-0001H8-1d;
        Tue, 02 May 2023 20:42:37 +0000
Date:   Wed, 3 May 2023 04:42:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     minyard@acm.org, im Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     oe-kbuild-all@lists.linux.dev,
        openipmi-developer@lists.sourceforge.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] watchdog: Add an IPMI watchdog driver in the watchdog
 framework
Message-ID: <202305030442.Ug9opjA1-lkp@intel.com>
References: <20230502150215.1266526-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502150215.1266526-1-minyard@acm.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230503/202305030442.Ug9opjA1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3138708f587acacac7e95f3098e7a9587866a66e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review minyard-acm-org/watchdog-Add-an-IPMI-watchdog-driver-in-the-watchdog-framework/20230502-230545
        git checkout 3138708f587acacac7e95f3098e7a9587866a66e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305030442.Ug9opjA1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/watchdog/ipmi_wdt.c:515:5: warning: no previous prototype for 'ipmi_wdt_start' [-Wmissing-prototypes]
     515 | int ipmi_wdt_start(struct watchdog_device *wd)
         |     ^~~~~~~~~~~~~~
   drivers/watchdog/ipmi_wdt.c:529:5: warning: no previous prototype for 'ipmi_wdt_stop' [-Wmissing-prototypes]
     529 | int ipmi_wdt_stop(struct watchdog_device *wd)
         |     ^~~~~~~~~~~~~
   drivers/watchdog/ipmi_wdt.c:539:5: warning: no previous prototype for 'ipmi_wdt_ping' [-Wmissing-prototypes]
     539 | int ipmi_wdt_ping(struct watchdog_device *wd)
         |     ^~~~~~~~~~~~~
   drivers/watchdog/ipmi_wdt.c:550:5: warning: no previous prototype for 'ipmi_wdt_set_timeout' [-Wmissing-prototypes]
     550 | int ipmi_wdt_set_timeout(struct watchdog_device *wd, unsigned int to)
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/watchdog/ipmi_wdt.c:563:5: warning: no previous prototype for 'ipmi_wdt_set_pretimeout' [-Wmissing-prototypes]
     563 | int ipmi_wdt_set_pretimeout(struct watchdog_device *wd, unsigned int pto)
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/ipmi_wdt_set_pretimeout +563 drivers/watchdog/ipmi_wdt.c

   561	
   562	#ifdef HAVE_DIE_NMI
 > 563	int ipmi_wdt_set_pretimeout(struct watchdog_device *wd, unsigned int pto)
   564	{
   565		int rv;
   566	
   567		mutex_lock(&ipmi_watchdog_mutex);
   568		pretimeout = pto;
   569		if (pto)
   570			pretimeout_state = WDOG_PRETIMEOUT_NMI;
   571		else
   572			pretimeout_state = WDOG_PRETIMEOUT_NONE;
   573	
   574		rv = _ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
   575		mutex_unlock(&ipmi_watchdog_mutex);
   576	
   577		return rv;
   578	}
   579	#endif
   580	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
