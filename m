Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA959713756
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 02:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjE1A3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 20:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1A3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 20:29:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156FEAC
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685233774; x=1716769774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WJyLpbPSiq9iQbioHTmtxePZ0MD6E1ztH3GAQk12b70=;
  b=CYHYID0ToY3w05khdHEQTDxYPi86q5duyqmcYAt07u6wLeYZctmOvwEN
   yEE/0MBufATGCrp9brLwRYCudjmxpQKF/YV8BetKr2KJEvxIFPQKj4ZKw
   VbOo1fnemaG8LqbnVh2hGqIukXiTS1EwoA8USu96R7vVyZhwp0IQhBUle
   ZDFKNYBxEjdYUrjNgu1Wuc7KCtIgJMPMR5r3++qjMiW6RhKGks6GzEW0F
   uqOXhHljt1R/vYOjyoTzD1D5hQziSzMHQX6mJ0JPyKxIkaGw8/XdO/iAq
   uF4P/asCdhoCbvatbBBzMlPmE5ZDkAjBJ3ucmiWqZx/agxZK4jGGG/Cyv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="354474620"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="354474620"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 17:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="849936448"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="849936448"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2023 17:29:30 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q34Hp-000KHM-3D;
        Sun, 28 May 2023 00:29:29 +0000
Date:   Sun, 28 May 2023 08:29:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linmiaohe@huawei.com
Subject: Re: [PATCH] sched/fair: remove unneeded header files
Message-ID: <202305280847.ss7JHZEe-lkp@intel.com>
References: <20230527173727.1669047-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527173727.1669047-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaohe,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miaohe-Lin/sched-fair-remove-unneeded-header-files/20230527-174628
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20230527173727.1669047-1-linmiaohe%40huawei.com
patch subject: [PATCH] sched/fair: remove unneeded header files
config: x86_64-randconfig-a012-20230528 (https://download.01.org/0day-ci/archive/20230528/202305280847.ss7JHZEe-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/653731fdd11d1ecb757fe4b90484ef4a777fb584
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Miaohe-Lin/sched-fair-remove-unneeded-header-files/20230527-174628
        git checkout 653731fdd11d1ecb757fe4b90484ef4a777fb584
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305280847.ss7JHZEe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/fair.c:1585:7: error: implicit declaration of function 'node_is_toptier' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
               !node_is_toptier(src_nid)) {
                ^
   kernel/sched/fair.c:2844:7: error: implicit declaration of function 'node_is_toptier' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (!node_is_toptier(mem_node) &&
                ^
>> kernel/sched/fair.c:3014:8: error: implicit declaration of function 'vma_migratable' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
                        ^
>> kernel/sched/fair.c:3014:32: error: implicit declaration of function 'vma_policy_mof' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
                                                ^
>> kernel/sched/fair.c:3015:4: error: implicit declaration of function 'is_vm_hugetlb_page' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
                           ^
   kernel/sched/fair.c:6159:6: warning: no previous prototype for function 'init_cfs_bandwidth' [-Wmissing-prototypes]
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
        ^
   kernel/sched/fair.c:6159:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
   ^
   static 
   kernel/sched/fair.c:11973:6: warning: no previous prototype for function 'task_vruntime_update' [-Wmissing-prototypes]
   void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
        ^
   kernel/sched/fair.c:11973:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
   ^
   static 
   kernel/sched/fair.c:12595:6: warning: no previous prototype for function 'free_fair_sched_group' [-Wmissing-prototypes]
   void free_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:12595:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:12597:5: warning: no previous prototype for function 'alloc_fair_sched_group' [-Wmissing-prototypes]
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/fair.c:12597:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
   kernel/sched/fair.c:12602:6: warning: no previous prototype for function 'online_fair_sched_group' [-Wmissing-prototypes]
   void online_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:12602:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void online_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:12604:6: warning: no previous prototype for function 'unregister_fair_sched_group' [-Wmissing-prototypes]
   void unregister_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:12604:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   6 warnings and 5 errors generated.


vim +/node_is_toptier +1585 kernel/sched/fair.c

c959924b0dc53b Huang Ying        2022-07-13  1572  
10f39042711ba2 Rik van Riel      2014-01-27  1573  bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
10f39042711ba2 Rik van Riel      2014-01-27  1574  				int src_nid, int dst_cpu)
10f39042711ba2 Rik van Riel      2014-01-27  1575  {
cb361d8cdef699 Jann Horn         2019-07-16  1576  	struct numa_group *ng = deref_curr_numa_group(p);
10f39042711ba2 Rik van Riel      2014-01-27  1577  	int dst_nid = cpu_to_node(dst_cpu);
10f39042711ba2 Rik van Riel      2014-01-27  1578  	int last_cpupid, this_cpupid;
10f39042711ba2 Rik van Riel      2014-01-27  1579  
33024536bafd91 Huang Ying        2022-07-13  1580  	/*
33024536bafd91 Huang Ying        2022-07-13  1581  	 * The pages in slow memory node should be migrated according
33024536bafd91 Huang Ying        2022-07-13  1582  	 * to hot/cold instead of private/shared.
33024536bafd91 Huang Ying        2022-07-13  1583  	 */
33024536bafd91 Huang Ying        2022-07-13  1584  	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
33024536bafd91 Huang Ying        2022-07-13 @1585  	    !node_is_toptier(src_nid)) {
33024536bafd91 Huang Ying        2022-07-13  1586  		struct pglist_data *pgdat;
c959924b0dc53b Huang Ying        2022-07-13  1587  		unsigned long rate_limit;
c959924b0dc53b Huang Ying        2022-07-13  1588  		unsigned int latency, th, def_th;
33024536bafd91 Huang Ying        2022-07-13  1589  
33024536bafd91 Huang Ying        2022-07-13  1590  		pgdat = NODE_DATA(dst_nid);
c959924b0dc53b Huang Ying        2022-07-13  1591  		if (pgdat_free_space_enough(pgdat)) {
c959924b0dc53b Huang Ying        2022-07-13  1592  			/* workload changed, reset hot threshold */
c959924b0dc53b Huang Ying        2022-07-13  1593  			pgdat->nbp_threshold = 0;
33024536bafd91 Huang Ying        2022-07-13  1594  			return true;
c959924b0dc53b Huang Ying        2022-07-13  1595  		}
33024536bafd91 Huang Ying        2022-07-13  1596  
c959924b0dc53b Huang Ying        2022-07-13  1597  		def_th = sysctl_numa_balancing_hot_threshold;
c959924b0dc53b Huang Ying        2022-07-13  1598  		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
c959924b0dc53b Huang Ying        2022-07-13  1599  			(20 - PAGE_SHIFT);
c959924b0dc53b Huang Ying        2022-07-13  1600  		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
c959924b0dc53b Huang Ying        2022-07-13  1601  
c959924b0dc53b Huang Ying        2022-07-13  1602  		th = pgdat->nbp_threshold ? : def_th;
33024536bafd91 Huang Ying        2022-07-13  1603  		latency = numa_hint_fault_latency(page);
33024536bafd91 Huang Ying        2022-07-13  1604  		if (latency >= th)
33024536bafd91 Huang Ying        2022-07-13  1605  			return false;
33024536bafd91 Huang Ying        2022-07-13  1606  
c6833e10008f97 Huang Ying        2022-07-13  1607  		return !numa_promotion_rate_limit(pgdat, rate_limit,
c6833e10008f97 Huang Ying        2022-07-13  1608  						  thp_nr_pages(page));
33024536bafd91 Huang Ying        2022-07-13  1609  	}
33024536bafd91 Huang Ying        2022-07-13  1610  
10f39042711ba2 Rik van Riel      2014-01-27  1611  	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
37355bdc5a1298 Mel Gorman        2018-10-01  1612  	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
37355bdc5a1298 Mel Gorman        2018-10-01  1613  
33024536bafd91 Huang Ying        2022-07-13  1614  	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
33024536bafd91 Huang Ying        2022-07-13  1615  	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
33024536bafd91 Huang Ying        2022-07-13  1616  		return false;
33024536bafd91 Huang Ying        2022-07-13  1617  
37355bdc5a1298 Mel Gorman        2018-10-01  1618  	/*
37355bdc5a1298 Mel Gorman        2018-10-01  1619  	 * Allow first faults or private faults to migrate immediately early in
37355bdc5a1298 Mel Gorman        2018-10-01  1620  	 * the lifetime of a task. The magic number 4 is based on waiting for
37355bdc5a1298 Mel Gorman        2018-10-01  1621  	 * two full passes of the "multi-stage node selection" test that is
37355bdc5a1298 Mel Gorman        2018-10-01  1622  	 * executed below.
37355bdc5a1298 Mel Gorman        2018-10-01  1623  	 */
98fa15f34cb379 Anshuman Khandual 2019-03-05  1624  	if ((p->numa_preferred_nid == NUMA_NO_NODE || p->numa_scan_seq <= 4) &&
37355bdc5a1298 Mel Gorman        2018-10-01  1625  	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
37355bdc5a1298 Mel Gorman        2018-10-01  1626  		return true;
10f39042711ba2 Rik van Riel      2014-01-27  1627  
10f39042711ba2 Rik van Riel      2014-01-27  1628  	/*
10f39042711ba2 Rik van Riel      2014-01-27  1629  	 * Multi-stage node selection is used in conjunction with a periodic
10f39042711ba2 Rik van Riel      2014-01-27  1630  	 * migration fault to build a temporal task<->page relation. By using
10f39042711ba2 Rik van Riel      2014-01-27  1631  	 * a two-stage filter we remove short/unlikely relations.
10f39042711ba2 Rik van Riel      2014-01-27  1632  	 *
10f39042711ba2 Rik van Riel      2014-01-27  1633  	 * Using P(p) ~ n_p / n_t as per frequentist probability, we can equate
10f39042711ba2 Rik van Riel      2014-01-27  1634  	 * a task's usage of a particular page (n_p) per total usage of this
10f39042711ba2 Rik van Riel      2014-01-27  1635  	 * page (n_t) (in a given time-span) to a probability.
10f39042711ba2 Rik van Riel      2014-01-27  1636  	 *
10f39042711ba2 Rik van Riel      2014-01-27  1637  	 * Our periodic faults will sample this probability and getting the
10f39042711ba2 Rik van Riel      2014-01-27  1638  	 * same result twice in a row, given these samples are fully
10f39042711ba2 Rik van Riel      2014-01-27  1639  	 * independent, is then given by P(n)^2, provided our sample period
10f39042711ba2 Rik van Riel      2014-01-27  1640  	 * is sufficiently short compared to the usage pattern.
10f39042711ba2 Rik van Riel      2014-01-27  1641  	 *
10f39042711ba2 Rik van Riel      2014-01-27  1642  	 * This quadric squishes small probabilities, making it less likely we
10f39042711ba2 Rik van Riel      2014-01-27  1643  	 * act on an unlikely task<->page relation.
10f39042711ba2 Rik van Riel      2014-01-27  1644  	 */
10f39042711ba2 Rik van Riel      2014-01-27  1645  	if (!cpupid_pid_unset(last_cpupid) &&
10f39042711ba2 Rik van Riel      2014-01-27  1646  				cpupid_to_nid(last_cpupid) != dst_nid)
10f39042711ba2 Rik van Riel      2014-01-27  1647  		return false;
10f39042711ba2 Rik van Riel      2014-01-27  1648  
10f39042711ba2 Rik van Riel      2014-01-27  1649  	/* Always allow migrate on private faults */
10f39042711ba2 Rik van Riel      2014-01-27  1650  	if (cpupid_match_pid(p, last_cpupid))
10f39042711ba2 Rik van Riel      2014-01-27  1651  		return true;
10f39042711ba2 Rik van Riel      2014-01-27  1652  
10f39042711ba2 Rik van Riel      2014-01-27  1653  	/* A shared fault, but p->numa_group has not been set up yet. */
10f39042711ba2 Rik van Riel      2014-01-27  1654  	if (!ng)
10f39042711ba2 Rik van Riel      2014-01-27  1655  		return true;
10f39042711ba2 Rik van Riel      2014-01-27  1656  
10f39042711ba2 Rik van Riel      2014-01-27  1657  	/*
4142c3ebb685bb Rik van Riel      2016-01-25  1658  	 * Destination node is much more heavily used than the source
4142c3ebb685bb Rik van Riel      2016-01-25  1659  	 * node? Allow migration.
10f39042711ba2 Rik van Riel      2014-01-27  1660  	 */
4142c3ebb685bb Rik van Riel      2016-01-25  1661  	if (group_faults_cpu(ng, dst_nid) > group_faults_cpu(ng, src_nid) *
4142c3ebb685bb Rik van Riel      2016-01-25  1662  					ACTIVE_NODE_FRACTION)
10f39042711ba2 Rik van Riel      2014-01-27  1663  		return true;
10f39042711ba2 Rik van Riel      2014-01-27  1664  
10f39042711ba2 Rik van Riel      2014-01-27  1665  	/*
4142c3ebb685bb Rik van Riel      2016-01-25  1666  	 * Distribute memory according to CPU & memory use on each node,
4142c3ebb685bb Rik van Riel      2016-01-25  1667  	 * with 3/4 hysteresis to avoid unnecessary memory migrations:
4142c3ebb685bb Rik van Riel      2016-01-25  1668  	 *
4142c3ebb685bb Rik van Riel      2016-01-25  1669  	 * faults_cpu(dst)   3   faults_cpu(src)
4142c3ebb685bb Rik van Riel      2016-01-25  1670  	 * --------------- * - > ---------------
4142c3ebb685bb Rik van Riel      2016-01-25  1671  	 * faults_mem(dst)   4   faults_mem(src)
10f39042711ba2 Rik van Riel      2014-01-27  1672  	 */
4142c3ebb685bb Rik van Riel      2016-01-25  1673  	return group_faults_cpu(ng, dst_nid) * group_faults(p, src_nid) * 3 >
4142c3ebb685bb Rik van Riel      2016-01-25  1674  	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
10f39042711ba2 Rik van Riel      2014-01-27  1675  }
10f39042711ba2 Rik van Riel      2014-01-27  1676  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
