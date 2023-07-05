Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6A8748958
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGEQjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGEQi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:38:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64181726
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 09:38:56 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b886456f66so4203573a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688575136; x=1691167136;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czNcJppNzYnegRH/R50VyIXlIgnQkoBU7FYSh2as3Jc=;
        b=sYuVJ3rqSHyA7VXn0oA70plCIam8mfF2GSlknOU6GbrYq496ZCcGu4GOkhNMa6iOEj
         nc2ZJYpy9I5h+MjFDJDTmH+Yo3kceStri0So+hj1qXBTnN+nGLUt8/uUYaIkXSvCAeis
         wGnAhllw05hOWFqDEeJjkaxGVu/amvyQgHmmatsXHfBO5/7xV6mLXXIt9ZPHD8hwjthY
         hINAAWQVpl7RZHoMSk28bVNna1480u50rc8vbsHY0L5un1vGm6lwF7EWBmzAHkhSNhd7
         jaOnZiumyf8BEyvlfwbJh+ayCIdcCW4jsgGomXWN/erleAr2cam4c7JiJtt4hFNfZDMO
         /yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688575136; x=1691167136;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=czNcJppNzYnegRH/R50VyIXlIgnQkoBU7FYSh2as3Jc=;
        b=WS0BwtCqGfkBJ9FkMNUC17BZc5Q7eIQNCIElPINS5EciVCqKqaaU3M0S3Od7QUYZGK
         bUoN+76cibLlZWNirm4/13ZxR8JAJ4lrKV0Q3Npp+se4vD/DKIUh9IZFz7wFoXxr+Ing
         K9sNP1dl0vBrg3Iidh8JErd059dP5k744SXeSUWfjrsB4Qef13sNfRTw5MoMrd4WnIvp
         uC8l4VRt/ZyR8bYSy8bzX6Wj5HYn4p+/8RIdxiwkJAUlsVmJLsrK9oZDd70ToTSfb4jb
         jomjoua8xAR6ODs6yBRzPt70b6bTWAxcD/Kn5jT4a4qXJDdRHeuwr5vfDQW856VKIXNW
         hFAg==
X-Gm-Message-State: AC+VfDwmPYpdIYrNgmi+LHuQIAIJvg9pEtKyQvXlVoEIZoWQMXYA8VGA
        Ksx3dn2XydT5d7A/X9No/lBSwQ==
X-Google-Smtp-Source: ACHHUZ6XLI9qZTCH0HMiW8cSiKnzbXNhU0THffpzYzQTuR0YO5hEcnTUNssJKFRKtS6yrHVueAvmnA==
X-Received: by 2002:a9d:6289:0:b0:6b7:47da:3ad7 with SMTP id x9-20020a9d6289000000b006b747da3ad7mr12240462otk.37.1688575136083;
        Wed, 05 Jul 2023 09:38:56 -0700 (PDT)
Received: from [192.168.17.16] ([149.19.169.25])
        by smtp.gmail.com with ESMTPSA id n11-20020a9d4d0b000000b006b735499817sm7963009otf.25.2023.07.05.09.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 09:38:55 -0700 (PDT)
Message-ID: <9115a84a-f264-4fac-ba9d-0d9936ecb53c@linaro.org>
Date:   Wed, 5 Jul 2023 10:38:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Subject: Re: [PATCH 6.4 00/15] 6.4.2-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, 04 Jul 2023 09:48:24 +0100, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 6.4.2 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

## Build
* kernel: 6.4.2-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 289036004f4bd4d640d3f6bfb47667af77c26a17
* git describe: v6.4.1-16-g289036004f4b
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.1-16-g289036004f4b

## Test Regressions (compared to v6.4.1)
No test regressions found.

## Metric Regressions (compared to v6.4.1)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to v6.4.1)
No test fixes found.

## Metric Fixes (compared to v6.4.1)
No metric fixes found.

## Test result summary
total: 173706, pass: 143184, fail: 2110, skip: 28412, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 41 passed, 0 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
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


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


-- 
Linaro LKFT
https://lkft.linaro.org

