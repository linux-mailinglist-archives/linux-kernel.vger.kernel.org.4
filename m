Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7CF5BF1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiIUADm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiIUADe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:03:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156A461B20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663718612; x=1695254612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rQ+iFKkuQtEcheUC1jaDcNruGi7AmbNVjbER7qSv6cc=;
  b=B4cc9dAK+OTTW8K36x8uLVrzn6gMbFssSuG4pacSLLj9klV5FKlJkJAu
   UMBR03yegO/+n5/WFQOTaQuFXuCNheq5M2t/2dkQSv9FhxtwuQd7Y+s+D
   ZlHP2QgHZco5JWYf13prhlAqae6RsLnMmmQKNWu/yWtsF+6p3ytCuBRhY
   dbPxUH5dAHOY6ZXQ7xwaz3JahCTOLm8c+ixHlywCXXSTdR3EYslINZ5LS
   o2vF0sNCEunM2NUUb/r+tTe9x4LW9eAC7+wC2K8PJOkSTd67quRIjNxLj
   +tyHyNSgS7uLLz2Uwnnz9W0AblGAk/kZPuAbEc+Lcl6FQBGWTcLUCsGkA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="386138266"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="386138266"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 17:03:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="570299184"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Sep 2022 17:03:30 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oanD7-00033c-1r;
        Wed, 21 Sep 2022 00:03:29 +0000
Date:   Wed, 21 Sep 2022 08:03:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nathan:wip/i915-kcfi 1/1]
 drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:441:1: warning: data definition
 has no type or storage class
Message-ID: <202209210813.ckU6XX3t-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git wip/i915-kcfi
head:   5aed167ba402539d4fb1c48c7c7801569feaf0d5
commit: 5aed167ba402539d4fb1c48c7c7801569feaf0d5 [1/1] WIP: drm/i915: Fix CFI violation
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220921/202209210813.ckU6XX3t-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git/commit/?id=5aed167ba402539d4fb1c48c7c7801569feaf0d5
        git remote add nathan https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git
        git fetch --no-tags nathan wip/i915-kcfi
        git checkout 5aed167ba402539d4fb1c48c7c7801569feaf0d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/ drivers/mtd/nand/raw/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:441:1: warning: data definition has no type or storage class
     441 | INTEL_GT_ATTR_RO(vlv_rpe_freq_mhz);
         | ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:441:1: error: type defaults to 'int' in declaration of 'INTEL_GT_ATTR_RO' [-Werror=implicit-int]
>> drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:441:1: warning: parameter names (without types) in function declaration
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:499:1: warning: data definition has no type or storage class
     499 | INTEL_GT_ATTR_RO(punit_req_freq_mhz);
         | ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:499:1: error: type defaults to 'int' in declaration of 'INTEL_GT_ATTR_RO' [-Werror=implicit-int]
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:499:1: warning: parameter names (without types) in function declaration
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:511:10: error: 'attr_punit_req_freq_mhz' undeclared here (not in a function); did you mean 'attr_rps_RPn_freq_mhz'?
     511 |         &attr_punit_req_freq_mhz.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~
         |          attr_rps_RPn_freq_mhz
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:678:1: warning: data definition has no type or storage class
     678 | INTEL_GT_ATTR_RW(media_freq_factor);
         | ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:678:1: error: type defaults to 'int' in declaration of 'INTEL_GT_ATTR_RW' [-Werror=implicit-int]
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:678:1: warning: parameter names (without types) in function declaration
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:681:1: warning: data definition has no type or storage class
     681 | INTEL_GT_ATTR_RO(media_RP0_freq_mhz);
         | ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:681:1: error: type defaults to 'int' in declaration of 'INTEL_GT_ATTR_RO' [-Werror=implicit-int]
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:681:1: warning: parameter names (without types) in function declaration
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:682:1: warning: data definition has no type or storage class
     682 | INTEL_GT_ATTR_RO(media_RPn_freq_mhz);
         | ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:682:1: error: type defaults to 'int' in declaration of 'INTEL_GT_ATTR_RO' [-Werror=implicit-int]
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:682:1: warning: parameter names (without types) in function declaration
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:685:10: error: 'attr_media_freq_factor' undeclared here (not in a function); did you mean 'attr_media_freq_factor_scale'?
     685 |         &attr_media_freq_factor.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~
         |          attr_media_freq_factor_scale
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:687:10: error: 'attr_media_RP0_freq_mhz' undeclared here (not in a function); did you mean 'attr_rps_RP0_freq_mhz'?
     687 |         &attr_media_RP0_freq_mhz.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~
         |          attr_rps_RP0_freq_mhz
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:688:10: error: 'attr_media_RPn_freq_mhz' undeclared here (not in a function); did you mean 'attr_rps_RPn_freq_mhz'?
     688 |         &attr_media_RPn_freq_mhz.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~
         |          attr_rps_RPn_freq_mhz
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function 'intel_sysfs_rps_init':
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:705:48: error: 'attr_vlv_rpe_freq_mhz' undeclared (first use in this function); did you mean 'attr_rps_RPn_freq_mhz'?
     705 |                 ret = sysfs_create_file(kobj, &attr_vlv_rpe_freq_mhz.attr);
         |                                                ^~~~~~~~~~~~~~~~~~~~~
         |                                                attr_rps_RPn_freq_mhz
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:705:48: note: each undeclared identifier is reported only once for each function it appears in
   At top level:
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:657:16: warning: 'media_RPn_freq_mhz_show' defined but not used [-Wunused-function]
     657 | static ssize_t media_RPn_freq_mhz_show(struct kobject *kobj,
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:636:16: warning: 'media_RP0_freq_mhz_show' defined but not used [-Wunused-function]
     636 | static ssize_t media_RP0_freq_mhz_show(struct kobject *kobj,
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:607:16: warning: 'media_freq_factor_store' defined but not used [-Wunused-function]
     607 | static ssize_t media_freq_factor_store(struct kobject *kobj,
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:576:16: warning: 'media_freq_factor_show' defined but not used [-Wunused-function]
     576 | static ssize_t media_freq_factor_show(struct kobject *kobj,
         |                ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:461:16: warning: 'punit_req_freq_mhz_show' defined but not used [-Wunused-function]
     461 | static ssize_t punit_req_freq_mhz_show(struct kobject *kobj,
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:401:16: warning: 'vlv_rpe_freq_mhz_show' defined but not used [-Wunused-function]
     401 | static ssize_t vlv_rpe_freq_mhz_show(struct kobject *kobj,
         |                ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +441 drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c

   440	
 > 441	INTEL_GT_ATTR_RO(vlv_rpe_freq_mhz);
   442	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
