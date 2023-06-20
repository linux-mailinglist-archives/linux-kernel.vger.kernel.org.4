Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDF8736DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjFTNqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjFTNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:46:14 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C903E1BB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:46:12 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-47148f11fe6so1767596e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687268772; x=1689860772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcJCG56qv3SmBGDxfHQD2CThgz4mtwNLX+rRWuwbSbw=;
        b=C6lG92cgKkpAVqdPf/+kfYhbGfzGw0ijZRCo1LZ5+Dds967JBZd/mMhSmnIalidWWy
         yhBnmSpWERId0kz3K4S+579oH1XNQy4Cbl1bnGqVFB5YnbsCX1aEu6nBBtFocfURNW5l
         ekCO0yCPIxJWbYbd4LLvhl0Uc3n45EhNWzFK6yQtBri1Zzy3EifQDSSerf2w2XZ83j31
         o5A6taC6X1OVjML94K4vZnvwRPxyq8yFkVMSlwkURpbLS7f2IMIFqqfPG0fB4+0fcSgJ
         8W8xcXeQ3HTNaau3QzwBgWGsWvCSqp9D2SkaNBuyhDZvk9cONGJHi0v5vqhmVzmWTaB+
         zxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268772; x=1689860772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcJCG56qv3SmBGDxfHQD2CThgz4mtwNLX+rRWuwbSbw=;
        b=XJbgJzGyQXM5OHPPIJgkWfDV2cDXWlfw6xMoaUE5OWCTcew4S+XeYl/tIXMfE/RjeM
         cuh2iKMRY+m4gmz8Z4egP5ased+UR7rGFVBuaBUC6kdA4KMrEW/J+zurG2aH+RMeWE26
         QCwQptVJvpwyDupFQjZ40cXKzsRYWSHCrBNww98Xee8GHxEHEFMEkoJhqQ+5OcLfjta6
         I5C5YK8gJ6jUltIpp3nI33yFDIx609OHygsbCGA61jv65bfTHtoQI+3rmqzjC2fw3WcG
         7u/xRjDcU7l3dSYYv21WfATD+RMoEFpJYshVrVdBzSWEMK43Jl6geNmspnQ8X4sOTFMq
         a26A==
X-Gm-Message-State: AC+VfDwls192XORTzoVgDUdU+xu08Z2IGAS2bp6apCblEWVC+Ko1eiAS
        J3WbMk/2oYD1D9wOFX+f8nAksF5UEZ0TOb1UQe4E1A==
X-Google-Smtp-Source: ACHHUZ7LyLpgdajqJ8eAW188Ghx5k/iDZpGh8m5wskPIyToCVUBLZmhjwi1g5PH+fXKJaQSqUxbkRjlnnvaKZCQfIYk=
X-Received: by 2002:a1f:e1c7:0:b0:46e:7102:7211 with SMTP id
 y190-20020a1fe1c7000000b0046e71027211mr4487185vkg.11.1687268771687; Tue, 20
 Jun 2023 06:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102141.541044823@linuxfoundation.org>
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Jun 2023 19:16:00 +0530
Message-ID: <CA+G9fYuLStZT5JN0DngsfeTZf_TBLB1UQqEcNgDJYaut_27FvA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/107] 5.15.118-rc1 review
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

On Mon, 19 Jun 2023 at 16:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.118 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.118-rc1.gz
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
* kernel: 5.15.118-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 71c980089d7356d54f2dc0be100c29d8c4534602
* git describe: v5.15.117-108-g71c980089d73
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.117-108-g71c980089d73

## Test Regressions (compared to v5.15.116)

## Metric Regressions (compared to v5.15.116)

## Test Fixes (compared to v5.15.116)

## Metric Fixes (compared to v5.15.116)

## Test result summary
total: 133496, pass: 108841, fail: 3835, skip: 20716, xfail: 104

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
