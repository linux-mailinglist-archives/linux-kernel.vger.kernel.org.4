Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46B95FB1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJKLqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJKLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:46:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57919378D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:45:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w18so4320934ejq.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r/G7Viduy1q12MSxFmqoKNXmv93wLfiRLHtzJhLt738=;
        b=yozCrNjiHXBa8wGFvIMC8yUJeFiyfDJJMytqgTFNOatnN5tfeB7+lrW/Obhpk+fbca
         FLsx1YAZDvDDWhH2/bu81YuWQoMz0zSOprAnepYkjNUvPFvW2c3+3qdqSXnVTSWvFoR6
         WsHzflnqngPInyVThxbVevk+L1wAG+Ly+TyBLaoQmu+DkyImN3IAFypcSFV2bJEt5p2H
         ugAJJHJXzq49SVnwHHR6QZijFXCLOmlsgzUsekSfAAT8DmAKCbM0gfCxjcNsWYeSktDf
         w7A3XZ8m6mVPBWEslgzi/zL197/wHrH3FeEvErrP6kHPiIH9z6oymb0mKoZ4H9wYK/Ap
         /E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/G7Viduy1q12MSxFmqoKNXmv93wLfiRLHtzJhLt738=;
        b=w8o3OZQv+c09v+YMRBrqvEYXDCsu13v0H/o/osOTXW3hnb5DrGvko8dRUwXahy9rTH
         G8NLVq3Gk4Kk2YqDE8FDcsY9Ii3TuC1RqZkO41vLohD+PKQ61Xhoxr3oJ8uNZsEWL6ff
         r3wGHIGdYKdHKdnvHRWDulKiDecqpBgjQQEdBBbf85neq5TM4h1nA5Ljd6xQVKrXIMXM
         XycXzghce/fU+4ZTw4zu7szpUTTZhezCsAt2Pc2GIy14QfCR+IVFN8d5tMSXp0/88PsP
         GotxeL7z/IuOjxJqzZqzGT4jMhaBxtTmadz1oaNSks2wQ0XNvjF7cBDGvb0HGbvgBNn4
         ujXw==
X-Gm-Message-State: ACrzQf25gu7Ek5YSE4T8W6oeRC+BqIBsRv2aNkE3WrODDKZvlK75alFY
        kuDhl27o6L+lPWn2nKCoXrmyuv8n2JhVjLx8YDbTNw==
X-Google-Smtp-Source: AMsMyM7f8YXkK4kLNMpvuHUahcCsdDuelOk96lqLJNoKQcJ2UfLuaazXvHiQuFpY5FEph1ouZdNJG2EoDbi078cgpUU=
X-Received: by 2002:a17:906:fd85:b0:77b:b538:6472 with SMTP id
 xa5-20020a170906fd8500b0077bb5386472mr18273873ejb.48.1665488717399; Tue, 11
 Oct 2022 04:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221010191226.167997210@linuxfoundation.org>
In-Reply-To: <20221010191226.167997210@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 11 Oct 2022 17:15:04 +0530
Message-ID: <CA+G9fYuZZ3aQsH-cdgW6jrmMPVADYGokp1iz993fJ-rs=W7+OA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/35] 5.15.73-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 at 00:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.73 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Oct 2022 19:12:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.73-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.73-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 197d9e17aabe8a6d8a323d8dd3d08487fd9cb33e
* git describe: v5.15.72-36-g197d9e17aabe
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.72-36-g197d9e17aabe

## No Test Regressions (compared to v5.15.71-71-gc68173b2012b)

## No Metric Regressions (compared to v5.15.71-71-gc68173b2012b)

## No Test Fixes (compared to v5.15.71-71-gc68173b2012b)

## No Metric Fixes (compared to v5.15.71-71-gc68173b2012b)


## Test result summary
total: 105666, pass: 93487, fail: 668, skip: 11215, xfail: 296

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 333 total, 333 passed, 0 failed
* arm64: 65 total, 63 passed, 2 failed
* i386: 55 total, 53 passed, 2 failed
* mips: 56 total, 56 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 63 total, 63 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 24 total, 24 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 58 total, 56 passed, 2 failed

## Test suites summary
* fwts
* igt-gpu-tools
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
* ltp-open-posix-tests
* ltp-pty
* ltp-sched
* ltp-securebits
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
