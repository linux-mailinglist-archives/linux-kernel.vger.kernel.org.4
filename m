Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F667A199
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjAXSnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjAXSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:43:33 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC08E1BAC8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:43:18 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p141so17294200ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkFhT+QE0Ss3sU9kMrqZW2elnAUnc+afRnNOBZnox54=;
        b=LxwaomsRn/d1CbSeA3tz9i64AjBmHkC8ytUwtJeD+fn4maubtUDZkWGF+fyQU9fi7d
         gii5JRq+nIUE6RoAPPEXAFAjAGhKJ7q1F7FHFpuaF7+K7b1slaA8E0gG1QS2srtNzsod
         SnYvXEcbvF0nH9PlJAljbR3tswg2NjohwNBCOi6b6KZnvi/V6QYFJcABAIxOB0aZsMwg
         ZWodU51v2Gwd7Eo7g8poKOJ3ct8ooIDndjlj2KhWylG10lsEIb/4r7GoGn1l5iNX7HiY
         Zw0yUaONHHxLNoBiDZvz5lapS6ndJQC1gXK/IF48nwOFM9ZUpu77H75OkiKTIMYyifB/
         +d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkFhT+QE0Ss3sU9kMrqZW2elnAUnc+afRnNOBZnox54=;
        b=g93FJmsQuzamVKTAmLtd4fnxSquV+8746SX0ljrdJRLngudUM+XA6E5Dh88YHnXYKi
         zrIENV/SGqLt/D8+lXKcLFkJ6adLtCC/qDUaZHEJelMYy3iPddjdhbOoPo98NI+o7Zgj
         fS1SDP2pdONg++5cqUZ8NZELnGSREZY8YrFzw+YGPvvXtdDW72m9SpRYfKN+FSzBQVMO
         Bg0qwG97Pj2uQLvl/ysm0fpMPBNJSfTnqUjg/eaJ/82m1lV3q7yiTFCuTouMdWsFbXxM
         5hUKTuFnJeeFImor5Qg2c6PWZQbfrfBHXrg2MqSKcZqNqDjBXwAwljvrLtYzI9LHQMXb
         yHig==
X-Gm-Message-State: AFqh2krBZxQISMuoWeLI9VBarP+0K6VE8ojbrmu++QzNR32vTO1oa5c8
        Axx/55MJM75T65E8KkPTEkSCxAZyYZQP+rSYCQk0
X-Google-Smtp-Source: AMrXdXstURzL2S1cvuqROU1aPMUNiUYhvM90spwo8zsryjjyzU6FnEMWqjXqqc7kWcpwuY6NVziD412VBYgDg7kPKlQ=
X-Received: by 2002:a25:2501:0:b0:801:4500:63e with SMTP id
 l1-20020a252501000000b008014500063emr2071419ybl.332.1674585797847; Tue, 24
 Jan 2023 10:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com> <CANDhNCpWwxXM8DD9h4zOW+bygshkOg9TWO9Z7wJO_B7bDtgEHw@mail.gmail.com>
 <9c17d6be-e532-84e1-4d35-77b9bd3051dc@linux.intel.com>
In-Reply-To: <9c17d6be-e532-84e1-4d35-77b9bd3051dc@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 24 Jan 2023 10:43:06 -0800
Message-ID: <CANDhNCp_0Os+e0A0LZ7yKw16mWai9MAPMPYL0p1NkcVxifh88w@mail.gmail.com>
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time to monotonic
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 7:09 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 2023-01-24 2:01 a.m., John Stultz wrote:
> > On Mon, Jan 23, 2023 at 10:27 AM <kan.liang@linux.intel.com> wrote:
> >> +               /*
> >> +                * Check whether the given timestamp is on the current
> >> +                * timekeeping interval.
> >> +                */
> >> +               now = tk_clock_read(tkr);
> >> +               interval_start = tkr->cycle_last;
> >> +               if (!cycle_between(interval_start, cycles, now))
> >> +                       return -EOPNOTSUPP;
> >
> > So. I've not fully thought this out, but it seems like it would be
> > quite likely that you'd run into the case where the cycle_last value
> > is updated and your earlier TSC timestamp isn't valid for the current
> > interval. The get_device_system_crosststamp() logic has a big chunk of
> > complex code to try to handle this case by interpolating the cycle
> > value back in time. How well does just failing in this case work out?
> >
>
> For the case, perf fallback to the time captured in the NMI handler, via
> ktime_get_mono_fast_ns().

This feels like *very* subtle behavior. Maybe I'm misunderstanding,
but the goal seems to be to have more accurate timestamps on the hw
events, and using the captured tsc timestamp avoids the measuring
latency reading the time again. But if every timekeeping update
interval (~tick) you transparently get a delayed value due to the
fallback, it makes it hard to understand which timestamps are better
or worse. The latency between two reads may be real or it may be just
bad luck. This doesn't intuitively seem like a great benefit over more
consistent latency of just using the ktime_get_mono_fast()
timestamping.

> The TSC in PEBS is captured by HW when the sample was generated. There
> should be a small delta compared with the time captured in the NMI
> handler. But I think the delta should be acceptable as a backup solution
> for the most analysis cases. Also, I don't think the case (the
> cycle_last value is updated during the monitoring) should occur very
> often either. So I drop the history support to simplify the function.

So the reads and this function are *always* used in NMI context?   Has
this been stressed with things like SMIs to see how it does if
interrupted in those cases?

My worry is that (as I bored everyone earlier), the
ktime_get_*_fast_ns() interfaces already have some sharp edges and
need a fair amount of thought as to when they should be used. This is
sort of compounding that adding an interface that has further special
cases where it can fail, making it difficult to fully understand and
easier to accidentally misuse.

My other concern is that interfaces always get stretched and used
beyond anything they were initially planned for (see the
ktime_get_*fast_ns() interfaces here as an example! :), and in this
case the logic seems to have lots of implicit dependencies on the
facts of your specific use case, so it seems a bit fragile should
folks on other architectures with other constraints try to use it.

So I just want to push a bit to think how you might be able to
extend/generalize the existing get_system_crosststamp for your
purposes, or alternatively find a way to simplify the logic's behavior
so its less tied to specific constraints ("this works most of the time
from NMI, but otherwise no promises").  Or at least some better
documentation around the code, its uses and its constraints? ( "NMI
safe" is not the same as "Only safe to use from NMI" :)

And apologies if I've misunderstood things here.

thanks
-john
