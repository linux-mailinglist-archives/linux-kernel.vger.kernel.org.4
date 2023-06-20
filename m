Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A696737805
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFTXtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTXtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:49:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F9E2;
        Tue, 20 Jun 2023 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687304988; x=1718840988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yjG5HbXpzyMj0TodosWe+wCE8+H6yKMdv5B0rKBSF0w=;
  b=A13lpcQBddZOoNYsdtjQvFe9Mu+XZjF7ziDlzfiJ+jwI/IJLABhiiaU6
   iD4H1CD28cwLR/UgAzoWUIUWXxkVgTy0kivCKE5aoF2OdgIJMMpLeu4zz
   MafNv+P+zJPQU7d9ZTzg08RrGVRe6x11ay6z5DpiMrd6uZvXE583CicWh
   YQrqPK7Ad2LPk+KatXPtAbrV+pMpF+r+qCJ5PCxC1UT02jsbE50/xFWCq
   vlUZ5Aakk+Ed8fNCHUZEkO18eGmGbWxTlpQ26M4JJ3vDD6oGbZ0PqDvBZ
   j+TUHC3qAfdBurwpcFQ1xPSwSMzzkNvWrfB2H6SwBv99E4Cz7e5fBe76K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357508091"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="357508091"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:49:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804142637"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="804142637"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2023 16:49:44 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBl6W-0006Lg-07;
        Tue, 20 Jun 2023 23:49:44 +0000
Date:   Wed, 21 Jun 2023 07:49:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Luke D. Jones" <luke@ljones.dev>, hdegoede@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
Message-ID: <202306210717.OFFdFt8Q-lkp@intel.com>
References: <20230620030033.55033-2-luke@ljones.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620030033.55033-2-luke@ljones.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.4-rc7 next-20230620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luke-D-Jones/platform-x86-asus-wmi-add-support-for-ASUS-screenpad/20230620-110305
base:   linus/master
patch link:    https://lore.kernel.org/r/20230620030033.55033-2-luke%40ljones.dev
patch subject: [PATCH v3 1/1] platform/x86: asus-wmi: add support for ASUS screenpad
config: x86_64-randconfig-a001-20230620 (https://download.01.org/0day-ci/archive/20230621/202306210717.OFFdFt8Q-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306210717.OFFdFt8Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306210717.OFFdFt8Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/asus-wmi.c:3293:41: warning: variable 'bd' is uninitialized when used here [-Wuninitialized]
           brightness = read_screenpad_brightness(bd);
                                                  ^~
   drivers/platform/x86/asus-wmi.c:3285:29: note: initialize the variable 'bd' to silence this warning
           struct backlight_device *bd;
                                      ^
                                       = NULL
   1 warning generated.


vim +/bd +3293 drivers/platform/x86/asus-wmi.c

  3282	
  3283	static int asus_screenpad_init(struct asus_wmi *asus)
  3284	{
  3285		struct backlight_device *bd;
  3286		struct backlight_properties props;
  3287		int power, brightness;
  3288	
  3289		power = read_screenpad_backlight_power(asus);
  3290		if (power < 0)
  3291			return power;
  3292	
> 3293		brightness = read_screenpad_brightness(bd);
  3294		if (brightness < 0)
  3295			return brightness;
  3296	
  3297		memset(&props, 0, sizeof(struct backlight_properties));
  3298		props.type = BACKLIGHT_RAW; /* ensure this bd is last to be picked */
  3299		props.max_brightness = 255;
  3300		bd = backlight_device_register("asus_screenpad",
  3301					       &asus->platform_device->dev, asus,
  3302					       &asus_screenpad_bl_ops, &props);
  3303		if (IS_ERR(bd)) {
  3304			pr_err("Could not register backlight device\n");
  3305			return PTR_ERR(bd);
  3306		}
  3307	
  3308		asus->screenpad_backlight_device = bd;
  3309		/*
  3310		 * Counter an odd behaviour where default is set to < 13 if it was 0 on boot.
  3311		 * 60 is subjective, but accepted as a good compromise to retain visibility.
  3312		 */
  3313		if (brightness < 60)
  3314			brightness = 60;
  3315	
  3316		asus->driver->screenpad_brightness = brightness;
  3317		bd->props.brightness = brightness;
  3318		bd->props.power = power;
  3319		backlight_update_status(bd);
  3320	
  3321		return 0;
  3322	}
  3323	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
