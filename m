Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2626E7601
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjDSJLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjDSJLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:11:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD842135;
        Wed, 19 Apr 2023 02:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681895508; x=1713431508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bwq23zBVr9UE6Bu5wJPoFE2RtRMooY2VwlFYV4IdgiI=;
  b=c0wY0fszmPGfZIwyPvJJOMabpvr17kCH8ChmTNdRpa5l0SUJEHrCRv9T
   j7LDrsG31U9EKQNr/c4ncfJUlclG0tzjLAje+ZzcXoz1Zp8mN4h69X1YC
   h99aFAeccQvb5iu8141NeceK9ntS79uxxFq3RI47lVFE7BJtdw36wwdpR
   gUFyfRxW7v7qVkthKFofWH/wVKG/xbb8xDMGlN6i5FvjxJm2p2gD0iOIg
   DmW92XHwcHNnz0jxZuhWnlCVDTD1jXMUNliwZoY3MXXW37hqf0YwXKdAa
   +huFYZ8Qy03wpvBotdttSRYevL1EgrvYXYTwjQgqsr6dBEPLBGjeYbXKc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325013497"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325013497"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 02:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="721852276"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="721852276"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Apr 2023 02:11:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp3qr-000elf-0B;
        Wed, 19 Apr 2023 09:11:45 +0000
Date:   Wed, 19 Apr 2023 17:11:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 1/4] block: constify partition prober array
Message-ID: <202304191640.SkNk7kVN-lkp@intel.com>
References: <20230419-const-partition-v1-1-2d66f2d83873@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419-const-partition-v1-1-2d66f2d83873@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on af67688dca57999fd848f051eeea1d375ba546b2]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/block-constify-partition-prober-array/20230419-155356
base:   af67688dca57999fd848f051eeea1d375ba546b2
patch link:    https://lore.kernel.org/r/20230419-const-partition-v1-1-2d66f2d83873%40weissschuh.net
patch subject: [PATCH 1/4] block: constify partition prober array
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230419/202304191640.SkNk7kVN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9bc1f4308c10322c327c9e86ede6bb9e862440aa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Thomas-Wei-schuh/block-constify-partition-prober-array/20230419-155356
        git checkout 9bc1f4308c10322c327c9e86ede6bb9e862440aa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash block/partitions/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304191640.SkNk7kVN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/partitions/core.c:15:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
      15 | static const int (*check_part[])(struct parsed_partitions *) = {
         |        ^~~~~


vim +15 block/partitions/core.c

    14	
  > 15	static const int (*check_part[])(struct parsed_partitions *) = {
    16		/*
    17		 * Probe partition formats with tables at disk address 0
    18		 * that also have an ADFS boot block at 0xdc0.
    19		 */
    20	#ifdef CONFIG_ACORN_PARTITION_ICS
    21		adfspart_check_ICS,
    22	#endif
    23	#ifdef CONFIG_ACORN_PARTITION_POWERTEC
    24		adfspart_check_POWERTEC,
    25	#endif
    26	#ifdef CONFIG_ACORN_PARTITION_EESOX
    27		adfspart_check_EESOX,
    28	#endif
    29	
    30		/*
    31		 * Now move on to formats that only have partition info at
    32		 * disk address 0xdc0.  Since these may also have stale
    33		 * PC/BIOS partition tables, they need to come before
    34		 * the msdos entry.
    35		 */
    36	#ifdef CONFIG_ACORN_PARTITION_CUMANA
    37		adfspart_check_CUMANA,
    38	#endif
    39	#ifdef CONFIG_ACORN_PARTITION_ADFS
    40		adfspart_check_ADFS,
    41	#endif
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
