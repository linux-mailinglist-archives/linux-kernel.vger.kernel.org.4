Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE7071FEDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjFBKV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjFBKVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:21:24 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177D196
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:21:17 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-45d59140bbdso520566e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685701276; x=1688293276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBezHgYwRvoy/30efbcqpEXiUeiRogeG+y2B1YMTHYs=;
        b=edvApyK85bfEP6lS15istJQVTcXW+61AuwurR1ydXgzbRPw9V9Wi9c3zZFqAH56qwv
         DKaqMV6c7lA5I/TQEhJCw26fEXLGjspw6jMVR6S4905OvndauU1pzxlNUckeghsQb/kE
         HLstWkln5sf1MGDWlQwqtRkdre65hQhZa8qqFpQ+8enaqKdDR08+hpzHtXZaOrLn8fX7
         UQQ5gv+Z8Uzayu/spqmJ1sdTn9niaNQjGwSyUXCh/qVL2Z8ZvJewRL1ZI7kJ6nKoNHzU
         jTBvkBoNVvtonrAZTkg5elU2Dr885tMaCnh/EM7/zHXJnEDgOgGQSZxDgcyFF5rR2KN4
         SrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701276; x=1688293276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBezHgYwRvoy/30efbcqpEXiUeiRogeG+y2B1YMTHYs=;
        b=B5wvkM5MsowQGH2BbByCghAo4nIXmtyl3ApcBWcRMGKrjoUOOjRm4rqxY2bM9z6Qb3
         4iZ6jHF3N30A946lyu08wHsY/0UJpBKVoekSuOiy75+CFAJNdptPkafRopY1NGphk1fz
         7FRdFpKcD7Y7qb+6BD3KgwADS8NcJonuHFnyo1EnUpINwmK38WUxMFaj6w0djDUa8xWd
         tTaFeRTtMK/zdvO4O66N+W2YUWlKHFBtryS2LrYCHr+PWf/iio/KUl1+OW4SnCZ/gu+g
         VOF8BDzDM5UoY+kZz/oT+8otMYZq86mp/sU768GpQG30H94ZZsrW/ZZ7oidNvuHl8NvG
         cQgg==
X-Gm-Message-State: AC+VfDz04XK3ju4GLKLHaqVvd4AxY+hO0Y3PjLH03vtDZhNaf+oR/4A8
        8pEtQhVIvTjQMXY7w1lLy2kc7SENNCVxVXLW3A8SxA==
X-Google-Smtp-Source: ACHHUZ5SzZQ7B7ViN1sTkHdQYmF3seIoUX7LhsuMplA0qZUaAgk9t+x3wAgV6V9p/hdrl/KgRfGy5kV5Szao5N2LaWA=
X-Received: by 2002:a1f:5f48:0:b0:453:8a02:8d8 with SMTP id
 t69-20020a1f5f48000000b004538a0208d8mr2738435vkb.6.1685701276415; Fri, 02 Jun
 2023 03:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230601131933.727832920@linuxfoundation.org>
In-Reply-To: <20230601131933.727832920@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 2 Jun 2023 15:51:05 +0530
Message-ID: <CA+G9fYsGZoYD8t_zvrq9VcRhG88HWiVJ3rh_RVLBCi5gc=sSsA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/22] 5.10.182-rc1 review
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

On Thu, 1 Jun 2023 at 18:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.182 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.182-rc1.gz
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
* kernel: 5.10.182-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.10.y
* git commit: f2a19702506cf5aee6bf44c1a1c48520b2455d75
* git describe: v5.10.181-23-gf2a19702506c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.181-23-gf2a19702506c

## Test Regressions (compared to v5.10.181)

## Metric Regressions (compared to v5.10.181)

## Test Fixes (compared to v5.10.181)

## Metric Fixes (compared to v5.10.181)

## Test result summary
total: 100555, pass: 83695, fail: 2731, skip: 13973, xfail: 156

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 35 total, 33 passed, 2 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 26 total, 20 passed, 6 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 36 passed, 2 failed

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
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
