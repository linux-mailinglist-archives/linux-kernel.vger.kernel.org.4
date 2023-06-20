Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855B773675D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjFTJNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjFTJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:13:21 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932231FD4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:12:55 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-464f8a20c05so1321545e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687252373; x=1689844373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbQjn1tsaYx8cD6Lvja4El7hMzJhB/RR9mXACpuXYKg=;
        b=RO7DMg6eHeMJsZ3rkYfFbNwHm4z8KwGzU9m5P8EqecZpbYl171KkFnLeafZsoOjORn
         iKi+2gDnR1uWUPUhjVhxzusDQwHGhCsKJqttpZpevJ6sQdVHnJJWilnVC58s3atrwx78
         3M80sRQvyBd+7M4mDgQUM33caZsBJYj5Nq3FEgah1f69OhKNlU9I0XLkxOIba25esNW6
         70dwBQnOe8lfuTrKoFqWqxTBtI5Q1Q8Xcr0urZQDX650vumEDpmdeRvS/YnlqBQ/Hw0m
         nt2e0isu7c7r1erLNgxlxDkcHpa249cwY9iwgXzPctx+Lbny9nbloTbQzxAxCcyvzQga
         EEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252373; x=1689844373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbQjn1tsaYx8cD6Lvja4El7hMzJhB/RR9mXACpuXYKg=;
        b=YivvZkbAjiBE+DHVHMEn9Gm55zPJDiiQRI03hWV6kP1yS3R5VGqi5L4HM8k+ZRmkwO
         UjGa/JMUfpXOfsWdJDL0qs8N+9PUO8CKxyno4PrxNres46EUajsh/d94vjHm3nLDpUKw
         nuC9gvDlarvt+2E2T/EAmdBYuhGAxPG0Y+p9e35v2Et7Y0WoyiqlCp68D4UgR6neAG/k
         tdn3umnqI49902IJhob/5kz4ZzbWrc2zZ2Y98D++7sYjmgs22DEOykuT7tgIT1369hj8
         5UOr1wEvQ+xh/Se9M23OG3g0lSDmfcFD4irB9PE34zvwvqVnwaxV7OySBA0z/SiWWwhg
         DXpg==
X-Gm-Message-State: AC+VfDwuYuwgo2ogJ4qjy7SHUvUr8+e6yCU+t7S9hpeZYL7wQOdaK0zX
        OXPyB15SJt2eX1ShyIsgjmtp4Qibw6KcZwvWEeI64hq9jaxhvI4lPr8+3w==
X-Google-Smtp-Source: ACHHUZ4Jt/xSCN2HOTfCa7g37yezHwvxeYaGJuZtETywEW2ozSAOCh1OVZ8YiUNP/kIADVsU4uMuwZQ5RZu8w9fQznc=
X-Received: by 2002:a05:6102:3a72:b0:440:be9c:bc99 with SMTP id
 bf18-20020a0561023a7200b00440be9cbc99mr1093071vsb.15.1687252373473; Tue, 20
 Jun 2023 02:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102154.568541872@linuxfoundation.org>
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Jun 2023 14:42:42 +0530
Message-ID: <CA+G9fYs2WDvPO34TDPyPWSqrc-ieM7OP0DDi1ZYF2jz3OdoXiQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/166] 6.1.35-rc1 review
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

On Mon, 19 Jun 2023 at 16:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.35 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.35-rc1.gz
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
* kernel: 6.1.35-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 1781b36a0958c09ec269d0591f929be0590eeb96
* git describe: v6.1.34-167-g1781b36a0958
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.3=
4-167-g1781b36a0958

## Test Regressions (compared to v6.1.33)

## Metric Regressions (compared to v6.1.33)

## Test Fixes (compared to v6.1.33)

## Metric Fixes (compared to v6.1.33)

## Test result summary
total: 173166, pass: 144515, fail: 3419, skip: 25079, xfail: 153

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
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
