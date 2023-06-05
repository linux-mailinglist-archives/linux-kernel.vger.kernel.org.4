Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D210C722E6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjFESPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjFESPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:15:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDEAD3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988943; x=1717524943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=huUH1HR4fszCoZuJr8Gz9MUwSwCUYWIuZ3BKksRCNQE=;
  b=dKKaJmAs+L2sbIwH93ay/lVFGah+HyrtOwU1BnNd10WCPabGe7yfd3gt
   cg8gskXNxoAZI83uMoFA/FuQKszKiXAOAl4Rg0YlYf4lgtiNV9HrMTNMM
   hxbaGvHeiC0IrDYukNefgwSivmbnrFH/YzdcFluaeqZI8BytjdCsuBCNc
   eZdBQ+4DFMoThke980wH0wycTftKG/4O5LK6fLN7V+n2Y4nYsg2xcCTrL
   GXb2dJeVnNQ5Cde1ffHZJsH3aDvpL/CP1a3xuM9+2GANIkk/jtqK9oolB
   2Le1cmPah564F3mi3mopZG0gUjpcu0i29f4hESklTmAhXli9740BEPjFh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="355295416"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="355295416"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:15:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="778658998"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="778658998"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2023 11:15:17 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6Ejc-0004Kd-2R;
        Mon, 05 Jun 2023 18:15:16 +0000
Date:   Tue, 6 Jun 2023 02:14:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [tip:timers/core 19/21] kernel/time/posix-timers.c:385:18: error:
 use of undeclared identifier 'TICK_NSECS'
Message-ID: <202306060236.yHWiRzTI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
head:   1263a2a9d71bac5ffabf9603c36e36cb6edbcdcf
commit: 63dede13d09850a8ace210f8e4227ac5a6b309ae [19/21] posix-timers: Clarify posix_timer_fn() comments
config: hexagon-randconfig-r036-20230605 (https://download.01.org/0day-ci/archive/20230606/202306060236.yHWiRzTI-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=63dede13d09850a8ace210f8e4227ac5a6b309ae
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip timers/core
        git checkout 63dede13d09850a8ace210f8e4227ac5a6b309ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306060236.yHWiRzTI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/time/posix-timers.c:13:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/time/posix-timers.c:13:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/time/posix-timers.c:13:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> kernel/time/posix-timers.c:385:18: error: use of undeclared identifier 'TICK_NSECS'
                                   ktime_t kj = TICK_NSECS;
                                                ^
   6 warnings and 1 error generated.


vim +/TICK_NSECS +385 kernel/time/posix-timers.c

   327	
   328	/*
   329	 * This function gets called when a POSIX.1b interval timer expires from
   330	 * the HRTIMER interrupt (soft interrupt on RT kernels).
   331	 *
   332	 * Handles CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME and CLOCK_TAI
   333	 * based timers.
   334	 */
   335	static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
   336	{
   337		struct k_itimer *timr;
   338		unsigned long flags;
   339		int si_private = 0;
   340		enum hrtimer_restart ret = HRTIMER_NORESTART;
   341	
   342		timr = container_of(timer, struct k_itimer, it.real.timer);
   343		spin_lock_irqsave(&timr->it_lock, flags);
   344	
   345		timr->it_active = 0;
   346		if (timr->it_interval != 0)
   347			si_private = ++timr->it_requeue_pending;
   348	
   349		if (posix_timer_event(timr, si_private)) {
   350			/*
   351			 * The signal was not queued due to SIG_IGN. As a
   352			 * consequence the timer is not going to be rearmed from
   353			 * the signal delivery path. But as a real signal handler
   354			 * can be installed later the timer must be rearmed here.
   355			 */
   356			if (timr->it_interval != 0) {
   357				ktime_t now = hrtimer_cb_get_time(timer);
   358	
   359				/*
   360				 * FIXME: What we really want, is to stop this
   361				 * timer completely and restart it in case the
   362				 * SIG_IGN is removed. This is a non trivial
   363				 * change to the signal handling code.
   364				 *
   365				 * For now let timers with an interval less than a
   366				 * jiffie expire every jiffie and recheck for a
   367				 * valid signal handler.
   368				 *
   369				 * This avoids interrupt starvation in case of a
   370				 * very small interval, which would expire the
   371				 * timer immediately again.
   372				 *
   373				 * Moving now ahead of time by one jiffie tricks
   374				 * hrtimer_forward() to expire the timer later,
   375				 * while it still maintains the overrun accuracy
   376				 * for the price of a slight inconsistency in the
   377				 * timer_gettime() case. This is at least better
   378				 * than a timer storm.
   379				 *
   380				 * Only required when high resolution timers are
   381				 * enabled as the periodic tick based timers are
   382				 * automatically aligned to the next tick.
   383				 */
   384				if (IS_ENABLED(CONFIG_HIGHRES_TIMERS)) {
 > 385					ktime_t kj = TICK_NSECS;
   386	
   387					if (timr->it_interval < kj)
   388						now = ktime_add(now, kj);
   389				}
   390	
   391				timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
   392				ret = HRTIMER_RESTART;
   393				++timr->it_requeue_pending;
   394				timr->it_active = 1;
   395			}
   396		}
   397	
   398		unlock_timer(timr, flags);
   399		return ret;
   400	}
   401	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
