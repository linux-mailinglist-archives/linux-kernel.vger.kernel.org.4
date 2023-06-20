Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD87368CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjFTKG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjFTKGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:06:05 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405011717
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:05:46 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-791a0651fa3so169047241.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687255545; x=1689847545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0GY0mmpJVaGap30C67wQ4P4gkVBdItlaEd3GxE6mzE=;
        b=O8vF/rEtSvgMMXiU+C/qQiDrvHcz7ZOo2WW2SAITXvKS9KF+/avDhkBoACW+rhVBSq
         rqRHA7CZ1dDN6ivk4dJtWJdI3xeK17NYMJUXT65vMK110RGYeazogZXVSfNxzvgguCiR
         EO9pSr6oDAEKSYmUxWzTwJi2hPBwX/7ufpuvwZCGP2QaNotok2ZEwUGpgBy6Juacj8n2
         tCCe1yF4dy6JrSYMrXXDRjpiWrQ2KXfH/wB8YQd9/hJ80iNfBkPGfWr8gUVuqcOG/8Oq
         bYFZFyYMyOb6IS/43JcIcvzIqwSYWWNRaNsRjQwLg9nvGMgfKv57JsrDktIQoE11irfK
         hOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255545; x=1689847545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0GY0mmpJVaGap30C67wQ4P4gkVBdItlaEd3GxE6mzE=;
        b=B8ZtMIufYxWrxWRTRi4ZKVbtvwBMFn97QaathhKOS/mfLyrxKkrXCCGWHbwGDWcBty
         OH0Vim80L8gSZfXDj5G1h2De0XU19kBK4S92i/lvMFkVfNbNoSon1p8aqvt7D42CsaCy
         KurJkOEv+RHLIR7Y+Cq2f48nCoci7N18FgAWyGdGPJ+Z1dg4mLtIi1mqEFe0z1F9si3U
         uYEGcy6FQgxqEpE1dF8J+2yjxLpziuXKbVwAs9uYn9TwGRaQoyy4PQC8ufOqfETjkte+
         Kf4SJeVMAeUshx2oUA6ATh9/QAKyoTV4oQR8xZOCfH5Z/Fs9t4os22v3Ta/Mm4BgWfda
         HPmA==
X-Gm-Message-State: AC+VfDxHEJc3WuL55uBATDX1G+awa2dRIZqERJIhL+qdtJ80wQBGB74d
        k76aW/FlA39/3bdq0BYlcPWY7kWuYUt7kBjVnx/oWQ==
X-Google-Smtp-Source: ACHHUZ4paUhqdQaooZN5/vkkgDUI30Ys4MzA6JHh3iVvL0JixzJdzyeBkA6kXR2s4JlhIhuQ2fiYtoF9mOMPKrBE3zQ=
X-Received: by 2002:a67:fd81:0:b0:440:a737:8b39 with SMTP id
 k1-20020a67fd81000000b00440a7378b39mr2609405vsq.6.1687255545181; Tue, 20 Jun
 2023 03:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102127.461443957@linuxfoundation.org>
In-Reply-To: <20230619102127.461443957@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Jun 2023 15:35:33 +0530
Message-ID: <CA+G9fYuSVS5T90SBViOzS8hqe-KAMSE3WYxisjzKVvqCcdL=sw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/32] 4.14.319-rc1 review
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

On Mon, 19 Jun 2023 at 16:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.319 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.319-rc1.gz
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
* kernel: 4.14.319-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 30c57b30b667852569dfc303f0bbd69d595134e6
* git describe: v4.14.318-33-g30c57b30b667
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.318-33-g30c57b30b667

## Test Regressions (compared to v4.14.317)

## Metric Regressions (compared to v4.14.317)

## Test Fixes (compared to v4.14.317)

## Metric Fixes (compared to v4.14.317)


## Test result summary
total: 76666, pass: 62979, fail: 3251, skip: 10347, xfail: 89

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
