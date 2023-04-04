Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FA46D599B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjDDH2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjDDH2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:28:37 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F1440FB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:27:49 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id b6so24348695vsu.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 00:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680593229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlz6Wp5FK79o2mUyLxwD7cc+G1aD53kNQqkkJLlNmhk=;
        b=b2MSdNlXgNEG/jBi09Go4KIlwhJgyep1CaTtYSpiR+Sa7oXepsaMCcx8vsnYRXdYk6
         gKWOFPrfoPQYooMAYKyGHJJ3/iGh7YdmqdQllZJl0KlaFp/yvinDoeiviv1Iz97HMp+h
         KHfQan9Bl6y8yuuXx1GibtVed7Nn8uQs/xili0NvzEGcqRxB+UpBDAc0RI41PUfQuR0C
         Frf4lgpdlFJO82YrVwilc5aqcXnZBE7o7As4zjmxgfTcOXb8s0niV5/GWQ1GIQDBUThV
         veAPZJI6KyWPBHOMBWa2uyFTcOA6isAll0kZJ14uBDRMyOrrCB1vqPlsJiz3OnQu/9L6
         OlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680593229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlz6Wp5FK79o2mUyLxwD7cc+G1aD53kNQqkkJLlNmhk=;
        b=087nI8F6UB0kKujlJMPdPTBxnR2BZp0poOaBuTrJclcK4R//XVfMoAPgiqTrHRSfhV
         7s0VVvzPnJddot3Wl6MGbOfKLK7qUJtRsqXrUg0cImbM3PYoXCbjKYA80RADxeZ5VuUf
         /+44uwsDesv6yktMZWxZp6UFb9Ue9g4BHipTBsv5NJwgaROgLAT7tPuX6tr1Y3MdIBKf
         V87i8f9X7yFYfr62HM6c/HEJ1qYrDYGR1xrgeRuyHWUbRCJr3qRp62wlNJh45lugBV8W
         ao1YnuMI5zp9LSSEnoc5wCOq7Orpdjhcd1z0HVfM14IpC114+M58fXqERyfZL32UJXr6
         klIg==
X-Gm-Message-State: AAQBX9f4iuOv2QA1vRaMlFZc3ajsSGIegwRQ9LMri+4p1h4W+DFEqrpp
        W6loyWiXBe3OftumI9ptErMBFK+oOcLgYPCgfPel0A==
X-Google-Smtp-Source: AKy350bRVj/1oluDM3VgMwrtB2McZPzYAWBenGEvOJExZIHSkH8u9/UzITdKzBR+kwpBAAiGqgk+VVnmxHFUfts3vXA=
X-Received: by 2002:a67:c812:0:b0:416:2ad3:35ba with SMTP id
 u18-20020a67c812000000b004162ad335bamr1626316vsk.1.1680593228980; Tue, 04 Apr
 2023 00:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230403140414.174516815@linuxfoundation.org>
In-Reply-To: <20230403140414.174516815@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Apr 2023 12:56:57 +0530
Message-ID: <CA+G9fYsHAG8y3nC2KP-5sCzchm8hBrOOfWfYb_DTJgdopU2KiA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/173] 5.10.177-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 19:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.177 release.
> There are 173 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.177-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.177-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 7d617ad89b616010f8233d54ae9d5623cbb91b41
* git describe: v5.10.176-174-g7d617ad89b61
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.176-174-g7d617ad89b61

## Test Regressions (compared to v5.10.176)

## Metric Regressions (compared to v5.10.176)

## Test Fixes (compared to v5.10.176)

## Metric Fixes (compared to v5.10.176)

## Test result summary
total: 126510, pass: 104809, fail: 3271, skip: 18206, xfail: 224

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 115 total, 114 passed, 1 failed
* arm64: 43 total, 40 passed, 3 failed
* i386: 33 total, 31 passed, 2 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 26 total, 20 passed, 6 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 36 total, 34 passed, 2 failed

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
