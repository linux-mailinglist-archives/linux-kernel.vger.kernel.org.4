Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E3873D6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFZEGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFZEGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:06:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972D11B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 21:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687752374; x=1719288374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NXivVSXkHgMkEjie+k5Nfpvk7wUxPvO4QF7oBYqQcII=;
  b=Bn1n+sMrvyB2rPUsWnQHyqMry0aMoksfex181QjYC1SqxtyJfq9TX0Qb
   e16vmTl282HOfsZ/Sa4ssq/w2lN5i9a8JovYuDNS4YCt9Kz0vJyhwr8ho
   rqdLo8MapP69YbKkfZsvwKGIbkJU6LJ9pMhNEmCvYsLYhq4O5H+rvPiZK
   NvtLcOrDrwBYqpt0jRMle6dopzKEL4tHko2Y0JIBnsecEjSf8PzIsCX06
   +tXaP8HlQ605kb6wFt4GozelhY4PQaJoy9DTvHSBkNbkiqd22njnP1+8C
   WmpdRfymqToJZKCgZ0tDI8gR16FXFCPXUPnNrexl2K2JlyKx8Z7z19VFH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="364616785"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="364616785"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 21:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="890150588"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="890150588"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2023 21:06:10 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDdUP-000AT5-2x;
        Mon, 26 Jun 2023 04:06:09 +0000
Date:   Mon, 26 Jun 2023 12:05:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li zeming <zeming@nfschina.com>, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] time: ntp: Remove =?utf-8?Q?un?=
 =?utf-8?B?bmVjZXNzYXJ5IOKAmC1FTk9ERVbigJk=?= values from err
Message-ID: <202306261141.5MEtBJtk-lkp@intel.com>
References: <20230627182540.5243-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627182540.5243-1-zeming@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on linus/master v6.4 next-20230623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-zeming/time-ntp-Remove-unnecessary-ENODEV-values-from-err/20230626-095508
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20230627182540.5243-1-zeming%40nfschina.com
patch subject: [PATCH] time: ntp: Remove unnecessary ‘-ENODEV’ values from err
config: i386-randconfig-i004-20230626 (https://download.01.org/0day-ci/archive/20230626/202306261141.5MEtBJtk-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230626/202306261141.5MEtBJtk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306261141.5MEtBJtk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/time/ntp.c:591:6: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!rtc->ops || !rtc->ops->set_time)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/ntp.c:605:9: note: uninitialized use occurs here
           return err;
                  ^~~
   kernel/time/ntp.c:591:2: note: remove the 'if' if its condition is always false
           if (!rtc->ops || !rtc->ops->set_time)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/time/ntp.c:591:6: warning: variable 'err' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if (!rtc->ops || !rtc->ops->set_time)
               ^~~~~~~~~
   kernel/time/ntp.c:605:9: note: uninitialized use occurs here
           return err;
                  ^~~
   kernel/time/ntp.c:591:6: note: remove the '||' if its condition is always false
           if (!rtc->ops || !rtc->ops->set_time)
               ^~~~~~~~~~~~
   kernel/time/ntp.c:585:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   2 warnings generated.


vim +591 kernel/time/ntp.c

76e87d96b30b5f Thomas Gleixner 2020-12-06  578  
33e62e832384c8 Thomas Gleixner 2020-12-06  579  #ifdef CONFIG_RTC_SYSTOHC
76e87d96b30b5f Thomas Gleixner 2020-12-06  580  /* Save NTP synchronized time to the RTC */
76e87d96b30b5f Thomas Gleixner 2020-12-06  581  static int update_rtc(struct timespec64 *to_set, unsigned long *offset_nsec)
33e62e832384c8 Thomas Gleixner 2020-12-06  582  {
33e62e832384c8 Thomas Gleixner 2020-12-06  583  	struct rtc_device *rtc;
33e62e832384c8 Thomas Gleixner 2020-12-06  584  	struct rtc_time tm;
7c397afa918b1a Li zeming       2023-06-28  585  	int err;
33e62e832384c8 Thomas Gleixner 2020-12-06  586  
33e62e832384c8 Thomas Gleixner 2020-12-06  587  	rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
33e62e832384c8 Thomas Gleixner 2020-12-06  588  	if (!rtc)
76e87d96b30b5f Thomas Gleixner 2020-12-06  589  		return -ENODEV;
33e62e832384c8 Thomas Gleixner 2020-12-06  590  
33e62e832384c8 Thomas Gleixner 2020-12-06 @591  	if (!rtc->ops || !rtc->ops->set_time)
33e62e832384c8 Thomas Gleixner 2020-12-06  592  		goto out_close;
33e62e832384c8 Thomas Gleixner 2020-12-06  593  
76e87d96b30b5f Thomas Gleixner 2020-12-06  594  	/* First call might not have the correct offset */
76e87d96b30b5f Thomas Gleixner 2020-12-06  595  	if (*offset_nsec == rtc->set_offset_nsec) {
76e87d96b30b5f Thomas Gleixner 2020-12-06  596  		rtc_time64_to_tm(to_set->tv_sec, &tm);
76e87d96b30b5f Thomas Gleixner 2020-12-06  597  		err = rtc_set_time(rtc, &tm);
76e87d96b30b5f Thomas Gleixner 2020-12-06  598  	} else {
76e87d96b30b5f Thomas Gleixner 2020-12-06  599  		/* Store the update offset and let the caller try again */
69eca258c85000 Thomas Gleixner 2020-12-06  600  		*offset_nsec = rtc->set_offset_nsec;
76e87d96b30b5f Thomas Gleixner 2020-12-06  601  		err = -EAGAIN;
33e62e832384c8 Thomas Gleixner 2020-12-06  602  	}
33e62e832384c8 Thomas Gleixner 2020-12-06  603  out_close:
33e62e832384c8 Thomas Gleixner 2020-12-06  604  	rtc_class_close(rtc);
33e62e832384c8 Thomas Gleixner 2020-12-06  605  	return err;
33e62e832384c8 Thomas Gleixner 2020-12-06  606  }
33e62e832384c8 Thomas Gleixner 2020-12-06  607  #else
76e87d96b30b5f Thomas Gleixner 2020-12-06  608  static inline int update_rtc(struct timespec64 *to_set, unsigned long *offset_nsec)
3c00a1fe8496ff Xunlei Pang     2015-04-01  609  {
926617889dc838 Arnd Bergmann   2018-08-14  610  	return -ENODEV;
3c00a1fe8496ff Xunlei Pang     2015-04-01  611  }
3c00a1fe8496ff Xunlei Pang     2015-04-01  612  #endif
3c00a1fe8496ff Xunlei Pang     2015-04-01  613  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
