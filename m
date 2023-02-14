Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A423696DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjBNTe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBNTe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:34:27 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BEE2A9A5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:34:26 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x71so18531572ybg.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MTXjHWYlOR0F/ROs8/K289rBoDRMz+1H4Pa/mpDBROM=;
        b=FCy6ojkDsTzVK9bqtf33Cb8kK4s66o9DyhCWT32KXEc4/1Ad4Lxm13Df0sqFkmBPYm
         LbHInCQVkVuqMAEFXuKKP3+xRhfM9hJxJNJGZkbXgEL/Ehts1RiffzSO/ad6a/H0S4vy
         6DeajCThlgwjHiJIpQXDrUZ+MZtPFX6BGmdkVNhF4A33JTbGgpeLoWIbuEtBMpqSYl+D
         2ZiPAnqs89Rn2Wsup0HYhDl66XBKIy1arLVL3y3wGshSxfKyfptoq71zwmQCdTRFmGRT
         5Och0wVD54LDPl75Yjeksb2ecB8LTlgxRZvd5nWZDJ5cSk2BPgUGBo2x6dHF99m9NYNB
         YBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTXjHWYlOR0F/ROs8/K289rBoDRMz+1H4Pa/mpDBROM=;
        b=6SW7VY5enDosvzcud/8tbzyaMWCrvtjaSwiUe0CMuEOAVPjjEGoh+KJmKpKU48YBDz
         t0y6QR5qUsDVCw5yv6RFMZc/WX8S0MM2oyXsBn4av9vwwalHhG6Z8vK2iHHu42V7rcts
         pj/VFr932VtG4LApQo/LKaz7V9o2y5rGOAZRLS5faK2mKx82bPaAKFX7vrzrRnPq0qGF
         prSRvrFFA+8yPg0Xuz6rhgW0lemxS3RTyK598loM9p209xKNOaYUvvK7/8s4yEphyweP
         evvYaHqmklnXIulciaSEBIB3Lrb1/fXJhImxBxj8QxfzWuFGbTaRhn8lDx0fEKQ8oxHu
         75TQ==
X-Gm-Message-State: AO0yUKU6NipYI4tik33SNHaoXtw+o31w3pEX4R34447LfsZ21w+0YngU
        00SlR3lr6UyLHxxu1ZCWMB9H4YckzxIt9UE0xhOFcmmTv4rZgh8=
X-Google-Smtp-Source: AK7set+BQuZnbPQv0mdZU1MMDyJo3GdDMZcuEU+6Vg8XOHAELGa0kjYppHtG95QEiR1rQzvd8jBGWAq7OATWQx2ieFU=
X-Received: by 2002:a5b:c4e:0:b0:8f4:2d3:1a3a with SMTP id d14-20020a5b0c4e000000b008f402d31a3amr370976ybr.255.1676403265443;
 Tue, 14 Feb 2023 11:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com> <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com> <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <Y+tl1ZJiWuMeKCnB@hirez.programming.kicks-ass.net>
In-Reply-To: <Y+tl1ZJiWuMeKCnB@hirez.programming.kicks-ass.net>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 14 Feb 2023 11:34:15 -0800
Message-ID: <CANDhNCop3qQ0PRm7ucR-q5smsXOZwUEsqRdJ=xc8suemWpDyDw@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com
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

On Tue, Feb 14, 2023 at 7:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 13, 2023 at 02:22:39PM -0800, John Stultz wrote:
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
> > and be able to get you a fairly close matching of TSC to
> > CLOCK_MONOTONIC_RAW value.
> >
> > Once you have that mapping you can take a few samples and establish
> > the linear function.
>
> Right, this is how we do the TSC calibration in the first place, and if
> NTP can achieve high correctness over a network, then surely we can do
> better locally.
>
> That is, this scheme should work for all CLOCKs, not only MONOTONIC_RAW.

Well, CLOCK_MONOTONIC_RAW is at least a fixed function, we don't
change its frequency. Whereas other clocks will likely be adjusted
over their lifetime, so deriving the frequency has to be continually
re-calculated, so they aren't ideal for this sort of interpolation.

thanks
-john
