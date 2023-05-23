Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD670E011
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbjEWPN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjEWPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:13:15 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4867E53
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:12:57 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-43951f7004cso499530137.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684854776; x=1687446776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wM1YKWaacw+NdtLLmBxHfmkkg8JjnMl7i5I7vNTn000=;
        b=Xl3zO5U/LOWrttVk2f4chMKbB1rCO/AKfFq864Ms06Hlmc5JrbI3mB2CTEhGeh59+A
         USQ4f2oiGlDP9AgnFTuldw3t6WxaZet6Zc6RkQiFxDbYIuATPISk8qdW/55qKyV8gzaI
         Mv8bJEJME0nZSBoQYZlmABK/zrCEcsubaR1jY60z2tw0Z2s/hJ6tyCryR981JaCruAYe
         KK8xsNnwqKJl270pWZzpGLH59OqzRjumnPea2048Sikp8ixh3t3YtwX27XmMh62NpGV0
         kQ6I1YBdLrSd3vxGXDZTjSbAt8I2iPHIEM7PYpdliVDUPPrmB20w655AbSgrBfSYcmfw
         gaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684854776; x=1687446776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM1YKWaacw+NdtLLmBxHfmkkg8JjnMl7i5I7vNTn000=;
        b=eatkkV3hCj88S8Jn6qIEp39TDLgc3Ry+fhZ2HGxXxwx5cVO/65PGeo1ymCc4Usl61j
         nCRPEkPwqIVYB2NlA7FtjDdzlajejOJCKXkfc8UxnS8l1HLb0y/rfzcGrVpiNnrup8Io
         jwxBb/H10ZD4aPrRLGpoB3f+Nsmzk/CBTdhr5Y+WTCb1sHkD1zFKZIKKng1VvPRQAiK1
         PoOOaluCnyXyzsKtf0/yjUp0oZxLC8YyUSvDVOSCJ28/AcAfj86K3WTk/+W5oP2K3kIp
         lVRzhW2/CdZ5vM1IQxXIoodWkO5PqgXpK/sgIOyRn+CYotTsicxDlqPRXvunDZKbBlcy
         ktOQ==
X-Gm-Message-State: AC+VfDwcql4xJoJ0hRafC3rwddwxh5HFe1NAaV6vm6Zhs+dm5fxJKVFw
        sIPdnNJw6UNnvjVIFoFvOP6kRbdoJBmdUyyfXakSpWTR2uLzSODTHd8aiw==
X-Google-Smtp-Source: ACHHUZ6Fbls4Hr+vpUcVFLgN7YzytVZUIM9F7tEEsVGhXlMX4agOjAeXZ/SyRR6huCZiw8MmL0k27vvuVmLruG4zkkk=
X-Received: by 2002:a67:b912:0:b0:430:a6a:a91a with SMTP id
 q18-20020a67b912000000b004300a6aa91amr4273383vsn.5.1684854776090; Tue, 23 May
 2023 08:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230522190354.935300867@linuxfoundation.org>
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 May 2023 20:42:44 +0530
Message-ID: <CA+G9fYtdPZMrPWnhj1c-KEM=_tMNYnHuksHCj4wGD4XT4g9QAQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/203] 5.15.113-rc1 review
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

On Tue, 23 May 2023 at 00:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.113 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.113-rc1.gz
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
* kernel: 5.15.113-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 30213a86a6fe2d0296aba978d583ebc81793df40
* git describe: v5.15.112-204-g30213a86a6fe
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.112-204-g30213a86a6fe

## Test Regressions (compared to v5.15.112)

## Metric Regressions (compared to v5.15.112)

## Test Fixes (compared to v5.15.112)

## Metric Fixes (compared to v5.15.112)

## Test result summary
total: 132109, pass: 110178, fail: 3940, skip: 17810, xfail: 181

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 35 total, 32 passed, 3 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
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
