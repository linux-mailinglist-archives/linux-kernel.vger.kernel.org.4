Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAA96E1C87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDNGTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNGTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:19:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BDE4C2D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 23:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681453159; x=1712989159;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=80Po/vZzPPp1FhvIXbNsNd4hAfBZ0z4oOmsPMWv5zCA=;
  b=ZMdkUNNe6aKMf28zKv+ea5fIiIoangqUPJ/+64Vdcfah0Y08/RBfTAxG
   j74YMnWNnWIsXOpbv7FYl8TADfdBa2hwbQY9Ph5U0JryLgycyvAl70kh/
   byvAkXzSigoR8yB9nQL9AKTrPVRHHjsN44CRxf8Ek1naNj4/j+RQAOIbB
   NN6VRItPKoUMSGu1GvnAcrSORxuH+LWs4qC092qRYlru4NvDpd70Ns/bO
   E1Ed1POEjKCfMSnww/4SjcWrDc3GAwXbfs4tGParGYC2+dRExMxsYJBne
   6rrDKMa7mTPEgKzWomG7BmKSEhSvlH5Srr3/V3RqH5MwENfVAytT9ifjz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="341891834"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="341891834"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 23:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692251386"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692251386"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2023 23:19:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnCmD-000ZHl-05;
        Fri, 14 Apr 2023 06:19:17 +0000
Date:   Fri, 14 Apr 2023 14:18:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:main] BUILD SUCCESS
 523c1335f23e46be1df402cced7f62fb8fb9a480
Message-ID: <6438f050.10YiSD8JcX3gZX6V%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git main
branch HEAD: 523c1335f23e46be1df402cced7f62fb8fb9a480  Merge branches 'urgent-rcu.2023.04.05a' and 'joel-boqun.2023.04.05a' into HEAD

elapsed time: 725m

configs tested: 55
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
