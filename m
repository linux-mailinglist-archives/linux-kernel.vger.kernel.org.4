Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06C37447AC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 09:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGAHXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 03:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGAHXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:23:07 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C77124
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 00:22:52 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-44363f4f128so1872905137.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688196171; x=1690788171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EndCeKtE1MtgHQq8vWwQLNF9dWQA3B6cvL2ugHn86C0=;
        b=p7/Cpgn+qOHw0O4uZ9lBFJqAIMmlfNxgrj7mC2p//k13dCEF6Sw0S/xxrHvCcm45Qo
         bt4bog7m4BvYlBGxcnltSwwPTpPIBGGMC5Nn0cuRbGXwPG6x5aDn3X/H8OY7EkWUWbK5
         jCO35tC0Wpjdad+RAWLSuw54m60OgkscXoNjIVO1Fa5ayqIkcRHsbKXq4Ewcj0cU9v40
         FKEKdXE21l9MgDwnW3beZBJRgrKJWYeF8UUyG3wFeAN7BQqT8B97jmZPz3NhGOfdxUMO
         LJ2GLr3FewCGDPGIGSQWXfHdSoLVuzYJpXUWvmkMwau+vh3zuKXMtziqTmvUp2Kx9wKd
         yNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688196171; x=1690788171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EndCeKtE1MtgHQq8vWwQLNF9dWQA3B6cvL2ugHn86C0=;
        b=k6/TdQ+OUi2Mw4cAY36epx2PbaLTcllZj8Kf8V2XFP6g9u2LvIXdoE+7lppH21byMy
         NAHShEARgItVssPE+6eL1cgVaa7vs65KNPlVIEV4TRWCeYWTD7gK6qvxw1m+07CEEDOD
         8uvvrtNPHVX1kZPDQCJyjhhoysaAEQGkHNpWPBIb/WOYMFfMvkE661LUM5qGUqu4hxED
         dqq9zNpJuxOFFXoseJ1CxuJIS0C1eOgHe+kG3ayyxNnDQbXdma8CKBwJAUiqpRjfUOOe
         /IlCtAfP6eYU8tnx1T7lULqVh+CaI7cN96wkpmOHQoBM1VI0q8vQ5AKpDTseOlusPdyr
         KKkg==
X-Gm-Message-State: ABy/qLal8gV2+FsroXEA0uhRmb/eApPuNMfO7q/QHrJwzVieKwgIMfqP
        FimEnEbeiuoCdSLgnepOO0iH3djj4oNbcGv0lfWKcw==
X-Google-Smtp-Source: APBJJlF/wJHiu7VKFbccuje5fHD/XYfVjwPMhARFmrKgQj+3Ii+IL3DF/1ULbi0q25CyiWdm3p8pZTtwRJ0QN/kn18U=
X-Received: by 2002:a67:fe98:0:b0:443:672a:8c3a with SMTP id
 b24-20020a67fe98000000b00443672a8c3amr2412688vsr.9.1688196171362; Sat, 01 Jul
 2023 00:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230630072124.944461414@linuxfoundation.org>
In-Reply-To: <20230630072124.944461414@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 1 Jul 2023 12:52:40 +0530
Message-ID: <CA+G9fYtUn5p-wQZsWoRA2XLaJdOSEt9E3RYgiF5w2fWczTvx9Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/33] 6.1.37-rc3 review
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

On Fri, 30 Jun 2023 at 13:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.37 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Jul 2023 07:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.37-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.37-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: bb9014bd0a3195cf910cede585b8dc0c4f85aa50
* git describe: v6.1.36-34-gbb9014bd0a31
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.3=
6-34-gbb9014bd0a31

## Test Regressions (compared to v6.1.36)

## Metric Regressions (compared to v6.1.36)

## Test Fixes (compared to v6.1.36)

## Metric Fixes (compared to v6.1.36)
## Test result summary
total: 184322, pass: 145551, fail: 3522, skip: 35067, xfail: 182

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
