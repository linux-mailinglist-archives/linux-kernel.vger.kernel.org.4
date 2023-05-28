Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D371377A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 04:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjE1Cf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 22:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1Cf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 22:35:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7934A2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685241354; x=1716777354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SsbA6YAE4EDLXAY3iKxF49ur7rC4X6+7Zn8oBIIGyAg=;
  b=gmNqjJ3H4VX5+Q7pKQrT0Hjb7tA6TgDaxpwZcjeZeF5yZjXZORoFGYjT
   QyoJCCe4YdBK3gxnPYMD52hlNDFPqk8qgBoWBh1WxRi4kBBo8bNTZfuOJ
   oK0/5F9ICEZGhJVNZF5Wsr9h0WdECbKZuinD54Icub5YphGMCBvIEpE5W
   x6xejkTw8Al6TbjCI6/hiv6JXpPpvphNS5CWxEVgENmZ+wqdjxiBmU1ly
   Msgz5YlhvFI+hiy94JXVITvHM5mZw8cSszBS8KGMT281IjXUnuplmZzP7
   7QA987vlUM7NgiBZ6nk4k5w79ZpQ1nRgqfv5pFUgzWOKltY3Ul7eZ0ANi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="334095834"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="334095834"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 19:35:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="1035777852"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="1035777852"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 May 2023 19:35:52 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q36G8-000KOQ-0u;
        Sun, 28 May 2023 02:35:52 +0000
Date:   Sun, 28 May 2023 10:35:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [tip:objtool/core 8/12] vmlinux.o: warning: objtool:
 do_arch_prctl_common+0xf4: preempt_schedule_thunk() is missing a __noreturn
 annotation
Message-ID: <202305281037.3PaI3tW4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
head:   6245ce4ab670166efcdae843c35c14e4c0811aa3
commit: fedb724c3db5490234ddde0103811c28c2fedae0 [8/12] objtool: Detect missing __noreturn annotations
config: x86_64-randconfig-x085-20230528 (https://download.01.org/0day-ci/archive/20230528/202305281037.3PaI3tW4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fedb724c3db5490234ddde0103811c28c2fedae0
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip objtool/core
        git checkout fedb724c3db5490234ddde0103811c28c2fedae0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305281037.3PaI3tW4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: do_arch_prctl_common+0xf4: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: raise_mce+0x380: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: unwind_next_frame+0x11e4: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: process_one_work+0x942: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __kthread_parkme+0x14a: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __sched_setscheduler+0xf54: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: rt_mutex_setprio+0x6e5: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __down_read_trylock+0x269: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __up_write+0x405: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __up_read+0x536: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __percpu_rwsem_trylock+0x3e: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __sync_rcu_exp_select_node_cpus+0x41d: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __symbol_get+0xd9: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: lookup_module_symbol_name+0x118: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: lookup_module_symbol_attrs+0x142: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: show_kprobe_addr+0x134: preempt_schedule_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __trace_event_discard_commit+0x47: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __ftrace_trace_stack+0x1da: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: ftrace_trace_userstack+0x246: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: __trace_array_puts+0x2e2: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: __trace_bputs+0x19c: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: __trace_array_vprintk+0x1d5: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: tracing_mark_raw_write+0x2bd: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: tracing_mark_write+0x4b2: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: trace_buffered_event_enable+0x193: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: trace_buffer_unlock_commit_regs+0xab: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: trace_buffer_unlock_commit_nostack+0x9c: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: trace_function+0x1a9: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: trace_last_func_repeats+0x27a: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: trace_vbprintk+0x225: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: user_event_ftrace+0x303: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: rethook_flush_task+0xb3: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: irq_work_queue+0x35f: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: bpf_bprintf_prepare+0x1e1: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: htab_lock_bucket+0x118: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: bp_constraints_lock+0x107: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: folio_deactivate+0x15a: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: rmqueue_pcplist.constprop.0+0x7f: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: free_unref_page+0x170: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: free_unref_page_list+0x30c: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: __kmem_cache_alloc_bulk+0xf8: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: iput+0x287: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: wb_workfn+0x3f5: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: __break_lease+0x889: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: __i2c_transfer+0x346: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: __i2c_smbus_xfer+0x3a8: preempt_schedule_notrace_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: edac_raw_mc_handle_error+0xc16: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: iptunnel_xmit+0x6df: preempt_schedule_thunk() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: native_sched_clock+0xd0: preempt_schedule_notrace_thunk() is missing a __noreturn annotation


objdump-func vmlinux.o do_arch_prctl_common:
0000 0000000000078edd <do_arch_prctl_common>:
0000    78edd:	f3 0f 1e fa          	endbr64
0004    78ee1:	e8 00 00 00 00       	call   78ee6 <do_arch_prctl_common+0x9>	78ee2: R_X86_64_PLT32	__fentry__-0x4
0009    78ee6:	55                   	push   %rbp
000a    78ee7:	41 50                	push   %r8
000c    78ee9:	81 ff 12 10 00 00    	cmp    $0x1012,%edi
0012    78eef:	74 43                	je     78f34 <do_arch_prctl_common+0x57>
0014    78ef1:	7f 2b                	jg     78f1e <do_arch_prctl_common+0x41>
0016    78ef3:	81 ff 11 10 00 00    	cmp    $0x1011,%edi
001c    78ef9:	0f 85 d4 00 00 00    	jne    78fd3 <do_arch_prctl_common+0xf6>
0022    78eff:	be 0f 00 00 00       	mov    $0xf,%esi
0027    78f04:	48 8b 3c 25 00 00 00 00 	mov    0x0,%rdi	78f08: R_X86_64_32S	pcpu_hot
002f    78f0c:	e8 30 e6 ff ff       	call   77541 <test_ti_thread_flag>
0034    78f11:	85 c0                	test   %eax,%eax
0036    78f13:	0f 94 c0             	sete   %al
0039    78f16:	0f b6 c0             	movzbl %al,%eax
003c    78f19:	e9 bc 00 00 00       	jmp    78fda <do_arch_prctl_common+0xfd>
0041    78f1e:	8d 87 df ef ff ff    	lea    -0x1021(%rdi),%eax
0047    78f24:	83 f8 04             	cmp    $0x4,%eax
004a    78f27:	0f 87 a6 00 00 00    	ja     78fd3 <do_arch_prctl_common+0xf6>
0050    78f2d:	59                   	pop    %rcx
0051    78f2e:	5d                   	pop    %rbp
0052    78f2f:	e9 00 00 00 00       	jmp    78f34 <do_arch_prctl_common+0x57>	78f30: R_X86_64_PLT32	fpu_xstate_prctl-0x4
0057    78f34:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	78f37: R_X86_64_32S	boot_cpu_data+0x40
005e    78f3b:	ba ff ff 37 00       	mov    $0x37ffff,%edx
0063    78f40:	48 c1 e8 03          	shr    $0x3,%rax
0067    78f44:	48 c1 e2 2a          	shl    $0x2a,%rdx
006b    78f48:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)
006f    78f4c:	74 14                	je     78f62 <do_arch_prctl_common+0x85>
0071    78f4e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	78f51: R_X86_64_32S	boot_cpu_data+0x40
0078    78f55:	48 89 34 24          	mov    %rsi,(%rsp)
007c    78f59:	e8 00 00 00 00       	call   78f5e <do_arch_prctl_common+0x81>	78f5a: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0081    78f5e:	48 8b 34 24          	mov    (%rsp),%rsi
0085    78f62:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 78f69 <do_arch_prctl_common+0x8c>	78f65: R_X86_64_PC32	boot_cpu_data+0x3c
008c    78f69:	48 c7 c0 ed ff ff ff 	mov    $0xffffffffffffffed,%rax
0093    78f70:	48 0f ba e2 21       	bt     $0x21,%rdx
0098    78f75:	73 63                	jae    78fda <do_arch_prctl_common+0xfd>
009a    78f77:	48 85 f6             	test   %rsi,%rsi
009d    78f7a:	74 09                	je     78f85 <do_arch_prctl_common+0xa8>
009f    78f7c:	e8 a9 e6 ff ff       	call   7762a <enable_cpuid>
00a4    78f81:	31 c0                	xor    %eax,%eax
00a6    78f83:	eb 55                	jmp    78fda <do_arch_prctl_common+0xfd>
00a8    78f85:	bf 01 00 00 00       	mov    $0x1,%edi
00ad    78f8a:	e8 00 00 00 00       	call   78f8f <do_arch_prctl_common+0xb2>	78f8b: R_X86_64_PLT32	preempt_count_add-0x4
00b2    78f8f:	be 08 00 00 00       	mov    $0x8,%esi
00b7    78f94:	48 8b 2c 25 00 00 00 00 	mov    0x0,%rbp	78f98: R_X86_64_32S	pcpu_hot
00bf    78f9c:	48 89 ef             	mov    %rbp,%rdi
00c2    78f9f:	e8 00 00 00 00       	call   78fa4 <do_arch_prctl_common+0xc7>	78fa0: R_X86_64_PLT32	__kasan_check_write-0x4
00c7    78fa4:	48 0f ba 6d 00 0f    	btsq   $0xf,0x0(%rbp)
00cd    78faa:	72 0a                	jb     78fb6 <do_arch_prctl_common+0xd9>
00cf    78fac:	bf 01 00 00 00       	mov    $0x1,%edi
00d4    78fb1:	e8 4c e6 ff ff       	call   77602 <set_cpuid_faulting>
00d9    78fb6:	bf 01 00 00 00       	mov    $0x1,%edi
00de    78fbb:	e8 00 00 00 00       	call   78fc0 <do_arch_prctl_common+0xe3>	78fbc: R_X86_64_PLT32	preempt_count_sub-0x4
00e3    78fc0:	31 c0                	xor    %eax,%eax
00e5    78fc2:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 78fc8 <do_arch_prctl_common+0xeb>	78fc4: R_X86_64_PC32	pcpu_hot+0x4
00eb    78fc8:	85 d2                	test   %edx,%edx
00ed    78fca:	75 0e                	jne    78fda <do_arch_prctl_common+0xfd>
00ef    78fcc:	e8 00 00 00 00       	call   78fd1 <do_arch_prctl_common+0xf4>	78fcd: R_X86_64_PLT32	preempt_schedule_thunk-0x4
00f4    78fd1:	eb 07                	jmp    78fda <do_arch_prctl_common+0xfd>
00f6    78fd3:	48 c7 c0 ea ff ff ff 	mov    $0xffffffffffffffea,%rax
00fd    78fda:	5a                   	pop    %rdx
00fe    78fdb:	5d                   	pop    %rbp
00ff    78fdc:	31 d2                	xor    %edx,%edx
0101    78fde:	31 c9                	xor    %ecx,%ecx
0103    78fe0:	31 f6                	xor    %esi,%esi
0105    78fe2:	31 ff                	xor    %edi,%edi
0107    78fe4:	45 31 c0             	xor    %r8d,%r8d
010a    78fe7:	e9 00 00 00 00       	jmp    78fec <fpu__init_cpu>	78fe8: R_X86_64_PLT32	__x86_return_thunk-0x4

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
