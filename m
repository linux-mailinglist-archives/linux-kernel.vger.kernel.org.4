Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D005BF174
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 01:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiITXo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 19:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiITXoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 19:44:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051D3DA8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663717461; x=1695253461;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SA2JZkbgm13c+2XfIQTBvJ/gK30WHUA4ZzFSSOHYGwA=;
  b=PVESMVxNQ8/lXgAEqcPl8RPcsDoMglgcSVT+gTfdD6G2fIM81/8dtZfo
   SWZBYGysb8NaW/LwBhgVDjz0UQGZ+zahOVYKk/1ZjHA8f6M7DYYanBDe1
   VkMLa+xG27xCxt8lrmrj/bUqd9TJ133Iz0f+IN7t0jLz1xeGx62XJfpcH
   /qkq7ipvtoS8ch2kcNpZh34sVO1yqTEUgEHo0gXP+5PloIBvbyaj7FZqT
   kbrTuqeObJpgIdH69PdtPUNCxQy41O/SIhIdWdX6CqbQiLzslkBV0WkJ8
   GKMPA98iaggBw2gqfC00hsD2K4LfFPJueBf9y2EamePcQ9ujTmVT9cf4E
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="361604820"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="361604820"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 16:44:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="649803700"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2022 16:44:18 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oamuY-00032r-0g;
        Tue, 20 Sep 2022 23:44:18 +0000
Date:   Wed, 21 Sep 2022 07:43:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4bd8f32a4d8ace8fc420af4e61cda46fabb4ae47
Message-ID: <632a503b.rfTATMmjEZP9jPiT%lkp@intel.com>
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
branch HEAD: 4bd8f32a4d8ace8fc420af4e61cda46fabb4ae47  Merge branch into tip/master: 'x86/timers'

elapsed time: 728m

configs tested: 48
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
riscv                randconfig-r042-20220919
um                             i386_defconfig
arc                              allyesconfig
arc                  randconfig-r043-20220919
mips                             allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                                defconfig
s390                 randconfig-r044-20220919
um                           x86_64_defconfig
i386                                defconfig
s390                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
s390                             allyesconfig
i386                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                 randconfig-a013-20220919
i386                 randconfig-a012-20220919
i386                 randconfig-a014-20220919
i386                 randconfig-a011-20220919
i386                 randconfig-a016-20220919
x86_64                           allyesconfig
i386                 randconfig-a015-20220919
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           rhel-8.3-kvm
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220919
hexagon              randconfig-r041-20220919
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
