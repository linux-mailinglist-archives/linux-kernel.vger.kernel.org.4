Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6144A72DAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbjFMHcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbjFMHbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:31:52 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DE81BC7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:31:29 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-46e28685090so94490e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686641489; x=1689233489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g+b2vltC3F+OFQWYwq7F1tumRpstZvjgQWTEP7Txb4=;
        b=ajyvwQKYILkUw0jsBoxuZklSkcPmhVdieM59wZGhCLrovjnVQbflmGFeHtZZ9w8e7h
         egRfhOFuSKcRGKAU69EqjyK4dWlb8KpZvfMiXVVswYS9+ZyrNdcghoMBmtPHZRqRovv+
         NVRUnPaCnjAuXEW7GRunpT5+eStUUDqOph7lYTFw+n40DlA4KpogJd3FugAmVyKvCWub
         1cS6zlzwIotULK69or2kLFH95oDJYdtHsI3/TVB/frzKCOS4PxeH9UAAKbFgjTK/iRpY
         5e1UDkpJsEpihkD1USxeZZbxHIzGm5l25aqFW0cAtCtFd7HvhbIY7hlMFz12SLL9EZRi
         YJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641489; x=1689233489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g+b2vltC3F+OFQWYwq7F1tumRpstZvjgQWTEP7Txb4=;
        b=KPUiuDHRB9UvnsWvYSCQcNy0VDKiHzC+3IimjiC4E6CAmAzK/ChgO0yvsoyBAJ0fdi
         UIbys0MU7sXOzTG2HelUg9n1gBZ7wq+3pcWe1CIQwMAA9BdcgjwxB821KSwJpHWibmPz
         kA5Sq44kG07EuPxR0zMowKwFQTKlgEpHp0HKMl6P6N4i5gqtt70PX+5p3snY+aTLLDOG
         GgFpkyhL6TZI/4Sh8RpWIzEfpWGUfi65t3IUCih6wkvV1ehpN6+lCRABvlz6Iyy/ZtTE
         mvLmteGP1dTGFCu6shHmpmOfpqCix6ayzgMeFWdcJrzCTD8KKmmDlqdgwmuBvGJC+91O
         sg4w==
X-Gm-Message-State: AC+VfDyrYAe02bwtKT77HbxIPjeDVZwn2VEBStvKjM5cqgazBWGiidHD
        WS4yD/zSBYiXnby09RsxCpFwgVSI3HhHYE7qZG7vag==
X-Google-Smtp-Source: ACHHUZ5m4CsWNuBusUZbEv/CFI9N53zLRqqE56Gsn9iIA1ffpdic8WDqyzU3a+fj0pjBa98jYGw992kamWSdldSVVXk=
X-Received: by 2002:a1f:5c43:0:b0:45f:ed55:4cca with SMTP id
 q64-20020a1f5c43000000b0045fed554ccamr5861243vkb.6.1686641488729; Tue, 13 Jun
 2023 00:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230612101715.129581706@linuxfoundation.org>
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 13 Jun 2023 13:01:17 +0530
Message-ID: <CA+G9fYtbQ2uO7_vnDWuxfwoQ1dNRdJZqXQBE7H4iqesDZsMz1Q@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
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

On Mon, 12 Jun 2023 at 16:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.8-rc1.gz
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
* kernel: 6.3.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-6.3.y
* git commit: 718be3905b8f1b4c3ef58c6b82bba0bb167f5da8
* git describe: v6.3.7-161-g718be3905b8f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.7=
-161-g718be3905b8f

## Test Regressions (compared to v6.3.7)

## Metric Regressions (compared to v6.3.7)

## Test Fixes (compared to v6.3.7)

## Metric Fixes (compared to v6.3.7)

## Test result summary
total: 173472, pass: 151655, fail: 3242, skip: 18318, xfail: 257

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 141 total, 140 passed, 1 failed
* arm64: 50 total, 50 passed, 0 failed
* i386: 37 total, 36 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 42 total, 42 passed, 0 failed

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
