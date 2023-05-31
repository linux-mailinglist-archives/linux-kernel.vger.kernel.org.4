Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDF717479
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjEaDrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEaDrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:47:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340AAEC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685504819; x=1717040819;
  h=date:from:to:cc:subject:message-id;
  bh=m8z8OxuJvu51YoN7GiS7m1Tho+HsLXuIo0wrFlMH8pY=;
  b=QKOv4UdjnRDNYQ8UOKRtu3HcoeEZk45aQuy9vXK892oY8KUmodz4HJGA
   FFkpB3pQYslvywAuogg0rEPcQoZnhWUnC8OppYhSWRgTtXGBPCdMdtJ1Y
   dpkD7c7cLAh/ivtpwxf9uvqC/X5Zbl8Xak+GDPwTTsZBKBXuGu8V5E5R6
   OkljWXuYE1HTVSau2RmyEpHnrjBQtccF1MSRcNBlye9JU35pEv5mkg0Uq
   erP8Xv7M03I8ScySDQkJH/m86ia6LZDNeNI52D3pvjXGKIutf0iwXj/Up
   h119AzTTW8jocG1ln1t//ta3IfRHkpiifdvUtxLXDM2GlTQc93keUbnbl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="339718465"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="339718465"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="831056022"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="831056022"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 20:46:57 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4CnY-00013f-2o;
        Wed, 31 May 2023 03:46:56 +0000
Date:   Wed, 31 May 2023 11:46:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 33e20b07bec4991c169e3c6ff28c2126583724fc
Message-ID: <20230531034620.emDIi%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: 33e20b07bec4991c169e3c6ff28c2126583724fc  x86/realmode: Make stack lock work in trampoline_compat()

elapsed time: 926m

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
