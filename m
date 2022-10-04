Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FCA5F4CAF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiJDXnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJDXm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:42:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CED201B3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3471C61554
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 23:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E131C433C1;
        Tue,  4 Oct 2022 23:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664926972;
        bh=wQpoqUJ36mxKKYiII67tE0mlOFU6PxlfZoSKxlq/9XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrzK0cz+UihGQRWUDLq5sxwD04Y4he7mGnh67Ktxuh5CnTlBUNLtUB3xYeFLLdCsL
         WqbTuv369v9j/9rQTlNy2cPP7zO07nqyGvdGqI8axQ/z6PnEmgXUXsRgkjdnWjJzbJ
         zM+6zIMtIkntBzBzvLhsLAV0gUWNFJo7srv3pTMpJ4kS9d1JhVzH87o+2KFU4FJK0q
         MTn96diKFEbr5c69FKO/Vh0XNn0kSR0kjB9oq+RWU2joN8z3xv7HkMFCO0QF9VLKct
         1m9r2i+EUZJD+SkHiObCstrfsWwlrk9C8Dkiio7P+zY1cckbBDSKA+t3hOyaAyEKwv
         w1EdSCw0gJ6Xw==
Date:   Tue, 4 Oct 2022 16:42:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: s390x-linux-ld: kallsyms.c:undefined reference to `__tsan_memcpy'
Message-ID: <YzzE+pyUHEpzVJy2@dev-arch.thelio-3990X>
References: <202210050714.u9gnp2UF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210050714.u9gnp2UF-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://lore.kernel.org/YzsMHqG9LvMZXTz8@dev-arch.thelio-3990X/

On Wed, Oct 05, 2022 at 07:40:04AM +0800, kernel test robot wrote:
> Hi Alan,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0326074ff4652329f2a1a9c8685104576bd8d131
> commit: 647cafa22349026a8435030e9157074ab7fe5710 bpf: add a ksym BPF iterator
> date:   3 months ago
> config: s390-randconfig-r021-20221002
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=647cafa22349026a8435030e9157074ab7fe5710
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 647cafa22349026a8435030e9157074ab7fe5710
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    timekeeping.c:(.text+0x29ec): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_update':
>    timekeeping.c:(.text+0x2cb8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_inject_offset':
>    timekeeping.c:(.text+0x3108): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `read_persistent_clock64':
>    timekeeping.c:(.text+0x3a98): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_resume':
>    timekeeping.c:(.text+0x4120): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: timekeeping.c:(.text+0x4208): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_suspend':
>    timekeeping.c:(.text+0x4660): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: timekeeping.c:(.text+0x4694): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: timekeeping.c:(.text+0x473e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o:timekeeping.c:(.text+0x4d70): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `do_adjtimex':
>    timekeeping.c:(.text+0x5ba0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `update_fast_timekeeper':
>    timekeeping.c:(.text+0x6262): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: timekeeping.c:(.text+0x629a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `read_persistent_wall_and_boot_offset':
>    timekeeping.c:(.init.text+0x52): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_init':
>    timekeeping.c:(.init.text+0x148): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.init.text+0x19e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/ntp.o: in function `ntp_clear':
>    ntp.c:(.text+0x19c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/ntp.o: in function `second_overflow':
>    ntp.c:(.text+0x692): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/ntp.o: in function `__hardpps':
>    ntp.c:(.text+0x16ee): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: ntp.c:(.text+0x1a1e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: ntp.c:(.text+0x1c18): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/ntp.o: in function `ntp_init':
>    ntp.c:(.init.text+0x210): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/clocksource.o: in function `sysfs_get_uname':
>    clocksource.c:(.text+0xf10): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/clocksource.o: in function `current_clocksource_store':
>    clocksource.c:(.text+0x1284): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/clocksource.o: in function `unbind_clocksource_store':
>    clocksource.c:(.text+0x133e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/clocksource.o: in function `boot_override_clocksource':
>    clocksource.c:(.init.text+0x148): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/jiffies.o: in function `register_refined_jiffies':
>    jiffies.c:(.text+0x3a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/alarmtimer.o:alarmtimer.c:(.text+0x14a6): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: kernel/time/alarmtimer.o: in function `alarmtimer_init':
>    alarmtimer.c:(.init.text+0xae): undefined reference to `__tsan_memset'
>    s390x-linux-ld: alarmtimer.c:(.init.text+0xdc): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/posix-stubs.o: in function `do_clock_gettime':
>    posix-stubs.c:(.text+0x188): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/tick-sched.o: in function `tick_cancel_sched_timer':
>    tick-sched.c:(.text+0x52a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/test_udelay.o: in function `udelay_test_write':
>    test_udelay.c:(.text+0x13a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/futex/core.o: in function `exit_pi_state_list':
>    core.c:(.text+0x1858): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/futex/syscalls.o: in function `__se_sys_futex_waitv':
>    syscalls.c:(.text+0x91e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: syscalls.c:(.text+0x976): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/futex/pi.o: in function `refill_pi_state_cache':
>    pi.c:(.text+0xcc): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/futex/pi.o: in function `futex_lock_pi_atomic':
>    pi.c:(.text+0x790): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: pi.c:(.text+0x940): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/futex/pi.o: in function `futex_lock_pi':
>    pi.c:(.text+0xf90): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: pi.c:(.text+0x1144): undefined reference to `__tsan_memset'
>    s390x-linux-ld: pi.c:(.text+0x13c0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/futex/pi.o: in function `futex_unlock_pi':
>    pi.c:(.text+0x146c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/futex/requeue.o: in function `futex_requeue':
>    requeue.c:(.text+0x40): undefined reference to `__tsan_memset'
>    s390x-linux-ld: requeue.c:(.text+0x52): undefined reference to `__tsan_memset'
>    s390x-linux-ld: requeue.c:(.text+0x6ac): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: requeue.c:(.text+0xa48): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: requeue.c:(.text+0xc22): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: requeue.c:(.text+0xcea): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/futex/requeue.o: in function `futex_wait_requeue_pi':
>    requeue.c:(.text+0xf32): undefined reference to `__tsan_memset'
>    s390x-linux-ld: requeue.c:(.text+0xf46): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: requeue.c:(.text+0xfa8): undefined reference to `__tsan_memset'
>    s390x-linux-ld: requeue.c:(.text+0x1316): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/futex/waitwake.o: in function `futex_wake':
>    waitwake.c:(.text+0x138): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/futex/waitwake.o: in function `futex_wake_op':
>    waitwake.c:(.text+0x33a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: waitwake.c:(.text+0x34c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/futex/waitwake.o: in function `futex_wait':
>    waitwake.c:(.text+0x1230): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/smp.o: in function `smp_call_function_single':
>    smp.c:(.text+0x792): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/smp.o: in function `smp_call_function_many_cond':
>    smp.c:(.text+0x1104): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/smp.o: in function `smp_call_on_cpu':
>    smp.c:(.text+0x18a0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/kallsyms.o: in function `bpf_iter_ksym_init':
>    kallsyms.c:(.text+0x1036): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/kallsyms.o: in function `update_iter':
>    kallsyms.c:(.text+0x1460): undefined reference to `__tsan_memcpy'
> >> s390x-linux-ld: kallsyms.c:(.text+0x1492): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kallsyms.c:(.text+0x157c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/acct.o: in function `__se_sys_acct':
>    acct.c:(.text+0x30a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/acct.o: in function `do_acct_process':
>    acct.c:(.text+0x112e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: acct.c:(.text+0x1166): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/crash_core.o: in function `append_elf_note':
>    crash_core.c:(.text+0x78): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_core.c:(.text+0xa8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/crash_core.o: in function `final_note':
>    crash_core.c:(.text+0xfa): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/crash_core.o: in function `crash_update_vmcoreinfo_safecopy':
>    crash_core.c:(.text+0x162): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/crash_core.o: in function `crash_save_vmcoreinfo':
>    crash_core.c:(.text+0x25a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/crash_core.o: in function `vmcoreinfo_append_str':
>    crash_core.c:(.text+0x32c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/crash_core.o: in function `crash_save_vmcoreinfo_init':
>    crash_core.c:(.init.text+0x8f6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/kexec_core.o: in function `kimage_load_segment':
>    kexec_core.c:(.text+0x127a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kexec_core.c:(.text+0x1336): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kexec_core.c:(.text+0x1354): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kexec_core.c:(.text+0x14aa): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kexec_core.c:(.text+0x1530): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kexec_core.c:(.text+0x154c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/kexec_core.o: in function `kimage_alloc_pages':
>    kexec_core.c:(.text+0x1d0c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/kexec.o: in function `__se_sys_kexec_load':
>    kexec.c:(.text+0x18e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/kexec_file.o: in function `kexec_load_purgatory':
>    kexec_file.c:(.text+0x16e8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kexec_file.c:(.text+0x1928): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/kexec_file.o: in function `kexec_purgatory_get_set_symbol':
>    kexec_file.c:(.text+0x1e92): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/kexec_file.o: in function `crash_exclude_mem_range':
>    kexec_file.c:(.text+0x1f9c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kexec_file.c:(.text+0x2108): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/stop_machine.o: in function `stop_one_cpu':
>    stop_machine.c:(.text+0xf2): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/stop_machine.o: in function `cpu_stop_init_done':
>    stop_machine.c:(.text+0x1a6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/stop_machine.o: in function `stop_two_cpus':
>    stop_machine.c:(.text+0x48c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: stop_machine.c:(.text+0x4c0): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/stop_machine.o: in function `stop_one_cpu_nowait':
>    stop_machine.c:(.text+0xa86): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/stop_machine.o: in function `cpu_stopper_thread':
>    stop_machine.c:(.text+0x140e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/audit.o: in function `audit_send_list_thread':
>    audit.c:(.text+0x5dc): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/audit.o: in function `audit_make_reply':
>    audit.c:(.text+0x938): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/audit.o: in function `audit_log_start':
>    audit.c:(.text+0xc38): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/audit.o: in function `audit_log_n_string':
>    audit.c:(.text+0x1728): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/audit.o: in function `audit_receive':
>    audit.c:(.text+0x34ea): undefined reference to `__tsan_memset'
>    s390x-linux-ld: audit.c:(.text+0x3506): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: audit.c:(.text+0x3af8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: audit.c:(.text+0x3f00): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: audit.c:(.text+0x48c8): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/audit.o: in function `audit_net_init':
>    audit.c:(.init.text+0x566): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/auditfilter.o: in function `audit_unpack_string':
>    auditfilter.c:(.text+0x1ea): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/auditfilter.o: in function `audit_dupe_rule':
>    auditfilter.c:(.text+0x3ec): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: auditfilter.c:(.text+0x4b4): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/auditfilter.o: in function `audit_data_to_entry':
>    auditfilter.c:(.text+0x14a2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/auditfilter.o:auditfilter.c:(.text+0x18b2): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: kernel/auditfilter.o: in function `audit_list_rules_send':
>    auditfilter.c:(.text+0x243c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: auditfilter.c:(.text+0x2710): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: auditfilter.c:(.text+0x279e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: auditfilter.c:(.text+0x27c8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/auditsc.o: in function `audit_log_exit':
>    auditsc.c:(.text+0x1348): undefined reference to `__tsan_memmove'
>    s390x-linux-ld: kernel/auditsc.o: in function `audit_reset_context':
>    auditsc.c:(.text+0x2dcc): undefined reference to `__tsan_memset'
>    s390x-linux-ld: auditsc.c:(.text+0x2dfc): undefined reference to `__tsan_memset'
>    s390x-linux-ld: auditsc.c:(.text+0x2ef6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: auditsc.c:(.text+0x3030): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/auditsc.o: in function `audit_alloc_name':
>    auditsc.c:(.text+0x361e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: auditsc.c:(.text+0x371e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/auditsc.o: in function `__audit_mq_open':
>    auditsc.c:(.text+0x4f86): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: auditsc.c:(.text+0x4f98): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/auditsc.o: in function `__audit_mq_sendrecv':
>    auditsc.c:(.text+0x5038): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: auditsc.c:(.text+0x504a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/auditsc.o: in function `__audit_mq_getsetattr':
>    auditsc.c:(.text+0x5196): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/auditsc.o: in function `__audit_socketcall':
>    auditsc.c:(.text+0x5446): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/auditsc.o: in function `__audit_sockaddr':
>    auditsc.c:(.text+0x5584): undefined reference to `__tsan_memcpy'
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/s390 5.19.0-rc5 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="clang version 16.0.0 (git://gitmirror/llvm_project 791a7ae1ba3efd6bca96338e10ffde557ba83920)"
> CONFIG_GCC_VERSION=0
> CONFIG_CC_IS_CLANG=y
> CONFIG_CLANG_VERSION=160000
> CONFIG_AS_IS_LLVM=y
> CONFIG_AS_VERSION=160000
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23800
> CONFIG_LLD_VERSION=0
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_PAHOLE_VERSION=123
> CONFIG_CONSTRUCTORS=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> CONFIG_HAVE_KERNEL_UNCOMPRESSED=y
> # CONFIG_KERNEL_GZIP is not set
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_KERNEL_UNCOMPRESSED=y
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> # CONFIG_SYSVIPC is not set
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_WATCH_QUEUE is not set
> # CONFIG_CROSS_MEMORY_ATTACH is not set
> # CONFIG_USELIB is not set
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_HZ_PERIODIC=y
> # CONFIG_NO_HZ_IDLE is not set
> # CONFIG_NO_HZ is not set
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> 
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=y
> CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
> CONFIG_USERMODE_DRIVER=y
> CONFIG_BPF_PRELOAD=y
> CONFIG_BPF_PRELOAD_UMD=y
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_NONE_BUILD=y
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=y
> CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_TASKSTATS=y
> # CONFIG_TASK_DELAY_ACCT is not set
> # CONFIG_TASK_XACCT is not set
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
> 
> # CONFIG_CPU_ISOLATION is not set
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=y
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=17
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> # CONFIG_PRINTK_INDEX is not set
> 
> #
> # Scheduler features
> #
> # end of Scheduler features
> 
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_CC_HAS_INT128=y
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
> CONFIG_GCC12_NO_ARRAY_BOUNDS=y
> # CONFIG_CGROUPS is not set
> # CONFIG_NAMESPACES is not set
> # CONFIG_CHECKPOINT_RESTORE is not set
> # CONFIG_SCHED_AUTOGROUP is not set
> CONFIG_SYSFS_DEPRECATED=y
> # CONFIG_SYSFS_DEPRECATED_V2 is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> # CONFIG_RD_GZIP is not set
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> # CONFIG_RD_XZ is not set
> CONFIG_RD_LZO=y
> # CONFIG_RD_LZ4 is not set
> CONFIG_RD_ZSTD=y
> # CONFIG_BOOT_CONFIG is not set
> # CONFIG_INITRAMFS_PRESERVE_MTIME is not set
> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_EXPERT=y
> CONFIG_MULTIUSER=y
> # CONFIG_SGETMASK_SYSCALL is not set
> # CONFIG_SYSFS_SYSCALL is not set
> CONFIG_FHANDLE=y
> # CONFIG_POSIX_TIMERS is not set
> CONFIG_PRINTK=y
> # CONFIG_BUG is not set
> # CONFIG_BASE_FULL is not set
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> # CONFIG_EVENTFD is not set
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> # CONFIG_IO_URING is not set
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> # CONFIG_KCMP is not set
> # CONFIG_RSEQ is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> # CONFIG_PC104 is not set
> 
> #
> # Kernel Performance Events And Counters
> #
> # CONFIG_PERF_EVENTS is not set
> # end of Kernel Performance Events And Counters
> 
> # CONFIG_PROFILING is not set
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_MMU=y
> CONFIG_CPU_BIG_ENDIAN=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_NO_IOPORT_MAP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_S390=y
> CONFIG_SCHED_OMIT_FRAME_POINTER=y
> CONFIG_PGTABLE_LEVELS=5
> CONFIG_HAVE_LIVEPATCH=y
> 
> #
> # Processor type and features
> #
> CONFIG_HAVE_MARCH_Z10_FEATURES=y
> CONFIG_MARCH_Z10=y
> # CONFIG_MARCH_Z196 is not set
> # CONFIG_MARCH_ZEC12 is not set
> # CONFIG_MARCH_Z13 is not set
> # CONFIG_MARCH_Z14 is not set
> # CONFIG_MARCH_Z15 is not set
> # CONFIG_MARCH_Z16 is not set
> CONFIG_MARCH_Z10_TUNE=y
> # CONFIG_TUNE_DEFAULT is not set
> CONFIG_TUNE_Z10=y
> # CONFIG_TUNE_Z196 is not set
> # CONFIG_TUNE_ZEC12 is not set
> # CONFIG_TUNE_Z13 is not set
> # CONFIG_TUNE_Z14 is not set
> # CONFIG_TUNE_Z15 is not set
> # CONFIG_TUNE_Z16 is not set
> CONFIG_64BIT=y
> CONFIG_COMMAND_LINE_SIZE=4096
> CONFIG_SMP=y
> CONFIG_NR_CPUS=64
> CONFIG_HOTPLUG_CPU=y
> # CONFIG_SCHED_TOPOLOGY is not set
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_300=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=300
> CONFIG_SCHED_HRTICK=y
> CONFIG_KEXEC=y
> CONFIG_KEXEC_FILE=y
> CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
> CONFIG_ARCH_RANDOM=y
> # CONFIG_KERNEL_NOBP is not set
> CONFIG_RELOCATABLE=y
> # CONFIG_RANDOMIZE_BASE is not set
> # end of Processor type and features
> 
> #
> # Memory setup
> #
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_MAX_PHYSMEM_BITS=46
> CONFIG_CHECK_STACK=y
> CONFIG_STACK_GUARD=256
> # end of Memory setup
> 
> #
> # I/O subsystem
> #
> # CONFIG_QDIO is not set
> # CONFIG_CHSC_SCH is not set
> CONFIG_SCM_BUS=y
> CONFIG_EADM_SCH=y
> # CONFIG_VFIO_CCW is not set
> # end of I/O subsystem
> 
> #
> # Dump support
> #
> CONFIG_CRASH_DUMP=y
> # end of Dump support
> 
> CONFIG_CCW=y
> CONFIG_HAVE_PNETID=y
> 
> #
> # Virtualization
> #
> CONFIG_PROTECTED_VIRTUALIZATION_GUEST=y
> CONFIG_PFAULT=y
> CONFIG_CMM=y
> # CONFIG_CMM_IUCV is not set
> # CONFIG_S390_HYPFS_FS is not set
> CONFIG_HAVE_KVM=y
> CONFIG_VIRTUALIZATION=y
> # CONFIG_KVM is not set
> CONFIG_S390_GUEST=y
> # end of Virtualization
> 
> #
> # Selftests
> #
> # end of Selftests
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_GENERIC_ENTRY=y
> # CONFIG_JUMP_LABEL is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_WANTS_NO_INSTR=y
> CONFIG_ARCH_32BIT_USTAT_F_TINODE=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_MMU_GATHER_NO_GATHER=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_SECCOMP_FILTER=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE=y
> CONFIG_ARCH_HAS_SCALED_CPUTIME=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ALTERNATE_USER_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> CONFIG_HAVE_RELIABLE_STACKTRACE=y
> CONFIG_CLONE_BACKWARDS2=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> # CONFIG_VMAP_STACK is not set
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> # CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_ARCH_HAS_VDSO_DATA=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> 
> #
> # GCOV-based kernel profiling
> #
> CONFIG_GCOV_KERNEL=y
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # CONFIG_GCOV_PROFILE_ALL is not set
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=1
> # CONFIG_MODULES is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> # CONFIG_BLOCK is not set
> CONFIG_PADATA=y
> CONFIG_ASN1=y
> CONFIG_ARCH_INLINE_SPIN_TRYLOCK=y
> CONFIG_ARCH_INLINE_SPIN_TRYLOCK_BH=y
> CONFIG_ARCH_INLINE_SPIN_LOCK=y
> CONFIG_ARCH_INLINE_SPIN_LOCK_BH=y
> CONFIG_ARCH_INLINE_SPIN_LOCK_IRQ=y
> CONFIG_ARCH_INLINE_SPIN_LOCK_IRQSAVE=y
> CONFIG_ARCH_INLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_INLINE_SPIN_UNLOCK_BH=y
> CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQ=y
> CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE=y
> CONFIG_ARCH_INLINE_READ_TRYLOCK=y
> CONFIG_ARCH_INLINE_READ_LOCK=y
> CONFIG_ARCH_INLINE_READ_LOCK_BH=y
> CONFIG_ARCH_INLINE_READ_LOCK_IRQ=y
> CONFIG_ARCH_INLINE_READ_LOCK_IRQSAVE=y
> CONFIG_ARCH_INLINE_READ_UNLOCK=y
> CONFIG_ARCH_INLINE_READ_UNLOCK_BH=y
> CONFIG_ARCH_INLINE_READ_UNLOCK_IRQ=y
> CONFIG_ARCH_INLINE_READ_UNLOCK_IRQRESTORE=y
> CONFIG_ARCH_INLINE_WRITE_TRYLOCK=y
> CONFIG_ARCH_INLINE_WRITE_LOCK=y
> CONFIG_ARCH_INLINE_WRITE_LOCK_BH=y
> CONFIG_ARCH_INLINE_WRITE_LOCK_IRQ=y
> CONFIG_ARCH_INLINE_WRITE_LOCK_IRQSAVE=y
> CONFIG_ARCH_INLINE_WRITE_UNLOCK=y
> CONFIG_ARCH_INLINE_WRITE_UNLOCK_BH=y
> CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQ=y
> CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ARCH_BINFMT_ELF_STATE=y
> CONFIG_ELFCORE=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=y
> # CONFIG_COREDUMP is not set
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> 
> #
> # SLAB allocator options
> #
> # CONFIG_SLAB is not set
> # CONFIG_SLUB is not set
> CONFIG_SLOB=y
> # end of SLAB allocator options
> 
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> CONFIG_COMPAT_BRK=y
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_MEMBLOCK_PHYS_MAP=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_MEMORY_HOTPLUG=y
> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> # CONFIG_MEMORY_HOTREMOVE is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_COMPACTION=y
> # CONFIG_PAGE_REPORTING is not set
> CONFIG_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> CONFIG_CMA=y
> CONFIG_CMA_DEBUG=y
> # CONFIG_CMA_DEBUGFS is not set
> # CONFIG_CMA_SYSFS is not set
> CONFIG_CMA_AREAS=7
> # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> CONFIG_PAGE_IDLE_FLAG=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
> CONFIG_ZONE_DMA=y
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> # CONFIG_USERFAULTFD is not set
> 
> #
> # Data Access Monitoring
> #
> CONFIG_DAMON=y
> # CONFIG_DAMON_VADDR is not set
> CONFIG_DAMON_PADDR=y
> # CONFIG_DAMON_SYSFS is not set
> CONFIG_DAMON_RECLAIM=y
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_DIAG is not set
> # CONFIG_UNIX is not set
> CONFIG_IUCV=y
> # CONFIG_AFIUCV is not set
> # CONFIG_XDP_SOCKETS is not set
> # CONFIG_INET is not set
> CONFIG_NETWORK_SECMARK=y
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_ADVANCED is not set
> CONFIG_ATM=y
> # CONFIG_ATM_LANE is not set
> CONFIG_STP=y
> CONFIG_MRP=y
> CONFIG_BRIDGE=y
> # CONFIG_BRIDGE_VLAN_FILTERING is not set
> CONFIG_BRIDGE_MRP=y
> # CONFIG_BRIDGE_CFM is not set
> CONFIG_VLAN_8021Q=y
> # CONFIG_VLAN_8021Q_GVRP is not set
> CONFIG_VLAN_8021Q_MVRP=y
> # CONFIG_DECNET is not set
> CONFIG_LLC=y
> # CONFIG_LLC2 is not set
> CONFIG_ATALK=y
> # CONFIG_DEV_APPLETALK is not set
> CONFIG_X25=y
> CONFIG_LAPB=y
> CONFIG_PHONET=y
> # CONFIG_IEEE802154 is not set
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=y
> # CONFIG_NET_SCH_HTB is not set
> # CONFIG_NET_SCH_HFSC is not set
> # CONFIG_NET_SCH_ATM is not set
> CONFIG_NET_SCH_PRIO=y
> # CONFIG_NET_SCH_MULTIQ is not set
> CONFIG_NET_SCH_RED=y
> CONFIG_NET_SCH_SFB=y
> CONFIG_NET_SCH_SFQ=y
> CONFIG_NET_SCH_TEQL=y
> CONFIG_NET_SCH_TBF=y
> CONFIG_NET_SCH_CBS=y
> # CONFIG_NET_SCH_ETF is not set
> CONFIG_NET_SCH_TAPRIO=y
> CONFIG_NET_SCH_GRED=y
> # CONFIG_NET_SCH_DSMARK is not set
> # CONFIG_NET_SCH_NETEM is not set
> CONFIG_NET_SCH_DRR=y
> CONFIG_NET_SCH_MQPRIO=y
> # CONFIG_NET_SCH_SKBPRIO is not set
> CONFIG_NET_SCH_CHOKE=y
> CONFIG_NET_SCH_QFQ=y
> # CONFIG_NET_SCH_CODEL is not set
> CONFIG_NET_SCH_FQ_CODEL=y
> CONFIG_NET_SCH_CAKE=y
> CONFIG_NET_SCH_FQ=y
> CONFIG_NET_SCH_HHF=y
> CONFIG_NET_SCH_PIE=y
> CONFIG_NET_SCH_FQ_PIE=y
> CONFIG_NET_SCH_PLUG=y
> # CONFIG_NET_SCH_ETS is not set
> # CONFIG_NET_SCH_DEFAULT is not set
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_BASIC=y
> CONFIG_NET_CLS_TCINDEX=y
> # CONFIG_NET_CLS_FW is not set
> CONFIG_NET_CLS_U32=y
> CONFIG_CLS_U32_PERF=y
> # CONFIG_CLS_U32_MARK is not set
> CONFIG_NET_CLS_RSVP=y
> CONFIG_NET_CLS_RSVP6=y
> # CONFIG_NET_CLS_FLOW is not set
> CONFIG_NET_CLS_BPF=y
> CONFIG_NET_CLS_FLOWER=y
> # CONFIG_NET_CLS_MATCHALL is not set
> # CONFIG_NET_EMATCH is not set
> # CONFIG_NET_CLS_ACT is not set
> CONFIG_NET_SCH_FIFO=y
> CONFIG_DCB=y
> # CONFIG_DNS_RESOLVER is not set
> CONFIG_BATMAN_ADV=y
> # CONFIG_BATMAN_ADV_BATMAN_V is not set
> CONFIG_BATMAN_ADV_NC=y
> CONFIG_BATMAN_ADV_DEBUG=y
> # CONFIG_BATMAN_ADV_TRACING is not set
> CONFIG_VSOCKETS=y
> CONFIG_VSOCKETS_DIAG=y
> CONFIG_VSOCKETS_LOOPBACK=y
> # CONFIG_VIRTIO_VSOCKETS is not set
> CONFIG_VIRTIO_VSOCKETS_COMMON=y
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_QRTR is not set
> # CONFIG_PCPU_DEV_REFCNT is not set
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_SOCK_RX_QUEUE_MAPPING=y
> CONFIG_XPS=y
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> # end of Network testing
> # end of Networking options
> 
> CONFIG_CAN=y
> # CONFIG_CAN_RAW is not set
> CONFIG_CAN_BCM=y
> CONFIG_CAN_GW=y
> CONFIG_CAN_J1939=y
> # CONFIG_CAN_ISOTP is not set
> # CONFIG_MCTP is not set
> CONFIG_RFKILL=y
> CONFIG_RFKILL_LEDS=y
> CONFIG_RFKILL_INPUT=y
> CONFIG_RFKILL_GPIO=y
> # CONFIG_NET_9P is not set
> CONFIG_CAIF=y
> CONFIG_CAIF_DEBUG=y
> CONFIG_CAIF_NETDEV=y
> CONFIG_CAIF_USB=y
> # CONFIG_NFC is not set
> CONFIG_PSAMPLE=y
> CONFIG_NET_IFE=y
> CONFIG_LWTUNNEL=y
> CONFIG_GRO_CELLS=y
> CONFIG_NET_SOCK_MSG=y
> CONFIG_PAGE_POOL=y
> CONFIG_PAGE_POOL_STATS=y
> CONFIG_FAILOVER=y
> # CONFIG_ETHTOOL_NETLINK is not set
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_PCI=y
> # CONFIG_PCI is not set
> CONFIG_PCCARD=y
> CONFIG_PCMCIA=y
> CONFIG_PCMCIA_LOAD_CIS=y
> 
> #
> # PC-card bridges
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=y
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_DEVTMPFS_SAFE=y
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_FW_LOADER_SYSFS=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> CONFIG_FW_LOADER_COMPRESS=y
> CONFIG_FW_LOADER_COMPRESS_XZ=y
> # CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
> CONFIG_FW_UPLOAD=y
> # end of Firmware loader
> 
> CONFIG_WANT_DEV_COREDUMP=y
> # CONFIG_ALLOW_DEV_COREDUMP is not set
> CONFIG_DEBUG_DRIVER=y
> CONFIG_DEBUG_DEVRES=y
> CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPMI=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_REGMAP_I3C=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> CONFIG_MHI_BUS=y
> CONFIG_MHI_BUS_DEBUG=y
> CONFIG_MHI_BUS_EP=y
> # end of Bus devices
> 
> CONFIG_CONNECTOR=y
> # CONFIG_PROC_EVENTS is not set
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
> 
> # CONFIG_FIRMWARE_MEMMAP is not set
> CONFIG_GOOGLE_FIRMWARE=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> # CONFIG_GNSS is not set
> CONFIG_MTD=y
> 
> #
> # Partition parsers
> #
> # CONFIG_MTD_AR7_PARTS is not set
> # CONFIG_MTD_CMDLINE_PARTS is not set
> CONFIG_MTD_OF_PARTS=y
> # CONFIG_MTD_REDBOOT_PARTS is not set
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_OOPS=y
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> # CONFIG_MTD_CFI is not set
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> CONFIG_MTD_ABSENT=y
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # NAND
> #
> CONFIG_MTD_NAND_CORE=y
> # CONFIG_MTD_RAW_NAND is not set
> 
> #
> # ECC engine support
> #
> CONFIG_MTD_NAND_ECC=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
> CONFIG_MTD_NAND_ECC_SW_BCH=y
> # end of ECC engine support
> # end of NAND
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> # CONFIG_MTD_LPDDR is not set
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> CONFIG_MTD_UBI=y
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> CONFIG_MTD_UBI_FASTMAP=y
> CONFIG_MTD_UBI_GLUEBI=y
> CONFIG_OF=y
> # CONFIG_OF_UNITTEST is not set
> CONFIG_OF_KOBJ=y
> CONFIG_OF_IRQ=y
> # CONFIG_OF_OVERLAY is not set
> 
> #
> # NVME Support
> #
> # end of NVME Support
> 
> #
> # Misc devices
> #
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_ICS932S401 is not set
> CONFIG_ENCLOSURE_SERVICES=y
> CONFIG_APDS9802ALS=y
> CONFIG_ISL29003=y
> # CONFIG_ISL29020 is not set
> CONFIG_SENSORS_TSL2550=y
> CONFIG_SENSORS_BH1770=y
> CONFIG_SENSORS_APDS990X=y
> CONFIG_HMC6352=y
> CONFIG_DS1682=y
> CONFIG_C2PORT=y
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> CONFIG_EEPROM_LEGACY=y
> CONFIG_EEPROM_MAX6875=y
> CONFIG_EEPROM_93CX6=y
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
> 
> #
> # Texas Instruments shared transport line discipline
> #
> CONFIG_TI_ST=y
> # end of Texas Instruments shared transport line discipline
> 
> # CONFIG_SENSORS_LIS3_I2C is not set
> CONFIG_ALTERA_STAPL=y
> CONFIG_ECHO=y
> CONFIG_UACCE=y
> # CONFIG_PVPANIC is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # end of SCSI device support
> 
> CONFIG_NETDEVICES=y
> CONFIG_MII=y
> CONFIG_NET_CORE=y
> CONFIG_DUMMY=y
> CONFIG_EQUALIZER=y
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_MACSEC is not set
> CONFIG_NETCONSOLE=y
> CONFIG_NETCONSOLE_DYNAMIC=y
> CONFIG_NETPOLL=y
> CONFIG_NET_POLL_CONTROLLER=y
> # CONFIG_TUN_VNET_CROSS_LE is not set
> CONFIG_VETH=y
> CONFIG_VIRTIO_NET=y
> CONFIG_NLMON=y
> CONFIG_MHI_NET=y
> CONFIG_ARCNET=y
> CONFIG_ARCNET_1201=y
> # CONFIG_ARCNET_1051 is not set
> CONFIG_ARCNET_RAW=y
> CONFIG_ARCNET_CAP=y
> CONFIG_ARCNET_COM90xx=y
> CONFIG_ARCNET_COM90xxIO=y
> # CONFIG_ARCNET_RIM_I is not set
> CONFIG_ARCNET_COM20020=y
> # CONFIG_ARCNET_COM20020_CS is not set
> # CONFIG_ATM_DRIVERS is not set
> CONFIG_CAIF_DRIVERS=y
> CONFIG_CAIF_TTY=y
> CONFIG_CAIF_VIRTIO=y
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_PCMCIA_3C574 is not set
> # CONFIG_PCMCIA_3C589 is not set
> # CONFIG_NET_VENDOR_ALACRITECH is not set
> # CONFIG_ALTERA_TSE is not set
> # CONFIG_NET_VENDOR_AMAZON is not set
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_PCMCIA_NMCLAN is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_NET_VENDOR_ARC is not set
> CONFIG_NET_VENDOR_ASIX=y
> # CONFIG_NET_VENDOR_CAVIUM is not set
> CONFIG_NET_VENDOR_CORTINA=y
> CONFIG_NET_VENDOR_DAVICOM=y
> # CONFIG_NET_VENDOR_ENGLEDER is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> # CONFIG_NET_VENDOR_FUJITSU is not set
> CONFIG_NET_VENDOR_FUNGIBLE=y
> # CONFIG_NET_VENDOR_GOOGLE is not set
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_NET_VENDOR_INTEL is not set
> # CONFIG_NET_VENDOR_WANGXUN is not set
> CONFIG_NET_VENDOR_LITEX=y
> # CONFIG_NET_VENDOR_MELLANOX is not set
> # CONFIG_NET_VENDOR_MICROCHIP is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MICROSOFT=y
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NET_VENDOR_NATSEMI is not set
> # CONFIG_NET_VENDOR_NETRONOME is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> CONFIG_NET_VENDOR_QUALCOMM=y
> CONFIG_QCA7000=y
> CONFIG_QCA7000_UART=y
> CONFIG_RMNET=y
> # CONFIG_NET_VENDOR_RENESAS is not set
> # CONFIG_NET_VENDOR_ROCKER is not set
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_NET_VENDOR_SOLARFLARE is not set
> CONFIG_NET_VENDOR_SMSC=y
> CONFIG_PCMCIA_SMC91C92=y
> # CONFIG_NET_VENDOR_SOCIONEXT is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> CONFIG_NET_VENDOR_VERTEXCOM=y
> CONFIG_NET_VENDOR_VIA=y
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_NET_VENDOR_XIRCOM is not set
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> CONFIG_LED_TRIGGER_PHY=y
> CONFIG_FIXED_PHY=y
> 
> #
> # MII PHY device drivers
> #
> CONFIG_AMD_PHY=y
> # CONFIG_ADIN_PHY is not set
> # CONFIG_ADIN1100_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> CONFIG_AX88796B_PHY=y
> # CONFIG_BROADCOM_PHY is not set
> CONFIG_BCM54140_PHY=y
> CONFIG_BCM7XXX_PHY=y
> CONFIG_BCM84881_PHY=y
> # CONFIG_BCM87XX_PHY is not set
> CONFIG_BCM_NET_PHYLIB=y
> CONFIG_CICADA_PHY=y
> CONFIG_CORTINA_PHY=y
> CONFIG_DAVICOM_PHY=y
> # CONFIG_ICPLUS_PHY is not set
> CONFIG_LXT_PHY=y
> CONFIG_INTEL_XWAY_PHY=y
> CONFIG_LSI_ET1011C_PHY=y
> CONFIG_MARVELL_PHY=y
> # CONFIG_MARVELL_10G_PHY is not set
> CONFIG_MARVELL_88X2222_PHY=y
> CONFIG_MAXLINEAR_GPHY=y
> CONFIG_MEDIATEK_GE_PHY=y
> CONFIG_MICREL_PHY=y
> CONFIG_MICROCHIP_PHY=y
> CONFIG_MICROCHIP_T1_PHY=y
> CONFIG_MICROSEMI_PHY=y
> CONFIG_MOTORCOMM_PHY=y
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_NXP_C45_TJA11XX_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> # CONFIG_REALTEK_PHY is not set
> # CONFIG_RENESAS_PHY is not set
> CONFIG_ROCKCHIP_PHY=y
> CONFIG_SMSC_PHY=y
> # CONFIG_STE10XP is not set
> # CONFIG_TERANETICS_PHY is not set
> CONFIG_DP83822_PHY=y
> CONFIG_DP83TC811_PHY=y
> # CONFIG_DP83848_PHY is not set
> CONFIG_DP83867_PHY=y
> # CONFIG_DP83869_PHY is not set
> CONFIG_DP83TD510_PHY=y
> CONFIG_VITESSE_PHY=y
> # CONFIG_XILINX_GMII2RGMII is not set
> # CONFIG_CAN_DEV is not set
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> CONFIG_FWNODE_MDIO=y
> CONFIG_OF_MDIO=y
> CONFIG_MDIO_DEVRES=y
> CONFIG_MDIO_BITBANG=y
> CONFIG_MDIO_GPIO=y
> 
> #
> # MDIO Multiplexers
> #
> CONFIG_MDIO_BUS_MUX=y
> CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
> 
> #
> # PCS device drivers
> #
> # end of PCS device drivers
> 
> CONFIG_PPP=y
> CONFIG_PPP_BSDCOMP=y
> CONFIG_PPP_DEFLATE=y
> # CONFIG_PPP_FILTER is not set
> CONFIG_PPP_MPPE=y
> CONFIG_PPP_MULTILINK=y
> CONFIG_PPPOATM=y
> CONFIG_PPPOE=y
> # CONFIG_PPP_ASYNC is not set
> # CONFIG_PPP_SYNC_TTY is not set
> CONFIG_SLIP=y
> CONFIG_SLHC=y
> CONFIG_SLIP_COMPRESSED=y
> CONFIG_SLIP_SMART=y
> # CONFIG_SLIP_MODE_SLIP6 is not set
> 
> #
> # S/390 network device drivers
> #
> CONFIG_LCS=y
> CONFIG_CTCM=y
> CONFIG_NETIUCV=y
> CONFIG_SMSGIUCV=y
> # CONFIG_SMSGIUCV_EVENT is not set
> CONFIG_CCWGROUP=y
> # end of S/390 network device drivers
> 
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> # CONFIG_WAN is not set
> 
> #
> # Wireless WAN
> #
> CONFIG_WWAN=y
> CONFIG_WWAN_DEBUGFS=y
> CONFIG_WWAN_HWSIM=y
> CONFIG_MHI_WWAN_CTRL=y
> # CONFIG_MHI_WWAN_MBIM is not set
> CONFIG_RPMSG_WWAN_CTRL=y
> # end of Wireless WAN
> 
> CONFIG_NET_FAILOVER=y
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=y
> CONFIG_INPUT_FF_MEMLESS=y
> # CONFIG_INPUT_SPARSEKMAP is not set
> CONFIG_INPUT_MATRIXKMAP=y
> CONFIG_INPUT_VIVALDIFMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> CONFIG_INPUT_EVBUG=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ADC=y
> CONFIG_KEYBOARD_ADP5588=y
> CONFIG_KEYBOARD_ADP5589=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_KEYBOARD_QT1050=y
> CONFIG_KEYBOARD_QT1070=y
> CONFIG_KEYBOARD_QT2160=y
> CONFIG_KEYBOARD_DLINK_DIR685=y
> # CONFIG_KEYBOARD_LKKBD is not set
> CONFIG_KEYBOARD_GPIO=y
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> CONFIG_KEYBOARD_TCA6416=y
> # CONFIG_KEYBOARD_TCA8418 is not set
> CONFIG_KEYBOARD_MATRIX=y
> # CONFIG_KEYBOARD_LM8323 is not set
> CONFIG_KEYBOARD_LM8333=y
> # CONFIG_KEYBOARD_MAX7359 is not set
> CONFIG_KEYBOARD_MCS=y
> # CONFIG_KEYBOARD_MPR121 is not set
> CONFIG_KEYBOARD_NEWTON=y
> CONFIG_KEYBOARD_STOWAWAY=y
> CONFIG_KEYBOARD_SUNKBD=y
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> CONFIG_KEYBOARD_XTKBD=y
> CONFIG_KEYBOARD_CAP11XX=y
> CONFIG_KEYBOARD_CYPRESS_SF=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_PS2_ALPS is not set
> CONFIG_MOUSE_PS2_BYD=y
> # CONFIG_MOUSE_PS2_LOGIPS2PP is not set
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> # CONFIG_MOUSE_PS2_CYPRESS is not set
> # CONFIG_MOUSE_PS2_TRACKPOINT is not set
> # CONFIG_MOUSE_PS2_ELANTECH is not set
> # CONFIG_MOUSE_PS2_SENTELIC is not set
> CONFIG_MOUSE_PS2_TOUCHKIT=y
> # CONFIG_MOUSE_PS2_FOCALTECH is not set
> CONFIG_MOUSE_PS2_SMBUS=y
> CONFIG_MOUSE_SERIAL=y
> # CONFIG_MOUSE_CYAPA is not set
> CONFIG_MOUSE_ELAN_I2C=y
> # CONFIG_MOUSE_ELAN_I2C_I2C is not set
> # CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
> CONFIG_MOUSE_VSXXXAA=y
> CONFIG_MOUSE_GPIO=y
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> CONFIG_INPUT_JOYSTICK=y
> # CONFIG_JOYSTICK_ANALOG is not set
> CONFIG_JOYSTICK_A3D=y
> CONFIG_JOYSTICK_ADC=y
> CONFIG_JOYSTICK_ADI=y
> CONFIG_JOYSTICK_COBRA=y
> CONFIG_JOYSTICK_GF2K=y
> CONFIG_JOYSTICK_GRIP=y
> # CONFIG_JOYSTICK_GRIP_MP is not set
> CONFIG_JOYSTICK_GUILLEMOT=y
> # CONFIG_JOYSTICK_INTERACT is not set
> # CONFIG_JOYSTICK_SIDEWINDER is not set
> CONFIG_JOYSTICK_TMDC=y
> CONFIG_JOYSTICK_IFORCE=y
> # CONFIG_JOYSTICK_IFORCE_232 is not set
> CONFIG_JOYSTICK_WARRIOR=y
> CONFIG_JOYSTICK_MAGELLAN=y
> CONFIG_JOYSTICK_SPACEORB=y
> # CONFIG_JOYSTICK_SPACEBALL is not set
> CONFIG_JOYSTICK_STINGER=y
> CONFIG_JOYSTICK_TWIDJOY=y
> CONFIG_JOYSTICK_ZHENHUA=y
> # CONFIG_JOYSTICK_AS5011 is not set
> CONFIG_JOYSTICK_JOYDUMP=y
> CONFIG_JOYSTICK_QWIIC=y
> # CONFIG_JOYSTICK_FSIA6B is not set
> CONFIG_INPUT_TABLET=y
> CONFIG_TABLET_SERIAL_WACOM4=y
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> # CONFIG_RMI4_CORE is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_SERIO_SERPORT=y
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=y
> CONFIG_SERIO_PS2MULT=y
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> CONFIG_GAMEPORT=y
> # CONFIG_GAMEPORT_NS558 is not set
> CONFIG_GAMEPORT_L4=y
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> # CONFIG_VT is not set
> # CONFIG_UNIX98_PTYS is not set
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_LDISC_AUTOLOAD=y
> CONFIG_N_GSM=y
> CONFIG_NULL_TTY=y
> CONFIG_HVC_DRIVER=y
> CONFIG_HVC_IUCV=y
> CONFIG_RPMSG_TTY=y
> CONFIG_SERIAL_DEV_BUS=y
> # CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
> CONFIG_TTY_PRINTK=y
> CONFIG_TTY_PRINTK_LEVEL=6
> CONFIG_VIRTIO_CONSOLE=y
> # CONFIG_HW_RANDOM is not set
> 
> #
> # PCMCIA character devices
> #
> # CONFIG_SYNCLINK_CS is not set
> CONFIG_CARDMAN_4000=y
> CONFIG_CARDMAN_4040=y
> CONFIG_SCR24X=y
> CONFIG_IPWIRELESS=y
> # end of PCMCIA character devices
> 
> CONFIG_DEVMEM=y
> CONFIG_HANGCHECK_TIMER=y
> 
> #
> # S/390 character device drivers
> #
> CONFIG_TN3270=y
> CONFIG_TN3270_TTY=y
> CONFIG_TN3270_FS=y
> # CONFIG_TN3270_CONSOLE is not set
> CONFIG_TN3215=y
> CONFIG_TN3215_CONSOLE=y
> CONFIG_CCW_CONSOLE=y
> # CONFIG_SCLP_TTY is not set
> # CONFIG_SCLP_VT220_TTY is not set
> CONFIG_HMC_DRV=y
> # CONFIG_SCLP_OFB is not set
> CONFIG_S390_UV_UAPI=y
> CONFIG_S390_TAPE=y
> 
> #
> # S/390 tape hardware support
> #
> CONFIG_S390_TAPE_34XX=y
> # CONFIG_S390_TAPE_3590 is not set
> CONFIG_VMLOGRDR=y
> # CONFIG_VMCP is not set
> # CONFIG_MONREADER is not set
> CONFIG_MONWRITER=y
> # CONFIG_S390_VMUR is not set
> CONFIG_XILLYBUS_CLASS=y
> CONFIG_XILLYBUS=y
> # CONFIG_XILLYBUS_OF is not set
> CONFIG_RANDOM_TRUST_CPU=y
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> # CONFIG_I2C_CHARDEV is not set
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
> # CONFIG_I2C_MUX_GPIO is not set
> CONFIG_I2C_MUX_GPMUX=y
> CONFIG_I2C_MUX_LTC4306=y
> # CONFIG_I2C_MUX_PCA9541 is not set
> # CONFIG_I2C_MUX_PCA954x is not set
> CONFIG_I2C_MUX_PINCTRL=y
> # CONFIG_I2C_DEMUX_PINCTRL is not set
> # CONFIG_I2C_MUX_MLXCPLD is not set
> # end of Multiplexer I2C Chip support
> 
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> # CONFIG_I2C_SLAVE is not set
> CONFIG_I2C_DEBUG_CORE=y
> # CONFIG_I2C_DEBUG_ALGO is not set
> # end of I2C support
> 
> CONFIG_I3C=y
> CONFIG_SPMI=y
> CONFIG_HSI=y
> CONFIG_HSI_BOARDINFO=y
> 
> #
> # HSI controllers
> #
> 
> #
> # HSI clients
> #
> # CONFIG_HSI_CHAR is not set
> CONFIG_PPS=y
> CONFIG_PPS_DEBUG=y
> CONFIG_NTP_PPS=y
> 
> #
> # PPS clients support
> #
> CONFIG_PPS_CLIENT_KTIMER=y
> # CONFIG_PPS_CLIENT_LDISC is not set
> # CONFIG_PPS_CLIENT_GPIO is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> CONFIG_PINCTRL_MCP23S08_I2C=y
> CONFIG_PINCTRL_MCP23S08=y
> # CONFIG_PINCTRL_SX150X is not set
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIOLIB_IRQCHIP=y
> CONFIG_DEBUG_GPIO=y
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_CDEV=y
> CONFIG_GPIO_CDEV_V1=y
> CONFIG_GPIO_MAX730X=y
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> CONFIG_GPIO_MAX7300=y
> CONFIG_GPIO_MAX732X=y
> # CONFIG_GPIO_MAX732X_IRQ is not set
> CONFIG_GPIO_PCA953X=y
> CONFIG_GPIO_PCA953X_IRQ=y
> CONFIG_GPIO_PCA9570=y
> CONFIG_GPIO_PCF857X=y
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> # end of MFD GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> CONFIG_GPIO_AGGREGATOR=y
> CONFIG_GPIO_MOCKUP=y
> # CONFIG_GPIO_VIRTIO is not set
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
> 
> # CONFIG_POWER_RESET is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_GENERIC_ADC_BATTERY=y
> CONFIG_IP5XXX_POWER=y
> # CONFIG_TEST_POWER is not set
> CONFIG_CHARGER_ADP5061=y
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2782 is not set
> CONFIG_BATTERY_SAMSUNG_SDI=y
> CONFIG_BATTERY_SBS=y
> CONFIG_CHARGER_SBS=y
> CONFIG_MANAGER_SBS=y
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> CONFIG_BATTERY_MAX17042=y
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> CONFIG_CHARGER_GPIO=y
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> CONFIG_CHARGER_DETECTOR_MAX14656=y
> CONFIG_CHARGER_MAX77976=y
> CONFIG_CHARGER_BQ2415X=y
> CONFIG_CHARGER_BQ24190=y
> CONFIG_CHARGER_BQ24257=y
> CONFIG_CHARGER_BQ24735=y
> # CONFIG_CHARGER_BQ2515X is not set
> # CONFIG_CHARGER_BQ25890 is not set
> CONFIG_CHARGER_BQ25980=y
> CONFIG_CHARGER_BQ256XX=y
> CONFIG_BATTERY_GAUGE_LTC2941=y
> CONFIG_BATTERY_RT5033=y
> # CONFIG_CHARGER_RT9455 is not set
> CONFIG_CHARGER_BD99954=y
> # CONFIG_BATTERY_UG3105 is not set
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_NETLINK is not set
> CONFIG_THERMAL_STATISTICS=y
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> # CONFIG_THERMAL_OF is not set
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> CONFIG_THERMAL_EMULATION=y
> CONFIG_GENERIC_ADC_THERMAL=y
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> # CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
> CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> # CONFIG_WATCHDOG_SYSFS is not set
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
> 
> #
> # Watchdog Pretimeout Governors
> #
> CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=y
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
> CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=y
> # CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
> CONFIG_ZIIRAVE_WATCHDOG=y
> # CONFIG_MEN_A21_WDT is not set
> CONFIG_DIAG288_WATCHDOG=y
> # CONFIG_REGULATOR is not set
> # CONFIG_RC_CORE is not set
> 
> #
> # CEC support
> #
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # end of CEC support
> 
> #
> # Graphics support
> #
> # end of Graphics support
> 
> #
> # HID support
> #
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> # CONFIG_HIDRAW is not set
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> CONFIG_HID_ACRUX=y
> # CONFIG_HID_ACRUX_FF is not set
> # CONFIG_HID_APPLE is not set
> CONFIG_HID_AUREAL=y
> CONFIG_HID_BELKIN=y
> # CONFIG_HID_CHERRY is not set
> CONFIG_HID_COUGAR=y
> CONFIG_HID_MACALLY=y
> CONFIG_HID_CMEDIA=y
> CONFIG_HID_CYPRESS=y
> # CONFIG_HID_DRAGONRISE is not set
> CONFIG_HID_EMS_FF=y
> CONFIG_HID_ELECOM=y
> # CONFIG_HID_EZKEY is not set
> CONFIG_HID_GEMBIRD=y
> # CONFIG_HID_GFRM is not set
> CONFIG_HID_GLORIOUS=y
> CONFIG_HID_VIVALDI_COMMON=y
> CONFIG_HID_VIVALDI=y
> CONFIG_HID_KEYTOUCH=y
> # CONFIG_HID_KYE is not set
> CONFIG_HID_WALTOP=y
> CONFIG_HID_VIEWSONIC=y
> CONFIG_HID_XIAOMI=y
> CONFIG_HID_GYRATION=y
> # CONFIG_HID_ICADE is not set
> CONFIG_HID_ITE=y
> CONFIG_HID_JABRA=y
> CONFIG_HID_TWINHAN=y
> # CONFIG_HID_KENSINGTON is not set
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> CONFIG_HID_MAGICMOUSE=y
> CONFIG_HID_MALTRON=y
> CONFIG_HID_MAYFLASH=y
> CONFIG_HID_REDRAGON=y
> # CONFIG_HID_MICROSOFT is not set
> CONFIG_HID_MONTEREY=y
> # CONFIG_HID_MULTITOUCH is not set
> CONFIG_HID_NINTENDO=y
> # CONFIG_NINTENDO_FF is not set
> # CONFIG_HID_NTI is not set
> CONFIG_HID_ORTEK=y
> CONFIG_HID_PANTHERLORD=y
> CONFIG_PANTHERLORD_FF=y
> # CONFIG_HID_PETALYNX is not set
> CONFIG_HID_PICOLCD=y
> # CONFIG_HID_PICOLCD_LEDS is not set
> CONFIG_HID_PLANTRONICS=y
> CONFIG_HID_PLAYSTATION=y
> # CONFIG_PLAYSTATION_FF is not set
> # CONFIG_HID_RAZER is not set
> # CONFIG_HID_PRIMAX is not set
> CONFIG_HID_SAITEK=y
> # CONFIG_HID_SEMITEK is not set
> # CONFIG_HID_SPEEDLINK is not set
> CONFIG_HID_STEAM=y
> # CONFIG_HID_STEELSERIES is not set
> CONFIG_HID_SUNPLUS=y
> # CONFIG_HID_RMI is not set
> CONFIG_HID_GREENASIA=y
> CONFIG_GREENASIA_FF=y
> CONFIG_HID_SMARTJOYPLUS=y
> CONFIG_SMARTJOYPLUS_FF=y
> CONFIG_HID_TIVO=y
> CONFIG_HID_TOPSEED=y
> # CONFIG_HID_THINGM is not set
> CONFIG_HID_UDRAW_PS3=y
> # CONFIG_HID_WIIMOTE is not set
> CONFIG_HID_XINMO=y
> # CONFIG_HID_ZEROPLUS is not set
> CONFIG_HID_ZYDACRON=y
> CONFIG_HID_ALPS=y
> # end of Special HID drivers
> 
> #
> # I2C HID support
> #
> CONFIG_I2C_HID_OF=y
> CONFIG_I2C_HID_OF_GOODIX=y
> # end of I2C HID support
> 
> CONFIG_I2C_HID_CORE=y
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_MEMSTICK=y
> CONFIG_MEMSTICK_DEBUG=y
> 
> #
> # MemoryStick drivers
> #
> CONFIG_MEMSTICK_UNSAFE_RESUME=y
> 
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> CONFIG_LEDS_CLASS_FLASH=y
> CONFIG_LEDS_CLASS_MULTICOLOR=y
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_AN30259A is not set
> CONFIG_LEDS_AW2013=y
> # CONFIG_LEDS_LM3530 is not set
> CONFIG_LEDS_LM3532=y
> CONFIG_LEDS_LM3642=y
> CONFIG_LEDS_LM3692X=y
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=y
> CONFIG_LEDS_LP3952=y
> # CONFIG_LEDS_LP50XX is not set
> CONFIG_LEDS_LP55XX_COMMON=y
> # CONFIG_LEDS_LP5521 is not set
> CONFIG_LEDS_LP5523=y
> # CONFIG_LEDS_LP5562 is not set
> # CONFIG_LEDS_LP8501 is not set
> # CONFIG_LEDS_LP8860 is not set
> # CONFIG_LEDS_PCA955X is not set
> CONFIG_LEDS_PCA963X=y
> CONFIG_LEDS_PWM=y
> CONFIG_LEDS_BD2802=y
> # CONFIG_LEDS_LT3593 is not set
> CONFIG_LEDS_TCA6507=y
> CONFIG_LEDS_TLC591XX=y
> CONFIG_LEDS_LM355x=y
> # CONFIG_LEDS_IS31FL319X is not set
> # CONFIG_LEDS_IS31FL32XX is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> # CONFIG_LEDS_MLXREG is not set
> CONFIG_LEDS_USER=y
> CONFIG_LEDS_TI_LMU_COMMON=y
> # CONFIG_LEDS_LM3697 is not set
> 
> #
> # Flash and Torch LED drivers
> #
> CONFIG_LEDS_AAT1290=y
> CONFIG_LEDS_AS3645A=y
> # CONFIG_LEDS_KTD2692 is not set
> CONFIG_LEDS_LM3601X=y
> CONFIG_LEDS_RT4505=y
> CONFIG_LEDS_RT8515=y
> CONFIG_LEDS_SGM3140=y
> 
> #
> # RGB LED drivers
> #
> CONFIG_LEDS_PWM_MULTICOLOR=y
> CONFIG_LEDS_QCOM_LPG=y
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=y
> CONFIG_LEDS_TRIGGER_ONESHOT=y
> # CONFIG_LEDS_TRIGGER_MTD is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> CONFIG_LEDS_TRIGGER_CPU=y
> CONFIG_LEDS_TRIGGER_ACTIVITY=y
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=y
> CONFIG_LEDS_TRIGGER_CAMERA=y
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> CONFIG_LEDS_TRIGGER_NETDEV=y
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> CONFIG_LEDS_TRIGGER_AUDIO=y
> CONFIG_LEDS_TRIGGER_TTY=y
> 
> #
> # Simple LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> # CONFIG_SYNC_FILE is not set
> # CONFIG_UDMABUF is not set
> CONFIG_DMABUF_MOVE_NOTIFY=y
> # CONFIG_DMABUF_DEBUG is not set
> CONFIG_DMABUF_SELFTESTS=y
> CONFIG_DMABUF_HEAPS=y
> CONFIG_DMABUF_SYSFS_STATS=y
> # CONFIG_DMABUF_HEAPS_SYSTEM is not set
> # CONFIG_DMABUF_HEAPS_CMA is not set
> # end of DMABUF options
> 
> # CONFIG_AUXDISPLAY is not set
> CONFIG_UIO=y
> CONFIG_UIO_PDRV_GENIRQ=y
> CONFIG_UIO_DMEM_GENIRQ=y
> CONFIG_VFIO=y
> CONFIG_VFIO_IOMMU_TYPE1=y
> # CONFIG_VFIO_NOIOMMU is not set
> CONFIG_VFIO_MDEV=y
> CONFIG_VIRT_DRIVERS=y
> CONFIG_VIRTIO=y
> # CONFIG_VIRTIO_MENU is not set
> # CONFIG_VDPA is not set
> CONFIG_VHOST_IOTLB=y
> CONFIG_VHOST_RING=y
> # CONFIG_VHOST_MENU is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # end of Microsoft Hyper-V guest support
> 
> # CONFIG_GREYBUS is not set
> CONFIG_COMEDI=y
> # CONFIG_COMEDI_DEBUG is not set
> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
> CONFIG_COMEDI_MISC_DRIVERS=y
> # CONFIG_COMEDI_BOND is not set
> CONFIG_COMEDI_TEST=y
> CONFIG_COMEDI_PARPORT=y
> # CONFIG_COMEDI_ISA_DRIVERS is not set
> # CONFIG_COMEDI_PCMCIA_DRIVERS is not set
> CONFIG_COMEDI_8255=y
> CONFIG_COMEDI_8255_SA=y
> CONFIG_COMEDI_KCOMEDILIB=y
> CONFIG_COMEDI_NI_ROUTING=y
> CONFIG_COMEDI_TESTS=y
> CONFIG_COMEDI_TESTS_EXAMPLE=y
> CONFIG_COMEDI_TESTS_NI_ROUTES=y
> # CONFIG_STAGING is not set
> # CONFIG_COMMON_CLK is not set
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> # CONFIG_MICROCHIP_PIT64B is not set
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
> 
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_OF_IOMMU=y
> CONFIG_S390_CCW_IOMMU=y
> 
> #
> # Remoteproc drivers
> #
> CONFIG_REMOTEPROC=y
> # CONFIG_REMOTEPROC_CDEV is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> CONFIG_RPMSG_CHAR=y
> CONFIG_RPMSG_CTRL=y
> CONFIG_RPMSG_NS=y
> CONFIG_RPMSG_VIRTIO=y
> # end of Rpmsg drivers
> 
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> # CONFIG_PM_DEVFREQ is not set
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> CONFIG_EXTCON_ADC_JACK=y
> # CONFIG_EXTCON_FSA9480 is not set
> CONFIG_EXTCON_GPIO=y
> CONFIG_EXTCON_MAX3355=y
> # CONFIG_EXTCON_PTN5150 is not set
> CONFIG_EXTCON_RT8973A=y
> # CONFIG_EXTCON_SM5502 is not set
> # CONFIG_EXTCON_USB_GPIO is not set
> # CONFIG_EXTCON_USBC_TUSB320 is not set
> # CONFIG_MEMORY is not set
> CONFIG_IIO=y
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=y
> # CONFIG_IIO_BUFFER_DMA is not set
> # CONFIG_IIO_BUFFER_DMAENGINE is not set
> # CONFIG_IIO_BUFFER_HW_CONSUMER is not set
> CONFIG_IIO_KFIFO_BUF=y
> CONFIG_IIO_TRIGGERED_BUFFER=y
> CONFIG_IIO_CONFIGFS=y
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> CONFIG_IIO_SW_DEVICE=y
> CONFIG_IIO_SW_TRIGGER=y
> CONFIG_IIO_TRIGGERED_EVENT=y
> 
> #
> # Accelerometers
> #
> CONFIG_ADXL313=y
> CONFIG_ADXL313_I2C=y
> # CONFIG_ADXL345_I2C is not set
> CONFIG_ADXL355=y
> CONFIG_ADXL355_I2C=y
> CONFIG_ADXL367=y
> CONFIG_ADXL367_I2C=y
> CONFIG_ADXL372=y
> CONFIG_ADXL372_I2C=y
> # CONFIG_BMA180 is not set
> CONFIG_BMA400=y
> CONFIG_BMA400_I2C=y
> CONFIG_BMC150_ACCEL=y
> CONFIG_BMC150_ACCEL_I2C=y
> CONFIG_DA280=y
> # CONFIG_DA311 is not set
> # CONFIG_DMARD06 is not set
> CONFIG_DMARD09=y
> CONFIG_DMARD10=y
> # CONFIG_FXLS8962AF_I2C is not set
> CONFIG_IIO_ST_ACCEL_3AXIS=y
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
> # CONFIG_KXSD9 is not set
> CONFIG_KXCJK1013=y
> CONFIG_MC3230=y
> CONFIG_MMA7455=y
> CONFIG_MMA7455_I2C=y
> CONFIG_MMA7660=y
> # CONFIG_MMA8452 is not set
> CONFIG_MMA9551_CORE=y
> # CONFIG_MMA9551 is not set
> CONFIG_MMA9553=y
> # CONFIG_MXC4005 is not set
> # CONFIG_MXC6255 is not set
> CONFIG_STK8312=y
> CONFIG_STK8BA50=y
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> # CONFIG_AD7091R5 is not set
> CONFIG_AD7291=y
> # CONFIG_AD799X is not set
> CONFIG_ENVELOPE_DETECTOR=y
> CONFIG_HX711=y
> CONFIG_INA2XX_ADC=y
> CONFIG_LTC2471=y
> CONFIG_LTC2485=y
> CONFIG_LTC2497=y
> # CONFIG_MAX1363 is not set
> CONFIG_MAX9611=y
> CONFIG_MCP3422=y
> # CONFIG_NAU7802 is not set
> CONFIG_QCOM_VADC_COMMON=y
> CONFIG_QCOM_SPMI_IADC=y
> CONFIG_QCOM_SPMI_VADC=y
> CONFIG_QCOM_SPMI_ADC5=y
> CONFIG_SD_ADC_MODULATOR=y
> CONFIG_TI_ADC081C=y
> CONFIG_TI_ADS1015=y
> # end of Analog to digital converters
> 
> #
> # Analog to digital and digital to analog converters
> #
> # end of Analog to digital and digital to analog converters
> 
> #
> # Analog Front Ends
> #
> # CONFIG_IIO_RESCALE is not set
> # end of Analog Front Ends
> 
> #
> # Amplifiers
> #
> CONFIG_HMC425=y
> # end of Amplifiers
> 
> #
> # Capacitance to digital converters
> #
> CONFIG_AD7150=y
> # end of Capacitance to digital converters
> 
> #
> # Chemical Sensors
> #
> CONFIG_ATLAS_PH_SENSOR=y
> # CONFIG_ATLAS_EZO_SENSOR is not set
> CONFIG_BME680=y
> CONFIG_BME680_I2C=y
> # CONFIG_CCS811 is not set
> CONFIG_IAQCORE=y
> CONFIG_PMS7003=y
> # CONFIG_SCD30_CORE is not set
> CONFIG_SCD4X=y
> CONFIG_SENSIRION_SGP30=y
> CONFIG_SENSIRION_SGP40=y
> CONFIG_SPS30=y
> # CONFIG_SPS30_I2C is not set
> CONFIG_SPS30_SERIAL=y
> # CONFIG_SENSEAIR_SUNRISE_CO2 is not set
> # CONFIG_VZ89X is not set
> # end of Chemical Sensors
> 
> #
> # Hid Sensor IIO Common
> #
> # end of Hid Sensor IIO Common
> 
> CONFIG_IIO_MS_SENSORS_I2C=y
> 
> #
> # IIO SCMI Sensors
> #
> # end of IIO SCMI Sensors
> 
> #
> # SSP Sensor Common
> #
> # end of SSP Sensor Common
> 
> CONFIG_IIO_ST_SENSORS_I2C=y
> CONFIG_IIO_ST_SENSORS_CORE=y
> 
> #
> # Digital to analog converters
> #
> CONFIG_AD5064=y
> CONFIG_AD5380=y
> CONFIG_AD5446=y
> # CONFIG_AD5593R is not set
> CONFIG_AD5686=y
> CONFIG_AD5696_I2C=y
> CONFIG_DPOT_DAC=y
> CONFIG_DS4424=y
> CONFIG_M62332=y
> # CONFIG_MAX517 is not set
> # CONFIG_MAX5821 is not set
> CONFIG_MCP4725=y
> CONFIG_TI_DAC5571=y
> # end of Digital to analog converters
> 
> #
> # IIO dummy driver
> #
> CONFIG_IIO_SIMPLE_DUMMY=y
> # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
> # CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
> # end of IIO dummy driver
> 
> #
> # Filters
> #
> # end of Filters
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> # end of Clock Generator/Distribution
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
> 
> #
> # Digital gyroscope sensors
> #
> # CONFIG_BMG160 is not set
> CONFIG_FXAS21002C=y
> CONFIG_FXAS21002C_I2C=y
> # CONFIG_MPU3050_I2C is not set
> CONFIG_IIO_ST_GYRO_3AXIS=y
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
> CONFIG_ITG3200=y
> # end of Digital gyroscope sensors
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> CONFIG_AFE4404=y
> # CONFIG_MAX30100 is not set
> CONFIG_MAX30102=y
> # end of Heart Rate Monitors
> # end of Health Sensors
> 
> #
> # Humidity sensors
> #
> # CONFIG_AM2315 is not set
> CONFIG_DHT11=y
> CONFIG_HDC100X=y
> CONFIG_HDC2010=y
> CONFIG_HTS221=y
> CONFIG_HTS221_I2C=y
> CONFIG_HTU21=y
> # CONFIG_SI7005 is not set
> CONFIG_SI7020=y
> # end of Humidity sensors
> 
> #
> # Inertial measurement units
> #
> # CONFIG_BMI160_I2C is not set
> # CONFIG_FXOS8700_I2C is not set
> # CONFIG_KMX61 is not set
> CONFIG_INV_ICM42600=y
> CONFIG_INV_ICM42600_I2C=y
> CONFIG_INV_MPU6050_IIO=y
> CONFIG_INV_MPU6050_I2C=y
> CONFIG_IIO_ST_LSM6DSX=y
> CONFIG_IIO_ST_LSM6DSX_I2C=y
> CONFIG_IIO_ST_LSM6DSX_I3C=y
> CONFIG_IIO_ST_LSM9DS0=y
> # CONFIG_IIO_ST_LSM9DS0_I2C is not set
> # end of Inertial measurement units
> 
> #
> # Light sensors
> #
> CONFIG_ADJD_S311=y
> # CONFIG_ADUX1020 is not set
> # CONFIG_AL3010 is not set
> # CONFIG_AL3320A is not set
> CONFIG_APDS9300=y
> # CONFIG_APDS9960 is not set
> CONFIG_AS73211=y
> CONFIG_BH1750=y
> CONFIG_BH1780=y
> # CONFIG_CM32181 is not set
> CONFIG_CM3232=y
> CONFIG_CM3323=y
> CONFIG_CM3605=y
> # CONFIG_CM36651 is not set
> # CONFIG_GP2AP002 is not set
> # CONFIG_GP2AP020A00F is not set
> CONFIG_SENSORS_ISL29018=y
> CONFIG_SENSORS_ISL29028=y
> CONFIG_ISL29125=y
> CONFIG_JSA1212=y
> CONFIG_RPR0521=y
> CONFIG_LTR501=y
> CONFIG_LV0104CS=y
> CONFIG_MAX44000=y
> CONFIG_MAX44009=y
> # CONFIG_NOA1305 is not set
> CONFIG_OPT3001=y
> # CONFIG_PA12203001 is not set
> CONFIG_SI1133=y
> CONFIG_SI1145=y
> CONFIG_STK3310=y
> CONFIG_ST_UVIS25=y
> CONFIG_ST_UVIS25_I2C=y
> # CONFIG_TCS3414 is not set
> CONFIG_TCS3472=y
> CONFIG_SENSORS_TSL2563=y
> CONFIG_TSL2583=y
> CONFIG_TSL2591=y
> # CONFIG_TSL2772 is not set
> # CONFIG_TSL4531 is not set
> # CONFIG_US5182D is not set
> # CONFIG_VCNL4000 is not set
> # CONFIG_VCNL4035 is not set
> # CONFIG_VEML6030 is not set
> # CONFIG_VEML6070 is not set
> # CONFIG_VL6180 is not set
> CONFIG_ZOPT2201=y
> # end of Light sensors
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8974=y
> CONFIG_AK8975=y
> CONFIG_AK09911=y
> CONFIG_BMC150_MAGN=y
> CONFIG_BMC150_MAGN_I2C=y
> # CONFIG_MAG3110 is not set
> # CONFIG_MMC35240 is not set
> CONFIG_IIO_ST_MAGN_3AXIS=y
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
> # CONFIG_SENSORS_HMC5843_I2C is not set
> # CONFIG_SENSORS_RM3100_I2C is not set
> CONFIG_YAMAHA_YAS530=y
> # end of Magnetometer sensors
> 
> #
> # Multiplexers
> #
> # CONFIG_IIO_MUX is not set
> # end of Multiplexers
> 
> #
> # Inclinometer sensors
> #
> # end of Inclinometer sensors
> 
> #
> # Triggers - standalone
> #
> # CONFIG_IIO_HRTIMER_TRIGGER is not set
> CONFIG_IIO_INTERRUPT_TRIGGER=y
> CONFIG_IIO_TIGHTLOOP_TRIGGER=y
> # CONFIG_IIO_SYSFS_TRIGGER is not set
> # end of Triggers - standalone
> 
> #
> # Linear and angular position sensors
> #
> # end of Linear and angular position sensors
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> CONFIG_AD5272=y
> CONFIG_DS1803=y
> CONFIG_MAX5432=y
> # CONFIG_MCP4018 is not set
> CONFIG_MCP4531=y
> CONFIG_TPL0102=y
> # end of Digital potentiometers
> 
> #
> # Digital potentiostats
> #
> # CONFIG_LMP91000 is not set
> # end of Digital potentiostats
> 
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> CONFIG_BMP280=y
> CONFIG_BMP280_I2C=y
> # CONFIG_DLHL60D is not set
> CONFIG_DPS310=y
> CONFIG_HP03=y
> CONFIG_ICP10100=y
> CONFIG_MPL115=y
> CONFIG_MPL115_I2C=y
> CONFIG_MPL3115=y
> CONFIG_MS5611=y
> CONFIG_MS5611_I2C=y
> CONFIG_MS5637=y
> CONFIG_IIO_ST_PRESS=y
> CONFIG_IIO_ST_PRESS_I2C=y
> CONFIG_T5403=y
> CONFIG_HP206C=y
> CONFIG_ZPA2326=y
> CONFIG_ZPA2326_I2C=y
> # end of Pressure sensors
> 
> #
> # Lightning sensors
> #
> # end of Lightning sensors
> 
> #
> # Proximity and distance sensors
> #
> # CONFIG_ISL29501 is not set
> CONFIG_LIDAR_LITE_V2=y
> # CONFIG_MB1232 is not set
> CONFIG_PING=y
> CONFIG_RFD77402=y
> CONFIG_SRF04=y
> CONFIG_SX_COMMON=y
> CONFIG_SX9310=y
> # CONFIG_SX9324 is not set
> # CONFIG_SX9360 is not set
> CONFIG_SX9500=y
> CONFIG_SRF08=y
> CONFIG_VCNL3020=y
> CONFIG_VL53L0X_I2C=y
> # end of Proximity and distance sensors
> 
> #
> # Resolver to digital converters
> #
> # end of Resolver to digital converters
> 
> #
> # Temperature sensors
> #
> # CONFIG_MLX90614 is not set
> CONFIG_MLX90632=y
> CONFIG_TMP006=y
> CONFIG_TMP007=y
> CONFIG_TMP117=y
> CONFIG_TSYS01=y
> CONFIG_TSYS02D=y
> # end of Temperature sensors
> 
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_DEBUG is not set
> CONFIG_PWM_ATMEL_TCB=y
> CONFIG_PWM_PCA9685=y
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> # CONFIG_AL_FIC is not set
> # CONFIG_XILINX_INTC is not set
> # end of IRQ chip support
> 
> CONFIG_RESET_CONTROLLER=y
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> CONFIG_PHY_CAN_TRANSCEIVER=y
> 
> #
> # PHY drivers for Broadcom platforms
> #
> # end of PHY drivers for Broadcom platforms
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> # CONFIG_DTPM is not set
> CONFIG_RAS=y
> 
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # end of Android
> 
> CONFIG_DAX=y
> # CONFIG_NVMEM is not set
> 
> #
> # HW tracing support
> #
> CONFIG_STM=y
> CONFIG_STM_PROTO_BASIC=y
> # CONFIG_STM_PROTO_SYS_T is not set
> CONFIG_STM_DUMMY=y
> # CONFIG_STM_SOURCE_CONSOLE is not set
> CONFIG_STM_SOURCE_HEARTBEAT=y
> # CONFIG_STM_SOURCE_FTRACE is not set
> # end of HW tracing support
> 
> # CONFIG_FPGA is not set
> # CONFIG_FSI is not set
> CONFIG_MULTIPLEXER=y
> 
> #
> # Multiplexer drivers
> #
> # CONFIG_MUX_ADG792A is not set
> CONFIG_MUX_GPIO=y
> # CONFIG_MUX_MMIO is not set
> # end of Multiplexer drivers
> 
> CONFIG_SIOX=y
> # CONFIG_SIOX_BUS_GPIO is not set
> CONFIG_SLIMBUS=y
> CONFIG_INTERCONNECT=y
> CONFIG_COUNTER=y
> # CONFIG_INTERRUPT_CNT is not set
> CONFIG_MOST=y
> # CONFIG_MOST_CDEV is not set
> CONFIG_PECI=y
> CONFIG_PECI_CPU=y
> # CONFIG_HTE is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_VALIDATE_FS_PARSER=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FS_ENCRYPTION_ALGS=y
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> # CONFIG_DNOTIFY is not set
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
> # CONFIG_QUOTA is not set
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=y
> CONFIG_CUSE=y
> CONFIG_VIRTIO_FS=y
> CONFIG_OVERLAY_FS=y
> CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
> CONFIG_OVERLAY_FS_INDEX=y
> # CONFIG_OVERLAY_FS_NFS_EXPORT is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
> 
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=y
> CONFIG_FSCACHE=y
> CONFIG_FSCACHE_DEBUG=y
> # end of Caches
> 
> #
> # Pseudo filesystems
> #
> # CONFIG_PROC_FS is not set
> # CONFIG_PROC_CHILDREN is not set
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> CONFIG_TMPFS_XATTR=y
> CONFIG_TMPFS_INODE64=y
> CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
> # CONFIG_HUGETLBFS is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_ORANGEFS_FS=y
> CONFIG_ECRYPT_FS=y
> # CONFIG_ECRYPT_FS_MESSAGING is not set
> # CONFIG_JFFS2_FS is not set
> CONFIG_UBIFS_FS=y
> CONFIG_UBIFS_FS_ADVANCED_COMPR=y
> CONFIG_UBIFS_FS_LZO=y
> CONFIG_UBIFS_FS_ZLIB=y
> # CONFIG_UBIFS_FS_ZSTD is not set
> CONFIG_UBIFS_ATIME_SUPPORT=y
> CONFIG_UBIFS_FS_XATTR=y
> # CONFIG_UBIFS_FS_SECURITY is not set
> # CONFIG_UBIFS_FS_AUTHENTICATION is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> # CONFIG_PSTORE_DEFLATE_COMPRESS is not set
> CONFIG_PSTORE_LZO_COMPRESS=y
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> CONFIG_PSTORE_LZ4HC_COMPRESS=y
> # CONFIG_PSTORE_842_COMPRESS is not set
> CONFIG_PSTORE_ZSTD_COMPRESS=y
> CONFIG_PSTORE_COMPRESS=y
> # CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
> CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT=y
> CONFIG_PSTORE_COMPRESS_DEFAULT="zstd"
> # CONFIG_PSTORE_CONSOLE is not set
> CONFIG_PSTORE_PMSG=y
> CONFIG_NETWORK_FILESYSTEMS=y
> # CONFIG_NLS is not set
> CONFIG_UNICODE=y
> CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=y
> CONFIG_BIG_KEYS=y
> # CONFIG_TRUSTED_KEYS is not set
> CONFIG_ENCRYPTED_KEYS=y
> CONFIG_USER_DECRYPTED_DATA=y
> # CONFIG_KEY_DH_OPERATIONS is not set
> CONFIG_SECURITY_DMESG_RESTRICT=y
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_SECURITY_PATH=y
> CONFIG_FORTIFY_SOURCE=y
> CONFIG_STATIC_USERMODEHELPER=y
> CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
> CONFIG_SECURITY_TOMOYO=y
> CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
> CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
> # CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
> CONFIG_SECURITY_TOMOYO_POLICY_LOADER="/sbin/tomoyo-init"
> CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER="/sbin/init"
> # CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
> CONFIG_SECURITY_APPARMOR=y
> CONFIG_SECURITY_APPARMOR_HASH=y
> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> # CONFIG_SECURITY_YAMA is not set
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> CONFIG_INTEGRITY=y
> # CONFIG_INTEGRITY_SIGNATURE is not set
> CONFIG_INTEGRITY_AUDIT=y
> CONFIG_IMA=y
> CONFIG_IMA_MEASURE_PCR_IDX=10
> CONFIG_IMA_LSM_RULES=y
> CONFIG_IMA_NG_TEMPLATE=y
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> # CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
> # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> CONFIG_IMA_DEFAULT_HASH_SHA512=y
> # CONFIG_IMA_DEFAULT_HASH_WP512 is not set
> # CONFIG_IMA_DEFAULT_HASH_SM3 is not set
> CONFIG_IMA_DEFAULT_HASH="sha512"
> CONFIG_IMA_WRITE_POLICY=y
> CONFIG_IMA_READ_POLICY=y
> # CONFIG_IMA_APPRAISE is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> CONFIG_IMA_DISABLE_HTABLE=y
> CONFIG_EVM=y
> CONFIG_EVM_ATTR_FSUUID=y
> CONFIG_EVM_ADD_XATTRS=y
> CONFIG_DEFAULT_SECURITY_TOMOYO=y
> # CONFIG_DEFAULT_SECURITY_APPARMOR is not set
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_INIT_STACK_ALL_PATTERN is not set
> # CONFIG_INIT_STACK_ALL_ZERO is not set
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> CONFIG_INIT_ON_FREE_DEFAULT_ON=y
> # end of Memory initialization
> 
> CONFIG_CC_HAS_RANDSTRUCT=y
> CONFIG_RANDSTRUCT_NONE=y
> # CONFIG_RANDSTRUCT_FULL is not set
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=y
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> CONFIG_CRYPTO_USER=y
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_PCRYPT=y
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
> CONFIG_CRYPTO_ECC=y
> CONFIG_CRYPTO_ECDH=y
> CONFIG_CRYPTO_ECDSA=y
> CONFIG_CRYPTO_ECRDSA=y
> # CONFIG_CRYPTO_SM2 is not set
> CONFIG_CRYPTO_CURVE25519=y
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_CHACHA20POLY1305=y
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_SEQIV is not set
> CONFIG_CRYPTO_ECHAINIV=y
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=y
> CONFIG_CRYPTO_OFB=y
> CONFIG_CRYPTO_PCBC=y
> CONFIG_CRYPTO_XTS=y
> CONFIG_CRYPTO_KEYWRAP=y
> CONFIG_CRYPTO_NHPOLY1305=y
> CONFIG_CRYPTO_ADIANTUM=y
> # CONFIG_CRYPTO_ESSIV is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=y
> # CONFIG_CRYPTO_VMAC is not set
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32=y
> # CONFIG_CRYPTO_CRC32_S390 is not set
> CONFIG_CRYPTO_XXHASH=y
> # CONFIG_CRYPTO_BLAKE2B is not set
> # CONFIG_CRYPTO_BLAKE2S is not set
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_CRC64_ROCKSOFT=y
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=y
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> CONFIG_CRYPTO_RMD160=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA512_S390=y
> # CONFIG_CRYPTO_SHA1_S390 is not set
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA256_S390=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> CONFIG_CRYPTO_SHA3_256_S390=y
> CONFIG_CRYPTO_SHA3_512_S390=y
> CONFIG_CRYPTO_SM3=y
> CONFIG_CRYPTO_SM3_GENERIC=y
> CONFIG_CRYPTO_STREEBOG=y
> CONFIG_CRYPTO_WP512=y
> CONFIG_CRYPTO_GHASH_S390=y
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> # CONFIG_CRYPTO_AES_S390 is not set
> CONFIG_CRYPTO_ANUBIS=y
> CONFIG_CRYPTO_ARC4=y
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> CONFIG_CRYPTO_CAMELLIA=y
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=y
> CONFIG_CRYPTO_CAST6=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_DES_S390=y
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_KHAZAD=y
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_CHACHA_S390=y
> CONFIG_CRYPTO_SEED=y
> CONFIG_CRYPTO_SERPENT=y
> CONFIG_CRYPTO_SM4=y
> CONFIG_CRYPTO_SM4_GENERIC=y
> CONFIG_CRYPTO_TEA=y
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=y
> CONFIG_CRYPTO_LZ4=y
> CONFIG_CRYPTO_LZ4HC=y
> CONFIG_CRYPTO_ZSTD=y
> 
> #
> # Random Number Generation
> #
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_USER_API=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> CONFIG_CRYPTO_USER_API_SKCIPHER=y
> CONFIG_CRYPTO_USER_API_RNG=y
> CONFIG_CRYPTO_USER_API_RNG_CAVP=y
> CONFIG_CRYPTO_USER_API_AEAD=y
> CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
> # CONFIG_CRYPTO_STATS is not set
> CONFIG_CRYPTO_HASH_INFO=y
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> # CONFIG_X509_CERTIFICATE_PARSER is not set
> CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
> 
> #
> # Certificates for signature checking
> #
> # CONFIG_SYSTEM_TRUSTED_KEYRING is not set
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_LINEAR_RANGES=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_CORDIC=y
> CONFIG_PRIME_NUMBERS=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_ARC4=y
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> CONFIG_CRYPTO_LIB_CURVE25519=y
> CONFIG_CRYPTO_LIB_DES=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
> CONFIG_CRYPTO_LIB_SHA256=y
> # end of Crypto library routines
> 
> CONFIG_LIB_MEMNEQ=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC64_ROCKSOFT=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> CONFIG_CRC32_SELFTEST=y
> # CONFIG_CRC32_SLICEBY8 is not set
> CONFIG_CRC32_SLICEBY4=y
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=y
> CONFIG_CRC4=y
> # CONFIG_CRC7 is not set
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> CONFIG_RANDOM32_SELFTEST=y
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_ZLIB_DFLTCC=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4HC_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> # CONFIG_XZ_DEC_X86 is not set
> # CONFIG_XZ_DEC_POWERPC is not set
> # CONFIG_XZ_DEC_IA64 is not set
> # CONFIG_XZ_DEC_ARM is not set
> # CONFIG_XZ_DEC_ARMTHUMB is not set
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_MICROLZMA=y
> CONFIG_XZ_DEC_BCJ=y
> CONFIG_XZ_DEC_TEST=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_BCH=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
> CONFIG_SWIOTLB=y
> CONFIG_DMA_CMA=y
> CONFIG_DMA_PERNUMA_CMA=y
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=16
> CONFIG_CMA_SIZE_PERCENTAGE=10
> # CONFIG_CMA_SIZE_SEL_MBYTES is not set
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> CONFIG_CMA_SIZE_SEL_MIN=y
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=8
> # CONFIG_DMA_API_DEBUG is not set
> CONFIG_DMA_MAP_BENCHMARK=y
> CONFIG_SGL_ALLOC=y
> CONFIG_CPUMASK_OFFSTACK=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> CONFIG_GLOB_SELFTEST=y
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> # CONFIG_IRQ_POLL is not set
> CONFIG_MPILIB=y
> CONFIG_OID_REGISTRY=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_STACK_HASH_ORDER=20
> CONFIG_REF_TRACKER=y
> # end of Library routines
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> # CONFIG_PRINTK_TIME is not set
> # CONFIG_PRINTK_CALLER is not set
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> # CONFIG_SYMBOLIC_ERRNAME is not set
> # end of printk and dmesg options
> 
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_MISC is not set
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO_NONE=y
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_FRAME_WARN=2048
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> # CONFIG_VMLINUX_MAP is not set
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> # CONFIG_MAGIC_SYSRQ is not set
> CONFIG_DEBUG_FS=y
> # CONFIG_DEBUG_FS_ALLOW_ALL is not set
> CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
> # CONFIG_UBSAN_BOUNDS is not set
> CONFIG_UBSAN_SHIFT=y
> # CONFIG_UBSAN_DIV_ZERO is not set
> CONFIG_UBSAN_UNREACHABLE=y
> CONFIG_UBSAN_BOOL=y
> # CONFIG_UBSAN_ENUM is not set
> CONFIG_UBSAN_ALIGNMENT=y
> # CONFIG_UBSAN_SANITIZE_ALL is not set
> CONFIG_HAVE_ARCH_KCSAN=y
> CONFIG_HAVE_KCSAN_COMPILER=y
> CONFIG_KCSAN=y
> CONFIG_CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE=y
> CONFIG_KCSAN_VERBOSE=y
> CONFIG_KCSAN_SELFTEST=y
> CONFIG_KCSAN_EARLY_ENABLE=y
> CONFIG_KCSAN_NUM_WATCHPOINTS=64
> CONFIG_KCSAN_UDELAY_TASK=80
> CONFIG_KCSAN_UDELAY_INTERRUPT=20
> # CONFIG_KCSAN_DELAY_RANDOMIZE is not set
> CONFIG_KCSAN_SKIP_WATCH=4000
> CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE=y
> CONFIG_KCSAN_INTERRUPT_WATCHER=y
> CONFIG_KCSAN_REPORT_ONCE_IN_MS=3000
> # CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN is not set
> CONFIG_KCSAN_STRICT=y
> CONFIG_KCSAN_WEAK_MEMORY=y
> # end of Generic Kernel Debugging Instruments
> 
> #
> # Networking Debugging
> #
> CONFIG_NET_DEV_REFCNT_TRACKER=y
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> CONFIG_DEBUG_NET=y
> # end of Networking Debugging
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_PAGE_OWNER=y
> CONFIG_PAGE_POISONING=y
> CONFIG_DEBUG_PAGE_REF=y
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> CONFIG_DEBUG_WX=y
> CONFIG_GENERIC_PTDUMP=y
> CONFIG_PTDUMP_CORE=y
> CONFIG_PTDUMP_DEBUGFS=y
> CONFIG_DEBUG_OBJECTS=y
> CONFIG_DEBUG_OBJECTS_SELFTEST=y
> CONFIG_DEBUG_OBJECTS_FREE=y
> CONFIG_DEBUG_OBJECTS_TIMERS=y
> CONFIG_DEBUG_OBJECTS_WORK=y
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
> CONFIG_DEBUG_STACK_USAGE=y
> CONFIG_SCHED_STACK_END_CHECK=y
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> # CONFIG_DEBUG_VM is not set
> CONFIG_DEBUG_VM_PGTABLE=y
> # CONFIG_DEBUG_MEMORY_INIT is not set
> CONFIG_DEBUG_PER_CPU_MAPS=y
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_HAVE_ARCH_KFENCE=y
> # end of Memory Debugging
> 
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> # CONFIG_WQ_WATCHDOG is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_TIMEKEEPING is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> # CONFIG_PROVE_RAW_LOCK_NESTING is not set
> # CONFIG_LOCK_STAT is not set
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCKDEP_BITS=15
> CONFIG_LOCKDEP_CHAINS_BITS=16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> CONFIG_LOCK_TORTURE_TEST=y
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_DEBUG_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_KOBJECT_RELEASE=y
> 
> #
> # Debug kernel data structures
> #
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> CONFIG_DEBUG_NOTIFIERS=y
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Debug kernel data structures
> 
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> CONFIG_TORTURE_TEST=y
> CONFIG_RCU_SCALE_TEST=y
> CONFIG_RCU_TORTURE_TEST=y
> CONFIG_RCU_REF_SCALE_TEST=y
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
> CONFIG_RCU_TRACE=y
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_NOP_MCOUNT=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> CONFIG_TRACING=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> CONFIG_IO_STRICT_DEVMEM=y
> 
> #
> # s390 Debugging
> #
> CONFIG_EARLY_PRINTK=y
> CONFIG_DEBUG_ENTRY=y
> CONFIG_CIO_INJECT=y
> # end of s390 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FAULT_INJECTION=y
> CONFIG_FAIL_PAGE_ALLOC=y
> CONFIG_FAULT_INJECTION_USERCOPY=y
> # CONFIG_FAIL_FUTEX is not set
> CONFIG_FAULT_INJECTION_DEBUG_FS=y
> CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=y
> CONFIG_LKDTM=y
> CONFIG_TEST_MIN_HEAP=y
> CONFIG_TEST_DIV64=y
> CONFIG_BACKTRACE_SELF_TEST=y
> CONFIG_TEST_REF_TRACKER=y
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> CONFIG_INTERVAL_TREE_TEST=y
> # CONFIG_ATOMIC64_SELFTEST is not set
> CONFIG_TEST_HEXDUMP=y
> CONFIG_STRING_SELFTEST=y
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> CONFIG_TEST_SCANF=y
> # CONFIG_TEST_BITMAP is not set
> CONFIG_TEST_UUID=y
> CONFIG_TEST_XARRAY=y
> CONFIG_TEST_RHASHTABLE=y
> # CONFIG_TEST_SIPHASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> CONFIG_TEST_UDELAY=y
> CONFIG_TEST_MEMCAT_P=y
> CONFIG_TEST_MEMINIT=y
> # CONFIG_TEST_FREE_PAGES is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

