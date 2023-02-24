Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D407A6A1D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBXONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXONf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:13:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED8165B1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677247974; x=1708783974;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VRrdbg90JvMh/sWg4i4ypAsOM8fNcSKwYbYz8AMKag0=;
  b=kknhS/WVU1RIN+N3A5qRYlxH2Vsz9KODt+PIPEDqAx01v2rFVWt84zkR
   b4ue9jlS/z6aw7thm+Oeb6L+6SIDJy2RkjKGkJwM8jNGJ/oZG/EuXbPiz
   gw+asKB13ZiQkKNPon+6y1tZp6Q4b/UA09Jy9u6DnZwM4xkAM9qt3H5EB
   VdleWdOovWOEjmHafdj6s+MQOHkiCmIlVaqLe2qgHGgj6il4By+ttQjOj
   FaRWWVKFJv/7qYCn1KHa6hn+ZK6bBqX4sxUEjXy/A4N5Sdcgf2a1aRkuo
   tSKOYJ9zcWJZ+AcYNBs86pPou/+td2SkqZ8nBKzHGOV2enK/AdKYFmQN9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="331218414"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="331218414"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:12:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="736810633"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="736810633"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2023 06:12:53 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVYoe-0002Sh-1b;
        Fri, 24 Feb 2023 14:12:52 +0000
Date:   Fri, 24 Feb 2023 22:12:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/rcu/refscale.c:614:24: sparse: sparse: incompatible types in
 comparison expression (different address spaces):
Message-ID: <202302242216.C9zAq2tw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2980d8d826554fa6981d621e569a453787472f8
commit: a6889becb05394255c80b62103677e3b095726a9 refscale: Add tests using SLAB_TYPESAFE_BY_RCU
date:   7 weeks ago
config: parisc-randconfig-s052-20230222 (https://download.01.org/0day-ci/archive/20230224/202302242216.C9zAq2tw-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a6889becb05394255c80b62103677e3b095726a9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a6889becb05394255c80b62103677e3b095726a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302242216.C9zAq2tw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/rcu/refscale.c:614:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/rcu/refscale.c:614:24: sparse:    struct refscale_typesafe [noderef] __rcu *
>> kernel/rcu/refscale.c:614:24: sparse:    struct refscale_typesafe *
   kernel/rcu/refscale.c:569:13: sparse: sparse: context imbalance in 'typesafe_lock_acquire' - wrong count at exit
   kernel/rcu/refscale.c:576:13: sparse: sparse: context imbalance in 'typesafe_lock_release' - unexpected unlock

vim +614 kernel/rcu/refscale.c

   595	
   596	// Do a read-side critical section with the specified delay in
   597	// microseconds and nanoseconds inserted so as to increase probability
   598	// of failure.
   599	static void typesafe_delay_section(const int nloops, const int udl, const int ndl)
   600	{
   601		unsigned int a;
   602		unsigned int b;
   603		int i;
   604		long idx;
   605		struct refscale_typesafe *rtsp;
   606		unsigned int start;
   607	
   608		for (i = nloops; i >= 0; i--) {
   609			preempt_disable();
   610			idx = torture_random(this_cpu_ptr(&refscale_rand)) % rtsarray_size;
   611			preempt_enable();
   612	retry:
   613			rcu_read_lock();
 > 614			rtsp = rcu_dereference(rtsarray[idx]);
   615			a = READ_ONCE(rtsp->a);
   616			if (!rts_acquire(rtsp, &start)) {
   617				rcu_read_unlock();
   618				goto retry;
   619			}
   620			if (a != READ_ONCE(rtsp->a)) {
   621				(void)rts_release(rtsp, start);
   622				rcu_read_unlock();
   623				goto retry;
   624			}
   625			un_delay(udl, ndl);
   626			// Remember, seqlock read-side release can fail.
   627			if (!rts_release(rtsp, start)) {
   628				rcu_read_unlock();
   629				goto retry;
   630			}
   631			b = READ_ONCE(rtsp->a);
   632			WARN_ONCE(a != b, "Re-read of ->a changed from %u to %u.\n", a, b);
   633			b = rtsp->b;
   634			rcu_read_unlock();
   635			WARN_ON_ONCE(a * a != b);
   636		}
   637	}
   638	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
