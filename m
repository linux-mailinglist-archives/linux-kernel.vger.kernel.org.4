Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A905671EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjAROBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjAROA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:00:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A4E530C7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674048891; x=1705584891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rktdZw79cZP+azJjcZRKC/HpN/RSWY1Q9yE47uINJ+w=;
  b=X9xUZInlx0+NtLgNFL6lClyG1U7GcV3TuPVL45OiInfSwjKjY0v68piH
   4Mhjut1Np2X3Rr0L584CUwukh3l/8ZKWJkc1k8j5Hyj14P0+lzE4+GVoZ
   onKaapsUsqdPL8vpuEhEdzUd73jcrT9KWqzuq7gSXY4sA8KdPbrfJuh8u
   w5XOlirYJhJYZz0pMkY2ztALoENDnCQ4PrFuxrs4BkRr/nm+ihp65Jl6m
   WQ4qWQ+1EitVR75dkWGOu/NV8Tm57DX6k/0bvfMNCkKpwXvptbonbaPGA
   EIGU8sf3FOh7AkCe/bzgxl9GY+nBmv2YUJc95paBA6MISZX57OHY6AmBx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="411219659"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="411219659"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:34:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="988545396"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="988545396"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2023 05:34:48 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pI8aV-0000LU-1X;
        Wed, 18 Jan 2023 13:34:47 +0000
Date:   Wed, 18 Jan 2023 21:34:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [tip:irq/core 8/9] lib/group_cpus.c:43:23: warning: unused function
 'alloc_node_to_cpumask'
Message-ID: <202301182158.GgENalyU-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
head:   6a6dcae8f486c3f3298d0767d34505121c7b0b81
commit: f7b3ea8cf72f3d6060fe08e461805181e7450a13 [8/9] genirq/affinity: Move group_cpus_evenly() into lib/
config: i386-randconfig-a003-20230116 (https://download.01.org/0day-ci/archive/20230118/202301182158.GgENalyU-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=f7b3ea8cf72f3d6060fe08e461805181e7450a13
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip irq/core
        git checkout f7b3ea8cf72f3d6060fe08e461805181e7450a13
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/group_cpus.c:43:23: warning: unused function 'alloc_node_to_cpumask' [-Wunused-function]
   static cpumask_var_t *alloc_node_to_cpumask(void)
                         ^
>> lib/group_cpus.c:66:13: warning: unused function 'free_node_to_cpumask' [-Wunused-function]
   static void free_node_to_cpumask(cpumask_var_t *masks)
               ^
>> lib/group_cpus.c:75:13: warning: unused function 'build_node_to_cpumask' [-Wunused-function]
   static void build_node_to_cpumask(cpumask_var_t *masks)
               ^
>> lib/group_cpus.c:247:12: warning: unused function '__group_cpus_evenly' [-Wunused-function]
   static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
              ^
   4 warnings generated.


vim +/alloc_node_to_cpumask +43 lib/group_cpus.c

    42	
  > 43	static cpumask_var_t *alloc_node_to_cpumask(void)
    44	{
    45		cpumask_var_t *masks;
    46		int node;
    47	
    48		masks = kcalloc(nr_node_ids, sizeof(cpumask_var_t), GFP_KERNEL);
    49		if (!masks)
    50			return NULL;
    51	
    52		for (node = 0; node < nr_node_ids; node++) {
    53			if (!zalloc_cpumask_var(&masks[node], GFP_KERNEL))
    54				goto out_unwind;
    55		}
    56	
    57		return masks;
    58	
    59	out_unwind:
    60		while (--node >= 0)
    61			free_cpumask_var(masks[node]);
    62		kfree(masks);
    63		return NULL;
    64	}
    65	
  > 66	static void free_node_to_cpumask(cpumask_var_t *masks)
    67	{
    68		int node;
    69	
    70		for (node = 0; node < nr_node_ids; node++)
    71			free_cpumask_var(masks[node]);
    72		kfree(masks);
    73	}
    74	
  > 75	static void build_node_to_cpumask(cpumask_var_t *masks)
    76	{
    77		int cpu;
    78	
    79		for_each_possible_cpu(cpu)
    80			cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
    81	}
    82	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
