Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC90665D18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjAKNxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbjAKNxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:53:20 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA71277E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:53:07 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id e7so3681230ual.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs8zNDDs0guRBNHJ+MuE4jpZoikoTxsHLHrp29d2KYE=;
        b=VSqZBh8nG8YKorjtR6me1swYJUH5mQpYp0P9RxKY5fV1Ni6HR//9epzpnGwN6Mrf8z
         F5juGLQxg1Z041QTfRuOgGyHWgqmOvMrqzR5POFfCRKOfzobH/w2jGR+7aOu1z0J8AoW
         Yn3PsJsFn7qdkvBV3+je3msp8jQy1x1S3cwiI7+SSyQ6i/7tF7fFE+R7/K6FKf9sOUvx
         RPpdfWC2De9RSV27gtIVJS/kdYq5HzDkd35A8zT042fGbV78agXpmdaNCwv3mEPM9vjZ
         lEP1dzhNlQKjLjtH5k9rpc6DL78TG2zH8kYpRt963JlnexC8LvKzXRhP/Ey9cPdd2HG/
         Ty/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hs8zNDDs0guRBNHJ+MuE4jpZoikoTxsHLHrp29d2KYE=;
        b=PrO1QtJ3hnbmVE3Ioum4vjB7nQ0WSsPDYjYzn0KNk0I5VUE5Lg9uFF33DZBL0i+vbF
         vL2T6GbBqzvQSDtnEKAZbup0xReqFH0TQsPaW8byTfoC4ven6yl0yiIclgV2YS5IOLPD
         VBlGfDlbu0e3Xj4v4+yd5TVaNRd+ezXXE4LIx01hzHI5jAvYw4CmQzUnb2vvJ8WD3dL9
         mSyNH15q0PfJkrYDq1OPOMqKvfJvgsLYONWJPPGdyjBHnTCwLy0MB4h1dYHZ3n20GQ4O
         9tlGEPk2OKzLNfQGltVi7oI2RkGljr0VGn5sVrNubpTaMRoO7SuJWSdY9/pZSFs8YBnJ
         +KuQ==
X-Gm-Message-State: AFqh2kortCNVvEUoIfJv3m9lpde+41oOR9Ss29+smWC5cELoKHKFm8YY
        4WXJGjo61d5HxUXEP0Rhr9jbP3Me3KU6t0TDbnnByg==
X-Google-Smtp-Source: AMrXdXszpcVXeyvXDiC3YTLc+H/R45k8PlHBCpTF08kbAkvIrxuiMiEAXeDO1gGNZboW8F3gQwuLGGvWyEYBvXvZRMk=
X-Received: by 2002:ab0:251a:0:b0:5d5:d02:8626 with SMTP id
 j26-20020ab0251a000000b005d50d028626mr2219346uan.115.1673445186568; Wed, 11
 Jan 2023 05:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20230110180017.145591678@linuxfoundation.org>
In-Reply-To: <20230110180017.145591678@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Jan 2023 19:22:55 +0530
Message-ID: <CA+G9fYvfhDRhOs2ahCVS5L2QRSVeO6m5AOY3K6o751U0rxgmvA@mail.gmail.com>
Subject: Re: [PATCH 6.0 000/148] 6.0.19-rc1 review
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

On Tue, 10 Jan 2023 at 23:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.0.19 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> NOTE, this will probably be the LAST 6.0.y release.  If there is
> anything preventing you from moving to 6.1.y right now, please let me
> know.
>
> Responses should be made by Thu, 12 Jan 2023 17:59:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.0.19-rc1.gz
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

NOTE:

Regression reported on arm64 Raspberry Pi 4 Model B with clang-15
built kernel Image.

Insufficient stack space to handle exception!
end Kernel panic - not syncing: kernel stack overflow
https://lore.kernel.org/stable/CA+G9fYt42ntYZhhzqAYKf8J3TdNZ+fRYwNgQP=3DTgC=
LODcpNrfg@mail.gmail.com/

## Build
* kernel: 6.0.19-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.0.y
* git commit: a7ffaeeaf9bb7ab13e00a589d0910efb9119479c
* git describe: v6.0.18-149-ga7ffaeeaf9bb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.0.y/build/v6.0.1=
8-149-ga7ffaeeaf9bb

## Test Regressions (compared to v6.0.18)

## Metric Regressions (compared to v6.0.18)

## Test Fixes (compared to v6.0.18)

## Metric Fixes (compared to v6.0.18)

## Test result summary
total: 167741, pass: 139653, fail: 4441, skip: 23296, xfail: 351

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 148 passed, 3 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 39 total, 36 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 32 passed, 6 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 42 total, 41 passed, 1 failed

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
* ltp-math++
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
