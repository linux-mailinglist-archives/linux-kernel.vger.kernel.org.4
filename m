Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905AA610CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ1JU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJ1JUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:20:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEA948E93
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:20:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n12so11483913eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QnutZHOe2gKMrrD7jqzJic+dtBGCsc3bd1CmHvkJc2Y=;
        b=B8doC8IEjpg+T/8LCO2csY18UjUXXEtVfncbefcfii+Qs9cPDHacbHjY24wZFVgjq2
         kAbwMdW5jEhzXAx5ybiE1XrUrzgIPEWRzOdhv/Xr/iLzoiEWS77JaaLy7kSbsDpyNsJR
         SWqKvxKdplmZWjAAxGv6jIgznipb3NNXC/r2OXcadym4nET4HHyBnGH02KtnNWFznBUa
         5ibntpMvDctzZtdxObcyYuofZAYvnQiOlRoUVtH3Pul299djypl4t5+HwjS6NWVg9OvA
         OSbOk12yv4XpsxkrREevXT1DLNkbMXuZPXe2f7LbyMLrU/i90z/RtdhyDjUcNIv1Wi9c
         KGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnutZHOe2gKMrrD7jqzJic+dtBGCsc3bd1CmHvkJc2Y=;
        b=LWHA/yhErtwpxLgyMXPKKx5IKrz3qBMSqXDvH8VJ8wc5EP3UKkR6kDMVuYzGQSrWya
         JoaJzNKjZh3jHVYEf6ad7Pn+7fKPCIhEZ4f98mz9tbrDTGWpImMqDFdk/QGPpfxiELe8
         9rIEcw62H/S1k3jswKIz+bo7bPJpcwSZbjAbf6wYN14HHVmG4T00dTv6F9KWBlLkngjr
         rPlr+FfeUFDysGgcMP7BWzskyW8+YWzyYoIQXMA8e4Wco+1uZhe4R3h+fTBBHMa2ck/P
         8plh6onQ9l12em+MSwcN7qRy+XnBtPHpPXlFUGBCLlomZeMQJeESWmy1cXIBDgSgIbNY
         0gLQ==
X-Gm-Message-State: ACrzQf0thzAk/4BOhmbzy2Ch06YsEl8lmSH3YjTKvSRLI8y+Mj5iRH5R
        gokR7Zv4t4BNdr2xI96GGpTHpDCe65r/39pLOKUx+A==
X-Google-Smtp-Source: AMsMyM65d8m2kNVt1gVCUkN/DJIaUXUz7iHvhKnTgPHiqvSAIxXuGkNOJQIKkGly4uO4DQSRva6tkhVmRNiJOb6ncWw=
X-Received: by 2002:a17:907:9713:b0:78d:8e23:892c with SMTP id
 jg19-20020a170907971300b0078d8e23892cmr45943321ejc.449.1666948812758; Fri, 28
 Oct 2022 02:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221027165057.208202132@linuxfoundation.org>
In-Reply-To: <20221027165057.208202132@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Oct 2022 14:50:01 +0530
Message-ID: <CA+G9fYtTTSmE4dQrr3atT3FSs8qoipUP7Eh5U5j24m3Gr5H4aA@mail.gmail.com>
Subject: Re: [PATCH 6.0 00/94] 6.0.6-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 at 22:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.0.6 release.
> There are 94 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 Oct 2022 16:50:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.0.6-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.0.y
* git commit: 3df0520c3ce6fb59d1574a59eae038e2759cedb1
* git describe: v6.0.5-95-g3df0520c3ce6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.0.y/build/v6.0.5-95-g3df0520c3ce6

## No Test Regressions (compared to v6.0.3-22-gd4150c7b49be)

## No Metric Regressions (compared to v6.0.3-22-gd4150c7b49be)

## No Test Fixes (compared to v6.0.3-22-gd4150c7b49be)

## No Metric Fixes (compared to v6.0.3-22-gd4150c7b49be)

## Test result summary
total: 154977, pass: 131532, fail: 4887, skip: 18064, xfail: 494

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 145 passed, 3 failed
* arm64: 47 total, 47 passed, 0 failed
* i386: 37 total, 36 passed, 1 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 34 total, 30 passed, 4 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 40 total, 40 passed, 0 failed

## Test suites summary
* fwts
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
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-at
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
* ltp-nptl++
* ltp-open-posix-tests
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracin[
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
