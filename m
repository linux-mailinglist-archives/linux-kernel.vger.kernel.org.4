Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121CA70559C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjEPSEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEPSEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:04:10 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D83D5FCF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:04:08 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-43604f20944so7246613137.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684260247; x=1686852247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vvzg25v2oIEfNdNdkr9ntW85A+SET9yRI5a0pRi7L/0=;
        b=sEdkWnYfz1zslsG4WM18jSxyezgQrNq463fZoa8yCdWUxYbfMTl0vdCbxMmpaTSNub
         u6qn2ZO84qSn6oRYdupCOT6b2cNJSzhwxup1lB4OIFwpwUJPfgXrRwQa32vpPgTPpDSH
         bH6XrJinPH8xYTT8EW6qgBaCo2RYV+gQ1es7P6Xn6mgUZpK6fAAoqDlqe0IeCd4Ty8C1
         kdIDNyMqLmVdhvImg8TMZNqpDQozc1sma2EyiW2XUpcxH65NLDr6+GHP8ZKFYyWEricc
         FnH1efXODtqTImOEADh97BKcJvJlJPNw3+eMqQwWeCuAME/rHjTZ9QSJ06rBndqllLn7
         3TKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684260247; x=1686852247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vvzg25v2oIEfNdNdkr9ntW85A+SET9yRI5a0pRi7L/0=;
        b=P/mCYFB1I59IJyk7rJvqe4xhNbFHzr3t2VClhHE9JVmJJa/dT79r+4E/8b4wjZkzmv
         t5hDcs0gqsn/ISUYFObDQJ7RXEMHKIYeASUav8aMiTzbirQ0aCAvz0mjn7lkw7j3HpJA
         IeJUt4OXtSZiq+bbL9vre//J1N2lRtW6k+cnGkE7cUMmdQ0IPWk/ujn6gTOBnPiSXAr0
         J4jWRRfO2AbAa3IpNtofTO4ifwG2AnxjTFGSayex3PCDCv/tgm8dMW0Sz1bwBeEnCMJo
         Z4iZhw3m7Zkp7gpaRjYVxC5jub95GllsMPs4MYf4lUmh9plgNw9oi+vXpcdJqY0zJ13h
         a1Lg==
X-Gm-Message-State: AC+VfDzcMt7zIZc22HUXha+oK3aqDQL2ZObYMKnIngbWMUeuaZjows0H
        0RE2sFZKl+Zdy8CjbX8O9C7DUyZzkIRR/BCRUMkXiA==
X-Google-Smtp-Source: ACHHUZ4dCOV4LauCVxAwh+D6cPCaNzdjf9tHbKfIBWRaLaT+SOP3CuFj1esRSO97triBxPPZXU/cNH8fWdGrpVBvIVQ=
X-Received: by 2002:a05:6102:3cd:b0:42e:63a5:b711 with SMTP id
 n13-20020a05610203cd00b0042e63a5b711mr16338138vsq.10.1684260247144; Tue, 16
 May 2023 11:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230515161736.775969473@linuxfoundation.org>
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 May 2023 23:33:55 +0530
Message-ID: <CA+G9fYsCjQPQxde3-vw6SKmPPr16Gy4-P4uOCh7r6iEDwDpf9w@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
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

On Mon, 15 May 2023 at 23:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.180 release.
> There are 381 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.180-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64 and i386.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

We have recently upgraded our selftest sources to stable-rc 6.3 and
running on stable rc 6.1, 5.15, 5.10, 5.4, 4.19 and 4.14 kernels.

List of test regressions:
=3D=3D=3D=3D=3D=3D=3D=3D
kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

kselftest-memfd
  - memfd_memfd_test

kselftest-rseq
  - rseq_basic_test

 kselftest-kvm
  - kvm_xapic_state_test


NOTE:
The logs are the same as reported on other email reports.
link,
 - https://lore.kernel.org/stable/CA+G9fYu6ZOu_We2GMP0sFnSovOsqd6waW7oKS-Y1=
VPrjdibu5Q@mail.gmail.com/

## Build
* kernel: 5.10.180-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 065b6901e6dab7dcc7c8884779b96269724c7201
* git describe: v5.10.179-382-g065b6901e6da
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.179-382-g065b6901e6da

## Test Regressions (compared to v5.10.176-363-g1ef2000b94cb)
* bcm2711-rpi-4-b, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* bcm2711-rpi-4-b, kselftest-memfd
  - memfd_memfd_test

* bcm2711-rpi-4-b, kselftest-rseq
  - rseq_basic_test

* dragonboard-410c, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* dragonboard-410c, kselftest-memfd
  - memfd_memfd_test

* i386, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* i386, kselftest-memfd
  - memfd_memfd_test

* i386, kselftest-rseq
  - rseq_basic_test
  - rseq_run_param_test_sh

* juno-r2, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* juno-r2, kselftest-memfd
  - memfd_memfd_test

* juno-r2, kselftest-rseq
  - rseq_basic_test

* qemu_i386, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* qemu_i386, kselftest-memfd
  - memfd_memfd_test

* qemu_i386, kselftest-rseq
  - rseq_basic_test
  - rseq_run_param_test_sh

* qemu_x86_64, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* qemu_x86_64, kselftest-memfd
  - memfd_memfd_test

* qemu_x86_64, kselftest-rseq
  - rseq_basic_test
  - rseq_run_param_test_sh

* x15, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* x15, kselftest-rseq
  - rseq_basic_test

* x86, kselftest-kvm
  - kvm_xapic_state_test

* x86, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* x86, kselftest-memfd
  - memfd_memfd_test

* x86, kselftest-rseq
  - rseq_basic_test
  - rseq_run_param_test_sh

## Metric Regressions (compared to v5.10.176-363-g1ef2000b94cb)

## Test Fixes (compared to v5.10.176-363-g1ef2000b94cb)

## Metric Fixes (compared to v5.10.176-363-g1ef2000b94cb)

## Test result summary
total: 126856, pass: 105919, fail: 3576, skip: 17174, xfail: 187

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 42 passed, 3 failed
* i386: 35 total, 33 passed, 2 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 26 total, 20 passed, 6 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 36 passed, 2 failed

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
* kselftest-sigaltstack
* kselftest-size
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
