Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C6E60DDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiJZJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJZJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:16:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829188F246
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666775811; x=1698311811;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZnxWTf4+3ZF40Q58mX2C35CTcoRkINhta9jklkir7Co=;
  b=BnRHOAUOACpGary4IThe9FiBeFk7knnppbvRD9cskJQQDq4FG7QY9fsj
   53tIekMj7ayb9lDLL4Kx/AD1G3KRTBpj5KEKVKup4wEcTJq8RHE9wSPOH
   8bWbfz/VS/f6EZ5JD7qM4WJXsP6E14NLWQ89Kx0EjLpTk1zVM+uSuuXNS
   Y3xGOOze4cWyotTnpW+NLkCPDTgJTO3FFT/raZL7sQ02KgT7KmiPPhVYr
   pgljq2j7CVjRI8UCHmbTeD0gB2SEFsQB2ICDMPm9p/Pi3EBMJgxiYEYrg
   gMIpv9LNrF5FzyM8yPMLignCcSdQCBYLG+FyglaCCfXf2PjSqnaUicBs9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="369967907"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="gz'50?scan'50,208,50";a="369967907"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 02:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="634423851"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="gz'50?scan'50,208,50";a="634423851"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 26 Oct 2022 02:16:46 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oncWj-0007ER-27;
        Wed, 26 Oct 2022 09:16:45 +0000
Date:   Wed, 26 Oct 2022 17:16:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>
Subject: [jirislaby:lto 27/47] kernel/time/posix-stubs.c:49:1: error: use of
 undeclared identifier 'sys_timer_create'
Message-ID: <202210261727.wkFvxzU4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Bp75Z5UiYXgwP1o7"
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bp75Z5UiYXgwP1o7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   8565e13d5d29eb32bed9674240593315f3bdd7f5
commit: 088d326951aa790c35f1f009be5997088fe8f4bb [27/47] linkage, lto: use C version for SYSCALL_ALIAS() / cond_syscall()
config: powerpc-randconfig-r034-20221024 (attached as .config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=088d326951aa790c35f1f009be5997088fe8f4bb
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout 088d326951aa790c35f1f009be5997088fe8f4bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/time/posix-stubs.c:25:17: warning: no previous prototype for function 'sys_ni_posix_timers' [-Wmissing-prototypes]
   asmlinkage long sys_ni_posix_timers(void)
                   ^
   kernel/time/posix-stubs.c:25:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage long sys_ni_posix_timers(void)
              ^
              static 
>> kernel/time/posix-stubs.c:49:1: error: use of undeclared identifier 'sys_timer_create'
   SYS_NI(timer_create);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:99:1: note: expanded from here
   sys_timer_create
   ^
>> kernel/time/posix-stubs.c:49:1: error: definition 'sys_timer_create' cannot also be an alias
   kernel/time/posix-stubs.c:34:23: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                         ^
   include/linux/linkage.h:34:29: note: expanded from macro 'SYSCALL_ALIAS_PROTO'
           typeof(a) a __attribute__((alias(__stringify(name))))
                                      ^
>> kernel/time/posix-stubs.c:50:1: error: use of undeclared identifier 'sys_timer_gettime'
   SYS_NI(timer_gettime);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:101:1: note: expanded from here
   sys_timer_gettime
   ^
>> kernel/time/posix-stubs.c:50:1: error: definition 'sys_timer_gettime' cannot also be an alias
   kernel/time/posix-stubs.c:34:23: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                         ^
   include/linux/linkage.h:34:29: note: expanded from macro 'SYSCALL_ALIAS_PROTO'
           typeof(a) a __attribute__((alias(__stringify(name))))
                                      ^
>> kernel/time/posix-stubs.c:51:1: error: use of undeclared identifier 'sys_timer_getoverrun'
   SYS_NI(timer_getoverrun);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:103:1: note: expanded from here
   sys_timer_getoverrun
   ^
>> kernel/time/posix-stubs.c:51:1: error: definition 'sys_timer_getoverrun' cannot also be an alias
   kernel/time/posix-stubs.c:34:23: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                         ^
   include/linux/linkage.h:34:29: note: expanded from macro 'SYSCALL_ALIAS_PROTO'
           typeof(a) a __attribute__((alias(__stringify(name))))
                                      ^
>> kernel/time/posix-stubs.c:52:1: error: use of undeclared identifier 'sys_timer_settime'
   SYS_NI(timer_settime);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:105:1: note: expanded from here
   sys_timer_settime
   ^
>> kernel/time/posix-stubs.c:52:1: error: definition 'sys_timer_settime' cannot also be an alias
   kernel/time/posix-stubs.c:34:23: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                         ^
   include/linux/linkage.h:34:29: note: expanded from macro 'SYSCALL_ALIAS_PROTO'
           typeof(a) a __attribute__((alias(__stringify(name))))
                                      ^
>> kernel/time/posix-stubs.c:53:1: error: use of undeclared identifier 'sys_timer_delete'
   SYS_NI(timer_delete);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:107:1: note: expanded from here
   sys_timer_delete
   ^
>> kernel/time/posix-stubs.c:53:1: error: definition 'sys_timer_delete' cannot also be an alias
   kernel/time/posix-stubs.c:34:23: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                         ^
   include/linux/linkage.h:34:29: note: expanded from macro 'SYSCALL_ALIAS_PROTO'
           typeof(a) a __attribute__((alias(__stringify(name))))
                                      ^
>> kernel/time/posix-stubs.c:54:1: error: use of undeclared identifier 'sys_clock_adjtime'; did you mean 'do_clock_adjtime'?
   SYS_NI(clock_adjtime);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:109:1: note: expanded from here
   sys_clock_adjtime
   ^
   include/linux/timex.h:163:12: note: 'do_clock_adjtime' declared here
   extern int do_clock_adjtime(const clockid_t which_clock, struct __kernel_timex * ktx);
              ^
>> kernel/time/posix-stubs.c:55:1: error: use of undeclared identifier 'sys_getitimer'
   SYS_NI(getitimer);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:111:1: note: expanded from here
   sys_getitimer
   ^
>> kernel/time/posix-stubs.c:55:1: error: definition 'sys_getitimer' cannot also be an alias
   kernel/time/posix-stubs.c:34:23: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                         ^
   include/linux/linkage.h:34:29: note: expanded from macro 'SYSCALL_ALIAS_PROTO'
           typeof(a) a __attribute__((alias(__stringify(name))))
                                      ^
>> kernel/time/posix-stubs.c:56:1: error: use of undeclared identifier 'sys_setitimer'; did you mean 'cap_settime'?
   SYS_NI(setitimer);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:113:1: note: expanded from here
   sys_setitimer
   ^
   include/linux/security.h:144:12: note: 'cap_settime' declared here
   extern int cap_settime(const struct timespec64 *ts, const struct timezone *tz);
              ^
>> kernel/time/posix-stubs.c:57:1: error: use of undeclared identifier 'sys_clock_adjtime32'; did you mean 'sys_clock_adjtime'?
   SYS_NI(clock_adjtime32);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:115:1: note: expanded from here
   sys_clock_adjtime32
   ^
   kernel/time/posix-stubs.c:54:1: note: 'sys_clock_adjtime' declared here
   SYS_NI(clock_adjtime);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:109:1: note: expanded from here
   sys_clock_adjtime
   ^
>> kernel/time/posix-stubs.c:59:1: error: use of undeclared identifier 'sys_alarm'
   SYS_NI(alarm);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:117:1: note: expanded from here
   sys_alarm
   ^
>> kernel/time/posix-stubs.c:59:1: error: definition 'sys_alarm' cannot also be an alias
   kernel/time/posix-stubs.c:34:23: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                         ^
   include/linux/linkage.h:34:29: note: expanded from macro 'SYSCALL_ALIAS_PROTO'
           typeof(a) a __attribute__((alias(__stringify(name))))
                                      ^
>> kernel/time/posix-stubs.c:183:1: error: use of undeclared identifier 'sys_timer_settime32'
   SYS_NI(timer_settime32);
   ^
   kernel/time/posix-stubs.c:34:43: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                                             ^
   <scratch space>:206:1: note: expanded from here
   sys_timer_settime32
   ^
>> kernel/time/posix-stubs.c:183:1: error: definition 'sys_timer_settime32' cannot also be an alias
   kernel/time/posix-stubs.c:34:23: note: expanded from macro 'SYS_NI'
   #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
                         ^
   include/linux/linkage.h:34:29: note: expanded from macro 'SYSCALL_ALIAS_PROTO'
           typeof(a) a __attribute__((alias(__stringify(name))))
                                      ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.


vim +/sys_timer_create +49 kernel/time/posix-stubs.c

088d326951aa79 Andi Kleen     2017-04-09   48  
baa73d9e478ff3 Nicolas Pitre  2016-11-11  @49  SYS_NI(timer_create);
baa73d9e478ff3 Nicolas Pitre  2016-11-11  @50  SYS_NI(timer_gettime);
baa73d9e478ff3 Nicolas Pitre  2016-11-11  @51  SYS_NI(timer_getoverrun);
baa73d9e478ff3 Nicolas Pitre  2016-11-11  @52  SYS_NI(timer_settime);
baa73d9e478ff3 Nicolas Pitre  2016-11-11  @53  SYS_NI(timer_delete);
baa73d9e478ff3 Nicolas Pitre  2016-11-11  @54  SYS_NI(clock_adjtime);
baa73d9e478ff3 Nicolas Pitre  2016-11-11  @55  SYS_NI(getitimer);
baa73d9e478ff3 Nicolas Pitre  2016-11-11  @56  SYS_NI(setitimer);
8dabe7245bbc13 Arnd Bergmann  2019-01-07  @57  SYS_NI(clock_adjtime32);
baa73d9e478ff3 Nicolas Pitre  2016-11-11   58  #ifdef __ARCH_WANT_SYS_ALARM
baa73d9e478ff3 Nicolas Pitre  2016-11-11  @59  SYS_NI(alarm);
baa73d9e478ff3 Nicolas Pitre  2016-11-11   60  #endif
baa73d9e478ff3 Nicolas Pitre  2016-11-11   61  
088d326951aa79 Andi Kleen     2017-04-09   62  __diag_pop();
088d326951aa79 Andi Kleen     2017-04-09   63  
baa73d9e478ff3 Nicolas Pitre  2016-11-11   64  /*
baa73d9e478ff3 Nicolas Pitre  2016-11-11   65   * We preserve minimal support for CLOCK_REALTIME and CLOCK_MONOTONIC
baa73d9e478ff3 Nicolas Pitre  2016-11-11   66   * as it is easy to remain compatible with little code. CLOCK_BOOTTIME
baa73d9e478ff3 Nicolas Pitre  2016-11-11   67   * is also included for convenience as at least systemd uses it.
baa73d9e478ff3 Nicolas Pitre  2016-11-11   68   */
baa73d9e478ff3 Nicolas Pitre  2016-11-11   69  
baa73d9e478ff3 Nicolas Pitre  2016-11-11   70  SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
6d5b84132459c6 Deepa Dinamani 2018-03-13   71  		const struct __kernel_timespec __user *, tp)
baa73d9e478ff3 Nicolas Pitre  2016-11-11   72  {
5c4994102fb508 Deepa Dinamani 2017-06-24   73  	struct timespec64 new_tp;
baa73d9e478ff3 Nicolas Pitre  2016-11-11   74  
baa73d9e478ff3 Nicolas Pitre  2016-11-11   75  	if (which_clock != CLOCK_REALTIME)
baa73d9e478ff3 Nicolas Pitre  2016-11-11   76  		return -EINVAL;
5c4994102fb508 Deepa Dinamani 2017-06-24   77  	if (get_timespec64(&new_tp, tp))
baa73d9e478ff3 Nicolas Pitre  2016-11-11   78  		return -EFAULT;
2ac00f17b2e110 Deepa Dinamani 2017-03-26   79  
5c4994102fb508 Deepa Dinamani 2017-06-24   80  	return do_sys_settimeofday64(&new_tp, NULL);
baa73d9e478ff3 Nicolas Pitre  2016-11-11   81  }
baa73d9e478ff3 Nicolas Pitre  2016-11-11   82  
221f9d9cdf429d Jiri Slaby     2022-07-19   83  static int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
5c4994102fb508 Deepa Dinamani 2017-06-24   84  {
5c4994102fb508 Deepa Dinamani 2017-06-24   85  	switch (which_clock) {
5c4994102fb508 Deepa Dinamani 2017-06-24   86  	case CLOCK_REALTIME:
5c4994102fb508 Deepa Dinamani 2017-06-24   87  		ktime_get_real_ts64(tp);
5c4994102fb508 Deepa Dinamani 2017-06-24   88  		break;
5c4994102fb508 Deepa Dinamani 2017-06-24   89  	case CLOCK_MONOTONIC:
5c4994102fb508 Deepa Dinamani 2017-06-24   90  		ktime_get_ts64(tp);
5a590f35add93c Andrei Vagin   2019-11-12   91  		timens_add_monotonic(tp);
5c4994102fb508 Deepa Dinamani 2017-06-24   92  		break;
5c4994102fb508 Deepa Dinamani 2017-06-24   93  	case CLOCK_BOOTTIME:
58a10456d7175f Arnd Bergmann  2018-06-18   94  		ktime_get_boottime_ts64(tp);
5a590f35add93c Andrei Vagin   2019-11-12   95  		timens_add_boottime(tp);
5c4994102fb508 Deepa Dinamani 2017-06-24   96  		break;
5c4994102fb508 Deepa Dinamani 2017-06-24   97  	default:
5c4994102fb508 Deepa Dinamani 2017-06-24   98  		return -EINVAL;
5c4994102fb508 Deepa Dinamani 2017-06-24   99  	}
5c4994102fb508 Deepa Dinamani 2017-06-24  100  
5c4994102fb508 Deepa Dinamani 2017-06-24  101  	return 0;
5c4994102fb508 Deepa Dinamani 2017-06-24  102  }
221f9d9cdf429d Jiri Slaby     2022-07-19  103  
baa73d9e478ff3 Nicolas Pitre  2016-11-11  104  SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
6d5b84132459c6 Deepa Dinamani 2018-03-13  105  		struct __kernel_timespec __user *, tp)
baa73d9e478ff3 Nicolas Pitre  2016-11-11  106  {
5c4994102fb508 Deepa Dinamani 2017-06-24  107  	int ret;
5c4994102fb508 Deepa Dinamani 2017-06-24  108  	struct timespec64 kernel_tp;
baa73d9e478ff3 Nicolas Pitre  2016-11-11  109  
5c4994102fb508 Deepa Dinamani 2017-06-24  110  	ret = do_clock_gettime(which_clock, &kernel_tp);
5c4994102fb508 Deepa Dinamani 2017-06-24  111  	if (ret)
5c4994102fb508 Deepa Dinamani 2017-06-24  112  		return ret;
3c9c12f4b4610d Deepa Dinamani 2017-03-26  113  
5c4994102fb508 Deepa Dinamani 2017-06-24  114  	if (put_timespec64(&kernel_tp, tp))
baa73d9e478ff3 Nicolas Pitre  2016-11-11  115  		return -EFAULT;
baa73d9e478ff3 Nicolas Pitre  2016-11-11  116  	return 0;
baa73d9e478ff3 Nicolas Pitre  2016-11-11  117  }
baa73d9e478ff3 Nicolas Pitre  2016-11-11  118  
6d5b84132459c6 Deepa Dinamani 2018-03-13  119  SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct __kernel_timespec __user *, tp)
baa73d9e478ff3 Nicolas Pitre  2016-11-11  120  {
5c4994102fb508 Deepa Dinamani 2017-06-24  121  	struct timespec64 rtn_tp = {
baa73d9e478ff3 Nicolas Pitre  2016-11-11  122  		.tv_sec = 0,
baa73d9e478ff3 Nicolas Pitre  2016-11-11  123  		.tv_nsec = hrtimer_resolution,
baa73d9e478ff3 Nicolas Pitre  2016-11-11  124  	};
baa73d9e478ff3 Nicolas Pitre  2016-11-11  125  
baa73d9e478ff3 Nicolas Pitre  2016-11-11  126  	switch (which_clock) {
baa73d9e478ff3 Nicolas Pitre  2016-11-11  127  	case CLOCK_REALTIME:
baa73d9e478ff3 Nicolas Pitre  2016-11-11  128  	case CLOCK_MONOTONIC:
baa73d9e478ff3 Nicolas Pitre  2016-11-11  129  	case CLOCK_BOOTTIME:
5c4994102fb508 Deepa Dinamani 2017-06-24  130  		if (put_timespec64(&rtn_tp, tp))
baa73d9e478ff3 Nicolas Pitre  2016-11-11  131  			return -EFAULT;
baa73d9e478ff3 Nicolas Pitre  2016-11-11  132  		return 0;
baa73d9e478ff3 Nicolas Pitre  2016-11-11  133  	default:
baa73d9e478ff3 Nicolas Pitre  2016-11-11  134  		return -EINVAL;
baa73d9e478ff3 Nicolas Pitre  2016-11-11  135  	}
baa73d9e478ff3 Nicolas Pitre  2016-11-11  136  }
baa73d9e478ff3 Nicolas Pitre  2016-11-11  137  
baa73d9e478ff3 Nicolas Pitre  2016-11-11  138  SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
01909974b41036 Deepa Dinamani 2018-03-13  139  		const struct __kernel_timespec __user *, rqtp,
01909974b41036 Deepa Dinamani 2018-03-13  140  		struct __kernel_timespec __user *, rmtp)
baa73d9e478ff3 Nicolas Pitre  2016-11-11  141  {
fe460423438b62 Arnd Bergmann  2017-10-13  142  	struct timespec64 t;
1f9b37bfbb607a Andrei Vagin   2019-11-12  143  	ktime_t texp;
baa73d9e478ff3 Nicolas Pitre  2016-11-11  144  
baa73d9e478ff3 Nicolas Pitre  2016-11-11  145  	switch (which_clock) {
baa73d9e478ff3 Nicolas Pitre  2016-11-11  146  	case CLOCK_REALTIME:
baa73d9e478ff3 Nicolas Pitre  2016-11-11  147  	case CLOCK_MONOTONIC:
baa73d9e478ff3 Nicolas Pitre  2016-11-11  148  	case CLOCK_BOOTTIME:
edbeda46322fbc Al Viro        2017-06-07  149  		break;
edbeda46322fbc Al Viro        2017-06-07  150  	default:
edbeda46322fbc Al Viro        2017-06-07  151  		return -EINVAL;
edbeda46322fbc Al Viro        2017-06-07  152  	}
edbeda46322fbc Al Viro        2017-06-07  153  
fe460423438b62 Arnd Bergmann  2017-10-13  154  	if (get_timespec64(&t, rqtp))
baa73d9e478ff3 Nicolas Pitre  2016-11-11  155  		return -EFAULT;
fe460423438b62 Arnd Bergmann  2017-10-13  156  	if (!timespec64_valid(&t))
baa73d9e478ff3 Nicolas Pitre  2016-11-11  157  		return -EINVAL;
192a82f9003fe8 Al Viro        2017-06-07  158  	if (flags & TIMER_ABSTIME)
192a82f9003fe8 Al Viro        2017-06-07  159  		rmtp = NULL;
edbeda46322fbc Al Viro        2017-06-07  160  	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
192a82f9003fe8 Al Viro        2017-06-07  161  	current->restart_block.nanosleep.rmtp = rmtp;
1f9b37bfbb607a Andrei Vagin   2019-11-12  162  	texp = timespec64_to_ktime(t);
1f9b37bfbb607a Andrei Vagin   2019-11-12  163  	if (flags & TIMER_ABSTIME)
1f9b37bfbb607a Andrei Vagin   2019-11-12  164  		texp = timens_ktime_to_host(which_clock, texp);
1f9b37bfbb607a Andrei Vagin   2019-11-12  165  	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
baa73d9e478ff3 Nicolas Pitre  2016-11-11  166  				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
baa73d9e478ff3 Nicolas Pitre  2016-11-11  167  				 which_clock);
baa73d9e478ff3 Nicolas Pitre  2016-11-11  168  }
baa73d9e478ff3 Nicolas Pitre  2016-11-11  169  
088d326951aa79 Andi Kleen     2017-04-09  170  __diag_push();
088d326951aa79 Andi Kleen     2017-04-09  171  __diag_ignore(GCC, 8, "-Wattribute-alias", "Alias to nonimplemented syscall");
088d326951aa79 Andi Kleen     2017-04-09  172  
baa73d9e478ff3 Nicolas Pitre  2016-11-11  173  #ifdef CONFIG_COMPAT
63a766a1780f95 Deepa Dinamani 2017-06-24  174  COMPAT_SYS_NI(timer_create);
f35deaff1b8ead Arnd Bergmann  2019-12-07  175  #endif
f35deaff1b8ead Arnd Bergmann  2019-12-07  176  
f35deaff1b8ead Arnd Bergmann  2019-12-07  177  #if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
63a766a1780f95 Deepa Dinamani 2017-06-24  178  COMPAT_SYS_NI(getitimer);
63a766a1780f95 Deepa Dinamani 2017-06-24  179  COMPAT_SYS_NI(setitimer);
b5793b0d92c95c Deepa Dinamani 2018-03-13  180  #endif
63a766a1780f95 Deepa Dinamani 2017-06-24  181  
b5793b0d92c95c Deepa Dinamani 2018-03-13  182  #ifdef CONFIG_COMPAT_32BIT_TIME
8dabe7245bbc13 Arnd Bergmann  2019-01-07 @183  SYS_NI(timer_settime32);
8dabe7245bbc13 Arnd Bergmann  2019-01-07  184  SYS_NI(timer_gettime32);
8dabe7245bbc13 Arnd Bergmann  2019-01-07  185  

:::::: The code at line 49 was first introduced by commit
:::::: baa73d9e478ff32d62f3f9422822b59dd9a95a21 posix-timers: Make them configurable

:::::: TO: Nicolas Pitre <nicolas.pitre@linaro.org>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--Bp75Z5UiYXgwP1o7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
orJ5LNea9iO3XEP+F+QEF8qQbwIA

--Bp75Z5UiYXgwP1o7--
