Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF97669AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjAMOic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjAMOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:37:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000006F979
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673620166; x=1705156166;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sAwPcA67rv6du0GkUAVuBNgzwTh7NVh2xGwbgS+hU/I=;
  b=PSX8gnQhhJ8VzGUIHuZYA8OvM/klVLiV6MsTau3GotM59ESggaKtASZ9
   4TBtqSh4yREoJe6kh7FoZx4rvBtEP/v1W5CMXUO5wBmVwKjnxeXWwsiWY
   kk8f7uaRXklJtO7eg2acdOFo+97YFlB2GARFW7lntNUivxxHxCAGVIHLD
   9fEIZmb4c4LitpJIEUUmsEWn8ZQiQ9jZbLS8ng5RXU+ORMkYmbV7BIfd3
   CzX/X6ei+7VcbTOoRVvh5DP9D/VLScPkHlo1/Ye1yaU8oHsXAm3HmoIr9
   RwX+lm9po6Xu/wpvBiLO2ZPfinvMsqCcq92vTVVlE09VmxOPfENlDHped
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="410237720"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="410237720"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:29:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="651538269"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="651538269"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2023 06:29:24 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGL3b-000BAu-0G;
        Fri, 13 Jan 2023 14:29:23 +0000
Date:   Fri, 13 Jan 2023 22:28:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 0b8ddef9f5c69f7193ebf1a3c38c279ee173722c
Message-ID: <63c16a8e.hJZpboLofvxANVq5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 0b8ddef9f5c69f7193ebf1a3c38c279ee173722c  rcu: Disable laziness if lazy-tracking says so

elapsed time: 721m

configs tested: 87
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a016
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
ia64                             allmodconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20230112
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm                          pxa3xx_defconfig
sh                         ap325rxa_defconfig
sh                     magicpanelr2_defconfig
sh                         microdev_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-c001
mips                     decstation_defconfig
powerpc                        cell_defconfig
sh                           se7705_defconfig
arm                           viper_defconfig

clang tested configs:
i386                          randconfig-a013
x86_64                        randconfig-a014
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-k001
hexagon              randconfig-r041-20230112
powerpc                          g5_defconfig
mips                          malta_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      maltaaprp_defconfig
arm                  randconfig-r046-20230112
hexagon              randconfig-r045-20230112
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
