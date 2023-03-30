Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5056D0DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjC3S1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3S13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:27:29 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61014D517
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:27:28 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id k17so24635913ybm.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680200847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxG6njY8k+/+ispzPN3qWXN6acIiXrbNNQ8EGi7iQDU=;
        b=XWF/zHUj8pdGxzdB1qLZPEr23aEUeaKHC2AlF4G8hHYQVVIvA/jArgj95uqND44eaf
         eC/I6VaPieu+WZITMKC0VzqUs1gRXTJ8Qtt0FaahnjOsQWwyFdBtqep3dUKa+KRebcMI
         tBTjYBHief6cd81Pi41yMb5R7lzdG8gvojvvEK58sn71GP6WRr1Pl2xHN78KXmCYU1uP
         20OWeW84bvcz4r44XptVOc391A5VS84oh/m1WRcymI0LXQkFgMQcatsDMZnM1B6TgfBp
         sos6TO2gjCT0F3HAjMnLo45Rp0TBSbJBrb70etb9vTerOkuzAWCa+VUMuCBPP+FinLc/
         rdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxG6njY8k+/+ispzPN3qWXN6acIiXrbNNQ8EGi7iQDU=;
        b=QpFilFUsreKA2NidyNDgS7Q3nI4pMP+HXDm2hF9jCMUJTFT51FCfF3ZH/0XgBsSXiO
         v6iOS7dqg+FrevhkEVfjBUNbR4aEYozMCg5Rj4TemZDZFMZaWObzVq6LzulPQ1PrsReG
         dBp/YZL0W0EgjDR3Hf1IMCWdmiDDIUX/p34Gd2VMW5QFnsUmmdnfZ6ZzXMeaNtS4fIfD
         k4N00WM18JDdurY9Kwyghk3EE333fEHlfypWIhTOGPiviDQoVDUXtv7rzYk90vCLPNdw
         NhnWrfTPAj7qEvNYOqdTSiaHU3hSqSmSXDDeP5744RR6/7AfsgNXZV/19Cp8OJkrQCMg
         j5yw==
X-Gm-Message-State: AAQBX9emLsTeTunuXWpSfzUHzJhTJTQbxjyya6gQURteSNKiEHw0k9tG
        PlrpN6q06BKa1KML7lUpNIJv8soMvMWgngiHSVtoxhU9Q1U4+LQRjnS9CQ==
X-Google-Smtp-Source: AKy350YbI075/riIfk/IkFqyrMVzeQ6LJ2XwcX8EOuRt87cEtAsNiOu8msTuhUewQ1ttKggZ9z0oYXjahhAxLhRuU5w=
X-Received: by 2002:a25:df48:0:b0:b77:158d:b3a0 with SMTP id
 w69-20020a25df48000000b00b77158db3a0mr4583170ybg.6.1680200847393; Thu, 30 Mar
 2023 11:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230328125818.5574-1-jaewon31.kim@samsung.com>
 <CABdmKX1J6WzE9CMbRthROgHZLLhXZJBw4iOz-7q+RK5fGpggLA@mail.gmail.com>
 <20230329031302epcms1p6afc9d9d8e92db6a39c29044606d21afc@epcms1p6>
 <CGME20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2@epcms1p7>
 <CABdmKX3c+qK6ekhujkH9fo8bNagmd-M=a=ZWF3HOq1C0EzHs8g@mail.gmail.com> <20230330004117epcms1p7cab95489135a39bf511f6b2cf958e41e@epcms1p7>
In-Reply-To: <20230330004117epcms1p7cab95489135a39bf511f6b2cf958e41e@epcms1p7>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 30 Mar 2023 11:27:16 -0700
Message-ID: <CABdmKX1urNvWihM=9WVAwxMsR_Tp_HU1RkX66WJ+iry_LB8yHg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/heaps: c9e8440eca61 staging: ion: Fix overflow
 and list bugs in system heap:
To:     jaewon31.kim@samsung.com
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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

On Wed, Mar 29, 2023 at 5:41=E2=80=AFPM Jaewon Kim <jaewon31.kim@samsung.co=
m> wrote:
>
> >On Tue, Mar 28, 2023 at 8:13?PM Jaewon Kim <jaewon31.kim@samsung.com> wr=
ote:
> >>
> >> >On Tue, Mar 28, 2023 at 5:58?AM Jaewon Kim <jaewon31.kim@samsung.com>=
 wrote:
> >> >>
> >> >> Normal free:212600kB min:7664kB low:57100kB high:106536kB
> >> >>   reserved_highatomic:4096KB active_anon:276kB inactive_anon:180kB
> >> >>   active_file:1200kB inactive_file:0kB unevictable:2932kB
> >> >>   writepending:0kB present:4109312kB managed:3689488kB mlocked:2932=
kB
> >> >>   pagetables:13600kB bounce:0kB free_pcp:0kB local_pcp:0kB
> >> >>   free_cma:200844kB
> >> >> Out of memory and no killable processes...
> >> >> Kernel panic - not syncing: System is deadlocked on memory
> >> >>
> >> >> An OoM panic was reported, there were only native processes which a=
re
> >> >> non-killable as OOM_SCORE_ADJ_MIN.
> >> >>
> >> >> After looking into the dump, I've found the dma-buf system heap was
> >> >> trying to allocate a huge size. It seems to be a signed negative va=
lue.
> >> >>
> >> >> dma_heap_ioctl_allocate(inline)
> >> >>     |  heap_allocation =3D 0xFFFFFFC02247BD38 -> (
> >> >>     |    len =3D 0xFFFFFFFFE7225100,
> >> >>
> >> >> Actually the old ion system heap had policy which does not allow th=
at
> >> >> huge size with commit c9e8440eca61 ("staging: ion: Fix overflow and=
 list
> >> >> bugs in system heap"). We need this change again. Single allocation
> >> >> should not be bigger than half of all memory.
> >> >>
> >> >> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> >> >> ---
> >> >>  drivers/dma-buf/heaps/system_heap.c | 3 +++
> >> >>  1 file changed, 3 insertions(+)
> >> >>
> >> >> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/=
heaps/system_heap.c
> >> >> index e8bd10e60998..4c1ef2ecfb0f 100644
> >> >> --- a/drivers/dma-buf/heaps/system_heap.c
> >> >> +++ b/drivers/dma-buf/heaps/system_heap.c
> >> >> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(str=
uct dma_heap *heap,
> >> >>         struct page *page, *tmp_page;
> >> >>         int i, ret =3D -ENOMEM;
> >> >>
> >> >> +       if (len / PAGE_SIZE > totalram_pages() / 2)
> >> >> +               return ERR_PTR(-ENOMEM);
> >> >> +
> >> >
> >> >Instead of policy like that, would __GFP_RETRY_MAYFAIL on the system
> >> >heap's LOW_ORDER_GFP flags also avoid the panic, and eventually fail
> >> >the allocation request?
> >>
> >> Hello T.J.
> >>
> >> Thank you for your opinion.
> >> The __GFP_RETRY_MAYFAIL on LOW_ORDER_GFP seems to work.
> >>
> >> page allocation failure: order:0, mode:0x144dc2(GFP_HIGHUSER|__GFP_RET=
RY_MAYFAIL|__GFP_COMP|__GFP_ZERO)
> >> Node 0 active_anon:120kB inactive_anon:43012kB active_file:36kB inacti=
ve_file:788kB
> >>
> >> I tried to test it, and the allocation stopped at very low file cache =
situation without OoM panic
> >> as we expected. The phone device was freezing for few seconds though.
> >>
> >> We can avoid OoM panic through either totalram_pages() / 2 check or __=
GFP_RETRY_MAYFAIL.
> >>
> >> But I think we still need the totalram_pages() / 2 check so that we do=
n't have to suffer
> >> the freezing in UX perspective. We may kill some critical processes or=
 users' recent apps.
> >>
> >> Regarding __GFP_RETRY_MAYFAIL, I think it will help us avoid OoM panic=
. But I'm worried
> >> about low memory devices which still need OoM kill to get memory like =
in camera scenarios.
> >>
> >> So what do you think?
> >>
> >Hey Jaewon, thanks for checking! The totalram_pages() / 2 just feels
> >somewhat arbitrary. On the lowest memory devices I'm aware of that use
> >the system heap it would take a single buffer on the order of several
> >hundred megabytes to exceed that, so I guess the simple check is fine
> >here until someone says they just can't live without a buffer that
> >big!
> >
> >Reviewed-by: T.J. Mercier <tjmercier@google.com>
>
> Hello T.J.
>
> Thank you for your Reviewed-by.
>
> I also think the totalram_pages() / 2 doesn't look perfect, but I think
> we need it.
>
> By the way I'm a little confused on a single buffer. Please help me to be=
 clear.
> Do you mean we may need to reconsider the totalram_pages() / 2 some day,
> if camera may request a huge memory for a single camera buffer? Then I ho=
pe
> the device has also huge total memory to support that high quality camera=
.
>
Right, it's only a problem if a very low memory device wants a very
large buffer. IDK why anyone would want to do that.

> And if possible, could you give your idea about __GFP_RETRY_MAYFAIL regar=
ding
> what I said? I think OoM kill doesn't seem to occur that often thanks to =
LMKD kill.
> And I also want to avoid OoM panic, so I'd like to apply it.

Yeah even with the totalram_pages() / 2 check, a process could trigger
the panic by consuming all available memory by allocating multiple
buffers. (As long as that allocating process doesn't get oom killed
first, and it allocates faster than LMKD can kill it.) So to prevent
users of the system heap from crashing the system, I think it's still
worth adding __GFP_RETRY_MAYFAIL.

> But what if there is a situation which still need OoM kill to get memory.=
 I just
> thought policy of __GFP_RETRY_MAYFAIL could be changed to allow OoM kill =
but return
> NULL when there was a victim process.

I'm not sure exactly what you mean here, but it might be nice to have
a way to allow oom kills but not panics if a victim can't be found
(and then fail the allocation request). Looks like that'd be possible
by changing alloc_pages to conditionally set oom_control->order =3D -1
for some new GFP flag, but not sure if that's worth it. As you
mentioned, that'd be a super slow allocation. So I don't think that's
a state we'd really want to be operating in.

> Thank you
> Jaewon Kim
