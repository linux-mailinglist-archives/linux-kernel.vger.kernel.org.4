Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE4E6D85CE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjDESQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjDESQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:16:26 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A56659B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:16:25 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id h27so32292812vsa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680718584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBYRvq5aRUhHxPjwjo61wwnRjLT5arGtgwWPvAxbEvM=;
        b=wJ+SL4emeWxYwJxzHlacBCVwGzcdradBb/1VrRma4pdApUKQRhX6u/oPpOoLqvSkj7
         We0HBPAML8a6PphWKo6HDkdEwKnxKmqm39DSMwObOU3XmphYF/EP92H42Z4ucjI184BL
         aTGviu8rHMtY4bEqIE1JtF0x2H2xqnTOOgKXwKtTlDukjDleb8nCdEf3K6gVaFYulU5n
         gv1TYakt8qiHLIQqzq1lITAks+lRTGadpKsuqMVyMvWEnGOwALzv1XQeUn6Uy3uAzwT6
         DI3nqymy2Eg0pI7AvfcFayWtfLLF/Z7RlV4S3e+rqLr5t+2vLsngpZM4l4b6hPKCs1Ik
         lIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680718584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBYRvq5aRUhHxPjwjo61wwnRjLT5arGtgwWPvAxbEvM=;
        b=k9PlIVNZog7xcAJwYtZ/Yp5H0xediJBpv/nf26cSsTGaYdN6S8xUKLO7xJ6ieTEu0+
         RToPT8g6jJlj889MepP0JF6avmIRJLE20yW76Db7Jy1bG59qYSTbyFDMdGCjsQ6h8gP6
         JBuq5S4GyZ27cH7pfyFXRReaoVpO6yJQjYTw8B9bj8YDP9/T/Jw8GgpzsymG34lQxWfI
         UH8I95j2zsEbPNzxs4oWSb18vBA4aOLV8t2ar346eBGeTNuqe9zfs3FmT2tDpK0w4lk7
         6SLei1++w0xmHmrMQDo97+iBibu3l/GNfauMkC9PLvJlyJ9i2lZA/Zo4+Of85sgUviug
         a2Fg==
X-Gm-Message-State: AAQBX9caotvJEFy4o6maPM7kygsX3AGEbHSPOKJ/HpiSq9RmNynKMwTa
        AN9vVOYq/VPpk2/WHiW+V4T2rP8bE1SSn7bm0p7/JA==
X-Google-Smtp-Source: AKy350ZvoV+kCRKNng2HmglGD04IoAYgEM7XhLtMsYekXEaxS99syMWCmysI+S7nwsXw+HpRaD4qAS1BfR+CDoNV6uA=
X-Received: by 2002:a67:d20f:0:b0:426:392a:92bc with SMTP id
 y15-20020a67d20f000000b00426392a92bcmr5517030vsi.1.1680718584030; Wed, 05 Apr
 2023 11:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230405100309.298748790@linuxfoundation.org>
In-Reply-To: <20230405100309.298748790@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Apr 2023 23:46:12 +0530
Message-ID: <CA+G9fYvsWKkL_HPNH8hrRAu0LqOv2QrgJCQVorkcqjR6-0ehoQ@mail.gmail.com>
Subject: Re: [PATCH 6.2 000/185] 6.2.10-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 at 15:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.2.10 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Apr 2023 10:02:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.2.10-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.2.10-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.2.y
* git commit: 572b6e9e4ebca45157885c1b1cb946421c568243
* git describe: v6.2.9-186-g572b6e9e4ebc
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.2.9=
-186-g572b6e9e4ebc

## Test Regressions (compared to v6.2.9)

## Metric Regressions (compared to v6.2.9)

## Test Fixes (compared to v6.2.9)

## Metric Fixes (compared to v6.2.9)

## Test result summary
total: 198254, pass: 167459, fail: 4145, skip: 26300, xfail: 350

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 142 passed, 3 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 7 passed, 1 failed
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
* kselftest-vm
* kselftest-watchdog
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
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
