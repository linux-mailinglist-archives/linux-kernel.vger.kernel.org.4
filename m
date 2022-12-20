Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C073B651ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiLTGl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLTGlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:41:25 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BA521B0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:41:24 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id e24so2630775uam.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu7EV9ZEZz3Xd1It3w/Sy4Yei5vDPeRLiD3fIB+uyng=;
        b=uOgc70b9eTyQbAUuJYcDER+6dfeR1XwM10REiIsZhaWyUgrjSZ7IQfMBVGbXEPYYHR
         nEmi3H/KyUvYxl3i5v2KgchZP1DP5ZfTq/NlIzwcioaqdix7c5HsMouTpep/igE61ng/
         VRxK+VuGrRHUb+ZPEo7epPYP4lZ13vI3lDUk6PkgRtMrgFuA2wQvPEThtstS1Ds2ajPk
         v9D/Y2vzW1+EbTKZAHt68n80asHRN01/B/ztN7psFoG06lJBzOceCbxwkGpxptfCldfM
         0GtPJKWSOa/sCzOSkVF0HtDL1g/OdIRxsil9lImj/FXqVVUsN7NlP/m+5wpkgFqQYUmy
         Ddlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu7EV9ZEZz3Xd1It3w/Sy4Yei5vDPeRLiD3fIB+uyng=;
        b=oHupvzXyyI5BVgYNY4GViZQWo1cZIZlz8dOqarSaX0ET62agmEiVPEBOqwbGZlpHA+
         O9D5DpGUSTYzWY3nfNTOGYZ3kPdDtI5Qe0W2OEzIsIDKGm0nsDeUo4WpNfvV68UlbuFq
         5t3YRssLx084EBjPFF00qybCAc17Pg3mij+98u3sL2npa/t/Oxvmno6CvQ/R1RGNV570
         3xq9gfgeTNlMK1F9sT4LPyXPKkzYGKacXzi2OXGj1u2V8YMTswGryruj5mp5Of2ZBVou
         7Ope2WmDIx6T1DtjDHFUJmp0HzPIfyTG05Lo3ElKkA+GIzAvH9tzxghuL68zNRBLYgvD
         1fZw==
X-Gm-Message-State: ANoB5pk2A8kgUWcYKQj4NqgafJJObAxBn4c7EyWlep8iA/HnVQLg47Gn
        fxHZ4KwAxCCaduS+Q/IeBjTNoaSoLuDeKJpd4Mc8yg==
X-Google-Smtp-Source: AA0mqf414vTdvsZjZChK7GkEwhpBMPGWP3TyAPUK8/jnkRe0AOy9vPhQG2fHppyhwhUViRP8wIowRoZqyJeRHqpUYOs=
X-Received: by 2002:ab0:7c54:0:b0:419:23f:5481 with SMTP id
 d20-20020ab07c54000000b00419023f5481mr40635411uaw.22.1671518483152; Mon, 19
 Dec 2022 22:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20221219182944.179389009@linuxfoundation.org>
In-Reply-To: <20221219182944.179389009@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Dec 2022 12:11:11 +0530
Message-ID: <CA+G9fYs2Bc2a1UTraB-s838PkPUngjMe+NrhJA9S3SJOgZ-_3g@mail.gmail.com>
Subject: Re: [PATCH 6.0 00/28] 6.0.15-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022 at 00:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.0.15 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.0.15-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.0.15-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.0.y
* git commit: 65f3ab07fb2407bb18fa9f3d0526929483aaebfb
* git describe: v6.0.14-29-g65f3ab07fb24
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.0.y/build/v6.0.1=
4-29-g65f3ab07fb24

## Test Regressions (compared to v6.0.14)

## Metric Regressions (compared to v6.0.14)

## Test Fixes (compared to v6.0.14)

## Metric Fixes (compared to v6.0.14)

## Test result summary
total: 143871, pass: 125746, fail: 3356, skip: 14329, xfail: 440

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 146 passed, 5 failed
* arm64: 49 total, 48 passed, 1 failed
* i386: 39 total, 36 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 32 passed, 6 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 42 total, 41 passed, 1 failed

## Test suites summary
* boot
* fwts
* igt-gpu-tools
* kselftest-android
* kselftest-arm64
* kselftest-arm64/arm64.btitest.bti_c_func
* kselftest-arm64/arm64.btitest.bti_j_func
* kselftest-arm64/arm64.btitest.bti_jc_func
* kselftest-arm64/arm64.btitest.bti_none_func
* kselftest-arm64/arm64.btitest.nohint_func
* kselftest-arm64/arm64.btitest.paciasp_func
* kselftest-arm64/arm64.nobtitest.bti_c_func
* kselftest-arm64/arm64.nobtitest.bti_j_func
* kselftest-arm64/arm64.nobtitest.bti_jc_func
* kselftest-arm64/arm64.nobtitest.bti_none_func
* kselftest-arm64/arm64.nobtitest.nohint_func
* kselftest-arm64/arm64.nobtitest.paciasp_func
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
* ltp-open-posix-tests
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* packetdrill
* perf
* perf/Zstd-perf.data-compression
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
