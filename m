Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD04676BF0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 10:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjAVJp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 04:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjAVJp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 04:45:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD46817147
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674380724; x=1705916724;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=62GSkWHpr/lhKKjA6/XqYhX9DwZxKq4vaudQBUAmdlk=;
  b=Ezdp1VwoHzSUpkbFDMJxk3iqv51ZmxKME4Gg8w4woR2fifxE6k5KlHEs
   tmH2Xs/7I+TPOkNgQASHMsIScL2vxBtZjmcbo86Pp/swJesYNlTNUTZan
   YXF8rdPg0l7yuFBQ9UIFcoUeUYXIwWIId4yyMm0ZGO9DhDLjue6erUSmy
   PYbpR2li44ogXZn2Q93r0JlISRAJWz+j7oFGPff1pAZGdIjyvWmHri8LX
   ZsHSIqRTq8sNJjJPV69ocjOrqgMzdLgfl8bJTcEQY1h0PSiY37ak+J2J3
   hE1zmbCYHoz3MplEWkImm6y2MTMwW04MQgFpBkEJYmoPL9e0cwlXOVXm2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="353139370"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="353139370"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 01:45:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="691586222"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="691586222"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Jan 2023 01:45:22 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJWuf-0004vz-2Y;
        Sun, 22 Jan 2023 09:45:21 +0000
Date:   Sun, 22 Jan 2023 17:45:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: cc1: error: arch/sh/include/mach-hp6xx: No such file or directory
Message-ID: <202301221726.2AhhlplT-lkp@intel.com>
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

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2241ab53cbb5cdb08a6b2d4688feb13971058f65
commit: 4c8dd95a723d9cccf8810be54aa62be82885c9d8 kbuild: add some extra warning flags unconditionally
date:   3 years, 8 months ago
config: sh-hp6xx_defconfig (https://download.01.org/0day-ci/archive/20230122/202301221726.2AhhlplT-lkp@intel.com/config)
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

All errors (new ones prefixed by >>):

>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
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
   arch/sh/kernel/hw_breakpoint.c: In function 'arch_bp_generic_fields':
   arch/sh/kernel/hw_breakpoint.c:159:27: error: this statement may fall through [-Werror=implicit-fallthrough=]
     159 |                 *gen_type = HW_BREAKPOINT_R;
         |                 ~~~~~~~~~~^~~~~~~~~~~~~~~~~
   arch/sh/kernel/hw_breakpoint.c:160:9: note: here
     160 |         case SH_BREAKPOINT_WRITE:
         |         ^~~~
   cc1: all warnings being treated as errors

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
