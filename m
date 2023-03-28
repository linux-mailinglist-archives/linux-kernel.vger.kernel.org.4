Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C88B6CB389
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC1CEJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 22:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjC1CEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:04:04 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A530DD;
        Mon, 27 Mar 2023 19:03:57 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so8105590wmq.2;
        Mon, 27 Mar 2023 19:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969036; x=1682561036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gInmUk9P3b9WKA+5yRilxNKeBceFmhgXL21P6JMAxkI=;
        b=8ArlftfR/A5tr+rWiVRy1MnWBY09bERBPmaKqn6rFe8MsXy4B4nvFRI32JNbJPxOct
         px7cCtNUNyt2HkW9vvrZVS+HhpuaEzMy2tOr864E3YSz9Nkga0WoPH95Eyd8uC+NdX1t
         LoQfKQiYGO7VPuOx5e4WRfXKnnjfIhzohQlpduS1IH9ipYoDeL1egjPJzf43+41SgrAN
         lq8ehXzt3yAWou5oiM9LsvgWJlvr5P8GybOnYHzn1szQ/wM8lUmuMh+eDXite01S8FPc
         Wz0R7ico0W/2SSzySpO1mMj9bCjlOZyvraQVrhDmGn/pkfL8vczpam+sxz70mP7ZPuJp
         j0Qg==
X-Gm-Message-State: AO0yUKVSJzs8sy9T08aBekJZqJwVM6dtJPbU07M3n9ZXbHA7zBXb/Dpb
        mdBAFnwJkWdhNvOUN7nedHx02wCqZyDkVHSnrWQ=
X-Google-Smtp-Source: AK7set/AkfY3vKjeYkdkFvtTCzkZG2A3Fm1QMD6O70u77MMJYswx3QWErvKmHWFKRmcn7uGS5+ZvkZ1lqSwXrWisQGw=
X-Received: by 2002:a1c:6a03:0:b0:3ed:dfd8:653d with SMTP id
 f3-20020a1c6a03000000b003eddfd8653dmr11395008wmc.28.1679969035601; Mon, 27
 Mar 2023 19:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org> <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
 <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
 <CAP-5=fXWDPzuFrrY+uKnfoa5gO9eEfGUsbCyXB8AS7Tz0ZX=jw@mail.gmail.com>
 <CAP-5=fVHK9VqMs=px3ZzKjinFG4t+oOZ8x2=65_jjds4DiSXLg@mail.gmail.com>
 <CAP-5=fUTAABzK2e_S3kFYV8jWCrHKfj10wPpTnthQjCLy7d2Gg@mail.gmail.com> <CAM9d7cgdkzbzR+TjJo-gv1mNqCCxhyvWrXCFsVrpPHs19RNZYQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgdkzbzR+TjJo-gv1mNqCCxhyvWrXCFsVrpPHs19RNZYQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 27 Mar 2023 19:03:44 -0700
Message-ID: <CAM9d7ci_1Luc-VKPztNuw1seBA4akB8_2s4uJ5MaROuUtQUFWg@mail.gmail.com>
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

On Mon, Mar 27, 2023 at 7:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Mon, Mar 27, 2023 at 3:01 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Mar 27, 2023 at 2:22 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Mon, Mar 13, 2023 at 9:38 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Wed, Feb 22, 2023 at 7:58 PM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > The Linux Foundation was selected as a GSoC organization for 2023!
> > > > > https://summerofcode.withgoogle.com/programs/2023/organizations/the-linux-foundation
> > > > >
> > > > > This means we're looking for contributors until March 19th:
> > > > > https://developers.google.com/open-source/gsoc/timeline
> > > >
> > > > A reminder of the GSoC timeline. Applications open in a week;
> > > >
> > > > * February 22 - March 19
> > > > Potential GSoC contributors discuss application ideas with mentoring
> > > > organizations
> > > >
> > > > * March 20 - 18:00 UTC
> > > > GSoC contributor application period begins
> > > >
> > > > * April 4 - 18:00 UTC
> > > > GSoC contributor application deadline
> > > >
> > > > Thanks,
> > > > Ian
> > >
> > > A reminder that the application period closes in just over a week:
> > > https://developers.google.com/open-source/gsoc/timeline
> > > April 4 - 18:00 UTC
> > > GSoC contributor application deadline
> > >
> > > Thanks,
> > > Ian
> >
> > If you are looking for ideas on how to write a good proposal, PSF has
> > a collection of previously accepted proposals:
> > https://blogs.python-gsoc.org/en/
> >
> > You can also see the final report of Riccardo Mancini:
> > https://lore.kernel.org/lkml/3c4f8dd64d07373d876990ceb16e469b4029363f.camel@gmail.com/
>
> I have a proposal about the build without libtraceevent.
> Now it disables many perf commands if it doesn't have the
> library.  But part of sub-commands would work without it.
>
> For example, perf lock contention has two different modes
> one is to use tracepoints (using the libtraceevent) and
> the other is just use BPF.  The latter should work require
> anything from the libtraceevent so we can enable such
> usecase.
>
> Others like perf sched, kmem and so on might want to run
> only record part like in a small embedded machine (without
> libtraceevent).  Then we can copy the saved data to a host
> and run the report or other sub-commands to analyze the
> data (again, using libtraceevent).

Please let me know, if anyone is interested. :)

Thanks,
Namhyung
