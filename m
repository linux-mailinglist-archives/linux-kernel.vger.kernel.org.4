Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BED5B63B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiILW2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiILW2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:28:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1E9205D2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663021714; x=1694557714;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QE+zpv7+p1zxtZq8Ys4LSkA9vBh400scPmP4VqRM5jU=;
  b=T7Ocz4MJdL1MYN2CptBSPgnt6nT8T6kKvBN7xqPmhS8FMU1aDNUV5lQz
   M+cCDlVXN39fKtcgcWgnT3sgaLlbdj7luN5ghUdPbBmhLtttjhcHLgFo7
   bB74JMTmHGsgj1wG5pXQoV/TliZpZOsfV8GUr+syCadRyOCyzkZXqpGU1
   9EXCVRg7QWiQ39QNIk4pXzd5BahbEPCiywnEGgVxsbRK4dwge9EevAU+F
   lj6HqnCefNqi0gHL+ByC/gg2XFYHswEK4advf/bMSGY1VdigBPUyZg71K
   pNrgrkEbhs5ulbYnZSFypherCL8qxYgB6SyisAesTQI/v23vfXgCiJuJz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324224794"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324224794"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 15:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="861317773"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2022 15:28:32 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXruq-0002wB-1H;
        Mon, 12 Sep 2022 22:28:32 +0000
Date:   Tue, 13 Sep 2022 06:27:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [peterz-queue:call-depth-tracking 11/59] /tmp/cc5AOQRO.s: Error:
 .size expression for __raw_callee_save___kvm_vcpu_is_preempted does not
 evaluate to a constant
Message-ID: <202209130641.FPokOaKK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git call-depth-tracking
head:   3a02739baf0302d9ba295686fc7a48fdd235ad15
commit: df1de0e0220ea824baf5ff3ef0993bb85fce0c7f [11/59] x86/paravirt: Properly align PV functions
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220913/202209130641.FPokOaKK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=df1de0e0220ea824baf5ff3ef0993bb85fce0c7f
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue call-depth-tracking
        git checkout df1de0e0220ea824baf5ff3ef0993bb85fce0c7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /tmp/cc5AOQRO.s: Assembler messages:
>> /tmp/cc5AOQRO.s:59: Error: a bignum with underscores must have exactly 4 words
>> /tmp/cc5AOQRO.s:59: Error: bad or irreducible absolute expression
>> /tmp/cc5AOQRO.s:59: Error: junk at end of line, first unrecognized character is `r'
>> /tmp/cc5AOQRO.s: Error: .size expression for __raw_callee_save___kvm_vcpu_is_preempted does not evaluate to a constant
--
   /tmp/ccfYcFQ6.s: Assembler messages:
   /tmp/ccfYcFQ6.s:6: Error: a bignum with underscores must have exactly 4 words
>> /tmp/ccfYcFQ6.s:6: Error: junk at end of line, first unrecognized character is `p'
   /tmp/ccfYcFQ6.s:13: Error: junk at end of line, first unrecognized character is `p'
>> /tmp/ccfYcFQ6.s: Error: .size expression for _paravirt_nop does not evaluate to a constant
>> /tmp/ccfYcFQ6.s: Error: .size expression for paravirt_ret0 does not evaluate to a constant

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
