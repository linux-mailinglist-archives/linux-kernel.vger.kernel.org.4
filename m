Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA85BD755
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiISWbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiISWbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:31:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B44F6A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663626663; x=1695162663;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zVkJ3kPa+mINvuZHZ/hajJ3LbNc82czNXNGS2m7Y7TE=;
  b=M9WMa6MZBHAjppbjd1zkNYMbNIsUwTDhWH4UsPHAzP10LttA6vFI3x4J
   bR2PB3iQh4Qm+f3MUvNrVEZ80dn2f/5/qh/4JZ3I7nvtsQEQ7y94ZlYie
   lnJYu2uBKCX0bCmo2WzA0Q7i0sAx6eFHLo82w3nf47lIiZKoOpOlp9ze/
   Lqfb5CKyoMy44hSD2SeEBHKOyHjrrUwA5DqzE0aZGISj51NkRJXGde/lb
   O2Sn0e2D3cqcL2FeAW8P9+yJmlAAsDGt87++kHxNsNlXXe7z/ma8KxjkA
   OBIFFEgf40wZxjo/1wWQanFbMN+fIymwHSvnRmkNmRyf80jT1dBnvqYPi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="300357921"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="300357921"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 15:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="863742420"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Sep 2022 15:31:01 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaPI4-0002GS-2w;
        Mon, 19 Sep 2022 22:31:00 +0000
Date:   Tue, 20 Sep 2022 06:30:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Sagi Shahar <sagis@google.com>
Subject: [intel-tdx:kvm-upstream-workaround 207/314]
 include/x86_64/processor.h:761: warning: "__stringify_1" redefined
Message-ID: <202209200617.qET1i5ic-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   552dd80c48f67ca01bcdd10667e0c11efd375177
commit: 31055e94daecbccb36f6f4bfde26a583b2790a51 [207/314] KVM: selftest: Add helper functions to create TDX VMs
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # https://github.com/intel/tdx/commit/31055e94daecbccb36f6f4bfde26a583b2790a51
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 31055e94daecbccb36f6f4bfde26a583b2790a51
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from lib/kvm_util.c:11:
>> include/x86_64/processor.h:761: warning: "__stringify_1" redefined
     761 | #define __stringify_1(x) #x
         | 
   In file included from include/x86_64/processor.h:18,
                    from lib/kvm_util.c:11:
   ../../../../tools/include/linux/stringify.h:10: note: this is the location of the previous definition
      10 | #define __stringify_1(x...)     #x
         | 
   In file included from lib/kvm_util.c:11:
>> include/x86_64/processor.h:762: warning: "__stringify" redefined
     762 | #define __stringify(x)  __stringify_1(x)
         | 
   In file included from include/x86_64/processor.h:18,
                    from lib/kvm_util.c:11:
   ../../../../tools/include/linux/stringify.h:11: note: this is the location of the previous definition
      11 | #define __stringify(x...)       __stringify_1(x)
         | 
   lib/kvm_util.c: In function '____vm_create':
   lib/kvm_util.c:191:20: error: 'type' undeclared (first use in this function)
     191 |         vm->type = type;
         |                    ^~~~
   lib/kvm_util.c:191:20: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from lib/perf_test_util.c:9:
>> include/x86_64/processor.h:761: warning: "__stringify_1" redefined
     761 | #define __stringify_1(x) #x
         | 
   In file included from include/x86_64/processor.h:18,
                    from lib/perf_test_util.c:9:
   ../../../../tools/include/linux/stringify.h:10: note: this is the location of the previous definition
      10 | #define __stringify_1(x...)     #x
         | 
   In file included from lib/perf_test_util.c:9:
>> include/x86_64/processor.h:762: warning: "__stringify" redefined
     762 | #define __stringify(x)  __stringify_1(x)
         | 
   In file included from include/x86_64/processor.h:18,
                    from lib/perf_test_util.c:9:
   ../../../../tools/include/linux/stringify.h:11: note: this is the location of the previous definition
      11 | #define __stringify(x...)       __stringify_1(x)
         | 
--
   In file included from lib/x86_64/processor.c:10:
>> lib/x86_64/tdx.h:6:10: fatal error: ../kvm_util_internal.h: No such file or directory
       6 | #include "../kvm_util_internal.h"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
