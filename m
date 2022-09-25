Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5F25E96B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 00:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiIYWwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIYWwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 18:52:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F142A706
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664146338; x=1695682338;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oSpAJI+Sflg4S4/9V24kGd4lQ+/U/pcM2tTcNLjPWME=;
  b=TBkZ3JGEF+kZlwRRcyXX2twyROycjIHqSyUCUIkQbeLcGtop+zBC6sFA
   GVp7U0SGu3FoVG+w3UavWgp8aW8+ZPaCHLkRcYnIL2F6fKIw/8uKeA8TH
   hxFUtDLy3TpsN2C1yiDEU2JvC7OUPU9LNWH7tHv/wwre20hK7E2W5xUfb
   G2S7H62/HcZxigM7CCHYW0ptHshxYC/snP2YxxruNtr/2kwU41raoz03h
   Dmf9oCq7rgcCYaG+SuPirRklV4Rin2zy/46o3l7Ilv4LqBayttzhHRmHW
   qvgNg5clnweTF7h10W0BQ52YJODk+4cLWGRHNqz2QJ6C/ZPDnmGfgtI8Z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="364932318"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="364932318"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 15:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="949643383"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Sep 2022 15:52:16 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocaTw-0008SU-1B;
        Sun, 25 Sep 2022 22:52:16 +0000
Date:   Mon, 26 Sep 2022 06:51:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 02a42cd778750c33d55876321fa68e906122247e
Message-ID: <6330db7f.NC2HOxj91cjrIWlK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 02a42cd778750c33d55876321fa68e906122247e  Merge branch into tip/master: 'x86/timers'

elapsed time: 723m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
s390                             allmodconfig
x86_64                              defconfig
x86_64                        randconfig-a002
alpha                               defconfig
powerpc                           allnoconfig
arm                                 defconfig
s390                                defconfig
arc                  randconfig-r043-20220925
x86_64                               rhel-8.3
x86_64                        randconfig-a013
i386                             allyesconfig
i386                          randconfig-a001
s390                 randconfig-r044-20220925
x86_64                        randconfig-a011
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
i386                          randconfig-a014
x86_64                        randconfig-a006
i386                          randconfig-a012
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a015
riscv                randconfig-r042-20220925
i386                          randconfig-a016
i386                          randconfig-a005
x86_64                        randconfig-a004
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
arm                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220925
i386                          randconfig-a013
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
