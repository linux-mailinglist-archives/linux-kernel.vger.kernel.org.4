Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A0361039F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiJ0VAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbiJ0U7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:59:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D42837FB1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666903912; x=1698439912;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xAJMSA2cfH2n8wVY+GBEloeMSijoh81s68yyfHIupxg=;
  b=l2hyFmHPxnk97pUs5rfkyjvf0e0QxpJRgTh6JSlkIhZp5HSxq788ZH6J
   tO+NlMS+Km22diziV5npzFFp6kSOPMf4CJNV+er2s/kzr1G5PEA8cYMHB
   RJK+MGqT2YHsGbEUMJggWtZi1iZjGGSK4KIu4qGhYxhMZVgHayLIQIJZ8
   dhPyX9NskeNqHLk2a6Ackm2qSE+hUvgxWdr0L2DkikgIN+GFMUi20AtFd
   RQc65kyJz970rtJdG806olzi0bDA9UANZma3L+RUPuMh8hd7nN1NK+a8U
   m3EJm8yNKfUzyrXqfdvfYHHj/gRxRlHcgf6Bshj1pACjCqu0wur1iDnlZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="394653563"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="394653563"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 13:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="610507111"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="610507111"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Oct 2022 13:51:50 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oo9qv-00099x-2K;
        Thu, 27 Oct 2022 20:51:49 +0000
Date:   Fri, 28 Oct 2022 04:51:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 cb6c18b5a41622c7a439508f7421f8766a91cb87
Message-ID: <635aef41.3/+uCoy9lPWkDuYq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/urgent
branch HEAD: cb6c18b5a41622c7a439508f7421f8766a91cb87  perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to PERF_MEM_LVLNUM_CXL

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
x86_64                        randconfig-a002
m68k                             allyesconfig
i386                          randconfig-a003
x86_64                              defconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
arc                              allyesconfig
i386                          randconfig-a005
x86_64                           allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a004
i386                                defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
riscv                randconfig-r042-20221026
x86_64                        randconfig-a013
powerpc                          allmodconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221026
x86_64                        randconfig-a011
arm                                 defconfig
x86_64                        randconfig-a015
arc                                 defconfig
i386                          randconfig-a016
s390                 randconfig-r044-20221026
s390                             allmodconfig
arm64                            allyesconfig
alpha                               defconfig
arm                              allyesconfig
i386                             allyesconfig
s390                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
s390                             allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
hexagon              randconfig-r045-20221026
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20221026
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
