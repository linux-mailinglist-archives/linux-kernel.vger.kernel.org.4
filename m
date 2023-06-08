Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878EC728618
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjFHRQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjFHRQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:16:12 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720C22719
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:16:09 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-43dda815756so175060137.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686244568; x=1688836568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms3oXUPUzRxGjElc+3Pci4xOCxzzJ+lNZwHYN3+mkL0=;
        b=FxMSjRmmPUBwdN4r/E2eXzihPJ4YOqu4CnkOx0JAhfoDa6IkKmPyeYw6+4alCX3wrT
         XX+i+BvKUr5Pm84wPKtvV15Miz9Uk89G2bFLi0Yi/RfmZnRJUkGllmOMG/fdBpLHjLNn
         HxoUUCOpXYQE7S4vXdXywLCZisdnoHBk5sDVrtOlN0bpAfTCoGOsE2mHCa2XLFIcUrqm
         UvQNo1WHcg0QLuvIigaUzTsOqeFVzVH+sU9nmYcGVmOFXXTGJTA0B8Gbx48KxwJtVw1p
         VCs6pWR/BYnryNoSpO58oMg3vB1AaJgxK6qJkd6BAyM81hUTtgQZE3bpyB+QhlNXVB/h
         dXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686244568; x=1688836568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms3oXUPUzRxGjElc+3Pci4xOCxzzJ+lNZwHYN3+mkL0=;
        b=O8zMw2NB83yHFFcVCW57o7RPWFSm83Fisa2X8eRjY+3Q6qKmgQ83fz1s1txH7Tb/uv
         CcPMSvcEMAIli8G45mpT8/3Ep3Ho2jkaZW59/D1CXTAL++jBOgFk+fkTkDiOewSneKUU
         6jGTXDXdP5qqUIoN1dMiPPLMpnt4GudrGcOjcfZc+mZ1mUXbAScudc5CAPtJuwIEEJWo
         6cZDvMcKQ+5LsMDlFpjVEOyk76KcD3a4vthy9Q57lSZ203vUFJCNqMKOuV1zq2DVLZ4Y
         ThnjpfJ+D9ZjZgRPYFCg0v+JtxCBWVgoo0T270158KrlxLjXS/X2BSdj4M8BEcX814Pi
         Jt6A==
X-Gm-Message-State: AC+VfDzPz03wlQ3e3bd+fBV8zzEWte9tKmbky/SHTe7kqe9166TZzwzY
        on4GNrmeRw8VkZYrnBrBuYjDt/HfAKqOIjoaFfIcbA==
X-Google-Smtp-Source: ACHHUZ5TZzln45fzN/f8HOH2l8S70uPwPACW5hR0V9CnwSI56DnrMFG/yYSfGKhc6BG22MHnXYZ2WBFMF3ZvV0ogwcY=
X-Received: by 2002:a05:6102:355a:b0:43c:8a09:111e with SMTP id
 e26-20020a056102355a00b0043c8a09111emr2584064vss.6.1686244568342; Thu, 08 Jun
 2023 10:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230607200835.310274198@linuxfoundation.org>
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 8 Jun 2023 22:45:57 +0530
Message-ID: <CA+G9fYvx87wYfdRCi6t8o_buNwVBKzKZJMSdhuCNLHFoVty9cw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/61] 4.14.317-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 at 01:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.317 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.317-rc1.gz
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
* kernel: 4.14.317-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.14.y
* git commit: c6b4cc5cb5498210544f2c9b6c92148228e1aedb
* git describe: v4.14.316-62-gc6b4cc5cb549
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.316-62-gc6b4cc5cb549

## Test Regressions (compared to v4.14.316)

## Metric Regressions (compared to v4.14.316)

## Test Fixes (compared to v4.14.316)

## Metric Fixes (compared to v4.14.316)

## Test result summary
total: 55275, pass: 48369, fail: 1937, skip: 4890, xfail: 79

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 104 passed, 4 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

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
* network-basic-tests
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
