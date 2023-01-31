Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E39682568
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjAaHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAaHMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:12:46 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94715302AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:12:45 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id bs10so6943040vkb.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5//sUDN7aAa+/fdAa54DT1YY07Np/vQiCEXU20HW7A8=;
        b=mp5Sv6Mm56vPapy+tjZGh3nfS/GG1pk5KRXs4RHrdXQKmMyifRidlaN5LS2Z994ec1
         bENSN1Ztt56ZOpibf/EraXbQvDF+tXBOY6yLj1ZxQDVy3zyZYs0Jof8T92/hxDyFn7Fa
         W3Vau43jZKssGvJEUrOekJPF8gPn7/MpPjeix5hVCSiWyeUlzZ1BBcLIAIlIPYbu9fr1
         jN5Nftzmnq3QF7VHhsAJeG9AvZUnFWSG/JkKnS1IQmgEc1Eqbw+QtfzpvkzTUYdJYTKT
         5Fy+CLYwRZgasA+QhO41c7MVEmt+vV8CNumdTggcuBp3T3/1CXqv6K146hFbLsLbS6i9
         FJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5//sUDN7aAa+/fdAa54DT1YY07Np/vQiCEXU20HW7A8=;
        b=SE2/RM/Az02K6cKEdhmtiFqRRg8MfxdTVv7Yrw0wfu+g+EZmH1tTLQlViC/k+IDwd2
         XhFC4X2SwGhFeYy4eb7tlPNixTIVIepu9Fux8yX/aT7JU4mgmis3fIV93wMSw5GxCYzQ
         l2L1geX92vP6NKQ1qN1KKaOkOyh+f6+hyPNCSAMNPzBOG/hEVdyd6AcvBPIWEoC6v5OE
         Z8DKCj9vVLPznAT6xkZMO6bQLzQsvKzc1PnNbQPxzLS0vrINA90IWCW8nPif57b5j8qy
         Qo/SNGhPVyQ7Hx3mxwBcLGPFMedjG0h0/bTlj1iUBJxnROUUnHa1j6GKpVkJSf+WRFa0
         dXfw==
X-Gm-Message-State: AFqh2kooimJd3r+Xie9Oyvf2tjcCHRj2AAvVzMYgqANNzkJj4CmF7lsd
        wfz25/ZqraR64cVpECF1kxxYIF1Ae2Zrpk0fE2FWxA==
X-Google-Smtp-Source: AMrXdXvjqVMGMbYiTFtTDld6AddwuPV8R5YGhW/eXTCuAwdkRC/HVJ98OdA1IRSeM3saP5w1wvmGnhbD7/CyoLbP1R0=
X-Received: by 2002:a1f:ab92:0:b0:3d5:63ee:dae1 with SMTP id
 u140-20020a1fab92000000b003d563eedae1mr7199589vke.9.1675149164506; Mon, 30
 Jan 2023 23:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20230130134316.327556078@linuxfoundation.org>
In-Reply-To: <20230130134316.327556078@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 31 Jan 2023 12:42:33 +0530
Message-ID: <CA+G9fYvGio_rUOQPemEB-jTryPaP=nsfzkCRQY60d=-QoipwAQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/204] 5.15.91-rc1 review
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

On Mon, 30 Jan 2023 at 19:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.91 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 01 Feb 2023 13:42:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.91-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.91-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 5605d15db0225e49efaa8f83e03f78a8bee3bb5d
* git describe: v5.15.90-205-g5605d15db022
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.90-205-g5605d15db022

## Test Regressions (compared to v5.15.90)

## Metric Regressions (compared to v5.15.90)

## Test Fixes (compared to v5.15.90)

## Metric Fixes (compared to v5.15.90)

## Test result summary
total: 154391, pass: 127547, fail: 4115, skip: 22498, xfail: 231

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 49 total, 47 passed, 2 failed
* i386: 39 total, 35 passed, 4 failed
* mips: 31 total, 29 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 34 total, 32 passed, 2 failed
* riscv: 14 total, 14 passed, 0 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 42 total, 40 passed, 2 failed

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
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
