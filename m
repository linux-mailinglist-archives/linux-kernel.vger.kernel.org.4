Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414EB72900B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbjFIGgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbjFIGgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:36:49 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F7E2D6B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:36:42 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-78a230a687aso494777241.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686292602; x=1688884602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/Ri0MY+C8LWnFeLcYvuFxV4IlOKjoBFfe7H5eKN3PE=;
        b=vzJ53iDH99qCGcscqHPLc7juLS52qEHKzDn9G6wFHKs/RHQ/a+24P6pelrT47C9i8K
         b236ogTR0D174u5n6ofjEktQ1lVvpvaduz71ahaTPCXO+3bezCuTG1aQ/zwSPF/CEY/z
         8YeY2btUedzf7tYRaaQE1pM7Um5YJLgp8jT+tCiGwOUR9/294ivWTn8jZP+KQ593vhxq
         B6vi09YqUlYBY/uRYgD412wq31MCOdM3YFQAVhZOTrEDcuH+htFxGloBzFpYD5Y23XxF
         rg6cbzdGXe4HFQcMDDjQ3mLPvRV7Vfcy40WGmi5uRBk4Pm0IQpi0l4JtSKZ87fSBkiws
         c7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686292602; x=1688884602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/Ri0MY+C8LWnFeLcYvuFxV4IlOKjoBFfe7H5eKN3PE=;
        b=G5FfTLU+C/IOFX9GszfumvooiS05G60tfGXuWAA1uOpv25LSTOAQiWYWHv8VAKkjUf
         QPUgnuHzP7sAvTxYs0ie1dwt0Vr7CqypzGTxDWESZ46GrqK9lPisXuDVjzT98wHe20bd
         k3ol7GvISoTmdhChjZ2r7gMppSjD2h8peW3EGAitPqOh1JGjahg0RozZ+83Y65vpmyOK
         +Ju2+L7EW/qKTIK/vm606fhd/c2g24zh0D9Q0v2tJ0Xwld7HZXAB8RJEBTWrid9n7szv
         ZdexnfUG1YzLck0vkIHbh1j5svKUO2Z+nSYTDTazm7uMZXu+8lDoyDIhqlpAiosEG/k4
         rRgg==
X-Gm-Message-State: AC+VfDwkpnCPuK/ekhCKf3TLrJcxA9JTu63zBfj0wyMtcFz+rQKd8BGV
        7kMU8EsifWhMaOQaoLBZQ73hICwfnUMFXRbC5LDLkw==
X-Google-Smtp-Source: ACHHUZ4E04sbIpQsBKmZ4rgGd8ZUv6mj4gQ5EvT8z4FOkw9sojsEVyzf2LV+GrMkE6kH978NWLgT94v6jrLZCCkMm5M=
X-Received: by 2002:a67:bc0d:0:b0:43b:3eec:5e2b with SMTP id
 t13-20020a67bc0d000000b0043b3eec5e2bmr346623vsn.33.1686292601629; Thu, 08 Jun
 2023 23:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230608175726.909746266@linuxfoundation.org>
In-Reply-To: <20230608175726.909746266@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Jun 2023 12:06:30 +0530
Message-ID: <CA+G9fYv9crqtPsX=v-k+1zxpeRFuvVDmghRQ7HsE2gpCiBLV_g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/224] 6.1.33-rc2 review
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

On Thu, 8 Jun 2023 at 23:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 10 Jun 2023 17:56:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.33-rc2.gz
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
* kernel: 6.1.33-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-6.1.y
* git commit: 621717027bee62901033052db34271ebbc0123f1
* git describe: v6.1.31-265-g621717027bee
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.3=
1-265-g621717027bee

## Test Regressions (compared to v6.1.31)

## Metric Regressions (compared to v6.1.31)

## Test Fixes (compared to v6.1.31)

## Metric Fixes (compared to v6.1.31)

## Test result summary
total: 166640, pass: 144062, fail: 4048, skip: 18258, xfail: 272

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 147 passed, 1 failed
* arm64: 54 total, 54 passed, 0 failed
* i386: 44 total, 43 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 47 total, 47 passed, 0 failed

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
