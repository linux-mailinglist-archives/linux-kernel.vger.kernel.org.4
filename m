Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132D672F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjASCjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASCja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:39:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7787259259;
        Wed, 18 Jan 2023 18:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674095969; x=1705631969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EhoaZ96K7N17+1v0zvn8i+JexgqYOYLqIQbpavP/nO4=;
  b=n5Jk9VGu2H7EyEQ9amPBZUOgbZE56ROe8QkMzKQTW/z7Tzcy3NmI0PfQ
   mlL3IiAnC3xLROFgtOdtKfmCOwxT0GGI2CpY4f0DIRJzo9Xm8mBDUQvEQ
   ozELB0rikW/q9sGYky6EkikSvw76pscjLZ2kZchS62mL+OFkeoKOUBkbU
   eyVThX1shjZAnjBoKpCsi365Yo/WhLc/oMq+hreMyON8Q021ApE4njlZj
   sJENCBLDRPQq52DD86+G4dE68YS69r2l3WQOGSLPvzi8aXRucE+fkmqOc
   DTPezo+yLyEa2SLZR3b2VNAK8ubPnqxcS7QNm3lXJ1sp7GPyCDmp57M2u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323857715"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323857715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 18:39:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="692253874"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="692253874"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Jan 2023 18:39:27 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIKpq-0000ym-0d;
        Thu, 19 Jan 2023 02:39:26 +0000
Date:   Thu, 19 Jan 2023 10:39:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] thermal/core: Move the thermal trip code to a
 dedicated file
Message-ID: <202301191017.G3eBi85j-lkp@intel.com>
References: <20230118211123.111493-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118211123.111493-4-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on next-20230118]
[cannot apply to linus/master v6.2-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Remove-unneeded-ida_destroy/20230119-051422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230118211123.111493-4-daniel.lezcano%40linaro.org
patch subject: [PATCH 4/5] thermal/core: Move the thermal trip code to a dedicated file
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230119/202301191017.G3eBi85j-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/039f53e8f2c0e0711f85537055e169fb216a29a9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-core-Remove-unneeded-ida_destroy/20230119-051422
        git checkout 039f53e8f2c0e0711f85537055e169fb216a29a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_trip.c:12:5: warning: no previous prototype for '__for_each_thermal_trip' [-Wmissing-prototypes]
      12 | int __for_each_thermal_trip(struct thermal_zone_device *tz,
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/__for_each_thermal_trip +12 drivers/thermal/thermal_trip.c

    11	
  > 12	int __for_each_thermal_trip(struct thermal_zone_device *tz,
    13				    int (*cb)(struct thermal_trip *,
    14					      int trip_id, void *),
    15				    void *data)
    16	{
    17		int i, ret;
    18		struct thermal_trip trip;
    19	
    20		for (i = 0; i < tz->num_trips; i++) {
    21	
    22			ret = __thermal_zone_get_trip(tz, i, &trip);
    23			if (ret)
    24				return ret;
    25			
    26			ret = cb(&trip, i, data);
    27			if (ret)
    28				return ret;
    29		}
    30	
    31		return 0;
    32	}
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
