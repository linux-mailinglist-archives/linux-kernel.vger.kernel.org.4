Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F1728339
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbjFHPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFHPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:03:54 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D062D59
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:03:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75d536afa43so35948985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686236632; x=1688828632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sx0wIJhZFrYLsCINzj9pPzWTxRagC/8DgHUE+1r9JY=;
        b=how/+2vV9lZhM9Kn15pN5MdOc5KdNYyg0IMY1gOsahvsgJflWA6m5W/q7h+hUEi4XB
         R10zrtz+SGIevC4yVVLYTGhBoHpnKWE73UlTRajad4p8xQbp9wnl7Mtv5gLCjOXiIfUl
         9LEBL2+6OQ+8uH7tFPBCrSU9drkPz2ix8WBJvoQ3iHU8z3tAziNUNBbupr/w9Ir9RR6b
         Itw7R+m1ZZujZ5x2evog8a56wXfMDGUhT9BBN6UgroxZ7ghpky7nMPeBRjmCegLhWfEA
         es28rdR2mHt+embZKupaUoAkV2pEuELcNBTaqIGOnWBjQ+s+BegM6gB29EB/0QCwCf/b
         STDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686236632; x=1688828632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sx0wIJhZFrYLsCINzj9pPzWTxRagC/8DgHUE+1r9JY=;
        b=Sty8vVZWyFAF39L7IO8Z99HMyLGNfALve/4txwDq2ZsiSBmC/t1c3b5PoMTYDxkvpg
         oJxB7OZatgDfhES0vf69CNqjpkAq1WQJgDiz4KIPTNQHuAcHNvrESwb/GPCuiAje8CU0
         m6UcI9MmwI6IfulYEliDp7GOkhwuVJBbq3ckrQHLKOrxEVol2IAGRAikN/9EfLFc835H
         eLKVG96gGXimgAA+tt00jz/aSb6mtjc+4a/zRRnrwaf4tJN4aHC2hVupFq1rKQSy+3/Q
         s0p++Gt/WqzFGoKQkfH/Rvkxv7isVid7/uFo93vjVlSZEDXoX0ZSYhyShXpOEh+URbZP
         tNxQ==
X-Gm-Message-State: AC+VfDwftmvWUJSPQ7E4balu4yHLULmYZKYGR6gOuiz9YyfH9Q3Ea58x
        rnZvyj4d1QEeP3vQr7wDz0dik+cge0/d+vZCwe7dBg==
X-Google-Smtp-Source: ACHHUZ6h/xaZalSgDBHHdXFS+3cnM9QU1UxslDhNn7s4Wv2EybRBhfkjTRsXxD3i/2D8GTMaFtbzQZCZr4OtMh5E6W4=
X-Received: by 2002:a05:620a:26a2:b0:75d:5407:d761 with SMTP id
 c34-20020a05620a26a200b0075d5407d761mr2577954qkp.39.1686236631967; Thu, 08
 Jun 2023 08:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230607200900.195572674@linuxfoundation.org>
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 8 Jun 2023 20:33:39 +0530
Message-ID: <CA+G9fYvBy_OG=Z6NVjXE1um6uwxsyuNw6HT=TFum36-yPV3kFQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/99] 5.4.246-rc1 review
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

On Thu, 8 Jun 2023 at 02:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.246 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.246-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.246-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: 21d8ae1f2aa0a5687c2f614ccaaae460a74f56c5
* git describe: v5.4.244-117-g21d8ae1f2aa0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
44-117-g21d8ae1f2aa0

## Test Regressions (compared to v5.4.244)

## Metric Regressions (compared to v5.4.244)

## Test Fixes (compared to v5.4.244)

## Metric Fixes (compared to v5.4.244)

## Test result summary
total: 106317, pass: 91643, fail: 2159, skip: 12368, xfail: 147

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 133 passed, 15 failed
* arm64: 48 total, 42 passed, 6 failed
* i386: 30 total, 22 passed, 8 failed
* mips: 30 total, 29 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 33 total, 32 passed, 1 failed
* riscv: 15 total, 13 passed, 2 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 39 passed, 2 failed

## Test suites summary
* boot
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
* kselftest-sigaltstack
* kselftest-size
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
