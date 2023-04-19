Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2A06E7368
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjDSGkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDSGkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:40:53 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30754118
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:40:52 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id f39so3629179vsv.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681886451; x=1684478451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWd5qP19PrDA8a5+jMOmLR8wXhUw04LKJ7XceEnbX9s=;
        b=e3FPsHJmPlWD61qtzCukUCAKypIZTK6Y7WrWfeYnRzmQBinus8xKq4RdcGvHK3U4xv
         UtPJSIZnvNfdaDgXZN1mgIjdtLZttzYUWdJRn1rIVddpfnms+BSH82EbkBFqUzHrF8OG
         j64WYz09bhlob0qpRjoWh37imAJLKzwrQxA++/F6a27GCGu/XiWbAHbLed5J9VPd8u6m
         clp0QvvESMVuUHKPnkQpbwkRTCS3VSE3vfwpAlW/+yFgANhB5nlr+mquDXaxdt6ArDUi
         2dh7qvYdsnJHxRP/6vT0iz6Z/INCm6YBFqrOChs2IXxmI5I86tOQQM0Yq8BvJoamaOnV
         Te9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681886451; x=1684478451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWd5qP19PrDA8a5+jMOmLR8wXhUw04LKJ7XceEnbX9s=;
        b=HBB9ycGWF+i5Efo56C5Lmqxrkx22XqIiWHupPzjXl1QvCt11yKufzkn8pC3KEmkfbp
         9w3TARU5v3NX94Z6lXsn+5jYXdegirFCSEC/HG9OkQKu60WijkBWRmGZohg8h0g+wB2s
         mNJtgNa12bs6lpgWQW8JBeq/fANQ0hCKNScjPrbjLwdsqoeXe/lIthPvpyM4cq2zSy04
         dnLrrpHVmj9Ih2nVLQEu1CjBnF7AWFqNT5WimRMHlpRfMwWfbdzVapK/Ny/aICcI6oKD
         bYT3tcfzRSXQBNxo8eYXzhOizBwlN9z3OFpp621bCWv4I0noQ7he37yMNg+Y6WrvTFyb
         GrhA==
X-Gm-Message-State: AAQBX9dkZ0rQhaZwakfMx6TJXziZGW1hm6Sp//KbfmH+7IIveBAH67W5
        0OzForM5Zy4rnVmrYF2rxFE9N//tvHR8x3A+EimHvw==
X-Google-Smtp-Source: AKy350aPR9dTPodpYzT0iWfP5z+C0pG2685nhsjTHPlCI6dyQnDcK0ipkvjgGhXUg4kT025T4T7EWVhWrXcsZuibbXQ=
X-Received: by 2002:a67:f7cb:0:b0:42f:e169:b759 with SMTP id
 a11-20020a67f7cb000000b0042fe169b759mr3664374vsp.15.1681886451085; Tue, 18
 Apr 2023 23:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230418120313.001025904@linuxfoundation.org>
In-Reply-To: <20230418120313.001025904@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 19 Apr 2023 12:10:39 +0530
Message-ID: <CA+G9fYsXat98YZAOe6geqmffe4H9XW05n6ThLYoEMRLqXHKNxw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/134] 6.1.25-rc1 review
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

On Tue, 18 Apr 2023 at 18:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.25 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.25-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.25-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 90c08f549ee77571625a1b42bbb3fcc956181801
* git describe: v6.1.22-480-g90c08f549ee7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.2=
2-480-g90c08f549ee7

## Test Regressions (compared to v6.1.22)

## Metric Regressions (compared to v6.1.22)

## Test Fixes (compared to v6.1.22)

## Metric Fixes (compared to v6.1.22)

## Test result summary
total: 156939, pass: 136263, fail: 3904, skip: 16450, xfail: 322

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 149 total, 148 passed, 1 failed
* arm64: 52 total, 51 passed, 1 failed
* i386: 39 total, 36 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 44 total, 44 passed, 0 failed

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
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
