Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D840C6F20A5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbjD1WCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjD1WCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:02:14 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88884ED
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:02:12 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-771f6c049a5so189584241.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682719331; x=1685311331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4V4fWCdh5vAMScKzf2MsQ7kTvtaQZRkLxgm/CZVADY=;
        b=hTTblH6TYlpLAmysHUI1ipY4o3wPLKmOsTRPQXHBa2h+BlC0WLsH+kn+fP+IZMNcUn
         YIFJ2iAy7gw8M2ZcXah2tvSHCvM+31XOByL1ga68MhKccoKNj+/T6cDFtJV1dKsgz7YX
         0YcAxjPA+QA60BeKAj4jG/U0MNnSVw4Ik01RUPKMWAXiQzg8z7ffWo4d2x15RXRrvacb
         EoWRPl9gU8K/DLgAk4B57r73WchA9Sm3mjfWG5mXeYyDYxJIaf9mjGvMCze1L1SmtyT8
         mirh/kM1dz9LyW4WRbV7Q0CMIvrxfWDfrXdxD2h7XOsDhOGUkKpjgrGqDF1tG/Ws7mV8
         OrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682719331; x=1685311331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4V4fWCdh5vAMScKzf2MsQ7kTvtaQZRkLxgm/CZVADY=;
        b=CL618vwNFhgiHlCdgZmmZYl2k7+jGWji6bgaA9wd8B7pAMMkKaCYxtIPaHoV1rFBYf
         oljTojAiGU0UAW5hpHqdC4zAkcNF1GrhVKyqqgCChneLuxMHyR8u4mm5rZiIMMjSVioF
         trWCcF3sFLXjXAOBWZdUasK4fu79Us8oph7sfImJ64KwqHUzsA1twrAjQi5ylsUViwTO
         s/hL6SvIg4X1eIUxPQZaIzrDx7qEBdSk4h/8NusNcBw/HDvYoTXXhyfe7cK5xQfgqOXA
         4mgs+yIz+zCaRpQOe+U8ffZTz/a09/RiM0D8XK65p7kmpU/H0vB2LzbPXWBGE4JVDNfW
         OwOQ==
X-Gm-Message-State: AC+VfDw9JeBBkjiyP+uzHrFo9mD3qx6UH8MvQuUfsTAyLeqdv4eke5oY
        hLCi2ZudVimIqwaZzKduuSbm+Q2Oq7zx66YgznCFug==
X-Google-Smtp-Source: ACHHUZ4KMZQw81GlX4zGgLgdzHHbV7hpKnhTMesF9GuOxXRTaAQEVvP69R6i4H4omBxnLB5ycgpeslfPexYDPsKtdxQ=
X-Received: by 2002:a1f:ca47:0:b0:440:448c:27a0 with SMTP id
 a68-20020a1fca47000000b00440448c27a0mr3049086vkg.8.1682719331456; Fri, 28 Apr
 2023 15:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230428112040.137898986@linuxfoundation.org>
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Apr 2023 23:02:00 +0100
Message-ID: <CA+G9fYuTDZ36Z9qDHUDKQGj6Mm56xxiT_+M64fda4J+dj+=JNQ@mail.gmail.com>
Subject: Re: [PATCH 6.2 00/15] 6.2.14-rc1 review
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 at 12:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.2.14 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.2.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.2.14-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.2.y
* git commit: a451b003c3066aade2071a362d5d6d4a62c6da48
* git describe: v6.2.9-624-ga451b003c306
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.2.9=
-624-ga451b003c306

## Test Regressions (compared to v6.2.9-608-g9e5d20c13940)

## Metric Regressions (compared to v6.2.9-608-g9e5d20c13940)

## Test Fixes (compared to v6.2.9-608-g9e5d20c13940)

## Metric Fixes (compared to v6.2.9-608-g9e5d20c13940)

## Test result summary
total: 195174, pass: 163280, fail: 3868, skip: 27724, xfail: 302

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 141 total, 140 passed, 1 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 37 total, 36 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
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
* kselftest-vm
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
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
