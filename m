Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AC16C7BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjCXJqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjCXJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:45:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E7B24BD3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679651112; x=1711187112;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qrWaeGkbLuk83Xu+4e9KpP7tnegmfP1xmKYlknE6a8A=;
  b=b4UEvXy03bLG0eckSzaRpBRbVnhynE38OS4f57GBU7rekhjU2FNp93p4
   H3MWgTM4CmgD0ATZRm4LkjOIkLl43hvYHZJZ2Dray/6T0XdFjpawMZloy
   +v7Hy4O1DXdHWEsW0byd4ofCAvnbaG/jjEmJ8R2y7GkLI7TOTyAK35/kH
   +BnEMkyyjItBBQwY6PczCe8fZNi0bNuVVRQqOBHma+ECrTx/9sdbeS+ib
   2Be9ZnfTjjP77TBC3kgkEnKZssITAmU4lvC5d2zkt8+NYIMLViu3pOp7S
   rvFGGQ5szd/irZ3LcYT9Sva3tu+Up60z0ZgCjtXuxOYSQTJggBeG3u1JO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341308225"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="341308225"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 02:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="660003707"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="660003707"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Mar 2023 02:45:09 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfdyu-000FBU-2W;
        Fri, 24 Mar 2023 09:45:08 +0000
Date:   Fri, 24 Mar 2023 17:44:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcu-cf.2023.03.23a 14/20] kernel/rcu/tasks.h:140:20:
 warning: 'tasks_rcu_exit_srcu' defined but not used
Message-ID: <202303241725.0RIyOS2U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcu-cf.2023.03.23a
head:   01abd52f1773d0ad92560b79bb55b48e26da06d5
commit: fd18a19e0cef4deac7fb327209443a851355653a [14/20] srcu: Move work-scheduling fields from srcu_struct to srcu_usage
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20230324/202303241725.0RIyOS2U-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=fd18a19e0cef4deac7fb327209443a851355653a
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu srcu-cf.2023.03.23a
        git checkout fd18a19e0cef4deac7fb327209443a851355653a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241725.0RIyOS2U-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/srcu.h:49,
                    from include/linux/notifier.h:16,
                    from arch/x86/include/asm/uprobes.h:13,
                    from include/linux/uprobes.h:49,
                    from include/linux/mm_types.h:16,
                    from include/linux/sched/signal.h:13,
                    from kernel/rcu/update.c:26:
>> kernel/rcu/tasks.h:140:20: warning: 'tasks_rcu_exit_srcu' defined but not used [-Wunused-variable]
     140 | DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
         |                    ^~~~~~~~~~~~~~~~~~~
   include/linux/srcutree.h:171:38: note: in definition of macro '__DEFINE_SRCU'
     171 |         is_static struct srcu_struct name =                                                     \
         |                                      ^~~~
   kernel/rcu/tasks.h:140:1: note: in expansion of macro 'DEFINE_STATIC_SRCU'
     140 | DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
         | ^~~~~~~~~~~~~~~~~~


vim +/tasks_rcu_exit_srcu +140 kernel/rcu/tasks.h

07e105158d97b4 Paul E. McKenney 2020-03-02  138  
eacd6f04a13331 Paul E. McKenney 2020-03-02  139  /* Track exiting tasks in order to allow them to be waited for. */
eacd6f04a13331 Paul E. McKenney 2020-03-02 @140  DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
eacd6f04a13331 Paul E. McKenney 2020-03-02  141  

:::::: The code at line 140 was first introduced by commit
:::::: eacd6f04a1333187dd3e96e5635c0edce0a2e354 rcu-tasks: Move Tasks RCU to its own file

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
