Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2926BFFAA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCSHHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCSHHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:07:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985801D906
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679209632; x=1710745632;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AplSUTnrHkMziVAt34I92HYbNz8T2xSeGrhmgorAR1Y=;
  b=I3mkOgMZCEeWv6S0hOSHEL6vlIJeJ7xhFlOW1atd6yw50I2B7jFJ7HEK
   8BD6k618KJFN4uW2ZdDEqvhYAeA/Szk7sM/m0pxKQinWKTI7ry2Qzh/Fq
   PAVY/BZHHYS+q2wqOysy7oN5i7hAEJcPFJU7TWmidMoLK6iHw0L5jMbMc
   bm9qfm4t/iwf9iLVLgfb+Y1PxH7eanoSoasvqEF0v1oRCpjOigP2HuRKN
   UnIgatB9lhIBRPGJBHfiluVqib8Kjvw51kU93YVwIWdDz1VYWcFZIy0yB
   wJmqeJ8oJxJDMZHlf7gJMkaONSox6TeQqJNzpoRoqgGndOlrsVDjROjSD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338508595"
X-IronPort-AV: E=Sophos;i="5.98,273,1673942400"; 
   d="scan'208";a="338508595"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 00:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="713198539"
X-IronPort-AV: E=Sophos;i="5.98,273,1673942400"; 
   d="scan'208";a="713198539"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2023 00:06:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdn7C-000ARW-1e;
        Sun, 19 Mar 2023 07:06:02 +0000
Date:   Sun, 19 Mar 2023 15:05:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.17a 33/38] kernel/rcu/tasks.h:140:20:
 warning: 'tasks_rcu_exit_srcu' defined but not used
Message-ID: <202303191536.XzMSyzTl-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.17a
head:   19d218a4b125a4dce12eb88097a9c55f7126ce8c
commit: 61eea4556e8cf92d4c9b483110a679d2652aa451 [33/38] srcu: Move work-scheduling fields from srcu_struct to srcu_usage
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230319/202303191536.XzMSyzTl-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=61eea4556e8cf92d4c9b483110a679d2652aa451
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2023.03.17a
        git checkout 61eea4556e8cf92d4c9b483110a679d2652aa451
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303191536.XzMSyzTl-lkp@intel.com/

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
   include/linux/srcutree.h:184:38: note: in definition of macro '__DEFINE_SRCU'
     184 |         is_static struct srcu_struct name =                                                     \
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
