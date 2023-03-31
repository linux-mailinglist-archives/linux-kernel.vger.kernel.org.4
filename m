Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A9C6D15CE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCaDDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCaDD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:03:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE661204D;
        Thu, 30 Mar 2023 20:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680231806; x=1711767806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MsA0POeecZ/6JqCB8cjKEkAJwZbgcW7efgsYjItM9V8=;
  b=BIQt8sZ0SKdN+qqnd9bDBlZ9YLCQ1FhhU5SmPP0j3ORdA5oNxUmO/J0Y
   Jo3E8SbltJRKnnYHQi/7pClOZp2q8ZKTvs8Cix4+ZK3QUg9w3fPCiElvB
   1aE6oJ5CvbKZQrTRN9R7MJklgR9bDhluW1jAI0/NuuX+Pd8VT6vvdCfnb
   QOkFWeWq05jGbbr4mm33USgOg/JPdN9ERySyNIWC0049+b3YVVEjpRZxV
   QYu8YiIsgJ+nnbNeXmPeLFeH4Tob0RZ4x+pOB7NFWXEAGTKKOdaShXwDL
   z2A/ZtbG8UNgoDAPhG73I7jm6IFcwxBs7WgA3wxJr0Q5JkXxpUNIQ/dCh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="406344985"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="406344985"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:03:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="795936361"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="795936361"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2023 20:03:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pi52u-000LRg-1i;
        Fri, 31 Mar 2023 03:03:20 +0000
Date:   Fri, 31 Mar 2023 11:02:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, Raul Rangel <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v5 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Message-ID: <202303311048.UQo0skP2-lkp@intel.com>
References: <20230330194439.14361-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330194439.14361-5-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc4 next-20230330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PM-Add-a-sysfs-file-to-represent-time-spent-in-hardware-sleep-state/20230331-034714
patch link:    https://lore.kernel.org/r/20230330194439.14361-5-mario.limonciello%40amd.com
patch subject: [PATCH v5 4/4] platform/x86/intel/pmc: core: Report duration of time in HW sleep state
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20230331/202303311048.UQo0skP2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ab8a5cd564c9bd22860612acbd76477f7515ca7b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/PM-Add-a-sysfs-file-to-represent-time-spent-in-hardware-sleep-state/20230331-034714
        git checkout ab8a5cd564c9bd22860612acbd76477f7515ca7b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303311048.UQo0skP2-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/platform/x86/intel/pmc/core.c: In function 'pmc_core_is_s0ix_failed':
>> drivers/platform/x86/intel/pmc/core.c:1206:9: error: implicit declaration of function 'pm_set_hw_sleep_time' [-Werror=implicit-function-declaration]
    1206 |         pm_set_hw_sleep_time(s0ix_counter - pmcdev->s0ix_counter);
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pm_set_hw_sleep_time +1206 drivers/platform/x86/intel/pmc/core.c

  1198	
  1199	static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
  1200	{
  1201		u64 s0ix_counter;
  1202	
  1203		if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
  1204			return false;
  1205	
> 1206		pm_set_hw_sleep_time(s0ix_counter - pmcdev->s0ix_counter);
  1207	
  1208		if (s0ix_counter == pmcdev->s0ix_counter)
  1209			return true;
  1210	
  1211		return false;
  1212	}
  1213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
