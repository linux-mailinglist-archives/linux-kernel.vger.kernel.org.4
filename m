Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549FB5B6556
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIMCEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiIMCEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:04:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537BB9FEA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663034681; x=1694570681;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aq5CkD5R3lhPprQbjFiFBDcrgms+a4ueawvlYQspySI=;
  b=ThjwZJrmWRHBU3pnxOyTzfC9OptgMNlmfZ/oHTMHHM7X78FF+lxGNOOQ
   yEBpX9VPDgQKg07u9xrnk6Rmzq0MxX6pLLBuH4gEA7jJkfIr7eI7RHOex
   dafSuqu4XMrjgXPcA9AEUOSAAASw5S1WS2Uzn1/tJLEF2vS0TmIaCRhes
   Mx+u0Y1C9wDb8XSHFiRf2GbNWm3bjoUsQeiT4dvcIJTWz4qsYhfUqpApk
   mEKB1MK5Evb31FCvaT+TjEYQ9Wg2KRFFETbOgfOSgit6S3N1PfW/OvBID
   Kj93Zo5RYwLbr/Trb/3qMP61nRQSdagfo/4851BJWEaholfNYJeqGo8NM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298017343"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="298017343"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 19:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="649473690"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Sep 2022 19:04:39 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXvHy-00035X-2d;
        Tue, 13 Sep 2022 02:04:38 +0000
Date:   Tue, 13 Sep 2022 10:04:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 11/39]
 arch/x86/coco/tdx/tdx.c:298:14: warning: no previous prototype for function
 'tdx_write_msr'
Message-ID: <202209131039.Nv0agYnN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

FYI, the error/warning still remains.

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   1f71e25a309e1f46dadb7c65e4383c3690dcd3be
commit: a9189da9f0413f85d9072894ccb973cf785d2c0d [11/39] x86/tdx: Use direct paravirt call for wrmsrl
config: x86_64-randconfig-r025-20220912 (https://download.01.org/0day-ci/archive/20220913/202209131039.Nv0agYnN-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/a9189da9f0413f85d9072894ccb973cf785d2c0d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout a9189da9f0413f85d9072894ccb973cf785d2c0d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/tdx.c:298:14: warning: no previous prototype for function 'tdx_write_msr' [-Wmissing-prototypes]
   void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
                ^
   arch/x86/coco/tdx/tdx.c:298:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
   ^
   static 
   1 warning generated.


vim +/tdx_write_msr +298 arch/x86/coco/tdx/tdx.c

   297	
 > 298	void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
   299	{
   300		struct tdx_hypercall_args args = {
   301			.r10 = TDX_HYPERCALL_STANDARD,
   302			.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
   303			.r12 = msr,
   304			.r13 = (u64)high << 32 | low,
   305		};
   306	
   307		if (tdx_fast_tdcall_path_msr(msr))
   308			__tdx_hypercall(&args, 0);
   309		else
   310			native_write_msr(msr, low, high);
   311	}
   312	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
