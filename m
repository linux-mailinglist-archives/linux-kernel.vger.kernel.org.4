Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09E871F930
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjFBEPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjFBEPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:15:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213B2132
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685679308; x=1717215308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+85O83t+A0SbLQMxZLuPU0V+48P+xUBthI9YDZWZAVM=;
  b=VTvug+R/80b+dQILPx/3o6ZzYL7arEbq5d1fqDQY0Jhb57fNsS3oU4Pa
   Ql3Gjl5HbB2LBEzEg4+9VPXb8mxQNK8ogIKsgdxiiifAaAZ/Ij1HNS8Tl
   s9tvTX+/JE5+aNOIVw2IWd9I6HF2IpKZtK/0TfTBgGYOWVeo1/9WfT0nt
   jcAVvnZkPvjo/E0LxyKizhH0YUGbmYSZJeY4sC3hMwH2/qdMqgZJ6XFy2
   NnXS4TALFszzRW9/yUqLFZDFV0zjCwuY6ENbce8ya50K51wiLqfuMN3Y+
   ejRPvJ9I57kuNW09SltIPFmZeHUCmtKWBsN+5ghvnwBP1SoGePjfWTL6c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="340388515"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="340388515"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 21:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707667252"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="707667252"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2023 21:15:06 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4wBt-00003R-25;
        Fri, 02 Jun 2023 04:15:05 +0000
Date:   Fri, 2 Jun 2023 12:14:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:sched/core 23/24] kernel/sched/fair.c:7037:41: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202306021231.y2x3NdMC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   52c3a18973d0cb30586d8b316b7dc56b141a32b5
commit: c5214e13ad60bd0022bab45cbac2c9db6bc1e0d4 [23/24] sched/fair: Multi-LLC select_idle_sibling()
config: parisc-randconfig-s032-20230531 (https://download.01.org/0day-ci/archive/20230602/202306021231.y2x3NdMC-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=c5214e13ad60bd0022bab45cbac2c9db6bc1e0d4
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip sched/core
        git checkout c5214e13ad60bd0022bab45cbac2c9db6bc1e0d4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306021231.y2x3NdMC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/fair.c:939:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity const *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:939:34: sparse:     expected struct sched_entity const *se
   kernel/sched/fair.c:939:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:11842:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11842:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:11842:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:5566:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:5566:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:5566:22: sparse:    struct task_struct *
>> kernel/sched/fair.c:7037:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:7037:41: sparse:     expected struct sched_domain *parent
   kernel/sched/fair.c:7037:41: sparse:     got struct sched_domain [noderef] __rcu *parent
>> kernel/sched/fair.c:7049:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu * @@
   kernel/sched/fair.c:7049:52: sparse:     expected struct sched_domain *sd
   kernel/sched/fair.c:7049:52: sparse:     got struct sched_domain [noderef] __rcu *
   kernel/sched/fair.c:7515:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:7515:20: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:7515:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:7717:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:7717:9: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/fair.c:7717:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:7894:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7894:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7894:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:8192:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8192:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:8192:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:9182:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:9182:40: sparse:     expected struct sched_domain *child
   kernel/sched/fair.c:9182:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:9724:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:9724:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:9724:22: sparse:    struct task_struct *
   kernel/sched/fair.c:11114:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11114:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:11114:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:10773:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *sd_parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10773:44: sparse:     expected struct sched_domain *sd_parent
   kernel/sched/fair.c:10773:44: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:11210:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11210:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:11210:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:6770:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:6770:28: sparse:     expected struct sched_domain *sd
   kernel/sched/fair.c:6770:28: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:6776:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:6776:28: sparse:     expected struct sched_domain *sd
   kernel/sched/fair.c:6776:28: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:6783:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:6783:28: sparse:     expected struct sched_domain *sd
   kernel/sched/fair.c:6783:28: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:6791:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:6791:17: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/fair.c:6791:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2245:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2245:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2245:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2083:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2083:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2083:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2083:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2083:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2083:25: sparse:    struct task_struct *

vim +7037 kernel/sched/fair.c

  7029	
  7030	/*
  7031	 * For the multiple-LLC per node case, make sure to try the other LLC's if the
  7032	 * local LLC comes up empty.
  7033	 */
  7034	static int
  7035	select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
  7036	{
> 7037		struct sched_domain *parent = sd->parent;
  7038		struct sched_group *sg;
  7039	
  7040		/* Make sure to not cross nodes. */
  7041		if (!parent || parent->flags & SD_NUMA)
  7042			return -1;
  7043	
  7044		sg = parent->groups;
  7045		do {
  7046			int cpu = cpumask_first(sched_group_span(sg));
  7047	
  7048			if (!cpus_share_cache(cpu, target)) {
> 7049				int i = select_idle_cpu(p, per_cpu(sd_llc, cpu),
  7050							test_idle_cores(cpu), cpu);
  7051				if ((unsigned)i < nr_cpumask_bits)
  7052					return i;
  7053			}
  7054	
  7055			sg = sg->next;
  7056		} while (sg != parent->groups);
  7057	
  7058		return -1;
  7059	}
  7060	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
