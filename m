Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED36E46A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDQLkN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 07:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDQLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:40:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD39776A5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:39:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a342f4c8eso98976766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681731498; x=1684323498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/aw1KR9w+aBrMUs+mn4AJ435pOJ7Rn5INzRUj92jpQ=;
        b=ESCxDFnnUTzbP8BAIFkI6A4Z5oPkJIA8G6fVY50Vfx3pI+un+MOI7Ynk24Nhv2BiHn
         WHNP/1bFVQt/RMOB8tQLmq2JguL+Y3SrMmDTWSFbodX8KOemmuZ+NpdJu3C1yCUQi+O2
         BS/j57oXLu3tfEraGnGOdF6ADomdBwX4/9JrxrZazUaJFAsSiYZGCUwUhaOB2ew/aeUs
         RKafyNnfe/cGKlzegqTsqJYtK7dZ0QOLwUvUuWHxu7HyRRljlKSFA0bug0mteaLp4gZx
         1fL+kV0Mqf/yXCT52mlrJ2rLniC14AIygAOvh1YRvwkr9b6bYRsqb5NZQ+BFJqXH6t0l
         yGTA==
X-Gm-Message-State: AAQBX9d0UhwTvTOSQ4nUnbpqE3EzPJPR5HniE96woPT+YT9jQ+97C8Nx
        WyXQLDVK73hEn+AI6/FNjF2BpVRQzmoeTFN6v8CTvWznjrg=
X-Google-Smtp-Source: AKy350baN95neUjNrHOgHmvL1tImB5jWGwoeZyUEBqSe9LGD7WyoU+WMIOuCwueZTzuRur34sCie9B8HuleYIvm9e5U=
X-Received: by 2002:a17:906:74c8:b0:94e:d688:fca6 with SMTP id
 z8-20020a17090674c800b0094ed688fca6mr8253384ejl.0.1681731497811; Mon, 17 Apr
 2023 04:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <168166781352.1843526.278570500979918184@leemhuis.info> <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Apr 2023 13:38:06 +0200
Message-ID: <CAJZ5v0j_MwW6JaqTRNhmz=LcW8==GZ0X-=W0+z0tOsGQyDd0Dw@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-04-16]
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Rafael Wysocki <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 10:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Apr 16, 2023 at 10:59 AM Regzbot (on behalf of Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > Wake-on-lan (WOL) apparently is broken for a huge number of users since
> > 6.2 was released[1]. This is known for 8 weeks now and about 4 weeks ago
> > it was bisected to commit 5c62d5aab87 ("ACPICA: Events: Support fixed
> > PCIe wake event") we immediately could have reverted. The developer that
> > looked into this was even willing to do the revert late March, but then
> > got discouraged by a maintainer [2]. But well, a fix was apparently[3]
> > finally posted for review last week (to the acpica-devel list); with a
> > bit of luck your might get it next week. Still a bit sad that 6.2 is
> > broken for so long now, as Greg wants to see it fixed in mainline first.
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=217069
> > [2] https://bugzilla.kernel.org/show_bug.cgi?id=217069#c50
> > [3] https://lore.kernel.org/all/754225a2-95a9-2c36-1886-7da1a78308c2@loongson.cn/
>
> I find that bugzilla discussion very confusing, it's not clear what
> the status of the patch actually is.
>
> And the sane lkml thread just says "the patch is under review" without
> actually saying *where* said patch is, or where the review is.
>
> It sounds like it got perhaps into some internal ACPCICA queue? None
> of those links are very clear on any of this.
>
> Rafael?

There is a pull request for ACPICA that corresponds to this (IIUC),
https://github.com/acpica/acpica/pull/866
