Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A2C72DC86
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbjFMIcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbjFMIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:32:03 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C59710FF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:31:56 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-78a03acc52aso296202241.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686645115; x=1689237115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4iXIQmlE7K/ZL7WODqTijarurUNDUtMrl1zC33XtUM=;
        b=W7tOwFeb7OKaxnCiWPufvGERu1UH+ZrF1DmyUa800pGdoqQl/VPPjOXX1qwejlfKor
         YeLpeMhOhLpm+EJmFC7BGEmPAU7W/b9pY505g6yYrzSINKGosNEnDQbDVBSOk9kPP1U7
         P/LJK0huLvgULwj46FxudgkbrwqoveABcSttSUwFagxY0ty7MGC07uI8BAC2MedDUUsZ
         YhGqhz1NzVAb/vX/TYb76hWGX+5fu9GKM8InGQOrPLdA75AmJD5C2mAAvgmol1fZB2Df
         jq9ihOt2MbZ8JbLyYTW6HDTxpN1xwsks98n2Z/8vJtnzNx1CXpmGhzqhHTTyTmbQ8z58
         gxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645115; x=1689237115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4iXIQmlE7K/ZL7WODqTijarurUNDUtMrl1zC33XtUM=;
        b=bYzFZjJa7ij4rTayE/8gXx9oOf4q61AzNiW6h5l7Cu9z81K0Kl+IOlMVMp754+PA23
         yukpjVe3VXfdipP8aeqsWtJfMU7FroL0sHRpWGlOkLXq4eET/3eBZxyN1KnhCCWQ8xYy
         k0gA5IiUu8LYHf/T6Q5H+5cQUVnVah8iWPJMx87Poo8Bpe85ursxuyQbNVirTOR3PzB8
         LV5+/lPiDiaSxkjpmWy5hV1FeE+LSFpgF6dGxjcvXOQyR544YASOZkeLoicG+IQThtwY
         6xwuNWv9SLc37siMt5Sjh+X0jjEL4pcN9R2CnfHC2kYUiDsya/mdk4LnE0ScjwPlla//
         6ddg==
X-Gm-Message-State: AC+VfDy7ltiPNOqfdVCgIcwJ65HfaIhBoxoXUPDrhEXR7Lweq66irsLi
        hQ2bidLuJttPfRnoRqzd2mnce2D3O6hsg5DkzkEKbYyk38X1uXf1NgTwWQ==
X-Google-Smtp-Source: ACHHUZ7dAttEj0WX3njveCX71aXDMkbQmyqjLTKbyt12iCSdXtC5npmRe3YLMafc5OUtcg/WusOl5Ln1bid0f4entac=
X-Received: by 2002:a67:ff91:0:b0:43b:3ad8:6886 with SMTP id
 v17-20020a67ff91000000b0043b3ad86886mr5060793vsq.16.1686645114885; Tue, 13
 Jun 2023 01:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230612101702.085813286@linuxfoundation.org>
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 13 Jun 2023 14:01:43 +0530
Message-ID: <CA+G9fYuUF6pc44ETj7q7Mz5Lik93OqLkK_uzx1D_Yu2CGc_V2g@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/91] 5.15.117-rc1 review
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

On Mon, 12 Jun 2023 at 16:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.117 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.117-rc1.gz
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
* kernel: 5.15.117-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.15.y
* git commit: 09ab3478acfde2bfd20e35fa2f6d3db44662db69
* git describe: v5.15.116-92-g09ab3478acfd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.116-92-g09ab3478acfd

## Test Regressions (compared to v5.15.116)

## Metric Regressions (compared to v5.15.116)

## Test Fixes (compared to v5.15.116)

## Metric Fixes (compared to v5.15.116)

## Test result summary
total: 131232, pass: 110630, fail: 3682, skip: 16729, xfail: 191

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 35 total, 32 passed, 3 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 36 passed, 2 failed

## Test suites summary
* boot
* fwts
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
