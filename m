Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A17971FEA4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjFBKLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjFBKLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:11:14 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1D918D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:11:11 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-437e533af40so446357137.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685700670; x=1688292670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qed5EJFhX392M+0CSQ1skrxbY9OBLy90DVKGxzlxGqI=;
        b=Wia0nJDByt+Ozozz08X3wCpjA9aooJOYfRitMUuzLUFXuqYUpk7hZlKeiMQsihyuvY
         /h3JAOpx6I9JQSxnl4AYpdfxKNkQj3c0vigmS5HKFQbef6heC4nk3RCynqilXaduBC1v
         VgzKun7D8XibzInua5Ebmfdb3F8bC2mYqXs0FoB9UbmiwIaKf2quJ9YAaREcsCfhdWm+
         KoN3sOLisGJh8O/dZdS67nB60VBQpUFlJL7XHM8wLQ/v1HPi3Ke7qpGG5UdvDJCBXtb+
         ChCP+OkNxunXBK+z8z7oaC3hvBwNjUuToGn76dCclXLJYHEdxVsO4PGf+m7ymGBD7bFX
         90GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700670; x=1688292670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qed5EJFhX392M+0CSQ1skrxbY9OBLy90DVKGxzlxGqI=;
        b=GC9DZJILAELLUVMHgr39MvTwLQRl21+MZbpktgQpVTrVj4XSYgnyjKKrK/UXD6E5Q1
         pcd/GXPgGBALp0oHfcBQGI7Cw+Nl5xeyQ4CBTQK15etvHhv9bgoZlKcI3epRyTskWrVV
         99+U2QIVMbHN8uJp0ntZtxH51km2CMw5rbD0AQQjIwieC7uNQrkrE486JG/CVRM3ToeD
         4zIC0NmTvVPIVEjcsPuLP2FakxEoNSJRYJjRaY83CXCocquhwYO6gD0buEY76I4cC/qH
         3rGlpBW9e+286+ey2cscwxCvqVhQ/RLD55Ie/pRkJcwCAqlvuXLRhVlxkVW/fHVWZZ+K
         MvhA==
X-Gm-Message-State: AC+VfDwnKshDloAZ7b0v98GL1bxywMQeZBiohgN/SzLNEraw0sCuGjuV
        i2koQjjxqukfd+pgtUT8qDJuWqgm0XcWeIwAhYAU0g==
X-Google-Smtp-Source: ACHHUZ6d4FRxGLXBCWPRxyWeqlPK5cBhXYgtrnS5n6y5w5z6YuXCuLbwXa7hfUvoDIZIRv+VvZZ0dijaEeHwox/aj9E=
X-Received: by 2002:a05:6102:2836:b0:436:1501:ce69 with SMTP id
 ba22-20020a056102283600b004361501ce69mr3956339vsb.21.1685700669852; Fri, 02
 Jun 2023 03:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230601131931.947241286@linuxfoundation.org>
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 2 Jun 2023 15:40:58 +0530
Message-ID: <CA+G9fYvn2ag0aE0YsPv8W1W7j4CZDXVkxmTRRZdsiLbUyWtDUw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/16] 5.4.245-rc1 review
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

On Thu, 1 Jun 2023 at 18:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.245 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.245-rc1.gz
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
* kernel: 5.4.245-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: 50329515aa64a6882fcc2e86dfeb1e56d08d760c
* git describe: v5.4.244-17-g50329515aa64
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
44-17-g50329515aa64

## Test Regressions (compared to v5.4.244)

## Metric Regressions (compared to v5.4.244)

## Test Fixes (compared to v5.4.244)

## Metric Fixes (compared to v5.4.244)

## Test result summary
total: 109914, pass: 93670, fail: 2219, skip: 13853, xfail: 172

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 147 passed, 1 failed
* arm64: 48 total, 42 passed, 6 failed
* i386: 30 total, 22 passed, 8 failed
* mips: 30 total, 29 passed, 1 failed
* parisc: 8 total, 8 passed, 0 failed
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
