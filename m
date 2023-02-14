Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE8696E22
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjBNTwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBNTwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:52:30 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E8328D36
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:52:29 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-501c3a414acso221596637b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f+KDNIeE+nKdS1dZqI0hYpZ5KYkcXvEs5ZHvlJQJfq8=;
        b=OpahYHY7XHs3dEZ1eHiNZd9vr+9zo7VUyHm9XHbWGvXXSec9KffASwXcSaUwUa+Sce
         QSY6H8cQaSTKuXRSSuzSsC4aGzfo0t47lqJ0AN20DlxEBaMQ7uhQLh0tNgj53BC7HCzY
         Ll1ntLWPz0a7p8BRo5l1uC5k6sspScRt8XkpOgqB4J39pnwldjteF6G1SHk3xwWO53Cf
         EU7ftlvkKIQNnsj6h68/t6j6Ps2SDH6EOeYrYcMtz9Cgyb23uzIRMuiikgnGo4zUMJpX
         xsvWJagS62JQSEGwfG+qM0Z4RmjVYiFqfVShevRFrBFcGEfz1gj3btKiDUYK9IMZHbJu
         174A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+KDNIeE+nKdS1dZqI0hYpZ5KYkcXvEs5ZHvlJQJfq8=;
        b=KGksg7xuemleA9R3KqFsvc4p3JJ14gl4JOd2NH7mYrXK3bOnX/nGXNKU7pSl1yi3mb
         eTcdiEYgqQhqet3qttCXr++uHqOp2sWb6gqdR/POikmHRySguqwXpzPOhx+xsa4o5ipf
         JuL5PVQnHCBvLXhlQul0zZ6ZRiO5HCNVqPc2QbuQIBYWrSGWql3hM3Dm78BBFKMhxYu6
         cy9quOdKlyzUMa0L41FP71aQs0+yv9DoYjo1vjmXP48G2unq8qh5KV9H02SgMFxOTXhZ
         GtOa5YmZq9zoyrCxGoQLgv5Cn63KAMs3tF8KEwI+pv2cuROFTtv5GrEYvzO9HOe+KxyB
         0j2Q==
X-Gm-Message-State: AO0yUKXXbKW5ILGgB5Geqs6OyuwiOQUyBxEWRAk1SEaaEavUgecG0qPW
        GiXlTXUCCf/1xakvKv3VsNo1SGmetwFHKIAfYHSJux/UFnKFkNA=
X-Google-Smtp-Source: AK7set9xkgZdLRSWExySyO2VRawgD1XRQas/dNNWMaL9sYwideNtQNUsd9QcwVjER2tCYL3mTYz57/xFIvsuu07wb6I=
X-Received: by 2002:a81:710b:0:b0:52e:cbd1:c97c with SMTP id
 m11-20020a81710b000000b0052ecbd1c97cmr295602ywc.462.1676404348270; Tue, 14
 Feb 2023 11:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com> <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com> <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com>
In-Reply-To: <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 14 Feb 2023 11:52:17 -0800
Message-ID: <CANDhNCo4HugnOeHNaCqbp5R7Na1j_7pU-rWhPE-D9jMO3UdihQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        adrian.hunter@intel.com
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

On Tue, Feb 14, 2023 at 6:51 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 2023-02-13 5:22 p.m., John Stultz wrote:
> > On Mon, Feb 13, 2023 at 1:40 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >> On 2023-02-13 2:37 p.m., John Stultz wrote:
> >>> On Mon, Feb 13, 2023 at 11:08 AM <kan.liang@linux.intel.com> wrote:
> >>>>
> >>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>
> >>>> The monotonic raw clock is not affected by NTP/PTP correction. The
> >>>> calculation of the monotonic raw clock can be done in the
> >>>> post-processing, which can reduce the kernel overhead.
> >>>>
> >>>> Add hw_time in the struct perf_event_attr to tell the kernel dump the
> >>>> raw HW time to user space. The perf tool will calculate the HW time
> >>>> in post-processing.
> >>>> Currently, only supports the monotonic raw conversion.
> >>>> Only dump the raw HW time with PERF_RECORD_SAMPLE, because the accurate
> >>>> HW time can only be provided in a sample by HW. For other type of
> >>>> records, the user requested clock should be returned as usual. Nothing
> >>>> is changed.
> >>>>
> >>>> Add perf_event_mmap_page::cap_user_time_mono_raw ABI to dump the
> >>>> conversion information. The cap_user_time_mono_raw also indicates
> >>>> whether the monotonic raw conversion information is available.
> >>>> If yes, the clock monotonic raw can be calculated as
> >>>> mono_raw = base + ((cyc - last) * mult + nsec) >> shift
> >>>
> >>> Again, I appreciate you reworking and resending this series out, I
> >>> know it took some effort.
> >>>
> >>> But oof, I'd really like to make sure we're not exporting timekeeping
> >>> internals to userland.
> >>>
> >>> I think Thomas' suggestion of doing the timestamp conversion in
> >>> post-processing was more about interpolating collected system times
> >>> with the counter (tsc) values captured.
> >>>
> >>
> >> Thomas, could you please clarify your suggestion regarding "the relevant
> >> conversion information" provided by the kernel?
> >> https://lore.kernel.org/lkml/87ilgsgl5f.ffs@tglx/
> >>
> >> Is it only the interpolation information or the entire conversion
> >> information (Mult, shift etc.)?
> >>
> >> If it's only the interpolation information, the user space will be lack
> >> of information to handle all the cases. If I understand John's comments
> >> correctly, it could also bring some interpolation error which can only
> >> be addressed by the mult/shift conversion.
> >
>
>
> Thanks for the details John.
>
> > "Only" is maybe too strong a word. I think having the driver use
> > kernel timekeeping accessors to CLOCK_MONONOTONIC_RAW time with
> > counter values will minimize the error.
> >
>
> The key motivation of using the TSC in the PEBS record is to get an
> accurate timestamp of each record. We definitely want the conversion has
> minimized error.

Yep.

> > But again, it's not yet established that any interpolation error using
> > existing interfaces is great enough to be problematic here.
> >
> > The interpoloation is pretty easy to do:
> >
> > do {
> >     start= readtsc();
> >     clock_gett(CLOCK_MONOTONIC_RAW, &ts);
> >     end = readtsc();
> >     delta = end-start;
> > } while (delta  > THRESHOLD)   // make sure the reads were not preempted
> > mid = start + (delta +(delta/2))/2; //round-closest
> >
>
> How to choose the THRESHOLD? It seems the THRESHOLD value also impacts
> the accuracy.

Maybe by running a number of of these reads and collecting the detlas,
then setting THRESHOLD to a standard deviation of the results?
(I'm sure there's more sound methods, but I'd have to do some digging
to find them)

Alternatively you could always take 10 samples and then only do the
mapping with the smallest delta value.


> > and be able to get you a fairly close matching of TSC to
> > CLOCK_MONOTONIC_RAW value.
> >
> > Once you have that mapping you can take a few samples and establish
> > the linear function.
> >
> > But that will have some error, so quantifying that error helps
> > establish why being able to get an atomic mapping of TSC ->
> > CLOCK_MONOTONIC_RAW would help.
> >
> > So I really don't think we need to expose the kernel internal values
> > to userland, but I'm willing to guess the atomic mapping (which the
> > driver will have access to, not userland) may be helpful for the fine
> > granularity you want in the trace.
> >
>
> If I understand correctly, the idea is to let the user space tool run
> the above interpoloation algorithm several times to 'guess' the atomic
> mapping. Using the mapping information to covert the TSC from the PEBS
> record. Is my understanding correct?

So I think that's what Thomas was suggesting.

The next step would probably be to provide a way for the driver to
provide atomic TSC->CLOCK_MONOTONIC_RAW samples, so userland can
calculate the function itself.

So then the problem becomes if X1 and Y1 are exactly mapped, and X2
and Y2 are exactly mapped, then given X3, find Y3.

And if that doesn't work, then we would have to see about having the
driver do all the conversions.

> If so, to be honest, I doubt we can get the accuracy we want.

Sure. I just want to make sure its quantified that the pure userland
interpolation approach won't work before we go adding in extra
in-kernel logic

(We'd obviously rather do the logic that can be done in userland in userland)

thanks
-john
