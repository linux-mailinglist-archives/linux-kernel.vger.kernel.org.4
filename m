Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42D620D23
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiKHKVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiKHKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:21:39 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38840462
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:21:37 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id j130so16813065ybj.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4oYQISnVriXo+GC9BKkmEWGVXOoG0bIt8TJYQZTFqcE=;
        b=PpRgDt0N4dmFlgETaLNvqTedowSImMY0gqDdk0tNuc90WDNE8LumxXgMfBC2o49wNs
         O3ATfYBo+NdQmG5V5lkItxvVXXQMy3KFg+Jke31SnHo+ojyLdzyqmqXsejAFwDEiq1IA
         yyHZ5b+WMCAcSv/tq0pkOrwGCCHUXKHUuW0L2EnIZcZdCpcOO5goe0M5/3t1opiHpBn5
         HsWJ8sFaGwYA9Aqo3gpevJ9aOofpemAytlPFTblNB+NWC+qaqCkokbQw5pj39zXJTba1
         yykRFp5zv6WTOoNW4JuDNaRScXMwecZUnwA5xJ0/fbx60dZP1kacTr4AjrOrK9QrFQUH
         l1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oYQISnVriXo+GC9BKkmEWGVXOoG0bIt8TJYQZTFqcE=;
        b=72OTz8VlP2HWUHWSOSchDbOCsjNFxPIiEsUjwbNOUohLCDfN8o89NQQQyRYSYyO+Oj
         OZ0I+1387F8gBtdOEZjYdnmrHryH5d3cEUBhh3VN3TyFmrNA3vCWS1RtYqzeaVnlEG/P
         jcdLcK8/IWC1S2FT1BIQ4GtxJ2c1ghwtzyMXgAxIIG7k9SUV3XXmHzR2B/ApbT3+4+hL
         7TJnHSnOPtyZ6ubMLyESLGEFCpME7Soyd3KHRmhR45AaOheGlqKAXbEF0aEiXa5k8vvJ
         kJrgjRuoWH+kIhvnYPONMUuHC4UmlaID9xMX/l1bUvCDb5pM6ckDgP9qysyzb2D2q2ht
         CC4w==
X-Gm-Message-State: ACrzQf0ohrspu4xcOs2tmewr+u0a3pCDQKH5eE86jb5EvLIzMSxQmfih
        mMCB6bc8n69NtrhvsZxdiingpMPEBNMndiW23xWvSw==
X-Google-Smtp-Source: AMsMyM7ekyhLU/8aJaMIshQ494+WGBAeUT2DNE1kc7UFsfZ/ar18i8Flj+J6P88hP2RAUKytcjiIjAILhwDLCWx0bwY=
X-Received: by 2002:a05:6902:154d:b0:6d0:c289:7b9 with SMTP id
 r13-20020a056902154d00b006d0c28907b9mr29496738ybu.534.1667902896092; Tue, 08
 Nov 2022 02:21:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYs+fOTBO=aTfO57xby=QQDaqUt4umwgo6bwLB_iGoSEPw@mail.gmail.com>
 <20221108100420.6zhmrio226vbii4e@wittgenstein>
In-Reply-To: <20221108100420.6zhmrio226vbii4e@wittgenstein>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Nov 2022 15:51:24 +0530
Message-ID: <CA+G9fYtoqQq9xgpEzPL=q7ds5WbudRYikBHEAZAh_25SkPj4ww@mail.gmail.com>
Subject: Re: selftests: clone3: clone3_clear_sighand failed - Bail out! Failed
 to clear signal handler for child process
To:     Christian Brauner <brauner@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Florian Weimer <fweimer@redhat.com>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 at 15:34, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Nov 08, 2022 at 03:28:55PM +0530, Naresh Kamboju wrote:
> > selftests: clone3: clone3_clear_sighand failed on arm32 and i386
> > but passed on arm64 and x86_64.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > # selftests: clone3: clone3_clear_sighand
> > # TAP version 13
> > # 1..1
> > # # clone3() syscall supported
> > # Bail out! Failed to clear signal handler for child process
> > # # Planned tests != run tests (1 != 0)
> > # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> > not ok 2 selftests: clone3: clone3_clear_sighand # exit=1
> >
> > Test details links,
> > https://lkft.validation.linaro.org/scheduler/job/5820146#L1795
> >
> > Test results comparison link,
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_clear_sighand/history/
>
> Seems before 27 September 2022 this test wasn't run on 32bit instances
> and noone ever noticed?

This email is about sharing the results log and reporting failures.
If you think it is not supported on 32bit the test should SKIP instead of fail.

We have test data available from more than a year,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_clear_sighand/history/?page=13

- Naresh
