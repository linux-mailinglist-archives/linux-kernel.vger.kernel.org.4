Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4957B740BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjF1IjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjF1IgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:36:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE73588
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:27:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666eb03457cso2998944b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687940867; x=1690532867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iichXkU9g/XJfOh2ks749ZybEdtHWrMk0Xz57/tgOJI=;
        b=gea/EpO9SW4Lfb7RzwMAOu8sA4WiQsyVyR9+hwFrN0aNMT4HhBNuUr7oY9X1s5jsyd
         V8Ox+DL/UaPa8bYkJGWu13Vs6EQyaZYxdAYuRALX6ZAYOIL6mDj+puCPXtsYWar6xumO
         gRVI1iqr8PPmB70xniZD9EIwIv6NWOS869+BNf0DQr5MwZOp5QxHN0o4PxXu+2WxAibW
         UZv5aBRH73inFhREjJCge2sryGBaNG2UNp8pmysYMFQ8u9eTJHX+6POmkzAOV1dMYFZZ
         MjWn2Msklmp8s6QkXBqM+xRCEkdjeQakJhq0Pp9R5fzBrGP03eN6Sz/q0SMUzaCTjNPa
         7rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940867; x=1690532867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iichXkU9g/XJfOh2ks749ZybEdtHWrMk0Xz57/tgOJI=;
        b=BPy8gKUr1D7JV8ckW2o5F3Phc2DhNuyoAwsvVcVbge+LmOM2tykQXg7VfqzncoMlPQ
         8Sl8v0MkMnfHY/Z/nhiVNT2ZoTa9dzq7qI4GV9mU1WTxAvo8bO2uWi/Ap0v6GW0UAxdz
         O5sOLfB+lo4UC9col/f0QXfRmR2ExmV1gFWVX008FgJObSprCdNGjjgWokD/l/R/yh+u
         XZntXRlvnEgmcTchloKS7URW3m2ikJ4GqFadBGjJXGJKiS1kIaK8MkO2cW1iBLupSotQ
         Ehmo0fcFSCIt4EtRIrGQ2RtYiIHLwYKIW6kZVtjXXpcvX8zOe/vmrpnXKN+MKb+jHPxc
         jN/A==
X-Gm-Message-State: AC+VfDxBJW33HMmSxxyCe9cUmzERk+KcSkmyeYNt2+ujr5Rqc7QGtGLh
        3WjVCWK9kv6VqgxfHMpkdSazZ57UxsR9RoLh3ybf3zXh+FDqCMsaGAux5g==
X-Google-Smtp-Source: ACHHUZ6VnukVAQ1/fGZwHC1ltTN/zizq/VmIBMXyFnWMtOY7uaE4kWodZOKrq9+bM1xgMwFudSyfTycFvR+JLaWDdEU=
X-Received: by 2002:a05:6102:3641:b0:443:64c0:ef3e with SMTP id
 s1-20020a056102364100b0044364c0ef3emr4399976vsu.21.1687934274621; Tue, 27 Jun
 2023 23:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180805.643662628@linuxfoundation.org>
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:07:17 +0530
Message-ID: <CA+G9fYv=4j1e1-7kak3_dpkLAcRf1FHXK4j3tCNjPEsUks14kQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/199] 6.3.10-rc1 review
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

On Mon, 26 Jun 2023 at 23:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.10 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.3.10-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.3.y
* git commit: 3d49488718bf7f62bf7e49db5f677e4ad0d5a900
* git describe: v6.3.9-200-g3d49488718bf
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.9=
-200-g3d49488718bf

## Test Regressions (compared to v6.3.9)

## Metric Regressions (compared to v6.3.9)

## Test Fixes (compared to v6.3.9)

## Metric Fixes (compared to v6.3.9)

## Test result summary
total: 189021, pass: 155522, fail: 3063, skip: 30272, xfail: 164

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
