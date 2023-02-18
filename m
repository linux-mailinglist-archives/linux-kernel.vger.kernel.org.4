Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB50369BD86
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 23:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBRWgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 17:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRWgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 17:36:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAA015552
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 14:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676759778; x=1708295778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PsNI8hqW4WKziUwOLNXzi3I+iAtaihsXjk/rEwtmdxQ=;
  b=njS8nymmM7BIfU1ougTye70ygdL5vAjOBPN848pDXCQ5bv8V+BdjuDRI
   sP6UWH6cIY/Vfd9ELyB1meoCpH5FULmtPzdz2iWJDb4GXI6Gf79yZr2Ad
   oly1SR8O5Ap1MNyrXOyE/Cq9lF0WKYofpnXnfMRztpQIoRRKHToxnCN7r
   9k7aCTzw6cGrftXiNzxhQMcPCcOEuUMYbdyXLdzt2q5dfdAT9oLgo3p9i
   bMo6BfS0JssM5ahQDowgOZPt3gUbBsNtvhIKu+5O5UQQqCRh8K/oQQfMk
   4eod5iFkh1bRQTuf1UY+5KRqm1jjQ8sQ1JYGqOEmzkc16gCUKkH9AJwpE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="332213047"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="332213047"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 14:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="670935601"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="670935601"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Feb 2023 14:36:16 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTVoW-000Coz-0W;
        Sat, 18 Feb 2023 22:36:16 +0000
Date:   Sun, 19 Feb 2023 06:35:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: cc1: error: arch/sh/include/mach-hp6xx: No such file or directory
Message-ID: <202302190641.30VVXnPb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5e725d112e1a54c2611d5dffd124a79415d0f0de
commit: 4c8dd95a723d9cccf8810be54aa62be82885c9d8 kbuild: add some extra warning flags unconditionally
date:   3 years, 9 months ago
config: sh-randconfig-r021-20230219 (https://download.01.org/0day-ci/archive/20230219/202302190641.30VVXnPb-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4c8dd95a723d9cccf8810be54aa62be82885c9d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4c8dd95a723d9cccf8810be54aa62be82885c9d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302190641.30VVXnPb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/hw_breakpoint.c: In function 'arch_bp_generic_fields':
   arch/sh/kernel/hw_breakpoint.c:159:27: error: this statement may fall through [-Werror=implicit-fallthrough=]
     159 |                 *gen_type = HW_BREAKPOINT_R;
         |                 ~~~~~~~~~~^~~~~~~~~~~~~~~~~
   arch/sh/kernel/hw_breakpoint.c:160:9: note: here
     160 |         case SH_BREAKPOINT_WRITE:
         |         ^~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/machvec.c: In function 'early_parse_mv':
   arch/sh/kernel/machvec.c:43:15: error: variable 'mv_comma' set but not used [-Werror=unused-but-set-variable]
      43 |         char *mv_comma;
         |               ^~~~~~~~
   arch/sh/kernel/machvec.c: In function 'sh_mv_setup':
   arch/sh/kernel/machvec.c:104:33: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]
     104 |                         sh_mv = *(struct sh_machine_vector *)&__machvec_start;
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/sh/kernel/machvec.c:13:
   arch/sh/include/asm/sections.h:7:13: note: object '__machvec_start' of size 4
       7 | extern long __machvec_start, __machvec_end;
         |             ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/ptrace_32.c: In function 'arch_ptrace':
   arch/sh/kernel/ptrace_32.c:380:40: error: comparison of unsigned expression in '< 0' is always false [-Werror=type-limits]
     380 |                 if ((addr & 3) || addr < 0 ||
         |                                        ^
   arch/sh/kernel/ptrace_32.c:420:40: error: comparison of unsigned expression in '< 0' is always false [-Werror=type-limits]
     420 |                 if ((addr & 3) || addr < 0 ||
         |                                        ^
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/kgdb.c: In function 'kgdb_arch_handle_exception':
   arch/sh/kernel/kgdb.c:267:20: error: this statement may fall through [-Werror=implicit-fallthrough=]
     267 |                 if (kgdb_hex2long(&ptr, &addr))
         |                    ^
   arch/sh/kernel/kgdb.c:269:9: note: here
     269 |         case 'D':
         |         ^~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/kprobes.c: In function 'kprobe_exceptions_notify':
   arch/sh/kernel/kprobes.c:481:24: error: variable 'p' set but not used [-Werror=unused-but-set-variable]
     481 |         struct kprobe *p = NULL;
         |                        ^
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
   arch/sh/kernel/disassemble.c:295:13: error: variable 'lastsp' set but not used [-Werror=unused-but-set-variable]
     295 |         int lastsp;
         |             ^~~~~~
   arch/sh/kernel/disassemble.c:478:36: error: this statement may fall through [-Werror=implicit-fallthrough=]
     478 |                                 if (0)
         |                                    ^
   arch/sh/kernel/disassemble.c:480:25: note: here
     480 |                         case F_REG_N:
         |                         ^~~~
   arch/sh/kernel/disassemble.c:487:36: error: this statement may fall through [-Werror=implicit-fallthrough=]
     487 |                                 if (rn & 1) {
         |                                    ^
   arch/sh/kernel/disassemble.c:491:25: note: here
     491 |                         d_reg_n:
         |                         ^~~~~~~
   arch/sh/kernel/disassemble.c:496:36: error: this statement may fall through [-Werror=implicit-fallthrough=]
     496 |                                 if (rm & 1) {
         |                                    ^
   arch/sh/kernel/disassemble.c:500:25: note: here
     500 |                         case D_REG_M:
         |                         ^~~~
   cc1: all warnings being treated as errors

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
