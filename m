Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7275644320
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiLFM3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLFM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:29:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7557B80
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 04:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670329744; x=1701865744;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=J1t8XPlDc6GrYR3R3TEG/QVgboWuNdDW+WfSqyj3ACM=;
  b=bw0a+ITuNLmcd3VeY+R7wXr9KLkkgnnHuMK4gSq3Ax9mQmxKgGphTAVl
   6QbBUC7ijLEOIXes6ug6EqmQJZIOW0iaPwiMN5IJdGHkuyglvta9iQDIU
   D+GjClsUcD0rvCuogah0E+wgQ4uoRj5VP4oI2Fg55pDs6BMqK1f7PymZS
   u6j5+1JlQMxNFFCEc5dqKLhfH3liz79ACN4M+NqEzq0Tu9zUD8JBofLn8
   SfmU917Gb3u/GY4QWplpVvy9iL36kDf3EuwuhhY0tIJcvr9+wlgz+CNpl
   XUp4+KmsTLXck15jVsuzf7dg7oCAWf3mg3pHQLf3Cd1AVSQlNUezO+YpG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315320409"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="315320409"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 04:29:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="820564208"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="820564208"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2022 04:29:02 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2X4I-0000v5-0y;
        Tue, 06 Dec 2022 12:29:02 +0000
Date:   Tue, 06 Dec 2022 20:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7b727b02512e0c78c333254e530a64eb49a20989
Message-ID: <638f357a.bXyPgBG8g1Bggjjb%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7b727b02512e0c78c333254e530a64eb49a20989  Merge irq/core into tip/master

elapsed time: 728m

configs tested: 65
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
mips                             allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
sh                               allmodconfig
i386                                defconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                             allyesconfig
x86_64               randconfig-a011-20221205
x86_64               randconfig-a012-20221205
i386                 randconfig-a014-20221205
x86_64               randconfig-a014-20221205
i386                 randconfig-a013-20221205
x86_64               randconfig-a013-20221205
i386                 randconfig-a012-20221205
arm                                 defconfig
i386                 randconfig-a015-20221205
x86_64               randconfig-a015-20221205
x86_64               randconfig-a016-20221205
i386                 randconfig-a011-20221205
i386                 randconfig-a016-20221205
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20221205
arm                  randconfig-r046-20221204
s390                 randconfig-r044-20221205
arc                  randconfig-r043-20221204
riscv                randconfig-r042-20221205

clang tested configs:
x86_64               randconfig-a003-20221205
x86_64               randconfig-a004-20221205
x86_64               randconfig-a001-20221205
x86_64               randconfig-a002-20221205
x86_64               randconfig-a005-20221205
x86_64               randconfig-a006-20221205
hexagon              randconfig-r041-20221204
i386                 randconfig-a003-20221205
hexagon              randconfig-r045-20221204
i386                 randconfig-a001-20221205
i386                 randconfig-a002-20221205
i386                 randconfig-a005-20221205
i386                 randconfig-a004-20221205
i386                 randconfig-a006-20221205
hexagon              randconfig-r045-20221205
arm                  randconfig-r046-20221205
hexagon              randconfig-r041-20221205
riscv                randconfig-r042-20221204
s390                 randconfig-r044-20221204

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
