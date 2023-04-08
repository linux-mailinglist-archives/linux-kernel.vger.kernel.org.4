Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025296DBC53
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 19:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjDHR1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 13:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDHR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 13:27:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627FE212C;
        Sat,  8 Apr 2023 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680974828; x=1712510828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=20Gp8Ob9sY0l7Q3kLwGChvRjnxAHs9YuVEd44YUhsWE=;
  b=KwT1e59dSzu6B5HHy8L27MPtJ+dPtxm8ocGOf3c6zFtJ7F/pgJPRsKPn
   Y4YIjXwnh35ofbD7IHDopoTDgMvdUSYq3NAw32r0YeiSQCLEcVox7jfxz
   GF9xX/pUedsw3vgdQ85lBgu5jdA40pGnlNX8kwW7TW+ExjjnJBrEwZ9VS
   v1iGnlzzxpT4JlCBKvNLqsF2P/HUcRCmJcFR8E+F8ifK7iTqUFbD/g1fE
   5UN7s+Th8Xp5ZmgwNSCnMuhr52gkhLfjHVFmbpQNxG151s0WvToYsyIjI
   OtIzAJPdxDaaI+j7EauQCWG3l4p1GbOk25HiH8gjJst+L4kuX8aUzyizF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="322789169"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="322789169"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 10:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="681311839"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="681311839"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Apr 2023 10:27:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plCLA-000Twb-01;
        Sat, 08 Apr 2023 17:27:04 +0000
Date:   Sun, 9 Apr 2023 01:26:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deepanshu Kartikey <kartikey406@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: Re: [PATCH] staging: fbtft: fbtft-bus.c added params
Message-ID: <202304090139.b8XZpHpu-lkp@intel.com>
References: <20230408081817.81562-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408081817.81562-1-kartikey406@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepanshu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Deepanshu-Kartikey/staging-fbtft-fbtft-bus-c-added-params/20230408-161947
patch link:    https://lore.kernel.org/r/20230408081817.81562-1-kartikey406%40gmail.com
patch subject: [PATCH] staging: fbtft: fbtft-bus.c added params
config: i386-randconfig-s001-20230403 (https://download.01.org/0day-ci/archive/20230409/202304090139.b8XZpHpu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/038bedbb2c34ffc5e5ce77d5f49811778be8d631
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Deepanshu-Kartikey/staging-fbtft-fbtft-bus-c-added-params/20230408-161947
        git checkout 038bedbb2c34ffc5e5ce77d5f49811778be8d631
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/fbtft/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304090139.b8XZpHpu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/staging/fbtft/fbtft-bus.c:65:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] @@     got restricted __be16 [usertype] @@
   drivers/staging/fbtft/fbtft-bus.c:65:1: sparse:     expected unsigned char [usertype]
   drivers/staging/fbtft/fbtft-bus.c:65:1: sparse:     got restricted __be16 [usertype]
>> drivers/staging/fbtft/fbtft-bus.c:65:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] @@     got restricted __be16 [usertype] @@
   drivers/staging/fbtft/fbtft-bus.c:65:1: sparse:     expected unsigned char [usertype]
   drivers/staging/fbtft/fbtft-bus.c:65:1: sparse:     got restricted __be16 [usertype]
>> drivers/staging/fbtft/fbtft-bus.c:65:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] @@     got restricted __be16 [usertype] @@
   drivers/staging/fbtft/fbtft-bus.c:65:1: sparse:     expected unsigned char [usertype]
   drivers/staging/fbtft/fbtft-bus.c:65:1: sparse:     got restricted __be16 [usertype]
   drivers/staging/fbtft/fbtft-bus.c:67:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
   drivers/staging/fbtft/fbtft-bus.c:67:1: sparse:     expected unsigned short [usertype]
   drivers/staging/fbtft/fbtft-bus.c:67:1: sparse:     got restricted __be16 [usertype]
   drivers/staging/fbtft/fbtft-bus.c:67:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
   drivers/staging/fbtft/fbtft-bus.c:67:1: sparse:     expected unsigned short [usertype]
   drivers/staging/fbtft/fbtft-bus.c:67:1: sparse:     got restricted __be16 [usertype]
   drivers/staging/fbtft/fbtft-bus.c:67:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
   drivers/staging/fbtft/fbtft-bus.c:67:1: sparse:     expected unsigned short [usertype]
   drivers/staging/fbtft/fbtft-bus.c:67:1: sparse:     got restricted __be16 [usertype]

vim +65 drivers/staging/fbtft/fbtft-bus.c

    64	
  > 65	define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, cpu_to_be16);
    66	define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16);
    67	define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, cpu_to_be16);
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
