Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573BE61D9A7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 12:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiKELSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 07:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKELSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:18:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835213F1E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667647108; x=1699183108;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DzCQMKdTo47zamimbI7efnWn2zSE6FL9/JU0AVojKFk=;
  b=DtiDTFL2Y4Oi3SPwx/Ec4OxJcBR1j6NJeqaWDmoHYXgfe1uDCIkvpZmx
   0L9UbcYUw1V3gpkvL1ZwIa2yOWBktLWSDG35h5wNQz3ufVXaI4ionK48b
   vPaDVrqLp53Uqu3ewoomqw+5Z5UPD5UpdvbTYlpgGYxtHU3E7CKe9nqqT
   zYw40B3W1oJi0iv+8/9HWcmEE7QvU3sSHREl7hdYVcrBLDmBBhNcGjmjW
   aEhqbxOsuxow/9s87FgdJLpajAIJR2GmUokW8zR/oxAMN02LfWG9buvUn
   x2kNNR32QU5zRVrtZOk7OtxHphJJDrCi+W6q0xe/XKFtWaOvVMohxl/F2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="308864850"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="308864850"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 04:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="760606347"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="760606347"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Nov 2022 04:18:26 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orHBx-000Hvh-3C;
        Sat, 05 Nov 2022 11:18:26 +0000
Date:   Sat, 05 Nov 2022 19:17:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 16a7fe3728a8b832ef0d1add66875a666b1f24fc
Message-ID: <63664650.bLd+Szzs49TjDX6j%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 16a7fe3728a8b832ef0d1add66875a666b1f24fc  KVM/VMX: Allow exposing EDECCSSA user leaf function to KVM guest

elapsed time: 720m

configs tested: 58
configs skipped: 75

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
x86_64                        randconfig-a004
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                           allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                             allyesconfig
riscv                randconfig-r042-20221104
arc                  randconfig-r043-20221104
s390                 randconfig-r044-20221104
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                       m5208evb_defconfig
sh                   sh7724_generic_defconfig
powerpc                   currituck_defconfig
m68k                           sun3_defconfig
csky                                defconfig
nios2                         10m50_defconfig
m68k                       m5249evb_defconfig
ia64                         bigsur_defconfig
arm                            qcom_defconfig
i386                          randconfig-c001

clang tested configs:
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20221104
hexagon              randconfig-r045-20221104
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
