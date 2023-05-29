Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CAB714D70
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjE2Pwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjE2Pwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:52:43 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65611A3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:52:42 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-456ece9f868so937815e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685375561; x=1687967561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGaKnkSY6KauhCFSazmEUL/Bq+G0y7m3m3aFs5ZleIs=;
        b=Dxelwj2lHv1Ym9KWoinFzV/DSsT2+sKqw9RvU0KUv64qrdoHkuLpZ4hY1TtVSepYVM
         1sHO5361oiSjspGNHm/AOPqxorO6i1V6H2E+QigfuHMjkh8Wfxmc9l/9J+lHloClmSCH
         Fy68wEC6brJGg7NCZpLfk9zts6aIrNpQXvPA3Y9BsbhKjVwC3ps+FVij7a6jZsDGXvZb
         bKn/nfz02j0f8RMHqlPGK9gEtQLulk8QtQdYvSJ/b/ygWFeXcJKPXGdmJL8BQ0hU96WI
         rtuGJWjI44gsKhedH/i/VVoJDLfyr/YKjrf6PplvhjtZz+hxyuaxRMgRrUf7h1sCqe8X
         xvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685375561; x=1687967561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGaKnkSY6KauhCFSazmEUL/Bq+G0y7m3m3aFs5ZleIs=;
        b=bHFvWAplMy02ZrB3SRQAj23LDxrk56UgKn/rSV1gaZWLEnwdWNejdQhjAggyC4mjT3
         /cJYfOYrOynfT7/kOTp1DxV3D79NzYvdF/G1cOozXtGhJ9a1EDiNiKdqsgs3f58zZnas
         MUGoHCoF9iMcJ421/szt0csf+lgBmP3+GQjCc9CAhyuxCRhCdMW7NvG6dm1PGBHuGsON
         hVbrvOV5Ox1jHgxbRVWAqfJ6Ym8uhwYHJ/hhUTp0PSrpWexzuEm5rLvCBvvBm5iGvhV/
         AjjWHZx5i969UFVFdRw+BR5W6EqqAH3HsTOgJXdFt5tZCw9wAjBnszytCoq/hrabkuI7
         kqGg==
X-Gm-Message-State: AC+VfDzHKzJYfkFOvOfolUH9RkdIEOsvuSmeztslDN5JsqaeGgyI6dvL
        ff1T4W22rBbpR9Q5AeLMzFaXeSynDY0m+xpzTwjPhg==
X-Google-Smtp-Source: ACHHUZ5WTM9BvqPWbVXAGXg1rQ8FgY/ECsnpVegb3v3Wt3m1gWeGXnAFcFVnewNzGrXeKaoSYjRoJKc771LYXcgt6NA=
X-Received: by 2002:a1f:3d15:0:b0:440:3b4e:9a31 with SMTP id
 k21-20020a1f3d15000000b004403b4e9a31mr2451504vka.2.1685375560931; Mon, 29 May
 2023 08:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190828.358612414@linuxfoundation.org>
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 29 May 2023 21:22:29 +0530
Message-ID: <CA+G9fYtYT438NoeQegueRqLD_4x+6x9FSBLAcW3jU1+BpwTkpw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/69] 5.15.114-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 at 01:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.114 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.114-rc1.gz
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
* kernel: 5.15.114-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: cd3aaa9c7395cb221c57a5d6e5ca7d342669d553
* git describe: v5.15.112-274-gcd3aaa9c7395
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.112-274-gcd3aaa9c7395

## Test Regressions (compared to v5.15.112-204-g30213a86a6fe)

## Metric Regressions (compared to v5.15.112-204-g30213a86a6fe)

## Test Fixes (compared to v5.15.112-204-g30213a86a6fe)

## Metric Fixes (compared to v5.15.112-204-g30213a86a6fe)

## Test result summary
total: 133865, pass: 111296, fail: 4340, skip: 18041, xfail: 188

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 35 total, 32 passed, 3 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
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
