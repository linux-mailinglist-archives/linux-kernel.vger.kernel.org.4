Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794C0629691
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiKOLAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKOK7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:59:37 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCC113E8B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:58:36 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id g127so16735328ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+f1o8poFT4IwGE9CJ536ws+M8/+E0mupwQ7fimYGK6Y=;
        b=DuT+B7uFZkpDO4BUFUyMloTE+toywN+FUjtMCPdVwZLGACflAXZhyvq7vO3UBXOY3n
         btgBEWCe1UADcYCU97QSktkFQEEYCHaoYH3RZ6FxtKtE06fHx4pA3j4XgNhJS5noJ2jJ
         /wcVcrID/vx80pE9knVqXynJ8NmKSlhfpCUfmzpre6o3vmL+Vocut5FrABK03HyBOR8B
         BTvksXKskWq3k5aoRT1KfUwWoUGd2paE/5QoUYMeTQc7xP+e3tVxXN8d5jMFSeVl4e1x
         Wsu0zTdqo7k576QuQgUWCQ6Ac+Gx6KJbSpPORdrDd3snXATGFJtGfX8DftyV/i0FCTar
         iWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+f1o8poFT4IwGE9CJ536ws+M8/+E0mupwQ7fimYGK6Y=;
        b=eIlDcqG3/GIhKdUX++b4gtHKSeP4E++AoWbw+PDgRtBRyiX8Xive27tSWBLqQkE3lW
         PcLRgWL6qDKyAuQ8iVf+Vt1n5yznRfApZQlWhDxoJUiIJDuBNgeXzrKeZMm/NWL0Cf0F
         +66cHSprWzAjO8y7AJQh3jRLp0GdzhjOkf6w13z6JR+JJh75O3VTw9cWQPxQWq8LyFxt
         3nqarLLcudviKJseNvt+N+nKIilZ57V0UIeTkgqSlrEptFURto8P1NzGLIbpJ6s/Z5of
         5IsqPGDrRVTaBqreUaopWy5ht+OsOiO0N6WpLSPIa3D+Yd3beBnM1XmA4f809s7pNq0p
         UhMA==
X-Gm-Message-State: ANoB5pnSwyTcHPjg0PqBKEJEn8BZDRnBa79emoCw/jgfuIS58TWalPF/
        Yw4Grr9OyFn7Ynx0TX1SDTTiVaGFL0NxTdepjZmKPA==
X-Google-Smtp-Source: AA0mqf7H0ODWsWEljd5M8wqP9DmDppkT0oTVGQwVQa0QclXe4qKg3d95icIxSDlxO4Kz7uG+HGRHzbv6SgGQ8I3idbY=
X-Received: by 2002:a25:ad8b:0:b0:6ac:f720:793 with SMTP id
 z11-20020a25ad8b000000b006acf7200793mr15197214ybi.605.1668509915023; Tue, 15
 Nov 2022 02:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20221114124442.530286937@linuxfoundation.org>
In-Reply-To: <20221114124442.530286937@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 15 Nov 2022 16:28:23 +0530
Message-ID: <CA+G9fYvbDP+Y2QQWTX76==n-mEVz1rCCJ1e5OXAY9JDT6dTomg@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/95] 5.10.155-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 at 18:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.155 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Nov 2022 12:44:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.155-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.155-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: d59f46a55fcdeaab7337522c1c89553399bd1648
* git describe: v5.10.154-96-gd59f46a55fcd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.154-96-gd59f46a55fcd

## Test Regressions (compared to v5.10.154)

## Metric Regressions (compared to v5.10.154)

## Test Fixes (compared to v5.10.154)

## Metric Fixes (compared to v5.10.154)

## Test result summary
total: 56790, pass: 49368, fail: 1048, skip: 6172, xfail: 202

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 292 total, 290 passed, 2 failed
* arm64: 80 total, 77 passed, 3 failed
* i386: 74 total, 70 passed, 4 failed
* mips: 54 total, 54 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 56 total, 46 passed, 10 failed
* riscv: 24 total, 24 passed, 0 failed
* s390: 24 total, 24 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 78 total, 74 passed, 4 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-android
* kselftest-arm64
* kselftest-arm64/arm64.btitest.bti_c_func
* kselftest-arm64/arm64.btitest.bti_j_func
* kselftest-arm64/arm64.btitest.bti_jc_func
* kselftest-arm64/arm64.btitest.bti_none_func
* kselftest-arm64/arm64.btitest.nohint_func
* kselftest-arm64/arm64.btitest.paciasp_func
* kselftest-arm64/arm64.nobtitest.bti_c_func
* kselftest-arm64/arm64.nobtitest.bti_j_func
* kselftest-arm64/arm64.nobtitest.bti_jc_func
* kselftest-arm64/arm64.nobtitest.bti_none_func
* kselftest-arm64/arm64.nobtitest.nohint_func
* kselftest-arm64/arm64.nobtitest.paciasp_func
* kselftest-breakpoints
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-kvm
* kselftest-lib
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-openat2
* kselftest-seccomp
* kselftest-timens
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
* ltp-open-posix-tests
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* packetdrill
* perf
* perf/Zstd-perf.data-compression
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
