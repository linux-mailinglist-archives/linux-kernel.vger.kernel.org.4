Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CA8617ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKCKeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:34:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B4101D5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 03:34:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so4022699ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 03:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nxIFQrhHnqUmAHKk1eoDvF2MZDTtURCLJ71QAsosek=;
        b=VlCiVyRjQ0TVJ6ed1vx6bQpRU7/sPFX8iIyFXGLAoVK7XScEi1b06jiEtVR9HQMmCh
         4aN9zfeY+kxgF0dQhCS94KpwGb8vo1HoYEG6ZgK4B/imDWNh+rUPqQcqKtO9WORmUePG
         QAtZP/RPkHSMTeJHHhXyOS8KWifO9erj3SBKNJCv9lXDZp1umlAeMC4NrWyORu6d3/6j
         b8AvMPIaJbir5WQmMRKkra7ogqyFzDszpyqioQPGiSGTJdeRHudhoxCitDXw/ThHpcSx
         dcjYMGa8343Bo6GwlVETQ/zLh3KpbS2zrEPv7G7+MWcmdBNLobep1efKzPRzXxkflKHq
         ueig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nxIFQrhHnqUmAHKk1eoDvF2MZDTtURCLJ71QAsosek=;
        b=2APonoE209xbj+2HZMFRB+qp322tldOJHNeoEsEKNs5mCfBU6eVOich5s/Ur1vSoKq
         pjUXVyrvRRz5kLa++Fp2gIHblrHh1wXjCc+lN1uPmxXiF+4xo/hNyJQlGoeHWGs5E9Y2
         ksBS0cuo9bGEBgWsxIjF2rNs4qCwqo7y2InPy7evcgZuvsvemmknGbxSO5xGbI0A0RYR
         JoC8kCdftDGj8X7KzUbXmdl4vkU+zQ5uNUQSrIgKTUmkiprW5v3/2ifDWArtHxlHZeAX
         VAV//xXlSPcSes+MXq2jAPlYItOCicgR+hGVPxze8IUmqKhzHm+bKtIDRvZ/vbkzKnRk
         3cuw==
X-Gm-Message-State: ACrzQf2CutFXaGgbaLVecptkjSaVYQzhiQDgNP4CFWveBk5jaQeeEJ9c
        tK+nK+RNiq0LPREXrYgDwIPzr31q/PSvioAxOC7vmQ==
X-Google-Smtp-Source: AMsMyM42xgl0oL0+Pg+hu8u9qCxPebZlx7VD61d8mUFJBX8GGZmJUFRVPP0Ibx6F51Z90yimNhfIahc9r3cWB8j775I=
X-Received: by 2002:a17:907:80b:b0:77a:86a1:db52 with SMTP id
 wv11-20020a170907080b00b0077a86a1db52mr28329613ejb.294.1667471641090; Thu, 03
 Nov 2022 03:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221102022051.081761052@linuxfoundation.org>
In-Reply-To: <20221102022051.081761052@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 3 Nov 2022 16:03:49 +0530
Message-ID: <CA+G9fYvaDwofDb5qd21bsA3F_O10p3hqw-8QzxAjSXw65Zhy4A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/60] 4.14.298-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 at 09:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.298 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Nov 2022 02:20:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.298-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.298-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 0ac5e522677d1a65175d4aa1681137ee4c25f534
* git describe: v4.14.297-61-g0ac5e522677d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.297-61-g0ac5e522677d

## Test Regressions (compared to v4.14.297)

## Metric Regressions (compared to v4.14.297)

## Test Fixes (compared to v4.14.297)

## Metric Fixes (compared to v4.14.297)

## Test result summary
total: 112604, pass: 94379, fail: 1993, skip: 15318, xfail: 914

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 313 total, 308 passed, 5 failed
* arm64: 53 total, 50 passed, 3 failed
* i386: 29 total, 28 passed, 1 failed
* mips: 41 total, 41 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 20 total, 19 passed, 1 failed
* s390: 15 total, 11 passed, 4 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 51 total, 50 passed, 1 failed

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
* kselftest-net
* kselftest-net-forwarding
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
