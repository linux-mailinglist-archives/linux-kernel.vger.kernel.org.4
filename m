Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D3736A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjFTLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjFTLEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:04:40 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7C10D2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:04:37 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4715cbe0422so1149661e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259076; x=1689851076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqB4Kt+s05pjxA1QBH/foa/uppjMlny8KN5MCdCCFKU=;
        b=Kq8cKXuyWS2mawLCSY/hOK479aWdvD+Vm3tJNnfTBRsPnEEWI2PYGXdsipmRsCU98D
         jMdZBWV8c8/qxeVYCTj70/HkVeDWQ6dh3m4kcKNL0PG23QFenBkvF9niMBX7QJVr+uRR
         9Hllh5Sm54gbDG5J0tIXkwU7nBBrYPs4ywEepTqDAPhV+6pzbFevP1pMfC607VwqrKYq
         4EUifI1IPDBVHiIH7YOtLsSkxS9ybjG99BJhzxRCMYO+9zxpjJQPmHQN3ptJXr8IheoA
         jx4UZEx0JobJADeC1uTSm7hwQKjnTYjFSbrN5+F9CJnRh7NxfoLrr8dPbOzlN+r0vLBF
         t+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259076; x=1689851076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqB4Kt+s05pjxA1QBH/foa/uppjMlny8KN5MCdCCFKU=;
        b=f16yq9W+JTCx2lwkwjW4UUg0mrNv3tTbPgXMj6/WfHDxA6C9w9woVB4tnwrZid1zWM
         XYYYA0/AX1xBHCP6+eYZkMaW5hIym1HAwDE2XTblkwMj//m+x3aMHjdhB9MCtRrYN24m
         JhqbxoAWKr3oAeYCtbfpMHRQ8yBsGIgFcI3RDPdOB/jxN1mdfwU7GSV28EK5uH3S0ips
         yT5Qw7UNyIn1JiplVRD3Mw1WqU0AOpY1rrHnGG66Q+wDEqJKKE6Qeyg2Nf5utsh/+ISJ
         3CG+5FQU0Jve54Mj1msqqgZw4sOUUnMxgYtSl5y+aB0b4goHg4513CInSII2TrOMw9+3
         ZV+w==
X-Gm-Message-State: AC+VfDzBQnhFl8K/jcdoq4olVQPQRqjk42JlsB9zCKSQMg/SXFwRHDf7
        WV9ed2CVU2y91qnq7chS4QdmXKFyU0d1LdCpvuQvtA==
X-Google-Smtp-Source: ACHHUZ4WKgCFcBznpxwx+N1bIbbjHQPqIKFDM03dgTyT+rcEpb5O/9U9vsg95yzlUmwetPoRDahV49C6lvi+bTdrDWI=
X-Received: by 2002:a1f:5f8f:0:b0:471:5427:39a5 with SMTP id
 t137-20020a1f5f8f000000b00471542739a5mr1957712vkb.10.1687259076201; Tue, 20
 Jun 2023 04:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102129.856988902@linuxfoundation.org>
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Jun 2023 16:34:24 +0530
Message-ID: <CA+G9fYsPRLkpqWhRKv7Hiy8zGoa1Pvx8yLVdj_eu4fc3E_3fTg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/49] 4.19.287-rc1 review
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

On Mon, 19 Jun 2023 at 16:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.287 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.287-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.287-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 3e62ea320ab27feda1f02dd492333c4ce07e884f
* git describe: v4.19.286-50-g3e62ea320ab2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.286-50-g3e62ea320ab2

## Test Regressions (compared to v4.19.285)

## Metric Regressions (compared to v4.19.285)

## Test Fixes (compared to v4.19.285)

## Metric Fixes (compared to v4.19.285)

## Test result summary
total: 81523, pass: 67703, fail: 2677, skip: 11032, xfail: 111

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 106 passed, 5 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

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
