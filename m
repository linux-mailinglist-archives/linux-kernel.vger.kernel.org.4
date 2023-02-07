Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC968CFA5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBGGnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjBGGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:42:56 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA9D2D6D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675752164; x=1707288164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jIpT9ebS7n4mNSRR5/KZDqEO+r88BCQJ+kzssd4ydgA=;
  b=a9pwywPx3Q+C7aqO/Iy+LWOF9CqIvZO39ZYswYQp0lcp0cp6r2rU8pbB
   QFA56buCBVjXToNU93knd8tA0UiHbFu8Gc0q+5S+jyOpoiVxnEiGMwedi
   jrwJCK2REjdZ+shlGZS3FpZY/uh8KFgO6E6rw10o0DopAbyn8nobmlbpE
   UeCXsrHS83uUbQJUfy+jxnyI252uFd2g7T4BCHSuzpWpN16NpY/qzl1e7
   hpxpR0NCatmY5P0yz6mmky5V649hwVz7ToteKPfsywETZ86qgy7dr+wdb
   Ym5CzZlMFVnm1qkeG6kJPw94KgeshksYMPj9uaD291oUOHBPNa8jU9aFG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391817593"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="391817593"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 22:42:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995627008"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="995627008"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Feb 2023 22:42:41 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPHgf-0003CM-0V;
        Tue, 07 Feb 2023 06:42:41 +0000
Date:   Tue, 7 Feb 2023 14:41:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:sched/core 10/10] vmlinux.o: warning: objtool: poll_idle+0x4a:
 call to ftrace_likely_update() leaves .noinstr.text section
Message-ID: <202302071403.la39hU5C-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   4d627628d7584f3d3add1d53342d0f01aa878e04
commit: 4d627628d7584f3d3add1d53342d0f01aa878e04 [10/10] cpuidle: Fix poll_idle() noinstr annotation
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20230207/202302071403.la39hU5C-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=4d627628d7584f3d3add1d53342d0f01aa878e04
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip sched/core
        git checkout 4d627628d7584f3d3add1d53342d0f01aa878e04
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __asan_memset+0x53: call to __memset() with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_memmove+0x7f: call to __memmove() with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_memcpy+0x7f: call to __memcpy() with UACCESS enabled
   vmlinux.o: warning: objtool: __wrgsbase_inactive+0x36: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __rdgsbase_inactive+0x32: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret+0x75: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug+0x3d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi+0xbc: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler+0x34: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: native_sched_clock+0x7d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_check_crashing_cpu+0xd: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check+0x4d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_machine_check+0x52: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: pvclock_clocksource_read_nowd+0xb2: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: local_clock+0x44: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x49: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x8e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x3f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit+0x3e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mwait_idle+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x45: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_s2idle+0x63: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_xstate+0x5e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_irq+0x5a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle+0x59: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_ibrs+0x12: call to sched_smt_active() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x53: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter+0x4c: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: poll_idle+0x4a: call to ftrace_likely_update() leaves .noinstr.text section


objdump-func vmlinux.o poll_idle:
0000 0000000000000b3b <poll_idle>:
0000  b3b:	f3 0f 1e fa          	endbr64
0004  b3f:	41 57                	push   %r15
0006  b41:	49 89 f7             	mov    %rsi,%r15
0009  b44:	41 56                	push   %r14
000b  b46:	41 55                	push   %r13
000d  b48:	41 89 d5             	mov    %edx,%r13d
0010  b4b:	41 54                	push   %r12
0012  b4d:	55                   	push   %rbp
0013  b4e:	53                   	push   %rbx
0014  b4f:	48 89 fb             	mov    %rdi,%rbx
0017  b52:	51                   	push   %rcx
0018  b53:	e8 00 00 00 00       	call   b58 <poll_idle+0x1d>	b54: R_X86_64_PLT32	local_clock-0x4
001d  b58:	80 23 fb             	andb   $0xfb,(%rbx)
0020  b5b:	49 89 c6             	mov    %rax,%r14
0023  b5e:	fb                   	sti
0024  b5f:	4c 8b 24 25 00 00 00 00 	mov    0x0,%r12	b63: R_X86_64_32S	pcpu_hot
002c  b67:	41 80 4c 24 02 20    	orb    $0x20,0x2(%r12)
0032  b6d:	49 8b 2c 24          	mov    (%r12),%rbp
0036  b71:	31 c9                	xor    %ecx,%ecx
0038  b73:	31 d2                	xor    %edx,%edx
003a  b75:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	b78: R_X86_64_32S	_ftrace_annotated_branch+0xf5010
0041  b7c:	48 c1 ed 03          	shr    $0x3,%rbp
0045  b80:	83 e5 01             	and    $0x1,%ebp
0048  b83:	89 ee                	mov    %ebp,%esi
004a  b85:	e8 00 00 00 00       	call   b8a <poll_idle+0x4f>	b86: R_X86_64_PLT32	ftrace_likely_update-0x4
004f  b8a:	48 85 ed             	test   %rbp,%rbp
0052  b8d:	75 4f                	jne    bde <poll_idle+0xa3>
0054  b8f:	48 89 de             	mov    %rbx,%rsi
0057  b92:	4c 89 ff             	mov    %r15,%rdi
005a  b95:	e8 00 00 00 00       	call   b9a <poll_idle+0x5f>	b96: R_X86_64_PLT32	cpuidle_poll_time-0x4
005f  b9a:	48 89 04 24          	mov    %rax,(%rsp)
0063  b9e:	41 bf c9 00 00 00    	mov    $0xc9,%r15d
0069  ba4:	49 8b 2c 24          	mov    (%r12),%rbp
006d  ba8:	31 c9                	xor    %ecx,%ecx
006f  baa:	31 d2                	xor    %edx,%edx
0071  bac:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	baf: R_X86_64_32S	_ftrace_annotated_branch+0xf5040
0078  bb3:	48 c1 ed 03          	shr    $0x3,%rbp
007c  bb7:	83 e5 01             	and    $0x1,%ebp
007f  bba:	89 ee                	mov    %ebp,%esi
0081  bbc:	e8 00 00 00 00       	call   bc1 <poll_idle+0x86>	bbd: R_X86_64_PLT32	ftrace_likely_update-0x4
0086  bc1:	48 85 ed             	test   %rbp,%rbp
0089  bc4:	75 18                	jne    bde <poll_idle+0xa3>
008b  bc6:	f3 90                	pause
008d  bc8:	41 ff cf             	dec    %r15d
0090  bcb:	75 d7                	jne    ba4 <poll_idle+0x69>
0092  bcd:	e8 00 00 00 00       	call   bd2 <poll_idle+0x97>	bce: R_X86_64_PLT32	local_clock-0x4
0097  bd2:	4c 29 f0             	sub    %r14,%rax
009a  bd5:	48 3b 04 24          	cmp    (%rsp),%rax
009e  bd9:	76 c3                	jbe    b9e <poll_idle+0x63>
00a0  bdb:	80 0b 04             	orb    $0x4,(%rbx)
00a3  bde:	fa                   	cli
00a4  bdf:	48 8b 04 25 00 00 00 00 	mov    0x0,%rax	be3: R_X86_64_32S	pcpu_hot
00ac  be7:	80 60 02 df          	andb   $0xdf,0x2(%rax)
00b0  beb:	48 8b 00             	mov    (%rax),%rax
00b3  bee:	a8 08                	test   $0x8,%al
00b5  bf0:	74 0a                	je     bfc <poll_idle+0xc1>
00b7  bf2:	81 25 00 00 00 00 ff ff ff 7f 	andl   $0x7fffffff,0x0(%rip)        # bfc <poll_idle+0xc1>	bf4: R_X86_64_PC32	pcpu_hot
00c1  bfc:	5a                   	pop    %rdx
00c2  bfd:	44 89 e8             	mov    %r13d,%eax
00c5  c00:	5b                   	pop    %rbx
00c6  c01:	5d                   	pop    %rbp
00c7  c02:	41 5c                	pop    %r12
00c9  c04:	41 5d                	pop    %r13
00cb  c06:	41 5e                	pop    %r14
00cd  c08:	41 5f                	pop    %r15
00cf  c0a:	c3                   	ret

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
