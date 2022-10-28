Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5674610E44
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiJ1KTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJ1KTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:19:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A858115FDC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666952385; x=1698488385;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5Gzk75kHetdiKoHOlqEumcUhsSJjycSVuYIDWM7RMqE=;
  b=k512FOOR6fiKwbvKJI13Z07rAnstAjichYELXtOMBJwZ0FdxOhugHlpE
   LlVB3/P32Kzbn4lMOsLR2yfnnQfgt9hKDVyjShOWgjaJimDhKIsUgIXLw
   LmviQ8wmZaDd8xfRMjHJt9E9nhCA0KcuXMxuwSufxDWWwlqtJgLE75vag
   Yi2/IsZMn2u99FTpudONnl4TXgSqczoYtY0f1lCltWB5dXYaKXVMkzCl3
   DI9xsDhWGp9N6bNZzW33giThrz1qnnt4N1h89KhMfiMvImAQrtG8oETzp
   scignNjp872zFWRuhaF5GF9AS/s6pbtLt4rIKxrInmNTRVrX+9EcA2amh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="335101008"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="335101008"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 03:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="877917403"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="877917403"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 28 Oct 2022 03:19:32 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooMSa-0009nd-0l;
        Fri, 28 Oct 2022 10:19:32 +0000
Date:   Fri, 28 Oct 2022 18:19:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 571f97f7d51fa81e6cc0e00f0f6314792ce533a3
Message-ID: <635baca2.FbTo2SASwyC2/D0/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 571f97f7d51fa81e6cc0e00f0f6314792ce533a3  perf: Optimize perf_tp_event()

elapsed time: 721m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                              defconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
x86_64                           rhel-8.3-syz
alpha                            allyesconfig
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
m68k                             allmodconfig
x86_64                        randconfig-a002
m68k                             allyesconfig
i386                             allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a006
i386                          randconfig-a003
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
powerpc                          allmodconfig
i386                          randconfig-a005
x86_64                        randconfig-a015
i386                          randconfig-a012
sh                               allmodconfig
mips                             allyesconfig
i386                          randconfig-a016
ia64                             allmodconfig
arm                                 defconfig
arc                  randconfig-r043-20221028
arm                              allyesconfig
arm64                            allyesconfig
riscv                randconfig-r042-20221026
arc                  randconfig-r043-20221026
riscv                randconfig-r042-20221028
s390                 randconfig-r044-20221028
s390                 randconfig-r044-20221026

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a004
i386                          randconfig-a015
hexagon              randconfig-r041-20221028
hexagon              randconfig-r045-20221026
hexagon              randconfig-r045-20221028
hexagon              randconfig-r041-20221026
arm                         hackkit_defconfig
arm                         socfpga_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
