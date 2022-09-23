Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7A5E7E50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiIWPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIWPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:24:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC124BD5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCB0A626DB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA720C43142;
        Fri, 23 Sep 2022 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663946694;
        bh=20DHUPhIVmQnBMZs4XhW6hfoTHd9Uof5jBR5k0iDLfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lo5SxxISJbJdctKOcGA/NZP/Jcqh/OENI193JCRQ/IMgsTmo7nIHmgn0Z65gSdeI6
         K1dnW2mBFFLR7ztwfrD1K/imW+4zFrHEQw1ijEu7FxXweYEn2fgd2BJtv5mbdzQnyO
         m0Jxv/pHgHzX6tfqHKhKa5/7mI6yoiIBdTxTzbnt8IfMNYbSY5wh7aaj2AkDEYUZt3
         zc8yzEMxIPKn5j197X00MtcLVghVnjzPsEhdxNtr17ehCaIww9aaWLKCgjE+0lFe7m
         tvhqnKVTuw6ezuxQhy+pz2W+YZjt5EGvVtHd4fHKX9skIDmKu96q7ca8aV47RBov3c
         7Fi5AyhWzZm3w==
Date:   Fri, 23 Sep 2022 08:24:52 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: s390x-linux-ld: kallsyms.c:undefined reference to `__tsan_memcpy'
Message-ID: <Yy3PxL973jtEtEUK@dev-arch.thelio-3990X>
References: <202209231726.eAy8Z0ZF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209231726.eAy8Z0ZF-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel folks,

I thought these reports were not going to be delivered to kernel
developers?

https://lore.kernel.org/Yx3HnuEDyFG0+G62@dev-arch.thelio-3990X/

Cheers,
Nathan

On Fri, Sep 23, 2022 at 05:44:55PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   bf682942cd26ce9cd5e87f73ae099b383041e782
> commit: 647cafa22349026a8435030e9157074ab7fe5710 bpf: add a ksym BPF iterator
> date:   2 months ago
> config: s390-buildonly-randconfig-r001-20220922 (https://download.01.org/0day-ci/archive/20220923/202209231726.eAy8Z0ZF-lkp@intel.com/config)
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
>    hrtimer.c:(.text+0x1e92): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/hrtimer.o: in function `hrtimer_nanosleep':
>    hrtimer.c:(.text+0x332c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/hrtimer.o: in function `__se_sys_nanosleep':
>    hrtimer.c:(.text+0x350a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/hrtimer.o:hrtimer.c:(.text+0x36be): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `tk_set_wall_to_mono':
>    timekeeping.c:(.text+0x3a7e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_update':
>    timekeeping.c:(.text+0x3d64): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_inject_offset':
>    timekeeping.c:(.text+0x3f64): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.text+0x417a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `read_persistent_clock64':
>    timekeeping.c:(.text+0x4de2): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_resume':
>    timekeeping.c:(.text+0x517e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.text+0x5190): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/timekeeping.o:timekeeping.c:(.text+0x5432): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_resume':
>    timekeeping.c:(.text+0x54c8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: timekeeping.c:(.text+0x55fc): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.text+0x5620): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_suspend':
>    timekeeping.c:(.text+0x584e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.text+0x58c0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.text+0x5956): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.text+0x597c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: timekeeping.c:(.text+0x59b0): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: timekeeping.c:(.text+0x5a5a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_advance':
>    timekeeping.c:(.text+0x5f92): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.text+0x6572): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.text+0x66f2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `getboottime64':
>    timekeeping.c:(.text+0x67b4): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `do_adjtimex':
>    timekeeping.c:(.text+0x7382): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `update_fast_timekeeper':
>    timekeeping.c:(.text+0x794c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: timekeeping.c:(.text+0x7970): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `read_persistent_wall_and_boot_offset':
>    timekeeping.c:(.init.text+0x46): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_init':
>    timekeeping.c:(.init.text+0x7e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.init.text+0x90): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.init.text+0x146): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.init.text+0x198): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.init.text+0x1b6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: timekeeping.c:(.init.text+0x1da): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: timekeeping.c:(.init.text+0x34a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/ntp.o: in function `__do_adjtimex':
>    ntp.c:(.text+0xf8c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: ntp.c:(.text+0xf9e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/clocksource.o: in function `sysfs_get_uname':
>    clocksource.c:(.text+0xdd0): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/clocksource.o: in function `current_clocksource_store':
>    clocksource.c:(.text+0x10d0): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/clocksource.o: in function `unbind_clocksource_store':
>    clocksource.c:(.text+0x1142): undefined reference to `__tsan_memset'
>    s390x-linux-ld: clocksource.c:(.text+0x118c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/clocksource.o: in function `boot_override_clocksource':
>    clocksource.c:(.init.text+0x128): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/jiffies.o: in function `register_refined_jiffies':
>    jiffies.c:(.text+0x36): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/alarmtimer.o: in function `trace_event_raw_event_alarmtimer_suspend':
>    alarmtimer.c:(.text+0x26a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/alarmtimer.o: in function `trace_event_raw_event_alarm_class':
>    alarmtimer.c:(.text+0x35a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/alarmtimer.o: in function `get_boottime_timespec':
>    alarmtimer.c:(.text+0x149e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/alarmtimer.o: in function `alarmtimer_init':
>    alarmtimer.c:(.init.text+0xaa): undefined reference to `__tsan_memset'
>    s390x-linux-ld: alarmtimer.c:(.init.text+0xd8): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/posix-stubs.o: in function `__se_sys_clock_settime':
>    posix-stubs.c:(.text+0x56): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/posix-stubs.o: in function `do_clock_gettime':
>    posix-stubs.c:(.text+0xfe): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/time/posix-stubs.o: in function `__se_sys_clock_gettime':
>    posix-stubs.c:(.text+0x16c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/posix-stubs.o: in function `__se_sys_clock_nanosleep':
>    posix-stubs.c:(.text+0x2c4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/clockevents.o: in function `unbind_device_store':
>    clockevents.c:(.text+0x1808): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/tick-sched.o: in function `tick_cancel_sched_timer':
>    tick-sched.c:(.text+0x1f62): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/test_udelay.o: in function `udelay_test_write':
>    test_udelay.c:(.text+0x30): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/time/test_udelay.o:test_udelay.c:(.text+0x15c): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: kernel/smp.o: in function `smp_call_function_single':
>    smp.c:(.text+0x1084): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: smp.c:(.text+0x167a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: smp.c:(.text+0x1bf0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/smp.o: in function `smp_call_function_many_cond':
>    smp.c:(.text+0x295e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: smp.c:(.text+0x30b6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: smp.c:(.text+0x395a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/smp.o:smp.c:(.text+0x3fae): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: kernel/kallsyms.o: in function `update_iter':
>    kallsyms.c:(.text+0x1370): undefined reference to `__tsan_memcpy'
> >> s390x-linux-ld: kallsyms.c:(.text+0x13a2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kallsyms.c:(.text+0x148c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/acct.o: in function `__se_sys_acct':
>    acct.c:(.text+0x390): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/acct.o: in function `do_acct_process':
>    acct.c:(.text+0xf50): undefined reference to `__tsan_memset'
>    s390x-linux-ld: acct.c:(.text+0xfd6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: acct.c:(.text+0x10ee): undefined reference to `__tsan_memset'
> >> s390x-linux-ld: acct.c:(.text+0x112c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/crash_core.o: in function `append_elf_note':
>    crash_core.c:(.text+0x72): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_core.c:(.text+0xa2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/crash_core.o: in function `final_note':
>    crash_core.c:(.text+0xde): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/crash_core.o: in function `crash_update_vmcoreinfo_safecopy':
>    crash_core.c:(.text+0x13a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/crash_core.o: in function `crash_save_vmcoreinfo':
>    crash_core.c:(.text+0x228): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/crash_core.o: in function `vmcoreinfo_append_str':
>    crash_core.c:(.text+0x260): undefined reference to `__tsan_memset'
>    s390x-linux-ld: crash_core.c:(.text+0x272): undefined reference to `__tsan_memset'
>    s390x-linux-ld: crash_core.c:(.text+0x30c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/crash_core.o: in function `crash_save_vmcoreinfo_init':
>    crash_core.c:(.init.text+0x9fa): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/kexec_core.o: in function `kimage_load_segment':
>    kexec_core.c:(.text+0x1126): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kexec_core.c:(.text+0x1272): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kexec_core.c:(.text+0x1290): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kexec_core.c:(.text+0x13bc): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kexec_core.c:(.text+0x14d6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kexec_core.c:(.text+0x14f2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/kexec_core.o: in function `__crash_kexec':
>    kexec_core.c:(.text+0x15b4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/kexec_core.o: in function `kimage_alloc_pages':
>    kexec_core.c:(.text+0x1ca2): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/kexec.o: in function `__se_sys_kexec_load':
>    kexec.c:(.text+0x240): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/backtracetest.o: in function `backtrace_regression_test':
>    backtracetest.c:(.text+0x9e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `trace_event_raw_event_cgroup_root':
>    cgroup.c:(.text+0x778): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `trace_event_raw_event_cgroup':
>    cgroup.c:(.text+0x8ca): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `trace_event_raw_event_cgroup_migrate':
>    cgroup.c:(.text+0xa60): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `trace_event_raw_event_cgroup_event':
>    cgroup.c:(.text+0xc7a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o:cgroup.c:(.text+0x1c5c): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `task_cgroup_path':
>    cgroup.c:(.text+0x61b0): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_migrate_finish':
>    cgroup.c:(.text+0x67ee): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_migrate_prepare_dst':
>    cgroup.c:(.text+0x6d76): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `find_css_set':
>    cgroup.c:(.text+0x6f8c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: cgroup.c:(.text+0x6f9e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: cgroup.c:(.text+0x7676): undefined reference to `__tsan_memset'
>    s390x-linux-ld: cgroup.c:(.text+0x76f4): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_attach_task':
>    cgroup.c:(.text+0x8ad2): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `css_task_iter_start':
>    cgroup.c:(.text+0x9f76): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_mkdir':
>    cgroup.c:(.text+0xa992): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_addrm_files':
>    cgroup.c:(.text+0x103aa): undefined reference to `__tsan_memset'
>    s390x-linux-ld: cgroup.c:(.text+0x1048a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o:cgroup.c:(.text+0x10654): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `features_show':
>    cgroup.c:(.text+0x17c54): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_init_subsys':
>    cgroup.c:(.init.text+0x246): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_init':
>    cgroup.c:(.init.text+0xc48): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup_transfer_tasks':
>    cgroup-v1.c:(.text+0x1c4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: cgroup-v1.c:(.text+0x1d6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup_pidlist_start':
>    cgroup-v1.c:(.text+0x930): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup_release_agent_write':
>    cgroup-v1.c:(.text+0x142a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroupstats_build':
>    cgroup-v1.c:(.text+0x1588): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup1_release_agent':
>    cgroup-v1.c:(.text+0x1d60): undefined reference to `__tsan_memset'
>    s390x-linux-ld: cgroup-v1.c:(.text+0x1d72): undefined reference to `__tsan_memset'
>    s390x-linux-ld: cgroup-v1.c:(.text+0x1e7a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup1_parse_param':
>    cgroup-v1.c:(.text+0x1fa0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup1_reconfigure':
>    cgroup-v1.c:(.text+0x2640): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/cgroup/freezer.o: in function `cgroup_freeze':
>    freezer.c:(.text+0x123c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/legacy_freezer.o: in function `freezer_read':
>    legacy_freezer.c:(.text+0x956): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cgroup/legacy_freezer.o: in function `freezer_apply_state':
>    legacy_freezer.c:(.text+0x1834): undefined reference to `__tsan_memset'
>    s390x-linux-ld: legacy_freezer.c:(.text+0x18da): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/kheaders.o: in function `ikheaders_read':
>    kheaders.c:(.text+0x3a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/stop_machine.o: in function `stop_one_cpu':
>    stop_machine.c:(.text+0x70): undefined reference to `__tsan_memset'
>    s390x-linux-ld: stop_machine.c:(.text+0x82): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/stop_machine.o: in function `cpu_stop_init_done':
>    stop_machine.c:(.text+0x110): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/stop_machine.o: in function `stop_two_cpus':
>    stop_machine.c:(.text+0x334): undefined reference to `__tsan_memset'
>    s390x-linux-ld: stop_machine.c:(.text+0x3b8): undefined reference to `__tsan_memset'
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 
