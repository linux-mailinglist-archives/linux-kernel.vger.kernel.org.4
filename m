Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785676ADD0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCGLOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCGLNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:13:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE43D769CD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678187525; x=1709723525;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HmDpjR8h4i/+lk/Jyvs9+lkMOc/t/BKDdsmK6+Y3PA8=;
  b=EQsbLR74dJN8ghve877N9TeuDA6wffXHeq8rECrd8etK2ZZwK+jIcGJJ
   Q9x8jSndf+NWFfhlS27cLor+KXEy0GeUoNL+kaA2FLL9DWirtkMfadyAE
   B+Lcyi0AwfFR36RmZeZkC6bSOCmo1KUVbl9CKZD8vkM3UggrCiZzXjWoy
   +E0iFSg4i3a0nPydHA80ojpjJXpxDq11FBHuy/vZpQ8UYfO7Tq6o01/O0
   3XrdQWCyieO/AvSvfn83KwOvU6gYzzXQoD/J3oVRyBSS8b9+eqeS4LevA
   TlgsQRiyoLhG7eWmZ4dZhAIouBl2bZLXrLUOcOA51tw/IZv/mcyhK0o/y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="337343125"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="337343125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 03:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="786666543"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="786666543"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Mar 2023 03:12:02 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZVEf-0001Fn-2d;
        Tue, 07 Mar 2023 11:12:01 +0000
Date:   Tue, 7 Mar 2023 19:11:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chia-I Wu <olvaffe@gmail.com>
Subject: kismet: WARNING: unmet direct dependencies detected for
 DEVFREQ_GOV_SIMPLE_ONDEMAND when selected by DRM_MSM
Message-ID: <202303071922.wJqDWQpe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ca09d5fa3549d142c2080a72a4c70ce389163cd
commit: 6563f60f14cbb3dcbdc4e1d8469fc0fbaaa80544 drm/msm/gpu: Add devfreq tuning debugfs
date:   7 weeks ago
config: csky-kismet-CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND-CONFIG_DRM_MSM-0-0 (https://download.01.org/0day-ci/archive/20230307/202303071922.wJqDWQpe-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6563f60f14cbb3dcbdc4e1d8469fc0fbaaa80544
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6563f60f14cbb3dcbdc4e1d8469fc0fbaaa80544
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND --selectors CONFIG_DRM_MSM -a=csky
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=csky olddefconfig

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303071922.wJqDWQpe-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DEVFREQ_GOV_SIMPLE_ONDEMAND when selected by DRM_MSM
   .config:4518:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   
   WARNING: unmet direct dependencies detected for DEVFREQ_GOV_SIMPLE_ONDEMAND
     Depends on [n]: PM_DEVFREQ [=n]
     Selected by [y]:
     - DRM_MSM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=n] || QCOM_LLCC [=n]=n) && (QCOM_COMMAND_DB [=y] || QCOM_COMMAND_DB [=y]=n)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
