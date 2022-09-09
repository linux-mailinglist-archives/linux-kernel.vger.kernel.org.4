Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EFC5B3F60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiIITUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiIITUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:20:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E484C3E742
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662751205; x=1694287205;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=trxL+JsccAh8e5nhwfpXFs1+UmMFWeJLVEkdxMQVLWg=;
  b=eLY64DpEXqeDSOA0bfB8lJ+MQzU795rWixDjzTos50qFnfPE5Gkgd1By
   z7DWjSPRmLcIuaUe2/ZsfdI0l+xjdPE3zL0geAHp+EKsDWaRU1IuyOxdg
   Hdq/IK4db+uUxD+k+1DshM1gGFLhKmxUH2sVISpD/7XB5E0zwqorn3W2n
   iWMP9DMChQSNlLdnl3gcNdoY+LM4TIlP8gzP4UBrzsFjl/2y3EpuXjbcI
   1mBzczXoOmsUxWKV89HhopUff5X9dhl57MXC0Ao8bb7sF2Ft4g0Wm9hkn
   fwM9Z48RAh3bETdJPsF8RqO4rXuQk4AUkBkhLqw+qx0QMaskT3NGss8xq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="280573016"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="280573016"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 12:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="648549773"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Sep 2022 12:20:04 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWjXn-0001eh-12;
        Fri, 09 Sep 2022 19:20:03 +0000
Date:   Sat, 10 Sep 2022 03:19:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arvid Norlander <lkml@vorpal.se>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 59/65]
 drivers/platform/x86/toshiba_acpi.c:2937:9: warning: no previous prototype
 for 'toshiba_acpi_hwmon_is_visible'
Message-ID: <202209100300.LjCie4bn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   79e8f8235a1686d0656b60cf72f7fda5530ee1cf
commit: b5f3665e82591d465357f4a69196f46b3d30e997 [59/65] platform/x86: toshiba_acpi: Add fan RPM reading (hwmon interface)
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220910/202209100300.LjCie4bn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=b5f3665e82591d465357f4a69196f46b3d30e997
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout b5f3665e82591d465357f4a69196f46b3d30e997
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/toshiba_acpi.c:2937:9: warning: no previous prototype for 'toshiba_acpi_hwmon_is_visible' [-Wmissing-prototypes]
    2937 | umode_t toshiba_acpi_hwmon_is_visible(const void *drvdata,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/toshiba_acpi.c:2944:5: warning: no previous prototype for 'toshiba_acpi_hwmon_read' [-Wmissing-prototypes]
    2944 | int toshiba_acpi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/toshiba_acpi_hwmon_is_visible +2937 drivers/platform/x86/toshiba_acpi.c

  2934	
  2935	/* HWMON support for fan */
  2936	#if IS_ENABLED(CONFIG_HWMON)
> 2937	umode_t toshiba_acpi_hwmon_is_visible(const void *drvdata,
  2938					      enum hwmon_sensor_types type,
  2939					      u32 attr, int channel)
  2940	{
  2941		return 0444;
  2942	}
  2943	
> 2944	int toshiba_acpi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
  2945				    u32 attr, int channel, long *val)
  2946	{
  2947		/*
  2948		 * There is only a single channel and single attribute (for the
  2949		 * fan) at this point.
  2950		 * This can be replaced with more advanced logic in the future,
  2951		 * should the need arise.
  2952		 */
  2953		if (type == hwmon_fan && channel == 0 && attr == hwmon_fan_input) {
  2954			u32 value;
  2955			int ret;
  2956	
  2957			ret = get_fan_rpm(toshiba_acpi, &value);
  2958			if (ret)
  2959				return ret;
  2960	
  2961			*val = value;
  2962			return 0;
  2963		}
  2964		return -EOPNOTSUPP;
  2965	}
  2966	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
