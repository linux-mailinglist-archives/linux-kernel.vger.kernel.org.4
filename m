Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093FD718863
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEaRXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjEaRXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:23:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D61137;
        Wed, 31 May 2023 10:22:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b04706c974so30548285ad.2;
        Wed, 31 May 2023 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685553775; x=1688145775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrVwJAEjjvnvIKuJ6uTt26n9KFNYPZA2r93TFT7MbBM=;
        b=PTfLVn0ji4zAktKm8RzoDA3NBcmQMpDY6XyqpSzdauKVxASokup2dHBitvuhbykBsQ
         pJVnj3bkMmWUhDAkIO3bvFN86+KLCwuBubtZSY15vU6DzvnLoFIbfzol5ddUvV0XgLdl
         MjOYDB+CFmsd4HG8tIARZ7xAJpcjJaViKYaqEvK3tUhoDQYvj+pDJdf4FfUV91gqY34W
         O5I9ZfBeIs4YBPvg+MJ247CIAjRK48j/nJf06pH3KgGnuNPJ32QtyJq/hidzC3gELEWd
         5YNrXnhfWBq+u0GXxj8/fq40P7h1By472f9bnVZok1GCWkdEMoK4RfftxrJzBS1AwjuG
         sHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685553775; x=1688145775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrVwJAEjjvnvIKuJ6uTt26n9KFNYPZA2r93TFT7MbBM=;
        b=ZS2LFr3HP6Fhrxq/p7RBDQbAR5Ipxmp0QCVl9myc6noiFwz8t2N6N/FJNc9MqYMr2J
         szB73j5JasIvNaM17zY8ajzJf7Bzb3b/BZGwcw8gfq7lQxS848vDFCrvChT9CkSOlu+N
         NGBz++vvapZdBRqFHCi7UoBfjuA+nRaTk2hVpPJOAdd3TBa6tgoSjQpWa/9xgNF7ELPS
         Jf6Cpz0hLgjAod+iDZcHUMtxuis1+jHtqb5ZFexmkm41hGhSYBKoss9czhTqP7Hjp6oW
         SL/GEXdw7TBQNZh022Maz4RXBt1fufZ9WI4yQA6Ik2+tZcrpB4/r5wSMDNym2A0LPCkJ
         BNdQ==
X-Gm-Message-State: AC+VfDzCCeoqwh1TZjpgoZv0aJ8ul5w/DKPmAGLE0/SSSfFgDQIS47Vz
        owLQun9cXZUlrAiYYuz3PWLO+kZtpfo8PjzKtKc=
X-Google-Smtp-Source: ACHHUZ59Rc3El2kV4KaAoX205BGG2z29ZAqm5s0jPQoGNbX4kBK5ZhAdR9Xp24SNx29R1CuG5QwOv74WZ5CgDptbbuk=
X-Received: by 2002:a17:902:d490:b0:1aa:e425:2527 with SMTP id
 c16-20020a170902d49000b001aae4252527mr7161331plg.21.1685553775293; Wed, 31
 May 2023 10:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230525125746.553874-1-aleksander.lobakin@intel.com>
 <20230525125746.553874-4-aleksander.lobakin@intel.com> <8828262f1c238ab28be9ec87a7701acd791af926.camel@gmail.com>
 <cb7d3479-63a5-31b4-355d-b12a7e1b2878@intel.com>
In-Reply-To: <cb7d3479-63a5-31b4-355d-b12a7e1b2878@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 31 May 2023 10:22:18 -0700
Message-ID: <CAKgT0Ud204CiJeB-5zcTKdrv7ODrfP09t73CqRhps7g3qhWU5w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 03/12] iavf: optimize Rx
 buffer allocation a bunch
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org,
        Michal Kubiak <michal.kubiak@intel.com>,
        intel-wired-lan@lists.osuosl.org, Christoph Hellwig <hch@lst.de>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 8:14=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander H Duyck <alexander.duyck@gmail.com>
> Date: Tue, 30 May 2023 09:18:40 -0700
>
> > On Thu, 2023-05-25 at 14:57 +0200, Alexander Lobakin wrote:
> >> The Rx hotpath code of IAVF is not well-optimized TBH. Before doing an=
y
> >> further buffer model changes, shake it up a bit. Notably:
> >>
> >> 1. Cache more variables on the stack.
> >>    DMA device, Rx page size, NTC -- these are the most common things
> >>    used all throughout the hotpath, often in loops on each iteration.
> >>    Instead of fetching (or even calculating, as with the page size) th=
em
> >>    from the ring all the time, cache them on the stack at the beginnin=
g
> >>    of the NAPI polling callback. NTC will be written back at the end,
> >>    the rest are used read-only, so no sync needed.
> >
> > The advantage of this is going to vary based on the attribute. One of
> > the reasons why I left most of this on the ring is because the section
> > of the ring most of these variables were meant to be read-mostly and
> > shouldn't have resulted in any additional overhead versus accessing
> > them from the stack.
>
> But not all of these variables are read-only. E.g. NTC is often
> modified. Page size was calculated per descriptor, but could be once a
> poll cycle starts, and so on.

Yeah, the ntc should be carried in the stack. The only reason for
using the ring variable was because in the case of ixgbe we had to do
some tricks with it to deal with RSC as we were either accessing ntc
or the buffer pointed to by the descriptor. I think most of that code
has been removed for i40e though.

> >
> >> 2. Don't move the recycled buffers around the ring.
> >>    The idea of passing the page of the right-now-recycled-buffer to a
> >>    different buffer, in this case, the first one that needs to be
> >>    allocated, moreover, on each new frame, is fundamentally wrong. It
> >>    involves a few o' fetches, branches and then writes (and one Rx
> >>    buffer struct is at least 32 bytes) where they're completely unneed=
ed,
> >>    but gives no good -- the result is the same as if we'd recycle it
> >>    inplace, at the same position where it was used. So drop this and l=
et
> >>    the main refilling function take care of all the buffers, which wer=
e
> >>    processed and now need to be recycled/refilled.
> >
> > The next_to_alloc logic was put in place to deal with systems that are
> > experiencing memory issues. Specifically what can end up happening is
> > that the ring can stall due to failing memory allocations and the
> > memory can get stuck on the ring. For that reason we were essentially
> > defragmenting the buffers when we started suffering memory pressure so
> > that they could be reusued and/or freed following immediate use.
> >
> > Basically what you are trading off is some exception handling for
> > performance by removing it.
>
> I'm not sure this helps a lot, but OTOH this really slows down things,
> esp. given that this code is run all the time, not only when a memory
> allocation fail happens.

The thing is when things break they have to be fixed. For our purposes
since you are getting rid of the recycling anyway it is going to be
ripped out one way or the other. Just wanted to provide a bit of
history as to why it is being done that way.

> >
> >> 3. Don't allocate with %GPF_ATOMIC on ifup.
> >>    This involved introducing the @gfp parameter to a couple functions.
> >>    Doesn't change anything for Rx -> softirq.
> >
> > Any specific reason for this? Just wondering if this is meant to
> > address some sort of memory pressure issue since it basically just
> > means the allocation can go out and try to free other memory.
>
> Yes, I'm no MM expert, but I've seen plenty of times messages from the
> MM folks that ATOMIC shouldn't be used in non-atomic contexts. Atomic
> allocation is able to grab memory from some sort of critical reservs and
> all that, and the less we touch them, the better. Outside of atomic
> contexts they should not be touched.

For our purposes though the Rx path is more-or-less always in
interrupt context. That is why it had defaulted to just always using
GFP_ATOMIC. For your purposes you could probably leave it that way
since you are going to be pulling out most of this code anyway.

> >
> >> 4. 1 budget unit =3D=3D 1 descriptor, not skb.
> >>    There could be underflow when receiving a lot of fragmented frames.
> >>    If each of them would consist of 2 frags, it means that we'd proces=
s
> >>    64 descriptors at the point where we pass the 32th skb to the stack=
.
> >>    But the driver would count that only as a half, which could make NA=
PI
> >>    re-enable interrupts prematurely and create unnecessary CPU load.
> >
> > Not sure I agree with this. The problem is the overhead for an skb
> > going up the stack versus a fragment are pretty signficant. Keep in
> > mind that most of the overhead for a single buffer occurs w/
> > napi_gro_receive and is not actually at the driver itself. The whole
> > point of the budget is to meter out units of work, not to keep you in
> > the busy loop. This starts looking like the old code where the Intel
> > drivers were returning either budget or 0 instead of supporting the
> > middle ground.
>
> No, certainly not this :D
>
> The point of budget is to limit the amount of time drivers can spend on
> cleaning their rings. Making skb the unit makes the unit very logical
> and flexible, but I'd say it should always be solid. Imagine you get a
> frame which got spanned across 5 buffers. You spend x5 time (roughly) to
> build an skb and pass it up the stack vs when you get a linear frame in
> one buffer, but according to your logics both of these cases count as 1
> unit, while the amount of time spent differs significantly. I can't say
> that's fair enough.

I would say it is. Like I said most of the overhead is the stack, not
the driver. So if we are cleaning 5 descriptors but only processing
one skb then I would say it is only one unit in terms of budget. This
is one of the reasons why we don't charge Tx to the NAPI budget. Tx
clean up is extremely lightweight as it is only freeing memory, and in
cases of Tx and Rx being mixed can essentially be folded in as Tx
buffers could be reused for Rx.

If we are wanting to increase the work being done per poll it would
make more sense to stick to interrupts and force it to backlog more
packets per interrupt so that it is processing 64 skbs per call.

> >
> >> 5. Shortcut !size case.
> >>    It's super rare, but possible -- for example, if the last buffer of
> >>    the fragmented frame contained only FCS, which was then stripped by
> >>    the HW. Instead of checking for size several times when processing,
> >>    quickly reuse the buffer and jump to the skb fields part.
> >> 6. Refill the ring after finishing the polling loop.
> >>    Previously, the loop wasn't starting a new iteration after the 64th
> >>    desc, meaning that we were always leaving 16 buffers non-refilled
> >>    until the next NAPI poll. It's better to refill them while they're
> >>    still hot, so do that right after exiting the loop as well.
> >>    For a full cycle of 64 descs, there will be 4 refills of 16 descs
> >>    from now on.
> >>
> >> Function: add/remove: 4/2 grow/shrink: 0/5 up/down: 473/-647 (-174)
> >>
> >> + up to 2% performance.
> >>
> >
> > What is the test you saw the 2% performance improvement in? Is it
> > something XDP related or a full stack test?
>
> Not XDP, it's not present in this driver at this point :D
> Stack test, but without usercopy overhead. Trafgen bombs the NIC, the
> driver builds skbs and passes it up the stack, the stack does GRO etc,
> and then the frames get dropped on IP input because there's no socket.

So one thing you might want to look at would be a full stack test w/
something such as netperf versus optimizing for a drop only test.
Otherwise that can lead to optimizations that will actually hurt
driver performance in the long run.

> >
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >
> > Also one thing I am not a huge fan of is a patch that is really a
> > patchset onto itself. With all 6 items called out here I would have
> > preferred to see this as 6 patches as it would have been easier to
> > review.
>
> Agree BTW, I'm not a fan of this patch either. I wasn't sure what to do
> with it, as splitting it into 6 explodes the series into a monster, but
> proceeding without it increases diffstat and complicates things later
> on. I'll try the latter, but will see. 17 patches is not the End of Days
> after all.

One thing you may want to consider to condense some of these patches
would be to look at possibly combining patches 4 and 5 which disable
recycling and use a full 4K page. It seems like of those patches one
ends up redoing the other since so many of the dma_sync calls are
updated in both.

> >
> >> ---
> >>  drivers/net/ethernet/intel/iavf/iavf_main.c |   2 +-
> >>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 259 +++++++++----------=
-
> >>  drivers/net/ethernet/intel/iavf/iavf_txrx.h |   3 +-
> >>  3 files changed, 114 insertions(+), 150 deletions(-)
>
> [...]
>
> >> @@ -943,23 +945,17 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_=
ring, u16 cleaned_count)
> >>
> >>              /* clear the status bits for the next_to_use descriptor *=
/
> >>              rx_desc->wb.qword1.status_error_len =3D 0;
> >> -
> >> -            cleaned_count--;
> >> -    } while (cleaned_count);
> >> +    } while (--to_refill);
> >
> > Just a nit. You might want to break this up into two statements like I
> > had before. I know some people within Intel weren't a huge fan of when
> > I used to do that kind of thing all the time in loops where I would do
> > the decrement and test in one line.. :)
>
> Should I please them or do it as I want to? :D I realize from the
> compiler's PoV it's most likely the same, but dunno, why not.

If nobody internally is bugging you about it then I am fine with it. I
just know back during my era people would complain about that from a
maintainability perspective. I guess I got trained to catch those kind
of things as a result.

> >
> >>
> >>      if (rx_ring->next_to_use !=3D ntu)
> >>              iavf_release_rx_desc(rx_ring, ntu);
> >>
> >> -    return false;
>
> [...]
>
> >>      /* if we are the last buffer then there is nothing else to do */
> >>  #define IAVF_RXD_EOF BIT(IAVF_RX_DESC_STATUS_EOF_SHIFT)
> >>      if (likely(iavf_test_staterr(rx_desc, IAVF_RXD_EOF)))
> >
> > You may want to see if you can get rid of this function entirely,
> > perhaps you do in a later patch. This function was added for ixgbe back
> > in the day to allow us to place the skb back in the ring for the RSC
> > based workloads where we had to deal with interleaved frames in the Rx
> > path.
> >
> > For example, one question here would be why are we passing skb? It
> > isn't used as far as I can tell.
>
> Yes, I'm optimizing all this out later in the series. I was surprised
> just as much as you when I saw skb getting passed to do nothing ._.

The funny part for me is that it is like reviewing code written via a
game of telephone. I recognize the code but have to think about it
since there are all the bits of changes and such from the original
ixgbe.

> [...]
>
> Thanks for the detailed reviews, stuff that Intel often lacks :s :D

No problem, it was the least I could do since I am responsible for so
much of this code in the earlier drivers anyway. If nothing else I
figured I could provide a bit of history on why some of this was the
way it was.
