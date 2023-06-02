Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9100371FF73
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjFBKgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjFBKfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:35:14 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA8F1FC0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:34:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f6c014d33fso15420131cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685701989; x=1688293989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDCJcmMTRuNdKbBB3fxyRRrPDxYeS0o0RfK5IFdaXeU=;
        b=oZDJlCEjfId4ijtiJlL+uyRinTysFVgG6NaayWFC/tNTOFHhRN8spkwDOsA2mCWTal
         pzO6gF6SiOn8IJIPWUqNIq1+hUVqOO/9kORsbz8/BJfp3Y6is3DoBiSALDlLWokpbnQw
         IPHrKqEWW3jL6Ij630iP9kd+JeDz03wekDwu+FYQ0hyTlUCfT4n9WTi/haRDuMo5MHsF
         VMTpkB0r2iKRVmEPseG4eREbynaxSOj1j2aeKa6AwN+805ZTtMpp3KwAZlEZ6/T8uUoD
         coT8uXdpvNR9Ka8lBmw7jMZfQdJb23YMVPxjEp/EkdMGwGhjURHdyumR0ab1F4tH/ZkO
         1ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701989; x=1688293989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDCJcmMTRuNdKbBB3fxyRRrPDxYeS0o0RfK5IFdaXeU=;
        b=b34KYyXgtVFOTzy1pARuU1wX1mU6SQA9KXQVnokoIafnO6nZxt/FgxL3o1q5OX3Ta8
         DZ78sdVr0JPk64S//mRvJmY8tJ0qK1XMQTPAs02JvpC9wTdyHTb9yEpEZmYjA8E2afqi
         v9gzvkHpnN8S/lvPTMHEezxbPoyrX6dV1ofcLV3A/ao+LBz4JAe+3FR2R3fRKR4au+vS
         WW919qs8eFpkX1ubjDUyzc9aJ4XrJPWqNiHkMyeNkUPiHPNOa/BiHm1bibVW2J8DmpGU
         6wVkbgLRsCRuTM/q0Dj1iF967v85ijpovz0Yl/51rkfGkhbPTCSurqA8n1KsCGpVbbsA
         WB0w==
X-Gm-Message-State: AC+VfDwHI+7+V+oCeDSveUFshcbVNLR4zCR9OgivEEGAXlCXGZteuJHA
        TSNmp9R0eO+8gTnq3VCAtBEmme+BiB3IQgNu/9xK3w==
X-Google-Smtp-Source: ACHHUZ6WttLleiAeiW3+Btx3MgQu8sOJPqiiS3At5H3I9ythwEFMxDNMPHGBvwtZgpwMNxYzpAOK/+RtoYRIXzm5D/g=
X-Received: by 2002:ac8:59c6:0:b0:3f5:44c4:fbb with SMTP id
 f6-20020ac859c6000000b003f544c40fbbmr14156217qtf.21.1685701989229; Fri, 02
 Jun 2023 03:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230601143327.479886832@linuxfoundation.org>
In-Reply-To: <20230601143327.479886832@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 2 Jun 2023 16:02:57 +0530
Message-ID: <CA+G9fYuz5D+jqyV4tJThLFN3XMqKaaB9s4cx3UvmG5j5RcMFLQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/39] 6.1.32-rc2 review
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

On Thu, 1 Jun 2023 at 20:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.32 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 Jun 2023 14:33:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.32-rc2.gz
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
* kernel: 6.1.32-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-6.1.y
* git commit: 7d0a9678d27663bef481e0ed18226dab66fd884b
* git describe: v6.1.31-40-g7d0a9678d276
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.3=
1-40-g7d0a9678d276

## Test Regressions (compared to v6.1.31)

## Metric Regressions (compared to v6.1.31)

## Test Fixes (compared to v6.1.31)

## Metric Fixes (compared to v6.1.31)

## Test result summary
total: 163841, pass: 141318, fail: 3662, skip: 18572, xfail: 289

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
