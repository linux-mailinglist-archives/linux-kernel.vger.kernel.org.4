Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5472DDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbjFMJkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbjFMJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:40:30 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959CBDF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:40:26 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-78a1e095508so289714241.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686649225; x=1689241225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWL+8F4wX9QAkgda6QyJxqZXMC6jN1JJ2qnzQJBp1LA=;
        b=FWNDnQrHaBxGSTCFKvGpSOnoHQIMoP+4atd30vuD3aEc3PZwxblz4336lsE9Oah2Jn
         Kl6KLUMpSxcu05FzHx3wQESkClCZxlQ4rF225tHHAB5XZz5BHl7X+MvmgA6W9VYo5xPN
         QTyh6tX3zGg6Hr1gQ1thoElaL47qUkO4ZO3BJ4Kv1ZLU9o5chPmwrSEYKCTWQFKlVCpQ
         024ASjyR8PeKOaNHGNOPnI61D/R+fxjjsHp1H5JG0N6uNAddKTuDroG9Z/6B6IeFgN+F
         VIUCZLOObbQDGA8WBnsIwicoA34oOeW7+MfaKn6eUsjTrEw6MDrZoq8Dp6HO4S1uYaR4
         5q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686649225; x=1689241225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWL+8F4wX9QAkgda6QyJxqZXMC6jN1JJ2qnzQJBp1LA=;
        b=jrCathFzqwkElVK5bv9ZSgTetu5tf1Mb0O6xy2zrCiQli3lhUZyHSqrBtxQpBu/7+1
         nBUiqB/XIrmHPPIkLiQ+wX3voS+eqliAUM1ZKtvwXTMU3aRajcLrcowU/LKXcLC9vFrW
         kH3yoN1sZE1AU76uY1oYujVMUQvy2gVqu0LwUkjSfqwAqi6swXBL3QT5LFxT/dyOunt5
         OwfCGllBmxVKYcy9V6B1ajNDjhKDzpi192/OQ1YS95ZsQwO4BDa4eys+EH8SSR5hHXRh
         I1/hNJHlPdr7JXWxLntMhnEac4ZY8KhalMpUkvScAE6upaHGTrYZ2mynBTUtrtr0MS48
         S8wA==
X-Gm-Message-State: AC+VfDytil+LgrDG3AabEsGJt4dZAiDAQALlBz3Mgdqj42/qubE8eXOV
        DE+tLVm8hp9BJnLZsA9omwYcjR1w55YP4+qamAMmdA==
X-Google-Smtp-Source: ACHHUZ4EWfyHA5rw2XRBroD1azAfrmIXM3Fz6jopLa5yjoIdXhSqZPmSLZjjsADXUBn9iJmU85TtEMrvKH806787l5c=
X-Received: by 2002:a1f:6051:0:b0:464:c5aa:3338 with SMTP id
 u78-20020a1f6051000000b00464c5aa3338mr4506802vkb.15.1686649225448; Tue, 13
 Jun 2023 02:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230612101651.048240731@linuxfoundation.org>
In-Reply-To: <20230612101651.048240731@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 13 Jun 2023 15:10:14 +0530
Message-ID: <CA+G9fYvOtkh4H2CLn=ogogxz3S6TYcbS_YMGHpgaoeP6XQHeAw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/21] 4.14.318-rc1 review
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

On Mon, 12 Jun 2023 at 15:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.318 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.318-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.318-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.14.y
* git commit: 6958cbc0ef5cb58a12f24faede15c46ea71a1975
* git describe: v4.14.317-22-g6958cbc0ef5c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.317-22-g6958cbc0ef5c

## Test Regressions (compared to v4.14.316)

## Metric Regressions (compared to v4.14.316)

## Test Fixes (compared to v4.14.316)

## Metric Fixes (compared to v4.14.316)

## Test result summary
total: 66388, pass: 56634, fail: 3131, skip: 6520, xfail: 103

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 104 passed, 4 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

## Test suites summary
* boot
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
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
