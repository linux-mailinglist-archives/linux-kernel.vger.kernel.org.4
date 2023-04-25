Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059406EE48C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjDYPPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjDYPPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:15:00 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3544D328
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:14:55 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-771d9ec5aa5so24896859241.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682435695; x=1685027695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxnjgBH3r01yRypB6bVr6mXGG/d22cFoPAOaP3+DkyQ=;
        b=sX9fstc651c4dzxNrdtuuYCdxtWWzyn1oTILxQYSwYl/Bm686GtL73Fz6Z05TiHA3b
         T/7KS5t6bvMTlbHREPPlkGr/noKFqn1hggyBNrZS5l6sRPNwCUSrAFladtdP+gG74G9G
         qTolbyUwN9pXt6nGfXhUEcjBJo54WlP8Wc6gQOJo5ca2GEK1vy6IPyOiKBoKiDX58VDh
         TlkCYvYhOY24uEc1t0XW7YbSaYYYd+W01jFZCMmX2Cz/odEdfLXZGoHKA84h0e+bRhi1
         7J90RTdp1NJjqcbfHFiOJpngBp1AM82CNock6JGkLq33JcdIKh3Vlg1VZYRRgCGzGJqJ
         o64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682435695; x=1685027695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxnjgBH3r01yRypB6bVr6mXGG/d22cFoPAOaP3+DkyQ=;
        b=gWKhDPH+XvTnOUfd+Sgfe/94umXxXOyZnyuE96hxFL+y+Ok7Cq7BajDe9GW2h2w7Oe
         C6ThJH0eLYh00BX6672p8XH6U6Dt4XKOQeKtIE9ElkxBRPUOrv0NUVMZzIqmiwWaNeSk
         nSH+iNcLknQZL3xcMThKsrQj3d6EkACp9cpc9vFG+PihnZokPSibBNLsjl1M2kaUnHll
         53iwdAKFrGr5aM3/jDRtby7/zToNoFwTox8XqXx7GifNj106wem2KQE/tH7WcSGj5DG5
         rPjloNRfkpiGjQmSUOQOgi6TflDkQR0y5rqkwGm+5HnMHo3fBWRMVekqXRuIBQX9lhU2
         ztHQ==
X-Gm-Message-State: AAQBX9cd+s830qMQw0rq6ssVMQ2h/tf5cnMSrG2g0zJ0jV5scuonDDCV
        nqSehD2Ql7timiN+qUs35NTORJZRNEXXkSuMVXcGmiFEzS4l1T1VWoPVHw==
X-Google-Smtp-Source: AKy350bg7Ue4P+RG/HLejbUlXUJm67HzzN+QK6+EbTXGlSkS48R8MujxUMfMRYv9mKpWJoXo8gIE3C413ABXvEkZOUI=
X-Received: by 2002:a1f:bf8d:0:b0:43f:e623:952 with SMTP id
 p135-20020a1fbf8d000000b0043fe6230952mr6045262vkf.2.1682435694610; Tue, 25
 Apr 2023 08:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230424131136.142490414@linuxfoundation.org>
In-Reply-To: <20230424131136.142490414@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Apr 2023 16:14:43 +0100
Message-ID: <CA+G9fYs38=gG5tttigg_tngigDEqgXeA+QwqP2k25iUJnNrQgA@mail.gmail.com>
Subject: Re: [PATCH 6.2 000/110] 6.2.13-rc1 review
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

On Mon, 24 Apr 2023 at 14:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.2.13 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.2.13-rc1.gz
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
* kernel: 6.2.13-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.2.y
* git commit: 9e5d20c139403093b3899c2aeac481792aed6826
* git describe: v6.2.9-608-g9e5d20c13940
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.2.9=
-608-g9e5d20c13940

## Test Regressions (compared to v6.2.9-497-g7507bdf58f79)

## Metric Regressions (compared to v6.2.9-497-g7507bdf58f79)

## Test Fixes (compared to v6.2.9-497-g7507bdf58f79)

## Metric Fixes (compared to v6.2.9-497-g7507bdf58f79)

## Test result summary
total: 194288, pass: 162649, fail: 3944, skip: 27389, xfail: 306

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
