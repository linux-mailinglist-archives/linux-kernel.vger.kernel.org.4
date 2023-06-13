Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80E572DEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbjFMKKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjFMKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:09:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84805E6;
        Tue, 13 Jun 2023 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686650997; x=1718186997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2VSwRPSkxIPkkO43q2Odc9trSs0HhJfKrbzg/FdIwSU=;
  b=BUdxGZNo07AJTCZYdjrAk+WF/bnVKlDsXKF7xlpLdWdcgvUQ2lcg5xzw
   L1fB5vBJB+c7qyl+989X4n25bxpLo/+zAG6155PHGdG2Khz4cyi2RM0AZ
   RtcwONm4069CevfyUnFxSjq4gkhmw1QBYG+5dEtMfMv9RmCjv1tjjjcTE
   ONYBYHKHdxKhReaMTnXDjkMREgNwJVtis18nRsN2b0/XuAD0npnpdoNs4
   99IuSqPQOw3ZWhA5vD5V8Ds0DXYFzEysUV46JmPGE7id9pwW0sqlT6gsA
   6yXHqd9P8PH+NYR9/oHW4msSGop+T3b8UolRP/k+dSdMnLzD//5dY9+8z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358285070"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="358285070"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 03:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="711582141"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="711582141"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 03:09:48 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q90yB-0001Dq-1D;
        Tue, 13 Jun 2023 10:09:47 +0000
Date:   Tue, 13 Jun 2023 18:09:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devel@acpica.org,
        Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
        Wyes Karny <Wyes.Karny@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: Use the
 acpi_pm_profile_server() symbol
Message-ID: <202306131736.HZQ9caR6-lkp@intel.com>
References: <20230605151133.2615-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605151133.2615-5-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v6.4-rc6 next-20230613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-CPPC-Add-a-symbol-to-check-if-the-preferred-profile-is-a-server/20230605-231602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230605151133.2615-5-mario.limonciello%40amd.com
patch subject: [PATCH 4/4] cpufreq: intel_pstate: Use the acpi_pm_profile_server() symbol
config: i386-buildonly-randconfig-r006-20230612 (https://download.01.org/0day-ci/archive/20230613/202306131736.HZQ9caR6-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch rafael-pm linux-next
        git checkout rafael-pm/linux-next
        b4 shazam https://lore.kernel.org/r/20230605151133.2615-5-mario.limonciello@amd.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306131736.HZQ9caR6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cpufreq/intel_pstate.c:2397:8: error: call to undeclared function 'acpi_pm_profile_server'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                           if (acpi_pm_profile_server())
                               ^
   1 error generated.


vim +/acpi_pm_profile_server +2397 drivers/cpufreq/intel_pstate.c

  2376	
  2377	static int intel_pstate_init_cpu(unsigned int cpunum)
  2378	{
  2379		struct cpudata *cpu;
  2380	
  2381		cpu = all_cpu_data[cpunum];
  2382	
  2383		if (!cpu) {
  2384			cpu = kzalloc(sizeof(*cpu), GFP_KERNEL);
  2385			if (!cpu)
  2386				return -ENOMEM;
  2387	
  2388			WRITE_ONCE(all_cpu_data[cpunum], cpu);
  2389	
  2390			cpu->cpu = cpunum;
  2391	
  2392			cpu->epp_default = -EINVAL;
  2393	
  2394			if (hwp_active) {
  2395				intel_pstate_hwp_enable(cpu);
  2396	
> 2397				if (acpi_pm_profile_server())
  2398					hwp_boost = true;
  2399			}
  2400		} else if (hwp_active) {
  2401			/*
  2402			 * Re-enable HWP in case this happens after a resume from ACPI
  2403			 * S3 if the CPU was offline during the whole system/resume
  2404			 * cycle.
  2405			 */
  2406			intel_pstate_hwp_reenable(cpu);
  2407		}
  2408	
  2409		cpu->epp_powersave = -EINVAL;
  2410		cpu->epp_policy = 0;
  2411	
  2412		intel_pstate_get_cpu_pstates(cpu);
  2413	
  2414		pr_debug("controlling: cpu %d\n", cpunum);
  2415	
  2416		return 0;
  2417	}
  2418	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
