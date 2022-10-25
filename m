Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3C60D2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJYRlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiJYRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:41:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B0FBC628
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:41:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ud5so10996028ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SfGKt5JfDFzakjB/p2L9gxfJw0IiTsrWvmmRLODr25g=;
        b=y4b2mAXPbXyEPaIMfr8yKNeIZ1zqmitSByYRANp/Jz7YpuXz/+a4I+NAgvPFu895lk
         Zdi6dKhPs4mzb4Z/tA+uNBhlrLpztXux1OACCI9qOs4lsDDrDeRVwG7PEZprcH1ky45b
         v3ToSlvFRtVLSd1hMuWINh0ttLAXpWXZ76KKRpt2FVqkm9qtt6/LJyBUQnFEzFhnyNpC
         colZDWgqXbXZGL9C9VuuEi0LqiLumGRgZsi2LMgGnox0uPvKvlFhhcInuWfSm7quxoiL
         dR45y5s2nf/WE7DXTE9VM5aw8CCefNhHobPdkXaS+VLCaADtBUur5fGNZz/mQQlS/20T
         ClzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfGKt5JfDFzakjB/p2L9gxfJw0IiTsrWvmmRLODr25g=;
        b=mHxhYtdL/dSE64ljynCXqRSU/eZvh8TiPcwcrhDMK4rEx9HJ62TLi9Eeb+uWPiubTF
         KkZc+yk/+fXk6r18X55dzxECNrA4OtvF6e4yAX45Vp4N4pBq994lKbI/B+3RL0gckAAa
         QEnKbNifFXu0X7RQmOjrmSgjVZUj2BQanOVDTZ3n9UwgjmgARsFvFY3/X5bBkksgcbL8
         Q69scDalcvRWeZjrpP8FGtKjKtYtOV/2x/JF/NEUlpgHgdnK/axKKKf/+2s71UgPAZVT
         1PvAUJ1DJC3+jJ6PBKN83FuWc+fXgsnK/L9Ykv6FODTtR7D8skx7v4UwBNjI/ErEPPPo
         DQIA==
X-Gm-Message-State: ACrzQf2seE9iyNx1stvShNRiIwiNaEZvM6Pn720/0nAMMq21FD6B0UaT
        VwIUJeCg4ZqEfMrTWyFVJLI49KjWkGG7cxEM4/4hDn6kNTxWJw==
X-Google-Smtp-Source: AMsMyM7KS9cD07bH+VwAb0hWf9hSkcPrrc+Gv2FFymDva2j1m7bbaLsXKA1kksrQQ+qdMSSiiAsDDoDrYkYVfTqANV4=
X-Received: by 2002:a17:907:d02:b0:7a3:de36:b67 with SMTP id
 gn2-20020a1709070d0200b007a3de360b67mr13566234ejc.451.1666719684769; Tue, 25
 Oct 2022 10:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221024112949.358278806@linuxfoundation.org>
In-Reply-To: <20221024112949.358278806@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Oct 2022 23:11:13 +0530
Message-ID: <CA+G9fYvkwJJmS4CAz5-dQxQBVYKpKe5m=T9Fq2nn73Y6JvEvtQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/159] 4.9.331-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 at 17:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.331 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 Oct 2022 11:29:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.331-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.9.331-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.9.y
* git commit: 5bb2c3c178f36dd75d9e5050ce4e40c3a33792a8
* git describe: v4.9.330-160-g5bb2c3c178f3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.330-160-g5bb2c3c178f3

## No Test Regressions (compared to v4.9.330)

## No Metric Regressions (compared to v4.9.330)

## No Test Fixes (compared to v4.9.330)

## No Metric Fixes (compared to v4.9.330)

## Test result summary
total: 91698, pass: 76882, fail: 1427, skip: 12498, xfail: 891

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 282 total, 277 passed, 5 failed
* arm64: 53 total, 46 passed, 7 failed
* i386: 29 total, 28 passed, 1 failed
* mips: 41 total, 40 passed, 1 failed
* parisc: 12 total, 0 passed, 12 failed
* powerpc: 45 total, 19 passed, 26 failed
* s390: 15 total, 11 passed, 4 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 47 total, 46 passed, 1 failed

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
* kselftest-capabilities
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-firmware
* kselftest-fpu
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
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
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
* kselftest-vm
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
* ltp-open-posix-tests
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* packetdrill
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
