Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50676F20B1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbjD1WGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjD1WGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:06:38 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C14213
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:06:34 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-441134c09cdso197587e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682719594; x=1685311594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9K80hMY7rCwgO/zSjWmhZpx2GzE+k3UH+Jmat1R7EM=;
        b=eUdmhOS79VIY5PrysVQqlPafNuT/qALkQnqdcWynQ67fm1IZQ1W7ies/ytItECnulr
         fxyFIxIQoYh34/d2eAfy14S9vgM7Ln5iWH61RDHu1z2eYTNInmszAeKKPoPUw36F1ns8
         Emw5rl7DGmCe9P2aHSKvzH4WTCt/g406DTlkTQY1S51pCzTku9khoiAgNT/yRTahDlrR
         8w1yrQceLKbB/OupRj5WzNCfIzE5XTlHjwG3nZotpEI23CFb8ys3pgEz20z7V2nch59L
         XYpL0J82kvlJ5kdUlcLJVf1K3a/QMz6PJ7ags7OEPUVLTRV0FaqhVKnySx+mnsLv0gSd
         6USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682719594; x=1685311594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9K80hMY7rCwgO/zSjWmhZpx2GzE+k3UH+Jmat1R7EM=;
        b=ZP9DCRSMKlg54naXZ3G6zVElXARvffnvgZCmeBHlgz4SA6xo6mYbVXwr8Q7cLR8m6Y
         emBZAMUClAbEEqI3Rn9BsH9/Lv0HtLQYuTmTfMKv8dKFXnRb/1ZojZPNBK4rL7Iahry2
         ZTl987H4tLXsy7j8eCroqQKgf5D0kN0gLJezMcK/Fx+ab0Y/PsxtENEAGEUwOFHCEczj
         hQwwjQg8Q4OhRzJh/RW5tbRQin8pFfRrmpZAU0p7WuNsy6Dco7FPgYLASm4U1vMUDYjz
         pEKHc3NwRuPqqdLIRNYouBqf5xolKuyDlR5FNa2PJz/+EFcKDNBLInS54bkHf46gNn+F
         5OXw==
X-Gm-Message-State: AC+VfDw94tQPoQyhO4wX4LRPuiLim2kWEhkFbOLXS0pV5RCcgg5DxbuW
        vRQht2wAxSmvSZfnhkv88GdBtmh/9uvKdu+Atan0Nw==
X-Google-Smtp-Source: ACHHUZ5U9duRLvzuJpV5ogK40dUyZPN2Ti0VROanHSH27hht8Wm1VUbD5/57xwqbIsd/Qby3+Apina5jK2QL792Wv1s=
X-Received: by 2002:a1f:4ac4:0:b0:43f:bcad:db6b with SMTP id
 x187-20020a1f4ac4000000b0043fbcaddb6bmr2810332vka.10.1682719593906; Fri, 28
 Apr 2023 15:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230428112040.063291126@linuxfoundation.org>
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Apr 2023 23:06:22 +0100
Message-ID: <CA+G9fYtLzqqLrr45dO5NS=AQar1P+zeNa4puGwALU-BVeoqChw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/16] 6.1.27-rc1 review
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
> This is the start of the stable review cycle for the 6.1.27 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.27-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.27-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 58b654bf36db7c89178300adbb034ce63301b685
* git describe: v6.1.22-591-g58b654bf36db
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.2=
2-591-g58b654bf36db

## Test Regressions (compared to v6.1.22-574-ge4ff6ff54dea)

## Metric Regressions (compared to v6.1.22-574-ge4ff6ff54dea)

## Test Fixes (compared to v6.1.22-574-ge4ff6ff54dea)

## Metric Fixes (compared to v6.1.22-574-ge4ff6ff54dea)

## Test result summary
total: 158499, pass: 138000, fail: 3707, skip: 16470, xfail: 322

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 48 total, 48 passed, 0 failed
* i386: 35 total, 34 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 40 total, 40 passed, 0 failed

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
