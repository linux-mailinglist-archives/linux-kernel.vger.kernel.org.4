Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455725FE7A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJNDm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJNDmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:42:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A754A18D83D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:42:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f37so5342509lfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JmPMkVM44twsLVEmNZjFiaFjx4RV7WYTWD8miefDPDQ=;
        b=XdVbeJmrs230F/8iCuMdwdr/MYxBtYCbmPtjX+6nLbqZ1J7bkfHB8E1tJun8FlOHna
         SmcZqGjVWaMvcMIAMBMlOhjEKq/csOtInPujFCFmjWnHdt36r5jACnBs+VjzXQ+hhg4F
         OTcJ0czJpbQvjxTL7BSeEaS5dfRMYX01EQi6wqvyQ7FU4zONcunYZuKx4f09zuyQEleV
         zXk6gF0IdrxNrpgfjfUtNCwOQbf70wzcdAwUBL2wYe7Gs8jFSF2RP1iKH+lvIS7WplRA
         mriZHieMCvJJPSWWrgSy04lqLiesEjKavijbj6Se5ooUSIAM5/+GlOk5saj6V3twMnVg
         uA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmPMkVM44twsLVEmNZjFiaFjx4RV7WYTWD8miefDPDQ=;
        b=Be8uruKBOHOj0uXmIattqyEAcMloCcUC2H8WAAUK7qaHOTMSu1T2/HuJBMI1VHsVjz
         z2+xm4Qq1BBr9Gaefn5JRQUmgesUQCiF52Cvhk0cuto2LLW51J3A2DauS1NUjflPIVSJ
         kpDf0Alsimy6jtW4oC4DgDpKNfuXfqK/Rdfp/jZIMjRZOFNyAF2I4VrSpQ99vMG69oY4
         EluEpfYs2ZW3Utoqcn2wOO7b60l6RvgC9Z08weSeaQ2DNvePn3+no5UDnbqV159sQ4Je
         dflimPzKo4Qqk4IB81zqmSF4SwHJxeLYAwF4z3XlEZVkEAj0pVROE9BtURodL952qMcB
         Gpbg==
X-Gm-Message-State: ACrzQf32CPbxEjlbIKcvxpUHUKbYwGAxAA7JtM7coyk6c8GhbuAj2cuD
        ZV0Wi0ZCiPWjfAEy5Br/SyHz4JGN4EFDZbow2hoAz5vLejUU
X-Google-Smtp-Source: AMsMyM4KFA5s9CQCJPslF766X4af/KSDF9/TU0jDSjt+3vhx2qOwKvkAKr0dNZP0voc4sGme2yRrUbLMINQ91bSywtU=
X-Received: by 2002:ac2:5110:0:b0:4a2:3cf4:b693 with SMTP id
 q16-20020ac25110000000b004a23cf4b693mr906164lfb.283.1665718939915; Thu, 13
 Oct 2022 20:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCq-ewTnuuRPoDtq+14TCFEwUpyo-pxn3J8=x1qCZzcgKQ@mail.gmail.com> <CAJD7tkayXxKEPpRE7QvBN4CikqeQcUe3_qfrUaH4V+cJrk0y=Q@mail.gmail.com>
In-Reply-To: <CAJD7tkayXxKEPpRE7QvBN4CikqeQcUe3_qfrUaH4V+cJrk0y=Q@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 13 Oct 2022 20:42:07 -0700
Message-ID: <CANDhNCp6MOfWnHZKkd_pQbkJqJqPmArVK0JQKKzH4=GbyBVeSQ@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
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

On Thu, Oct 13, 2022 at 8:26 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> On Thu, Oct 13, 2022 at 7:39 PM John Stultz <jstultz@google.com> wrote:
> > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > I have a question about ktime_get_mono_fast_ns(), which is used by the
> > > BPF helper bpf_ktime_get_ns() among other use cases. The comment above
> > > this function specifies that there are cases where the observed clock
> > > would not be monotonic.
> > >
> > > I had 2 beginner questions:
> >
> > Thinking about this a bit more, I have my own "beginner question": Why
> > does bpf_ktime_get_ns() need to use the ktime_get_mono_fast_ns()
> > accessor instead of ktime_get_ns()?
> >
> > I don't know enough about the contexts that bpf logic can run, so it's
> > not clear to me and it's not obviously commented either.
>
> I am not the best person to answer this question (the BPF list is
> CC'd, it's full of more knowledgeable people).
>
> My understanding is that because BPF programs can basically be run in
> any context (because they can attach to almost all functions /
> tracepoints in the kernel), the time accessor needs to be safe in all
> contexts.

Ah. Ok, the tracepoint connection is indeed likely the case. Thanks
for clarifying.

> Now that I know that ktime_get_mono_fast_ns() can drift significantly,
> I am wondering why we don't just read sched_clock(). Can the
> difference between sched_clock() on different cpus be even higher than
> the potential drift from ktime_get_mono_fast_ns()?

sched_clock is also lock free and so I think it's possible to have
inconsistencies.

ktime_get_raw_fast_ns() is possibly closer to what you are looking
for, as it is similarly un-adjusted by NTP.
However that also means the time intervals it measures (especially
long ones) may not be accurate.

Also I worry that if it's already established as a CLOCK_MONOTONIC
interface, switching it to MONOTONIC_RAW might break some applications
that mix collected timestamps with CLOCK_MONOTONIC.

thanks
-john
