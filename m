Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A782622C44
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKINTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiKINTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:19:33 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AABBC32
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:19:31 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-333a4a5d495so161573437b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 05:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x346+kmJfvjw8vfZ1Id50Z5g+zEAMEv62tIEW3lQPaU=;
        b=RL7puTn14ehr1zYypE7k1SY+phVtYX/da0cT/ko/HxTKosTIWtSqsoIqRBW0Aad/ch
         61DuiXb5oIbiWkDD5M++dneqw/A6cz7Yyk87YrB042ocfbW5NMprS2V11nlSO3Jdmj5k
         AL5pxoMonSVvYyMfrwTShOdtVYvJq1JUsdfT3IfZ3HUZ/yubwcY7PTdzStKRZlzPpxYh
         HlbzycjvB7NMJpARybVzgp8byCv8q0P6rusM9icXxuF32ajvU5+k8LW1NRi9J4BPJVAO
         h765l0XEal2xFwPhdeHjtpB2jpypzDZwQB6Ft8MvsaySgx7a4X9Op0M49DGxYmPVQpIl
         f9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x346+kmJfvjw8vfZ1Id50Z5g+zEAMEv62tIEW3lQPaU=;
        b=BajSOV/EFlXOt0BW2BeaQy0Gm4GauZgod/Ni4Ad87JRbzCO+WRHhR8syH1dXbYx1Xk
         JhL/Eh+yGqv2COoID1kqRzdAsSHhbjQ8WQ+EHVX20+3crKuBKF7T0pdUmIClyd0D4i3U
         W+LSbhzS5ocE+PM55/JfDlYGTHszDRZmHrUw0chS2U8rgF8L6Um7HTPONNt6PXRGJj0e
         0SLN8OMAfc+pvNnaoIoSluhpxkk9onNgsQ5PMI+wjgW5T+iJDIQxtiTW12DPXiQ+6fRN
         SyUse0ErCseq0RYZowspIXYj3lqBN7Yn6F9ab5YncI5DwyPBPEHydLf2158Lne639IC0
         gPbg==
X-Gm-Message-State: ACrzQf0ku7f8pxzITmBcgbFd/nMtT0uXsdTzz4h8I5wwSxO5GqYb5Ww/
        /XrcdzAUHjDmDo/atMi4uOmrvZGfdhf5/nGMoaWY0g==
X-Google-Smtp-Source: AMsMyM42/xd9tY80pL9divoeqArHsLlesOLQrRnFa7WjHpxnwzCqNykN/KPEFWVhnWDLmlckTZL+E3jlN82pTjhVRq8=
X-Received: by 2002:a81:57c5:0:b0:36c:b2a3:2e9a with SMTP id
 l188-20020a8157c5000000b0036cb2a32e9amr56367460ywb.232.1667999970333; Wed, 09
 Nov 2022 05:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20221108133329.533809494@linuxfoundation.org>
In-Reply-To: <20221108133329.533809494@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Nov 2022 18:49:18 +0530
Message-ID: <CA+G9fYvrNypsJSzKt2NSG7mmc0Fs92U+36SOgV9tQPzhLZVetA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/48] 4.19.265-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 at 19:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.265 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Nov 2022 13:33:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.265-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.265-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: de1300f8320107e9923a7a85ca43577525595ddb
* git describe: v4.19.264-49-gde1300f83201
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.264-49-gde1300f83201

## Test Regressions (compared to v4.19.264-30-g61edd04ba8aa)

## Metric Regressions (compared to v4.19.264-30-g61edd04ba8aa)

## Test Fixes (compared to v4.19.264-30-g61edd04ba8aa)

## Metric Fixes (compared to v4.19.264-30-g61edd04ba8aa)

## Test result summary
total: 121991, pass: 101941, fail: 2100, skip: 16997, xfail: 953

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 323 total, 318 passed, 5 failed
* arm64: 61 total, 60 passed, 1 failed
* i386: 29 total, 28 passed, 1 failed
* mips: 46 total, 46 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 63 total, 63 passed, 0 failed
* s390: 15 total, 15 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 55 total, 54 passed, 1 failed

## Test suites summary
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
* kselftest-net
* kselftest-net-forwarding
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
* ltp-open-posix-tests
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* packetdrill
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
