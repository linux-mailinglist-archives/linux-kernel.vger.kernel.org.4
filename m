Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712686120A9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 08:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJ2GCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 02:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2GCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 02:02:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135CE18543B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 23:02:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so17646059eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 23:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcu8Be/gGDo1EjGeydRbsGDZjQziqyD42kQYq+29UJ0=;
        b=H6a4X6YeUViwpL6oegqcCXdSZPOeNIw+S23PAMr3Uoc53nir1r1fTCQPzfOEnlK/Zn
         0GLAJGBk8lQ9KFbgPwsfPq/KgKZh57ZoMnZH9E8oaJIfyq1VPi4VBh3Uammzk+QhQ8A4
         hjkgoZLufHjhDXg8Y3u8xa09TDH4NyZnBAoWbxXl2HdW2Eg2GrSGY6MlkObtqvI0g+c2
         +aMNHqT3ftWP9xnPKdm3/9crydcdESwILwDS4On2BiSLZabSUoGrPkpe+tuzVfdyTgeN
         6pvaRWF5jzeS2T0kHa9X+OcVPKxCw6HYlyzzW848hpiyQ6ZhJHQ0B6OJQbFmv6Tkf5o1
         ytig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcu8Be/gGDo1EjGeydRbsGDZjQziqyD42kQYq+29UJ0=;
        b=Mq36jgEoXyoOFiQHhlI4JxG74WLKeleVxgyEyuPROcuJmjbJWX6JBSw1O0oFS75WaH
         Rz02voBAx/oc+NoXjeOHPRuix0tbBdkNmIC6FKqxEfmgqScZ/FzJnFkpCo8YiyT3VZdT
         qqLBsR/oTdIkHDaDcEx/DHbh08yofQ+LVS6g6RylhNmjev1B7vHOt4d0y1Pu2SMb8aRU
         BLuvC23cnEFkD2iZCy5bEfpAXo1c/SyB/LuKShjawcrKugGsnGQpbgh3fwR+YxrXHMPb
         7A1JBBHjUgGFHoFNWK5D7iOVJZ04ZcSpTI9soYlmpGFWBuE0A2Re9gA0k3pTXyUfyMyf
         xLJA==
X-Gm-Message-State: ACrzQf3DRNYGJSTP581Y6MuT406Wo8cXFdp0bDskRPblrhZS4jxbaZeH
        eWMzFQTohj3T3/qjZ9Sie9MAzDWFU5HmewND+fQIHQ==
X-Google-Smtp-Source: AMsMyM7ziL/VVaoYA4Km9MoQenxD2h2reB/3ec0gLqR6h7vJrH5zvMriDAM2EJ1eXhti7j4sazw0q0YPWQnTTXGrf78=
X-Received: by 2002:a17:907:9713:b0:78d:8e23:892c with SMTP id
 jg19-20020a170907971300b0078d8e23892cmr2595642ejc.449.1667023357452; Fri, 28
 Oct 2022 23:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221028120302.594918388@linuxfoundation.org>
In-Reply-To: <20221028120302.594918388@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 29 Oct 2022 11:32:26 +0530
Message-ID: <CA+G9fYuxVemfdOhLHY0EGftXCigkGO2D1twxrY9C1YD4wVwoxw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/78] 5.15.76-rc2 review
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

On Fri, 28 Oct 2022 at 17:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.76 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 30 Oct 2022 12:02:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.76-rc2.gz
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
* kernel: 5.15.76-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 5a0236b27f28de336c8bf4745694cb69109520c2
* git describe: v5.15.75-79-g5a0236b27f28
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.75-79-g5a0236b27f28

## No Test Regressions (compared to v5.15.74-531-g98108584d385)

## No Metric Regressions (compared to v5.15.74-531-g98108584d385)

## No Test Fixes (compared to v5.15.74-531-g98108584d385)

## No Metric Fixes (compared to v5.15.74-531-g98108584d385)

## Test result summary
total: 154176, pass: 130140, fail: 4044, skip: 19447, xfail: 545

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 149 total, 148 passed, 1 failed
* arm64: 47 total, 45 passed, 2 failed
* i386: 37 total, 35 passed, 2 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 10 total, 10 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 39 total, 38 passed, 1 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kself[
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
* ltp-i[
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
* network-basic-tests[
* packetdrill
* perf
* perf/Adding-d534c162c99741e4f623f96c4a5410dc-/tmp
* perf/Adding-df5334e5a8dec3008d81684c3dc3e136e51f7a09-/tmp
* perf/Zstd-perf.data-compression
* rcutorture
* v4l2-comp[
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
