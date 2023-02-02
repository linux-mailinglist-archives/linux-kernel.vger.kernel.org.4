Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4078D6885C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjBBRyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBBRyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:54:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15E86A709
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675360482; x=1706896482;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Fm/sPzaFV6+d/VD1kHwAl/n94AjBQTCd7lWqvOYlsf8=;
  b=XWRYjVsC5BYeFBQ/Q48eMCn+SvAFwsiky/PYaxOEgyzrCGk1q9tsqNUb
   gxQ3ZwlrjuNZTShlLD70OLfzW+stvlabi20CdxM2B5k44EF5m8ROM/8Gd
   ED1J7YdU7kqNBxh1oheCDh71A4MylcIVi9VERSID19BDcMaLa+7i12vxj
   hbTMbkDfGEmYfwzsD5Q1ER0cvX8+32Ukg7Ir2TR9yF7tOWyToKlzCi1aS
   5ov5XfAn/QtEdDpENSJGVmWJukD2azB2vxv3CsaA7DjoRvIPLp6/klDTm
   wF21atdmxRqzkHStFeEDDi2KYIC/nhjrPB3dM6p+VUvXFyOYbVt6wGMtP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="327164571"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="327164571"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 09:54:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="910852708"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="910852708"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Feb 2023 09:54:41 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNdnE-0006hE-2N;
        Thu, 02 Feb 2023 17:54:40 +0000
Date:   Fri, 03 Feb 2023 01:54:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam-memcpy] BUILD SUCCESS
 b58291aae115b9af8c28719d95c68e07d06a5183
Message-ID: <63dbf8d4.GfK6HJ2BKR91r2qF%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam-memcpy
branch HEAD: b58291aae115b9af8c28719d95c68e07d06a5183  xfs: Replace one-element arrays with flexible-array members

elapsed time: 813m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64               randconfig-a001-20230130
um                             i386_defconfig
x86_64               randconfig-a003-20230130
um                           x86_64_defconfig
x86_64               randconfig-a002-20230130
x86_64                          rhel-8.3-func
x86_64               randconfig-a006-20230130
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a005-20230130
arc                                 defconfig
x86_64               randconfig-a004-20230130
s390                             allmodconfig
alpha                               defconfig
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
s390                                defconfig
x86_64                              defconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a016-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a015-20230130
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
hexagon              randconfig-r045-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a011-20230130
hexagon              randconfig-r041-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
hexagon              randconfig-r045-20230129
i386                 randconfig-a015-20230130
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
riscv                randconfig-r042-20230130
i386                 randconfig-a016-20230130
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
