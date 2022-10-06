Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F45F6FF8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiJFVLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiJFVLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:11:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA83B14C0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665090708; x=1696626708;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HdD3at6esv9aHSde7YVxdssRCTNaZf/E/8BLWVfbXDg=;
  b=lyjYH8kkM+5gpuzj45v3lgTGcFDIGdNoMIpFEWvP7LxNVWuzGSMbkeqa
   IDO/Wz7FEKB1rttVy46IwrjI9U25f5ABfHe6GTQer0RNg4+7C3E5GOaGI
   1FqHiQH3a5XfcFO8uXImZZBQSawSSspy6WaoU3TSlfQeS77LgY5Q4Qn1M
   blC3OG0blHW/E86F9SU7kMikTAi95CY+QiL9tFdCUxGey8ZhwpuUjwJCn
   jKw6NDkmKhkmWkX9Cx1bb25/uFTehCsdgEyXyAJfiYlWi2mDJ24V1EipD
   lDyVcDdLJDhden0gtvH2oSiSgENG3DVG5Z7qbg8ffgV7qOf35r3Fz7a3+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="304569187"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="304569187"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 14:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="624881496"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="624881496"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Oct 2022 14:11:47 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogY9i-0000Tp-1T;
        Thu, 06 Oct 2022 21:11:46 +0000
Date:   Fri, 07 Oct 2022 05:11:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.10.05a] BUILD SUCCESS WITH WARNING
 0b2715652d6ac3f3f496384d3c8dc3ccc46a6c18
Message-ID: <633f4475.tdxmy7xfQQAXe2Ph%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.10.05a
branch HEAD: 0b2715652d6ac3f3f496384d3c8dc3ccc46a6c18  EXP cpu: Add CPU-online debugging

Warning reports:

https://lore.kernel.org/lkml/202210061503.gBAGbL3p-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kernel/cpu.c:206 cpuhp_invoke_callback() error: uninitialized symbol 'cb'.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m001-20221003
    `-- kernel-cpu.c-cpuhp_invoke_callback()-error:uninitialized-symbol-cb-.
clang_recent_errors
|-- arm64-randconfig-r022-20221002
|   `-- kernel-cpu.c:warning:variable-cb-is-uninitialized-when-used-here
|-- hexagon-randconfig-r022-20221003
|   `-- kernel-cpu.c:warning:variable-cb-is-uninitialized-when-used-here
|-- hexagon-randconfig-r024-20221003
|   `-- kernel-cpu.c:warning:variable-cb-is-uninitialized-when-used-here
|-- hexagon-randconfig-r041-20221003
|   `-- kernel-cpu.c:warning:variable-cb-is-uninitialized-when-used-here
|-- i386-randconfig-a003-20221003
|   `-- kernel-cpu.c:warning:variable-cb-is-uninitialized-when-used-here
|-- powerpc-randconfig-r025-20221002
|   `-- kernel-cpu.c:warning:variable-cb-is-uninitialized-when-used-here
`-- s390-randconfig-r024-20221002
    `-- kernel-cpu.c:warning:variable-cb-is-uninitialized-when-used-here

elapsed time: 1246m

configs tested: 67
configs skipped: 2

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
m68k                             allmodconfig
i386                                defconfig
i386                 randconfig-a015-20221003
arc                              allyesconfig
i386                 randconfig-a016-20221003
sh                               allmodconfig
i386                 randconfig-a014-20221003
alpha                            allyesconfig
i386                 randconfig-a011-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a013-20221003
m68k                             allyesconfig
powerpc                          allmodconfig
arm                                 defconfig
mips                             allyesconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a016-20221003
x86_64               randconfig-a015-20221003
x86_64               randconfig-a014-20221003
i386                             allyesconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig

clang tested configs:
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a006-20221003
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
hexagon              randconfig-r041-20221002
s390                 randconfig-r044-20221002
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
