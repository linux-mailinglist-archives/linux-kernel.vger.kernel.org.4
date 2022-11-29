Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0603963CB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiK2WqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiK2WqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:46:10 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3553160D8;
        Tue, 29 Nov 2022 14:46:09 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id o30so12014509wms.2;
        Tue, 29 Nov 2022 14:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doewmcbrgpwjzH89FPXB9ag3RThizYw2YLdZZmvdJXQ=;
        b=mqoJi4bHHJVTNtAwNB0yn/SO3qBgGpMofnRAYtyz7+6zM9fKlKK1FsRvlZMf434i9J
         8ZXLqOGqjAoURnrQpM4pYRMz0GsVYb4mtl1nO3LiPQAYoILI9c2QmIFBny3LIEIYRiSl
         AE68hhUZh27MJMIm8VlnPj7EUVt/4mO9XzC90ox11Y6l1U7gjmGK8fRy4O2qPxwIIgIH
         MaRpJ3GNgCoTWo7KrXdVJZ9M9Q5zLqdqHWS8teE8BoNdyYt6p+KwTFz8vhAh1vyRk+zt
         7LvXdEct7qfvMR9jCTxaOVrWnwEJTG/EN5GsK9nBkDN0itHi58aGOgsONdU/OE0KpYrd
         KkIQ==
X-Gm-Message-State: ANoB5pno0qu7iUF+O+OmdDuyYopQnqCkLlz6KjE+WVbhJBQPoSGTqG3r
        VnF9WGHAU+2wSwYlWVKaIcKtqZlb4vMCYOZqroo=
X-Google-Smtp-Source: AA0mqf5FaoFkx1LA1RviPzk6UA+5Zw1Ya4hdKa8dUwBoyPHFHOQCFY64Pi12d1RgLCUyTqLmndw5/JMCcmdLphEGG4U=
X-Received: by 2002:a05:600c:4f03:b0:3cf:70f7:bfea with SMTP id
 l3-20020a05600c4f0300b003cf70f7bfeamr37626757wmq.104.1669761967478; Tue, 29
 Nov 2022 14:46:07 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-15-namhyung@kernel.org>
 <CAP-5=fVJjPXk2hmWc6xqDxe06Arq-nOB51CwihAuuVFAoaKJ4g@mail.gmail.com>
 <CAM9d7ciARxBRKpwf-8eQr-x5kR8n0Wv3RmycVFdO4ikeYhDVwg@mail.gmail.com> <CAP-5=fWF7ScB0kHKQsqePHmg3sJf22TOfvKcNeYQdMoD0p8Tbg@mail.gmail.com>
In-Reply-To: <CAP-5=fWF7ScB0kHKQsqePHmg3sJf22TOfvKcNeYQdMoD0p8Tbg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Nov 2022 14:45:55 -0800
Message-ID: <CAM9d7cj-JeKiHUM1Eq36937q+o+yj=DKwt_pYQLD6aC5zCTN+Q@mail.gmail.com>
Subject: Re: [PATCH 14/15] perf stat: Rename "aggregate-number" to "cpu-count"
 in JSON
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 7:14 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Nov 24, 2022 at 11:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Nov 23, 2022 at 3:31 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > As the JSON output has been broken for a little while, I guess there are
> > > > not many users.  Let's rename the field to more intuitive one. :)
> > >
> > > I'm not sure cpu-count is accurate. For example, an uncore counter in
> > > a dual socket machine may have a CPU mask of "0, 36", ie one event per
> > > socket. The aggregate-number in this case I believe is 2.
> >
> > You're right.  In case of uncore events, it can be confusing.  But in some
> > sense it could be thought as cpu count as well since it aggregates the
> > result from two cpus anyway. :)
> >
> > Note that the aggregate-number (or cpu-count) is only printed if users
> > requested one of aggregation options like --per-socket or --per-core.
> > In your example, then it could print 1 for each socket.
> >
> > But I think uncore events are different from core events, and hopefully
> > they have separate instances for different sockets or something already.
> > That means it doesn't need to use those aggregation options for them.
> >
> > Also the CSV output uses "cpus" for the same information.  It'd be nice
> > we could have consistency.
>
> So in the original patch from Claire she'd passed the name "number"
> through to the json from the stat code. Having an integer called
> "number" isn't exactly intention revealing - thank you for your clean
> up work! :-) I switched "number" to be "aggregate number" as the
> number comes from the "data" aggregated and the code refers to it as
> aggregate data. I think aggregate-number is more consistent with the
> code, and cpu-count would look strange in the uncore case above where
> the number of CPUs (really hyperthreads) is 72. Perhaps we should also
> be outputting the aggregation mode with the number. Anyway, I think
> for the patch series I'd prefer we skipped this one and kept the rest.

Right, I think we need a more general term to include non-cpu events.
But it seems Arnaldo already merged it.

Arnaldo, do you want me to send a revert?

Thanks,
Namhyung
