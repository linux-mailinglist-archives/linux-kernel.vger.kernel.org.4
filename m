Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A590748967
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjGEQkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjGEQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:40:37 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522011994
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 09:40:36 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b0419f758eso577958fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688575235; x=1691167235;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnXtS0u7cxVKylA7y1RxoIQ4YN3kdP9jrP9NUBsVEYI=;
        b=gHKiyHgp+mvsXbR1zsPiWsWG1g1hSf9IhEiLje+5czHuwPsZfGI3JGvaDx8/LfZOx2
         8WmMeNWm2uwsL4PcxnCPb9kaYwvVmgtnZFLRs5xeT73qsVtBR5aEOHHDrcu6+hVYEXmC
         Jv16uIcn7JI04mXdk+z12aU6ZfJIAS6qkd5wB3b8TQykDnaTIfs561r45+hXbsW/yL5/
         pyzteM29/0og6SwQd1RJPPSllmU0i1lKxqVtqc7UgE7UOpYmvtaUJ8eq9jfW4xANMdnf
         Pz+uoLlELyvufREDhnQLyW1Xjv4D4U7XvfKyxAs3cdKkJQ0ajgGFULbKcAzjNXTEFcbf
         T2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688575235; x=1691167235;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SnXtS0u7cxVKylA7y1RxoIQ4YN3kdP9jrP9NUBsVEYI=;
        b=ByOFl71VEi3PEuS0RDBGOVjNvanXJjGk23MYVqkQzlxzb8M39fB+H0FNrRiFgc6Sal
         i48TQ1PTfCkZkQ+Hn2qhlsFLxv9f/4rLbVq2mydwwxATdM4IJ9YteCgHM/wuqoZQqgx5
         MNguLPF1SB+Xg1XtNjqNK4t3vG2uMkGMfF+LDQ+Zesaa1YZ8lU06hpMofbXpp7+B1q9C
         H8e+D3PFHkcHxC9NUnQ2gLupXUhvoDCcKIvzjby9yPIQN4+tZYK8WlXxqr7yoL2hRXwQ
         GG89tH0iWd8UrHrOYumodTo6pfqci0nMyu8zpsOaNb+lbGEqm6g6FHNKnS3Cwd07701b
         wnEA==
X-Gm-Message-State: ABy/qLbPo7v95vXrWZmEAtDIBKhxVEyt7JhtfIl0lOlj/OmkaEoIWQmX
        YTwumTk4uo5dAStDUH2RASpFYg==
X-Google-Smtp-Source: APBJJlHVEMulR3Unas5/tn8Pqg9sNrGdpx7bs8aiYN3ehYDxqBMbf7wSCcg1IJaq2bFMCYT0aAlJVA==
X-Received: by 2002:a05:6870:d629:b0:1a6:8911:61a9 with SMTP id a41-20020a056870d62900b001a6891161a9mr1552438oaq.29.1688575235566;
        Wed, 05 Jul 2023 09:40:35 -0700 (PDT)
Received: from [192.168.17.16] ([149.19.169.25])
        by smtp.gmail.com with ESMTPSA id s17-20020a056870611100b001b3b14e2a0bsm3877537oae.19.2023.07.05.09.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 09:40:35 -0700 (PDT)
Message-ID: <325f1046-6003-bd7e-fc0c-251005a1a257@linaro.org>
Date:   Wed, 5 Jul 2023 10:40:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Subject: Re: [PATCH 6.1 00/13] 6.1.38-rc2 review
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, 04 Jul 2023 09:48:32 +0100, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 6.1.38 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.38-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

## Build
* kernel: 6.1.38-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 185484ee4c4f93669a3a7b324d356d643fdbfe35
* git describe: v6.1.37-14-g185484ee4c4f
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.37-14-g185484ee4c4f

## Test Regressions (compared to v6.1.37)
No test regressions found.

## Metric Regressions (compared to v6.1.37)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to v6.1.37)
No test fixes found.

## Metric Fixes (compared to v6.1.37)
No metric fixes found.

## Test result summary
total: 171025, pass: 135962, fail: 2579, skip: 32314, xfail: 170

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 147 total, 146 passed, 1 failed
* arm64: 53 total, 53 passed, 0 failed
* i386: 37 total, 36 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 42 total, 42 passed, 0 failed

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

