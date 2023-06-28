Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5EF740CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjF1JZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjF1IH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:07:57 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E710CEC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:06:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-765a5f7abc6so286282085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687939606; x=1690531606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKt46WH3haNdn68oDulwJLfg6Dbw6icGdyGT3p+VLw0=;
        b=W1DV0/9Cphin9evXRflf2L6aim9f9r6AfsjKpdysN/4jsMAPnccvEzEoKQJ4bzKpPT
         og8MlIz6DFq91YQMl/VUJ0bk+Q7HCNGoP2nx9ADFkAyRBaRwjaL2ysqVcmIbYauVl12n
         bkMCSf7N67t3iqLXjoPdTZQhCUO89Dx16ep2+HP/9lS2r8rWLIZ/+yUJaOguGJnjQa4H
         yA4e/Q8D1BcdPLDQlCnOCLb8zAr/zrPdHtRUFFvAZBcSnZc2JUbCN00JEcSNm9JmilLt
         YFS1ETiktrQLMd3AqhZb70D7YsmHzIIrKvYC7yMmfSQDWkD19D9c4yephZO2N+d5FY77
         Q+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939606; x=1690531606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKt46WH3haNdn68oDulwJLfg6Dbw6icGdyGT3p+VLw0=;
        b=AKTUhK5Taty+E8Ufqx82uqxm8g2hgulOoPXbtplJF06KHtI/rXF48gWSwpLDS0en7X
         RqjoN5ZzF0cwDT6DDqpcl5LVgkPZd2NofBG95X6oggXKuRTokSDbQzm+5pnNiQQXQbSa
         +pw7uDnJHrRjfGua+MiftgSTuurBWMxMPTcT9Km9Cth28UDVGrL2BWhI0Wh90sskrSHw
         v24oOPX+9JbAwITWi3fgcJ9Vmsm+JgYIehxAd9vYvwcxzU+g0C4JUx+dO19xa5pmfETb
         oq9xdBMYApX52wXGmB238IhmajzhdV22q5jsg8346YiB+BfCNn55EXeKz/rl6fyVVemY
         0b0g==
X-Gm-Message-State: AC+VfDwOUr4HZeZBAbe66rFD847ATPlp70uasFLvWgmys+qTxaJWaVDj
        KhLhMxuI9Z9ZmOJ/toBi5bzyuQPBkn64/nXeAk8HPJd1c1na/WFU+CToxA==
X-Google-Smtp-Source: ACHHUZ4UnxeddFx5DIcm9mVNTPRPajWiHva1L+q9Tk7Ikj+GOB9OfZEnDxVa3jmGUyFeD1tDajfgyDTVAO8JaJDmf9Y=
X-Received: by 2002:a67:f615:0:b0:443:66b9:b8e9 with SMTP id
 k21-20020a67f615000000b0044366b9b8e9mr4364431vso.20.1687935850952; Wed, 28
 Jun 2023 00:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180739.558575012@linuxfoundation.org>
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:33:36 +0530
Message-ID: <CA+G9fYu6KHvkpd86q2aVjWF4gXbpBw2mgc-Tmu=4hG4eQ11z1w@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/60] 5.4.249-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
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

On Tue, 27 Jun 2023 at 00:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.249 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.249-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.249-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 824b023c3cda00fe610c1f79d14a6223d68f425f
* git describe: v5.4.248-61-g824b023c3cda
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
48-61-g824b023c3cda

## Test Regressions (compared to v5.4.248)

## Metric Regressions (compared to v5.4.248)

## Test Fixes (compared to v5.4.248)

## Metric Fixes (compared to v5.4.248)

## Test result summary
total: 115217, pass: 90332, fail: 2137, skip: 22692, xfail: 56

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 129 passed, 19 failed
* arm64: 48 total, 44 passed, 4 failed
* i386: 30 total, 22 passed, 8 failed
* mips: 30 total, 29 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 33 total, 32 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 39 passed, 2 failed

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
