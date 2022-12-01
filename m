Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0AC63EF38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiLALR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiLALQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:16:54 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C280E1DDE6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:12:48 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3b5d9050e48so13745577b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LjGVWRVvoz0fVTn6nKDELE9RQjMADFV/wHWfjDFhp50=;
        b=A7ocv20iVGNs95mJ7eBNP7PYnw8vwxGYf6LJFcqHS8jOQ/z21MxdwSnQC7d/1j4T2C
         TVUGWXoJKUoHtORkO3JhqguVHyKnglWTYZ4H+oCmy0na2SNN30t3erQe0a9Qe6UlUfLl
         9ZGwTdYQo/q+2vDebq3MnM4eJTaqbU3OjNtQtTjX8TDkBSKycvgEDb5FhA0RFnqOehNA
         0DB4WV9dEaH0IonKJ6HeBh2edt2jjmO5Sv02pBRQfziP3J1TDOEyb+15ne2FfC1mHeDy
         5Gwv4eEuENtFDtuNprVmooI/RdvNcVoSdoUrqLkya5pt7W/tjDdP2NTLcIVFBx7Q+4FC
         4m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjGVWRVvoz0fVTn6nKDELE9RQjMADFV/wHWfjDFhp50=;
        b=39cKz+CkvWKtkhZHz9XNC7kzdQCf8ujhDawruE1stWfUO8+nyXmaFs7P0eoCHr8ptI
         1t1E9TYhN4CMpldv6yXqJbYLgL5jjrvi54TWxOBA8uedK8EYY0g9JGt3TP40R93edYLn
         5dWF9D3ak2+uGT+/saFi+DRipxRWEmBj45CEEy1VvaE+Io7IO76NmVaOYrz6AFnaaCTY
         fxA7mrMIP3OH0UfUTA4AoPwkwl46aygmdQDe7N11l4sbbJFFm60Vi2624IZED7b8Bb/5
         tD9MNb3/bKUlK7XGIy1dLHiwdJ5UvhSHPuF0iR+9z6D4d+KjuTLSMqu+j2TdXLQiHSPZ
         WalQ==
X-Gm-Message-State: ANoB5pn5B5K83/nD7lHWtd5e34L1NCgrM9DhiV0SEVyyRe/4t8P+74Zk
        iSeUcv/vNpT3aEivNeXAlx+KbmniEPL9YTUyzekXzw==
X-Google-Smtp-Source: AA0mqf7MG6aWY1Z82kpI6TEbT24QykgmNTsw/GkqpEaa+11x8Wq/MSA/oKdc/s4rvSyQ1e60eS7fzRtNWlxniriAHns=
X-Received: by 2002:a0d:d5ce:0:b0:3ba:29f1:1ddc with SMTP id
 x197-20020a0dd5ce000000b003ba29f11ddcmr28363333ywd.311.1669893167702; Thu, 01
 Dec 2022 03:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20221130180532.974348590@linuxfoundation.org>
In-Reply-To: <20221130180532.974348590@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 1 Dec 2022 16:42:35 +0530
Message-ID: <CA+G9fYuXFT8d+KPefPu395Rbn-xOANQCxAXAL_SJ0nbBjz_xWA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/206] 5.15.81-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 at 00:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.81 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Dec 2022 18:05:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.81-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.81-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 0b35f5d8dfc1c4892f8c447f208954d5ea9333e3
* git describe: v5.15.79-388-g0b35f5d8dfc1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.79-388-g0b35f5d8dfc1

## Test Regressions (compared to v5.15.79)

## Metric Regressions (compared to v5.15.79)

## Test Fixes (compared to v5.15.79)

## Metric Fixes (compared to v5.15.79)

## Test result summary
total: 147866, pass: 128170, fail: 3221, skip: 16059, xfail: 416

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 155 total, 151 passed, 4 failed
* arm64: 53 total, 49 passed, 4 failed
* i386: 43 total, 38 passed, 5 failed
* mips: 35 total, 31 passed, 4 failed
* parisc: 10 total, 7 passed, 3 failed
* powerpc: 38 total, 34 passed, 4 failed
* riscv: 18 total, 17 passed, 1 failed
* s390: 20 total, 14 passed, 6 failed
* sh: 16 total, 12 passed, 4 failed
* sparc: 10 total, 8 passed, 2 failed
* x86_64: 46 total, 42 passed, 4 failed

## Test suites summary
* boot
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
* ltp-smoke
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
