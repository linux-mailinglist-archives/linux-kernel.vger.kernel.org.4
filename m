Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D90746AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjGDHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjGDHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:45:55 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576E10C8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:45:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so3116182276.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688456750; x=1691048750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+F1CRRrDYFWMSeR7pdIM99Yud7CZpQYBqF7uVLNYcg=;
        b=HPKJH25M1EtladfDNW1fzBqu0HKYUZT9duFKOwHMlqZbNtvot4sx/HWaKza4/APrSJ
         fhZIxULQUlVHZc0qAPaU5XCEDfNtPpliGzZWEyY7TOC39x9m1hB0BBv02seqlOP6Dpb/
         frDXuwpbMPhzkYA1BI9xA3Vy5sci7KmRZOYAWsoxREWH8ocXvI6umTvD50JcBHYTX/Cy
         ta+anyV2RqlDMDwYUKQz0tUjPQxiSsYIkoumRrYNLQAfhkBEsCmX/4FA4HX813DsevZD
         1pzjmqJzdfIjFQ+9fFVxBsSUm2sLwjtharaDDuc7tqdk684G/9ghQze/sFpqaa8Hct8m
         b2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456750; x=1691048750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+F1CRRrDYFWMSeR7pdIM99Yud7CZpQYBqF7uVLNYcg=;
        b=ckUebJ3MmIXG4FOmkq4sw5tHvftT2Ns2ol1jGWmLNWB6xS1o4pldxhzQvQkKocYKau
         caFxbeuy54YAXvQd9dWeOKO2Af/XDzMWkBNxYWaWrOLGyIrjvP5eIlQhggex48veFWwX
         6TO25gRM0S5VTCgn0YMAvxHkWIkBAxrkFugjU5im6Xq1jU81GGp1Y0nFE17SiU+KmrUL
         XVEDbtzzuM975pK3zUFuO07F1odlyDh8wSsG+GJwoswBdmpIoNvcrB8mPZGcd4cG4jCY
         HrtJi5BpHm/KfIq1O+LNp9uqQuIYTT98dEc6SdgOrx/f9zf8eRoLJiWaPkWUXHSEp3ZF
         zD3A==
X-Gm-Message-State: ABy/qLYHIDoOdhB/iRP5/2w/+9TPiSDXWvFg/lb/PDbL2VSljvBWvCQd
        9fLRnCpEn0S+ysyNH953ge39ZJAW8hZy4YnuYCeC6Q==
X-Google-Smtp-Source: APBJJlFB3IV/8P2hDxGLg3/Osf2gTqSZWsYYoe3obpZM5g9tCWa6WsCTJCL9aS6pmt3nVrW4MoqplfvdJ/D8m2Uvt4s=
X-Received: by 2002:a25:cc0c:0:b0:c4d:4f44:c50b with SMTP id
 l12-20020a25cc0c000000b00c4d4f44c50bmr7195756ybf.21.1688456750288; Tue, 04
 Jul 2023 00:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info> <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
 <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com> <2023070359-evasive-regroup-f3b8@gregkh>
In-Reply-To: <2023070359-evasive-regroup-f3b8@gregkh>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 4 Jul 2023 00:45:39 -0700
Message-ID: <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 11:44=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Jul 03, 2023 at 11:27:19AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Jul 3, 2023 at 11:08=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Mon, Jul 3, 2023 at 2:53=E2=80=AFAM Linux regression tracking (Tho=
rsten
> > > Leemhuis) <regressions@leemhuis.info> wrote:
> > > >
> > > > On 02.07.23 14:27, Bagas Sanjaya wrote:
> > > > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > > > >
> > > > >> After upgrading to kernel version 6.4.0 from 6.3.9, I noticed fr=
equent but random crashes in a user space program.  After a lot of reductio=
n, I have come up with the following reproducer program:
> > > > > [...]
> > > > >> After tuning the various parameters for my computer, exit code 2=
, which indicates that memory corruption was detected, occurs approximately=
 99% of the time.  Exit code 1, which occurs approximately 1% of the time, =
means it ran out of statically-allocated memory before reproducing the issu=
e, and increasing the memory usage any more only leads to diminishing retur=
ns.  There is also something like a 0.1% chance that it segfaults due to me=
mory corruption elsewhere than in the statically-allocated buffer.
> > > > >>
> > > > >> With this reproducer in hand, I was able to perform the followin=
g bisection:
> > > > > [...]
> > > > >
> > > > > See Bugzilla for the full thread.
> > > >
> > > > Additional details from
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D217624#c5 :
> > > >
> > > > ```
> > > > I can confirm that v6.4 with 0bff0aaea03e2a3ed6bfa302155cca8a432a18=
29
> > > > reverted no longer causes any memory corruption with either my
> > > > reproducer or the original program.
> > > > ```
> > > >
> > > > FWIW: 0bff0aaea03 ("x86/mm: try VMA lock-based page fault handling
> > > > first") [merged for v6.4-rc1, authored by Suren Baghdasaryan [alrea=
dy CCed]]
> > > >
> > > > That's the same commit that causes build problems with go:
> > > >
> > > > https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@ke=
rnel.org/
> > >
> > > Thanks! I'll investigate this later today. After discussing with
> > > Andrew, we would like to disable CONFIG_PER_VMA_LOCK by default until
> > > the issue is fixed. I'll post a patch shortly.
> >
> > Posted at: https://lore.kernel.org/all/20230703182150.2193578-1-surenb@=
google.com/
>
> As that change fixes something in 6.4, why not cc: stable on it as well?

Sorry, I thought since per-VMA locks were introduced in 6.4 and this
patch is fixing 6.4 I didn't need to send it to stable for older
versions. Did I miss something?
Thanks,
Suren.

>
> thanks,
>
> greg k-h
