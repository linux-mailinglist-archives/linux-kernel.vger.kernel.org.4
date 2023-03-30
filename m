Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E706D0C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjC3RFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjC3RFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:05:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF05B8E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:05:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so20339864pjl.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680195929; x=1682787929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TRRqCDccBeP+lNtKH4FhSF476DcCW+G7YKWNq84Bm0A=;
        b=OCT9VwWgetU49MJ0cu8RdfcG3mTjYJX7N1jf35M19l8amDxCPPKxheCvk5esO9e9kI
         bB3lv0cYObJA2dqtQlTNSC73L1ZTo/D7w2BaQV/Ep4sbXJR8DaZp1jIgrCcWPJZy6NGe
         xcWZqxvPMUwrSK1/I7oYzPX/Lci0P5K/f3lXMoKfrX6uFq//onVbU3+eJ8PrE+ckq7Ye
         dq4rFgVv4G6NA4ZL+Lf27wYzxNwY7n64ASIqBFwQwpr6LCB7433g9XGCqUyzsUGO5wlt
         wtkKlK5vOOwUQNW143xaXRnmypMeXDZYTUz5bmW1HLLDJnyAtvM70FcBQA/8+KMiqf2W
         gMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680195929; x=1682787929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRRqCDccBeP+lNtKH4FhSF476DcCW+G7YKWNq84Bm0A=;
        b=DWFPXkVLR8cDBe0dIwaVT9eALuBDyG4reBfu8JrGyHVNrw/FeaVVe6P0xC5/CPovvn
         3EELA6FNaZm3uPtbb0gPhI7fo3yw2tRNmwXIgZ+LdjurlylrPX4H7t7DUyJkrLbJLL4S
         gbTofcOEKJyQTTslcRI30znVaC9nD1mwhg/2aNVNen3f+b3Wz7qD8GNOpNZzN/BkxWhW
         cb3W4Gn6B5Booz+UCQiANLae24+sUMU0vM5lsj8gEZe2/VH4X+e7AyuccVplRCq5laLr
         LCH/plLSGnI9F24WjMlOi4i/iUuZhhc4FwZHwQ+zdqt9pli9dxCvyJPYCL67/TsMc/1l
         eefA==
X-Gm-Message-State: AAQBX9dg+sw0hrlghEvtAmkvDamaVJaIm68Hb2twXD5CCYECknzN0NNm
        cxFaaWehcPrHNKTQKupZKD+ZlSrF1nWnU7MwpNZebg==
X-Google-Smtp-Source: AKy350aw6K9bcCHF/y0crq+hI9GpoTNz/xkJFwvkZskEWS05pmV3lrLRIUMHp5e98nFZRTsBjHDqwyXKe5sPDZppHC8=
X-Received: by 2002:a17:903:1250:b0:1a2:4524:975f with SMTP id
 u16-20020a170903125000b001a24524975fmr5863401plh.0.1680195929226; Thu, 30 Mar
 2023 10:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230328092622.062917921@infradead.org> <20230328110354.141543852@infradead.org>
 <CAKfTPtDDBVD_N6NgBYi_5iArDXd4iL0-ddQZDKGzzLAD-2AUXg@mail.gmail.com> <20230330080145.GA117836@hirez.programming.kicks-ass.net>
In-Reply-To: <20230330080145.GA117836@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Mar 2023 19:05:17 +0200
Message-ID: <CAKfTPtD+EiB4mnRD0z4wYg6PDn1vLKxu4fxrgfiqsm2G3+RrEQ@mail.gmail.com>
Subject: Re: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 at 10:04, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 29, 2023 at 04:35:25PM +0200, Vincent Guittot wrote:
>
> > IIUC how it works, Vd = ve + r / wi
> >
> > So for a same weight, the vd will be earlier but it's no more alway
> > true for different weight
>
> Correct; but for a heavier task the time also goes slower and since it
> needs more time, you want it to go first. But yes, this is weird at
> first glance.

Yeah, I understand that this is needed for bounding the lag to a
quantum max but that makes the latency prioritization less obvious and
not always aligned with what we want

let say that you have 2 tasks A and B waking up simultaneously with
the same vruntime; A has a negative latency nice to reflect some
latency constraint and B the default value.  A will run 1st if they
both have the same prio which is aligned with their  latency nice
values but B could run 1st if it increase its nice prio to reflect the
need for a larger cpu bandwidth so you can defeat the purpose of the
latency nice although there is no unfairness

A cares of its latency and set a negative latency nice to reduce its
request slice

A: w=2, r=4q    B: w=2, r=6q

     A  |-------<
     B  |-----------<

     ---+---+---+---+---+---+---+-----------
     V  ^

A runs 1st because its Vd is earlier

     A    |-----<
     B  |-----------<

     ---+---+---+---+---+---+---+-----------
     V   ^

     A    |-----<
     B    |---------<

     ---+---+---+---+---+---+---+-----------
     V    ^

     A      |---<
     B    |---------<

     ---+---+---+---+---+---+---+-----------
     V     ^


     A      |---<
     B      |-------<

     ---+---+---+---+---+---+---+-----------
     V      ^

If B increases its nice because it wants more bandwidth but still
doesn't care of latency

A: w=2, r=4q    B: w=4, r=6q

     A  |-----------<
     B  |---------<

     ---+-----+-----+-----+-----+-----+---+-----------
     V  ^

B runs 1st whereas A's latency nice is lower

     A  |-----------<
     B    |------<

     ---+-----+-----+-----+-----+-----+---+-----------
     V   ^

     A     |--------<
     B    |------<

     ---+-----+-----+-----+-----+-----+---+-----------
     V    ^

     A     |--------<
     B      |----<

     ---+-----+-----+-----+-----+-----+---+-----------
     V     ^

     A        |-----<
     B      |----<

     ---+-----+-----+-----+-----+-----+---+-----------
     V      ^

     A        |-----<
     B        |--<

     ---+-----+-----+-----+-----+-----+---+-----------
     V       ^

     A        |-----<
     B        |--<

     ---+-----+-----+-----+-----+-----+---+-----------
     V        ^

>
> Let us consider a 3 task scenario, where one task (A) is double weight
> wrt to the other two (B,C), and let them run one quanta (q) at a time.
>
> Each step will see V advance q/4.
>
> A: w=2, r=4q    B: w=1, r=4q    C: w=1, r=4q
>
>   1) A runs -- earliest deadline
>
>     A  |-------<
>     B  |---------------<
>     C  |---------------<
>     ---+---+---+---+---+---+---+-----------
>     V  ^
>
>   2) B runs (tie break with C) -- A is ineligible due to v_a > V
>
>     A    |-----<
>     B  |---------------<
>     C  |---------------<
>     ---+---+---+---+---+---+---+-----------
>     V   ^
>
>   3) A runs -- earliest deadline
>
>     A    |-----<
>     B      |-----------<
>     C  |---------------<
>     ---+---+---+---+---+---+---+-----------
>     V    ^
>
>   4) C runs -- only eligible task
>
>     A      |---<
>     B      |-----------<
>     C  |---------------<
>     ---+---+---+---+---+---+---+-----------
>     V     ^
>
>   5) similar to 1)
>
>     A      |---<
>     B      |-----------<
>     C      |-----------<
>     ---+---+---+---+---+---+---+-----------
>     V      ^
>
> And we see that we get a very nice ABAC interleave, with the only other
> possible schedule being ACAB.
>
> By virtue of the heaver task getting a shorter virtual deadline it gets
> nicely interleaved with the other tasks and you get a very consistent
> schedule with very little choice.
>
> Like already said, step 2) is the only place we had a choice, and if we
> were to have given either B or C a shorter request (IOW latency-nice)
> that choice would have been fully determined.
>
> So increasing w gets you more time (and the shorter deadline causes the
> above interleaving), while for the same w, reducing r gets you picked
> earlier.
>
> Perhaps another way to look at it is that since heavier tasks run more
> (often) you've got to compete against it more often for latency.
>
>
> Does that help?
