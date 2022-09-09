Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8405B3720
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIIMIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiIIMIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:08:15 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77683128C05
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:08:13 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t184so2360764yba.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9eo0O+oisX+ZKEctyYEq1GZOppdKmxJ/zNX7cz0mcds=;
        b=eVy4XOVBTnBF3IjRrpnh/Pt74A6QldQcpp2MHekAsFk/AAjp+qAZklAZ/v/uS3wTS1
         mbK10JpHCT/pxAEnQVT7DjUwO4fogFNPG47lQo9ItuM/5/+A8M7iY+JVePadqld4Fl1I
         dJaC6doWm3MD1lrTaGRA2F0m+YZX+9QFmnNIIpm9ctmXDIXnAXFPYNr4WZ30OM3lDDF9
         SQAmH50tS0ivmuOIeo0nB/8e4yFNz/VH6uFCVkaUaeCl2q3Ll0oG5dxJgjyjOfYR0mXe
         GwN49pMm5RqjBQjjFRIS31XzfLWjJnQZrYOK6fJqD1F+E4szzmg/cmm+Qs/RvmrfVyHo
         +6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9eo0O+oisX+ZKEctyYEq1GZOppdKmxJ/zNX7cz0mcds=;
        b=T2Tkh63PU8tqxcj7QekooKXQovJoVmlQgHeNWpbFRUSgWPt3/Ql0vE1VEaejaWHvdr
         FY5BlHi97MZWjyBe93g8+CHLoh/zJ5EfngOVKSa5D6wirI+hyxEzkRGrLpcFvIZYeF1x
         lffsQRYfLhyMxNHcXtokvNZ/tNwzAPTNsnt+F+xQqXlQb0PLQ/cIhkHzSQyC4BqAMZuN
         FY4qGwRqP6WYOfUedD0pj0NYs2urQRo/TTVBn2rOVzRtpfbDhxNprYixWY8zGZvwFUSB
         hAlxXh/1N3Rom7AqRXssj5epgjWqYyVNeQo0t6H242F6a/o1Mmhxv3+hLG2rc1zJhoKa
         tjxA==
X-Gm-Message-State: ACgBeo3mplZ6xUGtJkt6YvFUGUnNPQ1Ut7sy8tqREFLEPinvtjm0iSLv
        mymjiYdvEBmrdWpFfCcL+GWWPzC57GbXbM9cyMxD7gIYKOjZzQ==
X-Google-Smtp-Source: AA6agR49nJ0QplWEX2xxNtZSfhgRrDwMAiotUBWR2GAdLxl30X4PLhNHt6KnDJc6ByU46llJzZkB/Z8QK/k0N/ha7jU=
X-Received: by 2002:a25:556:0:b0:6a8:bf73:9c42 with SMTP id
 83-20020a250556000000b006a8bf739c42mr10766581ybf.584.1662725292036; Fri, 09
 Sep 2022 05:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <202209091909.o5AIdvoX-lkp@intel.com>
In-Reply-To: <202209091909.o5AIdvoX-lkp@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 9 Sep 2022 14:07:35 +0200
Message-ID: <CANpmjNPgaJ1HhW+siCvZTxBGc2DRsCSkTTtZWiFfjcb2k8iijA@mail.gmail.com>
Subject: Re: main.c:undefined reference to `__tsan_memset'
To:     kernel test robot <lkp@intel.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is being fixed:
https://lore.kernel.org/all/20220909073840.45349-2-elver@google.com/

This is an unreleased version of Clang, so not an urgent issue.

On Fri, 9 Sept 2022 at 13:59, kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   506357871c18e06565840d71c2ef9f818e19f460
> commit: e37b3dd063a1a68e28a7cfaf77c84c472112e330 s390: enable KCSAN
> date:   1 year, 1 month ago
> config: s390-randconfig-r044-20220909
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e37b3dd063a1a68e28a7cfaf77c84c472112e330
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e37b3dd063a1a68e28a7cfaf77c84c472112e330
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    s390x-linux-ld: init/main.o: in function `trace_event_raw_event_initcall_level':
> >> main.c:(.text+0x1ea): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/main.o: in function `trace_event_raw_event_initcall_start':
>    main.c:(.text+0x2fa): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/main.o: in function `trace_event_raw_event_initcall_finish':
>    main.c:(.text+0x3ce): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/main.o: in function `do_one_initcall':
> >> (.text+0x4c0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: (.text+0x4d2): undefined reference to `__tsan_memset'
>    s390x-linux-ld: (.text+0x83c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: init/main.o: in function `init_setup':
> >> main.c:(.init.text+0x1ba): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/main.o: in function `rdinit_setup':
>    main.c:(.init.text+0x20e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/main.o: in function `unknown_bootoption':
> >> main.c:(.init.text+0xd84): undefined reference to `__tsan_memmove'
>    s390x-linux-ld: init/main.o: in function `set_init_arg':
>    main.c:(.init.text+0x11ea): undefined reference to `__tsan_memmove'
>    s390x-linux-ld: init/do_mounts.o: in function `name_to_dev_t':
> >> do_mounts.c:(.text+0x26e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/do_mounts.o: in function `mount_block_root':
> >> do_mounts.c:(.init.text+0x2ee): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/do_mounts_rd.o: in function `identify_ramdisk_image':
> >> do_mounts_rd.c:(.init.text+0x59c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/initramfs.o: in function `panic_show_mem':
> >> initramfs.c:(.text+0xfc): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/initramfs.o: in function `do_populate_rootfs':
> >> initramfs.c:(.init.text+0x384): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/initramfs.o: in function `do_collect':
> >> initramfs.c:(.init.text+0xf46): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: init/initramfs.o: in function `do_name':
>    initramfs.c:(.init.text+0x1558): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/initramfs.o: in function `do_copy':
>    initramfs.c:(.init.text+0x1a06): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/initramfs.o: in function `do_symlink':
>    initramfs.c:(.init.text+0x1d44): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/initramfs.o: in function `parse_header':
>    initramfs.c:(.init.text+0x1fc8): undefined reference to `__tsan_memset'
>    s390x-linux-ld: init/initramfs.o: in function `maybe_link':
>    initramfs.c:(.init.text+0x2234): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/time.o:time.c:(.text+0x938): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: arch/s390/kernel/time.o: in function `leap_seconds_scheduled_show':
> >> time.c:(.text+0x17ea): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/time.o: in function `time_early_init':
> >> (.init.text+0x28): undefined reference to `__tsan_memset'
>    s390x-linux-ld: (.init.text+0x3a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/time.o: in function `read_persistent_wall_and_boot_offset':
>    (.init.text+0x30e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: (.init.text+0x332): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/process.o: in function `arch_dup_task_struct':
> >> process.c:(.text+0x1b8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/process.o: in function `copy_thread':
> >> process.c:(.text+0x254): undefined reference to `__tsan_memset'
> >> s390x-linux-ld: process.c:(.text+0x290): undefined reference to `__tsan_memset'
>    s390x-linux-ld: process.c:(.text+0x354): undefined reference to `__tsan_memset'
> >> s390x-linux-ld: process.c:(.text+0x41a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: process.c:(.text+0x4a4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/process.o: in function `get_wchan':
>    process.c:(.text+0x57c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/early.o: in function `startup_init':
> >> early.c:(.init.text+0x30e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/early.o: in function `setup_facility_list':
> >> early.c:(.init.text+0x410): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/early.o: in function `setup_arch_string':
>    early.c:(.init.text+0x51a): undefined reference to `__tsan_memset'
> >> s390x-linux-ld: early.c:(.init.text+0x52c): undefined reference to `__tsan_memset'
> >> s390x-linux-ld: early.c:(.init.text+0x652): undefined reference to `__tsan_memmove'
>    s390x-linux-ld: early.c:(.init.text+0x6d2): undefined reference to `__tsan_memmove'
>    s390x-linux-ld: early.c:(.init.text+0x80a): undefined reference to `__tsan_memmove'
>    s390x-linux-ld: early.c:(.init.text+0x88a): undefined reference to `__tsan_memmove'
>    s390x-linux-ld: arch/s390/kernel/setup.o: in function `relocate_dma_section':
>    setup.c:(.init.text+0xa22): undefined reference to `__tsan_memmove'
>    s390x-linux-ld: setup.c:(.init.text+0xa42): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/setup.o: in function `setup_resources':
>    setup.c:(.init.text+0x1372): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/setup.o: in function `setup_lowcore_dat_off':
>    setup.c:(.init.text+0x194a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/setup.o: in function `conmode_default':
>    setup.c:(.init.text+0x1b62): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/idle.o: in function `account_idle_time_irq':
>    idle.c:(.text+0x3e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/idle.o: in function `arch_cpu_idle':
>    idle.c:(.text+0x2a8): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/vtime.o: in function `do_account_vtime':
>    vtime.c:(.text+0x2d4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: vtime.c:(.text+0x4c8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/syscall.o: in function `__se_sys_mmap2':
>    syscall.c:(.text+0x40): undefined reference to `__tsan_memset'
>    s390x-linux-ld: syscall.c:(.text+0x116): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/ptrace.o: in function `update_cr_regs':
>    ptrace.c:(.text+0x3c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: ptrace.c:(.text+0x4e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/ptrace.o: in function `ptrace_disable':
>    ptrace.c:(.text+0x3de): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/ptrace.o:ptrace.c:(.text+0x458): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: arch/s390/kernel/ptrace.o: in function `s390_regs_get':
>    ptrace.c:(.text+0x1774): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/ptrace.o: in function `s390_fpregs_get':
>    ptrace.c:(.text+0x1ea2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: ptrace.c:(.text+0x1f02): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: ptrace.c:(.text+0x20a2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/ptrace.o: in function `s390_fpregs_set':
>    ptrace.c:(.text+0x2162): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/ptrace.o:ptrace.c:(.text+0x2356): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: arch/s390/kernel/ptrace.o: in function `s390_gs_cb_set':
>    ptrace.c:(.text+0x3574): undefined reference to `__tsan_memset'
>    s390x-linux-ld: ptrace.c:(.text+0x35ce): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: ptrace.c:(.text+0x3690): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: ptrace.c:(.text+0x36e4): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/ptrace.o: in function `s390_gs_bc_get':
>    ptrace.c:(.text+0x385e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/ptrace.o: in function `s390_gs_bc_set':
>    ptrace.c:(.text+0x39ba): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/ptrace.o:ptrace.c:(.text+0x3ae0): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: arch/s390/kernel/ptrace.o: in function `s390_runtime_instr_set':
>    ptrace.c:(.text+0x3b64): undefined reference to `__tsan_memset'
>    s390x-linux-ld: ptrace.c:(.text+0x3bc4): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: ptrace.c:(.text+0x3c80): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: ptrace.c:(.text+0x3de2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/signal.o: in function `__s390x_sys_sigreturn':
>    signal.c:(.text+0xca): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: signal.c:(.text+0x220): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/signal.o:signal.c:(.text+0x242): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: arch/s390/kernel/signal.o: in function `__s390x_sys_sigreturn':
>    signal.c:(.text+0x43a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/signal.o: in function `__s390x_sys_rt_sigreturn':
>    signal.c:(.text+0x87a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: signal.c:(.text+0x9d0): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: signal.c:(.text+0x9f2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: signal.c:(.text+0xa3e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: signal.c:(.text+0xbea): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/signal.o: in function `arch_do_signal_or_restart':
>    signal.c:(.text+0xf80): undefined reference to `__tsan_memset'
>    s390x-linux-ld: signal.c:(.text+0x155a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: signal.c:(.text+0x15b2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: signal.c:(.text+0x15d6): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: signal.c:(.text+0x161c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: signal.c:(.text+0x187c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/signal.o:signal.c:(.text+0x18d6): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: arch/s390/kernel/cpcmd.o: in function `__cpcmd':
>    cpcmd.c:(.text+0xe2): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/cpcmd.o: in function `cpcmd':
>    cpcmd.c:(.text+0x296): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: cpcmd.c:(.text+0x2ea): undefined reference to `__tsan_memset'
>    s390x-linux-ld: cpcmd.c:(.text+0x38e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: cpcmd.c:(.text+0x3b4): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: cpcmd.c:(.text+0x412): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/nmi.o: in function `__s390_handle_mcck':
>    nmi.c:(.text+0x1ee): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_hex_ascii_format_fn':
>    debug.c:(.text+0x194): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_sprintf_format_fn':
>    debug.c:(.text+0x4d6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_event_common':
>    (.text+0x1b58): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: (.text+0x1b88): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_exception_common':
>    (.text+0x2066): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: (.text+0x2092): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/debug.o: in function `__debug_sprintf_event':
>    (.text+0x23b8): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/debug.o: in function `__debug_sprintf_exception':
>    (.text+0x2a18): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_info_alloc':
>    debug.c:(.text+0x34f4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/debug.o: in function `debug_prolog_level_fn':
>    debug.c:(.text+0x389e): undefined reference to `__tsan_memcpy'
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
