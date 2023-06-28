Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C652D740B54
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjF1I0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjF1IXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:23:55 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125B4EC1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:13:20 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c2743325e2dso1077647276.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687939999; x=1690531999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFn/Do9jN3RPupZVUJruVQkAXpC2rvNpM+OVzSO4M6Y=;
        b=iaItv3GMpIVhZsud7gv7o5W6eL/8hi3+YbatlDYiT3M2NfhEwRkXuOyodt/9lM1AqR
         je0h/gtDbOmCb19KXQRHljgKXj4KlGpRqBvgizdQUBXavay5J98ysVFOaHHDWnlOvUkI
         FAqFeP/c/8VF0C0wBP1fgUkOlMyX4VlY+p3xs9JfGExfLruaqE0ygZsitPsrW6ZtqWrN
         wxhCmfwYNzvJEGVYufpJqqv9uZPfr1AkwPUE3+f4lD9zhZyyjTwcinDvm9UswgF9ef7f
         PVCbFPXa0fdi0rL0wOms5nw26lzu4hzdXsMyNzcXxvQC0nGyZzLJ2YFySOud4XFVvXPW
         W/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939999; x=1690531999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFn/Do9jN3RPupZVUJruVQkAXpC2rvNpM+OVzSO4M6Y=;
        b=YzNujlH0m9ImEiW7xkjZINowLJKedWfASiTTaLgnOs3tu2V82SSqjMXjNiStsPBPOw
         LnRGSEFrKo5GgJa1J8fiocAa0IuFM2vU4DfAHDOwjZhZAH4QzsNfpwV+p0ghOG0FTbAq
         Jggnr4a4KlEf579v9NSpCZ9ul3GaBEQWMkJmoowCuY0iYVh679xPzb+j0KPexz0FZsJO
         DCrUbKHI9FdfpGJ1ADSd56B9qpitv6SkpTy0UbHeeHLSuFWkJSyGKW4ng9bda1B2ohq/
         XbJt0cvZCD0oFUDMrHrzMSy1XB1agt0S8rT8Wiod4VOdPmP1B2qQfYqIB5eEwBeP5Tfb
         I4og==
X-Gm-Message-State: ABy/qLagLhpP2JfJSeVwVkvKKUXtXBG2/CL7XBfxJPi5zgRHXT0w+Q82
        0qI9K/RLo1C2orarg0LzBzUjr49ySHeSijG3r37pzD2nzObLwq7WKnhV3g==
X-Google-Smtp-Source: ACHHUZ620+ut1eAZaT3bcrux1OZzch2BmXZiVR/JAa5o3q2SNMYljDhjnw86jyAORwrecq40xjDRJwSnfOiK5+6IE0I=
X-Received: by 2002:a67:f9c2:0:b0:443:681b:c8ca with SMTP id
 c2-20020a67f9c2000000b00443681bc8camr165293vsq.10.1687936638913; Wed, 28 Jun
 2023 00:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180733.699092073@linuxfoundation.org>
In-Reply-To: <20230626180733.699092073@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:47:07 +0530
Message-ID: <CA+G9fYvkRm274Sdk-06dbQuKV-W-mx7K9KM9BER9i_+HH0x4ZA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/26] 4.14.320-rc1 review
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

On Mon, 26 Jun 2023 at 23:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.320 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.320-rc1.gz
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
* kernel: 4.14.320-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 11aa1c2697f51ec92ee0c9033b8bce9e13b71787
* git describe: v4.14.319-27-g11aa1c2697f5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.319-27-g11aa1c2697f5

## Test Regressions (compared to v4.14.314-117-g854d9237fbd3)

## Metric Regressions (compared to v4.14.314-117-g854d9237fbd3)

## Test Fixes (compared to v4.14.314-117-g854d9237fbd3)

## Metric Fixes (compared to v4.14.314-117-g854d9237fbd3)

## Test result summary
total: 61334, pass: 48370, fail: 2047, skip: 10872, xfail: 45

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
