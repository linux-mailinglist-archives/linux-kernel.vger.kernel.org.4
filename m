Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE28620DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiKHKyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiKHKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:54:07 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C7C75E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:54:06 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id j130so16898608ybj.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rfZR5U4gChaI5Onrm1Hyr5yShLag3yC0LYHWhYpsmR0=;
        b=UwpizaPyCRB/wtTIK8L8rPC3/ceyv48IHLpgUp0YZW6OZAEHSn0AMIISrUpqaIlLq+
         M44EAd1fcIpce5Q1PhETFPAU+RCcQueGJA1ZRE3Ex9p3JyGVt6FTLk/YKDtDzkOw5aLR
         kC+06lG8tAXRWD/pcT8MUJBFxTHnkrL3liMd5PvBekEIPB+ilAfiUfoTlwn20zyZRzxo
         Lr6sR1WtCKrKCRCGSrreorm2G/lbiuOmrQM1lzDMmmbgqPwFkneY8mFDMWMZfAdcH8c1
         5HqGUI4neBPPJQ5CGjGyaxug0RuMv7SHTnsZdeFqDKZYjZPB+UG/rf8PR2bF8t46QPXm
         3OMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfZR5U4gChaI5Onrm1Hyr5yShLag3yC0LYHWhYpsmR0=;
        b=Irp2sVMJB046e/5307TBfzCPlyConYNs6bTI5VFXANtlqeZd0Wxw4wY4XWrDqcXOeO
         n5Vqi53QuOAAuxIq1SkSmjimgX/xx1yCvFddz1WgmNAS/aARQlSpTrjETwx6pXsujRk8
         4Zp+6YNDuyd+3ZCT0Ug60+yFj6neh4IDsS3NS5oV3i/5X8SU93RWl6x6+V+ttG3MunNI
         WLecIZGtPVSokRvEi7auer2HZzh9nQHg6QcftvJNnVe39/pOqbw+HqFAiqsKgsvA2F00
         E+hrOJE3U7fruWKlHxduee1kpXw18qp2ucwlKve0TDEYbd7xSZ6MWEa4l2G3hTxjvIs8
         lpuA==
X-Gm-Message-State: ANoB5pktVzWfFppna040X+wy1ppRioMM10aZtwZWf6YT9N0zoGKJD6Vs
        9fohKmW4G0uLS7IoDv3fxzcnRLhvPowRu0Wh8EbW2A==
X-Google-Smtp-Source: AA0mqf7a65z+WGBHF5Px9g1NUDAw3eBvcU7XU6gMVrOWCt2leXp8eGdMyRSNqtGaNlUq13gV7dbS917pYYnX5Z9Za4k=
X-Received: by 2002:a05:6902:b16:b0:6d6:9455:d6c5 with SMTP id
 ch22-20020a0569020b1600b006d69455d6c5mr11950402ybb.164.1667904845653; Tue, 08
 Nov 2022 02:54:05 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYs+fOTBO=aTfO57xby=QQDaqUt4umwgo6bwLB_iGoSEPw@mail.gmail.com>
 <87h6z9ka3s.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87h6z9ka3s.fsf@oldenburg.str.redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Nov 2022 16:23:54 +0530
Message-ID: <CA+G9fYsAA-e+roKY3GoM5BXjRVDVz6wRDZCg6M7GeG_qWMQ6wA@mail.gmail.com>
Subject: Re: selftests: clone3: clone3_clear_sighand failed - Bail out! Failed
 to clear signal handler for child process
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org,
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

On Tue, 8 Nov 2022 at 16:05, Florian Weimer <fweimer@redhat.com> wrote:
>
> * Naresh Kamboju:
>
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
>
> Not sure why you are reporting this to libc-alpha.  We'd like to help,
> but there doesn't seem to be anything glibc-specific in this report?

This is coming from a commit log having CC to the libc-alpha list.
However, please ignore the report if it is not related.

--
tests: test CLONE_CLEAR_SIGHAND
Test that CLONE_CLEAR_SIGHAND resets signal handlers to SIG_DFL for the
child process and that CLONE_CLEAR_SIGHAND and CLONE_SIGHAND are
mutually exclusive.

Cc: Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org
Cc: linux-api@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/r/20191014104538.3096-2-christian.brauner@ubuntu.com

>
> Thanks,
> Florian


- Naresh
