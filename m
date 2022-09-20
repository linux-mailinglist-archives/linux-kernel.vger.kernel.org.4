Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90E05BEF66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiITVvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiITVvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:51:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BDB2AE2E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663710670; x=1695246670;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5O/mf2Gr+8mcBeRa2e75wK7Og6q7isYIGWCuIH7kD+A=;
  b=f5P2wKrJse5QBnSuouoGyRYTdW+G0Ot3RmbOKYSXfYHi22Dlbty9Bk9h
   ruh6jQEKpvJM7cI8pfXLwKeBvPOg/ZI/59l9g0w/f4OezcRY5oMHsY11m
   jOdnvJPHLc+DA5XPLCJtIsRnGKMrTiSRKO3FiVhGVDQjcat0v8xDTDQqD
   x1yiSR9iEJO7E44gZ829yilu/JUs7xNLDpddowze1N3AW0gDPqcFQWq+8
   isZxshL2144SXU++ysokIDvcAFMOJKc6ww3khVhTtFfrdivoFKUlKjxZ1
   4G+MvfIz1VgsFYcSia7LlGesy3iodkME8en88hwcp+kc9yu7OwjKQ8GxI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="386113998"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="386113998"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 14:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="687595296"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2022 14:51:09 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oal92-0002zZ-1q;
        Tue, 20 Sep 2022 21:51:08 +0000
Date:   Wed, 21 Sep 2022 05:50:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>
Subject: [jirislaby:lto 17/49] drivers/cpufreq/amd-pstate.c:127:22: warning:
 no previous prototype for 'do_amd_pstate_enable'
Message-ID: <202209210551.0tYWREPo-lkp@intel.com>
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

Hi Andi,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   b8aca9a738ed75e571b2f9a761b8a9896c686a48
commit: bf37a9b27bd9b38b18a7f385f9163603f20043de [17/49] cpufreq, amd-pstate, lto: make static calls __visible_on_lto
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220921/202209210551.0tYWREPo-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=bf37a9b27bd9b38b18a7f385f9163603f20043de
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout bf37a9b27bd9b38b18a7f385f9163603f20043de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:127:22: warning: no previous prototype for 'do_amd_pstate_enable' [-Wmissing-prototypes]
     127 | __visible_on_lto int do_amd_pstate_enable(bool enable)
         |                      ^~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/amd-pstate.c:152:22: warning: no previous prototype for 'do_amd_pstate_init_perf' [-Wmissing-prototypes]
     152 | __visible_on_lto int do_amd_pstate_init_perf(struct amd_cpudata *cpudata)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/amd-pstate.c:200:23: warning: no previous prototype for 'do_amd_pstate_update_perf' [-Wmissing-prototypes]
     200 | __visible_on_lto void do_amd_pstate_update_perf(struct amd_cpudata *cpudata,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/do_amd_pstate_enable +127 drivers/cpufreq/amd-pstate.c

   126	
 > 127	__visible_on_lto int do_amd_pstate_enable(bool enable)
   128	{
   129		return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
   130	}
   131	
   132	static int cppc_enable(bool enable)
   133	{
   134		int cpu, ret = 0;
   135	
   136		for_each_present_cpu(cpu) {
   137			ret = cppc_set_enable(cpu, enable);
   138			if (ret)
   139				return ret;
   140		}
   141	
   142		return ret;
   143	}
   144	
   145	DEFINE_STATIC_CALL(amd_pstate_enable, do_amd_pstate_enable);
   146	
   147	static inline int amd_pstate_enable(bool enable)
   148	{
   149		return static_call(amd_pstate_enable)(enable);
   150	}
   151	
 > 152	__visible_on_lto int do_amd_pstate_init_perf(struct amd_cpudata *cpudata)
   153	{
   154		u64 cap1;
   155	
   156		int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
   157					     &cap1);
   158		if (ret)
   159			return ret;
   160	
   161		/*
   162		 * TODO: Introduce AMD specific power feature.
   163		 *
   164		 * CPPC entry doesn't indicate the highest performance in some ASICs.
   165		 */
   166		WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
   167	
   168		WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
   169		WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
   170		WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
   171	
   172		return 0;
   173	}
   174	
   175	static int cppc_init_perf(struct amd_cpudata *cpudata)
   176	{
   177		struct cppc_perf_caps cppc_perf;
   178	
   179		int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
   180		if (ret)
   181			return ret;
   182	
   183		WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
   184	
   185		WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
   186		WRITE_ONCE(cpudata->lowest_nonlinear_perf,
   187			   cppc_perf.lowest_nonlinear_perf);
   188		WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
   189	
   190		return 0;
   191	}
   192	
   193	DEFINE_STATIC_CALL(amd_pstate_init_perf, do_amd_pstate_init_perf);
   194	
   195	static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
   196	{
   197		return static_call(amd_pstate_init_perf)(cpudata);
   198	}
   199	
 > 200	__visible_on_lto void do_amd_pstate_update_perf(struct amd_cpudata *cpudata,
   201				       u32 min_perf, u32 des_perf, u32 max_perf,
   202				       bool fast_switch)
   203	{
   204		if (fast_switch)
   205			wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
   206		else
   207			wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
   208				      READ_ONCE(cpudata->cppc_req_cached));
   209	}
   210	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
