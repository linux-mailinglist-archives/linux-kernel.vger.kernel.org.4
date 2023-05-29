Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D8371483B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjE2Kx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE2Kx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:53:28 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97750B2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:53:26 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-456e4f4ea83so888025e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685357605; x=1687949605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CdD2S99xoGQ6D/EjHc8yZ3GdLc5NVTApEcMwxqgxW8=;
        b=BVCGL88r2SR5hGNr7N1hMyaCOvEkKKGOKcaU1HL1Ym0eumphHEO16ao4lFSQLYCU1N
         MwZPrZZ3xcqlSuYVxe0bv3lgHGgF0TL+L/Eb54Bdzv8/a83bK6CNGfmXm5qFdGPdygR7
         uRVCY/ObZIU0dtL6gysPrZy3eOqC2ePdaa1yvx2PZ/BkAXnaBiR/bHfEYgigtUV3jPpI
         iAjpp8IkvGVO/CXjLozImbLWO9Zp/mePgXzxTcjE0lO4HsAJpmaqUS3nRymkGpwmeBlZ
         YphsYLLVAvHDpPZIp/98s1OTVGQNfB6B+P1/3kyKDH7/r9FQn59DjusTL7kbe5WENdM8
         x48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357605; x=1687949605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CdD2S99xoGQ6D/EjHc8yZ3GdLc5NVTApEcMwxqgxW8=;
        b=jA+eTwMiNfHNM4Eq/86uECfkFWS6NLI+9Y30ONOZZ2CYNKFF/oNX6yFWiHoJZEEMAJ
         ErEFlZoVk0cMQkZnYhm67BNddYHmzhY0XhCNgPOIyp8jbXnd4pc/eKi9W5/TtTwyrNW9
         0Oe03pPIixVSF44iNovBOYP7rf0tw7OMl5a1J/9JGbdKcK1jqlL+ohRL2HxQEMm1/AJR
         Ifb6og3sSAuWoN8OOfiVFrFQXehRWaW8QRGwNj6JIkQc6WpJRhAcp+iYsYzDe+VNaVfZ
         BbSIsS1+dSTccWtsO+CTWfpuiIvGOsAbkVN0gzQueZRql1UfPYaDQ4Epvrk4Zw2jDyVv
         PuKw==
X-Gm-Message-State: AC+VfDzU4TSOkEFE6N+tt5JVIXpuY8ZErxQfrDpbnTiiwh/qHgzl2yoo
        nGjVGpxzJZzdgvemtWfsy3cEVv46kB8Wg2Wp2TpEXw==
X-Google-Smtp-Source: ACHHUZ7E9kPHWS7jZtU1LFCWYfsdgQjIAh1XlUv7QCi25G5HrUYZ7+TjrNknsxnlhQR7frg3/cfRaa/BHwwbPvT+wM0=
X-Received: by 2002:a1f:c686:0:b0:443:de44:6118 with SMTP id
 w128-20020a1fc686000000b00443de446118mr1902399vkf.14.1685357605503; Mon, 29
 May 2023 03:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190836.161231414@linuxfoundation.org>
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 29 May 2023 16:23:14 +0530
Message-ID: <CA+G9fYsUfv4emPkWZd5f+HzVXTii6CHUd5f6iC0g+-rFM7O+9A@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/127] 6.3.5-rc1 review
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

On Mon, 29 May 2023 at 00:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.3.5-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.3.y
* git commit: 1cd506b5ec444632c344cd4148ce1b0367f28d0b
* git describe: v6.3.3-492-g1cd506b5ec44
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3=
-492-g1cd506b5ec44

## Test Regressions (compared to v6.3.3-364-ga37c304c022d)

## Metric Regressions (compared to v6.3.3-364-ga37c304c022d)

## Test Fixes (compared to v6.3.3-364-ga37c304c022d)

## Metric Fixes (compared to v6.3.3-364-ga37c304c022d)

## Test result summary
total: 182936, pass: 158898, fail: 3658, skip: 20113, xfail: 267

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
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
* kselftest-mincore
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
