Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8619B6E7FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjDSQdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjDSQdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:33:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD718C;
        Wed, 19 Apr 2023 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681921978; x=1713457978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mAnrcuaI7efpoWd59QZ5GygKxMkYAN5Xjr9QIGC1lsg=;
  b=lXPx51WzY3Psc05GnjHwp0Uoj5g83p63m9qanEJzSBZcY4WmRdGGZGV8
   d9EdWHbf18PmoQROhczkG02ca7MsaOjtl58/SzfMT/MeHmOVvypZIJTZc
   mWm7gathZ8DfptuLOv3Qcesys97sGz54IhUblO1XOlUKje8jen8u0mmOp
   MYbCuv1eYPxJ3IpYqyvWjw8mXkzLQ5oE5rW4fPQub4ZvH8u9NfbfXvP3D
   FjrpZFwO5EZsdpUiWYduzBJTbCxD/cvxRIjcxhU9YJwhr8jSkuDOIWBLm
   Dlnj0Jx7J+N0ril0M74Q7gvMxebEQLaCObqT/iwBGqCasgzIiM/PeKcAV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334310887"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="334310887"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 09:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="760801231"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="760801231"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2023 09:32:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppAjn-000f0U-0l;
        Wed, 19 Apr 2023 16:32:55 +0000
Date:   Thu, 20 Apr 2023 00:32:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 1/4] block: constify partition prober array
Message-ID: <202304200014.y79VnmJo-lkp@intel.com>
References: <20230419-const-partition-v1-1-2d66f2d83873@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419-const-partition-v1-1-2d66f2d83873@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on af67688dca57999fd848f051eeea1d375ba546b2]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/block-constify-partition-prober-array/20230419-155356
base:   af67688dca57999fd848f051eeea1d375ba546b2
patch link:    https://lore.kernel.org/r/20230419-const-partition-v1-1-2d66f2d83873%40weissschuh.net
patch subject: [PATCH 1/4] block: constify partition prober array
config: arm64-randconfig-r001-20230416 (https://download.01.org/0day-ci/archive/20230420/202304200014.y79VnmJo-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/9bc1f4308c10322c327c9e86ede6bb9e862440aa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Thomas-Wei-schuh/block-constify-partition-prober-array/20230419-155356
        git checkout 9bc1f4308c10322c327c9e86ede6bb9e862440aa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash block/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304200014.y79VnmJo-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/partitions/core.c:15:8: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
   static const int (*check_part[])(struct parsed_partitions *) = {
          ^~~~~~
>> block/partitions/core.c:47:2: error: incompatible function pointer types initializing 'const int (*)(struct parsed_partitions *)' with an expression of type 'int (struct parsed_partitions *)' [-Wincompatible-function-pointer-types]
           efi_partition,          /* this must come before msdos */
           ^~~~~~~~~~~~~
   block/partitions/core.c:50:2: error: incompatible function pointer types initializing 'const int (*)(struct parsed_partitions *)' with an expression of type 'int (struct parsed_partitions *)' [-Wincompatible-function-pointer-types]
           sgi_partition,
           ^~~~~~~~~~~~~
   block/partitions/core.c:56:2: error: incompatible function pointer types initializing 'const int (*)(struct parsed_partitions *)' with an expression of type 'int (struct parsed_partitions *)' [-Wincompatible-function-pointer-types]
           msdos_partition,
           ^~~~~~~~~~~~~~~
   block/partitions/core.c:59:2: error: incompatible function pointer types initializing 'const int (*)(struct parsed_partitions *)' with an expression of type 'int (struct parsed_partitions *)' [-Wincompatible-function-pointer-types]
           osf_partition,
           ^~~~~~~~~~~~~
   block/partitions/core.c:62:2: error: incompatible function pointer types initializing 'const int (*)(struct parsed_partitions *)' with an expression of type 'int (struct parsed_partitions *)' [-Wincompatible-function-pointer-types]
           sun_partition,
           ^~~~~~~~~~~~~
   block/partitions/core.c:65:2: error: incompatible function pointer types initializing 'const int (*)(struct parsed_partitions *)' with an expression of type 'int (struct parsed_partitions *)' [-Wincompatible-function-pointer-types]
           amiga_partition,
           ^~~~~~~~~~~~~~~
   block/partitions/core.c:71:2: error: incompatible function pointer types initializing 'const int (*)(struct parsed_partitions *)' with an expression of type 'int (struct parsed_partitions *)' [-Wincompatible-function-pointer-types]
           mac_partition,
           ^~~~~~~~~~~~~
   1 warning and 7 errors generated.


vim +47 block/partitions/core.c

387048bf67eeff Christoph Hellwig 2020-03-24  42  
387048bf67eeff Christoph Hellwig 2020-03-24  43  #ifdef CONFIG_CMDLINE_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  44  	cmdline_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  45  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  46  #ifdef CONFIG_EFI_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24 @47  	efi_partition,		/* this must come before msdos */
387048bf67eeff Christoph Hellwig 2020-03-24  48  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  49  #ifdef CONFIG_SGI_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  50  	sgi_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  51  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  52  #ifdef CONFIG_LDM_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  53  	ldm_partition,		/* this must come before msdos */
387048bf67eeff Christoph Hellwig 2020-03-24  54  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  55  #ifdef CONFIG_MSDOS_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  56  	msdos_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  57  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  58  #ifdef CONFIG_OSF_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  59  	osf_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  60  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  61  #ifdef CONFIG_SUN_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  62  	sun_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  63  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  64  #ifdef CONFIG_AMIGA_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  65  	amiga_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  66  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  67  #ifdef CONFIG_ATARI_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  68  	atari_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  69  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  70  #ifdef CONFIG_MAC_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  71  	mac_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  72  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  73  #ifdef CONFIG_ULTRIX_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  74  	ultrix_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  75  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  76  #ifdef CONFIG_IBM_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  77  	ibm_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  78  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  79  #ifdef CONFIG_KARMA_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  80  	karma_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  81  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  82  #ifdef CONFIG_SYSV68_PARTITION
387048bf67eeff Christoph Hellwig 2020-03-24  83  	sysv68_partition,
387048bf67eeff Christoph Hellwig 2020-03-24  84  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  85  	NULL
387048bf67eeff Christoph Hellwig 2020-03-24  86  };
387048bf67eeff Christoph Hellwig 2020-03-24  87  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
