Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B217305D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjFNRRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjFNRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:17:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94033268F;
        Wed, 14 Jun 2023 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686763033; x=1718299033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1rVknc6eI0s2SyaBRaLfKBU3jy707I2xZOIeKDgA+gA=;
  b=SEU2SiRNmCVtgm6gafrsHL0GhcNeyLOsOtf91h9Iz1QXHbUXvzPZMoUS
   YkbB7WEPiR+e7kPs/yr2yuCto69bYdSWOlMR1lJmo+BNv7AWHBOtnpPoX
   A6Qi3YbiAPFpD7v9Bls/Z+tvVwLx/6Xn3qcAgnJL2TZeodymbIA2zMY+8
   iTzFi5/T53xkUqs/icIPQkWMOodwd81zktMpMRK55F4qAjEpEy3OZho8n
   jbYH8b58B+27iEcwg1DeiR3gQR2tn1mP6pjVMG2S8VIxwUFShRmxXfdPn
   DUa6mDouWgAGUvsH/1ZDwHeJpYsGQ5b/4htNg3/DEicBHoKr58YkcTTrm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362053903"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="362053903"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782176086"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="782176086"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2023 10:17:10 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9U6v-0000t3-1a;
        Wed, 14 Jun 2023 17:16:49 +0000
Date:   Thu, 15 Jun 2023 01:15:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>, linux@roeck-us.net,
        jdelvare@suse.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: Re: [PATCH 1/3] hwmon: (sht3x)remove sht3x_platform_data
Message-ID: <202306150115.i0k7ulfo-lkp@intel.com>
References: <DB4PR10MB6261D79FE16EC2BBD5316B91925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB6261D79FE16EC2BBD5316B91925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi JuenKit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.4-rc6 next-20230614]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/JuenKit-Yip/hwmon-sht3x-add-medium-repeatability-support/20230614-143100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/DB4PR10MB6261D79FE16EC2BBD5316B91925AA%40DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
patch subject: [PATCH 1/3] hwmon: (sht3x)remove sht3x_platform_data
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230615/202306150115.i0k7ulfo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        git remote add groeck-staging https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
        git fetch groeck-staging hwmon-next
        git checkout groeck-staging/hwmon-next
        b4 shazam https://lore.kernel.org/r/DB4PR10MB6261D79FE16EC2BBD5316B91925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hwmon/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306150115.i0k7ulfo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/sht3x.c:29:28: warning: 'sht3x_cmd_measure_blocking_lpm' defined but not used [-Wunused-const-variable=]
      29 | static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/sht3x.c:25:28: warning: 'sht3x_cmd_measure_blocking_hpm' defined but not used [-Wunused-const-variable=]
      25 | static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sht3x_cmd_measure_blocking_lpm +29 drivers/hwmon/sht3x.c

7c84f7f80d6fcea David Frey  2016-06-02  23  
cecbab8bdd40311 JuenKit Yip 2023-06-14  24  /* commands (high repeatability mode) */
7c84f7f80d6fcea David Frey  2016-06-02 @25  static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
7c84f7f80d6fcea David Frey  2016-06-02  26  static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 0x24, 0x00 };
7c84f7f80d6fcea David Frey  2016-06-02  27  
cecbab8bdd40311 JuenKit Yip 2023-06-14  28  /* commands (low repeatability mode) */
7c84f7f80d6fcea David Frey  2016-06-02 @29  static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
7c84f7f80d6fcea David Frey  2016-06-02  30  static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 0x24, 0x16 };
7c84f7f80d6fcea David Frey  2016-06-02  31  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
