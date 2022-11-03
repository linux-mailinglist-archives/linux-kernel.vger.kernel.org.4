Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28086617708
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKCG7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCG7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:59:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE45D6C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:59:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so2738362ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 23:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj1GNgc0zC7LmySqgd1/EQ8aJdse95LGxtuBcxW3XZ8=;
        b=ozZgIXgI0yEifAI5odai3lgHfeHbNmu2oR9AZIPI7bJ2RvVBAWpHm0FZHlQyTPau21
         4w050QEA2dDVCaMWeLWfjjc2i5Swi4xxtpeRcDOLi6ZTOIBmzks4YQtJAoteohKy6GCv
         dLC7EsyA8DVla5+aGFfQphXi1nRYawomvXAbCuSaZ822H4gC7NSsgh8XbKSMbFDOwGA3
         21VKrCMNpQx8dlxLQq7FDgKrREoIiM4GUY+FjvBpEgA2r13xe3ukxcwOmyP8t2aq93kS
         4oASIIJ8qiPEKTVtrT7JfAg6VQ3XK0g6sc15A+CEeB2zJyzwwbNuM62zmXFRs2Bd2h+e
         EQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj1GNgc0zC7LmySqgd1/EQ8aJdse95LGxtuBcxW3XZ8=;
        b=3x9F5ZexXMZSrc8A/mm6i+0ttael12+aPZXbg3VDjdFVm4qtl4i6Brnevp5aCEuCIm
         UdM4mpa5A5vyxBB0KLxAtT4ZzNvDQjsRQn0ClFptQnvUSIM1/1Yp1zJKmxb0MBXjTLe6
         6rf+Vk2tC40NFqgCONFhzGOQfrpkZ9bWjWwP23xR+u6Dzzn/s6SQnLMDJ6//YFpdbAtE
         EJdRoNqs31dDdawQxm/q5J2XzpPxW/DXwMtvnFtX5yej54ijpMJ/RdKKbQN0z5OxeBu+
         qnab9fILeH5j/1Qh2KYYJ4otzbFWW5I/Xwzq5bcMSPGB0vtm8AcdtmwO+ZU+7GQZLEwC
         DkNQ==
X-Gm-Message-State: ACrzQf0SJQA+2dT33R1r3J+AD7eVfKfGpcCzA8sJfceFfynvmI+xV04N
        KJPhkx+MHIkmqrwjF69ZMLNHcclxAHnEV2TU5DOM1C5yNmbSdQ==
X-Google-Smtp-Source: AMsMyM6DEBg0fVoGNFIWomQ3+QdAuc/7cfzElVqqx+iD826sQqftfI+rbjkRJeGYZAaPahJARTCwattK+Hkm7HiMRDs=
X-Received: by 2002:a17:907:80b:b0:77a:86a1:db52 with SMTP id
 wv11-20020a170907080b00b0077a86a1db52mr27550502ejb.294.1667458778830; Wed, 02
 Nov 2022 23:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221102022059.593236470@linuxfoundation.org>
In-Reply-To: <20221102022059.593236470@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 3 Nov 2022 12:29:27 +0530
Message-ID: <CA+G9fYvPV69FB2QARi0whE4WE4oOb24mWRDAzE8e4YwHA_1KCA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/132] 5.15.77-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net
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

On Wed, 2 Nov 2022 at 08:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.77 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Nov 2022 02:20:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.77-rc1.gz
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
* kernel: 5.15.77-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 55ed865a9c8fe0489641ddc8e9a4ee35d74767aa
* git describe: v5.15.76-133-g55ed865a9c8f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.76-133-g55ed865a9c8f

## No Test Regressions (compared to v5.15.76)

## No Metric Regressions (compared to v5.15.76)

## No Test Fixes (compared to v5.15.76)

## No Metric Fixes (compared to v5.15.76)

## Test result summary
total: 156317, pass: 131770, fail: 4147, skip: 19975, xfail: 425

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 149 total, 148 passed, 1 failed
* arm64: 47 total, 45 passed, 2 failed
* i386: 37 total, 35 passed, 2 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 10 total, 10 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 40 total, 38 passed, 2 failed

## Test suites summary
* fwts
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
* perf/Zstd-perf.data-compression
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
