Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB08744810
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGAIeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGAIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:34:01 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B217137
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:33:59 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-471b3ad20e1so751699e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688200438; x=1690792438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcNvbuaIlv1gwLBFKc6vhXussHqO67ZMr6Hh1pCp9v8=;
        b=xpHa5oNjpdiUPZaBjlyQSkonXJukLriMNTdoNWvJBDnrmgi9Ue1wN3oZ1rOOmiXqQB
         R93fSykFhExR15JVkY5sijLzK9PWwKAf0qTPf9Efoo/S42kGPuZEbM/j62LE7hjm/DOO
         kFb8kYe2XT80ZCxaO9Js3pCpKrn5YCpamnscT02XCxhjSILUeniTJfV4zJm4fDuPym8C
         w+cv0zMNb6+As+pe6Tr3TzXp1YEdJv3AhTzO5E5+9BT5AbW5ZhPMCyfcORoWuDQafK+Y
         IJyNdMLr+PqvkdOqVgIOf7kLqMsBm2Iw/7ahQIas5bj4jmTKHns+1Rf+BH0co1RELZef
         B89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688200438; x=1690792438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcNvbuaIlv1gwLBFKc6vhXussHqO67ZMr6Hh1pCp9v8=;
        b=Ts+oAaENHT+J3RZCI0PVGKPzpicMK/JzGi3PeHftZCPuDQxWijRw+oJhR1UUnGgJFP
         icVJ+XQ65hnC4Ak1DjNh5TP26tpQetXcBpBrgyhxP6Y7wukXj+mkacgyK3XuIOjavTEj
         C9BsH3gLL5CFR1l6JtCLVPFKPD3yoVStTDV/KbpCPqmvLT5Ilj2yz9p1lRe2FFrEDh/M
         1P6SwDmUsj977mS7Cs6uQnHzwK2hTrxPMxNFWEd+gZ3zqfkHQH/Btg9A/bKTe1bxjTye
         syq/VPnOZpeq42qqUsTc616VFAnlmTmyZBODW099WjxygIydxyx+J3tqS/Mj48SU68YZ
         QOxQ==
X-Gm-Message-State: ABy/qLYLcRXMPJJD3lpIA3P65eZMoq2T7zNaRsZU6uE8L0QmhV+94gCH
        4Q/yQV53C8y7EP3t5plAHJofCjCc7HPlF8vZPiD/8w==
X-Google-Smtp-Source: APBJJlH0I2HYlfuH3kSTq1UWWc6XFX1mtdGexglzmNqAupVxlQPg6qeFOIiFPhjGcJ/vJcP+Rs5qP5NQX/KaaQQedx0=
X-Received: by 2002:a67:f6d6:0:b0:443:62c2:7f4f with SMTP id
 v22-20020a67f6d6000000b0044362c27f4fmr2011479vso.32.1688200438090; Sat, 01
 Jul 2023 01:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230630072101.040486316@linuxfoundation.org>
In-Reply-To: <20230630072101.040486316@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 1 Jul 2023 14:03:46 +0530
Message-ID: <CA+G9fYt=rW=3+YK5wB9+6Mo9Sy7WuGSw1dWyvUJ3F1cq8YMDPg@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/31] 6.4.1-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 at 13:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.1 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Jul 2023 07:20:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.1-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
NOTE:
1) Following kernel BUG noticed while booting and running KASAN /
KFENCE testing on
qemu-arm64 and qemu-x86_64. This is always reproducible.

Boot log:
=3D=3D=3D=3D=3D=3D=3D=3D=3D

<6>[  508.503587]     KTAP version 1
<6>[  508.504164]     # Subtest: input_core
<6>[  508.505615]     1..3
<6>[  508.514268] input: Test input device as /devices/virtual/input/input1
<3>[  508.533860]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<3>[  508.535501] BUG: KASAN: slab-use-after-free in input_free_device+0x20=
/0x74
<3>[  508.537680] Read of size 1 at addr ffff0000c60dd548 by task
kunit_try_catch/471
<3>[  508.539159]
<3>[  508.540334] CPU: 1 PID: 471 Comm: kunit_try_catch Tainted: G
            N 6.4.1-rc3 #1
<3>[  508.542035] Hardware name: linux,dummy-virt (DT)
<3>[  508.543528] Call trace:
<3>[  508.544275]  dump_backtrace+0x94/0x100
<3>[  508.545430]  show_stack+0x18/0x24
<3>[  508.546378]  dump_stack_lvl+0x48/0x60
<3>[  508.547602]  print_report+0xf8/0x5c0
<3>[  508.548600]  kasan_report+0x78/0xc0
<3>[  508.549629]  __asan_load1+0x60/0x6c
<3>[  508.550799]  input_free_device+0x20/0x74
<3>[  508.551884]  input_test_exit+0x2c/0x3c
<3>[  508.553028]  kunit_try_run_case+0x94/0x118
<3>[  508.554249]  kunit_generic_run_threadfn_adapter+0x30/0x4c
<3>[  508.555496]  kthread+0x1d4/0x1e4
<3>[  508.556452]  ret_from_fork+0x10/0x20
<3>[  508.558125]
<3>[  508.558816] Allocated by task 471:
<4>[  508.559974]  kasan_save_stack+0x2c/0x54
<4>[  508.561120]  kasan_set_track+0x2c/0x40
<4>[  508.562131]  kasan_save_alloc_info+0x24/0x34
<4>[  508.563206]  __kasan_kmalloc+0xa0/0xb8
<4>[  508.564204]  kmalloc_trace+0x54/0x68
<4>[  508.565387]  input_allocate_device+0x30/0x164
<4>[  508.566523]  input_test_init+0x94/0x1c4
<4>[  508.567540]  kunit_try_run_case+0x60/0x118
<4>[  508.568615]  kunit_generic_run_threadfn_adapter+0x30/0x4c
<4>[  508.569927]  kthread+0x1d4/0x1e4
<4>[  508.570869]  ret_from_fork+0x10/0x20
<3>[  508.571923]
<3>[  508.572538] Freed by task 471:
<4>[  508.573365]  kasan_save_stack+0x2c/0x54
<4>[  508.574404]  kasan_set_track+0x2c/0x40
<4>[  508.575376]  kasan_save_free_info+0x38/0x60
<4>[  508.576452]  __kasan_slab_free+0xe8/0x154
<4>[  508.577537]  __kmem_cache_free+0x194/0x360
<4>[  508.578423]  kfree+0x60/0x74
<4>[  508.579332]  input_dev_release+0x64/0x80
<4>[  508.580610]  device_release+0x94/0x10c
<4>[  508.581712]  kobject_put+0xe0/0x184
<4>[  508.582682]  put_device+0x14/0x24
<4>[  508.583595]  input_unregister_device+0x78/0x90
<4>[  508.584664]  input_test_exit+0x24/0x3c
<4>[  508.585797]  kunit_try_run_case+0x94/0x118
<4>[  508.586839]  kunit_generic_run_threadfn_adapter+0x30/0x4c
<4>[  508.588072]  kthread+0x1d4/0x1e4
<4>[  508.589121]  ret_from_fork+0x10/0x20
<3>[  508.590175]
<3>[  508.591009] The buggy address belongs to the object at ffff0000c60dd0=
00
<3>[  508.591009]  which belongs to the cache kmalloc-2k of size 2048
<3>[  508.593404] The buggy address is located 1352 bytes inside of
<3>[  508.593404]  freed 2048-byte region [ffff0000c60dd000, ffff0000c60dd8=
00)
<3>[  508.595234]
<3>[  508.596225] The buggy address belongs to the physical page:
<4>[  508.597748] page:00000000c20b6f30 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x1060d8
<4>[  508.599925] head:00000000c20b6f30 order:3 entire_mapcount:0
nr_pages_mapped:0 pincount:0
<4>[  508.601649] flags:
0xbfffc0000010200(slab|head|node=3D0|zone=3D2|lastcpupid=3D0xffff)
<4>[  508.603059] page_type: 0xffffffff()
<4>[  508.604620] raw: 0bfffc0000010200 ffff0000c0002900
dead000000000122 0000000000000000
<4>[  508.606267] raw: 0000000000000000 0000000080080008
00000001ffffffff 0000000000000000
<4>[  508.607742] page dumped because: kasan: bad access detected
<3>[  508.608610]
<3>[  508.609452] Memory state around the buggy address:
<3>[  508.611047]  ffff0000c60dd400: fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb fb
<3>[  508.612333]  ffff0000c60dd480: fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb fb
<3>[  508.613892] >ffff0000c60dd500: fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb fb
<3>[  508.615057]                                               ^
<3>[  508.616277]  ffff0000c60dd580: fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb fb
<3>[  508.618324]  ffff0000c60dd600: fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb fb
<3>[  508.619628]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<4>[  508.621915] Disabling lock debugging due to kernel taint

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.=
4-32-g94976aa9d87c/testrun/18006002/suite/log-parser-boot/test/check-kernel=
-bug/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.=
4-32-g94976aa9d87c/testrun/18006002/suite/log-parser-boot/tests/

2) Build warnings on x86 with KCSAN config enabled with clang 16 tool chain=
.

* x86_64, build
  - clang-16-lkftconfig-kcsan-warnings

vmlinux.o: warning: objtool: ibt_selftest+0x14: sibling call from
callable instruction with modified stack frame
vmlinux.o: warning: objtool: ibt_selftest+0x1e: return with modified stack =
frame
vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x27: relocation to
!ENDBR: .text+0x1b63c6
vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3d: relocation to
!ENDBR: .text+0x1b622c

Link:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2RurEsG9Cn0pVN7kl=
R71yKdp57r/

## Build
* kernel: 6.4.1-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 94976aa9d87c63c78bc4d660382977fcf89d2921
* git describe: v6.4-32-g94976aa9d87c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4-3=
2-g94976aa9d87c/

## Test Regressions (compared to v6.4)

## Metric Regressions (compared to v6.4)

## Test Fixes (compared to v6.4)

## Metric Fixes (compared to v6.4)

## Test result summary
total: 188717, pass: 153596, fail: 3192, skip: 31929

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* boot
* fwts
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
