Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066196B2057
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjCIJl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCIJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:41:24 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43055E8422
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:41:22 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id p2so715104uap.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678354881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIOTc6rn175vyiFq5gHKJuBMS+ktp/ltYyWXUJXbuJ0=;
        b=snneBnAmpgUiHLd38p7vadzvY/UzVgShwTDe/tov/JkfdNK5XlTfaMix0bwM22zHSL
         h4eR9mlatZ+qXxORwLyvsRqsozXsecjYIEKNx+QN5TNWB/qgsqqESMpDFpcRfY6ys3OJ
         E1SETI9x0xOblR1YLtnr+ZYb9UsVdDMrboM33RW+TsIDQELxdiAUzuAe2Pm4ynuOG+/E
         qcN+pmWtwESko7WW3QKk9U07MogoModFMCuKwyUKNrFhioUvBIvC8oe8b+1OL8zWoVw6
         Zn5WBDww/3R/gQdHNIGmIU0HbO1K9qY7+jF93o3Nlz8Zsw5JL5tmRePpV5U32iJ8tG8W
         G+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIOTc6rn175vyiFq5gHKJuBMS+ktp/ltYyWXUJXbuJ0=;
        b=F/15iFexKRiBemkJwK3Bu8S34R3y5433JOy5EF9Nf+b0NCaRH+CqucCQGTJ6q0QrB0
         onMET6mgolPTjhyJB0UADtt8zs00CMm+TtYqI/v2ZsLR9pMTX2gPsEDNqCWXE3Pk0Gfq
         YYBHTw/va18WOyuJHxlt9aU5C00ysXFhpul+FEad+ALIQW828jA3e67YrydV855gfj3Q
         Eyc2ZhEnlbJcnsmVpbfNj1tlFqwnKSRMz1woivzOC2o8ZZm5DfDECC8kcGlyT/Tjuvdd
         vxtKabscDuz8jPXwCUwjNgqpS+U+wuC9N/GWPrlARd2VfzhYC0gu3lO1iHNsyyKdLED0
         7cZA==
X-Gm-Message-State: AO0yUKW6PWwYe38XkTyUFdVL1xEoxB23Q5eo9xpM5vztH0yahPw06d56
        /fIpTHb8M2EcKk30CYj7+sG7otobwoKgJla5ztSXDw==
X-Google-Smtp-Source: AK7set9MA0HVOQztZi1vXV8nxaRwHuutfpyhuAGcdu+cDwH71E4Sieb/AVCvERDPvAxQA5myYctNNvM4Ets7TGOoSBQ=
X-Received: by 2002:a1f:cac3:0:b0:406:6b94:c4fe with SMTP id
 a186-20020a1fcac3000000b004066b94c4femr13560505vkg.0.1678354881180; Thu, 09
 Mar 2023 01:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20230308091912.362228731@linuxfoundation.org>
In-Reply-To: <20230308091912.362228731@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 9 Mar 2023 15:11:10 +0530
Message-ID: <CA+G9fYvb+59kmM=LXucEEG0Ys4-ad9EBdC_p_A3E7SXadGS0Kw@mail.gmail.com>
Subject: Re: [PATCH 6.2 0000/1000] 6.2.3-rc2 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 at 14:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.2.3 release.
> There are 1000 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 10 Mar 2023 09:16:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.2.3-rc2.gz
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
* kernel: 6.2.3-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.2.y
* git commit: 69fee44387164fb4c017b1a9fbdc04a66aee75aa
* git describe: v6.2.2-1001-g69fee4438716
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.2.2=
-1001-g69fee4438716

## Test Regressions (compared to v6.2.2)

## Metric Regressions (compared to v6.2.2)

## Test Fixes (compared to v6.2.2)

## Metric Fixes (compared to v6.2.2)

## Test result summary
total: 197247, pass: 168778, fail: 5013, skip: 23456, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 140 total, 139 passed, 1 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 36 total, 35 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

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
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
