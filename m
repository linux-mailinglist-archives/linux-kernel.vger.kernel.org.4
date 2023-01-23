Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2D6774C0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 06:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjAWFLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 00:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjAWFLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 00:11:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DFB17CF8;
        Sun, 22 Jan 2023 21:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674450660; x=1705986660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G0T9CBQMm3M05NepIpVoxbviDZVhyd2lAZttRFNTUkc=;
  b=fG1LH4aTYxbAbPm2OtP2R4L1MVkAhxhAQlyZE4qWgSEQ5mZcdZ6qudrS
   s0dNgxjoKLMtZgJtKBGBhi6mPjZftHUwecXvAh+YNNvsAOQpQa8+5qzKw
   CZjkxDhjMO3I9HCBygGQSTPuk+w4eUT8Eqhe5M6XjnzozuEI4dD94ovvq
   UnjYWTaVf9AxoYheNop+dBZlox5lyFKgkU+cL4X/IkoGYOBIKLi50QRuo
   UEbo8Y3GPqtqXEhy999zogg3jaSKWv95UunIoLH7lfCWSWo5j+Z2QOmXV
   lvbioIK6KuKJSlTqIIvEgucOMw4tJHNFTNxs5ORvi2+/krjSS76u6YLsW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="305633840"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="305633840"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 21:11:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="692009289"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="692009289"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Jan 2023 21:10:58 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJp6f-0005RU-0e;
        Mon, 23 Jan 2023 05:10:57 +0000
Date:   Mon, 23 Jan 2023 13:10:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] thermal: int340x_thermal: Add production mode
 attribute
Message-ID: <202301231218.inlZXxdA-lkp@intel.com>
References: <20230123024040.337866-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123024040.337866-1-srinivas.pandruvada@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivas-Pandruvada/thermal-int340x_thermal-Add-production-mode-attribute/20230123-104105
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230123024040.337866-1-srinivas.pandruvada%40linux.intel.com
patch subject: [PATCH v2] thermal: int340x_thermal: Add production mode attribute
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230123/202301231218.inlZXxdA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2c4e5f536a8e523a9f48701629806ecb63346cc0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Srinivas-Pandruvada/thermal-int340x_thermal-Add-production-mode-attribute/20230123-104105
        git checkout 2c4e5f536a8e523a9f48701629806ecb63346cc0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/thermal/intel/int340x_thermal/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/intel/int340x_thermal/int3400_thermal.c:351:6: warning: no previous prototype for 'production_mode_exit' [-Wmissing-prototypes]
     351 | void production_mode_exit(struct int3400_thermal_priv *priv)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/production_mode_exit +351 drivers/thermal/intel/int340x_thermal/int3400_thermal.c

   350	
 > 351	void production_mode_exit(struct int3400_thermal_priv *priv)
   352	{
   353		if (priv->production_mode >= 0)
   354			sysfs_remove_file(&priv->pdev->dev.kobj, &dev_attr_production_mode.attr);
   355	}
   356	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
