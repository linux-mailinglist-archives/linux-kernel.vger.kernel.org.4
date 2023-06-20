Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9473632C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjFTFaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFTFaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:30:01 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3540010D5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:30:00 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-78f3f8ecc42so802053241.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687238999; x=1689830999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=801oa+DLA4Ef9kDMkAwEab4R+1WW+i+tgb6pOy6o1MY=;
        b=bywN+ROadmbYEi+zWpU+PUtZTpC2Plg10u9tqckzJsfSr2C6Th4SVDoL4EfBulUDrC
         xz3IvnD7ALxdVLQSvPutW7Ykxwe6Lg2zirtBEBGy4WWwfbQQpbTv97OU/bi1mq1aUnHb
         hzIYYPgWDf5p2iuRaG98bGv54hOz/+tvWasN+pA6BPWtMeGE+oiQMwbw2QaKsBxQZCZV
         1uOzqkMU0PJtg1wC3mpLBXZJStNUfGeWv4iQD/15ynslzgxoxjtdsoPVIBJ9IdkZ7wIb
         sBmp26M5qh1TOOtayY1zJME+UYOGEHF3dgUxi8owL8Ys7QXVQYXOMgA+U3Qs1k2Nbb8j
         RGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687238999; x=1689830999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=801oa+DLA4Ef9kDMkAwEab4R+1WW+i+tgb6pOy6o1MY=;
        b=Ff93swpZGdTtJ3b5R6OzJqZtDEChz0xchGNpwKOawedxeRdn9wlQsmE5HBEmvSNFAZ
         pwbKlpb6gsDM3qPuRsvZEiFlg4CxgMkOnlGBMQalYbVNsAn2HUG2PUYF1oETihz6lgy0
         tBkl7UItj9yd9Y/9iF/GRzFsyAdZPw1Uw+id8mTOWH8YdbDz/n+06D6AsIefyDwh2oDe
         dSviZeotNg4KvB5WSc08OqB+g5ximW6pk4/QXsWMckOgmFTlrGhlZxsYYG6UkP3+xK3H
         LVDW2Z1rp6KHAqHxv/BEByMed/Ef8bWNpyZ9+cG6XF5uFCvELIjM6HYDCcT4k9LfWwWV
         bMHA==
X-Gm-Message-State: AC+VfDzqFJpd+V25M6zYvepGjLhlWAwdlVqB8shp2M6NRmICKufdbkiY
        CCWLMAEaz4HkVP2s0GNrjeXZBwiLmYPgKfVXrlKJQJhE1Jo4uzf+aA2i5A==
X-Google-Smtp-Source: ACHHUZ4vlUUcBSkw3SYLsCg6Zuqv1wWvojRjlGXb7Uhi4Q75I4wVrEfAF4UbAV3+Tfu5H+e+wLtEUhvT/Fp4S9lv62w=
X-Received: by 2002:a1f:5e48:0:b0:473:4e4d:8a8d with SMTP id
 s69-20020a1f5e48000000b004734e4d8a8dmr84082vkb.11.1687238999085; Mon, 19 Jun
 2023 22:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102157.579823843@linuxfoundation.org>
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Jun 2023 10:59:47 +0530
Message-ID: <CA+G9fYv9fWPCKndjk3Fy6rF2v-MusMarhV5Ppd70TEVCzDYvnQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/187] 6.3.9-rc1 review
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

On Mon, 19 Jun 2023 at 16:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.9 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.9-rc1.gz
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
* kernel: 6.3.9-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.3.y
* git commit: c4f2a2d855d4abab5f904b8deec55ff390f954e0
* git describe: v6.3.8-188-gc4f2a2d855d4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.8=
-188-gc4f2a2d855d4

## Test Regressions (compared to v6.3.7)

## Metric Regressions (compared to v6.3.7)

## Test Fixes (compared to v6.3.7)

## Metric Fixes (compared to v6.3.7)

## Test result summary
total: 181373, pass: 152623, fail: 3225, skip: 25380, xfail: 145

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
