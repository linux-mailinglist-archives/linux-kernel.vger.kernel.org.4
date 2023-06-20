Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BC9736FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjFTPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjFTPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:03:19 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA71BC1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:02:06 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-78a065548e3so1852053241.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687273324; x=1689865324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex9LH41sBtxSu4nGJTMmDXReVKlwhUxbkE+orFPF3pU=;
        b=pEGrgLluw3fEB0PMi/FzPPl+r1kOgefq6EBZyOoe0OuEHrYu03EfAv35dGeq+ACO8M
         Of1fL6arzMkS8jARtmqMBo0vEmKgdCdFOAbIpx6WCCH/e69vQG3aYK/zDQcu0l9gOEH3
         HQhu5X1suHp/3kOQd82etkSn8Pv5AHBtTOIw00NJ2Bg0l0qRLN43AHqrkBSteWkS03GY
         c8GY9UPpemcKNaGs7oxYq8bxpCpAYv3cbSduw8tT1n2017U+VpBKQELyIgAi1kOhPhEq
         JAqegnjEu/LAAYki1uAzuFvk5Ack3cOK3aSfvHgHddaMYhT2rAeciuCEwhnrExGKvaaL
         rZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687273324; x=1689865324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ex9LH41sBtxSu4nGJTMmDXReVKlwhUxbkE+orFPF3pU=;
        b=Obq6Iw8Q1M2y+2Vsnn3Ew9522crvasPWMiqmU2zzJvaJYgF6ONUEd9FGJARzVw7laJ
         9KifqIdzq99FMXeK2l8CxntFprMKmiFQOOnHkxBnZse7/vLWPKs5FBOSAqRo0ByYEVU4
         9UXwzae8wuZZsk2si5Rtv2iHQTsFiO6YXzZyergdRr96pVnfyD21PcpelA4BoRM4wsU8
         JQ7HLrzRje75dgnYmPE0Tw1YrEFuviQbeo1ZOw5ovF4y7jf/AEj+UpuPWObwJNj8kK0Q
         Gnucrn36cHjYLrsMrL2Jnx0BLjGRhR8txCVSKcXfoYlFE5WB6J2R+4D7+Ek3FexD9FzS
         9nvw==
X-Gm-Message-State: AC+VfDz5xgdNtjywb+XmImz2KElGIu7ajGZ32J2Rin/jVfkEistYzklH
        1bB4gR4okFS2kkKtFzusTmJ6TyqjO7bdOVIjf4dzoQ==
X-Google-Smtp-Source: ACHHUZ61l8hktY/IAC0pNcJtikH+zgj6xoAJwkJSzEsBNwtd6tNhRDNAQy0SnFlAQuG3RwlFEXR2znduvlY1D+ZT/90=
X-Received: by 2002:a67:f99a:0:b0:43f:567b:c61a with SMTP id
 b26-20020a67f99a000000b0043f567bc61amr5038917vsq.33.1687273323749; Tue, 20
 Jun 2023 08:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102132.808972458@linuxfoundation.org>
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Jun 2023 20:31:52 +0530
Message-ID: <CA+G9fYt_1vxhnHywwbLmLqWNytxu8VcU4mzmCcdH88gt+CpjTw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/64] 5.4.248-rc1 review
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 at 16:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.248 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.248-rc1.gz
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
* kernel: 5.4.248-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: d4a1c8c10fcdfa1193f2b8a5a632ee5918e74a55
* git describe: v5.4.247-65-gd4a1c8c10fcd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
47-65-gd4a1c8c10fcd

## Test Regressions (compared to v5.4.246)

## Metric Regressions (compared to v5.4.246)

## Test Fixes (compared to v5.4.246)

## Metric Fixes (compared to v5.4.246)

## Test result summary
total: 135818, pass: 111037, fail: 3470, skip: 21217, xfail: 94

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
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
