Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF2B614DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKAPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiKAPHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:07:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC7C1E71A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667314877; x=1698850877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hy1H8a64cUzn6UmQr2e8zuKqJh4TE7Gyn8TAVJEnlV0=;
  b=F34bhglINz9Bl+CmwA0Vxprs90VcM8E3IpHYiqDl9CMOL28LTYOVIirs
   NbzEEHNQoIQP65Vlz62ZoJT/+8oOFxAJljFlmaCNrk+ZGAyOoZiGNLqU8
   PmGIFzCcvvuhMUdb24vaooI9NkBp/7/fSQ/qjrpiARmaH73Y3e/MhDmUw
   3hgf8F5rl885NPswEKLNx57klGykg0R2Nam4JhuTrYcC4e/ZevFWte3lB
   UCYGwwmr6/vtxAcv1Qjvg4t6TJR+sqHj1tsEhLbTuSHTTDkyBpJU8F3nH
   yq73p4rgiSbzykVJbvLn/LJLxGsRd2A3pwFuX1a4vw7tMbR1s0yCyljNZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="296583984"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="296583984"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="963148029"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="963148029"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Nov 2022 07:59:58 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1opskA-000Dj6-0o;
        Tue, 01 Nov 2022 14:59:58 +0000
Date:   Tue, 1 Nov 2022 22:59:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        ndesaulniers@google.com
Cc:     oe-kbuild-all@lists.linux.dev, peterz@infradead.org,
        llvm@lists.linux.dev, ashutosh.dixit@intel.com,
        andi.shyti@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitfield: Use argument type for size comparison on
 Bitfield access macros
Message-ID: <202211012258.Dntye0Cw-lkp@intel.com>
References: <20221029053429.38381-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="F1MOaMtzXsGkYEuw"
Content-Disposition: inline
In-Reply-To: <20221029053429.38381-1-gwan-gyeong.mun@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F1MOaMtzXsGkYEuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gwan-gyeong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.1-rc3 next-20221101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gwan-gyeong-Mun/bitfield-Use-argument-type-for-size-comparison-on-Bitfield-access-macros/20221029-133640
patch link:    https://lore.kernel.org/r/20221029053429.38381-1-gwan-gyeong.mun%40intel.com
patch subject: [PATCH] bitfield: Use argument type for size comparison on Bitfield access macros
config: arm64-randconfig-s053-20221101
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/91f22fce5cc0639c001bcf755c9dec0913073876
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gwan-gyeong-Mun/bitfield-Use-argument-type-for-size-comparison-on-Bitfield-access-macros/20221029-133640
        git checkout 91f22fce5cc0639c001bcf755c9dec0913073876
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/perf/arm-cmn.c:404:16: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
   drivers/perf/arm-cmn.c: note: in included file (through arch/arm64/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]

vim +404 drivers/perf/arm-cmn.c

a88fa6c28b867a Robin Murphy 2021-12-03  400  
a88fa6c28b867a Robin Murphy 2021-12-03  401  #ifdef CONFIG_DEBUG_FS
a88fa6c28b867a Robin Murphy 2021-12-03  402  static const char *arm_cmn_device_type(u8 type)
a88fa6c28b867a Robin Murphy 2021-12-03  403  {
c5781212985a76 Robin Murphy 2022-05-11 @404  	switch(FIELD_GET(CMN__CONNECT_INFO_DEVICE_TYPE, type)) {
8e504d93acb647 Robin Murphy 2022-04-18  405  		case 0x00: return "        |";
a88fa6c28b867a Robin Murphy 2021-12-03  406  		case 0x01: return "  RN-I  |";
a88fa6c28b867a Robin Murphy 2021-12-03  407  		case 0x02: return "  RN-D  |";
a88fa6c28b867a Robin Murphy 2021-12-03  408  		case 0x04: return " RN-F_B |";
a88fa6c28b867a Robin Murphy 2021-12-03  409  		case 0x05: return "RN-F_B_E|";
a88fa6c28b867a Robin Murphy 2021-12-03  410  		case 0x06: return " RN-F_A |";
a88fa6c28b867a Robin Murphy 2021-12-03  411  		case 0x07: return "RN-F_A_E|";
a88fa6c28b867a Robin Murphy 2021-12-03  412  		case 0x08: return "  HN-T  |";
a88fa6c28b867a Robin Murphy 2021-12-03  413  		case 0x09: return "  HN-I  |";
a88fa6c28b867a Robin Murphy 2021-12-03  414  		case 0x0a: return "  HN-D  |";
8e504d93acb647 Robin Murphy 2022-04-18  415  		case 0x0b: return "  HN-P  |";
a88fa6c28b867a Robin Murphy 2021-12-03  416  		case 0x0c: return "  SN-F  |";
a88fa6c28b867a Robin Murphy 2021-12-03  417  		case 0x0d: return "  SBSX  |";
a88fa6c28b867a Robin Murphy 2021-12-03  418  		case 0x0e: return "  HN-F  |";
a88fa6c28b867a Robin Murphy 2021-12-03  419  		case 0x0f: return " SN-F_E |";
a88fa6c28b867a Robin Murphy 2021-12-03  420  		case 0x10: return " SN-F_D |";
a88fa6c28b867a Robin Murphy 2021-12-03  421  		case 0x11: return "  CXHA  |";
a88fa6c28b867a Robin Murphy 2021-12-03  422  		case 0x12: return "  CXRA  |";
a88fa6c28b867a Robin Murphy 2021-12-03  423  		case 0x13: return "  CXRH  |";
a88fa6c28b867a Robin Murphy 2021-12-03  424  		case 0x14: return " RN-F_D |";
a88fa6c28b867a Robin Murphy 2021-12-03  425  		case 0x15: return "RN-F_D_E|";
a88fa6c28b867a Robin Murphy 2021-12-03  426  		case 0x16: return " RN-F_C |";
a88fa6c28b867a Robin Murphy 2021-12-03  427  		case 0x17: return "RN-F_C_E|";
8e504d93acb647 Robin Murphy 2022-04-18  428  		case 0x18: return " RN-F_E |";
8e504d93acb647 Robin Murphy 2022-04-18  429  		case 0x19: return "RN-F_E_E|";
a88fa6c28b867a Robin Murphy 2021-12-03  430  		case 0x1c: return "  MTSX  |";
23760a0144173e Robin Murphy 2022-04-18  431  		case 0x1d: return "  HN-V  |";
23760a0144173e Robin Murphy 2022-04-18  432  		case 0x1e: return "  CCG   |";
8e504d93acb647 Robin Murphy 2022-04-18  433  		default:   return "  ????  |";
a88fa6c28b867a Robin Murphy 2021-12-03  434  	}
a88fa6c28b867a Robin Murphy 2021-12-03  435  }
a88fa6c28b867a Robin Murphy 2021-12-03  436  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--F1MOaMtzXsGkYEuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/arm64 6.1.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="aarch64-linux-gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_GENERIC_IRQ_IPI=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_ARCH_HAS_TICK_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_TIME_KUNIT_TEST=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_CGROUP_FAVOR_DYNMODS=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_RD_GZIP is not set
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
# CONFIG_BOOT_CONFIG is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
# CONFIG_MULTIUSER is not set
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_FHANDLE is not set
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
# CONFIG_TIMERFD is not set
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
# end of General setup

CONFIG_ARM64=y
CONFIG_GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_64BIT=y
CONFIG_MMU=y
CONFIG_ARM64_PAGE_SHIFT=12
CONFIG_ARM64_CONT_PTE_SHIFT=4
CONFIG_ARM64_CONT_PMD_SHIFT=4
CONFIG_ARCH_MMAP_RND_BITS_MIN=18
CONFIG_ARCH_MMAP_RND_BITS_MAX=24
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=11
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_SMP=y
CONFIG_KERNEL_MODE_NEON=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_ARCH_PROC_KCORE_TEXT=y

#
# Platform selection
#
CONFIG_ARCH_ACTIONS=y
# CONFIG_ARCH_SUNXI is not set
CONFIG_ARCH_ALPINE=y
CONFIG_ARCH_APPLE=y
# CONFIG_ARCH_BCM is not set
# CONFIG_ARCH_BERLIN is not set
# CONFIG_ARCH_BITMAIN is not set
CONFIG_ARCH_EXYNOS=y
CONFIG_ARCH_SPARX5=y
CONFIG_ARCH_K3=y
# CONFIG_ARCH_LG1K is not set
# CONFIG_ARCH_HISI is not set
# CONFIG_ARCH_KEEMBAY is not set
CONFIG_ARCH_MEDIATEK=y
CONFIG_ARCH_MESON=y
CONFIG_ARCH_MVEBU=y
# CONFIG_ARCH_NXP is not set
# CONFIG_ARCH_NPCM is not set
CONFIG_ARCH_QCOM=y
# CONFIG_ARCH_REALTEK is not set
CONFIG_ARCH_RENESAS=y
# CONFIG_ARCH_ROCKCHIP is not set
CONFIG_ARCH_SEATTLE=y
# CONFIG_ARCH_INTEL_SOCFPGA is not set
CONFIG_ARCH_SYNQUACER=y
# CONFIG_ARCH_TEGRA is not set
CONFIG_ARCH_TESLA_FSD=y
# CONFIG_ARCH_SPRD is not set
# CONFIG_ARCH_THUNDER is not set
CONFIG_ARCH_THUNDER2=y
CONFIG_ARCH_UNIPHIER=y
CONFIG_ARCH_VEXPRESS=y
# CONFIG_ARCH_VISCONTI is not set
CONFIG_ARCH_XGENE=y
CONFIG_ARCH_ZYNQMP=y
# end of Platform selection

#
# Kernel Features
#

#
# ARM errata workarounds via the alternatives framework
#
CONFIG_ARM64_WORKAROUND_CLEAN_CACHE=y
CONFIG_ARM64_ERRATUM_826319=y
CONFIG_ARM64_ERRATUM_827319=y
# CONFIG_ARM64_ERRATUM_824069 is not set
CONFIG_ARM64_ERRATUM_819472=y
# CONFIG_ARM64_ERRATUM_832075 is not set
# CONFIG_ARM64_ERRATUM_834220 is not set
CONFIG_ARM64_ERRATUM_1742098=y
# CONFIG_ARM64_ERRATUM_845719 is not set
CONFIG_ARM64_ERRATUM_843419=y
CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419=y
CONFIG_ARM64_ERRATUM_1024718=y
# CONFIG_ARM64_ERRATUM_1418040 is not set
CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT=y
# CONFIG_ARM64_ERRATUM_1165522 is not set
CONFIG_ARM64_ERRATUM_1319367=y
# CONFIG_ARM64_ERRATUM_1530923 is not set
CONFIG_ARM64_WORKAROUND_REPEAT_TLBI=y
# CONFIG_ARM64_ERRATUM_2441007 is not set
# CONFIG_ARM64_ERRATUM_1286807 is not set
CONFIG_ARM64_ERRATUM_1463225=y
# CONFIG_ARM64_ERRATUM_1542419 is not set
# CONFIG_ARM64_ERRATUM_1508412 is not set
CONFIG_ARM64_ERRATUM_2051678=y
CONFIG_ARM64_ERRATUM_2077057=y
# CONFIG_ARM64_ERRATUM_2658417 is not set
CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE=y
CONFIG_ARM64_ERRATUM_2054223=y
CONFIG_ARM64_ERRATUM_2067961=y
CONFIG_ARM64_ERRATUM_2441009=y
# CONFIG_ARM64_ERRATUM_2457168 is not set
CONFIG_CAVIUM_ERRATUM_22375=y
CONFIG_CAVIUM_ERRATUM_23144=y
CONFIG_CAVIUM_ERRATUM_23154=y
CONFIG_CAVIUM_ERRATUM_27456=y
# CONFIG_CAVIUM_ERRATUM_30115 is not set
# CONFIG_CAVIUM_TX2_ERRATUM_219 is not set
# CONFIG_FUJITSU_ERRATUM_010001 is not set
# CONFIG_HISILICON_ERRATUM_161600802 is not set
# CONFIG_QCOM_FALKOR_ERRATUM_1003 is not set
CONFIG_QCOM_FALKOR_ERRATUM_1009=y
# CONFIG_QCOM_QDF2400_ERRATUM_0065 is not set
# CONFIG_QCOM_FALKOR_ERRATUM_E1041 is not set
# CONFIG_NVIDIA_CARMEL_CNP_ERRATUM is not set
# CONFIG_SOCIONEXT_SYNQUACER_PREITS is not set
# end of ARM errata workarounds via the alternatives framework

CONFIG_ARM64_4K_PAGES=y
# CONFIG_ARM64_16K_PAGES is not set
# CONFIG_ARM64_64K_PAGES is not set
CONFIG_ARM64_VA_BITS_39=y
# CONFIG_ARM64_VA_BITS_48 is not set
CONFIG_ARM64_VA_BITS=39
CONFIG_ARM64_PA_BITS_48=y
CONFIG_ARM64_PA_BITS=48
# CONFIG_CPU_BIG_ENDIAN is not set
CONFIG_CPU_LITTLE_ENDIAN=y
CONFIG_SCHED_MC=y
# CONFIG_SCHED_CLUSTER is not set
# CONFIG_SCHED_SMT is not set
CONFIG_NR_CPUS=256
CONFIG_HOTPLUG_CPU=y
CONFIG_NUMA=y
CONFIG_NODES_SHIFT=4
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_HW_PERF_EVENTS=y
CONFIG_CC_HAVE_SHADOW_CALL_STACK=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_KEXEC_FILE=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_TRANS_TABLE=y
# CONFIG_XEN is not set
CONFIG_ARCH_FORCE_MAX_ORDER=11
# CONFIG_UNMAP_KERNEL_AT_EL0 is not set
# CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY is not set
CONFIG_RODATA_FULL_DEFAULT_ENABLED=y
# CONFIG_ARM64_SW_TTBR0_PAN is not set
CONFIG_ARM64_TAGGED_ADDR_ABI=y
CONFIG_COMPAT=y
# CONFIG_KUSER_HELPERS is not set
# CONFIG_COMPAT_ALIGNMENT_FIXUPS is not set

#
# ARMv8.1 architectural features
#
CONFIG_ARM64_HW_AFDBM=y
# CONFIG_ARM64_PAN is not set
CONFIG_AS_HAS_LDAPR=y
CONFIG_AS_HAS_LSE_ATOMICS=y
CONFIG_ARM64_LSE_ATOMICS=y
CONFIG_ARM64_USE_LSE_ATOMICS=y
# end of ARMv8.1 architectural features

#
# ARMv8.2 architectural features
#
CONFIG_AS_HAS_ARMV8_2=y
CONFIG_AS_HAS_SHA3=y
# CONFIG_ARM64_PMEM is not set
CONFIG_ARM64_RAS_EXTN=y
# CONFIG_ARM64_CNP is not set
# end of ARMv8.2 architectural features

#
# ARMv8.3 architectural features
#
CONFIG_ARM64_PTR_AUTH=y
# CONFIG_ARM64_PTR_AUTH_KERNEL is not set
CONFIG_CC_HAS_BRANCH_PROT_PAC_RET=y
CONFIG_CC_HAS_SIGN_RETURN_ADDRESS=y
CONFIG_AS_HAS_PAC=y
CONFIG_AS_HAS_CFI_NEGATE_RA_STATE=y
# end of ARMv8.3 architectural features

#
# ARMv8.4 architectural features
#
CONFIG_ARM64_AMU_EXTN=y
CONFIG_AS_HAS_ARMV8_4=y
CONFIG_ARM64_TLB_RANGE=y
# end of ARMv8.4 architectural features

#
# ARMv8.5 architectural features
#
CONFIG_AS_HAS_ARMV8_5=y
CONFIG_ARM64_BTI=y
CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI=y
# CONFIG_ARM64_E0PD is not set
CONFIG_ARM64_AS_HAS_MTE=y
# end of ARMv8.5 architectural features

#
# ARMv8.7 architectural features
#
# end of ARMv8.7 architectural features

CONFIG_ARM64_SVE=y
CONFIG_ARM64_SME=y
CONFIG_ARM64_MODULE_PLTS=y
# CONFIG_ARM64_PSEUDO_NMI is not set
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_CC_HAVE_STACKPROTECTOR_SYSREG=y
CONFIG_STACKPROTECTOR_PER_TASK=y
CONFIG_ARCH_NR_GPIO=2048
# end of Kernel Features

#
# Boot options
#
CONFIG_CMDLINE=""
# CONFIG_EFI is not set
# end of Boot options

#
# Power management options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_OF=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# end of Power management options

#
# CPU Power Management
#

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling
# end of CPU Power Management

CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
CONFIG_NVHE_EL2_DEBUG=y
# CONFIG_PROTECTED_NVHE_STACKTRACE is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_GENERIC_IDLE_POLL_SETUP=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_KEEPINITRD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_SHADOW_CALL_STACK=y
# CONFIG_SHADOW_CALL_STACK is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_ARCH_MMAP_RND_BITS=18
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=11
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_COMPILER_H=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_RELR=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_KEY=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAVE_TRACE_MMIO_ACCESS=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SIG_FORCE=y
# CONFIG_MODULE_SIG_ALL is not set

#
# Do not forget to sign required modules with scripts/sign-file
#
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
CONFIG_MODULE_SIG_SHA512=y
CONFIG_MODULE_SIG_HASH="sha512"
# CONFIG_MODULE_COMPRESS_NONE is not set
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_DECOMPRESS=y
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
CONFIG_ARCH_BINFMT_ELF_STATE=y
CONFIG_ARCH_BINFMT_ELF_EXTRA_PHDRS=y
CONFIG_ARCH_HAVE_ELF_PROT=y
CONFIG_ARCH_USE_GNU_PROPERTY=y
CONFIG_BINFMT_SCRIPT=m
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_STATS=y
# CONFIG_SLUB_CPU_PARTIAL is not set
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
# CONFIG_ZONE_DMA32 is not set
CONFIG_ZONE_DEVICE=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
CONFIG_LRU_GEN_STATS=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_KUNIT_TEST=y
# CONFIG_DAMON_VADDR is not set
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_RECLAIM=y
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
CONFIG_ARM_AMBA=y
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
CONFIG_PCI_SYSCALL=y
CONFIG_PCIEPORTBUS=y
# CONFIG_HOTPLUG_PCI_PCIE is not set
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_QUIRKS is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=m
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_BRIDGE_EMUL=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_P2PDMA=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
CONFIG_PCIE_BUS_PEER2PEER=y
# CONFIG_VGA_ARB is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_PCI_AARDVARK=m
# CONFIG_PCIE_XILINX_NWL is not set
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_TEGRA is not set
CONFIG_PCIE_RCAR_HOST=y
CONFIG_PCI_HOST_COMMON=y
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set
# CONFIG_PCIE_XILINX_CPM is not set
CONFIG_PCI_XGENE=y
CONFIG_PCI_XGENE_MSI=y
CONFIG_PCI_V3_SEMI=y
CONFIG_PCI_VERSATILE=y
CONFIG_PCIE_ALTERA=y
CONFIG_PCIE_ALTERA_MSI=y
CONFIG_PCI_HOST_THUNDER_PEM=y
CONFIG_PCI_HOST_THUNDER_ECAM=y
CONFIG_PCIE_ROCKCHIP=y
CONFIG_PCIE_ROCKCHIP_HOST=y
# CONFIG_PCIE_MEDIATEK is not set
CONFIG_PCIE_MEDIATEK_GEN3=y
# CONFIG_PCIE_BRCMSTB is not set
# CONFIG_PCIE_MICROCHIP_HOST is not set
CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR=0xfffff000
CONFIG_PCIE_APPLE=m
CONFIG_PCIE_MT7621=y

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCI_EXYNOS=y
CONFIG_PCI_IMX6=y
# CONFIG_PCIE_SPEAR13XX is not set
CONFIG_PCI_KEYSTONE=y
CONFIG_PCI_KEYSTONE_HOST=y
# CONFIG_PCI_LAYERSCAPE is not set
# CONFIG_PCI_HISI is not set
# CONFIG_PCIE_QCOM is not set
# CONFIG_PCIE_ARMADA_8K is not set
# CONFIG_PCIE_ARTPEC6_HOST is not set
CONFIG_PCIE_ROCKCHIP_DW_HOST=y
# CONFIG_PCIE_INTEL_GW is not set
# CONFIG_PCIE_KEEMBAY_HOST is not set
# CONFIG_PCIE_KIRIN is not set
CONFIG_PCIE_HISI_STB=y
CONFIG_PCI_MESON=y
# CONFIG_PCIE_TEGRA194_HOST is not set
CONFIG_PCIE_VISCONTI_HOST=y
CONFIG_PCIE_UNIPHIER=y
CONFIG_PCIE_AL=y
# CONFIG_PCIE_FU740 is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
CONFIG_PCIE_MOBIVEIL=y
CONFIG_PCIE_MOBIVEIL_HOST=y
# CONFIG_PCIE_MOBIVEIL_PLAT is not set
CONFIG_PCIE_LAYERSCAPE_GEN4=y
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
CONFIG_CXL_MEM_RAW_COMMANDS=y
CONFIG_CXL_MEM=m
CONFIG_CXL_PORT=m
CONFIG_CXL_REGION=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
# CONFIG_DEVTMPFS is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

# CONFIG_ALLOW_DEV_COREDUMP is not set
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_GENERIC_ARCH_TOPOLOGY=y
CONFIG_GENERIC_ARCH_NUMA=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
CONFIG_BRCMSTB_GISB_ARB=m
# CONFIG_BT1_APB is not set
CONFIG_BT1_AXI=y
CONFIG_HISILICON_LPC=y
CONFIG_INTEL_IXP4XX_EB=y
# CONFIG_QCOM_EBI2 is not set
CONFIG_QCOM_SSC_BLOCK_BUS=y
CONFIG_UNIPHIER_SYSTEM_BUS=m
# CONFIG_VEXPRESS_CONFIG is not set
# CONFIG_FSL_MC_BUS is not set
# CONFIG_MHI_BUS is not set
CONFIG_MHI_BUS_EP=m
# end of Bus devices

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=m
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_SHMEM=y
CONFIG_ARM_SCMI_HAVE_MSG=y
CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=y
CONFIG_ARM_SCMI_TRANSPORT_OPTEE=y
# CONFIG_ARM_SCMI_TRANSPORT_SMC is not set
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=y
CONFIG_ARM_SCMI_POWER_CONTROL=y
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_PROTOCOL=y
CONFIG_ARM_SCPI_POWER_DOMAIN=m
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_MTK_ADSP_IPC is not set
CONFIG_QCOM_SCM=y
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
CONFIG_TI_SCI_PROTOCOL=y
CONFIG_TURRIS_MOX_RWTM=m
CONFIG_ARM_FFA_TRANSPORT=y
CONFIG_ARM_FFA_SMCCC=y
CONFIG_BCM47XX_NVRAM=y
# CONFIG_BCM47XX_SPROM is not set
CONFIG_TEE_BNXT_FW=m
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_MESON_SM=m
CONFIG_ARM_PSCI_FW=y
CONFIG_HAVE_ARM_SMCCC=y
CONFIG_HAVE_ARM_SMCCC_DISCOVERY=y
CONFIG_ARM_SMCCC_SOC_ID=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver

#
# Zynq MPSoC Firmware Drivers
#
# CONFIG_ZYNQMP_FIRMWARE is not set
# end of Zynq MPSoC Firmware Drivers
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_GNSS_USB=m
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_ALL_DTBS=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_OF_NUMA=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=m
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=m
# CONFIG_ATMEL_SSC is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_HI6421V600_IRQ=y
CONFIG_HP_ILO=y
# CONFIG_QCOM_COINCELL is not set
CONFIG_QCOM_FASTRPC=m
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
CONFIG_PCH_PHUB=y
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=m
CONFIG_PCI_ENDPOINT_TEST=m
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=m
CONFIG_HISI_HIKEY_USB=m
# CONFIG_OPEN_DICE is not set
CONFIG_VCPU_STALL_DETECTOR=m
CONFIG_C2PORT=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=m
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=m
CONFIG_VMWARE_VMCI=y
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=m
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
CONFIG_PVPANIC_PCI=y
CONFIG_GP_PCI1XXXX=m
# end of Misc devices

#
# SCSI device support
#
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

#
# Input device support
#
CONFIG_INPUT=m
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADC=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
# CONFIG_JOYSTICK_IFORCE_USB is not set
CONFIG_JOYSTICK_IFORCE_232=m
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_DB9=m
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_XPAD=m
# CONFIG_JOYSTICK_XPAD_FF is not set
# CONFIG_JOYSTICK_XPAD_LEDS is not set
CONFIG_JOYSTICK_PXRC=m
CONFIG_JOYSTICK_QWIIC=m
# CONFIG_JOYSTICK_FSIA6B is not set
# CONFIG_JOYSTICK_SENSEHAT is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SMB is not set
# CONFIG_RMI4_F03 is not set
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_AMBAKMI=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=m
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_SERIO_SUN4I_PS2=m
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_FM801=m
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
CONFIG_SERIAL_DEV_BUS=m
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMI_KCS_BMC=y
CONFIG_ASPEED_KCS_IPMI_BMC=y
# CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
CONFIG_IPMI_KCS_BMC_CDEV_IPMI=m
CONFIG_IPMI_KCS_BMC_SERIO=m
CONFIG_ASPEED_BT_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_ATMEL=m
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_BCM2835=m
CONFIG_HW_RANDOM_IPROC_RNG200=m
CONFIG_HW_RANDOM_IXP4XX=y
CONFIG_HW_RANDOM_OMAP=y
# CONFIG_HW_RANDOM_OMAP3_ROM is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_IMX_RNGC=y
# CONFIG_HW_RANDOM_NOMADIK is not set
# CONFIG_HW_RANDOM_XGENE is not set
CONFIG_HW_RANDOM_STM32=m
CONFIG_HW_RANDOM_MESON=m
CONFIG_HW_RANDOM_MTK=m
CONFIG_HW_RANDOM_EXYNOS=m
CONFIG_HW_RANDOM_OPTEE=m
# CONFIG_HW_RANDOM_NPCM is not set
CONFIG_HW_RANDOM_KEYSTONE=y
CONFIG_HW_RANDOM_CCTRNG=y
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_HW_RANDOM_ARM_SMCCC_TRNG=m
CONFIG_HW_RANDOM_CN10K=m
CONFIG_APPLICOM=m
# CONFIG_DEVMEM is not set
# CONFIG_DEVPORT is not set
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C=m
# CONFIG_TCG_TIS_SYNQUACER is not set
CONFIG_TCG_TIS_I2C_CR50=m
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_ATMEL=m
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_FTPM_TEE=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
# CONFIG_XILLYBUS_OF is not set
CONFIG_XILLYUSB=m
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=m
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=m
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_HIX5HD2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=m
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ALTERA=y
CONFIG_I2C_ASPEED=m
# CONFIG_I2C_AT91 is not set
# CONFIG_I2C_AXXIA is not set
CONFIG_I2C_BCM2835=y
CONFIG_I2C_BCM_IPROC=m
CONFIG_I2C_BCM_KONA=m
# CONFIG_I2C_BRCMSTB is not set
CONFIG_I2C_CADENCE=m
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DAVINCI=y
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DIGICOLOR is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_EXYNOS5=m
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_HIGHLANDER=y
CONFIG_I2C_HISI=y
CONFIG_I2C_IMG=m
# CONFIG_I2C_IMX is not set
CONFIG_I2C_IMX_LPI2C=y
CONFIG_I2C_IOP3XX=m
CONFIG_I2C_JZ4780=y
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_LPC2K is not set
CONFIG_I2C_MESON=y
CONFIG_I2C_MICROCHIP_CORE=m
CONFIG_I2C_MT65XX=m
# CONFIG_I2C_MT7621 is not set
CONFIG_I2C_MV64XXX=m
# CONFIG_I2C_MXS is not set
CONFIG_I2C_NOMADIK=y
# CONFIG_I2C_NPCM is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_OMAP=y
CONFIG_I2C_OWL=m
# CONFIG_I2C_APPLE is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_PNX=y
CONFIG_I2C_PXA=m
# CONFIG_I2C_PXA_SLAVE is not set
CONFIG_I2C_QCOM_CCI=m
CONFIG_I2C_QCOM_GENI=m
# CONFIG_I2C_QUP is not set
CONFIG_I2C_RIIC=m
CONFIG_I2C_RK3X=y
CONFIG_I2C_RZV2M=y
CONFIG_I2C_S3C2410=y
# CONFIG_I2C_SH_MOBILE is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_SPRD=y
CONFIG_I2C_ST=y
CONFIG_I2C_STM32F4=m
CONFIG_I2C_STM32F7=m
CONFIG_I2C_SUN6I_P2WI=y
CONFIG_I2C_SYNQUACER=y
CONFIG_I2C_TEGRA=m
# CONFIG_I2C_TEGRA_BPMP is not set
CONFIG_I2C_UNIPHIER=m
CONFIG_I2C_UNIPHIER_F=y
CONFIG_I2C_VERSATILE=y
# CONFIG_I2C_WMT is not set
CONFIG_I2C_THUNDERX=m
CONFIG_I2C_XILINX=y
# CONFIG_I2C_XLP9XX is not set
# CONFIG_I2C_RCAR is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PCI1XXXX=y
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_XGENE_SLIMPRO is not set
# CONFIG_I2C_FSI is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=y
# CONFIG_SPMI_MSM_PMIC_ARB is not set
CONFIG_SPMI_MTK_PMIF=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_PARPORT=m
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_APPLE_GPIO=y
# CONFIG_PINCTRL_AT91PIO4 is not set
CONFIG_PINCTRL_BM1880=y
CONFIG_PINCTRL_CY8C95X0=y
CONFIG_PINCTRL_DA850_PUPD=y
CONFIG_PINCTRL_DA9062=m
CONFIG_PINCTRL_EQUILIBRIUM=m
# CONFIG_PINCTRL_INGENIC is not set
CONFIG_PINCTRL_KEEMBAY=m
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_PISTACHIO is not set
CONFIG_PINCTRL_ROCKCHIP=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_THUNDERBAY is not set
# CONFIG_PINCTRL_OWL is not set
CONFIG_PINCTRL_ASPEED=y
# CONFIG_PINCTRL_ASPEED_G4 is not set
CONFIG_PINCTRL_ASPEED_G5=y
CONFIG_PINCTRL_ASPEED_G6=y
# CONFIG_PINCTRL_BCM281XX is not set
# CONFIG_PINCTRL_BCM2835 is not set
# CONFIG_PINCTRL_BCM4908 is not set
CONFIG_PINCTRL_BCM63XX=y
CONFIG_PINCTRL_BCM6318=y
CONFIG_PINCTRL_BCM6328=y
# CONFIG_PINCTRL_BCM6358 is not set
# CONFIG_PINCTRL_BCM6362 is not set
# CONFIG_PINCTRL_BCM6368 is not set
# CONFIG_PINCTRL_BCM63268 is not set
CONFIG_PINCTRL_IPROC_GPIO=y
CONFIG_PINCTRL_CYGNUS_MUX=y
# CONFIG_PINCTRL_NS is not set
CONFIG_PINCTRL_NSP_GPIO=y
CONFIG_PINCTRL_NS2_MUX=y
CONFIG_PINCTRL_NSP_MUX=y
CONFIG_PINCTRL_BERLIN=y
CONFIG_PINCTRL_AS370=y
# CONFIG_PINCTRL_BERLIN_BG4CT is not set
# CONFIG_PINCTRL_LOCHNAGAR is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_PINCTRL_IMX=y
CONFIG_PINCTRL_IMX8MM=y
CONFIG_PINCTRL_IMX8MN=y
CONFIG_PINCTRL_IMX8MP=y
CONFIG_PINCTRL_IMX8MQ=y

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_MOORE=y
CONFIG_PINCTRL_MTK_PARIS=y
CONFIG_PINCTRL_MT2701=y
# CONFIG_PINCTRL_MT7623 is not set
# CONFIG_PINCTRL_MT7629 is not set
# CONFIG_PINCTRL_MT8135 is not set
# CONFIG_PINCTRL_MT8127 is not set
# CONFIG_PINCTRL_MT2712 is not set
# CONFIG_PINCTRL_MT6765 is not set
CONFIG_PINCTRL_MT6779=y
# CONFIG_PINCTRL_MT6795 is not set
# CONFIG_PINCTRL_MT6797 is not set
CONFIG_PINCTRL_MT7622=y
# CONFIG_PINCTRL_MT7986 is not set
CONFIG_PINCTRL_MT8167=y
CONFIG_PINCTRL_MT8173=y
# CONFIG_PINCTRL_MT8183 is not set
# CONFIG_PINCTRL_MT8186 is not set
# CONFIG_PINCTRL_MT8188 is not set
# CONFIG_PINCTRL_MT8192 is not set
CONFIG_PINCTRL_MT8195=y
CONFIG_PINCTRL_MT8365=y
CONFIG_PINCTRL_MT8516=y
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

# CONFIG_PINCTRL_MESON is not set
CONFIG_PINCTRL_MVEBU=y
CONFIG_PINCTRL_ARMADA_AP806=y
CONFIG_PINCTRL_ARMADA_CP110=y
CONFIG_PINCTRL_AC5=y
CONFIG_PINCTRL_ARMADA_37XX=y
CONFIG_PINCTRL_WPCM450=m
# CONFIG_PINCTRL_NPCM7XX is not set
CONFIG_PINCTRL_PXA=y
# CONFIG_PINCTRL_PXA25X is not set
CONFIG_PINCTRL_PXA27X=m
# CONFIG_PINCTRL_MSM is not set
CONFIG_PINCTRL_QCOM_SPMI_PMIC=m
CONFIG_PINCTRL_QCOM_SSBI_PMIC=m
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
CONFIG_PINCTRL_RENESAS=y
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
CONFIG_PINCTRL_PFC_EMEV2=y
CONFIG_PINCTRL_PFC_R8A77995=y
CONFIG_PINCTRL_PFC_R8A7794=y
CONFIG_PINCTRL_PFC_R8A77990=y
CONFIG_PINCTRL_PFC_R8A7779=y
# CONFIG_PINCTRL_PFC_R8A7790 is not set
CONFIG_PINCTRL_PFC_R8A77950=y
# CONFIG_PINCTRL_PFC_R8A77951 is not set
# CONFIG_PINCTRL_PFC_R8A7778 is not set
CONFIG_PINCTRL_PFC_R8A7793=y
# CONFIG_PINCTRL_PFC_R8A7791 is not set
CONFIG_PINCTRL_PFC_R8A77965=y
CONFIG_PINCTRL_PFC_R8A77960=y
CONFIG_PINCTRL_PFC_R8A77961=y
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
# CONFIG_PINCTRL_PFC_R8A7792 is not set
CONFIG_PINCTRL_PFC_R8A77980=y
CONFIG_PINCTRL_PFC_R8A77970=y
CONFIG_PINCTRL_PFC_R8A779A0=y
CONFIG_PINCTRL_PFC_R8A779G0=y
CONFIG_PINCTRL_PFC_R8A7740=y
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
CONFIG_PINCTRL_RZA1=y
# CONFIG_PINCTRL_RZA2 is not set
CONFIG_PINCTRL_RZG2L=y
CONFIG_PINCTRL_PFC_R8A77470=y
CONFIG_PINCTRL_PFC_R8A7745=y
CONFIG_PINCTRL_PFC_R8A7742=y
# CONFIG_PINCTRL_PFC_R8A7743 is not set
# CONFIG_PINCTRL_PFC_R8A7744 is not set
CONFIG_PINCTRL_PFC_R8A774C0=y
CONFIG_PINCTRL_PFC_R8A774E1=y
CONFIG_PINCTRL_PFC_R8A774A1=y
CONFIG_PINCTRL_PFC_R8A774B1=y
CONFIG_PINCTRL_RZN1=y
CONFIG_PINCTRL_RZV2M=y
CONFIG_PINCTRL_PFC_SH7203=y
CONFIG_PINCTRL_PFC_SH7264=y
CONFIG_PINCTRL_PFC_SH7269=y
CONFIG_PINCTRL_PFC_SH7720=y
CONFIG_PINCTRL_PFC_SH7722=y
CONFIG_PINCTRL_PFC_SH7734=y
# CONFIG_PINCTRL_PFC_SH7757 is not set
CONFIG_PINCTRL_PFC_SH7785=y
# CONFIG_PINCTRL_PFC_SH7786 is not set
# CONFIG_PINCTRL_PFC_SH73A0 is not set
# CONFIG_PINCTRL_PFC_SH7723 is not set
CONFIG_PINCTRL_PFC_SH7724=y
# CONFIG_PINCTRL_PFC_SHX3 is not set
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
CONFIG_PINCTRL_EXYNOS_ARM=y
CONFIG_PINCTRL_EXYNOS_ARM64=y
# CONFIG_PINCTRL_S3C24XX is not set
CONFIG_PINCTRL_S3C64XX=y
# CONFIG_PINCTRL_SPRD_SC9860 is not set
# CONFIG_PINCTRL_STARFIVE_JH7100 is not set
CONFIG_PINCTRL_STM32=y
CONFIG_PINCTRL_STM32F429=y
CONFIG_PINCTRL_STM32F469=y
# CONFIG_PINCTRL_STM32F746 is not set
# CONFIG_PINCTRL_STM32F769 is not set
# CONFIG_PINCTRL_STM32H743 is not set
CONFIG_PINCTRL_STM32MP135=y
CONFIG_PINCTRL_STM32MP157=y
# CONFIG_PINCTRL_TI_IODELAY is not set
# CONFIG_PINCTRL_UNIPHIER is not set
CONFIG_PINCTRL_VISCONTI=y
CONFIG_PINCTRL_TMPV7700=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
# CONFIG_GPIO_ATH79 is not set
CONFIG_GPIO_RASPBERRYPI_EXP=y
CONFIG_GPIO_BCM_KONA=y
CONFIG_GPIO_BCM_XGS_IPROC=y
# CONFIG_GPIO_BRCMSTB is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_CLPS711X=m
CONFIG_GPIO_DAVINCI=y
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_EIC_SPRD=y
# CONFIG_GPIO_EM is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HISI=y
CONFIG_GPIO_HLWD=m
CONFIG_GPIO_IOP=m
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_LPC18XX=y
# CONFIG_GPIO_LPC32XX is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MPC8XXX is not set
CONFIG_GPIO_MT7621=y
CONFIG_GPIO_MVEBU=y
# CONFIG_GPIO_MXC is not set
CONFIG_GPIO_MXS=y
CONFIG_GPIO_PL061=m
# CONFIG_GPIO_PMIC_EIC_SPRD is not set
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=y
# CONFIG_GPIO_RDA is not set
# CONFIG_GPIO_ROCKCHIP is not set
CONFIG_GPIO_SAMA5D2_PIOBU=m
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_SNPS_CREG=y
# CONFIG_GPIO_SPRD is not set
# CONFIG_GPIO_STP_XWAY is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_TEGRA=m
# CONFIG_GPIO_TEGRA186 is not set
CONFIG_GPIO_TS4800=m
# CONFIG_GPIO_THUNDERX is not set
CONFIG_GPIO_UNIPHIER=y
CONFIG_GPIO_VISCONTI=m
CONFIG_GPIO_VX855=m
CONFIG_GPIO_WCD934X=m
CONFIG_GPIO_XGENE=y
CONFIG_GPIO_XGENE_SB=y
CONFIG_GPIO_XILINX=m
CONFIG_GPIO_XLP=y
CONFIG_GPIO_ZYNQ=y
# CONFIG_GPIO_AMD_FCH is not set
CONFIG_GPIO_IDT3243X=y
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=m
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=m
# CONFIG_GPIO_TPIC2810 is not set
CONFIG_GPIO_TS4900=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD71815=m
# CONFIG_GPIO_BD71828 is not set
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_JANZ_TTL=m
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77650=m
CONFIG_GPIO_SL28CPLD=y
CONFIG_GPIO_STMPE=y
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_TWL4030=y
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_MLXBF=m
CONFIG_GPIO_MLXBF2=m
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=m
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=m
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_MXC=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2430 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=y
CONFIG_POWER_RESET_BRCMKONA=y
CONFIG_POWER_RESET_BRCMSTB=y
# CONFIG_POWER_RESET_GEMINI_POWEROFF is not set
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_MSM=y
CONFIG_POWER_RESET_QCOM_PON=m
# CONFIG_POWER_RESET_OCELOT_RESET is not set
CONFIG_POWER_RESET_PIIX4_POWEROFF=m
CONFIG_POWER_RESET_LTC2952=y
# CONFIG_POWER_RESET_MT6323 is not set
# CONFIG_POWER_RESET_REGULATOR is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_TPS65086=y
# CONFIG_POWER_RESET_XGENE is not set
# CONFIG_POWER_RESET_KEYSTONE is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
# CONFIG_POWER_RESET_RMOBILE is not set
CONFIG_REBOOT_MODE=y
# CONFIG_SYSCON_REBOOT_MODE is not set
# CONFIG_POWER_RESET_SC27XX is not set
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_IP5XXX_POWER is not set
CONFIG_MAX8925_POWER=m
CONFIG_WM831X_BACKUP=m
# CONFIG_WM831X_POWER is not set
CONFIG_TEST_POWER=y
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=m
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=m
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_BATTERY_TWL4030_MADC=m
CONFIG_CHARGER_88PM860X=m
# CONFIG_BATTERY_RX51 is not set
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=m
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_LP8788=m
CONFIG_CHARGER_GPIO=m
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=m
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=m
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_MAX77976=m
CONFIG_CHARGER_MAX8997=m
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_MT6370=m
CONFIG_CHARGER_QCOM_SMBB=m
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=m
CONFIG_CHARGER_BQ256XX=m
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_SC2731=m
CONFIG_FUEL_GAUGE_SC27XX=m
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD99954=y
CONFIG_RN5T618_POWER=m
# CONFIG_BATTERY_ACER_A500 is not set
CONFIG_BATTERY_UG3105=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=m
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=y
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_ARM_SCMI=m
CONFIG_SENSORS_ARM_SCPI=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_BT1_PVT=m
# CONFIG_SENSORS_BT1_PVT_ALARMS is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_SPARX5=y
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LAN966X is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LOCHNAGAR=m
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX31760=y
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_MLXREG_FAN=m
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_TPS23861=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_NSA320=y
CONFIG_SENSORS_OCC_P8_I2C=y
CONFIG_SENSORS_OCC=y
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1266=m
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_BPA_RS600=m
CONFIG_SENSORS_DELTA_AHE50DC_FAN=m
CONFIG_SENSORS_FSP_3Y=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_DPS920AB=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR36021=m
CONFIG_SENSORS_IR38064=m
# CONFIG_SENSORS_IR38064_REGULATOR is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=m
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LM25066_REGULATOR=y
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX15301=m
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX16601=m
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_MP2888=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
CONFIG_SENSORS_PIM4328=m
CONFIG_SENSORS_PLI1209BC=m
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
CONFIG_SENSORS_PM6764TR=m
CONFIG_SENSORS_PXE1610=m
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_TPS546D24=m
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_XDPE152=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_RASPBERRYPI_HWMON=y
CONFIG_SENSORS_SL28CPLD=m
CONFIG_SENSORS_SBTSI=m
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_XGENE=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_CPU_THERMAL=y
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
# CONFIG_THERMAL_MMIO is not set
# CONFIG_HISI_THERMAL is not set
# CONFIG_IMX_THERMAL is not set
# CONFIG_IMX8MM_THERMAL is not set
CONFIG_K3_THERMAL=m
# CONFIG_QORIQ_THERMAL is not set
CONFIG_SPEAR_THERMAL=y
# CONFIG_SUN8I_THERMAL is not set
CONFIG_ROCKCHIP_THERMAL=y
CONFIG_RCAR_THERMAL=y
CONFIG_RCAR_GEN3_THERMAL=m
CONFIG_RZG2L_THERMAL=y
CONFIG_KIRKWOOD_THERMAL=m
# CONFIG_DOVE_THERMAL is not set
# CONFIG_ARMADA_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set
# CONFIG_MTK_THERMAL is not set
CONFIG_AMLOGIC_THERMAL=y

#
# Intel thermal drivers
#

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers
# end of Intel thermal drivers

#
# Broadcom thermal drivers
#
# CONFIG_BCM2711_THERMAL is not set
CONFIG_BCM2835_THERMAL=y
# CONFIG_BRCMSTB_THERMAL is not set
CONFIG_BCM_NS_THERMAL=y
CONFIG_BCM_SR_THERMAL=y
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
# CONFIG_TI_SOC_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
# CONFIG_EXYNOS_THERMAL is not set
# end of Samsung thermal drivers

#
# NVIDIA Tegra thermal drivers
#
# CONFIG_TEGRA_SOCTHERM is not set
CONFIG_TEGRA_BPMP_THERMAL=y
CONFIG_TEGRA30_TSENSOR=y
# end of NVIDIA Tegra thermal drivers

CONFIG_GENERIC_ADC_THERMAL=m

#
# Qualcomm thermal drivers
#
CONFIG_QCOM_TSENS=m
CONFIG_QCOM_SPMI_ADC_TM5=m
# CONFIG_QCOM_SPMI_TEMP_ALARM is not set
CONFIG_QCOM_LMH=m
# end of Qualcomm thermal drivers

CONFIG_UNIPHIER_THERMAL=m
CONFIG_SPRD_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
# CONFIG_SSB_HOST_SOC is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_MIPS is not set
# CONFIG_BCMA_SFLASH is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_SUN4I_GPADC=m
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_AT91_USART=y
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
# CONFIG_MFD_ASIC3 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_ENE_KB3930=m
CONFIG_MFD_EXYNOS_LPASS=y
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=m
# CONFIG_MFD_MXS_LRADC is not set
CONFIG_MFD_MX25_TSADC=m
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=m
CONFIG_MFD_HI655X_PMIC=m
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=y
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=m
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX77714=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6370=y
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_NTXEC=m
CONFIG_MFD_RETU=m
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_PM8XXX=m
CONFIG_MFD_QCOM_RPM=m
CONFIG_MFD_SPMI_PMIC=m
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RT5120=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=m
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SL28CPLD is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
CONFIG_ABX500_CORE=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SUN6I_PRCM=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
CONFIG_TPS65010=y
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=m
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=m
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=m
# CONFIG_MFD_STW481X is not set
CONFIG_MFD_ROHM_BD718XX=m
CONFIG_MFD_ROHM_BD71828=m
CONFIG_MFD_ROHM_BD957XMUF=m
# CONFIG_MFD_STM32_LPTIMER is not set
CONFIG_MFD_STM32_TIMERS=m
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_KHADAS_MCU is not set
CONFIG_MFD_ACER_A500_EC=y
# CONFIG_MFD_QCOM_PM8008 is not set
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_RSMU_I2C=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_ARM_SCMI is not set
CONFIG_REGULATOR_ATC260X=m
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD71815=m
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_BD718XX=m
CONFIG_REGULATOR_BD9571MWV=m
# CONFIG_REGULATOR_BD957XMUF is not set
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9121=y
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=m
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_HI6421 is not set
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_HI655X=m
# CONFIG_REGULATOR_HI6421V600 is not set
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LOCHNAGAR=m
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LP8788 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=m
CONFIG_REGULATOR_MAX77650=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8893=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=y
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=m
CONFIG_REGULATOR_MAX20086=m
# CONFIG_REGULATOR_MAX77686 is not set
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MAX77826=y
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MP5416=m
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6315=m
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6331=m
# CONFIG_REGULATOR_MT6332 is not set
CONFIG_REGULATOR_MT6358=m
# CONFIG_REGULATOR_MT6359 is not set
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6370=y
# CONFIG_REGULATOR_MT6380 is not set
CONFIG_REGULATOR_MT6397=m
# CONFIG_REGULATOR_PBIAS is not set
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_RPM=m
CONFIG_REGULATOR_QCOM_RPMH=m
# CONFIG_REGULATOR_QCOM_SMD_RPM is not set
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_QCOM_USB_VBUS=m
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_ROHM=m
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_RT5120=y
CONFIG_REGULATOR_RT5190A=m
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=m
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SC2731 is not set
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_STM32_BOOSTER=y
CONFIG_REGULATOR_STM32_VREFBUF=m
CONFIG_REGULATOR_STM32_PWR=y
CONFIG_REGULATOR_STPMIC1=m
# CONFIG_REGULATOR_TI_ABB is not set
# CONFIG_REGULATOR_STW481X_VMMC is not set
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=m
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65910=m
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_TPS68470 is not set
CONFIG_REGULATOR_TWL4030=m
# CONFIG_REGULATOR_UNIPHIER is not set
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_VQMMC_IPQ4019 is not set
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8994=m
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=m
# CONFIG_LIRC is not set
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=m
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
CONFIG_CEC_MESON_AO=y
CONFIG_CEC_MESON_G12A_AO=m
CONFIG_CEC_GPIO=m
CONFIG_CEC_SAMSUNG_S5P=y
# CONFIG_CEC_STI is not set
CONFIG_CEC_STM32=m
CONFIG_CEC_TEGRA=m
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_AU0828 is not set
# CONFIG_VIDEO_CX231XX is not set

#
# Digital TV USB devices
#
# CONFIG_DVB_AS102 is not set
CONFIG_DVB_B2C2_FLEXCOP_USB=m
CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG=y
# CONFIG_DVB_USB_V2 is not set
# CONFIG_DVB_USB is not set
CONFIG_SMS_USB_DRV=m
# CONFIG_DVB_TTUSB_BUDGET is not set
CONFIG_DVB_TTUSB_DEC=m

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=m
CONFIG_USB_HACKRF=m
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIM2M is not set
CONFIG_VIDEO_VICODEC=y
CONFIG_VIDEO_VIMC=y
CONFIG_VIDEO_VIVID=m
# CONFIG_VIDEO_VIVID_CEC is not set
CONFIG_VIDEO_VIVID_MAX_DEVS=64
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
CONFIG_VIDEO_V4L2_TPG=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
# CONFIG_VIDEO_IR_I2C is not set

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_SONY_BTF_MPX is not set
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=m
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_UDA1342=y
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
CONFIG_VIDEO_ADV7183=m
# CONFIG_VIDEO_ADV748X is not set
CONFIG_VIDEO_ADV7604=m
# CONFIG_VIDEO_ADV7604_CEC is not set
CONFIG_VIDEO_ADV7842=m
# CONFIG_VIDEO_ADV7842_CEC is not set
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_ISL7998X=m
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_MAX9286=m
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=m
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=y
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_TW9910=y
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_AD9389B=y
CONFIG_VIDEO_ADV7170=y
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=m
CONFIG_VIDEO_ADV7393=m
# CONFIG_VIDEO_ADV7511 is not set
CONFIG_VIDEO_AK881X=m
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_THS8200=m
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_ST_MIPID02=y
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=m
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=y
# CONFIG_MEDIA_TUNER_MT20XX is not set
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
# CONFIG_MEDIA_TUNER_MXL301RF is not set
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_SI2157=m
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA18271=m
# CONFIG_MEDIA_TUNER_TDA827X is not set
# CONFIG_MEDIA_TUNER_TDA8290 is not set
# CONFIG_MEDIA_TUNER_TDA9887 is not set
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_M88DS3103 is not set
# CONFIG_DVB_MXL5XX is not set
CONFIG_DVB_STB0899=y
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
# CONFIG_DVB_STV6110x is not set
CONFIG_DVB_STV6111=m

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
CONFIG_DVB_MN88472=y
# CONFIG_DVB_MN88473 is not set
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24116=m
# CONFIG_DVB_CX24117 is not set
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_CX24123=m
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=m
# CONFIG_DVB_MT312 is not set
CONFIG_DVB_S5H1420=m
CONFIG_DVB_SI21XX=y
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0288=y
# CONFIG_DVB_STV0299 is not set
CONFIG_DVB_STV0900=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
# CONFIG_DVB_TDA8083 is not set
# CONFIG_DVB_TDA8261 is not set
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TS2020=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=y
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=m
# CONFIG_DVB_DIB3000MB is not set
CONFIG_DVB_DIB3000MC=y
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_DRXD is not set
CONFIG_DVB_EC100=y
# CONFIG_DVB_L64781 is not set
# CONFIG_DVB_MT352 is not set
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_SI2168=m
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_TDA10048=m
# CONFIG_DVB_TDA1004X is not set
CONFIG_DVB_ZD1301_DEMOD=y
# CONFIG_DVB_ZL10353 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=m
CONFIG_DVB_TDA10021=y
CONFIG_DVB_TDA10023=y
# CONFIG_DVB_VES1820 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
# CONFIG_DVB_AU8522_DTV is not set
CONFIG_DVB_AU8522_V4L=y
CONFIG_DVB_BCM3510=m
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LGDT330X=y
# CONFIG_DVB_MXL692 is not set
CONFIG_DVB_NXT200X=y
# CONFIG_DVB_OR51132 is not set
# CONFIG_DVB_OR51211 is not set
# CONFIG_DVB_S5H1409 is not set
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=m
# CONFIG_DVB_MB86A20S is not set
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=y
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=y
CONFIG_DVB_AF9033=m
CONFIG_DVB_ASCOT2E=y
CONFIG_DVB_ATBM8830=y
# CONFIG_DVB_HELENE is not set
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=m
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_IX2505V=y
CONFIG_DVB_LGS8GL5=y
# CONFIG_DVB_LGS8GXX is not set
# CONFIG_DVB_LNBH25 is not set
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=y
# CONFIG_DVB_LNBP22 is not set
CONFIG_DVB_M88RS2000=m
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
# CONFIG_DVB_CXD2099 is not set
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_IMX_IPUV3_CORE is not set
# CONFIG_DRM is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_MACMODES=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_ARMCLCD is not set
CONFIG_FB_CLPS711X=m
CONFIG_FB_IMX=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
CONFIG_FB_CONTROL=y
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
# CONFIG_FB_GBE is not set
CONFIG_FB_PVR2=y
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_ATMEL is not set
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=m
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
# CONFIG_FB_WM8505 is not set
CONFIG_FB_PXA168=m
CONFIG_FB_W100=y
CONFIG_FB_SH_MOBILE_LCDC=y
CONFIG_FB_TMIO=m
CONFIG_FB_TMIO_ACCELL=y
# CONFIG_FB_S3C is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_XILINX=y
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_DA8XX is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_SIMPLE=m
CONFIG_FB_SSD1307=m
CONFIG_FB_SM712=m
CONFIG_FB_OMAP_LCD_H3=y
CONFIG_FB_OMAP2=m
# CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
CONFIG_FB_OMAP2_NUM_FBS=3
CONFIG_FB_OMAP2_DSS_INIT=y
CONFIG_FB_OMAP2_DSS=m
# CONFIG_FB_OMAP2_DSS_DEBUG is not set
# CONFIG_FB_OMAP2_DSS_DEBUGFS is not set
# CONFIG_FB_OMAP2_DSS_DPI is not set
CONFIG_FB_OMAP2_DSS_VENC=y
# CONFIG_FB_OMAP4_DSS_HDMI is not set
# CONFIG_FB_OMAP5_DSS_HDMI is not set
# CONFIG_FB_OMAP2_DSS_SDI is not set
# CONFIG_FB_OMAP2_DSS_DSI is not set
CONFIG_FB_OMAP2_DSS_MIN_FCK_PER_PCK=0
CONFIG_FB_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=y

#
# OMAPFB Panel and Encoder Drivers
#
# CONFIG_FB_OMAP2_ENCODER_OPA362 is not set
CONFIG_FB_OMAP2_ENCODER_TFP410=m
CONFIG_FB_OMAP2_ENCODER_TPD12S015=m
CONFIG_FB_OMAP2_CONNECTOR_DVI=m
# CONFIG_FB_OMAP2_CONNECTOR_HDMI is not set
CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV=m
CONFIG_FB_OMAP2_PANEL_DPI=m
# CONFIG_FB_OMAP2_PANEL_DSI_CM is not set
CONFIG_FB_OMAP2_PANEL_SHARP_LS037V7DW01=m
# end of OMAPFB Panel and Encoder Drivers

CONFIG_MMP_DISP=m
CONFIG_MMP_DISP_CONTROLLER=y
CONFIG_MMP_FB=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_OMAP1=m
CONFIG_BACKLIGHT_PWM=m
# CONFIG_BACKLIGHT_DA9052 is not set
CONFIG_BACKLIGHT_MAX8925=m
CONFIG_BACKLIGHT_MT6370=y
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_LM3630A=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=m
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_SKY81452=m
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
# CONFIG_HID is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
CONFIG_HID_PID=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_OF is not set
CONFIG_I2C_HID_OF_ELAN=m
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
# CONFIG_USB_PCI is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_OTG_FSM=m
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_XHCI_HISTB=m
CONFIG_USB_XHCI_MTK=m
CONFIG_USB_XHCI_MVEBU=m
CONFIG_USB_XHCI_RCAR=m
CONFIG_USB_EHCI_BRCMSTB=m
CONFIG_USB_BRCMSTB=m
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_FSL=m
# CONFIG_USB_EHCI_HCD_NPCM7XX is not set
# CONFIG_USB_EHCI_HCD_OMAP is not set
CONFIG_USB_EHCI_HCD_ORION=m
CONFIG_USB_EHCI_HCD_SPEAR=m
# CONFIG_USB_EHCI_HCD_STI is not set
CONFIG_USB_EHCI_HCD_AT91=m
CONFIG_USB_EHCI_SH=y
CONFIG_USB_EHCI_EXYNOS=m
CONFIG_USB_EHCI_MV=m
# CONFIG_USB_CNS3XXX_EHCI is not set
CONFIG_USB_EHCI_HCD_PLATFORM=m
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_ISP1362_HCD=m
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_RENESAS_USBHS_HCD=m
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_SSB=m
# CONFIG_USB_HCD_TEST_MODE is not set
CONFIG_USB_RENESAS_USBHS=m

#
# USB Device Class drivers
#
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_CDNS_SUPPORT is not set
CONFIG_USB_MTU3=m
# CONFIG_USB_MTU3_HOST is not set
# CONFIG_USB_MTU3_GADGET is not set
CONFIG_USB_MTU3_DUAL_ROLE=y
CONFIG_USB_MTU3_DEBUG=y
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
CONFIG_USB_MUSB_GADGET=y
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#
CONFIG_USB_MUSB_TUSB6010=m
CONFIG_USB_MUSB_DSPS=m
# CONFIG_USB_MUSB_UX500 is not set
CONFIG_USB_MUSB_MEDIATEK=m
CONFIG_USB_MUSB_POLARFIRE_SOC=m

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_INVENTRA_DMA=y
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_ULPI is not set
# CONFIG_USB_DWC3_HOST is not set
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_DUAL_ROLE=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_OMAP=m
CONFIG_USB_DWC3_EXYNOS=m
# CONFIG_USB_DWC3_KEYSTONE is not set
CONFIG_USB_DWC3_MESON_G12A=m
# CONFIG_USB_DWC3_OF_SIMPLE is not set
CONFIG_USB_DWC3_ST=m
CONFIG_USB_DWC3_QCOM=m
CONFIG_USB_DWC3_IMX8MP=m
# CONFIG_USB_DWC3_XILINX is not set
# CONFIG_USB_DWC3_AM62 is not set
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=m
# CONFIG_USB_CHIPIDEA_UDC is not set
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_CHIPIDEA_MSM=m
CONFIG_USB_CHIPIDEA_IMX=m
# CONFIG_USB_CHIPIDEA_GENERIC is not set
# CONFIG_USB_CHIPIDEA_TEGRA is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=m
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_USB_QCOM_EUD is not set
CONFIG_APPLE_MFI_FASTCHARGE=m
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=m
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
# CONFIG_USB_EZUSB_FX2 is not set
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_BRCM_USB_PINMAP is not set
CONFIG_USB_ONBOARD_HUB=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_KEYSTONE_USB_PHY=m
CONFIG_NOP_USB_XCEIV=m
CONFIG_AM335X_CONTROL_USB=m
CONFIG_AM335X_PHY_USB=m
CONFIG_USB_GPIO_VBUS=m
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=m
CONFIG_USB_MV_OTG=m
CONFIG_USB_TEGRA_PHY=y
CONFIG_USB_ULPI=y
CONFIG_USB_ULPI_VIEWPORT=y
# CONFIG_JZ4770_PHY is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_LPC32XX=m
CONFIG_USB_FOTG210_UDC=m
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_RENESAS_USBHS_UDC is not set
CONFIG_USB_RENESAS_USB3=m
# CONFIG_USB_PXA27X is not set
CONFIG_USB_MV_UDC=m
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=m
CONFIG_USB_SNP_UDC_PLAT=m
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=m
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_GADGET_XILINX is not set
CONFIG_USB_ASPEED_UDC=m
CONFIG_USB_ASPEED_VHUB=m
CONFIG_USB_DUMMY_HCD=m
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_UVC=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
CONFIG_USB_CONFIGFS_F_LB_SS=y
CONFIG_USB_CONFIGFS_F_FS=y
# CONFIG_USB_CONFIGFS_F_HID is not set
CONFIG_USB_CONFIGFS_F_UVC=y
CONFIG_USB_CONFIGFS_F_PRINTER=y

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=m
CONFIG_USB_ZERO_HNPTEST=y
# CONFIG_USB_GADGETFS is not set
CONFIG_USB_FUNCTIONFS=m
CONFIG_USB_FUNCTIONFS_GENERIC=y
# CONFIG_USB_G_PRINTER is not set
CONFIG_USB_G_HID=m
CONFIG_USB_G_WEBCAM=m
CONFIG_USB_RAW_GADGET=m
# end of USB Gadget precomposed configurations

# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
CONFIG_LEDS_AN30259A=m
# CONFIG_LEDS_ARIEL is not set
CONFIG_LEDS_AW2013=m
CONFIG_LEDS_BCM6328=m
CONFIG_LEDS_BCM6358=m
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_S3C24XX=m
CONFIG_LEDS_COBALT_QUBE=m
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_LP55XX_COMMON is not set
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=m
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_NS2=m
# CONFIG_LEDS_NETXBIG is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_MAX8997=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=m
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_PM8058 is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=m
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_IP30=m
CONFIG_LEDS_ACER_A500=m
CONFIG_LEDS_BCM63138=m
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_MT6360=m
CONFIG_LEDS_RT4505=m
CONFIG_LEDS_RT8515=m
CONFIG_LEDS_SGM3140=m

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=m

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_AL_MC=m
# CONFIG_EDAC_THUNDERX is not set
CONFIG_EDAC_SYNOPSYS=m
# CONFIG_EDAC_XGENE is not set
# CONFIG_EDAC_BLUEFIELD is not set
CONFIG_EDAC_DMC520=m
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
CONFIG_RTC_LIB_KUNIT_TEST=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
# CONFIG_RTC_INTF_PROC is not set
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=m
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_BRCMSTB=y
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_HYM8563=m
# CONFIG_RTC_DRV_LP8788 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=m
# CONFIG_RTC_DRV_MAX8925 is not set
CONFIG_RTC_DRV_MAX8997=y
# CONFIG_RTC_DRV_MAX77686 is not set
CONFIG_RTC_DRV_NCT3018Y=y
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_ISL12026=m
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BD70528=m
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_TWL4030=m
CONFIG_RTC_DRV_TPS65910=m
# CONFIG_RTC_DRV_RC5T619 is not set
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=m
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=m
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=m
# CONFIG_RTC_DRV_RV3029C2 is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_DS1286=y
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=m
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_GAMECUBE=m
CONFIG_RTC_DRV_WM831X=m
# CONFIG_RTC_DRV_SC27XX is not set
CONFIG_RTC_DRV_SPEAR=y
# CONFIG_RTC_DRV_OPTEE is not set
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_NTXEC is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_ASM9260=m
# CONFIG_RTC_DRV_DAVINCI is not set
# CONFIG_RTC_DRV_DIGICOLOR is not set
# CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
CONFIG_RTC_DRV_MESON=y
CONFIG_RTC_DRV_MESON_VRTC=m
CONFIG_RTC_DRV_OMAP=m
CONFIG_RTC_DRV_S3C=m
CONFIG_RTC_DRV_EP93XX=y
CONFIG_RTC_DRV_SH=y
CONFIG_RTC_DRV_PL030=y
CONFIG_RTC_DRV_PL031=m
CONFIG_RTC_DRV_AT91RM9200=m
CONFIG_RTC_DRV_AT91SAM9=y
CONFIG_RTC_DRV_RZN1=m
CONFIG_RTC_DRV_GENERIC=m
# CONFIG_RTC_DRV_VT8500 is not set
# CONFIG_RTC_DRV_SUN6I is not set
CONFIG_RTC_DRV_SUNXI=y
# CONFIG_RTC_DRV_MV is not set
CONFIG_RTC_DRV_ARMADA38X=y
# CONFIG_RTC_DRV_CADENCE is not set
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_STMP=y
CONFIG_RTC_DRV_MC13XXX=y
# CONFIG_RTC_DRV_JZ4740 is not set
CONFIG_RTC_DRV_LPC24XX=m
# CONFIG_RTC_DRV_LPC32XX is not set
# CONFIG_RTC_DRV_PM8XXX is not set
CONFIG_RTC_DRV_TEGRA=y
# CONFIG_RTC_DRV_MXC is not set
CONFIG_RTC_DRV_MXC_V2=y
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_MOXART is not set
# CONFIG_RTC_DRV_MT2712 is not set
CONFIG_RTC_DRV_MT6397=y
# CONFIG_RTC_DRV_MT7622 is not set
# CONFIG_RTC_DRV_XGENE is not set
# CONFIG_RTC_DRV_R7301 is not set
CONFIG_RTC_DRV_STM32=y
# CONFIG_RTC_DRV_RTD119X is not set
# CONFIG_RTC_DRV_ASPEED is not set
# CONFIG_RTC_DRV_TI_K3 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
CONFIG_RTC_DRV_MSC313=y
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=y
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_AMBA_PL08X is not set
# CONFIG_APPLE_ADMAC is not set
# CONFIG_AXI_DMAC is not set
CONFIG_DMA_JZ4780=m
# CONFIG_DMA_SA11X0 is not set
CONFIG_DMA_SUN6I=y
CONFIG_DW_AXI_DMAC=y
CONFIG_EP93XX_DMA=y
CONFIG_FSL_EDMA=m
# CONFIG_FSL_QDMA is not set
# CONFIG_HISI_DMA is not set
CONFIG_IMG_MDC_DMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_INTEL_IOP_ADMA is not set
# CONFIG_K3_DMA is not set
CONFIG_MCF_EDMA=y
CONFIG_MILBEAUT_HDMAC=y
# CONFIG_MILBEAUT_XDMAC is not set
CONFIG_MMP_PDMA=y
CONFIG_MMP_TDMA=m
CONFIG_MV_XOR=y
CONFIG_MV_XOR_V2=y
# CONFIG_MXS_DMA is not set
# CONFIG_NBPFAXI_DMA is not set
# CONFIG_OWL_DMA is not set
# CONFIG_PCH_DMA is not set
# CONFIG_PL330_DMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_STM32_DMA=y
# CONFIG_STM32_DMAMUX is not set
CONFIG_STM32_MDMA=y
CONFIG_SPRD_DMA=y
# CONFIG_S3C24XX_DMAC is not set
CONFIG_TEGRA186_GPC_DMA=m
# CONFIG_TEGRA20_APB_DMA is not set
# CONFIG_TEGRA210_ADMA is not set
CONFIG_TIMB_DMA=m
# CONFIG_UNIPHIER_MDMAC is not set
CONFIG_UNIPHIER_XDMAC=m
# CONFIG_XGENE_DMA is not set
CONFIG_XILINX_DMA=y
CONFIG_XILINX_ZYNQMP_DMA=m
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
CONFIG_MTK_HSDMA=m
CONFIG_MTK_CQDMA=m
CONFIG_QCOM_BAM_DMA=m
CONFIG_QCOM_GPI_DMA=m
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
CONFIG_RZN1_DMAMUX=y
CONFIG_DW_DMAC_PCI=m
CONFIG_DW_EDMA=y
CONFIG_DW_EDMA_PCIE=y
CONFIG_SF_PDMA=m
CONFIG_RENESAS_DMA=y
# CONFIG_SH_DMAE_BASE is not set
# CONFIG_RCAR_DMAC is not set
# CONFIG_RENESAS_USB_DMAC is not set
CONFIG_RZ_DMAC=y
CONFIG_TI_EDMA=m
# CONFIG_DMA_OMAP is not set
CONFIG_TI_K3_UDMA=y
# CONFIG_TI_K3_UDMA_GLUE_LAYER is not set
CONFIG_TI_K3_PSIL=y
CONFIG_TI_DMA_CROSSBAR=y
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=m
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=m
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=m
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=m
CONFIG_UIO_NETX=m
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_UIO_DFL=m
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_PLATFORM=m
CONFIG_VFIO_AMBA=m
CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET=m
# CONFIG_VFIO_PLATFORM_AMDXGBE_RESET is not set
CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET=m
CONFIG_VFIO_MDEV=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=m
CONFIG_COMEDI_SSV_DNP=y
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
CONFIG_COMEDI_ADDI_APCI_1500=m
CONFIG_COMEDI_ADDI_APCI_1516=m
CONFIG_COMEDI_ADDI_APCI_1564=m
CONFIG_COMEDI_ADDI_APCI_16XX=m
# CONFIG_COMEDI_ADDI_APCI_2032 is not set
# CONFIG_COMEDI_ADDI_APCI_2200 is not set
CONFIG_COMEDI_ADDI_APCI_3120=m
CONFIG_COMEDI_ADDI_APCI_3501=m
# CONFIG_COMEDI_ADDI_APCI_3XXX is not set
# CONFIG_COMEDI_ADL_PCI6208 is not set
# CONFIG_COMEDI_ADL_PCI7X3X is not set
CONFIG_COMEDI_ADL_PCI8164=m
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
CONFIG_COMEDI_ADV_PCI1724=m
# CONFIG_COMEDI_ADV_PCI1760 is not set
CONFIG_COMEDI_ADV_PCI_DIO=m
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
CONFIG_COMEDI_AMPLC_PCI230=m
CONFIG_COMEDI_CONTEC_PCI_DIO=m
# CONFIG_COMEDI_DAS08_PCI is not set
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
# CONFIG_COMEDI_MF6X4 is not set
# CONFIG_COMEDI_ICP_MULTI is not set
CONFIG_COMEDI_DAQBOARD2000=m
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
# CONFIG_COMEDI_CB_PCIDAS64 is not set
CONFIG_COMEDI_CB_PCIDAS=m
CONFIG_COMEDI_CB_PCIDDA=m
# CONFIG_COMEDI_CB_PCIMDAS is not set
# CONFIG_COMEDI_CB_PCIMDDA is not set
# CONFIG_COMEDI_ME4000 is not set
CONFIG_COMEDI_ME_DAQ=m
# CONFIG_COMEDI_NI_6527 is not set
CONFIG_COMEDI_NI_65XX=m
CONFIG_COMEDI_NI_660X=m
CONFIG_COMEDI_NI_670X=m
CONFIG_COMEDI_NI_LABPC_PCI=m
CONFIG_COMEDI_NI_PCIDIO=m
CONFIG_COMEDI_NI_PCIMIO=m
# CONFIG_COMEDI_RTD520 is not set
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
# CONFIG_COMEDI_USB_DRIVERS is not set
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
# CONFIG_COMEDI_8255_SA is not set
# CONFIG_COMEDI_KCOMEDILIB is not set
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
CONFIG_COMEDI_TESTS=m
CONFIG_COMEDI_TESTS_EXAMPLE=m
# CONFIG_COMEDI_TESTS_NI_ROUTES is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH=y
CONFIG_GOLDFISH_PIPE=m
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CROS_EC is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=m
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_OLPC_XO175=y
CONFIG_SURFACE_PLATFORMS=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=m

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
CONFIG_CLK_SP810=y
# end of Clock driver for ARM Reference designs

CONFIG_CLK_HSDK=y
CONFIG_COMMON_CLK_APPLE_NCO=m
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_HI655X=m
CONFIG_COMMON_CLK_SCMI=m
CONFIG_COMMON_CLK_SCPI=m
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=m
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_BM1880 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_TPS68470=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_EN7523=y
CONFIG_COMMON_CLK_FSL_FLEXSPI=m
CONFIG_COMMON_CLK_FSL_SAI=y
# CONFIG_COMMON_CLK_GEMINI is not set
CONFIG_COMMON_CLK_LAN966X=m
# CONFIG_COMMON_CLK_ASPEED is not set
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_COMMON_CLK_AXI_CLKGEN=m
CONFIG_CLK_QORIQ=y
CONFIG_CLK_LS1028A_PLLDIG=y
CONFIG_COMMON_CLK_XGENE=y
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_PWM=m
CONFIG_COMMON_CLK_OXNAS=y
CONFIG_COMMON_CLK_RS9_PCIE=m
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_VC7=y
# CONFIG_COMMON_CLK_MMP2_AUDIO is not set
CONFIG_COMMON_CLK_BD718XX=m
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_ACTIONS is not set
CONFIG_CLK_BAIKAL_T1=y
CONFIG_CLK_BT1_CCU_PLL=y
CONFIG_CLK_BT1_CCU_DIV=y
# CONFIG_CLK_BT1_CCU_RST is not set
CONFIG_CLK_BCM2711_DVP=m
CONFIG_CLK_BCM2835=y
CONFIG_CLK_BCM_63XX=y
CONFIG_CLK_BCM_63XX_GATE=y
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
# CONFIG_CLK_BCM_CYGNUS is not set
# CONFIG_CLK_BCM_HR2 is not set
CONFIG_CLK_BCM_NSP=y
CONFIG_CLK_BCM_NS2=y
# CONFIG_CLK_BCM_SR is not set
# CONFIG_CLK_RASPBERRYPI is not set
# CONFIG_COMMON_CLK_HI3516CV300 is not set
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3559A is not set
# CONFIG_COMMON_CLK_HI3660 is not set
CONFIG_COMMON_CLK_HI3670=y
CONFIG_COMMON_CLK_HI3798CV200=y
# CONFIG_COMMON_CLK_HI6220 is not set
CONFIG_RESET_HISI=y
CONFIG_STUB_CLK_HI6220=y
CONFIG_STUB_CLK_HI3660=y
CONFIG_COMMON_CLK_BOSTON=y
CONFIG_MXC_CLK=y
# CONFIG_CLK_IMX8MM is not set
# CONFIG_CLK_IMX8MN is not set
CONFIG_CLK_IMX8MP=m
CONFIG_CLK_IMX8MQ=y
CONFIG_CLK_IMX8ULP=y
CONFIG_CLK_IMX93=m

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
CONFIG_INGENIC_CGU_JZ4740=y
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
CONFIG_INGENIC_CGU_JZ4770=y
# CONFIG_INGENIC_CGU_JZ4780 is not set
CONFIG_INGENIC_CGU_X1000=y
# CONFIG_INGENIC_CGU_X1830 is not set
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

CONFIG_COMMON_CLK_KEYSTONE=y
CONFIG_TI_SCI_CLK=y
# CONFIG_TI_SCI_CLK_PROBE_FROM_FW is not set
# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
# CONFIG_COMMON_CLK_MT2701 is not set
# CONFIG_COMMON_CLK_MT2712 is not set
# CONFIG_COMMON_CLK_MT6765 is not set
# CONFIG_COMMON_CLK_MT6779 is not set
CONFIG_COMMON_CLK_MT6795=y
CONFIG_COMMON_CLK_MT6795_MFGCFG=y
# CONFIG_COMMON_CLK_MT6795_MMSYS is not set
CONFIG_COMMON_CLK_MT6795_VDECSYS=y
# CONFIG_COMMON_CLK_MT6795_VENCSYS is not set
CONFIG_COMMON_CLK_MT6797=y
CONFIG_COMMON_CLK_MT6797_MMSYS=y
CONFIG_COMMON_CLK_MT6797_IMGSYS=y
CONFIG_COMMON_CLK_MT6797_VDECSYS=y
# CONFIG_COMMON_CLK_MT6797_VENCSYS is not set
CONFIG_COMMON_CLK_MT7622=y
# CONFIG_COMMON_CLK_MT7622_ETHSYS is not set
# CONFIG_COMMON_CLK_MT7622_HIFSYS is not set
# CONFIG_COMMON_CLK_MT7622_AUDSYS is not set
# CONFIG_COMMON_CLK_MT7629 is not set
CONFIG_COMMON_CLK_MT7986=y
# CONFIG_COMMON_CLK_MT7986_ETHSYS is not set
# CONFIG_COMMON_CLK_MT8135 is not set
CONFIG_COMMON_CLK_MT8167=y
# CONFIG_COMMON_CLK_MT8167_AUDSYS is not set
CONFIG_COMMON_CLK_MT8167_IMGSYS=y
# CONFIG_COMMON_CLK_MT8167_MFGCFG is not set
CONFIG_COMMON_CLK_MT8167_MMSYS=y
# CONFIG_COMMON_CLK_MT8167_VDECSYS is not set
# CONFIG_COMMON_CLK_MT8173 is not set
CONFIG_COMMON_CLK_MT8183=y
# CONFIG_COMMON_CLK_MT8183_AUDIOSYS is not set
# CONFIG_COMMON_CLK_MT8183_CAMSYS is not set
# CONFIG_COMMON_CLK_MT8183_IMGSYS is not set
CONFIG_COMMON_CLK_MT8183_IPU_CORE0=y
# CONFIG_COMMON_CLK_MT8183_IPU_CORE1 is not set
CONFIG_COMMON_CLK_MT8183_IPU_ADL=y
CONFIG_COMMON_CLK_MT8183_IPU_CONN=y
CONFIG_COMMON_CLK_MT8183_MFGCFG=y
# CONFIG_COMMON_CLK_MT8183_MMSYS is not set
CONFIG_COMMON_CLK_MT8183_VDECSYS=y
CONFIG_COMMON_CLK_MT8183_VENCSYS=y
# CONFIG_COMMON_CLK_MT8186 is not set
# CONFIG_COMMON_CLK_MT8192 is not set
CONFIG_COMMON_CLK_MT8195=y
# CONFIG_COMMON_CLK_MT8365 is not set
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
CONFIG_COMMON_CLK_MESON_REGMAP=m
CONFIG_COMMON_CLK_MESON_DUALDIV=m
CONFIG_COMMON_CLK_MESON_MPLL=m
CONFIG_COMMON_CLK_MESON_PHASE=m
CONFIG_COMMON_CLK_MESON_PLL=m
CONFIG_COMMON_CLK_MESON_SCLK_DIV=m
CONFIG_COMMON_CLK_MESON_VID_PLL_DIV=m
CONFIG_COMMON_CLK_MESON_AO_CLKC=m
CONFIG_COMMON_CLK_MESON_EE_CLKC=m
CONFIG_COMMON_CLK_GXBB=m
CONFIG_COMMON_CLK_AXG=m
CONFIG_COMMON_CLK_AXG_AUDIO=m
# CONFIG_COMMON_CLK_G12A is not set
# end of Clock support for Amlogic platforms

# CONFIG_MSTAR_MSC313_MPLL is not set
# CONFIG_MCHP_CLK_MPFS is not set
CONFIG_ARMADA_AP_CP_HELPER=y
CONFIG_ARMADA_37XX_CLK=y
CONFIG_ARMADA_AP806_SYSCON=y
CONFIG_ARMADA_CP110_SYSCON=y
# CONFIG_COMMON_CLK_PISTACHIO is not set
CONFIG_QCOM_GDSC=y
CONFIG_QCOM_RPMCC=y
CONFIG_COMMON_CLK_QCOM=m
# CONFIG_QCOM_A53PLL is not set
# CONFIG_QCOM_A7PLL is not set
CONFIG_QCOM_CLK_APCS_MSM8916=m
# CONFIG_QCOM_CLK_APCC_MSM8996 is not set
# CONFIG_QCOM_CLK_APCS_SDX55 is not set
CONFIG_QCOM_CLK_RPM=m
CONFIG_QCOM_CLK_SMD_RPM=m
# CONFIG_QCOM_CLK_RPMH is not set
# CONFIG_APQ_GCC_8084 is not set
# CONFIG_APQ_MMCC_8084 is not set
# CONFIG_IPQ_APSS_PLL is not set
# CONFIG_IPQ_APSS_6018 is not set
# CONFIG_IPQ_GCC_4019 is not set
CONFIG_IPQ_GCC_6018=m
CONFIG_IPQ_GCC_806X=m
CONFIG_IPQ_LCC_806X=m
CONFIG_IPQ_GCC_8074=m
# CONFIG_MSM_GCC_8660 is not set
# CONFIG_MSM_GCC_8909 is not set
CONFIG_MSM_GCC_8916=m
CONFIG_MSM_GCC_8939=m
CONFIG_MSM_GCC_8960=m
CONFIG_MSM_LCC_8960=m
# CONFIG_MDM_GCC_9607 is not set
# CONFIG_MDM_GCC_9615 is not set
# CONFIG_MDM_LCC_9615 is not set
# CONFIG_MSM_MMCC_8960 is not set
CONFIG_MSM_GCC_8953=m
CONFIG_MSM_GCC_8974=m
CONFIG_MSM_MMCC_8974=m
# CONFIG_MSM_GCC_8976 is not set
CONFIG_MSM_MMCC_8994=m
CONFIG_MSM_GCC_8994=m
CONFIG_MSM_GCC_8996=m
CONFIG_MSM_MMCC_8996=m
CONFIG_MSM_GCC_8998=m
CONFIG_MSM_GPUCC_8998=m
CONFIG_MSM_MMCC_8998=m
# CONFIG_QCM_GCC_2290 is not set
# CONFIG_QCM_DISPCC_2290 is not set
CONFIG_QCS_GCC_404=m
CONFIG_SC_CAMCC_7180=m
CONFIG_SC_CAMCC_7280=m
CONFIG_SC_DISPCC_7180=m
CONFIG_SC_DISPCC_7280=m
CONFIG_SC_GCC_7180=m
CONFIG_SC_GCC_7280=m
# CONFIG_SC_GCC_8180X is not set
CONFIG_SC_GCC_8280XP=m
CONFIG_SC_GPUCC_7180=m
CONFIG_SC_GPUCC_7280=m
# CONFIG_SC_GPUCC_8280XP is not set
CONFIG_SC_LPASSCC_7280=m
# CONFIG_SC_LPASS_CORECC_7180 is not set
# CONFIG_SC_LPASS_CORECC_7280 is not set
CONFIG_SC_MSS_7180=m
# CONFIG_SC_VIDEOCC_7180 is not set
CONFIG_SC_VIDEOCC_7280=m
CONFIG_SDM_CAMCC_845=m
CONFIG_SDM_GCC_660=m
CONFIG_SDM_MMCC_660=m
CONFIG_SDM_GPUCC_660=m
CONFIG_QCS_TURING_404=m
CONFIG_QCS_Q6SSTOP_404=m
CONFIG_SDM_GCC_845=m
# CONFIG_SDM_GPUCC_845 is not set
CONFIG_SDM_VIDEOCC_845=m
CONFIG_SDM_DISPCC_845=m
# CONFIG_SDM_LPASSCC_845 is not set
CONFIG_SDX_GCC_55=m
# CONFIG_SDX_GCC_65 is not set
CONFIG_SM_CAMCC_8250=m
# CONFIG_SM_CAMCC_8450 is not set
CONFIG_SM_DISPCC_6125=m
CONFIG_SM_DISPCC_8250=m
# CONFIG_SM_GCC_6115 is not set
CONFIG_SM_GCC_6125=m
# CONFIG_SM_GCC_6350 is not set
CONFIG_SM_GCC_6375=m
CONFIG_SM_GCC_8150=m
CONFIG_SM_GCC_8250=m
CONFIG_SM_GCC_8350=m
# CONFIG_SM_GCC_8450 is not set
# CONFIG_SM_GPUCC_6350 is not set
CONFIG_SM_GPUCC_8150=m
CONFIG_SM_GPUCC_8250=m
CONFIG_SM_GPUCC_8350=m
CONFIG_SM_VIDEOCC_8150=m
# CONFIG_SM_VIDEOCC_8250 is not set
CONFIG_SPMI_PMIC_CLKDIV=m
CONFIG_QCOM_HFPLL=m
# CONFIG_KPSS_XCC is not set
CONFIG_CLK_GFM_LPASS_SM8250=m
# CONFIG_CLK_MT7621 is not set
CONFIG_CLK_RENESAS=y
# CONFIG_CLK_EMEV2 is not set
CONFIG_CLK_RZA1=y
# CONFIG_CLK_R7S9210 is not set
CONFIG_CLK_R8A73A4=y
# CONFIG_CLK_R8A7740 is not set
# CONFIG_CLK_R8A7742 is not set
# CONFIG_CLK_R8A7743 is not set
# CONFIG_CLK_R8A7745 is not set
# CONFIG_CLK_R8A77470 is not set
CONFIG_CLK_R8A774A1=y
CONFIG_CLK_R8A774B1=y
CONFIG_CLK_R8A774C0=y
CONFIG_CLK_R8A774E1=y
CONFIG_CLK_R8A7778=y
CONFIG_CLK_R8A7779=y
# CONFIG_CLK_R8A7790 is not set
# CONFIG_CLK_R8A7791 is not set
CONFIG_CLK_R8A7792=y
# CONFIG_CLK_R8A7794 is not set
CONFIG_CLK_R8A7795=y
# CONFIG_CLK_R8A77960 is not set
CONFIG_CLK_R8A77961=y
CONFIG_CLK_R8A77965=y
# CONFIG_CLK_R8A77970 is not set
CONFIG_CLK_R8A77980=y
CONFIG_CLK_R8A77990=y
CONFIG_CLK_R8A77995=y
CONFIG_CLK_R8A779A0=y
CONFIG_CLK_R8A779F0=y
CONFIG_CLK_R8A779G0=y
CONFIG_CLK_R9A06G032=y
CONFIG_CLK_R9A07G043=y
CONFIG_CLK_R9A07G044=y
# CONFIG_CLK_R9A07G054 is not set
CONFIG_CLK_R9A09G011=y
CONFIG_CLK_SH73A0=y
CONFIG_CLK_RCAR_CPG_LIB=y
CONFIG_CLK_RCAR_GEN2_CPG=y
CONFIG_CLK_RCAR_GEN3_CPG=y
CONFIG_CLK_RCAR_GEN4_CPG=y
# CONFIG_CLK_RCAR_USB2_CLOCK_SEL is not set
CONFIG_CLK_RZG2L=y
CONFIG_CLK_RENESAS_CPG_MSSR=y
CONFIG_CLK_RENESAS_CPG_MSTP=y
CONFIG_CLK_RENESAS_DIV6=y
CONFIG_COMMON_CLK_SAMSUNG=y
# CONFIG_S3C64XX_COMMON_CLK is not set
CONFIG_S5PV210_COMMON_CLK=y
# CONFIG_EXYNOS_3250_COMMON_CLK is not set
CONFIG_EXYNOS_4_COMMON_CLK=y
CONFIG_EXYNOS_5250_COMMON_CLK=y
# CONFIG_EXYNOS_5260_COMMON_CLK is not set
CONFIG_EXYNOS_5410_COMMON_CLK=y
# CONFIG_EXYNOS_5420_COMMON_CLK is not set
CONFIG_EXYNOS_ARM64_COMMON_CLK=y
# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
# CONFIG_EXYNOS_CLKOUT is not set
CONFIG_S3C2410_COMMON_CLK=y
# CONFIG_S3C2412_COMMON_CLK is not set
CONFIG_S3C2443_COMMON_CLK=y
CONFIG_TESLA_FSD_COMMON_CLK=y
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
# CONFIG_CLK_INTEL_SOCFPGA32 is not set
CONFIG_CLK_INTEL_SOCFPGA64=y
# CONFIG_SPRD_COMMON_CLK is not set
# CONFIG_CLK_STARFIVE_JH7100 is not set
# CONFIG_CLK_SUNXI is not set
CONFIG_SUNXI_CCU=y
CONFIG_SUNIV_F1C100S_CCU=m
CONFIG_SUN20I_D1_CCU=y
CONFIG_SUN20I_D1_R_CCU=y
CONFIG_SUN50I_A64_CCU=y
CONFIG_SUN50I_A100_CCU=m
CONFIG_SUN50I_A100_R_CCU=m
# CONFIG_SUN50I_H6_CCU is not set
# CONFIG_SUN50I_H616_CCU is not set
# CONFIG_SUN50I_H6_R_CCU is not set
# CONFIG_SUN4I_A10_CCU is not set
CONFIG_SUN5I_CCU=y
# CONFIG_SUN6I_A31_CCU is not set
# CONFIG_SUN6I_RTC_CCU is not set
CONFIG_SUN8I_A23_CCU=y
CONFIG_SUN8I_A33_CCU=y
# CONFIG_SUN8I_A83T_CCU is not set
CONFIG_SUN8I_H3_CCU=y
# CONFIG_SUN8I_V3S_CCU is not set
# CONFIG_SUN8I_DE2_CCU is not set
# CONFIG_SUN8I_R40_CCU is not set
CONFIG_SUN9I_A80_CCU=m
CONFIG_SUN8I_R_CCU=m
# CONFIG_COMMON_CLK_TI_ADPLL is not set
# CONFIG_CLK_UNIPHIER is not set
CONFIG_COMMON_CLK_VISCONTI=y
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=m
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_COMMON_CLK_ZYNQMP=y
CONFIG_CLK_KUNIT_TEST=y
CONFIG_CLK_GATE_KUNIT_TEST=y
CONFIG_HWSPINLOCK=y
# CONFIG_HWSPINLOCK_OMAP is not set
CONFIG_HWSPINLOCK_QCOM=y
CONFIG_HWSPINLOCK_SPRD=y
CONFIG_HWSPINLOCK_STM32=m
# CONFIG_HWSPINLOCK_SUN6I is not set
# CONFIG_HSEM_U8500 is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
CONFIG_BCM2835_TIMER=y
# CONFIG_BCM_KONA_TIMER is not set
CONFIG_DAVINCI_TIMER=y
CONFIG_DIGICOLOR_TIMER=y
CONFIG_OMAP_DM_TIMER=y
CONFIG_DW_APB_TIMER=y
CONFIG_DW_APB_TIMER_OF=y
# CONFIG_FTTMR010_TIMER is not set
# CONFIG_IXP4XX_TIMER is not set
# CONFIG_ROCKCHIP_TIMER is not set
CONFIG_MESON6_TIMER=y
CONFIG_OWL_TIMER=y
# CONFIG_RDA_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
CONFIG_SUN5I_HSTIMER=y
CONFIG_TEGRA_TIMER=y
CONFIG_VT8500_TIMER=y
# CONFIG_NPCM7XX_TIMER is not set
CONFIG_CADENCE_TTC_TIMER=y
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
CONFIG_KEYSTONE_TIMER=y
# CONFIG_INTEGRATOR_AP_TIMER is not set
CONFIG_CLKSRC_PISTACHIO=y
CONFIG_CLKSRC_TI_32K=y
# CONFIG_CLKSRC_STM32_LP is not set
# CONFIG_CLKSRC_MPS2 is not set
# CONFIG_ARC_TIMERS is not set
CONFIG_ARM_ARCH_TIMER=y
# CONFIG_ARM_ARCH_TIMER_EVTSTREAM is not set
CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND=y
CONFIG_FSL_ERRATUM_A008585=y
# CONFIG_HISILICON_ERRATUM_161010101 is not set
# CONFIG_ARM64_ERRATUM_858921 is not set
CONFIG_ARM_TIMER_SP804=y
# CONFIG_ARMV7M_SYSTICK is not set
CONFIG_ATMEL_PIT=y
# CONFIG_ATMEL_ST is not set
CONFIG_CLKSRC_EXYNOS_MCT=y
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
CONFIG_FSL_FTM_TIMER=y
CONFIG_OXNAS_RPS_TIMER=y
CONFIG_SYS_SUPPORTS_SH_CMT=y
CONFIG_MTK_TIMER=y
CONFIG_SPRD_TIMER=y
CONFIG_SYS_SUPPORTS_SH_TMU=y
CONFIG_CLKSRC_JCORE_PIT=y
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
CONFIG_SH_TIMER_TMU=y
CONFIG_EM_TIMER_STI=y
CONFIG_CLKSRC_VERSATILE=y
CONFIG_CLKSRC_PXA=y
# CONFIG_CLKSRC_IMX_GPT is not set
CONFIG_CLKSRC_IMX_TPM=y
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_ST_LPC is not set
CONFIG_GXP_TIMER=y
CONFIG_MSC313E_TIMER=y
# CONFIG_INGENIC_TIMER is not set
CONFIG_INGENIC_SYSOST=y
CONFIG_INGENIC_OST=y
CONFIG_MICROCHIP_PIT64B=y
# CONFIG_GOLDFISH_TIMER is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_APPLE_MAILBOX is not set
# CONFIG_ARM_MHU is not set
# CONFIG_ARM_MHU_V2 is not set
# CONFIG_IMX_MBOX is not set
CONFIG_PLATFORM_MHU=m
# CONFIG_PL320_MBOX is not set
CONFIG_ARMADA_37XX_RWTM_MBOX=y
CONFIG_OMAP2PLUS_MBOX=m
CONFIG_OMAP_MBOX_KFIFO_SIZE=256
CONFIG_ROCKCHIP_MBOX=y
CONFIG_ALTERA_MBOX=y
CONFIG_TI_MESSAGE_MANAGER=y
# CONFIG_HI3660_MBOX is not set
CONFIG_HI6220_MBOX=y
CONFIG_MAILBOX_TEST=m
CONFIG_POLARFIRE_SOC_MAILBOX=y
CONFIG_QCOM_APCS_IPC=m
CONFIG_XGENE_SLIMPRO_MBOX=y
# CONFIG_BCM_PDC_MBOX is not set
CONFIG_BCM_FLEXRM_MBOX=y
CONFIG_STM32_IPCC=y
CONFIG_MTK_ADSP_MBOX=m
CONFIG_MTK_CMDQ_MBOX=y
CONFIG_ZYNQMP_IPI_MBOX=y
# CONFIG_SUN6I_MSGBOX is not set
# CONFIG_SPRD_MBOX is not set
CONFIG_QCOM_IPCC=y
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE=y
# CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST is not set
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S is not set
CONFIG_IOMMU_IO_PGTABLE_DART=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
CONFIG_OMAP_IOMMU=y
CONFIG_OMAP_IOMMU_DEBUG=y
# CONFIG_ROCKCHIP_IOMMU is not set
CONFIG_SUN50I_IOMMU=y
# CONFIG_EXYNOS_IOMMU is not set
CONFIG_IPMMU_VMSA=y
# CONFIG_APPLE_DART is not set
CONFIG_ARM_SMMU=y
CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS=y
# CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is not set
CONFIG_ARM_SMMU_QCOM=y
# CONFIG_ARM_SMMU_QCOM_DEBUG is not set
CONFIG_ARM_SMMU_V3=y
# CONFIG_ARM_SMMU_V3_SVA is not set
CONFIG_S390_CCW_IOMMU=y
CONFIG_S390_AP_IOMMU=y
# CONFIG_MTK_IOMMU is not set
CONFIG_QCOM_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set
# CONFIG_SPRD_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CTRL=m
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_QCOM_GLINK=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#
CONFIG_OWL_PM_DOMAINS_HELPER=y
CONFIG_OWL_PM_DOMAINS=y

#
# Amlogic SoC drivers
#
# CONFIG_MESON_CANVAS is not set
# CONFIG_MESON_CLK_MEASURE is not set
CONFIG_MESON_GX_SOCINFO=y
# CONFIG_MESON_GX_PM_DOMAINS is not set
CONFIG_MESON_EE_PM_DOMAINS=m
CONFIG_MESON_SECURE_PM_DOMAINS=m
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
CONFIG_APPLE_PMGR_PWRSTATE=y
CONFIG_APPLE_RTKIT=m
# CONFIG_APPLE_SART is not set
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=y
# CONFIG_ASPEED_LPC_SNOOP is not set
CONFIG_ASPEED_UART_ROUTING=y
CONFIG_ASPEED_P2A_CTRL=y
CONFIG_ASPEED_SOCINFO=y
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
CONFIG_AT91_SOC_SFR=y

#
# Broadcom SoC drivers
#
# CONFIG_BCM2835_POWER is not set
# CONFIG_SOC_BCM63XX is not set
# CONFIG_SOC_BRCMSTB is not set
CONFIG_BCM_PMB=y
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
# CONFIG_DPAA2_CONSOLE is not set
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
CONFIG_IMX_GPCV2_PM_DOMAINS=y
CONFIG_SOC_IMX8M=y
CONFIG_SOC_IMX9=m
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
CONFIG_IXP4XX_NPE=y
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
# CONFIG_MTK_CMDQ is not set
CONFIG_MTK_DEVAPC=y
CONFIG_MTK_INFRACFG=y
CONFIG_MTK_PMIC_WRAP=y
CONFIG_MTK_SCPSYS=y
CONFIG_MTK_SCPSYS_PM_DOMAINS=y
CONFIG_MTK_MMSYS=y
# end of MediaTek SoC drivers

# CONFIG_POLARFIRE_SOC_SYS_CTRL is not set

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_AOSS_QMP=y
CONFIG_QCOM_COMMAND_DB=m
# CONFIG_QCOM_CPR is not set
CONFIG_QCOM_GENI_SE=m
# CONFIG_QCOM_GSBI is not set
# CONFIG_QCOM_LLCC is not set
CONFIG_QCOM_OCMEM=m
# CONFIG_QCOM_RMTFS_MEM is not set
CONFIG_QCOM_RPMH=m
CONFIG_QCOM_RPMHPD=m
# CONFIG_QCOM_RPMPD is not set
# CONFIG_QCOM_SMEM is not set
CONFIG_QCOM_SMD_RPM=m
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_WCNSS_CTRL is not set
CONFIG_QCOM_ICC_BWMON=m
# end of Qualcomm SoC drivers

CONFIG_SOC_RENESAS=y
CONFIG_ARCH_RCAR_GEN3=y
CONFIG_ARCH_RZG2L=y
CONFIG_ARCH_R8A77995=y
# CONFIG_ARCH_R8A77990 is not set
CONFIG_ARCH_R8A77950=y
# CONFIG_ARCH_R8A77951 is not set
CONFIG_ARCH_R8A77965=y
# CONFIG_ARCH_R8A77960 is not set
CONFIG_ARCH_R8A77961=y
# CONFIG_ARCH_R8A779F0 is not set
# CONFIG_ARCH_R8A77980 is not set
# CONFIG_ARCH_R8A77970 is not set
CONFIG_ARCH_R8A779A0=y
CONFIG_ARCH_R8A779G0=y
CONFIG_ARCH_R8A774C0=y
CONFIG_ARCH_R8A774E1=y
CONFIG_ARCH_R8A774A1=y
CONFIG_ARCH_R8A774B1=y
CONFIG_ARCH_R9A07G043=y
CONFIG_ARCH_R9A07G044=y
# CONFIG_ARCH_R9A07G054 is not set
CONFIG_ARCH_R9A09G011=y
CONFIG_RST_RCAR=y
CONFIG_SYSC_RCAR=y
CONFIG_SYSC_RCAR_GEN4=y
CONFIG_SYSC_R8A77995=y
CONFIG_SYSC_R8A7794=y
# CONFIG_SYSC_R8A77990 is not set
# CONFIG_SYSC_R8A7779 is not set
CONFIG_SYSC_R8A7790=y
CONFIG_SYSC_R8A7795=y
CONFIG_SYSC_R8A7791=y
CONFIG_SYSC_R8A77965=y
CONFIG_SYSC_R8A77960=y
CONFIG_SYSC_R8A77961=y
# CONFIG_SYSC_R8A779F0 is not set
CONFIG_SYSC_R8A7792=y
# CONFIG_SYSC_R8A77980 is not set
# CONFIG_SYSC_R8A77970 is not set
CONFIG_SYSC_R8A779A0=y
CONFIG_SYSC_R8A779G0=y
# CONFIG_SYSC_RMOBILE is not set
CONFIG_SYSC_R8A77470=y
# CONFIG_SYSC_R8A7745 is not set
CONFIG_SYSC_R8A7742=y
# CONFIG_SYSC_R8A7743 is not set
CONFIG_SYSC_R8A774C0=y
CONFIG_SYSC_R8A774E1=y
CONFIG_SYSC_R8A774A1=y
CONFIG_SYSC_R8A774B1=y
# CONFIG_ROCKCHIP_GRF is not set
CONFIG_ROCKCHIP_IODOMAIN=y
CONFIG_ROCKCHIP_PM_DOMAINS=y
CONFIG_ROCKCHIP_DTPM=m
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_CHIPID is not set
CONFIG_EXYNOS_USI=y
CONFIG_EXYNOS_PMU=y
# CONFIG_EXYNOS_PMU_ARM_DRIVERS is not set
CONFIG_EXYNOS_PM_DOMAINS=y
# CONFIG_EXYNOS_REGULATOR_COUPLER is not set
# CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
CONFIG_SOC_TI=y
# CONFIG_TI_SCI_PM_DOMAINS is not set
CONFIG_TI_K3_RINGACC=y
CONFIG_TI_K3_SOCINFO=y
# CONFIG_TI_PRUSS is not set
CONFIG_TI_SCI_INTA_MSI_DOMAIN=y
# CONFIG_UX500_SOC_ID is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
CONFIG_ARM_IMX_BUS_DEVFREQ=y
CONFIG_ARM_IMX8M_DDRC_DEVFREQ=y
CONFIG_ARM_TEGRA_DEVFREQ=y
# CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
# CONFIG_ARM_RK3399_DMC_DEVFREQ is not set
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=m
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=y
CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI=m
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_MAX14577=m
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_QCOM_SPMI_MISC=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=m
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADXL313=m
CONFIG_ADXL313_I2C=m
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
# CONFIG_ADXL355_I2C is not set
CONFIG_ADXL367=m
CONFIG_ADXL367_I2C=m
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=m
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=m
# CONFIG_DA311 is not set
CONFIG_DMARD06=m
CONFIG_DMARD09=m
CONFIG_DMARD10=m
# CONFIG_FXLS8962AF_I2C is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
# CONFIG_IIO_ST_ACCEL_I2C_3AXIS is not set
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7660=m
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
CONFIG_MSA311=m
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=m
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=m
# CONFIG_AD7291 is not set
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD799X=m
CONFIG_ADI_AXI_ADC=m
# CONFIG_ASPEED_ADC is not set
# CONFIG_AT91_ADC is not set
# CONFIG_AT91_SAMA5D2_ADC is not set
# CONFIG_BCM_IPROC_ADC is not set
# CONFIG_BERLIN2_ADC is not set
# CONFIG_CC10001_ADC is not set
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_EXYNOS_ADC=m
CONFIG_FSL_MX25_ADC=m
# CONFIG_HX711 is not set
# CONFIG_INGENIC_ADC is not set
CONFIG_IMX7D_ADC=m
# CONFIG_IMX8QXP_ADC is not set
CONFIG_LP8788_ADC=m
CONFIG_LPC18XX_ADC=m
CONFIG_LPC32XX_ADC=m
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=m
CONFIG_MAX9611=m
# CONFIG_MCP3422 is not set
CONFIG_MEDIATEK_MT6360_ADC=m
CONFIG_MEDIATEK_MT6577_AUXADC=m
CONFIG_MESON_SARADC=m
# CONFIG_MP2629_ADC is not set
CONFIG_NAU7802=m
CONFIG_NPCM_ADC=m
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_PM8XXX_XOADC=m
# CONFIG_QCOM_SPMI_RRADC is not set
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
CONFIG_QCOM_SPMI_ADC5=m
CONFIG_RCAR_GYRO_ADC=m
CONFIG_RN5T618_ADC=m
CONFIG_ROCKCHIP_SARADC=m
# CONFIG_RICHTEK_RTQ6056 is not set
CONFIG_RZG2L_ADC=m
# CONFIG_SC27XX_ADC is not set
# CONFIG_SPEAR_ADC is not set
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_STM32_ADC_CORE=m
CONFIG_STM32_ADC=m
CONFIG_STM32_DFSDM_CORE=m
CONFIG_STM32_DFSDM_ADC=m
# CONFIG_STMPE_ADC is not set
CONFIG_SUN4I_GPADC=m
CONFIG_TI_ADC081C=m
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_AM335X_ADC=m
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
CONFIG_VF610_ADC=m
CONFIG_VIPERBOARD_ADC=m
# CONFIG_XILINX_XADC is not set
CONFIG_XILINX_AMS=m
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_HMC425=m
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=m
CONFIG_BME680_I2C=m
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_PMS7003 is not set
CONFIG_SCD30_CORE=m
# CONFIG_SCD30_I2C is not set
CONFIG_SCD30_SERIAL=m
CONFIG_SCD4X=m
CONFIG_SENSIRION_SGP30=m
CONFIG_SENSIRION_SGP40=m
CONFIG_SPS30=m
CONFIG_SPS30_I2C=m
CONFIG_SPS30_SERIAL=m
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# IIO SCMI Sensors
#
# CONFIG_IIO_SCMI is not set
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=m
# CONFIG_AD5446 is not set
CONFIG_AD5592R_BASE=m
CONFIG_AD5593R=m
CONFIG_AD5686=m
CONFIG_AD5696_I2C=m
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
CONFIG_LPC18XX_DAC=m
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
CONFIG_MAX5821=m
# CONFIG_MCP4725 is not set
CONFIG_STM32_DAC=m
CONFIG_STM32_DAC_CORE=m
# CONFIG_TI_DAC5571 is not set
CONFIG_VF610_DAC=m
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
# CONFIG_FXAS21002C is not set
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
CONFIG_HDC100X=m
# CONFIG_HDC2010 is not set
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTU21=m
CONFIG_SI7005=m
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BOSCH_BNO055=m
CONFIG_BOSCH_BNO055_SERIAL=m
CONFIG_BOSCH_BNO055_I2C=m
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
CONFIG_KMX61=m
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ADJD_S311=m
CONFIG_ADUX1020=m
CONFIG_AL3010=m
# CONFIG_AL3320A is not set
CONFIG_APDS9300=m
CONFIG_APDS9960=m
CONFIG_AS73211=m
CONFIG_BH1750=m
# CONFIG_BH1780 is not set
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
CONFIG_CM3605=m
# CONFIG_CM36651 is not set
CONFIG_GP2AP002=m
CONFIG_GP2AP020A00F=m
CONFIG_IQS621_ALS=m
CONFIG_SENSORS_ISL29018=m
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=m
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
CONFIG_LTRF216A=m
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
CONFIG_MAX44009=m
CONFIG_NOA1305=m
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
CONFIG_SI1133=m
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
CONFIG_TSL2591=m
CONFIG_TSL2772=m
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=m
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_MAG3110=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
# CONFIG_IIO_ST_MAGN_I2C_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
# CONFIG_SENSORS_RM3100_I2C is not set
CONFIG_YAMAHA_YAS530=m
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=m
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

CONFIG_IIO_FORMAT_KUNIT_TEST=m

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
CONFIG_IIO_STM32_TIMER_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=m
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=m
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
CONFIG_MAX5432=m
CONFIG_MCP4018=m
CONFIG_MCP4531=m
CONFIG_TPL0102=m
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_DLHL60D=m
CONFIG_DPS310=m
CONFIG_HP03=m
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=m
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
CONFIG_HP206C=m
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
# CONFIG_MB1232 is not set
CONFIG_PING=m
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX_COMMON=m
CONFIG_SX9310=m
CONFIG_SX9324=m
# CONFIG_SX9360 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
CONFIG_VCNL3020=m
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_IQS620AT_TEMP is not set
CONFIG_MLX90614=m
CONFIG_MLX90632=m
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
# CONFIG_TMP117 is not set
CONFIG_TSYS01=m
# CONFIG_TSYS02D is not set
# end of Temperature sensors

CONFIG_NTB=y
# CONFIG_NTB_MSI is not set
CONFIG_NTB_IDT=m
CONFIG_NTB_EPF=m
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=y
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_ATMEL=m
CONFIG_PWM_ATMEL_TCB=m
CONFIG_PWM_BCM_IPROC=y
CONFIG_PWM_BCM_KONA=m
CONFIG_PWM_BCM2835=m
# CONFIG_PWM_BERLIN is not set
# CONFIG_PWM_BRCMSTB is not set
CONFIG_PWM_CLK=y
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_EP93XX is not set
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_HIBVT=y
CONFIG_PWM_IMG=m
# CONFIG_PWM_IMX1 is not set
CONFIG_PWM_IMX27=m
CONFIG_PWM_IMX_TPM=m
CONFIG_PWM_INTEL_LGM=y
CONFIG_PWM_IQS620A=m
CONFIG_PWM_JZ4740=m
CONFIG_PWM_KEEMBAY=y
CONFIG_PWM_LP3943=m
# CONFIG_PWM_LPC18XX_SCT is not set
CONFIG_PWM_LPC32XX=m
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
CONFIG_PWM_LPSS_PLATFORM=y
# CONFIG_PWM_MESON is not set
CONFIG_PWM_MTK_DISP=y
# CONFIG_PWM_MEDIATEK is not set
# CONFIG_PWM_MXS is not set
# CONFIG_PWM_NTXEC is not set
CONFIG_PWM_OMAP_DMTIMER=m
CONFIG_PWM_PCA9685=m
CONFIG_PWM_PXA=m
# CONFIG_PWM_RASPBERRYPI_POE is not set
CONFIG_PWM_RCAR=y
# CONFIG_PWM_RENESAS_TPU is not set
CONFIG_PWM_ROCKCHIP=m
# CONFIG_PWM_SAMSUNG is not set
CONFIG_PWM_SIFIVE=m
# CONFIG_PWM_SL28CPLD is not set
CONFIG_PWM_SPEAR=y
CONFIG_PWM_SPRD=m
CONFIG_PWM_STI=y
# CONFIG_PWM_STM32 is not set
CONFIG_PWM_STM32_LP=m
# CONFIG_PWM_STMPE is not set
CONFIG_PWM_SUN4I=y
CONFIG_PWM_SUNPLUS=m
# CONFIG_PWM_TEGRA is not set
# CONFIG_PWM_TIECAP is not set
CONFIG_PWM_TIEHRPWM=y
# CONFIG_PWM_TWL is not set
# CONFIG_PWM_TWL_LED is not set
CONFIG_PWM_VISCONTI=y
# CONFIG_PWM_VT8500 is not set
CONFIG_PWM_XILINX=m

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_ARM_GIC_V2M=y
CONFIG_ARM_GIC_V3=y
CONFIG_ARM_GIC_V3_ITS=y
CONFIG_ARM_GIC_V3_ITS_PCI=y
CONFIG_ALPINE_MSI=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# CONFIG_JCORE_AIC is not set
CONFIG_RENESAS_INTC_IRQPIN=y
CONFIG_RENESAS_IRQC=y
CONFIG_RENESAS_RZA1_IRQC=y
CONFIG_RENESAS_RZG2L_IRQC=y
# CONFIG_SL28CPLD_INTC is not set
# CONFIG_TS4800_IRQ is not set
CONFIG_XILINX_INTC=y
# CONFIG_INGENIC_TCU_IRQ is not set
CONFIG_MVEBU_GICP=y
CONFIG_MVEBU_ICU=y
CONFIG_MVEBU_ODMI=y
CONFIG_MVEBU_PIC=y
CONFIG_MVEBU_SEI=y
CONFIG_PARTITION_PERCPU=y
CONFIG_IRQ_UNIPHIER_AIDET=y
CONFIG_MESON_IRQ_GPIO=y
CONFIG_QCOM_PDC=m
CONFIG_QCOM_MPM=m
# CONFIG_IMX_IRQSTEER is not set
CONFIG_IMX_INTMUX=y
CONFIG_IMX_MU_MSI=m
CONFIG_TI_SCI_INTR_IRQCHIP=y
CONFIG_TI_SCI_INTA_IRQCHIP=y
# CONFIG_EXYNOS_IRQ_COMBINER is not set
# CONFIG_MST_IRQ is not set
CONFIG_APPLE_AIC=y
CONFIG_MCHP_EIC=y
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_ARCH_HAS_RESET_CONTROLLER=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_A10SR=m
CONFIG_RESET_ATH79=y
CONFIG_RESET_AXS10X=y
# CONFIG_RESET_BCM6345 is not set
# CONFIG_RESET_BERLIN is not set
CONFIG_RESET_BRCMSTB=m
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_HSDK=y
CONFIG_RESET_IMX7=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_K210=y
CONFIG_RESET_LANTIQ=y
# CONFIG_RESET_LPC18XX is not set
CONFIG_RESET_MCHP_SPARX5=y
CONFIG_RESET_MESON=y
CONFIG_RESET_MESON_AUDIO_ARB=y
CONFIG_RESET_NPCM=y
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_QCOM_AOSS is not set
CONFIG_RESET_QCOM_PDC=m
CONFIG_RESET_RASPBERRYPI=m
CONFIG_RESET_RZG2L_USBPHY_CTRL=m
# CONFIG_RESET_SCMI is not set
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_SOCFPGA is not set
CONFIG_RESET_STARFIVE_JH7100=y
CONFIG_RESET_SUNPLUS=y
# CONFIG_RESET_SUNXI is not set
CONFIG_RESET_TI_SCI=y
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set
CONFIG_RESET_TN48M_CPLD=y
# CONFIG_RESET_UNIPHIER is not set
CONFIG_RESET_UNIPHIER_GLUE=m
# CONFIG_RESET_ZYNQ is not set
CONFIG_COMMON_RESET_HI3660=m
CONFIG_COMMON_RESET_HI6220=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_PHY_LPC18XX_USB_OTG=m
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_XGENE is not set
CONFIG_USB_LGM_PHY=m
# CONFIG_PHY_CAN_TRANSCEIVER is not set
CONFIG_PHY_SUN4I_USB=y
CONFIG_PHY_SUN6I_MIPI_DPHY=y
# CONFIG_PHY_SUN9I_USB is not set
CONFIG_PHY_SUN50I_USB3=y
# CONFIG_PHY_MESON8_HDMI_TX is not set
CONFIG_PHY_MESON8B_USB2=y
CONFIG_PHY_MESON_GXL_USB2=m
CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG=m
# CONFIG_PHY_MESON_G12A_USB2 is not set
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
CONFIG_PHY_MESON_AXG_PCIE=y
CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG=y
CONFIG_PHY_MESON_AXG_MIPI_DPHY=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=m
# CONFIG_PHY_CYGNUS_PCIE is not set
# CONFIG_PHY_BCM_SR_USB is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_BCM_NS_USB2 is not set
CONFIG_PHY_NS2_USB_DRD=m
CONFIG_PHY_BRCM_SATA=m
CONFIG_PHY_BRCM_USB=y
CONFIG_PHY_BCM_SR_PCIE=m
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=y
CONFIG_PHY_CADENCE_SIERRA=y
CONFIG_PHY_CADENCE_SALVO=m
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_MIXEL_LVDS_PHY=y
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
CONFIG_PHY_HI6220_USB=m
# CONFIG_PHY_HI3660_USB is not set
CONFIG_PHY_HI3670_USB=y
CONFIG_PHY_HI3670_PCIE=y
CONFIG_PHY_HISTB_COMBPHY=y
CONFIG_PHY_HISI_INNO_USB2=m
CONFIG_PHY_INGENIC_USB=y
CONFIG_PHY_LANTIQ_VRX200_PCIE=m
CONFIG_PHY_LANTIQ_RCU_USB2=y
# CONFIG_ARMADA375_USBCLUSTER_PHY is not set
CONFIG_PHY_BERLIN_SATA=m
# CONFIG_PHY_BERLIN_USB is not set
CONFIG_PHY_MVEBU_A3700_COMPHY=y
# CONFIG_PHY_MVEBU_A3700_UTMI is not set
CONFIG_PHY_MVEBU_A38X_COMPHY=m
CONFIG_PHY_MVEBU_CP110_COMPHY=y
CONFIG_PHY_MVEBU_CP110_UTMI=y
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
CONFIG_PHY_PXA_USB=m
CONFIG_PHY_MMP3_USB=y
CONFIG_PHY_MMP3_HSIC=y
# CONFIG_PHY_MTK_PCIE is not set
# CONFIG_PHY_MTK_TPHY is not set
CONFIG_PHY_MTK_UFS=y
CONFIG_PHY_MTK_XSPHY=y
CONFIG_PHY_MTK_HDMI=y
CONFIG_PHY_MTK_MIPI_DSI=m
CONFIG_PHY_MTK_DP=y
# CONFIG_PHY_SPARX5_SERDES is not set
CONFIG_PHY_LAN966X_SERDES=y
CONFIG_PHY_CPCAP_USB=m
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_ATH79_USB is not set
# CONFIG_PHY_QCOM_APQ8064_SATA is not set
# CONFIG_PHY_QCOM_EDP is not set
CONFIG_PHY_QCOM_IPQ4019_USB=m
# CONFIG_PHY_QCOM_IPQ806X_SATA is not set
# CONFIG_PHY_QCOM_PCIE2 is not set
CONFIG_PHY_QCOM_QMP=y
# CONFIG_PHY_QCOM_QUSB2 is not set
CONFIG_PHY_QCOM_USB_HS=m
# CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
CONFIG_PHY_QCOM_USB_HSIC=m
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
# CONFIG_PHY_QCOM_USB_SS is not set
CONFIG_PHY_QCOM_IPQ806X_USB=y
CONFIG_PHY_MT7621_PCI=y
# CONFIG_PHY_RALINK_USB is not set
# CONFIG_PHY_RCAR_GEN2 is not set
CONFIG_PHY_RCAR_GEN3_PCIE=y
# CONFIG_PHY_RCAR_GEN3_USB2 is not set
CONFIG_PHY_RCAR_GEN3_USB3=m
CONFIG_PHY_ROCKCHIP_DPHY_RX0=y
CONFIG_PHY_ROCKCHIP_INNO_HDMI=m
CONFIG_PHY_ROCKCHIP_INNO_USB2=m
CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY=y
CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
CONFIG_PHY_ROCKCHIP_PCIE=y
# CONFIG_PHY_ROCKCHIP_SNPS_PCIE3 is not set
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
CONFIG_PHY_EXYNOS_DP_VIDEO=y
CONFIG_PHY_EXYNOS_MIPI_VIDEO=m
# CONFIG_PHY_EXYNOS_PCIE is not set
CONFIG_PHY_SAMSUNG_UFS=m
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_EXYNOS5_USBDRD=m
CONFIG_PHY_UNIPHIER_USB2=m
CONFIG_PHY_UNIPHIER_USB3=m
CONFIG_PHY_UNIPHIER_PCIE=y
CONFIG_PHY_UNIPHIER_AHCI=m
# CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
# CONFIG_PHY_STIH407_USB is not set
# CONFIG_PHY_STM32_USBPHYC is not set
# CONFIG_PHY_SUNPLUS_USB is not set
# CONFIG_PHY_TEGRA194_P2U is not set
CONFIG_PHY_DA8XX_USB=m
CONFIG_PHY_DM816X_USB=m
CONFIG_PHY_AM654_SERDES=m
CONFIG_PHY_J721E_WIZ=y
CONFIG_OMAP_CONTROL_PHY=m
CONFIG_OMAP_USB2=m
# CONFIG_TI_PIPE3 is not set
CONFIG_PHY_TUSB1210=m
CONFIG_PHY_INTEL_KEEMBAY_EMMC=m
CONFIG_PHY_INTEL_KEEMBAY_USB=y
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=m
# CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_DTPM=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_ARM_CCI_PMU is not set
CONFIG_ARM_CCN=m
CONFIG_ARM_CMN=m
CONFIG_ARM_PMU=y
CONFIG_ARM_SMMU_V3_PMU=y
CONFIG_ARM_DSU_PMU=m
CONFIG_FSL_IMX8_DDR_PMU=m
# CONFIG_XGENE_PMU is not set
CONFIG_ARM_SPE_PMU=y
# CONFIG_ARM_DMC620_PMU is not set
CONFIG_MARVELL_CN10K_TAD_PMU=y
# CONFIG_APPLE_M1_CPU_PMU is not set
CONFIG_ALIBABA_UNCORE_DRW_PMU=y
# CONFIG_HISI_PCIE_PMU is not set
CONFIG_HNS3_PMU=m
CONFIG_MARVELL_CN10K_DDR_PMU=y
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=m
# CONFIG_USB4_DEBUGFS_WRITE is not set
CONFIG_USB4_KUNIT_TEST=y
CONFIG_USB4_DMA_TEST=m

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_APPLE_EFUSES is not set
CONFIG_NVMEM_BCM_OCOTP=m
CONFIG_NVMEM_BRCM_NVRAM=m
# CONFIG_NVMEM_IMX_IIM is not set
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_NVMEM_JZ4780_EFUSE is not set
CONFIG_NVMEM_LAN9662_OTPC=y
CONFIG_NVMEM_LAYERSCAPE_SFP=m
CONFIG_NVMEM_LPC18XX_EEPROM=m
CONFIG_NVMEM_LPC18XX_OTP=y
CONFIG_NVMEM_MESON_EFUSE=m
# CONFIG_NVMEM_MESON_MX_EFUSE is not set
CONFIG_NVMEM_MICROCHIP_OTPC=m
# CONFIG_NVMEM_MTK_EFUSE is not set
CONFIG_NVMEM_MXS_OCOTP=m
CONFIG_NVMEM_NINTENDO_OTP=m
CONFIG_NVMEM_QCOM_QFPROM=m
# CONFIG_NVMEM_RMEM is not set
CONFIG_NVMEM_ROCKCHIP_EFUSE=m
# CONFIG_NVMEM_ROCKCHIP_OTP is not set
CONFIG_NVMEM_SC27XX_EFUSE=m
CONFIG_NVMEM_SNVS_LPGPR=y
CONFIG_NVMEM_SPMI_SDAM=y
CONFIG_NVMEM_SPRD_EFUSE=y
# CONFIG_NVMEM_STM32_ROMEM is not set
CONFIG_NVMEM_SUNPLUS_OCOTP=m
CONFIG_NVMEM_UNIPHIER_EFUSE=y
CONFIG_NVMEM_VF610_OCOTP=m
CONFIG_NVMEM_ZYNQMP=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
CONFIG_HISI_PTT=y
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_FPGA_MGR_SOCFPGA=m
# CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_ZYNQ_FPGA=m
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
CONFIG_FPGA_DFL_FME_MGR=m
CONFIG_FPGA_DFL_FME_BRIDGE=m
CONFIG_FPGA_DFL_FME_REGION=m
CONFIG_FPGA_DFL_AFU=m
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
CONFIG_FPGA_DFL_PCI=m
CONFIG_FPGA_MGR_ZYNQMP_FPGA=m
CONFIG_FPGA_MGR_VERSAL_FPGA=m
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=m
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_MASTER_ASPEED=y
# CONFIG_FSI_SCOM is not set
# CONFIG_FSI_SBEFIFO is not set
CONFIG_TEE=m
CONFIG_OPTEE=m
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
# CONFIG_INTERCONNECT_IMX is not set
CONFIG_INTERCONNECT_QCOM=y
CONFIG_INTERCONNECT_QCOM_BCM_VOTER=m
CONFIG_INTERCONNECT_QCOM_MSM8916=m
CONFIG_INTERCONNECT_QCOM_MSM8939=m
CONFIG_INTERCONNECT_QCOM_MSM8974=m
CONFIG_INTERCONNECT_QCOM_MSM8996=m
# CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
CONFIG_INTERCONNECT_QCOM_QCM2290=m
# CONFIG_INTERCONNECT_QCOM_QCS404 is not set
CONFIG_INTERCONNECT_QCOM_RPMH_POSSIBLE=m
CONFIG_INTERCONNECT_QCOM_RPMH=m
# CONFIG_INTERCONNECT_QCOM_SC7180 is not set
CONFIG_INTERCONNECT_QCOM_SC7280=m
# CONFIG_INTERCONNECT_QCOM_SC8180X is not set
CONFIG_INTERCONNECT_QCOM_SC8280XP=m
CONFIG_INTERCONNECT_QCOM_SDM660=m
CONFIG_INTERCONNECT_QCOM_SDM845=m
# CONFIG_INTERCONNECT_QCOM_SDX55 is not set
# CONFIG_INTERCONNECT_QCOM_SDX65 is not set
CONFIG_INTERCONNECT_QCOM_SM6350=m
CONFIG_INTERCONNECT_QCOM_SM8150=m
# CONFIG_INTERCONNECT_QCOM_SM8250 is not set
# CONFIG_INTERCONNECT_QCOM_SM8350 is not set
CONFIG_INTERCONNECT_QCOM_SM8450=m
CONFIG_INTERCONNECT_QCOM_SMD_RPM=m
CONFIG_INTERCONNECT_SAMSUNG=y
CONFIG_INTERCONNECT_EXYNOS=m
# CONFIG_COUNTER is not set
CONFIG_MOST=m
CONFIG_MOST_USB_HDM=m
CONFIG_MOST_CDEV=m
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=m
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
# CONFIG_INOTIFY_USER is not set
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=m
# CONFIG_FUSE_DAX is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_DEBUG=y
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
# CONFIG_PROC_SYSCTL is not set
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_CRAMFS=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_LZ4HC_COMPRESS=m
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="842"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=m
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=m
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
CONFIG_UNICODE=m
CONFIG_UNICODE_NORMALIZATION_SELFTEST=m
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_ENGINE=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_AEGIS128_SIMD=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_VMAC=y
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
# CONFIG_CRYPTO_CRC32C is not set
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_NHPOLY1305_NEON=y
# CONFIG_CRYPTO_CHACHA20_NEON is not set

#
# Accelerated Cryptographic Algorithms for CPU (arm64)
#
CONFIG_CRYPTO_GHASH_ARM64_CE=y
CONFIG_CRYPTO_POLY1305_NEON=m
CONFIG_CRYPTO_SHA1_ARM64_CE=m
CONFIG_CRYPTO_SHA256_ARM64=m
CONFIG_CRYPTO_SHA2_ARM64_CE=m
CONFIG_CRYPTO_SHA512_ARM64=m
# CONFIG_CRYPTO_SHA512_ARM64_CE is not set
CONFIG_CRYPTO_SHA3_ARM64=y
CONFIG_CRYPTO_SM3_ARM64_CE=y
CONFIG_CRYPTO_POLYVAL_ARM64_CE=m
CONFIG_CRYPTO_AES_ARM64=m
CONFIG_CRYPTO_AES_ARM64_CE=y
# CONFIG_CRYPTO_AES_ARM64_CE_BLK is not set
CONFIG_CRYPTO_AES_ARM64_NEON_BLK=m
CONFIG_CRYPTO_AES_ARM64_BS=m
CONFIG_CRYPTO_SM4_ARM64_CE=m
# CONFIG_CRYPTO_SM4_ARM64_CE_BLK is not set
# CONFIG_CRYPTO_SM4_ARM64_NEON_BLK is not set
CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
CONFIG_CRYPTO_CRCT10DIF_ARM64_CE=m
# end of Accelerated Cryptographic Algorithms for CPU (arm64)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_ALLWINNER=y
# CONFIG_CRYPTO_DEV_SUN8I_CE is not set
CONFIG_CRYPTO_DEV_SUN8I_SS=m
CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG=y
# CONFIG_CRYPTO_DEV_SUN8I_SS_PRNG is not set
CONFIG_CRYPTO_DEV_SUN8I_SS_HASH=y
CONFIG_CRYPTO_DEV_SL3516=y
# CONFIG_CRYPTO_DEV_SL3516_DEBUG is not set
# CONFIG_CRYPTO_DEV_EXYNOS_RNG is not set
# CONFIG_CRYPTO_DEV_S5P is not set
# CONFIG_CRYPTO_DEV_ATMEL_AES is not set
CONFIG_CRYPTO_DEV_ATMEL_TDES=y
# CONFIG_CRYPTO_DEV_ATMEL_SHA is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=y
# CONFIG_CRYPTO_DEV_SP_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
CONFIG_CRYPTO_DEV_QAT_4XXX=m
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_CPT=y
CONFIG_CAVIUM_CPT=y
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_MARVELL=m
# CONFIG_CRYPTO_DEV_MARVELL_CESA is not set
CONFIG_CRYPTO_DEV_OCTEONTX_CPT=m
CONFIG_CRYPTO_DEV_CAVIUM_ZIP=y
# CONFIG_CRYPTO_DEV_QCE is not set
CONFIG_CRYPTO_DEV_QCOM_RNG=y
CONFIG_CRYPTO_DEV_IMGTEC_HASH=m
CONFIG_CRYPTO_DEV_ZYNQMP_AES=y
# CONFIG_CRYPTO_DEV_ZYNQMP_SHA3 is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_CRYPTO_DEV_CCREE=y
CONFIG_CRYPTO_DEV_HISI_SEC=m
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
CONFIG_CRYPTO_DEV_SA2UL=y
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC is not set
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU=m
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU_HMAC_SHA224 is not set
# CONFIG_CRYPTO_DEV_ASPEED is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
# CONFIG_MODULE_SIG_KEY_TYPE_RSA is not set
CONFIG_MODULE_SIG_KEY_TYPE_ECDSA=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_HAVE_ARCH_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_INDIRECT_PIO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=9
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=m
CONFIG_CRC4=y
CONFIG_CRC7=y
# CONFIG_LIBCRC32C is not set
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_AUDIT_ARCH_COMPAT_GENERIC=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
CONFIG_ARCH_HAS_DMA_PREP_COHERENT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_RESTRICTED_POOL is not set
CONFIG_DMA_NONCOHERENT_MMAP=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_DIRECT_REMAP=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_FORCE_NR_CPUS=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_SPLIT=y
CONFIG_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
# CONFIG_PARMAN is not set
CONFIG_OBJAGG=m
# end of Library routines

CONFIG_GENERIC_IOREMAP=y
CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y
CONFIG_POLYNOMIAL=m

#
# Kernel hacking
#

#
# printk and dmesg options
#
# CONFIG_PRINTK_TIME is not set
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
# CONFIG_DEBUG_BUGVERBOSE is not set
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_AS_HAS_NON_CONST_LEB128=y
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_VMLINUX_MAP is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_KGDB=y
# CONFIG_KGDB_HONOUR_BLOCKLIST is not set
# CONFIG_KGDB_TESTS is not set
# CONFIG_KGDB_KDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
# CONFIG_UBSAN_BOUNDS is not set
# CONFIG_UBSAN_SHIFT is not set
CONFIG_UBSAN_DIV_ZERO=y
CONFIG_UBSAN_UNREACHABLE=y
CONFIG_UBSAN_BOOL=y
CONFIG_UBSAN_ENUM=y
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_SW_TAGS=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_KOBJECT_RELEASE=y

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set

#
# arm64 Debugging
#
CONFIG_PID_IN_CONTEXTIDR=y
CONFIG_ARM64_RELOC_TEST=m
CONFIG_CORESIGHT=m
CONFIG_CORESIGHT_LINKS_AND_SINKS=m
CONFIG_CORESIGHT_LINK_AND_SINK_TMC=m
CONFIG_CORESIGHT_CATU=m
CONFIG_CORESIGHT_SINK_TPIU=m
CONFIG_CORESIGHT_SINK_ETBV10=m
CONFIG_CORESIGHT_SOURCE_ETM4X=m
# CONFIG_ETM4X_IMPDEF_FEATURE is not set
# CONFIG_CORESIGHT_STM is not set
CONFIG_CORESIGHT_CPU_DEBUG=m
# CONFIG_CORESIGHT_CPU_DEBUG_DEFAULT_ON is not set
CONFIG_CORESIGHT_CTI=m
# CONFIG_CORESIGHT_CTI_INTEGRATION_REGS is not set
# CONFIG_CORESIGHT_TRBE is not set
# end of arm64 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
# CONFIG_KUNIT_DEFAULT_ENABLED is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAULT_INJECTION_USERCOPY=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking

CONFIG_WARN_MISSING_DOCUMENTS=y
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--F1MOaMtzXsGkYEuw--
