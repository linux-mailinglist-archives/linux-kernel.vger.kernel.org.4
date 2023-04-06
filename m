Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899E16DA61E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjDFX1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjDFX1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:27:41 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A759EE4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:27:40 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q5so316650ybk.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680823659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TDmHE+6Z/IxOxGPOrmPdh/+ahrGLDRiBjXuUSgqT7s=;
        b=Et1SgasCmflDYlpPApKkbbGVFvsipra17Uu+GGK8mwwGzKrBhJUqOtt6zoFvNNtnrD
         HCnxfqLYwANaJifhCfrKLsE/RK5YrWpR/QjvVXP8N9WVNeoif9xBHnvYc7pc8jIckrUl
         gWXLJH8tYr+EUgloRfIJdwaJyvZl29idB5QIGB6goRd0Mt3j4Gurr1rMRkVCRa/2VIzy
         MQE6i3DKQuq1Yn6ZnftsZML08s+JoYUBuJRuPHWrr/gbnSI5yJruqx9N1to+LZO/vs6o
         jln/xz3/nnJBRzapGM5o4tVzD41eS5fvLRGTALzcgRzwYf5Ba+lPdcZK8HAoZShLQA/n
         WJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680823659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TDmHE+6Z/IxOxGPOrmPdh/+ahrGLDRiBjXuUSgqT7s=;
        b=nIsRNPLk117PQQ4udAitGNtp3hsQlNawo44HxmY/QxNe8ME8GQ+r+85jNcz5vgc2WX
         NvOeoyArZTpT7Uu+jgBaSFTd3pITSEYWGAyd2V2jxW7HX+CSlPR6FWmtJiGOm4A287eB
         P+U7FMG4uWHwaTyvS6dedSuAFSQXec+GntNXTs7GiKdLLnAA+lsrqofGpsS81w00m3GB
         +C3vjWw7nnHteDD0z9EBE+rj/2fg05hm6H9y8/JHVFyJfRKfUeonHw9RsgLAxjbEjP1B
         QhSlWNz+2Ngv2o4yOu3u8YGxpzI/sEUhCftzLV/GfovVzom8GX03+FKeIb643kBLWhB9
         fhUA==
X-Gm-Message-State: AAQBX9fpEkWG98Xj66T5PZ5oFQDl98v8kla6IQoeZRb2AnTcd/3b+/lP
        xR+C57me1BygKm8Yhiq8Y4HeDo61tQry2TZV6exZBA==
X-Google-Smtp-Source: AKy350bseRgo/6enzMBu28AACsjF+fsREfCPn4L0Y43rnpJBnC3NdkEGtmH9IqryvaFSDw2ENLZzTwYNTkLRxTQsr7E=
X-Received: by 2002:a25:dad3:0:b0:b77:e465:cb16 with SMTP id
 n202-20020a25dad3000000b00b77e465cb16mr681943ybf.11.1680823659067; Thu, 06
 Apr 2023 16:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
 <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
 <20230406000854.25764-1-jaewon31.kim@samsung.com> <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
 <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p2>
 <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2>
 <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org> <CANDhNCq+mhhXjW7huYoQwUq18sRCcn6HjbPqh7mU9KrGyKeLfA@mail.gmail.com>
In-Reply-To: <CANDhNCq+mhhXjW7huYoQwUq18sRCcn6HjbPqh7mU9KrGyKeLfA@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 6 Apr 2023 16:27:28 -0700
Message-ID: <CABdmKX0ZnQX5BPEJjqxwUsx=c8ykcX8Bjitak50DAYvfti6VFw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
To:     John Stultz <jstultz@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        jaewon31.kim@samsung.com,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 9:24=E2=80=AFPM John Stultz <jstultz@google.com> wro=
te:
>
> On Wed, Apr 5, 2023 at 8:09=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> > On Thu, 06 Apr 2023 11:17:12 +0900 Jaewon Kim <jaewon31.kim@samsung.com=
> wrote:
> >
> > > >> +       if (len / PAGE_SIZE > totalram_pages())
> > > >> +               return ERR_PTR(-ENOMEM);
> > > >
> > > >We're catering for a buggy caller here, aren't we?  Are such large
> > > >requests ever reasonable?
> > > >
> > > >How about we decide what's the largest reasonable size and do a
> > > >WARN_ON(larger-than-that), so the buggy caller gets fixed?
> > >
> > > Yes we're considering a buggy caller. I thought even totalram_pages()=
 / 2 in
> > > the old ion system is also unreasonable. To avoid the /2, I changed i=
t to
> > > totalram_pages() though.
> > >
> > > Because userspace can request that size repeately, I think WARN_ON() =
may be
> > > called to too often, so that it would fill the kernel log buffer.
> >
> > Oh geeze.  I trust that userspace needs elevated privileges of some for=
m?
> >
> > If so, then spamming dmesg isn't an issue - root can do much worse than
> > that.
> >
> > > Even we think WARN_ON_ONCE rather than WARN_ON, the buggy point is no=
t kernel
> > > layer. Unlike page fault mechanism, this dma-buf system heap gets the=
 size from
> > > userspace, and it is allowing unlimited size. I think we can't fix th=
e buggy
> > > user space with the kernel warning log. So I think warning is not eno=
ugh,
> > > and we need a safeguard in kernel layer.
> >
> > I really dislike that ram/2 thing - it's so arbitrary, hence is surely
> > wrong for all cases.  Is there something more thoughtful we can do?
>
> Just for context, here's the old commit that added this to ION:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dc9e8440eca61298ecccbb27f53036124a7a3c6c8
>
> I think the consideration was that allocations larger than half of
> memory are likely due to erroneously "negative" size values.
>
> My memory is foggy on any discussions from that time, but I imagine
> the thinking was treating the value as if it were signed and error out
> immediately on negative values, but rather than just capping at 2gb on
> 32bit systems, one could scale it to half of the system memory size,
> as that seemed an appropriate border of "obviously wrong".
>
> And the reason why I think folks wanted to avoid just warning and
> continuing with the allocation, is that these large allocations would
> bog the system down badly before it failed, so failing quickly was a
> benefit as the system was still responsive and able to be used to
> collect logs and debug the issue.
>
> When you say "decide what's the largest reasonable size", I think it
> is difficult as with the variety of RAM sizes and buffer sizes I don't
> think there's a fixed limit. Systems with more ram will use larger
> buffers for image/video capture buffers.  And yes, you're right that
> ram/2-1 in a single allocation is just as broken, but I'm not sure how
> to establish a better guard rail.
>
> thanks
> -john

I like ENOMEM with the len / PAGE_SIZE > totalram_pages() check and
WARN_ON. We know for sure that's an invalid request, and it's pretty
cheap to check as opposed to trying a bunch of reclaim before failing.
For buffers smaller than that I agree with John in that I'm not sure
there's a definitive threshold.
