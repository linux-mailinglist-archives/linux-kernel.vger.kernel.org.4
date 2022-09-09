Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7755B41AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiIIVtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiIIVtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:49:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225B46EF22
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662760150; x=1694296150;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2gDL6PdyKT5sSUrhkHv+iu2BT8z99ndogq3WpGpkmp4=;
  b=VOX+iQbbMm/nfSGr6KfG1zBFqawELs4QqDanD6/oQ2dmt8PBk1bFxzyk
   /eOZmP0CV/fENbKayfSpFJSWWYDJ02O+DHbiL9AnIZyneoxQPQlvGVf57
   H4EaVjvXOMxIKqTr0/f68pq8Q2BnfL7XFk35WyLEcmNnBxLjW3kLZIcWw
   Tv3LR9oyF40LrDquoofx38fCeAQfl+/ndcsYcvfglwp2ztxIPKpAnZBp4
   6e8N7eP2UiPL5EQe8PTSBMyn9PZU0aKKiPCmC4Hj/KuaL10a0k1heKB2v
   vXAZN/CMJjkN1VoQMlxYKIk1XBU2G1W3CQ5WsyBvtUerncZIX61AgGgiV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="277310204"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="277310204"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 14:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="683786867"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2022 14:49:08 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWls4-0001lp-0Y;
        Fri, 09 Sep 2022 21:49:08 +0000
Date:   Sat, 10 Sep 2022 05:48:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/psi] BUILD SUCCESS
 34f26a15611afb03c33df6819359d36f5b382589
Message-ID: <631bb4ad.SqbxEE0idLqBeWxA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/psi
branch HEAD: 34f26a15611afb03c33df6819359d36f5b382589  sched/psi: Per-cgroup PSI accounting disable/re-enable interface

elapsed time: 741m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
arm                                 defconfig
x86_64                           allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a014
x86_64                        randconfig-a013
powerpc                           allnoconfig
x86_64                        randconfig-a011
i386                          randconfig-a003
powerpc                          allmodconfig
i386                          randconfig-a012
x86_64                        randconfig-a006
sh                               allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                          randconfig-a005
m68k                             allyesconfig
arc                  randconfig-r043-20220907
m68k                             allmodconfig
arc                              allyesconfig
arm64                            allyesconfig
mips                             allyesconfig
alpha                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
sh                             espt_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                            mps2_defconfig

clang tested configs:
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
s390                 randconfig-r044-20220907
x86_64                        randconfig-a001
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220907
riscv                randconfig-r042-20220907
i386                          randconfig-a015
i386                          randconfig-a004
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220907
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
