Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D2B72806C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjFHMt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjFHMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:49:18 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E461D26B0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:49:16 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4640f75d784so804407e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686228556; x=1688820556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IG1ThSQ1jxrOuB1P2MSWtqb4AAHY6/cg8lxWJNKVGY=;
        b=IYFVb0U2Oq7LZb1F6Dmi54zSNKZDEY3k2bQ5z08t5fSjL6y/vjU0XKpnXcr2qe/sMJ
         PL44XqQSLBe3imAZ1KmVKdrYe8+z5e79lStvACtgRjeiMPlR53HUjqe/xHwQ74NpJ2wi
         WzS+7VP5Y4Uh0SOU6MwHmsdsMZ5KN73rqjfwMYMfFP5lh5097IcikWXcTpN2KMAidzLB
         e+jFqyp3giEqno7JZC1lntvVjOW5TwTM9iw8md7kGtw4Q2CO3DJtG1Mx59ORftzHNzwv
         aYsgsqyfHPt9qU5YchF6VQEnGu7HhsfZFKClsCDpPuI3ZUopfZhYvskqmFvS3517gF7r
         6zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686228556; x=1688820556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IG1ThSQ1jxrOuB1P2MSWtqb4AAHY6/cg8lxWJNKVGY=;
        b=XyukuCfcXmNGEp5yYkQvCsGg0H3CypuE8Gl7yguGyWX7pcmflaqPmDf9ewXi7NGb8C
         IEV46U6QKtLcpC81tail4xY03ElOnhfMBuf1i6iXNH1NdAvDrcOOdQC+IyoOQzje0aCu
         ra3E21VAuIwvS/ITlqv1ff/QyJQKbcbwIpDeYSyQmXaDM5twax/R2oTvhX742YsVU/PT
         SQL9B60hotIae1R2iFNDib7cMJ9xjMMHer07QiXyShwdw76Uhs44GGQD8aLXLEQlcp+d
         523nSotlzE4qJ5cCsiku6YvBgfk4BHQq+/0qwky2w5y4msFAfFNc4spY7Hr/s6BK8/ZV
         YnfQ==
X-Gm-Message-State: AC+VfDzqLA9m/SklE2ZYW423h3GVLgu6DXEV/8uYgaPrH5BLlw6yIFJV
        Nxw+CO6c2cYclcnaC8/Bsc53HOcldr+n/Oxc1ZxCyQ==
X-Google-Smtp-Source: ACHHUZ7DmXMy6qtRSZaHnwd/L+HqaTf5Vqi1SwvFj7z9WO+R1e00H+9zA1ptMecUQIGDdjXHRFMVVtTvOmv+a/5/mEI=
X-Received: by 2002:a1f:a643:0:b0:446:b903:d76c with SMTP id
 p64-20020a1fa643000000b00446b903d76cmr567941vke.5.1686228555827; Thu, 08 Jun
 2023 05:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230607200900.915613242@linuxfoundation.org>
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 8 Jun 2023 18:19:04 +0530
Message-ID: <CA+G9fYu4Pe=6aBnvui4ab+JA=WvGOm8PaR+woYvD_miNwf+A2w@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/120] 5.10.183-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 at 02:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.183 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.183-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.183-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 2aa548ff4cdfc9c180d0501d29b68c1a63f47d4f
* git describe: v5.10.181-148-g2aa548ff4cdf
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.181-148-g2aa548ff4cdf

## Test Regressions (compared to v5.10.181)

## Metric Regressions (compared to v5.10.181)

## Test Fixes (compared to v5.10.181)

## Metric Fixes (compared to v5.10.181)

## Test result summary
total: 95158, pass: 80772, fail: 2161, skip: 12081, xfail: 144

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 114 total, 113 passed, 1 failed
* arm64: 42 total, 40 passed, 2 failed
* i386: 32 total, 30 passed, 2 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 35 total, 33 passed, 2 failed

## Test suites summary
* boot
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
* kselftest-sigaltstack
* kselftest-size
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
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
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
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
