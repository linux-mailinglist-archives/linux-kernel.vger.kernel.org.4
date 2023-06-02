Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2DF71FE25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjFBJon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjFBJoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:44:38 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F415B3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:44:37 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-461b6c85a28so17915e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685699076; x=1688291076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9MDdiGNQyozYNYhlffEGTRvT7DDnoxyaHD04TGAKeA=;
        b=BNFTeQxC9ouzk5HKhoORQEopHY7htboovi6YDzN4fTgG3ohX+yD+ThjzPssQhDrEjm
         /NtN1+S7HgLzlRD4aXTZ1q0407LxhLu3pqBt7rYeA1hsKXFkns3aJEcZDlYvehWASW/V
         V9EiVsgbu/gkZnpijmhbbjuYAAhoC5uhA+PX/F4LQ5UsbZ9JGB7j7cn9s5NTOrJU7EWe
         qh3NDN4pp/30HhfVoQ2DarxpuGLTClbs8OsT3Ry+BhZEUkKhafmAxddhMIjCC1FB9t9L
         4XIedNlechVs943fsE/MJYXQ6hBMu0g8QkF9bnBbbph6pDl6k0bt/l58Y5jJn6ThrxIa
         Nm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685699076; x=1688291076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9MDdiGNQyozYNYhlffEGTRvT7DDnoxyaHD04TGAKeA=;
        b=A9IgjgitT6rdEf6SdAZBrG0+jKh7oFqCjhDVYt9f+9bc0995ulFDueGK5OpOGaK72a
         cNBe846e/1aDuf2bQj1CN/adjMv/lBkrBsPRBOCkZ1TvLbKQ/TCCAJsHxra8Vnd4AoQ3
         QZAi3Pcssf5fNaxeQ0Xt9fCpsJxCaun+Y8Flja8PPdzmRBJk2Ziyk/7ECOu4BWEQSK/r
         714A/Yfo8xSjdUVaUek3edO0+ZfSVE+o6bMe8sCRrRLlOiOdOJJa5g9aeMub0RSUs7zZ
         DEpaO9D7cqsN/IPVW0KBQZz9RbARGeCXz2fH3gAEnoYxCoGrGmx5KrV4G4RINy4AG8RS
         Lpqg==
X-Gm-Message-State: AC+VfDzc2yrpb1onhsijHkJ16JbDGj5JDI9ln/dD1CSP8mEmDXibKeO7
        FpGbPSDN+VEK1RqQmfL/tjpauJvOwZNWpKinEswyQg==
X-Google-Smtp-Source: ACHHUZ5z1bRWqTnqmPW0skglwi03nMjfC1xBqDoqxDowi3tz5CH3snBRatxHpAdHnT+pmiyQuSRgFCia+ItXzERoLpw=
X-Received: by 2002:a1f:c1d2:0:b0:45c:e4a5:5f4f with SMTP id
 r201-20020a1fc1d2000000b0045ce4a55f4fmr2051337vkf.7.1685699076414; Fri, 02
 Jun 2023 02:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230601131938.702671708@linuxfoundation.org>
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 2 Jun 2023 15:14:25 +0530
Message-ID: <CA+G9fYscs4WKYTp=fYbUemdtjPbSJifzcfUjrE=FM2mrf5hc8w@mail.gmail.com>
Subject: Re: [PATCH 6.3 00/45] 6.3.6-rc1 review
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 18:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.6-rc1.gz
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
* kernel: 6.3.6-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-6.3.y
* git commit: b8c049753f7cf6804abcd8bbd0abf46baf4bff5e
* git describe: v6.3.5-46-gb8c049753f7c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.5=
-46-gb8c049753f7c

## Test Regressions (compared to v6.3.5)

## Metric Regressions (compared to v6.3.5)

## Test Fixes (compared to v6.3.5)

## Metric Fixes (compared to v6.3.5)

## Test result summary
total: 185110, pass: 161571, fail: 3311, skip: 19957, xfail: 271

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
