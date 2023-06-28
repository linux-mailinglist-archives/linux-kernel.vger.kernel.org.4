Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84314740A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjF1H4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjF1Hyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:31 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462171BE8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 00:53:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3fde1d6b1c4so46143181cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687938825; x=1690530825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOL4fhmYp/J1U14FeZJzgC75kK+fB1QnqyhzqYSaFWE=;
        b=nx6kC0qhHy3VHWXWtE7rYqrbcjbM+7T2YfC3HUGNqpog5l329I1sNcYXFVg0J+Hz6j
         tuGoaXDWCkXgBQMWakeRwH5X84hD3dzytzwdS3PiDS3EPIcpmbqMhi9jwg47GIKR/Ga+
         SxvDjbo0j0kFxGMm9y+BrO3chr1Km8DWxDJLIu/xC8DD+zDWw/SmQmD+NSVYXYblsciK
         nLJd+2ZsQmBw9ULukeEr5aL2cC+BDewBLPF0m4GN3w6lsM+1S5taeunrqmWh0d8EqoRn
         00cOzKzk8lo/kyF7w5rEfrl60n/TWRWXcGjWTMJ2zYMhBNxiKy75QbCLHwNFkT6AjZop
         +AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687938825; x=1690530825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOL4fhmYp/J1U14FeZJzgC75kK+fB1QnqyhzqYSaFWE=;
        b=PDhq37ggvE6nuCjT6dmGFq616AAbWAUILR1cGlaOH+bcdZcm48QohfvyFxzNfBGnHZ
         OYs9NNcydtE5mdPwZg3hDdu1BWWW3nlIKZnyX2XcEKnqVBQ1t218Hm1LF6DiUknYOX5E
         m+lamgcTBrPIcwNjch/hnOjbPtI4CmS6ppHQkoET2jUaBxf1cgtLs4yBmqGkxAQoNkbu
         dKvnA1yR9u1FdA6ylXHd9UKov3jCgHVlZlqDx6M6v0ZrlalvPeJENpL2DSNtrGkf7kUS
         aA1A64ja6DtwKb2eN6ndd0xb+ovIWx0HzkJy4eAMjCWKBnqWP+xEqSh3HMxJdeRFiEmP
         BB4A==
X-Gm-Message-State: AC+VfDzOEktRNAM2PCWzK0/rhrHQOmWuc42nnbDC1x51wp50KCzGfYPF
        kLZP+nM5jFYUnLPQK+5ujLbi7HNDfpawWqZIRwtcp8JPifNGHDxSEtM=
X-Google-Smtp-Source: ACHHUZ7A4S4HR26N/0nle94mISPwYAJezxHfyXA6h00XeHK22z59tuMAimzyRG3vETFa6AaudIHR/709SL3eA5vGSzc=
X-Received: by 2002:a05:6102:3c4:b0:440:afd7:cfe with SMTP id
 n4-20020a05610203c400b00440afd70cfemr3062445vsq.31.1687934546023; Tue, 27 Jun
 2023 23:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180746.943455203@linuxfoundation.org>
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:12:07 +0530
Message-ID: <CA+G9fYvcu1z5PUZfUx3VXgwSWrGpnUxgy+gxuUZwPzejpkDRSg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/96] 5.15.119-rc1 review
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 at 00:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.119 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.119-rc1.gz
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
* kernel: 5.15.119-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 27883eb9b47ea94a1f340d622c1dbf8680cd90f3
* git describe: v5.15.118-97-g27883eb9b47e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.118-97-g27883eb9b47e

## Test Regressions (compared to v5.15.118)

## Metric Regressions (compared to v5.15.118)

## Test Fixes (compared to v5.15.118)

## Metric Fixes (compared to v5.15.118)

## Test result summary
total: 111617, pass: 86213, fail: 3043, skip: 22291, xfail: 70

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 35 total, 32 passed, 3 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
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
