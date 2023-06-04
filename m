Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515FC7215EE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 11:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjFDJ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjFDJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 05:59:01 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E580DB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 02:59:00 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f7f864525fso41373961cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685872739; x=1688464739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhU1FXPYdlb9iSGIG8lbwlkpDKW5OB+bZCuIFDtfOH0=;
        b=obJTcQGs0hARCk0eYgzjgTj//bL7RStx1eItN3M32H4CJ1j85m8aInaWwr4tvXIAFk
         Dow1NZEDOTsV1b0j4cyt634kB9uuV9a0IbEQzCVXsO0XHCqBY/TDHDZVw3/lwqn05bLz
         gYaoHKfOKhzIqQDygaxB6UCtXV9VZq/DTUTvM329rjlirAofR8f+yOQnv3bSzZJaT49U
         goo+tX+SNKvimSazbCDScdI+NodgxPI+i1ltotKljSQQkSFSY3aaLqukj5Q7jJpvx/9V
         jyIKLmLi1gxnl/EFZyP9ARwNv02f8ESoX8uD80OCc3MzJa8EXmM+VdG1CxUuN10Rd+Bi
         1EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685872739; x=1688464739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhU1FXPYdlb9iSGIG8lbwlkpDKW5OB+bZCuIFDtfOH0=;
        b=TrUxUJTO8OQAL/8OnTyfvMwD+rCUY/khI6a/+O0Q5EL2PYLLRdI9b79JalUaW2CnDU
         9Wp+67G2erhduxvcGgA5WNfCI3yAw7Tln7x2oCRcYNOJlN6+9qvqca00TR5oVj4YXGlF
         sSzhq9DPoDSKGjsarkB1LDhq8JLrcDUTnu8+q1qd97UDJM1FKWqrLu0jt2foX2gh6sO/
         6gQGgPLGmrn47bAaGgMOtbV0MmZD1RBcSyp26z2wgyfCh39opZLQ72b6WhmXakpOr77m
         qc5fonkaMS2Ek1of9GYJqCaeX0vcpHBbtrDQhT/yJHdBxZfmqF2caRpPaeksqdw6Jj49
         bvlA==
X-Gm-Message-State: AC+VfDztqx2eyvCnYlIxlbUldfcBlL1588JhyHYgREXo00aC1U+sI74m
        KUua7Ct4tKnwPut/lHnlxNI+HXDzIWWNoLL/IGvGFX4C0i6mdNyt6wM=
X-Google-Smtp-Source: ACHHUZ4eTcpeyy75bxMkt02Ojc6r+CM5ClNVt0Ig5+uPMTs5U21Lbl+XNdZDsHiFKaLgwpXATl38jV/DfHEBdA+C1A4=
X-Received: by 2002:ac8:5a12:0:b0:3f2:ba:62b3 with SMTP id n18-20020ac85a12000000b003f200ba62b3mr4880854qta.32.1685872739202;
 Sun, 04 Jun 2023 02:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230603143543.855276091@linuxfoundation.org>
In-Reply-To: <20230603143543.855276091@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 4 Jun 2023 15:28:48 +0530
Message-ID: <CA+G9fYvNK=g4GKPD+OFhDbOUEn-cHeqgKOuUYceVHwb79=s9RA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/35] 5.15.115-rc3 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2023 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Jun 2023 14:35:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.115-rc3.gz
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
* kernel: 5.15.115-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: e43ef124b08b3125f1560d34f33fe33bce33c1ce
* git describe: v5.15.114-36-ge43ef124b08b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.114-36-ge43ef124b08b

## Test Regressions (compared to v5.15.114)

## Metric Regressions (compared to v5.15.114)

## Test Fixes (compared to v5.15.114)

## Metric Fixes (compared to v5.15.114)

## Test result summary
total: 133100, pass: 110484, fail: 4281, skip: 18135, xfail: 200

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
