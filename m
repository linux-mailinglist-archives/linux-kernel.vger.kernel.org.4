Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7987767750D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjAWGCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWGCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:02:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537BB193FA;
        Sun, 22 Jan 2023 22:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674453722; x=1705989722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZ9nJvTOfQdGeV/OepP0vidYgTp9t+4wTJeLI0MISkg=;
  b=gJrjETg3Z1z1WA0MLzOVWklUZXDp3og8tXtZb8TtMb2CYvrFdis5d2te
   Mw5oH7ZWdGCmBMXBgCQTsXSu3QOKZkiTinIQai/8fQx3CzLQhJoWqVeu7
   EfeK16R58HYKyXXrJ60AUBbJn0INaDsZ9rq/yEjGMiEfpGJpQ1MwBwkch
   wKBumDr4agBRJj7spqXcGchx7ilKemq1aqMsY6ac1DALKiFRxLJqVxwej
   t4a+qbmrnMLZRgG6UH2oIPadVG0wV0Dwzbg78UJek0MfIVySOBQNizP1i
   WnagKabymEwvFU2GeDs3amzNj1vV8lSUVdz2PQv+atuKLYhKL5BLrx/3P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="390480642"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="390480642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 22:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="769675158"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="769675158"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jan 2023 22:01:59 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJpu2-0005Sa-0K;
        Mon, 23 Jan 2023 06:01:58 +0000
Date:   Mon, 23 Jan 2023 14:01:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] thermal: int340x_thermal: Add production mode
 attribute
Message-ID: <202301231356.x7cUwKr8-lkp@intel.com>
References: <20230123024040.337866-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123024040.337866-1-srinivas.pandruvada@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.2-rc5 next-20230120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivas-Pandruvada/thermal-int340x_thermal-Add-production-mode-attribute/20230123-104105
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230123024040.337866-1-srinivas.pandruvada%40linux.intel.com
patch subject: [PATCH v2] thermal: int340x_thermal: Add production mode attribute
config: x86_64-randconfig-a014-20230123 (https://download.01.org/0day-ci/archive/20230123/202301231356.x7cUwKr8-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2c4e5f536a8e523a9f48701629806ecb63346cc0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Srinivas-Pandruvada/thermal-int340x_thermal-Add-production-mode-attribute/20230123-104105
        git checkout 2c4e5f536a8e523a9f48701629806ecb63346cc0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/thermal/intel/int340x_thermal/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/intel/int340x_thermal/int3400_thermal.c:351:6: warning: no previous prototype for function 'production_mode_exit' [-Wmissing-prototypes]
   void production_mode_exit(struct int3400_thermal_priv *priv)
        ^
   drivers/thermal/intel/int340x_thermal/int3400_thermal.c:351:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void production_mode_exit(struct int3400_thermal_priv *priv)
   ^
   static 
   1 warning generated.


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
