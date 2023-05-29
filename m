Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D6714F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjE2Rzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjE2Rzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:55:45 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026EDB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:55:43 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-456ece9f868so981390e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685382942; x=1687974942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuXd+KSvwPuhQTamSBP5Q/DKAIDp88AuCgUa261KgHU=;
        b=Lrz4NW0cje9C4EpIvHOzWBLxpOF3hmXry15NXnPZ77zauvtVwsvC0c7fmMwMMtGbjT
         865FUowdRJ1f3NgjmTwXiSE897gBvdUMKoMEjcNM8p7gWxVmUmJOn94lKj2qHeXLCMv4
         OwG0I5YJl1Xaw5mw+akdctLlL8wa6QkvDRVlGnWCwwk6m3M+ilJZwG7AcdDTJB4RNr3E
         2K+vv9mOagrH4XYfCFKNtCxP/hWe1iqnh1ekhwbyItv6KZ+e0pqKrUb3JcDbq2KRsdhc
         BoYeO3GZT9y8ilvNl9sldRvxcXOAEoeCnJk44UKqWK/ihE3zwDxpLb8bxP51SVfAlpTj
         ZMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685382942; x=1687974942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuXd+KSvwPuhQTamSBP5Q/DKAIDp88AuCgUa261KgHU=;
        b=lILaRaXBa/+dZAMSPXB/Gmw37A2yFL18XFqlT4ykxXHg79qPUSK8EslZGaw3ur4At/
         LbZneunJ3zunTS4gn+sDr5f05VV8giMSWB311YfVe2ju9GGkLA+ySMetFg43GcdNvrXh
         W6EoR9m1eU8WG0AAQvc0pRr5nkb8f5dtGy5AsOzHhZeY2dceYRHH9iftuURsNubTTc3m
         kP7QRXPdTM12wFsNIMJRjjkCvbSJj3UJ4jSKJN3COeok0AP1e1g0qoDH1bSHx3309Fe2
         VaEt90VvIXifE8EsivhsguEvLShRpCfsYYYWUHJ1PldXqkyvcS6z+om24puz23DsbnW2
         eM7Q==
X-Gm-Message-State: AC+VfDzrefLkvOwLn6dYXHwCf8IkhPxJ69B0CcpLMPCx3JCLQKy4Ex9B
        1tOZdd/P+eRrmSnnteyzaNrf546iEwAfIlld0WSY3g==
X-Google-Smtp-Source: ACHHUZ4PV0yw/DDjQRCmIM3enlo7jc04a2FmQ1+Ep6v9zr+Hu+k+2ytJ8iE094iUnGSv/q7eHCxo5yD4M4AGCvExe/k=
X-Received: by 2002:a1f:5e55:0:b0:443:ddb3:1512 with SMTP id
 s82-20020a1f5e55000000b00443ddb31512mr2405661vkb.3.1685382941974; Mon, 29 May
 2023 10:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190828.564682883@linuxfoundation.org>
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 29 May 2023 23:25:30 +0530
Message-ID: <CA+G9fYvdx9eNxM0Jdr0hS_C-CNzQCihxVRHqy_8KxdWP2cNPcw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/86] 4.14.316-rc1 review
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

On Mon, 29 May 2023 at 00:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.316 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.316-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.316-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 102232d7564c0309a3860a21180d09bb04978f5f
* git describe: v4.14.315-87-g102232d7564c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.315-87-g102232d7564c

## Test Regressions (compared to v4.14.315)

## Metric Regressions (compared to v4.14.315)

## Test Fixes (compared to v4.14.315)

## Metric Fixes (compared to v4.14.315)

## Test result summary
total: 84485, pass: 70491, fail: 3766, skip: 10063, xfail: 165

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 104 passed, 4 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

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
