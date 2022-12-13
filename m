Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6C64BB86
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiLMSES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiLMSEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:04:13 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591F923E99;
        Tue, 13 Dec 2022 10:04:12 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id jr11so489282qtb.7;
        Tue, 13 Dec 2022 10:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTTQLHgy9Q/Zctr5X5z89kcadx7K+UFZq2P5wu79Zh8=;
        b=j4AXUeYzmJbO4UujOehIus62UjSHhJiFdCHJ0fVY3JjJ006MT+mEtA1MjoE5Yrd1Cy
         O22T59p2O5Xcio6bEXfRhv+5q7zjfmqte0cZJsdCMRhWcxtchK8zLrY0arPO+Jk5EB30
         2+4yvGmtPk0ATXyhfYgEbyL50FPoPWbPyDi85qFJlgxCzYENI6d7VkyCzvwYbRKksQPA
         SOtgmdgSz0OdydmIdoXgHOIVSBKaoBFYglEnfmwpwFq/A1MpxqfJAsZvuP1MiFmyaJX9
         C6mVexM196z+evhtUh7PvYj6cWJr9GYOYkNahWwpWT6drPWFTzvL1Oj7WE5lluNfcKq5
         Qqww==
X-Gm-Message-State: ANoB5pnDWMeiaub8Xj6dWL164sdtwMWE6bYirCnRe56E2ph/a48Cec5H
        D/YJciS+APN21w/g9Jnudcn0JutSwI48Yoni91A=
X-Google-Smtp-Source: AA0mqf5k3z1ddVGLk4Eslp0YhKDVfCT8B7U2a+2B2dIOu2IxOmw56qEXzwTNGuLLRWxeG9p3gPnXQqT6q1Y9FOoff9Y=
X-Received: by 2002:ac8:7dcb:0:b0:3a6:8dd0:4712 with SMTP id
 c11-20020ac87dcb000000b003a68dd04712mr32048520qte.411.1670954651440; Tue, 13
 Dec 2022 10:04:11 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0j=CNHAC-H9ci6qpTEeG4R1TD78oQWoKZXALN4TzPZubw@mail.gmail.com>
 <CAHk-=whBn0PmD0pV5RZnnO=75tMd9XLFVstKfNxH5eM6MCK1-g@mail.gmail.com>
In-Reply-To: <CAHk-=whBn0PmD0pV5RZnnO=75tMd9XLFVstKfNxH5eM6MCK1-g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Dec 2022 19:04:00 +0100
Message-ID: <CAJZ5v0gPYdjz40mTdWZmh84NAf10ivkyBFVgkMERTnnu4PrR9w@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control updates for v6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 10:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Dec 12, 2022 at 9:33 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > I would really appreciate it if you please give me your recommendation
> > regarding the extra thermal control material.  Would you like to
> > receive a pull request with it later during this merge window, or
> > would you prefer it to wait for the 6.3 one?
>
> If you are happy with it, and feel like you can review it and get it
> to me in a couple of days, then fine. But I really don't want to deal
> with it after that point - I'm on the road over the weekend, and then
> the week after that is xmas week. So at that point I'm solidly in the
> "it can wait until next release..

Thanks a lot, this helps.

I'll see if I can get the pull request out by Thursday (or please let
me know if that will be too late already).  Otherwise it will wait for
the next merge window.

Cheers,
Rafael
