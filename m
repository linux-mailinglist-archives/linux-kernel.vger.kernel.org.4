Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEB15E60F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiIVL2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiIVL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:27:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B40DF3A3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663846062; x=1695382062;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FgJ9nNz/vzLaS4WX2fhDFxkYknwbFT4sEjE+pFd9WeI=;
  b=IMFh4VJIPo+oKtocit6cdYaSF6Fo3S/FD4oiaQvm9MokwaCJhJSVgbvm
   BlgdpihCHDmMU2KQHSTRLtIzLCOJOQe9ZRQkt/0UTJNfAZkbh8l1GaUpJ
   IlcEgL7blS9Vydy7P7B9lF4yZTZs5ZXJ1RWIIRIf50B4bX1Kffj3mhfJB
   Ofsiwl26OJRms1Wq72dUUo+1NMG2rbGQs6mFnPiYN0zQXTvL7+5V/Ij0e
   uNl1yAzb/JMpaDPkWxn/wURNTfqOgy5WjGEmOJ8H5WtvI8y9tCviTQvxt
   Qk/C1ab+zossl5gWqQSEBf3YhMcE5tkzwZAkcC4HD3OiSQMJCBOK25mT9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="287350576"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="287350576"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 04:27:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="652932094"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Sep 2022 04:27:22 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obKMU-0004eg-09;
        Thu, 22 Sep 2022 11:27:22 +0000
Date:   Thu, 22 Sep 2022 19:26:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [ammarfaizi2-block:arm64/linux/for-next/alternatives 7/9]
 arch/arm64/include/asm/alternative-macros.h:224:2: error: call to undeclared
 function 'BUILD_BUG_ON'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202209221916.DuPaZviq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/for-next/alternatives
head:   0072dc1b53c39fb7c4cfc5c9e5d5a30622198613
commit: 21fb26bfb01ffe0d9a9a967ffe061092128bbffe [7/9] arm64: alternatives: add alternative_has_feature_*()
config: arm64-buildonly-randconfig-r006-20220921 (https://download.01.org/0day-ci/archive/20220922/202209221916.DuPaZviq-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/21fb26bfb01ffe0d9a9a967ffe061092128bbffe
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/for-next/alternatives
        git checkout 21fb26bfb01ffe0d9a9a967ffe061092128bbffe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/arm64/linux/for-next/alternatives HEAD 0072dc1b53c39fb7c4cfc5c9e5d5a30622198613 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from kernel/bounds.c:10:
   In file included from include/linux/page-flags.h:10:
   In file included from include/linux/bug.h:5:
   In file included from arch/arm64/include/asm/bug.h:26:
   In file included from include/asm-generic/bug.h:5:
   In file included from include/linux/compiler.h:248:
   In file included from arch/arm64/include/asm/rwonce.h:11:
>> arch/arm64/include/asm/alternative-macros.h:224:2: error: call to undeclared function 'BUILD_BUG_ON'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           BUILD_BUG_ON(feature >= ARM64_NCAPS);
           ^
   arch/arm64/include/asm/alternative-macros.h:241:2: error: call to undeclared function 'BUILD_BUG_ON'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           BUILD_BUG_ON(feature >= ARM64_NCAPS);
           ^
   2 errors generated.
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1205: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/BUILD_BUG_ON +224 arch/arm64/include/asm/alternative-macros.h

   220	
   221	static __always_inline bool
   222	alternative_has_feature_likely(unsigned long feature)
   223	{
 > 224		BUILD_BUG_ON(feature >= ARM64_NCAPS);
   225	
   226		asm_volatile_goto(
   227		ALTERNATIVE("b	%l[l_no]", "nop", %[feature])
   228		:
   229		: [feature] "i" (feature)
   230		:
   231		: l_no);
   232	
   233		return true;
   234	l_no:
   235		return false;
   236	}
   237	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
