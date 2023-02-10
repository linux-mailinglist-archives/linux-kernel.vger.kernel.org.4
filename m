Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE3C691771
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjBJEAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjBJEAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:00:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7246F224
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676001622; x=1707537622;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cYCGm20Wt4WkFmUmwHul6JsfnB/4OQoQNQZBxFV8+qA=;
  b=QUbIFn4hEKX4wFtnrKhS0Opi2eX01acEodGDDFt6pWswECpyLIv7LAXi
   GLHMg4t1o7WxpAr6alhW2fsIHi8sTnrml4pd6UESVZcqNYa0hsPvgnKf1
   7ZkmA89oN5TfqMqfu+LX4ZYugGkZdjYQj2LqivnfW5UL9lL3zqmR4O1Kh
   IgchB8+tLkWRGQBC4ZWVQLn17P8aIAiFQXHtPq8DahwdqPQQxXw2VJEiJ
   SEOI45L3343AjnR0EdV18zSkbVzt7SQoFgOIR7tTHV/VXLcPlseAmbwh4
   bZopPjw0YAikjGbmq93hCazc7QH6cv7eX8V3OwjXjo6EF5t+OTtrHP4aE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="357728360"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="357728360"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 20:00:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="698283263"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="698283263"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Feb 2023 20:00:19 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQKaB-0005Wu-0E;
        Fri, 10 Feb 2023 04:00:19 +0000
Date:   Fri, 10 Feb 2023 11:59:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 f545e8831e70065e127f903fc7aca09aa50422c7
Message-ID: <63e5c139.cf5VuqZwLcFQfiul%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: f545e8831e70065e127f903fc7aca09aa50422c7  x86/cpu: Add Lunar Lake M

elapsed time: 1899m

configs tested: 76
configs skipped: 66

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                                defconfig
i386                          randconfig-a001
x86_64                        randconfig-a015
i386                          randconfig-a003
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a005
x86_64                           allyesconfig
i386                             allyesconfig
i386                          randconfig-a014
x86_64                        randconfig-a004
i386                          randconfig-a012
x86_64                        randconfig-a002
i386                          randconfig-a016
x86_64                        randconfig-a006
um                           x86_64_defconfig
um                             i386_defconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                             allyesconfig
alpha                            allyesconfig
mips                     decstation_defconfig
arm                            hisi_defconfig
powerpc                     taishan_defconfig
m68k                             alldefconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                          rhel-8.3-func

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                          rhel-8.3-rust
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-k001
riscv                randconfig-r042-20230209
s390                 randconfig-r044-20230209
hexagon              randconfig-r045-20230209
hexagon              randconfig-r041-20230209
mips                malta_qemu_32r6_defconfig
powerpc                 mpc832x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
