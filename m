Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A91071872D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjEaQR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEaQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:17:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7881712C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685549843; x=1717085843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NP8J/yvcR/yss1+daiu7aMG7qEaHT3dVfT6aXQ7JXm8=;
  b=eeoJyLcXvVhjwvoK5fNVynjwQa+1vy3E2khe1bJ9391wWz7qFWaxJn9+
   8VflVa5XiVtoVoW/0PNyyrR9SpRXQ3Z2p0b+T9ZUi17t3Pnnh6jUCh7lP
   +Egiq9DVfIQdmLQ4IpbU+yHMxWpQLhtUsoGhXbexgoS3x6MCB89fVlq1X
   kJIhWaSU/YOqGvGfBO7arQf2bgxseWTRFvNnMMl3U3+2bb7gR1mteQmqy
   bVWWjWEo/EtpiA2+5hQmDa2TjlZzJJdooXHtOkopSylA1EM9KgzRl9UrO
   flAtge3aIW5m/clNEuwsymBfC3mDl0yjO7y99sXLUJKFs95MPOe7ILxCk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="383550889"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="383550889"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:14:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="1037117690"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="1037117690"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 09:14:31 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4OT0-0001Tr-3A;
        Wed, 31 May 2023 16:14:30 +0000
Date:   Thu, 1 Jun 2023 00:13:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, tvrtko.ursulin@linux.intel.com,
        intel-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com
Subject: Re: [PATCH -next] drm/i915: remove unreachable code
Message-ID: <202306010001.gUxZYcyb-lkp@intel.com>
References: <20230531021714.125078-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531021714.125078-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230530]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Li/drm-i915-remove-unreachable-code/20230531-101832
base:   next-20230530
patch link:    https://lore.kernel.org/r/20230531021714.125078-1-yang.lee%40linux.alibaba.com
patch subject: [PATCH -next] drm/i915: remove unreachable code
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20230601/202306010001.gUxZYcyb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/58232a66b9d21d80bc6b478e2a8fb1443da3adfc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yang-Li/drm-i915-remove-unreachable-code/20230531-101832
        git checkout 58232a66b9d21d80bc6b478e2a8fb1443da3adfc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306010001.gUxZYcyb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/i915/display/intel_color.c: In function 'intel_color_prepare_commit':
>> drivers/gpu/drm/i915/display/intel_color.c:1803:28: warning: unused variable 'crtc' [-Wunused-variable]
    1803 |         struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
         |                            ^~~~


vim +/crtc +1803 drivers/gpu/drm/i915/display/intel_color.c

3962ca4e080a52 Ville Syrjälä 2023-03-20  1800  
efb2b57edf20c3 Ville Syrjälä 2022-11-23  1801  void intel_color_prepare_commit(struct intel_crtc_state *crtc_state)
efb2b57edf20c3 Ville Syrjälä 2022-11-23  1802  {
b358c3b98813b1 Ville Syrjälä 2022-11-23 @1803  	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
b358c3b98813b1 Ville Syrjälä 2022-11-23  1804  
2487ae0bcb53a7 Ville Syrjälä 2022-11-23  1805  	/* FIXME DSB has issues loading LUTs, disable it for now */
2487ae0bcb53a7 Ville Syrjälä 2022-11-23  1806  	return;
efb2b57edf20c3 Ville Syrjälä 2022-11-23  1807  }
efb2b57edf20c3 Ville Syrjälä 2022-11-23  1808  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
