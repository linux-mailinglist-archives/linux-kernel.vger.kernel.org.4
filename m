Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4945B663F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIMDmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIMDmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:42:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A6213D31
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663040565; x=1694576565;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BY6WsLfR0t4CqcDwDVpt9wqeo7EYjBtMpwaUfTOvTDM=;
  b=lrN1cMYUKe0TDScQI0xUz2wdGnEXUnNSbmFq76m2VL/VvjzzxRyBj20P
   eBeac48jOySITKYPSAgf9Afv7BC1wxzoBJTkvVdVTinnMOdGf3BvPFWOz
   XZRDmgWewFU0d/2DpBmbWRfLuZ+ekrOGm//G4Nw+4c06cptndelrD2VGw
   LM8a6svrjpUvT78z6Fqd7TG1/GamsfrAkwWdoDyqAiyQ/ouRK9nW1kdPM
   9uxDcJ1JfVUaled/QpxOYN4t2dJ4ICaS7ad+mregvnQhPlwG+6tW6UAzE
   sVf8hW7fL1GaNOPfyX18DDMxdOBO5cYWTURW4zITGSptupnO/JE8dm5Lx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="281046587"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="281046587"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 20:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="944889181"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2022 20:42:43 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXwot-0003At-0E;
        Tue, 13 Sep 2022 03:42:43 +0000
Date:   Tue, 13 Sep 2022 11:42:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 16/39]
 arch/x86/coco/tdx/tdx-tests.c:66:12: warning: no previous prototype for
 function 'kvm_unit_test_debug_init'
Message-ID: <202209131158.hc5Q4EtT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

FYI, the error/warning still remains.

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   1f71e25a309e1f46dadb7c65e4383c3690dcd3be
commit: 5091d7c6068bf030df54dc48b303a1d25a7ef0a0 [16/39] x86/tdx-tests: Add a port of a kvm unit test
config: x86_64-randconfig-r025-20220912 (https://download.01.org/0day-ci/archive/20220913/202209131158.hc5Q4EtT-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/5091d7c6068bf030df54dc48b303a1d25a7ef0a0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 5091d7c6068bf030df54dc48b303a1d25a7ef0a0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/tdx-tests.c:66:12: warning: no previous prototype for function 'kvm_unit_test_debug_init' [-Wmissing-prototypes]
   int __init kvm_unit_test_debug_init(void)
              ^
   arch/x86/coco/tdx/tdx-tests.c:66:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init kvm_unit_test_debug_init(void)
   ^
   static 
   1 warning generated.


vim +/kvm_unit_test_debug_init +66 arch/x86/coco/tdx/tdx-tests.c

    65	
  > 66	int __init kvm_unit_test_debug_init(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
