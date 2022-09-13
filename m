Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A655B65DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiIMC5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIMC5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:57:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC44F655
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663037864; x=1694573864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=igZFmcra99pSCHBocBFCevoqU/tRbp9DHblEw52maIg=;
  b=B7z6J4Za5nIyOoh9kF8YSsDOhtcS22EOKR0LdASdES+qoqfDgdQIbn2t
   FO4FKsAiQTQYYW6Ov/ymN/JSMjoppg0IjuNnY9z8/Uag3DsWFT0/x3bOO
   DbQKxAsBSDwoBu3p0z9m8SmRyAON2oNDFYe5EOvDQB8F0xt9t2+d066l/
   Xz7AaYSDRcHW7pa8e3EaCFAT1qkuFX46A/1wqI41czEoCaUtsLm9JIHGz
   Bl01chJKHdxoyLYaUF+PJyxhXoJYuNuOmCOLwVTxfBR/0gqp1b0DG43Er
   7bn8Q5mzENdSIiGpS+CJ6nWbCeiOexazI/u/C7OaPhdtZfFrosRtmqi1G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="384317734"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="384317734"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 19:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="567414232"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2022 19:57:41 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXw7I-00038F-37;
        Tue, 13 Sep 2022 02:57:40 +0000
Date:   Tue, 13 Sep 2022 10:56:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 13/39]
 arch/x86/coco/tdx/tdx.c:531:15: warning: no previous prototype for function
 'tdx_mmio_readq'
Message-ID: <202209131030.eVPnwS0j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
commit: 0cf382195475412201e134e2925bb276445a8460 [13/39] x86/tdx: Enable direct iomap MMIO optimizations
config: x86_64-randconfig-r025-20220912 (https://download.01.org/0day-ci/archive/20220913/202209131030.eVPnwS0j-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/0cf382195475412201e134e2925bb276445a8460
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 0cf382195475412201e134e2925bb276445a8460
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/coco/tdx/tdx.c:298:14: warning: no previous prototype for function 'tdx_write_msr' [-Wmissing-prototypes]
   void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
                ^
   arch/x86/coco/tdx/tdx.c:298:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
   ^
   static 
>> arch/x86/coco/tdx/tdx.c:531:15: warning: no previous prototype for function 'tdx_mmio_readq' [-Wmissing-prototypes]
   unsigned long tdx_mmio_readq(void __iomem* addr)
                 ^
   arch/x86/coco/tdx/tdx.c:531:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long tdx_mmio_readq(void __iomem* addr)
   ^
   static 
   2 warnings generated.


vim +/tdx_mmio_readq +531 arch/x86/coco/tdx/tdx.c

   530	
 > 531	unsigned long tdx_mmio_readq(void __iomem* addr)
   532	{
   533		unsigned long val;
   534	
   535		if (tdx_virt_mmio(8, false, (unsigned long)addr, &val))
   536			return 0xffffffffffffffff;
   537		return val;
   538	}
   539	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
