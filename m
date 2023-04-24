Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376136E0332
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDMA1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDMA1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:27:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD4449D;
        Wed, 12 Apr 2023 17:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681345651; x=1712881651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=91ps9yc2BHF8OTu7wTRMHp/SHeLcXz0RITidFgNOBe8=;
  b=VyhHedk361fRRuCamWpL3YDNrBQpm+1gMMlqHjBe/A4decLEgCTrYEpX
   ilXwQCcAzQtyV6+rVIlgLuhCo1ShzadVL7tBbvfO5ItcY+0Z0H++ycQlg
   ei0j1EXTDP4Vhu4XJHhJnNzVnKFJIgrp+QjgiHurGIuWDbf3o3djwDrMv
   XsAaqsIIy4oZffoBRxENSlkwYyH4uPx+2RWfI6dJkqe7uefLZJtR12/JB
   AXVoY0nqF3HFED5vvl/s2VvCvwhKarhEjrUhlvMysSO8GiLwryjQlosQI
   fXKXqERWiSMKRY9UfSzBtD3lkgI5ftSYpTD+Auib1Jb4gk2e6q8o5i7hh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323676684"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323676684"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 17:27:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="721784440"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="721784440"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2023 17:27:28 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmkoB-000YAh-14;
        Thu, 13 Apr 2023 00:27:27 +0000
Date:   Thu, 13 Apr 2023 08:27:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     mail@mariushoch.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: Re: [PATCH] iio: st_sensors: Add ACPI support for lsm303d to the
 LSM9DS0 IMU driver
Message-ID: <202304130858.DbtHpwcV-lkp@intel.com>
References: <20230412223627.442963-5-mail@mariushoch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412223627.442963-5-mail@mariushoch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.3-rc6 next-20230412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mail-mariushoch-de/iio-st_sensors-Add-ACPI-support-for-lsm303d-to-the-LSM9DS0-IMU-driver/20230413-064417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230412223627.442963-5-mail%40mariushoch.de
patch subject: [PATCH] iio: st_sensors: Add ACPI support for lsm303d to the LSM9DS0 IMU driver
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230413/202304130858.DbtHpwcV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ec35631841a31e357cf4f6781b4c8f78a468a4ef
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review mail-mariushoch-de/iio-st_sensors-Add-ACPI-support-for-lsm303d-to-the-LSM9DS0-IMU-driver/20230413-064417
        git checkout ec35631841a31e357cf4f6781b4c8f78a468a4ef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304130858.DbtHpwcV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c:38:38: error: 'LSM303D_IMU_DEV_NAME' undeclared here (not in a function); did you mean 'LSM9DS0_IMU_DEV_NAME'?
      38 |         {"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
         |                                      ^~~~~~~~~~~~~~~~~~~~
         |                                      LSM9DS0_IMU_DEV_NAME
--
>> drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c:38:38: error: 'LSM303D_IMU_DEV_NAME' undeclared here (not in a function); did you mean 'LSM9DS0_IMU_DEV_NAME'?
      38 |         {"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
         |                                      ^~~~~~~~~~~~~~~~~~~~
         |                                      LSM9DS0_IMU_DEV_NAME


vim +38 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c

    35	
    36	#ifdef CONFIG_ACPI
    37	static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
  > 38		{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
    39		{ },
    40	};
    41	MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
    42	#endif
    43	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
