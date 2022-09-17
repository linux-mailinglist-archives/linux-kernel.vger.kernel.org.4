Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B883A5BB963
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIQQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIQQcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:32:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA9FFCA
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:32:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kr11so9639095ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wk60V2JZ5/8m/6AXle+vWgSEFySvQ5cikPAjV4l3e+4=;
        b=QueiQcezt6QnZIAroPnyxrGwxQiyZ5pgqLVySVUxVjUE7KFGqjOtwiWssXniEwJ56W
         DL/rLcCJYnMtyUly0aiNRe2xax8MJGh8MR4kOrU0gK69eX8yzfYj+1xSeg8js7E13C4I
         CQcQUSWbDlVk++7YbnaKxuH8s4wXgA7aRIEEsk5shLt3pq9xgOq+U2MVkOklFP7Xu6s/
         nROg0zVpyVZVzVT4X3kJhgAJl0FtgmsqwRkBBjA248i/Vf0ESliTnjO7PpBX+8LZcs5r
         rG1Se3t68Xp4U9Dn3pcSlHxLp2vCj+k00z+b9qsfKCARlAQmo95iUghsMSR1jk3P6+PW
         7xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wk60V2JZ5/8m/6AXle+vWgSEFySvQ5cikPAjV4l3e+4=;
        b=31S+yumB0LlrqnrhBrqq29OyThLQu/fGQLqcIBYshhdhSX7Kqjalcg+x7T/dlst3hL
         O1O09ACOe0sx4cctq2vTyJ+cNa/+R2jqdY9coCakJBrPkalncMGqMy4R/XILuGB0Uz3x
         WyInPiN2+vlGX7FwwVcaRAkeiC5/uCONS82Lf/1NqiPrps5TgrEVxLaVLK7q736iIE7X
         Jz9szceU5UwkuC+pTx0gqkztZ+PF5dm+0DmRM0c2U7w7DFhVNDFnF9zUiOm+n1Cs8p/5
         poy4zYXy81HkIjK07BmgDLNPDK+0jqRgc6FaQN5DoFJanZVys+PekaYaM6Ygn3Rg/mTq
         lfDA==
X-Gm-Message-State: ACrzQf1nwtNFqY83SH9/KnpyBxAytHvuy+ElOjtHzHbfNfLgfACVslOU
        F3Gf8TBMKT5hrsyS/2f0KRouDqG20hRcMSFNr1eW/MJO5sIlgg==
X-Google-Smtp-Source: AMsMyM6L0Sjiy0ksxuKro+UahilBN6x9BqmyW+KzhMdDDhXjCRyn7f51o8xC5UIGBPGm9sP30Sjr3Ei3lArH//x4sZQ=
X-Received: by 2002:a17:907:3188:b0:741:4bf7:ec1a with SMTP id
 xe8-20020a170907318800b007414bf7ec1amr7459018ejb.448.1663432329215; Sat, 17
 Sep 2022 09:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220916100442.662955946@linuxfoundation.org>
In-Reply-To: <20220916100442.662955946@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 17 Sep 2022 22:01:57 +0530
Message-ID: <CA+G9fYsjMLmiwqmiKOYjKs+twZvfYD5SgKVV3GN3Rq3R=U4ZLg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/11] 4.19.259-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sept 2022 at 15:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.259 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 18 Sep 2022 10:04:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.259-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.259-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: d4263a0749d603ef83c9e887841af68149e87a5a
* git describe: v4.19.258-12-gd4263a0749d6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.258-12-gd4263a0749d6

## No test Regressions (compared to v4.19.258)

## No metric Regressions (compared to v4.19.258)

## No test Fixes (compared to v4.19.258)

## No metric Fixes (compared to v4.19.258)


## Test result summary
total: 86945, pass: 76047, fail: 692, skip: 10005, xfail: 201

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 323 total, 318 passed, 5 failed
* arm64: 61 total, 60 passed, 1 failed
* i386: 29 total, 28 passed, 1 failed
* mips: 46 total, 46 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 63 total, 63 passed, 0 failed
* s390: 15 total, 15 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 55 total, 54 passed, 1 failed

## Test suites summary
* fwts
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
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
