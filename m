Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7F56A77FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCAXs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCAXsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:48:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FFD4EEA;
        Wed,  1 Mar 2023 15:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677714523; x=1709250523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=438mUqu27Pg/8R7tElJ2t97iI5443sfkue+J0vJ5gNg=;
  b=QHr2xfOXiqxXREcERzwCmn5qwmAlVMwFBKWmyBUlFgsyMRrL+nDSHMrH
   ddluhJ2+i5+ch/jW5BGc0FGec+1WZdb6J8nt70Al13rVmBa1DxKa3zwwh
   w48jvOoz73PEvzqu/4TI4vnLZ70LzDgrdVIhNdLSg26bqO6hBugT2TUix
   +yP0Oa/ucyBB35aXLWG8bH8oKpsDxUZ8DgeG2eidunD73dfrMCwjRH3dA
   X5uBLJlwvZKy7hFE2MMKE7yy+1z0WjZ1ktLDvnC6Idulu0tc9FEr+k8Mk
   PdLpZ46/11V6p42Y3R8OgwI8n2qHqJNtFPzeOVLbyiltManmV68NN6hDn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="322831141"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="322831141"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:48:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="798604515"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="798604515"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2023 15:48:39 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXWBa-0006Vf-2d;
        Wed, 01 Mar 2023 23:48:38 +0000
Date:   Thu, 2 Mar 2023 07:48:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Pavlu <petr.pavlu@suse.com>, rafael@kernel.org,
        lenb@kernel.org, viresh.kumar@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, pmladek@suse.com, mcgrof@kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [PATCH v3] ACPI: cpufreq: use a platform device to load ACPI PPC
 and PCC drivers
Message-ID: <202303020759.pwVPib0p-lkp@intel.com>
References: <20230301085717.10411-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301085717.10411-1-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.2 next-20230301]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Pavlu/ACPI-cpufreq-use-a-platform-device-to-load-ACPI-PPC-and-PCC-drivers/20230301-165927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230301085717.10411-1-petr.pavlu%40suse.com
patch subject: [PATCH v3] ACPI: cpufreq: use a platform device to load ACPI PPC and PCC drivers
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230302/202303020759.pwVPib0p-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/59eb26f9b02165cc5c5fb6514ff4d2a8d7a91356
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Petr-Pavlu/ACPI-cpufreq-use-a-platform-device-to-load-ACPI-PPC-and-PCC-drivers/20230301-165927
        git checkout 59eb26f9b02165cc5c5fb6514ff4d2a8d7a91356
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303020759.pwVPib0p-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/acpi_processor.c:177:13: warning: no previous prototype for 'acpi_pcc_cpufreq_init' [-Wmissing-prototypes]
     177 | void __init acpi_pcc_cpufreq_init(void) {}
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +/acpi_pcc_cpufreq_init +177 drivers/acpi/acpi_processor.c

   162	
   163	#ifdef CONFIG_X86
   164	/* Check presence of Processor Clocking Control by searching for \_SB.PCCH. */
   165	void __init acpi_pcc_cpufreq_init(void)
   166	{
   167		acpi_status status;
   168		acpi_handle handle;
   169	
   170		status = acpi_get_handle(NULL, "\\_SB", &handle);
   171		if (ACPI_FAILURE(status))
   172			return;
   173		if (acpi_has_method(handle, "PCCH"))
   174			cpufreq_add_device("pcc-cpufreq");
   175	}
   176	#else
 > 177	void __init acpi_pcc_cpufreq_init(void) {}
   178	#endif /* CONFIG_X86 */
   179	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
