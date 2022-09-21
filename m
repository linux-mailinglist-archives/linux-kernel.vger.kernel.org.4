Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A05BF55E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiIUEbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIUEbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:31:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DA6C77B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663734670; x=1695270670;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=850qvCnTn1QoywvxumjAB1dTtcQRaNH+2FY7GmUspp8=;
  b=V1UXuYOzvHcqXOMBLcUiy+wu7xpA1J0QTvGPxCYsyz4/KsOFA+ku6jqB
   1beKk50E6mV1gN+Pw2ndoLDNGQupLLVvnHiSYdqyQo/xIkWHyeCnS1lro
   XxPMwFxPM8bN4LBsyIjH67YL70yuVexyN6iFvnSlEgpHR80Z6rtqr7dDY
   knYV5JVfD6ND76JNOt/mw6Dw/xojDgzGKbzk6vqcMhwe4opkbG90RSBKH
   ZXuj/EEt/MKQqy+Wi1CVirRRABeVh4WNMGudoJ00dmbz/e/QEQ15tKeiE
   K2LBiZde99k/4y88FDdcWJpc6CefXFEU60D+h1ydGUiUBDQLg/OApDlHb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="298615214"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="298615214"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 21:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="652375679"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2022 21:30:58 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oarNx-0003ED-2r;
        Wed, 21 Sep 2022 04:30:57 +0000
Date:   Wed, 21 Sep 2022 12:30:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 5881/9999] mremap_test.c:126:13:
 error: redefinition of 'is_remap_region_valid'
Message-ID: <202209211205.av57IQNU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   820b689b4a7a6ca1b4fdabf26a17196a2e379a97
commit: 0b4e16093e081a3ab08b0d6cedf79b249f41b248 [5881/9999] selftest/vm: verify remap destination address in mremap_test
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=0b4e16093e081a3ab08b0d6cedf79b249f41b248
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 0b4e16093e081a3ab08b0d6cedf79b249f41b248
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-stable-rc/linux-5.15.y HEAD 820b689b4a7a6ca1b4fdabf26a17196a2e379a97 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> mremap_test.c:126:13: error: redefinition of 'is_remap_region_valid'
     126 | static bool is_remap_region_valid(void *addr, unsigned long long size)
         |             ^~~~~~~~~~~~~~~~~~~~~
   mremap_test.c:73:13: note: previous definition of 'is_remap_region_valid' with type '_Bool(void *, long long unsigned int)'
      73 | static bool is_remap_region_valid(void *addr, unsigned long long size)
         |             ^~~~~~~~~~~~~~~~~~~~~
   mremap_test.c:147:27: error: redefinition of 'get_mmap_min_addr'
     147 | static unsigned long long get_mmap_min_addr(void)
         |                           ^~~~~~~~~~~~~~~~~
   mremap_test.c:94:27: note: previous definition of 'get_mmap_min_addr' with type 'long long unsigned int(void)'
      94 | static unsigned long long get_mmap_min_addr(void)
         |                           ^~~~~~~~~~~~~~~~~
   mremap_test.c:94:27: warning: 'get_mmap_min_addr' defined but not used [-Wunused-function]
   mremap_test.c:73:13: warning: 'is_remap_region_valid' defined but not used [-Wunused-function]
      73 | static bool is_remap_region_valid(void *addr, unsigned long long size)
         |             ^~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
