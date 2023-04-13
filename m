Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A556E0980
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDMI5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjDMI5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:57:15 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA54A27A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:55:42 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id w19so881468uad.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681376140; x=1683968140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PrjGClB6aBMd5jPrkLLFovctALNVXzd7tpLMl0zzO4=;
        b=y60vwBrMosjjUa5lWyKi3dJna9t5hEp6YTEeDt8R0sXW2YmWqyudV4JZf0AfvtLahj
         IfvyeBlTSKKBmjvUdckFYjgOT6n0kOhhKaDUc2nA1oxJ0xqOL1RqjEb7x/If6mJHeLB+
         ZsaH0kNwtcWlH08gsThfdQuYigJUhHFXMlIkbtHyZlBQdHoeVjHxtA+oO5AZsm3ncMq1
         96XpADM6UiaMk0978OgkI7UOc4pRsup2GcI+osduGZtJeGLY/3e3eBq/AzQSZP9M+H6O
         KcVpfWz3ORh2ZKPCw1A+duiuWyh2SmRdxYBFnRJOw1C+YM6nOvF5RsioVJHETscGsaw0
         Qr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681376140; x=1683968140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PrjGClB6aBMd5jPrkLLFovctALNVXzd7tpLMl0zzO4=;
        b=V0jkoxjBw0YVN0ooHitfcELL404s4r8bx5WPONVJ3kOfjzTajwxuUdifiaS/CgJ4Hb
         XOHHJtdxTrZIRtAtXciPgclmHtjyxthNJRqmqLfMn5BksJUZtIhe8OHdBAVv4fTP6PXm
         hiPLwDobDwSuEmsh4dLAseKfDXuWZTzkxsuN0zxQ1gYl277lrc8axbL3bG/4mOmMhNG8
         taovSlBkmL5vhmstPwawxiY/GijT6f9R6diD9qAUf6RMMVCR6F3ZrvTEd2sMq1R1Sicm
         VLSizBsyGl4x2AfM/Vkt0Bh+CefVv8D3Y7cuIDEgUzcnF1rSLSAEFVlrkXGt6JuwR4Fs
         YHaA==
X-Gm-Message-State: AAQBX9fwV3KuAGaN0r2Ozv2W8EoxA66rIhtGFhZOcqL/7V6YLFryzY0l
        xoybql6iXUMcEBILcT+wZyXaWlXBgNBWdFTIjoRMPA==
X-Google-Smtp-Source: AKy350Z81to55BJMvhHs6QbXIb8eH6eaUTqPmN7DYMdBoFqQZcGxnpkaVC8M63nSp71akXc2AIK9BL9UAGSl8AFP/lY=
X-Received: by 2002:a9f:3012:0:b0:6cd:2038:4911 with SMTP id
 h18-20020a9f3012000000b006cd20384911mr646593uab.1.1681376139699; Thu, 13 Apr
 2023 01:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230412082838.125271466@linuxfoundation.org>
In-Reply-To: <20230412082838.125271466@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 13 Apr 2023 14:25:28 +0530
Message-ID: <CA+G9fYvNNULQQ809qOxfk=3jqQpSfRvNwW80zNRXXCxbzqxFbQ@mail.gmail.com>
Subject: Re: [PATCH 6.2 000/173] 6.2.11-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 at 14:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.2.11 release.
> There are 173 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 14 Apr 2023 08:28:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.2.11-rc1.gz
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
* kernel: 6.2.11-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.2.y
* git commit: 5f50ce97de71b5278626756de07d906a3a4882d0
* git describe: v6.2.9-361-g5f50ce97de71
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.2.9=
-361-g5f50ce97de71

## Test Regressions (compared to v6.2.9)

## Metric Regressions (compared to v6.2.9)

## Test Fixes (compared to v6.2.9)

## Metric Fixes (compared to v6.2.9)

## Test result summary
total: 186207, pass: 158993, fail: 4143, skip: 22756, xfail: 315

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
