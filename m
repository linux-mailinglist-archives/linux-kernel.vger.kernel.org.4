Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E6472DD38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjFMJC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbjFMJC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:02:57 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85161A5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:02:55 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-463fdee669cso3657294e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686646975; x=1689238975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8GrSifCz49aZ98QowmS7zz/X3J0dQxhH0/1YzTAdAw=;
        b=h8SlbE594Rls0nWuMPFh2Utq/W24JSKrwAxh+0DqkqXVnG9Lt7MKBXyoW4YuPNrq0C
         KTk1ajaTCwCIeVgbwcxNx2KzHueJh/xEoSTcH8pXw+wES4AxDvKNcajX0LMPbFdMN5iA
         JYKsvcWk1HpX6VoSpzv+xrNJ632GM9jOWVuh2jFmn2/nN4DRvrJIQyDFeje751MV2f7h
         DwpAk9h1sTpFLB7brurFiar2PWGP++cRq/22QXyPYhr4u0mmo0chK0aEMV336bjiHywN
         tKTIjtZbN2ku/IkB6g0BoNN95cnlvuMAJiBrpFPoo4VhGdiT/nz1Ja2UtKuJTSONggCB
         Vq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686646975; x=1689238975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8GrSifCz49aZ98QowmS7zz/X3J0dQxhH0/1YzTAdAw=;
        b=iNfKFKI5od+CP+ux8fKFcKr0blM/tOlFQ6epgDhOF7IBM+78umpfQKHjYHTcNUkG0i
         nUckA8O4Ssiy2rJis/6hrf18Zf66ja2K8U1X1SigdFCxSO9Ymma8DyXAPWXeioRWR1ZS
         ygvZ4Se3sXgat9LupARFmGK89yQEJePDT1Zu5dsmIXiPzVuKHTBc0OiXSLRcQN/FTfEj
         4i091QbKfhUpxc+MrroKi6hM5u85fM+apATbXtW5n3au0jnqbkREkb6JOax1VzbdzXpN
         /CXCxvK5OEpWerUhkHeDohi46kmC4vgyMqkExj6zCGIWAXbPSK1Cv80eTYXB9Z8xhffp
         hO3Q==
X-Gm-Message-State: AC+VfDyRGl+XAdTSuq7/pyQD1iMmiIxDg7HVrMOgIn51NlEGe9RXMuae
        jmHKxsqVpiPlu5PZVCTKoIFu2xj1qmsJrJ2nR8CLrg==
X-Google-Smtp-Source: ACHHUZ472ELf3akgi2xGU5AUTtDTUzVkI5rji7GVrCbWRiQMLRH3A90uY6PmW7WUt4aWW5rOkqxSveRWwYed681zXxE=
X-Received: by 2002:a05:6122:a17:b0:456:f5b7:837c with SMTP id
 23-20020a0561220a1700b00456f5b7837cmr4935535vkn.1.1686646974684; Tue, 13 Jun
 2023 02:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230612101658.437327280@linuxfoundation.org>
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 13 Jun 2023 14:32:43 +0530
Message-ID: <CA+G9fYsp+5r2F8asPXzvsAq8_JYuezL+qYnj4VN3oH0T_bP9vA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/68] 5.10.184-rc1 review
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

On Mon, 12 Jun 2023 at 16:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.184 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.184-rc1.gz
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
* kernel: 5.10.184-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.10.y
* git commit: 32cae866b1825021bd263dbd8dbb522e1d0df8a6
* git describe: v5.10.183-69-g32cae866b182
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.183-69-g32cae866b182

## Test Regressions (compared to v5.10.183)

## Metric Regressions (compared to v5.10.183)

## Test Fixes (compared to v5.10.183)

## Metric Fixes (compared to v5.10.183)

## Test result summary
total: 127773, pass: 107744, fail: 3845, skip: 16007, xfail: 177

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 35 total, 32 passed, 3 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 25 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
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
