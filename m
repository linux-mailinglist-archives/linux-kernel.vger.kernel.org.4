Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B956BBFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjCOW2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjCOW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:28:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD4968D5;
        Wed, 15 Mar 2023 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678919292; x=1710455292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KOM7hWuc+mursDdv+bZS6bFfc0Blf43vlrc6huzBfUc=;
  b=n9lKwmyvRWHlkxDMywb+tUnNjM8qtR+Y+BiE0TlY1scjDmxjFI9vyz58
   yA6FOiPocopLkgnrpLvg3n8DO93HBi65GTmiH3o6oRKzxnDEecBm/tFy2
   MS3CtbQ9Uv2elgB3RBnK/kkwc6TMEtzoy8IntD/qLEQJAzugpdo+H4It0
   ZPGj58Y7ltzjg0j7zY5/3APGxyXeTjRmXIQs6AS/ajfQxdAuV5QVUnP9v
   veeFNKIW5MeMj8S4Jkm1DaW3a1WtO1EEGkQVbBaGfw69PLBIYoFB09iSq
   dcZOnd3ZF4HIE9HQu8sZhhivn92STN+2Dencb1pxzZp0a5a0gGvYLBWud
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424102832"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="424102832"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="656937318"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="656937318"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2023 15:28:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcZbN-000857-2y;
        Wed, 15 Mar 2023 22:28:09 +0000
Date:   Thu, 16 Mar 2023 06:28:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     phinex <phinex@realtek.com>, jdelvare@suse.com
Cc:     oe-kbuild-all@lists.linux.dev, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        phinex@realtek.com
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Message-ID: <202303160645.7Nrjce3N-lkp@intel.com>
References: <20230315121606.GA71707@threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315121606.GA71707@threadripper>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi phinex,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/phinex/hwmon-drivetemp-support-to-be-a-platform-driver-for-thermal_of/20230315-201903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230315121606.GA71707%40threadripper
patch subject: [PATCH v1] hwmon: drivetemp: support to be a platform driver for thermal_of
config: i386-randconfig-a012 (https://download.01.org/0day-ci/archive/20230316/202303160645.7Nrjce3N-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/1c53b683440a584685795fa8ff831379577081b0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review phinex/hwmon-drivetemp-support-to-be-a-platform-driver-for-thermal_of/20230315-201903
        git checkout 1c53b683440a584685795fa8ff831379577081b0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160645.7Nrjce3N-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/drivetemp.c:116:36: warning: 'tz' defined but not used [-Wunused-variable]
     116 | static struct thermal_zone_device *tz;
         |                                    ^~


vim +/tz +116 drivers/hwmon/drivetemp.c

   114	
   115	/*A single thermal_zone for all HDD sensors */
 > 116	static struct thermal_zone_device *tz;
   117	#define MAX_NAME_LEN 255
   118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
