Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBD367B292
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjAYM3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjAYM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:29:01 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AD02410C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674649740; x=1706185740;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3tDMMSb2kLbUB16hbzda5EPzAtJTxQcqKdu5ai7AvbM=;
  b=R+jd4hTGe/j/GNmCToKlT0qsEq06amsd3WdoHy7pYRFmtEmeonnv8ve3
   BYeQYeMD1ZkS67afjyLu3WE9sNXkisMg9s4JOXYWH7cDhOlS60XZASOxR
   UrYvzNAtXfhZO1HQhBSSZq27EO2xv+0/3i7ns1gj1cMzsndITAJSaoZAT
   Ega0/otkk7YYuZP6ibmMf9fyx4Y7FEvqRQRIjiVE0PD/osiSWwY4Z+8/d
   r/vpF71aqLwKHxP2/WVHVyzEmVY8343y3S/IyYQmPlMERZBZZkU7Hu33O
   HseW2OLV3oZuzUXI4MWD+y5Aa+fkKx9Sou8lpzDT9pgAS1Q8eASiMirmw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="328629528"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="328629528"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 04:29:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="725837708"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="725837708"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jan 2023 04:28:58 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKetd-0007IS-2I;
        Wed, 25 Jan 2023 12:28:57 +0000
Date:   Wed, 25 Jan 2023 20:28:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.01.23a] BUILD SUCCESS
 fd26681cc4f80261febe2781648ebee972c242f3
Message-ID: <63d1207d.tcBlLvpZqhf6kNIG%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.01.23a
branch HEAD: fd26681cc4f80261febe2781648ebee972c242f3  tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem

elapsed time: 720m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
powerpc                           allnoconfig
x86_64                              defconfig
i386                                defconfig
ia64                             allmodconfig
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
x86_64               randconfig-a002-20230123
sh                               allmodconfig
x86_64               randconfig-a001-20230123
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64               randconfig-a006-20230123
mips                             allyesconfig
x86_64               randconfig-a004-20230123
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a003-20230123
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a005-20230123
x86_64                           rhel-8.3-bpf
s390                                defconfig
i386                             allyesconfig
s390                             allmodconfig
i386                 randconfig-a004-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a001-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
arm                                 defconfig
x86_64                           allyesconfig
arm64                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig

clang tested configs:
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
x86_64                          rhel-8.3-rust
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a016-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
