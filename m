Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF2473D6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjFZEGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFZEGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:06:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D671AA
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687752374; x=1719288374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7kPsgpTpzjhTdpO/VDl2FDgRskFjsKreH2SS3Vbfgu8=;
  b=SatjOmIp1eRfdv1Nw1TqBojsbvOI2sz1w1QHnu3oFcOFG+BN9PHrADdP
   JF5ohHh+wxPFA8wS2d+x2gh0cAzJWPtEE6W5I6IslwZFsmqdw62Y1hgpj
   triY0k4LxcknegyNNxHwolLLEJ7D7Rnt0sT8aafhRJP30lPYMQYzrKkbz
   7M7IbURl9pQbQR5aLVndxcBfyhfQWjAnONLoEXvf8z5kmWy7f7qxQx0QC
   QVUXZFFnRnzJaGWpiMr96xI3KtNF0YMYo9zcBPMEKUU9VCBBHK//cQmou
   X+OsFnzIfEmbAU3PzcuHIf+pKaGlFKIwRtX1sDHGHVGxq0RKlmGSF/+/7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="360035581"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="360035581"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 21:06:13 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="750894915"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="750894915"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jun 2023 21:06:11 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDdUQ-000ATE-05;
        Mon, 26 Jun 2023 04:06:10 +0000
Date:   Mon, 26 Jun 2023 12:05:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li zeming <zeming@nfschina.com>, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] time: ntp: Remove =?utf-8?Q?un?=
 =?utf-8?B?bmVjZXNzYXJ5IOKAmC1FTk9ERVbigJk=?= values from err
Message-ID: <202306261146.21X5CDd9-lkp@intel.com>
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
config: hexagon-randconfig-r045-20230626 (https://download.01.org/0day-ci/archive/20230626/202306261146.21X5CDd9-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230626/202306261146.21X5CDd9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306261146.21X5CDd9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/time/ntp.c:10:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/time/ntp.c:10:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/time/ntp.c:10:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> kernel/time/ntp.c:591:6: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     591 |         if (!rtc->ops || !rtc->ops->set_time)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/ntp.c:605:9: note: uninitialized use occurs here
     605 |         return err;
         |                ^~~
   kernel/time/ntp.c:591:2: note: remove the 'if' if its condition is always false
     591 |         if (!rtc->ops || !rtc->ops->set_time)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     592 |                 goto out_close;
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/time/ntp.c:591:6: warning: variable 'err' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
     591 |         if (!rtc->ops || !rtc->ops->set_time)
         |             ^~~~~~~~~
   kernel/time/ntp.c:605:9: note: uninitialized use occurs here
     605 |         return err;
         |                ^~~
   kernel/time/ntp.c:591:6: note: remove the '||' if its condition is always false
     591 |         if (!rtc->ops || !rtc->ops->set_time)
         |             ^~~~~~~~~~~~
   kernel/time/ntp.c:585:9: note: initialize the variable 'err' to silence this warning
     585 |         int err;
         |                ^
         |                 = 0
   8 warnings generated.


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
