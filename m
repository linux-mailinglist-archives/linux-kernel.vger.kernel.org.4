Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FBC6D5C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjDDKFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjDDKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:05:50 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8099D1BDB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:05:49 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id g17so27888263vst.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680602748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6kJcc2bUWjE/Wm8xwhZrxnLe8bMAR/uQeQIm/Gksbg=;
        b=oHi4Ll9+VXF/8V2IqhmbTklYcRikN6S8XqOcTA5OFxOg89c5yhkqUz+E6Hseqjku54
         9TyzFNOPlBKD8MfCO98hWbL+PZQOFqH0YU0OQ9ENb9/ZxPmvmXKRq9Wz2ddXqOKEiIsq
         b8r8lC3vZrC2XTtrVpLgMUiGYeHzQVnx7mg5SodnjxRRqis71tfeX1hsMrcHieFHUWqE
         M1czMd2qNO4TgvBKvZjsIxiuzQLYBGs4dCFFucom14MC7ZCu99EaV3zgCL/waKe12KXB
         1rSh+kdfoGFpzUCPDHMH5EyRCUKnhwAJYhLSc8HKfDvS+zR4TsLoINAIeGx8u5dHnVtp
         YIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680602748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6kJcc2bUWjE/Wm8xwhZrxnLe8bMAR/uQeQIm/Gksbg=;
        b=NzEk67ZNQtiGhwyLDxlcuGRaCOKzIXH52Jj3XISEsAjFHMYTam824K9znmeTxR755x
         ZVUtZyif4229xq6Ivg+BO/nlAkZ5k2101N6vnfemhnCyZN6yHbfcLF1vuWNROCgZx+SL
         83tWObYP53l4wLQ/A+9oliMrXCsrqV+UbSEc21gIWwSadZKbZjHWwPlWejsiGICODkGe
         Bo7JEhpetWTcAcLCbCSSdH9NS0LUuQojDeH2KEuVHPxOmKMFzskBmRoSs8OYtWQawzna
         6g8f3808OV1Ufubs3eMualj3SGZvY00KOv28NZpzwRu486Py5am5OYnmEpGpfLx77flb
         D3UA==
X-Gm-Message-State: AAQBX9cixmioLlexjdANijGL6B5/c7AC1idWntS5mBWGvfXNfKH2R3cB
        l6ETkjKKKf1x/qq5VGCAQZ0VRtENEidSQKR+9qN7fw==
X-Google-Smtp-Source: AKy350bozIGUKrFTIuvX4HK5SHyZ/Y51MlT+Sqx2mhOA/4Eo2BaXE54VSsg61qenpSHyejFTj6QgIyXywHRS+Ij4K7s=
X-Received: by 2002:a67:ca8d:0:b0:425:d255:dd38 with SMTP id
 a13-20020a67ca8d000000b00425d255dd38mr1800040vsl.1.1680602748487; Tue, 04 Apr
 2023 03:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230403140356.079638751@linuxfoundation.org>
In-Reply-To: <20230403140356.079638751@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Apr 2023 15:35:36 +0530
Message-ID: <CA+G9fYtMs6S+_LFRXNR3230wLOjz50ryNNJMuDdQAjMyyqC7pw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/99] 5.15.106-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 20:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.106 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.106-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.106-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: aacd621499911fb2f9643a302eb98e3670b89539
* git describe: v5.15.105-100-gaacd62149991
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.105-100-gaacd62149991

## Test Regressions (compared to v5.15.105)

## Metric Regressions (compared to v5.15.105)

## Test Fixes (compared to v5.15.105)

## Metric Fixes (compared to v5.15.105)

## Test result summary
total: 138014, pass: 115097, fail: 4115, skip: 18551, xfail: 251

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 115 total, 114 passed, 1 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 33 total, 31 passed, 2 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 36 total, 36 passed, 0 failed

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
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
