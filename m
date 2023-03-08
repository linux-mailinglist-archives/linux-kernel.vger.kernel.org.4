Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2576B1282
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCHUAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCHUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:00:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A17ABAEF1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678305599; x=1709841599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lujBnfyVjbSN3IX5eAFqoZfHIihIG2YLxxYAJnRFe48=;
  b=Lhmy6SdTzP433YpZqImIjHbx3qNlhvX0oLv1xWIdK8NC7J4CpRD0+8nP
   zdVHyTHd1sdGC4QXEMH9rqiKQNtSAzWYGpxIMChwBKpvojbwRT8g4nV/B
   oGmBjcv2T3r+EMC6kdGLIrXx9ShBg80Nk6X7ws03x40jy8dDMw2DYXcFX
   KnCy+EaS7200TdiSR6RRCPsppEaYp3ajkJc1kM7EGJc7J+wC8ColHUBzC
   j6xl+rbDGv1GW1T98CwvD3YVWCb30GmJKnIYSXi+pUa3S5BKiUVCdEE+y
   VjQ02Mjn/hgAgvsXEyAM4Gxis0CJb1HmVab0RDcgrfKVoTwoGZ9UF+7d9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="337783817"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="337783817"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 11:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="627061025"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="627061025"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2023 11:59:57 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZzx6-0002Nm-2f;
        Wed, 08 Mar 2023 19:59:56 +0000
Date:   Thu, 9 Mar 2023 03:59:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: <instantiation>:99:2: error: Unable to parse register name $fp
Message-ID: <202303090316.McwlaGBM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   63355b9884b3d1677de6bd1517cd2b8a9bf53978
commit: 15f3d81a8c8a564cbc8642cf95c548d02db035a7 MIPS: use simpler access_ok()
date:   1 year ago
config: mips-randconfig-c004-20230308 (https://download.01.org/0day-ci/archive/20230309/202303090316.McwlaGBM-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15f3d81a8c8a564cbc8642cf95c548d02db035a7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 15f3d81a8c8a564cbc8642cf95c548d02db035a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303090316.McwlaGBM-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/kernel/signal.c:439:5: warning: no previous prototype for function 'setup_sigcontext' [-Wmissing-prototypes]
   int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
       ^
   arch/mips/kernel/signal.c:439:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
   ^
   static 
   arch/mips/kernel/signal.c:516:5: warning: no previous prototype for function 'restore_sigcontext' [-Wmissing-prototypes]
   int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
       ^
   arch/mips/kernel/signal.c:516:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
   ^
   static 
   arch/mips/kernel/signal.c:637:17: warning: no previous prototype for function 'sys_sigreturn' [-Wmissing-prototypes]
   asmlinkage void sys_sigreturn(void)
                   ^
   arch/mips/kernel/signal.c:637:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void sys_sigreturn(void)
              ^
              static 
   arch/mips/kernel/signal.c:674:17: warning: no previous prototype for function 'sys_rt_sigreturn' [-Wmissing-prototypes]
   asmlinkage void sys_rt_sigreturn(void)
                   ^
   arch/mips/kernel/signal.c:674:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void sys_rt_sigreturn(void)
              ^
              static 
   arch/mips/kernel/signal.c:904:17: warning: no previous prototype for function 'do_notify_resume' [-Wmissing-prototypes]
   asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
                   ^
   arch/mips/kernel/signal.c:904:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
              ^
              static 
>> <instantiation>:99:2: error: Unable to parse register name $fp
           .error  "Unable to parse register name $fp"
           ^
   <instantiation>:104:2: note: while in macro instantiation
           parse_r __rs, $fp
           ^
   arch/mips/include/asm/msa.h:213:1: note: while in macro instantiation
   __BUILD_MSA_CTL_REG(csr, 1)
   ^
   arch/mips/include/asm/msa.h:205:2: note: expanded from macro '__BUILD_MSA_CTL_REG'
           _ASM_SET_CTCMSA                                         \
           ^
   arch/mips/include/asm/msa.h:172:2: note: expanded from macro '_ASM_SET_CTCMSA'
           _ASM_MACRO_2R(ctcmsa, cd, rs,                                   \
           ^
   arch/mips/include/asm/mipsregs.h:1342:11: note: expanded from macro '_ASM_MACRO_2R'
                   ".endm\n\t"
                           ^
   <inline asm>:111:3: note: instantiated into assembly here
                   ctcmsa  $1, $fp
                   ^
   5 warnings and 1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
