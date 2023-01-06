Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C0D65FE90
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjAFKMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjAFKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:12:51 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35346879D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 02:12:50 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id d14so205344uak.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 02:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywCSUF+X295X7XbFjWuK654uTeSEr3DQy9LQ0QXRwbk=;
        b=JxA2IQYp1OzLpRTt6TJefF1yxxSYEAmcheawYkZApCdToXvztRP6ykTemrQTzi5eZa
         yBF8fZGdBRzUuQFs8cGQdnWjRdPSmHvLj/AfIUdKmQej5LHmCfuRQZrFRqWbAqOckfLR
         X6EobZrXLpp8ArH5LPGwd+6cyuJ8SJ6RCEDA+zqLH3ViGu0bAlvNJWF+XrkaJgMBZnS4
         IAI34lqmP8TPbMpjpmCbZ51uY7rdnu/95O8BAVa17cKac+mp7rFV34dy9n9m5LKvH6XV
         k2Zp+zaeRDlyR80sNsOnPp7m8bKjjGh1/QbZ240oL+Slg4+W3ImhAgbr+hT3yunCrqWu
         E90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywCSUF+X295X7XbFjWuK654uTeSEr3DQy9LQ0QXRwbk=;
        b=pyaM5aOKZBlAwDidORYW97qU+Px7KL3bvmH2vSzpMw6FhJj5w36YYJm1WJBu8s6JdZ
         GRLtjyYnV0MK0qYi8bGlTCMBDOQ95myb2f3eS0whWWf7pAkdpvsCcuvvHJv6eFQs8S1/
         ll7cwOOs2jksJAOwmHKU5Sw4hwQ26m1m1mypubsgiyBiYTazXb5Gd9X2cjyvS0hJ7kWb
         YMC/Zlwec1tYdPzMfJ9Tr5gH1xxlMlwjKdCYY5I5WV88+uL2PYtdbm5qVu0xKJBHRQDP
         1jRgOIxtM6bPe9HkVsRzmX3nOBe4VIhl/9VkWC0zHam5uJGSyN/iHBX66AsQhkHhgria
         lGdQ==
X-Gm-Message-State: AFqh2kpGMw5xJ2sjCli9pqDWXuCmq/3F+wfzKVLKDHyQNnGYHL8DbB44
        rKZB98kqxn8+es7BI/TYeISMOJcnm7LGQBR8R2Wysg==
X-Google-Smtp-Source: AMrXdXuZ3NuN6/159on7c/7uCnqTDsn8Cbh4ESQwvfI5CMjlUpe800yuPE5y7O9SfoRYx8sCKp+7hCbBgCw38Yvi+HQ=
X-Received: by 2002:ab0:152b:0:b0:418:620e:6794 with SMTP id
 o40-20020ab0152b000000b00418620e6794mr5137240uae.59.1672999969735; Fri, 06
 Jan 2023 02:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20230105125334.727282894@linuxfoundation.org>
In-Reply-To: <20230105125334.727282894@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 6 Jan 2023 15:42:38 +0530
Message-ID: <CA+G9fYsgUDmUENC4+a66U=wXP_HQRyEeR8CGZCOy+zjw2pjm_Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/251] 4.9.337-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023 at 18:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> -------------------------------------------
> NOTE:
>
> This is going to be the LAST 4.9.y release to be made by the stable/LTS
> kernel maintainers.  After this release, it will be end-of-life and you
> should not use it at all.  You should have moved to a newer kernel
> branch by now (as seen on the https://kernel.org/category/releases.html
> page), but if NOT, and this is going to be a real hardship, please
> contact me directly.
> -------------------------------------------
>
> This is the start of the stable review cycle for the 4.9.337 release.
> There are 251 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Jan 2023 12:52:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.337-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.9.337-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.9.y
* git commit: e5be668a53e8317a07f6b4a6b3e0b17b232cb6a1
* git describe: v4.9.336-252-ge5be668a53e8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.3=
36-252-ge5be668a53e8

## Test Regressions (compared to v4.9.336)

## Metric Regressions (compared to v4.9.336)

## Test Fixes (compared to v4.9.336)

## Metric Fixes (compared to v4.9.336)

## Test result summary
total: 77532, pass: 66466, fail: 2409, skip: 8290, xfail: 367

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 284 total, 278 passed, 6 failed
* arm64: 55 total, 48 passed, 7 failed
* i386: 31 total, 30 passed, 1 failed
* mips: 43 total, 40 passed, 3 failed
* parisc: 2 total, 0 passed, 2 failed
* powerpc: 27 total, 21 passed, 6 failed
* s390: 17 total, 12 passed, 5 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 52 total, 49 passed, 3 failed

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
