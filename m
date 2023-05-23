Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7164F70E23B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjEWQhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjEWQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:37:04 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625A4185
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:36:57 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-783f1443b70so2484906241.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684859816; x=1687451816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VH/bj/vFsonSvfQ9d0PiamHB4y93f7MSPfGXexLIWoQ=;
        b=ijegsW2lBlnb8/8bH0QRUTePucDSzy5rVpsOwB1sR0JbeHqIRgUbCzrSYJITxuJZCk
         HCbzhj1mYT4Ni14xGFgc7yl4oDGXxNZeqW9ohC87YL9dA4L9jg9+4V0x5TGQlo4Y3LSf
         KUxHitHXewfG+pvHqPyZLZxwR3lp6uOma42S7pJ1bSoQeMQCbpXKbiwMGKRgkrUVRSVG
         dZPYPFlazrPUGVssIrwWO1X0hUZOA9+1l9h4wvqLXurr3Qb9oCmnz0X1KZO6CaZnPMd8
         3/Z9glkHsPqX79G5uStvzqKuRr15gTO5G4GPOUkEVTSFtRVWcv5o+44aguapppkM4YU0
         PyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684859816; x=1687451816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH/bj/vFsonSvfQ9d0PiamHB4y93f7MSPfGXexLIWoQ=;
        b=TnZ+oM5wLeFmlyLwrT0hRRQHJuLAn5HXaS1wKJpFrvG6KMYFqrv9HCE7X3iseg6/yq
         3QBsTgvMFi3zc0yMkOkDZVKRMvyQMxCcNYQD2+5sHSieQeyj2qA7y7he4U1hbHD+AGVX
         RMo3t3to9PROkG4nuu19TMivBP0Gxx05+BJgGZNMbAKsvm3GV2YplAjYYXIlBXkKYmck
         WSoWTSAjrzxt6AjABibnrgSJeY6o5W2+QEi5Ttvwh/8l9KM9vjvlYba21qV2OF6w3Cuv
         8PO6fzdSZiqppzn82j6nDqNK9EiXKxO5/GZPaOX9nmw+3mog+qy8gsgS7oxcqu1y+G1U
         tKJw==
X-Gm-Message-State: AC+VfDyojRbEz7d3FQ2tBqjIKHMNICpM7EMzOXB3YVmeF9dXWj68bFWj
        wPDxMBrhYCkt1iH1zNhaU9VqrHCpkroYiMxEPPBCaKZdcj77Re5Jzy3iKA==
X-Google-Smtp-Source: ACHHUZ7+MAxHQ4ZYTMOVO0O/FKyNB2Lnf4wPuu1wag0LFSUkSHFhWeM0ffoEI/0+HH4jvHhYNfPREwRKpM+XndV5Krc=
X-Received: by 2002:a67:f2c9:0:b0:42f:e944:7ea0 with SMTP id
 a9-20020a67f2c9000000b0042fe9447ea0mr4664595vsn.6.1684859816167; Tue, 23 May
 2023 09:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230522190412.801391872@linuxfoundation.org>
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 May 2023 22:06:44 +0530
Message-ID: <CA+G9fYuKxKdTSLKM=fsToOGzoY=017i+7iypy84sYRC2HfDcyg@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        josue.d.hernandez.gutierrez@intel.com
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        LTP List <ltp@lists.linux.it>
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

On Tue, 23 May 2023 at 01:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 364 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Regressions on arm and mips builds failed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

 * arm: exynos_defconfig - build failed.
 * mips: cavium_octeon_defconfig - build failed.

Build failed due to this commit,
  "xhci: Avoid PCI MSI/MSIX interrupt reinitialization at resume"
     upstream commit 78887e3e5f00fca305670d8f3ba3c0f42b343047

NOTE:
LTP syscalls msync04 started failing intermittently on 6.3, 6.1 and 5.15 on
arm64 devices which are using NFS mounted rootfs and external mounted drive=
.
Whereas on arm x15 devices it always fails from 6.3.2-rc1, 6.1.28-rc1
and 5.15.111-rc1.

Test log:
=3D=3D=3D=3D=3D=3D=3D=3D

tst_test.c:1634: TINFO: =3D=3D=3D Testing on vfat =3D=3D=3D
tst_test.c:1093: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opt=
s=3D''
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1634: TINFO: =3D=3D=3D Testing on ntfs =3D=3D=3D
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opt=
s=3D''
The partition start sector was not specified for /dev/loop0 and it
could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and
it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not
be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the
'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1107: TINFO: Trying FUSE...
msync04.c:59: TFAIL: Expected dirty bit to be set after writing to
mmap()-ed area


log:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.=
3.3-365-g20efcce0526d/testrun/17163865/suite/ltp-syscalls/test/msync04/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.=
3.3-365-g20efcce0526d/testrun/17163865/suite/ltp-syscalls/test/msync04/hist=
ory/

Test results compare across 6.3, 6.1 and 5.15.
 - https://qa-reports.linaro.org/_/comparetest/?project=3D1764&project=3D15=
97&project=3D1022&suite=3Dltp-syscalls&test=3Dmsync04

## Build
* kernel: 6.3.4-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.3.y
* git commit: 20efcce0526de5a73d24520128ccf44e1e2ab833
* git describe: v6.3.3-365-g20efcce0526d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3=
-365-g20efcce0526d

## Test Regressions (compared to v6.3.3)
* arm, build
  - clang-16-exynos_defconfig
  - clang-nightly-exynos_defconfig
  - gcc-12-exynos_defconfig
  - gcc-8-exynos_defconfig

* juno-r2-kasan, ltp-syscalls
  - msync04

* mips, build
  - gcc-12-cavium_octeon_defconfig
  - gcc-8-cavium_octeon_defconfig

## Metric Regressions (compared to v6.3.3)

## Test Fixes (compared to v6.3.3)

## Metric Fixes (compared to v6.3.3)

## Test result summary
total: 181993, pass: 158209, fail: 3545, skip: 19974, xfail: 265

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 140 passed, 5 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 30 total, 26 passed, 4 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
