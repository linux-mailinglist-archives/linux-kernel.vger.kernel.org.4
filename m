Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BF696E01
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjBNThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBNThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:37:21 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5886A2A9A5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:37:20 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x71so18540233ybg.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mfKrq3y7xxNOKsmtdyTYkEWHGboWGCnIkV77mEuLrI=;
        b=k3djtyLhlew15VoejGHYpDB9y1lg8LPO+99iFVOU6yL0TGBuLPL8k6tMvqFImIlbNc
         LDNff2ECiRt+yGYVPEFu5XNBUbaFxnf9MdPB1UyXYKKBkd+BXw/LncxiYIGfiG2SbwwB
         MXuJoVYRsBUpIEqIb+w3b4/h9P8pmzLBfvf8J/S/0L65lXvhSpqoFk+3lcD6TCXjJaDy
         IuzGTir46VjotETJ7oXx4qVVoXRU3bpX9oRej0SuBPm5LOVAezO+k6dVP1MZNCaBt0Z7
         lx3vJhti7TUJhiR4cYjmWNCNS6eA38rppyCexDw81FRsOF1I06K5kBNXCvURVnpCYBoa
         c08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mfKrq3y7xxNOKsmtdyTYkEWHGboWGCnIkV77mEuLrI=;
        b=ZMLAXLSAoj8rVuJ82NHwLT8ygsdZf0196Tk3r0Jqib0C/3EYbhxxbjzhHhqnJHvOry
         iBgOOp60EK8rFnThJd3lP0kkdte6o0W6QExGDLVuo5mmAy7VZ+gRPjPYD5dZpxTBJPIb
         iCbISdtIE0RYhtiIgkSrX2COBZ4g4ZShzD/9bhgibVCrNlVUPxZLGqv2/KcqKF23VuVU
         D5U6xyZHtKh/kPDZgEnzbMGfOW8ZoeLCTzMWV79cbOuhMqvEPRdmWAj3OIYeoU0CSYqm
         nn6MbddbkEVqKeuG+cXGGSG3u54/r9pGL07AyB5z22YFGTjbV/dd7Q8WM1SH24GG0+Xo
         XwYA==
X-Gm-Message-State: AO0yUKW6envuMNLKcxBjtmAwCmqTaKt4FIho4IwFZtDT8VuwUe87MEgy
        BCqRUwvX4m3+MCx7K10/0UM6Mvgf+zskbzWHc+EP
X-Google-Smtp-Source: AK7set+l3dBnCtETwSahwINYMCvrWT+7xSWgTEb4stCjBLAZqOk1q3qODUB1Dr17LkdtndcnR/K0AbihMrHpgVLfrnQ=
X-Received: by 2002:a25:eb0c:0:b0:80b:5398:3aeb with SMTP id
 d12-20020a25eb0c000000b0080b53983aebmr382105ybs.300.1676403439425; Tue, 14
 Feb 2023 11:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com> <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com> <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <Y+tl1ZJiWuMeKCnB@hirez.programming.kicks-ass.net> <8dc13cf0-42f4-9ef1-1e22-de58ff743a0d@linux.intel.com>
In-Reply-To: <8dc13cf0-42f4-9ef1-1e22-de58ff743a0d@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 14 Feb 2023 11:37:08 -0800
Message-ID: <CANDhNCrLTBB6UaSxUhivGKv+ugnMYtCqDSDiz7o-DnE2MkC8jA@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Tue, Feb 14, 2023 at 9:46 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 2023-02-14 5:43 a.m., Peter Zijlstra wrote:
> > On Mon, Feb 13, 2023 at 02:22:39PM -0800, John Stultz wrote:
> >> The interpoloation is pretty easy to do:
> >>
> >> do {
> >>     start= readtsc();
> >>     clock_gett(CLOCK_MONOTONIC_RAW, &ts);
> >>     end = readtsc();
> >>     delta = end-start;
> >> } while (delta  > THRESHOLD)   // make sure the reads were not preempted
> >> mid = start + (delta +(delta/2))/2; //round-closest
> >>
> >> and be able to get you a fairly close matching of TSC to
> >> CLOCK_MONOTONIC_RAW value.
> >>
> >> Once you have that mapping you can take a few samples and establish
> >> the linear function.
> >
> > Right, this is how we do the TSC calibration in the first place, and if
> > NTP can achieve high correctness over a network, then surely we can do
> > better locally.
> >
> > That is, this scheme should work for all CLOCKs, not only MONOTONIC_RAW.
>
> If I understand correctly, the TSC calibration is done in the kernel.
> The kernel keeps updating the mul/shift. We dump the mul/shift into the
> perf mmap page for the user tools.

Where is that done in the perf mmap? I wasn't aware.

thanks
-john
