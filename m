Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE28E6CB383
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjC1CBP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 22:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC1CBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:01:13 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132EE213B;
        Mon, 27 Mar 2023 19:01:10 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so2994764wms.5;
        Mon, 27 Mar 2023 19:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679968868; x=1682560868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtdoywSg0sqxDkZWwUZLe9PwThZK6+X1Vn5yjVkPniA=;
        b=q840BmdOmNMtI8DqpqCz6zSm4aiIWVNTdobEqXSp13Qcxqex1QLm6NmKvN5t50Pdrv
         Va1bkkSzf4enrmdWC/2VLULvJDL+XOZrLe/pDmITsjvZhLPzQSssc7oTHUofs6jKmUVl
         w0Q2zVqILSaPaG9rngP/651ZFCGd2JGoe+1uSUcwvwk51f8BsSLIidVDQwiJjrrZni6B
         m7N0WWwMqW0/QbmVLyU5UqHXCCTdLlwfHwOoABw5gRbv68QHYLoF60DreDqaUaR8HkLe
         PLzgWH7m0S6vIZS/dde0yenn5maE4lLEYGQnQnSXPP1oo11OG1N5mhK45rSnFkBTr6HE
         Fd/w==
X-Gm-Message-State: AO0yUKWPqN+KfW9I/M3hc29qvRepNM9gx8TN10KtH1AybgSP/hMnrsnZ
        MKpraDqurtsdPhI9k4Q23RdWqBaYjiLglutTv30=
X-Google-Smtp-Source: AK7set8Dgf5IkOqr80Zrge2p5LfFf7474+KGgg1W4Is5eNDeeskXjNFRpTG1P0L8KMpXGbz4l1NUUCouMbv6LNCatZA=
X-Received: by 2002:a05:600c:2043:b0:3ee:4678:dde with SMTP id
 p3-20020a05600c204300b003ee46780ddemr10994112wmg.27.1679968868269; Mon, 27
 Mar 2023 19:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org> <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
 <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
 <CAP-5=fXWDPzuFrrY+uKnfoa5gO9eEfGUsbCyXB8AS7Tz0ZX=jw@mail.gmail.com>
 <CAP-5=fVHK9VqMs=px3ZzKjinFG4t+oOZ8x2=65_jjds4DiSXLg@mail.gmail.com> <CAP-5=fUTAABzK2e_S3kFYV8jWCrHKfj10wPpTnthQjCLy7d2Gg@mail.gmail.com>
In-Reply-To: <CAP-5=fUTAABzK2e_S3kFYV8jWCrHKfj10wPpTnthQjCLy7d2Gg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 27 Mar 2023 19:00:56 -0700
Message-ID: <CAM9d7cgdkzbzR+TjJo-gv1mNqCCxhyvWrXCFsVrpPHs19RNZYQ@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2023
To:     Ian Rogers <irogers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        paranlee <p4ranlee@gmail.com>,
        Madhu patel <patelmadhu06@gmail.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Lukas Molleman <lukas.molleman@gmail.com>,
        n2 h9 <n2h9z4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 27, 2023 at 3:01 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Mar 27, 2023 at 2:22 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Mar 13, 2023 at 9:38 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Feb 22, 2023 at 7:58 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > The Linux Foundation was selected as a GSoC organization for 2023!
> > > > https://summerofcode.withgoogle.com/programs/2023/organizations/the-linux-foundation
> > > >
> > > > This means we're looking for contributors until March 19th:
> > > > https://developers.google.com/open-source/gsoc/timeline
> > >
> > > A reminder of the GSoC timeline. Applications open in a week;
> > >
> > > * February 22 - March 19
> > > Potential GSoC contributors discuss application ideas with mentoring
> > > organizations
> > >
> > > * March 20 - 18:00 UTC
> > > GSoC contributor application period begins
> > >
> > > * April 4 - 18:00 UTC
> > > GSoC contributor application deadline
> > >
> > > Thanks,
> > > Ian
> >
> > A reminder that the application period closes in just over a week:
> > https://developers.google.com/open-source/gsoc/timeline
> > April 4 - 18:00 UTC
> > GSoC contributor application deadline
> >
> > Thanks,
> > Ian
>
> If you are looking for ideas on how to write a good proposal, PSF has
> a collection of previously accepted proposals:
> https://blogs.python-gsoc.org/en/
>
> You can also see the final report of Riccardo Mancini:
> https://lore.kernel.org/lkml/3c4f8dd64d07373d876990ceb16e469b4029363f.camel@gmail.com/

I have a proposal about the build without libtraceevent.
Now it disables many perf commands if it doesn't have the
library.  But part of sub-commands would work without it.

For example, perf lock contention has two different modes
one is to use tracepoints (using the libtraceevent) and
the other is just use BPF.  The latter should work require
anything from the libtraceevent so we can enable such
usecase.

Others like perf sched, kmem and so on might want to run
only record part like in a small embedded machine (without
libtraceevent).  Then we can copy the saved data to a host
and run the report or other sub-commands to analyze the
data (again, using libtraceevent).

Thanks,
Namhyung
