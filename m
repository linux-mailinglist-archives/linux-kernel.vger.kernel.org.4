Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0485BDA53
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiITCn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiITCnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:43:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DE3C16E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663641832; x=1695177832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2O7XDOGXnyfckroVMvQts/00N/iLNw5AcL3yHcU+5ok=;
  b=MkeVkR0vimgJyQ3Ac9bi98fIJti1IUHkq1z2OqQY6znNzzQFW9I4XSbI
   xdXicML2Tv8aPzkIqVbTuHU0baxg8OppygMvXsjw0jL6ZfsyqPeFlDEPY
   8PHD9y7CFy2MF/cICB2iLZqLtdZOsvcS14LTKQQGiSuFFkR6vlSdcHEH8
   3iuuQ+F6CTNT9pa/mm15zLBgdMshFdMlh9QADyJzv+mZnAygnD10rKFSE
   5Ac7C/8CAZUpNLSX0TAL7EPDcsJkXNRlanqUlglaDyOMs/1N+0GL4dtQL
   IoZKESLEpPAqNMJGchy62tmxH+Lndx62Qzo45JdqLgk0GWnYHPKyVyU1S
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="282605471"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="282605471"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 19:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="947478734"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2022 19:43:50 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaTEj-0002Q9-2m;
        Tue, 20 Sep 2022 02:43:49 +0000
Date:   Tue, 20 Sep 2022 10:43:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 279/314] lib/kvm_random.c:43:25:
 warning: implicit declaration of function 'cpuid_eax'
Message-ID: <202209201008.U8ySkGPR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   552dd80c48f67ca01bcdd10667e0c11efd375177
commit: a9daeb222b941f9c7fc89fee39301460ae2283d5 [279/314] *** HACK *** KVM: selftests: Add random_() framework to common KVM code
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # https://github.com/intel/tdx/commit/a9daeb222b941f9c7fc89fee39301460ae2283d5
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout a9daeb222b941f9c7fc89fee39301460ae2283d5
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from lib/kvm_random.c:14:
   include/x86_64/processor.h:761: warning: "__stringify_1" redefined
     761 | #define __stringify_1(x) #x
         | 
   In file included from include/x86_64/processor.h:18,
                    from lib/kvm_random.c:14:
   ../../../../tools/include/linux/stringify.h:10: note: this is the location of the previous definition
      10 | #define __stringify_1(x...)     #x
         | 
   In file included from lib/kvm_random.c:14:
   include/x86_64/processor.h:762: warning: "__stringify" redefined
     762 | #define __stringify(x)  __stringify_1(x)
         | 
   In file included from include/x86_64/processor.h:18,
                    from lib/kvm_random.c:14:
   ../../../../tools/include/linux/stringify.h:11: note: this is the location of the previous definition
      11 | #define __stringify(x...)       __stringify_1(x)
         | 
   lib/kvm_random.c: In function 'init_random':
>> lib/kvm_random.c:43:25: warning: implicit declaration of function 'cpuid_eax' [-Wimplicit-function-declaration]
      43 |         x86_phys_bits = cpuid_eax(0x80000008) & 0xff;
         |                         ^~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
