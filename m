Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E07681864
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbjA3SL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjA3SLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:11:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B132131
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675102278; x=1706638278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gXD0R29Ib6o2ty6I1G9sKFWkOOk8CVk6fMR1Zb5Z1wU=;
  b=THPltPuOti1R+pbj9PmrYG5sBuqdJGHJxxGDa4XOZCLbZtiqRl0We2iz
   poYi0LqSd5aomqqCJvOhx7GiTcL0x7UqIW/UIMFQ14bFEaPcsN/vfhKbJ
   BccXl11/keaMYj9sx2wnv0B/GHWXV4yBPtRnLG7V8OIG/VNUjOH4GMnnJ
   fFP22RelShQZpKxcxwle8NIbM0CLBXhsmkx9M9+JXg26JECPs7kmGs2u9
   MzT2RvbeYVFZO/YO5H9eDi07WZScOK5uG9STg2sFfTtYND/eET99Le9LF
   F9N/q9Szhi/CG8yO83WmhaKEHiW9OdObjh/rEVxc63y5AVjk91KV9e9gC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327651838"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="327651838"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:11:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="694653248"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="694653248"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Jan 2023 10:11:15 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMYcc-0003oA-20;
        Mon, 30 Jan 2023 18:11:14 +0000
Date:   Tue, 31 Jan 2023 02:10:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>, linux@armlinux.org.uk,
        arnd@arndb.de
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        ndesaulniers@google.com, trix@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] ARM: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
Message-ID: <202301310149.euWWUSrD-lkp@intel.com>
References: <20230118-v4-v4t-lld-16-v1-1-e3d9a00ae47c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118-v4-v4t-lld-16-v1-1-e3d9a00ae47c@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 5dc4c995db9eb45f6373a956eb1f69460e69e6d4]

url:    https://github.com/intel-lab-lkp/linux/commits/Nathan-Chancellor/ARM-Allow-pre-ARMv5-builds-with-ld-lld-16-0-0-and-newer/20230119-032402
base:   5dc4c995db9eb45f6373a956eb1f69460e69e6d4
patch link:    https://lore.kernel.org/r/20230118-v4-v4t-lld-16-v1-1-e3d9a00ae47c%40kernel.org
patch subject: [PATCH] ARM: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
config: arm-shannon_defconfig (https://download.01.org/0day-ci/archive/20230131/202301310149.euWWUSrD-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/197c1476db190ad6d2afe14bc0f90de0e82f63b6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nathan-Chancellor/ARM-Allow-pre-ARMv5-builds-with-ld-lld-16-0-0-and-newer/20230119-032402
        git checkout 197c1476db190ad6d2afe14bc0f90de0e82f63b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-sa1100/ drivers/gpio/ drivers/video/fbdev/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-sa1100/pm.c:122:12: warning: no previous prototype for function 'sa11x0_pm_init' [-Wmissing-prototypes]
   int __init sa11x0_pm_init(void)
              ^
   arch/arm/mach-sa1100/pm.c:122:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init sa11x0_pm_init(void)
   ^
   static 
   1 warning generated.
--
>> drivers/gpio/gpio-sa1100.c:309:13: warning: no previous prototype for function 'sa1100_init_gpio' [-Wmissing-prototypes]
   void __init sa1100_init_gpio(void)
               ^
   drivers/gpio/gpio-sa1100.c:309:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init sa1100_init_gpio(void)
   ^
   static 
   1 warning generated.
--
>> drivers/video/fbdev/sa1100fb.c:1219:12: warning: no previous prototype for function 'sa1100fb_init' [-Wmissing-prototypes]
   int __init sa1100fb_init(void)
              ^
   drivers/video/fbdev/sa1100fb.c:1219:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init sa1100fb_init(void)
   ^
   static 
   1 warning generated.


vim +/sa11x0_pm_init +122 arch/arm/mach-sa1100/pm.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  121  
7fea1ba58e61c1 Shawn Guo      2012-04-26 @122  int __init sa11x0_pm_init(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
