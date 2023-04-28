Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877386F2106
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346860AbjD1Wp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346502AbjD1Wp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:45:26 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739DA2137
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:45:24 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-77a9c5b6aa6so132838241.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682721922; x=1685313922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDeu5aaOiZPNvFFpKasxGsuP4WSAZ9aS6rbGwWquBHo=;
        b=aWqLI6RstbefS4wTjrZLlZWehgdt7FU1i+wI9BMT61oqSE+I2AIU5kfTAFVl8F0KXm
         uw/nt8EUfqSjoSGxOzS3Qj+HA4jMNLrWGLoQHca+XRR0EkZCcgqn6tkB//6h71XirO3P
         lEjszS++X7WmyHqZzzjyhWdZHGXQEkYKxUZLAEMVQbyEDm2r+hM++ZLmg7SiOCS9U+kN
         m99d1TrvvY8nmz3A+CqXj/8OdmSyP45X7LL1kFQPlrbWpA0UZSOG6snBj9rQnLv7Sykg
         7RWUgvotQ4IA2JQIoFaaFowJu+Rc77xjBO2BNUSn/x+RbFaZvOq5qC58+N2+dMiExfOF
         CKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682721922; x=1685313922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDeu5aaOiZPNvFFpKasxGsuP4WSAZ9aS6rbGwWquBHo=;
        b=UvCFzzkQWqibuBQqlVzm30sQMRZQwJVympQU4rQXy+h6iFeBJvqqnhVP+8cg6l/vRb
         Z/dYqIfZi+B+Xi3lMH3EMqFtEO3p/f06Mt9u28SMS34384QR0w9siFP1xN5Hq/dIMPbt
         Gqou64NpGLTJprq0NPpvj1pO5mrXGFqkZoqpLsK/CmjsnvOESQxOGjf7s7EWgVFSMhLn
         lDBd30kke4o7Cblzs2egRys3GK83kM399O/KYkpcER0msDqBwc6aLJDE31G9Vne9ZbMM
         SVlXeUmqQuglo6Ms2VIxQOWHIEzFpGKFsP+Oxn+E5Gh/+MCevnMrfRq62ZepCUq5p5AP
         k7rw==
X-Gm-Message-State: AC+VfDxdrTZWaM6OyWSL876MvrTR3+jBbwJumY+dh1q1bdYre61RZF5N
        N2cAvLqu/T6XhqwOtuxG95WkGUzrEuzW2EQ35N1lUg==
X-Google-Smtp-Source: ACHHUZ6PsVYrO/G2gFMEr9pZJE7D0RfhO5SYwUpvCgBZowyQI5cbRSA7hJh64XVuXfZCqXUaK2UC4mtgWbo+Br0Kfvk=
X-Received: by 2002:a05:6102:c4:b0:42e:6a3e:9072 with SMTP id
 u4-20020a05610200c400b0042e6a3e9072mr3262224vsp.25.1682721922318; Fri, 28 Apr
 2023 15:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230428112039.133978540@linuxfoundation.org>
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Apr 2023 23:45:11 +0100
Message-ID: <CA+G9fYsP58FUqHmmVJ7Oa3JthKzSEJbW=mpFN9M5-2NN75OVDQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/13] 5.15.110-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 at 12:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.110 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.110-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm64 juno while LTP controllers testing with 5.15 kernel.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

This is not always reproducible.

Crash log:
----------
[ 5059.396958] Unable to handle kernel execute from non-executable
memory at virtual address ffff80000a63eb34
[ 5059.397002] BUG: Bad rss-counter state mm:00000000f95cf07e
type:MM_FILEPAGES val:352
[ 5059.406643] Mem abort info:
[ 5059.406648]   ESR =3D 0x000000008600000f
[ 5059.414403] BUG: Bad rss-counter state mm:00000000f95cf07e
type:MM_ANONPAGES val:1201
[ 5059.417192]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
[ 5059.420945] BUG: non-zero pgtables_bytes on freeing mm: 45056
[ 5059.428782]   SET =3D 0, FnV =3D 0
[ 5059.442901]   EA =3D 0, S1PTW =3D 0
[ 5059.446045]   FSC =3D 0x0f: level 3 permission fault
[ 5059.450843] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000081e710=
00
[ 5059.457557] [ffff80000a63eb34] pgd=3D10000009fffff003,
p4d=3D10000009fffff003, pud=3D10000009ffffe003, pmd=3D10000009ffffa003,
pte=3D007800008283e703
[ 5059.470128] Internal error: Oops: 8600000f [#1] PREEMPT SMP
[ 5059.475708] Modules linked in: btrfs blake2b_generic libcrc32c xor
xor_neon zstd_compress raid6_pq cfg80211 bluetooth rfkill tda998x cec
drm_kms_helper crct10dif_ce drm fuse
[ 5059.491254] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.15.110-rc1 #1
[ 5059.497706] Hardware name: ARM Juno development board (r2) (DT)
[ 5059.503632] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[ 5059.510605] pc : cpu_idle_force_poll+0x0/0x4
[ 5059.514887] lr : cpu_idle_force_poll+0x0/0x4
[ 5059.519162] sp : ffff80000acf3de0
[ 5059.522476] x29: ffff0008002e8f80 x28: 0000000000000000 x27: 00000000000=
00000
[ 5059.529629] x26: 0000000000000002 x25: ffff000822032880 x24: ffff00097ef=
62f00
[ 5059.536780] x23: ffff80000a63eb64 x22: 0000000000000000 x21: 00000000000=
00000
[ 5059.543931] x20: 0000000000000000 x19: 0000000000000000 x18: 00000000000=
00000
[ 5059.551081] x17: 000000040044ffff x16: 00500074b5503510 x15: 00000000000=
00000
[ 5059.558232] x14: ffff0008002e8f80 x13: ffff8009750eb000 x12: 0000000034d=
4d91d
[ 5059.565383] x11: 0000000000000000 x10: 0000000000001000 x9 : ffff8000092=
52da4
[ 5059.572533] x8 : 00000074b5503510 x7 : 00000074b5503510 x6 : 00000000001=
6e360
[ 5059.579684] x5 : 0000000000000003 x4 : 0000000000000000 x3 : ffff00097ef=
62f40
[ 5059.586835] x2 : 0000000000000002 x1 : 00000000002625a0 x0 : 00000000000=
00001
[ 5059.593986] Call trace:
[ 5059.596430]  cpu_idle_force_poll+0x0/0x4
[ 5059.600361] Code: 00000001 00000001 00000020 037e563b (00000000)
[ 5059.606463] ---[ end trace f19c34443506e9b1 ]---
[ 5059.611085] Kernel panic - not syncing: Attempted to kill the idle task!
[ 5059.617794] SMP: stopping secondary CPUs
[ 5060.733718] SMP: failed to stop secondary CPUs 1-2
[ 5060.738514] Kernel Offset: disabled
[ 5060.742002] CPU features: 0x800830f1,00000846
[ 5060.746362] Memory Limit: none
[ 5060.749418] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---

log:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5=
.15.105-361-g64fb7ad7e758/testrun/16607331/suite/log-parser-test/test/check=
-kernel-bug/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5=
.15.105-361-g64fb7ad7e758/testrun/16607331/suite/log-parser-test/tests/

## Build
* kernel: 5.15.110-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 64fb7ad7e758c85ebeb0c8c500e4175c65bf5778
* git describe: v5.15.105-361-g64fb7ad7e758
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.105-361-g64fb7ad7e758

## Test Regressions (compared to v5.15.105-347-g579deb859f24)

* juno-r2, log-parser-test
  - check-kernel-bug
  - check-kernel-oops
  - check-kernel-panic

## Metric Regressions (compared to v5.15.105-347-g579deb859f24)

## Test Fixes (compared to v5.15.105-347-g579deb859f24)

## Metric Fixes (compared to v5.15.105-347-g579deb859f24)

## Test result summary
total: 123779, pass: 99490, fail: 3473, skip: 20591, xfail: 225

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 112 total, 111 passed, 1 failed
* arm64: 40 total, 38 passed, 2 failed
* i386: 30 total, 28 passed, 2 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 31 passed, 2 failed

## Test suites summary
* boot
* fwts
* igt-gpu-tools
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
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
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
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
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
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
