Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6285D71866B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjEaPcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjEaPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:32:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02751125
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685547152; x=1717083152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BYPMrPYIIbcl1XzJ9RKq09gP2kje2GE3CG61hxMkSeA=;
  b=DbKmAFbPXa+9+FqB/mRkuGGDeX8lEbuIva/ll5UVWzQQ3vQUfHXjc2AG
   NLVangy3gc3qJBp4sD6pgYjTstLRq7VIZHEGwB+4WZ1ffAogw85czxYfO
   iC+eQbNip/gJhBI7wgjnMJNptoKRMXnoZ0V2uOcKd6hR61NE/YFOb4T/8
   pvwab7hp3p2mA3b3Gp4mFQLrFzoXjUnRLWfI8Wy4juATDkdAbUA6XrfjP
   K4bHpx03/pbUMssIsSJ3TZbNK7oZdfIDNiSKf7IlTI/5aHbqiUqXuDKCG
   3dRFDGbdSlF8pNdy/hNWiVBvERnl8xv99D+hXrK2P/39soM5ntlb/GFWt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="354116864"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="354116864"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 08:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="701140924"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="701140924"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 May 2023 08:32:29 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4NoL-0001Ql-0O;
        Wed, 31 May 2023 15:32:29 +0000
Date:   Wed, 31 May 2023 23:32:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, tvrtko.ursulin@linux.intel.com,
        intel-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com
Subject: Re: [PATCH -next] drm/i915: remove unreachable code
Message-ID: <202305312340.S0eChDKB-lkp@intel.com>
References: <20230531021714.125078-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531021714.125078-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230530]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Li/drm-i915-remove-unreachable-code/20230531-101832
base:   next-20230530
patch link:    https://lore.kernel.org/r/20230531021714.125078-1-yang.lee%40linux.alibaba.com
patch subject: [PATCH -next] drm/i915: remove unreachable code
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230531/202305312340.S0eChDKB-lkp@intel.com/config)
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
| Closes: https://lore.kernel.org/oe-kbuild-all/202305312340.S0eChDKB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/display/intel_color.c: In function 'intel_color_prepare_commit':
>> drivers/gpu/drm/i915/display/intel_color.c:1803:28: error: unused variable 'crtc' [-Werror=unused-variable]
    1803 |         struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
         |                            ^~~~
   cc1: all warnings being treated as errors


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
