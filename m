Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E95BAF66
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIPOaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPOaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:30:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB073AE6A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:30:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z21so31754670edi.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iq2ziHb7n3k50v5MNQWihxa9dFCmp8hrAwxBI4g5ll8=;
        b=onAy8em61y5ZppUVfmIUlegHQdOfSXau5/phHj/yjk5via3T/CVmqWXIUFidU6EX5v
         JoduAS36bqBvOALHVKcMVzHSZGnrT1+jzBmemrhovHcKevMgdzUgw8amUKb+1gFCUJ4m
         agyzcLzqVHJ9oaReZDbhQ3JtBqgKgko+7LHUdjGvUZ/YN1RH3J+ALTZo11qGnK/F0nqk
         rhZ/T/zROz9CCFCnNgfL5e3vMnNPj9unsvzr7O64Jj7yPqwej92KiHa6PBOH37+MIbY7
         WjtyN21JkwIUqthXeAD1XmdGZBn/sjSpqfQD6UbDEl1F5wo3rwqKir0ybyQL4xo3Yccc
         M4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iq2ziHb7n3k50v5MNQWihxa9dFCmp8hrAwxBI4g5ll8=;
        b=CzDOdgZILjWyNVoV34rqjqL+xspJ6IvzUMbNY/sKvB46XdJzxLFJv+jfTWUFZYk7NQ
         BxwCLN2VYCQ4Y0v4JmuPg1cvorEBOpeoTC/b9mlRj4MKSSqIPP0GMAFhwHeDOkfcmzhc
         HyzVOadPK+1pp7j1YbBtHvKpJZz8L8Gz60K4jkpnoHeq0h7+7rWHTNneagGItOA8IsEg
         zfAz+CffdaKcVOQMYc8jhOqdDRv363QtbCPS7w7iYMnM4QAvqmV9dkLsBF9ODrhYIDUO
         Z6kdox7ljfqpLd38jPTYGdDAsa4n/Q4XX8fyIswu11d1ThEvTHKIDyWHWDTRRQdYul6g
         Xo3Q==
X-Gm-Message-State: ACrzQf1tVYuj1V5+vUHcM9EoLqdNjGLull+q4Th/CXq48dQ7hVaVOTo5
        6BvshcrxFWx8dv5GOqM1F/MZyQUSexxDzjGxpRLoiQ==
X-Google-Smtp-Source: AMsMyM7FBT6qo4giOi6BSkTiPUFcw8D+h2IfR/oxTTneT1ww2VQcNoyVuO7NUB597LzjnmEHj8c00V94DRgOQ4IO+zo=
X-Received: by 2002:aa7:dd02:0:b0:44e:f7af:b996 with SMTP id
 i2-20020aa7dd02000000b0044ef7afb996mr4203296edv.422.1663338600825; Fri, 16
 Sep 2022 07:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220916074253.781428-1-brgl@bgdev.pl> <CAHk-=wh7XqYTJgDHGF5xYBNJEKtf1wQ7Gg3vjr+onevNN8uHvw@mail.gmail.com>
In-Reply-To: <CAHk-=wh7XqYTJgDHGF5xYBNJEKtf1wQ7Gg3vjr+onevNN8uHvw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 16 Sep 2022 16:29:50 +0200
Message-ID: <CAMRc=MfHuMtYXNN5q=HT8tXWH+PEbkriAMsun9f8HujdXAWjAw@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v6.0-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 4:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 16, 2022 at 12:42 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.0-rc6
>
> I think you forgot to push the tag, there's no such thing.
>
> I see the branch ("gpio/for-current") that contains that top commit,
> but no fixes tag by that name.
>
>               Linus

Sorry for that, the tag was indeed not pushed out. Strange, normally I
would have noticed git's warning about the missing tag when running
request-pull.

Now fixed.

Bartosz
