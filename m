Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83071962C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjFAI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjFAI7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:59:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5BAE7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685609938; x=1717145938;
  h=date:from:to:cc:subject:message-id;
  bh=bI04po/eK1H1qpKN8XdWnVH3kCj9h3k0RBK7LNfcsUg=;
  b=K/JcUTkz93pacaocwQbEHHLg14kNgrwz0SJ1exGgi9eBduQCxuDV+DFr
   30qcP/uIwsIQwoQjeFXTghSSkQwOdkF5NhhJ722ZPMJfTgcvJ6gOvOwka
   XQpvoyTltmlf7L59uHHjThncGZK2N9mq9Zgpd6fkTEJL2iZbWc2wiQ6pD
   5WSSeXeUQt1Ne74D9SSiItNA14GUgBm/yW8Bxf6mxye9+6jxv68qY3zm0
   75ZsIDvLVWJu2tqKOnqlmKLrG0954z5thkCxZ0twCm38LwrEXmJqzzRFg
   jEQz2vD3vzDkaCSKja0kmvZEovQ0amfPsjwANC8vfIShn9MVJYZLCrInB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="441862774"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="441862774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 01:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="831509379"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="831509379"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2023 01:58:56 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4e92-00027q-0n;
        Thu, 01 Jun 2023 08:58:56 +0000
Date:   Thu, 01 Jun 2023 16:58:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 3496d1c64a0fcc9bae3ed40decc3ecd7f8ac072f
Message-ID: <20230601085805.G_oh-%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: 3496d1c64a0fcc9bae3ed40decc3ecd7f8ac072f  x86/nospec: Shorten RESET_CALL_DEPTH

Unverified Warning (likely false positive, please contact us if interested):

arch/x86/kernel/alternative.c:1471:32: warning: no previous prototype for '__alt_reloc_selftest' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-debian-10.3
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-defconfig
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-allyesconfig
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-defconfig
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-kexec
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
`-- x86_64-rhel-8.3
    `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest

elapsed time: 1252m

configs tested: 40
configs skipped: 2

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
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
