Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94B0727D46
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjFHKwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjFHKw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:52:27 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440822D42
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:52:06 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-45ee86a16caso144844e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686221525; x=1688813525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+wKmn+dGFIKb4lUNmkGpLUatoAVJNOyxAKbwg0PNTE=;
        b=FXX4WlkDxC6e/BwUUoQ9mYR1oXHrRvqnPf4ZcRCqgk7HTbrvPt33x/D1C2YZBA3Plm
         ZYMrYM9/4IJUKzSHlVl7pr6TLGSRB4oyo0ksF6IXwB3fil1KQLQXFtEwRWPHjHfqj6pk
         7VAlyP0zgz/1ZpKxW+GYi5Vu0t5qXZQ3Sav4P67zD7ix5pzZc2wwRTQbQ+7tfEYkKkt7
         67VGd5YoEXnw4f4N6H+GkSIOJaPb6wp6qvFnTbeI4IaHvxyfGAAwMcD056m5MXO9DEb2
         ZU8Oy0JkN1jvhq9a3Zadds+RBKsrpXNbrA1esgzqqqemQbnOpLhjjKQEQVTuAXCrCTQz
         pCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686221525; x=1688813525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+wKmn+dGFIKb4lUNmkGpLUatoAVJNOyxAKbwg0PNTE=;
        b=XABCNvVsOc9zDNk1pN4iJ/7hqkafqq6RGvII/6+bt8wjoCra0JCf/kAB5j2nyOpvvM
         LvX8WXk2RqPPdcQAkzsMBej8Wmv8Ei3lszIFy2DoxbfSgffdS2SJT+8NOQ4fIbSSK1FV
         CVD3h6CdHOO+Ac6/OCSVfg8j5JQrPliOvde34ByL7OOTUKhU0GUsN+He3NYN5280fuO5
         OsboPjCO73NR73L96B1+aKV4aDtRPEc18v3bnv4ATzf3iTu+bPkJPwrGkBFtAi0job+N
         rlocEr1iHVpFS62R/4RU13VXXEFpXGvThYEkXYiSSgKcZVOQ0Q3DVlXOZN2O4J2U0j5J
         gnSw==
X-Gm-Message-State: AC+VfDzEVysHmUqA8948Fw/o8AGEzTic1pI8N5FcllIaMS4vSaWt3Lrm
        bskFduf4/Vl7Byyu0nbwxhn4ZchhCSdFx2FaV6fz0w==
X-Google-Smtp-Source: ACHHUZ693v6i8cQH8pJrkhIBaCx8F9RI+5evhOle5Jb3R3CnNgus9SfPOwHT3YuWZm+CoOsmxExNhFO/rhGiSLwHiZ4=
X-Received: by 2002:a1f:43c6:0:b0:464:6036:604f with SMTP id
 q189-20020a1f43c6000000b004646036604fmr3036424vka.7.1686221525223; Thu, 08
 Jun 2023 03:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230607200922.978677727@linuxfoundation.org>
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 8 Jun 2023 16:21:53 +0530
Message-ID: <CA+G9fYuv4MhCAMSc33hZdDozV=MJzbK3CvHYCn10nDOY5gDQpQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/286] 6.3.7-rc1 review
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

On Thu, 8 Jun 2023 at 01:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.7 release.
> There are 286 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.7-rc1.gz
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
* kernel: 6.3.7-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-6.3.y
* git commit: 78317e11fb00aba0b42e15367d2630a515e4a808
* git describe: v6.3.5-333-g78317e11fb00
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.5=
-333-g78317e11fb00

## Test Regressions (compared to v6.3.5)

## Metric Regressions (compared to v6.3.5)

## Test Fixes (compared to v6.3.5)

## Metric Fixes (compared to v6.3.5)

## Test result summary
total: 138349, pass: 121372, fail: 2111, skip: 14667, xfail: 199

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 140 total, 139 passed, 1 failed
* arm64: 50 total, 50 passed, 0 failed
* i386: 36 total, 35 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 42 total, 42 passed, 0 failed

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
