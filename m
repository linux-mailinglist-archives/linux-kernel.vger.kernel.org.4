Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F965A351
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiLaJMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 04:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 04:12:48 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11C2B1EE
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:12:47 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id n205so4042623vkf.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7nZRxEKSVk0taYN2kEmqLsK8D/a7ZjrzRfmuGsGVgo=;
        b=BCG98/thMeSUuI8QudtVR9vY3JQGMQf+poWtQgCqt/vkbqnBJqCAtDnMq/uMIJn8RO
         ZhzEFiWHgtPNATlh52XgAlCTPrkTB1Gcg/jn2Yx20iRN5OWa7AtjQ7riuMnH1vUO9P4r
         Z7wNQLi9dDy+o9TxKvtKl32v4l3ZJejLvE3ZPojCA3MzsdkymeQ6F47twuNBtWTbC0BI
         CJLznK+oHuXQydVqNISGQNaZk6NjL4kEmElCv45/WJS4EMEcr4iwrJ4gyJApbkCmc0ij
         hv6Ustkl6L87RsVnqqVjGCD3nM2KWOMGJesqWK/w5VsHWtkFMOk+HUO9wePKxELC54vD
         sM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7nZRxEKSVk0taYN2kEmqLsK8D/a7ZjrzRfmuGsGVgo=;
        b=h0fCQ2dUt0x5oYyB8VQECaBWsnlobRA0klOaGk92sDP+YryuzHVU62jzx+TVgJwGcZ
         orardatTo/c0LcyKpuT1n8t1oh1RPWMs9V8WfIZNTQvPG2je7r3fjitj0dI6x+ObWVYB
         9N+Qxz8HkbyqdrZyS55pJ8FcQFqdCOffxJecXKc3UdS30usL4OpeY+gxN7zJBgYUu80n
         S4Z0SLe9uUXPhV2JHnMeaARxYjykoJ9rtvr186W1wd/E68AVniAjRerynKLpqYNULNAE
         ZnyKIwZABEVC0blkjmO84rKEUG6cilanIELTLjFj+sQXPLc3v7oDVNDCr62Lh0VP1JRf
         VQrA==
X-Gm-Message-State: AFqh2kpiqmcLLmNbODffbaRT6pJ78DL2wN6se3TCAiEYSYZZ/jxU86Kt
        ZqGBneViGENdcDhIZ9BenQbRIELcK7/hLCi60SIAAA==
X-Google-Smtp-Source: AMrXdXuZl5Fg9dS/lm6Xwp0v0J1CunPxyffU28ZabuI7HLyOGnaBDj5/d+WeKrmMhhPp+Is1KyQw/S1VtfVD4avzeBM=
X-Received: by 2002:a1f:3215:0:b0:3d5:86ff:6638 with SMTP id
 y21-20020a1f3215000000b003d586ff6638mr1125362vky.30.1672477966697; Sat, 31
 Dec 2022 01:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20221230094059.698032393@linuxfoundation.org>
In-Reply-To: <20221230094059.698032393@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 31 Dec 2022 14:42:35 +0530
Message-ID: <CA+G9fYv8nE=1TZUFopiG9msoBExkkcGWyLTokiO79-JQFwMUNg@mail.gmail.com>
Subject: Re: [PATCH 6.0 0000/1066] 6.0.16-rc2 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Dec 2022 at 15:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.0.16 release.
> There are 1066 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 01 Jan 2023 09:38:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.0.16-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.0.16-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.0.y
* git commit: f54b936f8ec726a772a7c0ca5c77583bd0f90b7e
* git describe: v6.0.15-1067-gf54b936f8ec7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.0.y/build/v6.0.1=
5-1067-gf54b936f8ec7

## Test Regressions (compared to v6.0.14-29-g65f3ab07fb24)

## Metric Regressions (compared to v6.0.14-29-g65f3ab07fb24)

## Test Fixes (compared to v6.0.14-29-g65f3ab07fb24)

## Metric Fixes (compared to v6.0.14-29-g65f3ab07fb24)

## Test result summary
total: 147899, pass: 131296, fail: 2681, skip: 13616, xfail: 306

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 146 passed, 5 failed
* arm64: 49 total, 47 passed, 2 failed
* i386: 39 total, 36 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 32 passed, 6 failed
* riscv: 16 total, 14 passed, 2 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 42 total, 39 passed, 3 failed

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
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
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
* ltp-ip
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
* packetdrill
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
