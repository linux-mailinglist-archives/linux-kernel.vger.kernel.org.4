Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4815B460A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 13:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIJLYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 07:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIJLYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 07:24:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B943336
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662809043; x=1694345043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z9h+x7W/Mk441CW9ffCcIjK4EZkdlgg2fx+a2K45CFQ=;
  b=mb95U51qMEXm9ejpyuS0Vd5dVlRgO4ax+Xfz8XDN1NJ1QWYtTweC5uYz
   SgOdoPEaMCpovobGqyEfG3R0n95FFxDYHWjQEzfkVEdRw4aIkOnF1DbuC
   h7QPnMQ1jNi1CHaNt0nLXDN2ohc05IHMwo3b/phAxZor5dbOT9wshIR+C
   ULeFcZTIg/rfks47My4GspuEY3jjzHnEo1XR0TFiq0gGv17WohfQRJHZD
   wQk8vHflNhXxN37fyPBf2rzIuAGrxT6VQr4IN1YmL4kb/PPKAPceyeyrl
   ey4p0llP4uBI4vM1yw0B4LBow3Up5gcNK76LMgf6izXZV5G3HIsT60rwq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="284651889"
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="284651889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 04:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="645864051"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2022 04:24:00 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWyad-00003D-1V;
        Sat, 10 Sep 2022 11:23:59 +0000
Date:   Sat, 10 Sep 2022 19:23:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [masahiroy:fixes 6/6] arch/mips/kernel/branch.c:712:20: error:
 instruction requires a CPU feature not currently enabled
Message-ID: <202209101939.bvk64Fok-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git fixes
head:   97f72ed7a6b5a6bbac628f1f6e91cf06d1ea2cb5
commit: 97f72ed7a6b5a6bbac628f1f6e91cf06d1ea2cb5 [6/6] Makefile.compiler: Use KBUILD_AFLAGS for as-option
config: mips-loongson2k_defconfig (https://download.01.org/0day-ci/archive/20220910/202209101939.bvk64Fok-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips64el-linux-gnuabi64
        # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=97f72ed7a6b5a6bbac628f1f6e91cf06d1ea2cb5
        git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
        git fetch --no-tags masahiroy fixes
        git checkout 97f72ed7a6b5a6bbac628f1f6e91cf06d1ea2cb5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/kernel/branch.c:712:20: error: instruction requires a CPU feature not currently enabled
                                   fcr31 = read_32bit_cp1_register(CP1_STATUS);
                                           ^
   arch/mips/include/asm/mipsregs.h:2405:2: note: expanded from macro 'read_32bit_cp1_register'
           _read_32bit_cp1_register(source, )
           ^
   arch/mips/include/asm/mipsregs.h:2381:3: note: expanded from macro '_read_32bit_cp1_register'
           "       cfc1    %0,"STR(source)"                        \n"     \
            ^
   <inline asm>:7:2: note: instantiated into assembly here
           cfc1    $19,$31                 
           ^
   1 error generated.
--
    ^
   <instantiation>:10:13: error: invalid operand for instruction
    ldc1 $f12, 2176($4)
               ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
   <instantiation>:11:13: error: invalid operand for instruction
    ldc1 $f14, 2192($4)
               ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
   <instantiation>:12:13: error: invalid operand for instruction
    ldc1 $f16, 2208($4)
               ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
   <instantiation>:13:13: error: invalid operand for instruction
    ldc1 $f18, 2224($4)
               ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
   <instantiation>:14:13: error: invalid operand for instruction
    ldc1 $f20, 2240($4)
               ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
   <instantiation>:15:13: error: invalid operand for instruction
    ldc1 $f22, 2256($4)
               ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
   <instantiation>:16:13: error: invalid operand for instruction
    ldc1 $f24, 2272($4)
               ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
   <instantiation>:17:13: error: invalid operand for instruction
    ldc1 $f26, 2288($4)
               ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
   <instantiation>:18:13: error: invalid operand for instruction
    ldc1 $f28, 2304($4)
               ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
   <instantiation>:19:13: error: invalid operand for instruction
    ldc1 $f30, 2320($4)
               ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
   <instantiation>:20:2: error: instruction requires a CPU feature not currently enabled
    ctc1 $13, $31
    ^
   <instantiation>:9:2: note: while in macro instantiation
    fpu_restore_16even $4 $13
    ^
   arch/mips/kernel/r4k_fpu.S:59:2: note: while in macro instantiation
    fpu_restore_double $4 $12 $13 # clobbers $13
    ^
>> arch/mips/kernel/r4k_fpu.S:102:2: error: instruction requires a CPU feature not currently enabled
    cfc1 $13, $31
    ^
   <instantiation>:4:17: error: invalid operand for instruction
   .ex8: sdc1 $f1, 8($4)
                   ^
   arch/mips/kernel/r4k_fpu.S:118:2: note: while in macro instantiation
    EX sdc1 $f1, 8($4)
    ^
   <instantiation>:4:17: error: invalid operand for instruction
   .ex9: sdc1 $f3, 24($4)
                   ^
   arch/mips/kernel/r4k_fpu.S:119:2: note: while in macro instantiation
    EX sdc1 $f3, 24($4)
    ^
   <instantiation>:4:18: error: invalid operand for instruction
   .ex10: sdc1 $f5, 40($4)
                    ^
   arch/mips/kernel/r4k_fpu.S:120:2: note: while in macro instantiation
    EX sdc1 $f5, 40($4)
    ^
   <instantiation>:4:18: error: invalid operand for instruction
   .ex11: sdc1 $f7, 56($4)
                    ^
   arch/mips/kernel/r4k_fpu.S:121:2: note: while in macro instantiation
    EX sdc1 $f7, 56($4)
    ^
   <instantiation>:4:18: error: invalid operand for instruction
   .ex12: sdc1 $f9, 72($4)
                    ^
   arch/mips/kernel/r4k_fpu.S:122:2: note: while in macro instantiation
    EX sdc1 $f9, 72($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex13: sdc1 $f11, 88($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:123:2: note: while in macro instantiation
    EX sdc1 $f11, 88($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex14: sdc1 $f13, 104($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:124:2: note: while in macro instantiation
    EX sdc1 $f13, 104($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex15: sdc1 $f15, 120($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:125:2: note: while in macro instantiation
    EX sdc1 $f15, 120($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex16: sdc1 $f17, 136($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:126:2: note: while in macro instantiation
    EX sdc1 $f17, 136($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex17: sdc1 $f19, 152($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:127:2: note: while in macro instantiation
    EX sdc1 $f19, 152($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex18: sdc1 $f21, 168($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:128:2: note: while in macro instantiation
    EX sdc1 $f21, 168($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex19: sdc1 $f23, 184($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:129:2: note: while in macro instantiation
    EX sdc1 $f23, 184($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex20: sdc1 $f25, 200($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:130:2: note: while in macro instantiation
    EX sdc1 $f25, 200($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex21: sdc1 $f27, 216($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:131:2: note: while in macro instantiation
    EX sdc1 $f27, 216($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex22: sdc1 $f29, 232($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:132:2: note: while in macro instantiation
    EX sdc1 $f29, 232($4)
    ^
   <instantiation>:4:19: error: invalid operand for instruction
   .ex23: sdc1 $f31, 248($4)
                     ^
   arch/mips/kernel/r4k_fpu.S:133:2: note: while in macro instantiation
    EX sdc1 $f31, 248($4)
    ^
   <instantiation>:4:18: error: invalid operand for instruction
   .ex24: sdc1 $f0, 0($4)
--
>> arch/mips/math-emu/cp1emu.c:734:20: error: instruction requires a CPU feature not currently enabled
                                   fcr31 = read_32bit_cp1_register(CP1_STATUS);
                                           ^
   arch/mips/include/asm/mipsregs.h:2405:2: note: expanded from macro 'read_32bit_cp1_register'
           _read_32bit_cp1_register(source, )
           ^
   arch/mips/include/asm/mipsregs.h:2381:3: note: expanded from macro '_read_32bit_cp1_register'
           "       cfc1    %0,"STR(source)"                        \n"     \
            ^
   <inline asm>:7:2: note: instantiated into assembly here
           cfc1    $20,$31                 
           ^
   1 error generated.


vim +712 arch/mips/kernel/branch.c

8508488fe7028b Steven J. Hill    2013-03-25  401  
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  402  /**
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  403   * __compute_return_epc_for_insn - Computes the return address and do emulate
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  404   *				    branch simulation, if required.
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  405   *
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  406   * @regs:	Pointer to pt_regs
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  407   * @insn:	branch instruction to decode
cdf93470a065de Mathieu Malaterre 2017-12-27  408   * Return:	-EFAULT on error and forces SIGILL, and on success
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  409   *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  410   *		evaluating the branch.
a8ff66f52d3f17 Markos Chandras   2014-11-26  411   *
a8ff66f52d3f17 Markos Chandras   2014-11-26  412   * MIPS R6 Compact branches and forbidden slots:
a8ff66f52d3f17 Markos Chandras   2014-11-26  413   *	Compact branches do not throw exceptions because they do
a8ff66f52d3f17 Markos Chandras   2014-11-26  414   *	not have delay slots. The forbidden slot instruction ($PC+4)
a8ff66f52d3f17 Markos Chandras   2014-11-26  415   *	is only executed if the branch was not taken. Otherwise the
a8ff66f52d3f17 Markos Chandras   2014-11-26  416   *	forbidden slot is skipped entirely. This means that the
a8ff66f52d3f17 Markos Chandras   2014-11-26  417   *	only possible reason to be here because of a MIPS R6 compact
a8ff66f52d3f17 Markos Chandras   2014-11-26  418   *	branch instruction is that the forbidden slot has thrown one.
a8ff66f52d3f17 Markos Chandras   2014-11-26  419   *	In that case the branch was not taken, so the EPC can be safely
a8ff66f52d3f17 Markos Chandras   2014-11-26  420   *	set to EPC + 8.
^1da177e4c3f41 Linus Torvalds    2005-04-16  421   */
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  422  int __compute_return_epc_for_insn(struct pt_regs *regs,
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  423  				   union mips_instruction insn)
^1da177e4c3f41 Linus Torvalds    2005-04-16  424  {
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  425  	long epc = regs->cp0_epc;
6a1cc218b9ccf8 Paul Burton       2018-11-07  426  	unsigned int dspcontrol;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  427  	int ret = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  428  
^1da177e4c3f41 Linus Torvalds    2005-04-16  429  	switch (insn.i_format.opcode) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  430  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  431  	 * jr and jalr are in r_format format.
^1da177e4c3f41 Linus Torvalds    2005-04-16  432  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  433  	case spec_op:
^1da177e4c3f41 Linus Torvalds    2005-04-16  434  		switch (insn.r_format.func) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  435  		case jalr_op:
^1da177e4c3f41 Linus Torvalds    2005-04-16  436  			regs->regs[insn.r_format.rd] = epc + 8;
c9b0299034665d Liangliang Huang  2020-05-04  437  			fallthrough;
^1da177e4c3f41 Linus Torvalds    2005-04-16  438  		case jr_op:
5f9f41c474befb Markos Chandras   2014-11-25  439  			if (NO_R6EMU && insn.r_format.func == jr_op)
1f4edde4229613 Maciej W. Rozycki 2017-06-16  440  				goto sigill_r2r6;
^1da177e4c3f41 Linus Torvalds    2005-04-16  441  			regs->cp0_epc = regs->regs[insn.r_format.rs];
^1da177e4c3f41 Linus Torvalds    2005-04-16  442  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  443  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  444  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  445  
^1da177e4c3f41 Linus Torvalds    2005-04-16  446  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  447  	 * This group contains:
^1da177e4c3f41 Linus Torvalds    2005-04-16  448  	 * bltz_op, bgez_op, bltzl_op, bgezl_op,
^1da177e4c3f41 Linus Torvalds    2005-04-16  449  	 * bltzal_op, bgezal_op, bltzall_op, bgezall_op.
^1da177e4c3f41 Linus Torvalds    2005-04-16  450  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  451  	case bcond_op:
^1da177e4c3f41 Linus Torvalds    2005-04-16  452  		switch (insn.i_format.rt) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  453  		case bltzl_op:
319824eabc3f1c Markos Chandras   2014-11-25  454  			if (NO_R6EMU)
1f4edde4229613 Maciej W. Rozycki 2017-06-16  455  				goto sigill_r2r6;
c9b0299034665d Liangliang Huang  2020-05-04  456  			fallthrough;
319824eabc3f1c Markos Chandras   2014-11-25  457  		case bltz_op:
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  458  			if ((long)regs->regs[insn.i_format.rs] < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  459  				epc = epc + 4 + (insn.i_format.simmediate << 2);
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  460  				if (insn.i_format.rt == bltzl_op)
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  461  					ret = BRANCH_LIKELY_TAKEN;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  462  			} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  463  				epc += 8;
^1da177e4c3f41 Linus Torvalds    2005-04-16  464  			regs->cp0_epc = epc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  465  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  466  
^1da177e4c3f41 Linus Torvalds    2005-04-16  467  		case bgezl_op:
319824eabc3f1c Markos Chandras   2014-11-25  468  			if (NO_R6EMU)
1f4edde4229613 Maciej W. Rozycki 2017-06-16  469  				goto sigill_r2r6;
c9b0299034665d Liangliang Huang  2020-05-04  470  			fallthrough;
319824eabc3f1c Markos Chandras   2014-11-25  471  		case bgez_op:
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  472  			if ((long)regs->regs[insn.i_format.rs] >= 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  473  				epc = epc + 4 + (insn.i_format.simmediate << 2);
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  474  				if (insn.i_format.rt == bgezl_op)
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  475  					ret = BRANCH_LIKELY_TAKEN;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  476  			} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  477  				epc += 8;
^1da177e4c3f41 Linus Torvalds    2005-04-16  478  			regs->cp0_epc = epc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  479  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  480  
^1da177e4c3f41 Linus Torvalds    2005-04-16  481  		case bltzal_op:
^1da177e4c3f41 Linus Torvalds    2005-04-16  482  		case bltzall_op:
319824eabc3f1c Markos Chandras   2014-11-25  483  			if (NO_R6EMU && (insn.i_format.rs ||
fef40be6da856a Maciej W. Rozycki 2017-06-16  484  			    insn.i_format.rt == bltzall_op))
fef40be6da856a Maciej W. Rozycki 2017-06-16  485  				goto sigill_r2r6;
^1da177e4c3f41 Linus Torvalds    2005-04-16  486  			regs->regs[31] = epc + 8;
319824eabc3f1c Markos Chandras   2014-11-25  487  			/*
319824eabc3f1c Markos Chandras   2014-11-25  488  			 * OK we are here either because we hit a NAL
319824eabc3f1c Markos Chandras   2014-11-25  489  			 * instruction or because we are emulating an
4939788eb85597 Ralf Baechle      2016-05-22  490  			 * old bltzal{,l} one. Let's figure out what the
319824eabc3f1c Markos Chandras   2014-11-25  491  			 * case really is.
319824eabc3f1c Markos Chandras   2014-11-25  492  			 */
319824eabc3f1c Markos Chandras   2014-11-25  493  			if (!insn.i_format.rs) {
319824eabc3f1c Markos Chandras   2014-11-25  494  				/*
319824eabc3f1c Markos Chandras   2014-11-25  495  				 * NAL or BLTZAL with rs == 0
319824eabc3f1c Markos Chandras   2014-11-25  496  				 * Doesn't matter if we are R6 or not. The
319824eabc3f1c Markos Chandras   2014-11-25  497  				 * result is the same
319824eabc3f1c Markos Chandras   2014-11-25  498  				 */
319824eabc3f1c Markos Chandras   2014-11-25  499  				regs->cp0_epc += 4 +
319824eabc3f1c Markos Chandras   2014-11-25  500  					(insn.i_format.simmediate << 2);
319824eabc3f1c Markos Chandras   2014-11-25  501  				break;
319824eabc3f1c Markos Chandras   2014-11-25  502  			}
319824eabc3f1c Markos Chandras   2014-11-25  503  			/* Now do the real thing for non-R6 BLTZAL{,L} */
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  504  			if ((long)regs->regs[insn.i_format.rs] < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  505  				epc = epc + 4 + (insn.i_format.simmediate << 2);
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  506  				if (insn.i_format.rt == bltzall_op)
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  507  					ret = BRANCH_LIKELY_TAKEN;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  508  			} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  509  				epc += 8;
^1da177e4c3f41 Linus Torvalds    2005-04-16  510  			regs->cp0_epc = epc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  511  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  512  
^1da177e4c3f41 Linus Torvalds    2005-04-16  513  		case bgezal_op:
^1da177e4c3f41 Linus Torvalds    2005-04-16  514  		case bgezall_op:
319824eabc3f1c Markos Chandras   2014-11-25  515  			if (NO_R6EMU && (insn.i_format.rs ||
fef40be6da856a Maciej W. Rozycki 2017-06-16  516  			    insn.i_format.rt == bgezall_op))
fef40be6da856a Maciej W. Rozycki 2017-06-16  517  				goto sigill_r2r6;
^1da177e4c3f41 Linus Torvalds    2005-04-16  518  			regs->regs[31] = epc + 8;
319824eabc3f1c Markos Chandras   2014-11-25  519  			/*
319824eabc3f1c Markos Chandras   2014-11-25  520  			 * OK we are here either because we hit a BAL
319824eabc3f1c Markos Chandras   2014-11-25  521  			 * instruction or because we are emulating an
4939788eb85597 Ralf Baechle      2016-05-22  522  			 * old bgezal{,l} one. Let's figure out what the
319824eabc3f1c Markos Chandras   2014-11-25  523  			 * case really is.
319824eabc3f1c Markos Chandras   2014-11-25  524  			 */
319824eabc3f1c Markos Chandras   2014-11-25  525  			if (!insn.i_format.rs) {
319824eabc3f1c Markos Chandras   2014-11-25  526  				/*
319824eabc3f1c Markos Chandras   2014-11-25  527  				 * BAL or BGEZAL with rs == 0
319824eabc3f1c Markos Chandras   2014-11-25  528  				 * Doesn't matter if we are R6 or not. The
319824eabc3f1c Markos Chandras   2014-11-25  529  				 * result is the same
319824eabc3f1c Markos Chandras   2014-11-25  530  				 */
319824eabc3f1c Markos Chandras   2014-11-25  531  				regs->cp0_epc += 4 +
319824eabc3f1c Markos Chandras   2014-11-25  532  					(insn.i_format.simmediate << 2);
319824eabc3f1c Markos Chandras   2014-11-25  533  				break;
319824eabc3f1c Markos Chandras   2014-11-25  534  			}
319824eabc3f1c Markos Chandras   2014-11-25  535  			/* Now do the real thing for non-R6 BGEZAL{,L} */
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  536  			if ((long)regs->regs[insn.i_format.rs] >= 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  537  				epc = epc + 4 + (insn.i_format.simmediate << 2);
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  538  				if (insn.i_format.rt == bgezall_op)
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  539  					ret = BRANCH_LIKELY_TAKEN;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  540  			} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  541  				epc += 8;
^1da177e4c3f41 Linus Torvalds    2005-04-16  542  			regs->cp0_epc = epc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  543  			break;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  544  
e50c0a8fa60da9 Ralf Baechle      2005-05-31  545  		case bposge32_op:
e50c0a8fa60da9 Ralf Baechle      2005-05-31  546  			if (!cpu_has_dsp)
5f9f41c474befb Markos Chandras   2014-11-25  547  				goto sigill_dsp;
e50c0a8fa60da9 Ralf Baechle      2005-05-31  548  
e50c0a8fa60da9 Ralf Baechle      2005-05-31  549  			dspcontrol = rddsp(0x01);
e50c0a8fa60da9 Ralf Baechle      2005-05-31  550  
e50c0a8fa60da9 Ralf Baechle      2005-05-31  551  			if (dspcontrol >= 32) {
e50c0a8fa60da9 Ralf Baechle      2005-05-31  552  				epc = epc + 4 + (insn.i_format.simmediate << 2);
e50c0a8fa60da9 Ralf Baechle      2005-05-31  553  			} else
e50c0a8fa60da9 Ralf Baechle      2005-05-31  554  				epc += 8;
e50c0a8fa60da9 Ralf Baechle      2005-05-31  555  			regs->cp0_epc = epc;
e50c0a8fa60da9 Ralf Baechle      2005-05-31  556  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  557  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  558  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  559  
^1da177e4c3f41 Linus Torvalds    2005-04-16  560  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  561  	 * These are unconditional and in j_format.
^1da177e4c3f41 Linus Torvalds    2005-04-16  562  	 */
a9db101b735a9d Maciej W. Rozycki 2017-06-16  563  	case jalx_op:
^1da177e4c3f41 Linus Torvalds    2005-04-16  564  	case jal_op:
^1da177e4c3f41 Linus Torvalds    2005-04-16  565  		regs->regs[31] = regs->cp0_epc + 8;
c9b0299034665d Liangliang Huang  2020-05-04  566  		fallthrough;
^1da177e4c3f41 Linus Torvalds    2005-04-16  567  	case j_op:
^1da177e4c3f41 Linus Torvalds    2005-04-16  568  		epc += 4;
^1da177e4c3f41 Linus Torvalds    2005-04-16  569  		epc >>= 28;
^1da177e4c3f41 Linus Torvalds    2005-04-16  570  		epc <<= 28;
^1da177e4c3f41 Linus Torvalds    2005-04-16  571  		epc |= (insn.j_format.target << 2);
^1da177e4c3f41 Linus Torvalds    2005-04-16  572  		regs->cp0_epc = epc;
fb6883e5809c08 Leonid Yegoshin   2013-03-25  573  		if (insn.i_format.opcode == jalx_op)
fb6883e5809c08 Leonid Yegoshin   2013-03-25  574  			set_isa16_mode(regs->cp0_epc);
^1da177e4c3f41 Linus Torvalds    2005-04-16  575  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  576  
^1da177e4c3f41 Linus Torvalds    2005-04-16  577  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  578  	 * These are conditional and in i_format.
^1da177e4c3f41 Linus Torvalds    2005-04-16  579  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  580  	case beql_op:
319824eabc3f1c Markos Chandras   2014-11-25  581  		if (NO_R6EMU)
1f4edde4229613 Maciej W. Rozycki 2017-06-16  582  			goto sigill_r2r6;
c9b0299034665d Liangliang Huang  2020-05-04  583  		fallthrough;
319824eabc3f1c Markos Chandras   2014-11-25  584  	case beq_op:
^1da177e4c3f41 Linus Torvalds    2005-04-16  585  		if (regs->regs[insn.i_format.rs] ==
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  586  		    regs->regs[insn.i_format.rt]) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  587  			epc = epc + 4 + (insn.i_format.simmediate << 2);
41ca86e8502952 Ralf Baechle      2014-05-22  588  			if (insn.i_format.opcode == beql_op)
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  589  				ret = BRANCH_LIKELY_TAKEN;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  590  		} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  591  			epc += 8;
^1da177e4c3f41 Linus Torvalds    2005-04-16  592  		regs->cp0_epc = epc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  593  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  594  
^1da177e4c3f41 Linus Torvalds    2005-04-16  595  	case bnel_op:
319824eabc3f1c Markos Chandras   2014-11-25  596  		if (NO_R6EMU)
1f4edde4229613 Maciej W. Rozycki 2017-06-16  597  			goto sigill_r2r6;
c9b0299034665d Liangliang Huang  2020-05-04  598  		fallthrough;
319824eabc3f1c Markos Chandras   2014-11-25  599  	case bne_op:
^1da177e4c3f41 Linus Torvalds    2005-04-16  600  		if (regs->regs[insn.i_format.rs] !=
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  601  		    regs->regs[insn.i_format.rt]) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  602  			epc = epc + 4 + (insn.i_format.simmediate << 2);
41ca86e8502952 Ralf Baechle      2014-05-22  603  			if (insn.i_format.opcode == bnel_op)
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  604  				ret = BRANCH_LIKELY_TAKEN;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  605  		} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  606  			epc += 8;
^1da177e4c3f41 Linus Torvalds    2005-04-16  607  		regs->cp0_epc = epc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  608  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  609  
319824eabc3f1c Markos Chandras   2014-11-25  610  	case blezl_op: /* not really i_format */
e9d92d223381f1 Markos Chandras   2015-06-24  611  		if (!insn.i_format.rt && NO_R6EMU)
1f4edde4229613 Maciej W. Rozycki 2017-06-16  612  			goto sigill_r2r6;
c9b0299034665d Liangliang Huang  2020-05-04  613  		fallthrough;
319824eabc3f1c Markos Chandras   2014-11-25  614  	case blez_op:
a8ff66f52d3f17 Markos Chandras   2014-11-26  615  		/*
a8ff66f52d3f17 Markos Chandras   2014-11-26  616  		 * Compact branches for R6 for the
a8ff66f52d3f17 Markos Chandras   2014-11-26  617  		 * blez and blezl opcodes.
a8ff66f52d3f17 Markos Chandras   2014-11-26  618  		 * BLEZ  | rs = 0 | rt != 0  == BLEZALC
a8ff66f52d3f17 Markos Chandras   2014-11-26  619  		 * BLEZ  | rs = rt != 0      == BGEZALC
a8ff66f52d3f17 Markos Chandras   2014-11-26  620  		 * BLEZ  | rs != 0 | rt != 0 == BGEUC
a8ff66f52d3f17 Markos Chandras   2014-11-26  621  		 * BLEZL | rs = 0 | rt != 0  == BLEZC
a8ff66f52d3f17 Markos Chandras   2014-11-26  622  		 * BLEZL | rs = rt != 0      == BGEZC
a8ff66f52d3f17 Markos Chandras   2014-11-26  623  		 * BLEZL | rs != 0 | rt != 0 == BGEC
a8ff66f52d3f17 Markos Chandras   2014-11-26  624  		 *
a8ff66f52d3f17 Markos Chandras   2014-11-26  625  		 * For real BLEZ{,L}, rt is always 0.
a8ff66f52d3f17 Markos Chandras   2014-11-26  626  		 */
a8ff66f52d3f17 Markos Chandras   2014-11-26  627  
a8ff66f52d3f17 Markos Chandras   2014-11-26  628  		if (cpu_has_mips_r6 && insn.i_format.rt) {
a8ff66f52d3f17 Markos Chandras   2014-11-26  629  			if ((insn.i_format.opcode == blez_op) &&
a8ff66f52d3f17 Markos Chandras   2014-11-26  630  			    ((!insn.i_format.rs && insn.i_format.rt) ||
a8ff66f52d3f17 Markos Chandras   2014-11-26  631  			     (insn.i_format.rs == insn.i_format.rt)))
a8ff66f52d3f17 Markos Chandras   2014-11-26  632  				regs->regs[31] = epc + 4;
a8ff66f52d3f17 Markos Chandras   2014-11-26  633  			regs->cp0_epc += 8;
a8ff66f52d3f17 Markos Chandras   2014-11-26  634  			break;
a8ff66f52d3f17 Markos Chandras   2014-11-26  635  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  636  		/* rt field assumed to be zero */
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  637  		if ((long)regs->regs[insn.i_format.rs] <= 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  638  			epc = epc + 4 + (insn.i_format.simmediate << 2);
41ca86e8502952 Ralf Baechle      2014-05-22  639  			if (insn.i_format.opcode == blezl_op)
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  640  				ret = BRANCH_LIKELY_TAKEN;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  641  		} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  642  			epc += 8;
^1da177e4c3f41 Linus Torvalds    2005-04-16  643  		regs->cp0_epc = epc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  644  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  645  
^1da177e4c3f41 Linus Torvalds    2005-04-16  646  	case bgtzl_op:
e9d92d223381f1 Markos Chandras   2015-06-24  647  		if (!insn.i_format.rt && NO_R6EMU)
1f4edde4229613 Maciej W. Rozycki 2017-06-16  648  			goto sigill_r2r6;
c9b0299034665d Liangliang Huang  2020-05-04  649  		fallthrough;
319824eabc3f1c Markos Chandras   2014-11-25  650  	case bgtz_op:
f1b44067c19258 Markos Chandras   2014-11-26  651  		/*
f1b44067c19258 Markos Chandras   2014-11-26  652  		 * Compact branches for R6 for the
f1b44067c19258 Markos Chandras   2014-11-26  653  		 * bgtz and bgtzl opcodes.
f1b44067c19258 Markos Chandras   2014-11-26  654  		 * BGTZ  | rs = 0 | rt != 0  == BGTZALC
f1b44067c19258 Markos Chandras   2014-11-26  655  		 * BGTZ  | rs = rt != 0      == BLTZALC
f1b44067c19258 Markos Chandras   2014-11-26  656  		 * BGTZ  | rs != 0 | rt != 0 == BLTUC
f1b44067c19258 Markos Chandras   2014-11-26  657  		 * BGTZL | rs = 0 | rt != 0  == BGTZC
f1b44067c19258 Markos Chandras   2014-11-26  658  		 * BGTZL | rs = rt != 0      == BLTZC
f1b44067c19258 Markos Chandras   2014-11-26  659  		 * BGTZL | rs != 0 | rt != 0 == BLTC
f1b44067c19258 Markos Chandras   2014-11-26  660  		 *
f1b44067c19258 Markos Chandras   2014-11-26  661  		 * *ZALC varint for BGTZ &&& rt != 0
f1b44067c19258 Markos Chandras   2014-11-26  662  		 * For real GTZ{,L}, rt is always 0.
f1b44067c19258 Markos Chandras   2014-11-26  663  		 */
f1b44067c19258 Markos Chandras   2014-11-26  664  		if (cpu_has_mips_r6 && insn.i_format.rt) {
f1b44067c19258 Markos Chandras   2014-11-26  665  			if ((insn.i_format.opcode == blez_op) &&
f1b44067c19258 Markos Chandras   2014-11-26  666  			    ((!insn.i_format.rs && insn.i_format.rt) ||
f1b44067c19258 Markos Chandras   2014-11-26  667  			    (insn.i_format.rs == insn.i_format.rt)))
f1b44067c19258 Markos Chandras   2014-11-26  668  				regs->regs[31] = epc + 4;
f1b44067c19258 Markos Chandras   2014-11-26  669  			regs->cp0_epc += 8;
f1b44067c19258 Markos Chandras   2014-11-26  670  			break;
f1b44067c19258 Markos Chandras   2014-11-26  671  		}
f1b44067c19258 Markos Chandras   2014-11-26  672  
^1da177e4c3f41 Linus Torvalds    2005-04-16  673  		/* rt field assumed to be zero */
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  674  		if ((long)regs->regs[insn.i_format.rs] > 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  675  			epc = epc + 4 + (insn.i_format.simmediate << 2);
41ca86e8502952 Ralf Baechle      2014-05-22  676  			if (insn.i_format.opcode == bgtzl_op)
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  677  				ret = BRANCH_LIKELY_TAKEN;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  678  		} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  679  			epc += 8;
^1da177e4c3f41 Linus Torvalds    2005-04-16  680  		regs->cp0_epc = epc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  681  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  682  
6a1cc218b9ccf8 Paul Burton       2018-11-07  683  #ifdef CONFIG_MIPS_FP_SUPPORT
^1da177e4c3f41 Linus Torvalds    2005-04-16  684  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  685  	 * And now the FPA/cp1 branch instructions.
^1da177e4c3f41 Linus Torvalds    2005-04-16  686  	 */
6a1cc218b9ccf8 Paul Burton       2018-11-07  687  	case cop1_op: {
6a1cc218b9ccf8 Paul Burton       2018-11-07  688  		unsigned int bit, fcr31, reg;
6a1cc218b9ccf8 Paul Burton       2018-11-07  689  
c8a34581ec09a5 Markos Chandras   2014-11-26  690  		if (cpu_has_mips_r6 &&
c8a34581ec09a5 Markos Chandras   2014-11-26  691  		    ((insn.i_format.rs == bc1eqz_op) ||
c8a34581ec09a5 Markos Chandras   2014-11-26  692  		     (insn.i_format.rs == bc1nez_op))) {
cc97ab235f3fe3 Paul Burton       2018-11-07  693  			if (!init_fp_ctx(current))
cc97ab235f3fe3 Paul Burton       2018-11-07  694  				lose_fpu(1);
c8a34581ec09a5 Markos Chandras   2014-11-26  695  			reg = insn.i_format.rt;
ac1496980f1d27 Paul Burton       2016-04-21  696  			bit = get_fpr32(&current->thread.fpu.fpr[reg], 0) & 0x1;
ac1496980f1d27 Paul Burton       2016-04-21  697  			if (insn.i_format.rs == bc1eqz_op)
ac1496980f1d27 Paul Burton       2016-04-21  698  				bit = !bit;
c8a34581ec09a5 Markos Chandras   2014-11-26  699  			own_fpu(1);
c8a34581ec09a5 Markos Chandras   2014-11-26  700  			if (bit)
c8a34581ec09a5 Markos Chandras   2014-11-26  701  				epc = epc + 4 +
c8a34581ec09a5 Markos Chandras   2014-11-26  702  					(insn.i_format.simmediate << 2);
c8a34581ec09a5 Markos Chandras   2014-11-26  703  			else
c8a34581ec09a5 Markos Chandras   2014-11-26  704  				epc += 8;
c8a34581ec09a5 Markos Chandras   2014-11-26  705  			regs->cp0_epc = epc;
c8a34581ec09a5 Markos Chandras   2014-11-26  706  
c8a34581ec09a5 Markos Chandras   2014-11-26  707  			break;
c8a34581ec09a5 Markos Chandras   2014-11-26  708  		} else {
c8a34581ec09a5 Markos Chandras   2014-11-26  709  
1d74f6bc85cbdc Ralf Baechle      2005-05-09  710  			preempt_disable();
1d74f6bc85cbdc Ralf Baechle      2005-05-09  711  			if (is_fpu_owner())
842dfc11ea9a21 Manuel Lauss      2014-11-07 @712  			        fcr31 = read_32bit_cp1_register(CP1_STATUS);
1d74f6bc85cbdc Ralf Baechle      2005-05-09  713  			else
eae89076e696f5 Atsushi Nemoto    2006-05-16  714  				fcr31 = current->thread.fpu.fcr31;
1d74f6bc85cbdc Ralf Baechle      2005-05-09  715  			preempt_enable();
1d74f6bc85cbdc Ralf Baechle      2005-05-09  716  
^1da177e4c3f41 Linus Torvalds    2005-04-16  717  			bit = (insn.i_format.rt >> 2);
^1da177e4c3f41 Linus Torvalds    2005-04-16  718  			bit += (bit != 0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  719  			bit += 23;
ee1cca1b0661fa Ralf Baechle      2006-04-26  720  			switch (insn.i_format.rt & 3) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  721  			case 0: /* bc1f */
^1da177e4c3f41 Linus Torvalds    2005-04-16  722  			case 2: /* bc1fl */
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  723  				if (~fcr31 & (1 << bit)) {
c8a34581ec09a5 Markos Chandras   2014-11-26  724  					epc = epc + 4 +
c8a34581ec09a5 Markos Chandras   2014-11-26  725  						(insn.i_format.simmediate << 2);
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  726  					if (insn.i_format.rt == 2)
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  727  						ret = BRANCH_LIKELY_TAKEN;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  728  				} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  729  					epc += 8;
^1da177e4c3f41 Linus Torvalds    2005-04-16  730  				regs->cp0_epc = epc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  731  				break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  732  
^1da177e4c3f41 Linus Torvalds    2005-04-16  733  			case 1: /* bc1t */
^1da177e4c3f41 Linus Torvalds    2005-04-16  734  			case 3: /* bc1tl */
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  735  				if (fcr31 & (1 << bit)) {
c8a34581ec09a5 Markos Chandras   2014-11-26  736  					epc = epc + 4 +
c8a34581ec09a5 Markos Chandras   2014-11-26  737  						(insn.i_format.simmediate << 2);
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  738  					if (insn.i_format.rt == 3)
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  739  						ret = BRANCH_LIKELY_TAKEN;
d8d4e3ae0b5c17 Maneesh Soni      2011-11-08  740  				} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  741  					epc += 8;
^1da177e4c3f41 Linus Torvalds    2005-04-16  742  				regs->cp0_epc = epc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  743  				break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  744  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  745  			break;
c8a34581ec09a5 Markos Chandras   2014-11-26  746  		}
6a1cc218b9ccf8 Paul Burton       2018-11-07  747  	}
6a1cc218b9ccf8 Paul Burton       2018-11-07  748  #endif /* CONFIG_MIPS_FP_SUPPORT */
6a1cc218b9ccf8 Paul Burton       2018-11-07  749  

:::::: The code at line 712 was first introduced by commit
:::::: 842dfc11ea9a21f9825167c8a4f2834b205b0a79 MIPS: Fix build with binutils 2.24.51+

:::::: TO: Manuel Lauss <manuel.lauss@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
