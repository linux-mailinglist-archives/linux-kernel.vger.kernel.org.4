Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961517370B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjFTPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjFTPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:39:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37F41B6;
        Tue, 20 Jun 2023 08:39:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686708c986so3146318b3a.0;
        Tue, 20 Jun 2023 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687275596; x=1689867596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8Hoy9XM6nWteCVE5umnvw8tKutc1dVsJMGplgb80kA=;
        b=b7zOlxVEy2vIWv1T2M/YDbCcULIamqgm7i3+45WSNTj7SNpp9Pv4nj3sFMz3uUzIxD
         oI2ZlOwFhmgzp5nx9kGm2qnFB534e41sHDfnVv++ypvNJzdwZGxZb+g+0HZ6Z5YbwX6L
         4PshcRT1R+L+yBlpWHHDK7Ek0ATkgfCEaH9k/JNgM1CAQJsptGH0rXilYhFq94v+L+/8
         OFwWPW5dL0nia4DpQipTAVGr6hy6CmaSsFgtiISLRTjjKHwoI60Q9XBnpW9qM4Sju/UD
         2rVCdw14a5yVf+5HTKbid/nLXsQ1wjzbNoU1cLkP43vRA7Aq3us65/vDu27Uf2CXuwcp
         XWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275596; x=1689867596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8Hoy9XM6nWteCVE5umnvw8tKutc1dVsJMGplgb80kA=;
        b=cc9X+5Ejdu9MK0A9aQRZCkNFnvi0/qivwbplAeP6Bi3iMTD583JlIEdR+vr/KBoBLW
         kvpo7pSphxYMQC2CUo4ZDHlBxZlvgHk1Jl+6Z42NcFVuFbhD2woapjN+4RzyKB1nT+G0
         9Mba73xj7Ts02QTrpV/hNrFfXoA4EpaNvFQH/EU+4UGYTPC2MQmYOPXYz0ZXhaMx9KIP
         YhQLZPol/FY8N7wKKQeQKLfEfqkm894Q4b39xbMo/hnGsT81GruxKY7Al1vurjTZ7mRB
         boDbF/vU/+2vNG0SQKbnHby1rwXzrgmVd/IsvTOD6bqS8VBvUiPA8VIluRKOy1zFi4Fo
         gPaQ==
X-Gm-Message-State: AC+VfDyC5e1dkBSbyy97YZ4LOw2WUeiOAQaxnBJ7qooT7hubn8gSlIZe
        ELO3Bh7loCCeYVsOCm429zYw3mLmJGdkyVG0OkuLznXY
X-Google-Smtp-Source: ACHHUZ7O7X8Z5vHQFdY+MxB0E7hlMRxnKq3F/BH9JHPtZV2XtBjPBjXhEfXZUPCEjVBwkPf+E+BOgPStwb7iwVztaqs=
X-Received: by 2002:a05:6a00:1886:b0:668:8545:cbeb with SMTP id
 x6-20020a056a00188600b006688545cbebmr5648677pfh.15.1687275595976; Tue, 20 Jun
 2023 08:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230609131740.7496-1-linyunsheng@huawei.com> <20230609131740.7496-4-linyunsheng@huawei.com>
 <CAKgT0UfVwQ=ri7ZDNnsATH2RQpEz+zDBBb6YprvniMEWGdw+dQ@mail.gmail.com>
 <36366741-8df2-1137-0dd9-d498d0f770e4@huawei.com> <CAKgT0UdXTSv1fDHBX4UC6Ok9NXKMJ_9F88CEv5TK+mpzy0N21g@mail.gmail.com>
 <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com> <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
 <0345b6c4-18da-66d8-71a0-02620f9abe9e@huawei.com> <CAKgT0Udmxc6EbUoZ_4P3jfWck3mvUtTY8mqUjT91bDwjZj-uMg@mail.gmail.com>
 <741d1dab-e8d7-2420-e652-d4a671dac7b1@gmail.com>
In-Reply-To: <741d1dab-e8d7-2420-e652-d4a671dac7b1@gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 20 Jun 2023 08:39:19 -0700
Message-ID: <CAKgT0UeeWhD0_YWHoQe4=vEvKPXdVcFzp5qca2kM3uG7j+U2dg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc() API
To:     Yunsheng Lin <yunshenglin0825@gmail.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 4:41=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail=
.com> wrote:
>
> On 2023/6/16 22:46, Alexander Duyck wrote:
> ...
>
> >>>> 2. the driver handles it by manipulating the page_pool->frag_offset
> >>>>    directly.
> >>>
> >>> I view 2 as being the only acceptable approach. Otherwise we are
> >>> forcing drivers into a solution that may not fit and forcing yet
> >>> another fork of allocation setups. There is a reason vendors have
> >>
> >> I respectly disagree with driver manipulating the page_pool->frag_offs=
et
> >> directly.
> >>
> >> It is a implemenation detail which should be hiden from the driver:
> >> For page_pool_alloc_frag() API, page_pool->frag_offset is not even
> >> useful for arch with PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true,
> >> similar cases for page_pool_alloc() returning mono-frag if I understan=
d
> >> 'mono-frag ' correctly.
> >>
> >> IMHO, if the driver try to do the their own page spilting, it should
> >> use it's own offset, not messing with the offset the page pool is usin=
g.
> >> Yes, that may mean driver doing it's own page splitting and page pool
> >> doing it's own page splitting for the same page if we really like to
> >> make the best out of a page.
> >
> > Actually, now that I reread this I agree with you. It shouldn't be
> > manipulating the frag_offset. The frag offset isn't really a thing
> > that we have to worry about if we are being given the entire page to
> > fragment as we want. Basically the driver needs the ability to access
> > any offset within the page that it will need to. The frag_offset is an
> > implementation of the page_pool and is not an aspect of the fragment
> > or page that is given out. That is one of the reasons why the page
> > fragments are nothing more than a virtual address that is known to be
> > a given size. With that what we can do is subdivide the page further
> > in the drivers.
>
> I am really doubtful that the need of 'subdividing the page further
> in the drivers' if we have the page splitting in page pool to allow
> multi-descs to share the same page for most of the nic driver. IOW,
> we should do only one level of page splitting IMHO.

The problem is there are architectures that use things like 64K pages.
On those systems drivers are usually taking the page and having to
split it into 4K sub-sections of the page since the device cannot
fully utilize the 64K page. The thought here is that if we are already
treating 4K pages as a single fragged page, and performing
fragmentation on it then if we were to take the 64K page and break it
into 16 4K fragments, those fragments could further be broken up and
used by the device instead of wasting 60K due to the large page size.

> If I understand it correctly, most hw have a per-queue fixed buffer
> size, even the mlx5 one with per-desc buffer size support through
> mlx5_wqe_data_seg, the driver seems to use the 'per-queue fixed
> buffer size' model, I assume that using per-desc buffer size is just
> not worth the effort?

The problem is the device really has two buffer sizes it is dealing
with. The wqe size, and the cqe size. What goes in as a 4K page can
come up as multiple frames depending on the packet sizes being
received.

> Let's say we use the per-queue fixed buffer with 2K buffer size, I
> am supposing that is most drivers is using by default, so the question
> is how much memory is needed for each desc to allowing subdividing
> within desc? I am supposing we mostly need a 4K buffer for each desc,
> right?

The problem is your solution here is naive. Most drivers are getting
much more complicated than just using a fixed buffer size these days.
Again, the point I am getting at is that they will be taking in 4K
pages most likely and then having to subdivide it after the DMA has
been performed and they are sorting out completion queue entries to
figure out how the hardware used the page and what was written.

> For system with 4K page size, that means we are only able to do one
> level of page splitting, either in the page pool or in the driver.
> What is your perfer option? and Why?

We can do both. All we have to do is add references from the driver.
It is no different than how in the old drivers pre-page pool we were
taking the reference count on the page in the driver and splitting it
ourselves for reuse.

> For system with larger page size, that means we are able to do
> multi level of page splitting, and I suppose page splitting in
> the page pool is always needed, the question is whether we allow
> subdividing in the driver, right?

Right, and there isn't really anything we can do to prevent that nor
should we. Otherwise we risk making the page pool obsolete and it will
be replaced by something that can support it since that is the
hardware model that vendor can support with their device.

> I think we need to consider the truesize underestimate problem
> for small packet if we want to do page splitting in the driver
> to save memory, even for system with 4K page size, not to
> mention the 64K page size.
>
> As you said in the previous thread:
> "
> > IMHO, doing the above only alleviate the problem. How is above splittin=
g
> > different from splitting it evently with 16 2K fragments, and when 15 f=
rag
> > is released, we still have the last 2K fragment holding onto 32K memory=
,
> > doesn't that also cause massive truesize underestimate? Not to mention =
that
> > for system with 64K page size.
>
> Yes, that is a known issue. That is why I am not wanting us to further
> exacerbate the issue.
> "
> Also If there is any known solution to this 'known issue'? it
> seems unfixable to me, so I did not continue that discussion in
> that thread.
>
> And for packet with normal size, it seems the hns3 case seems
> like a proof that doing the page splitting in the page pool
> seems like a better choice, even for system with 4K page size,
> mainly because doing the page splitting in page pool is per-queue,
> and doing the page splitting in driver is per-desc, which is a
> smaller 'pool' comparing to page pool.

That seems like a very narrow perspective. The fact is the Mellanox
use case is more likely the direction things are going in. It is more
heavily used and is more widely supported. That is one of the reasons
why trying to modify it to fit your use case is going to be much more
tricky, and why I believe you should think about that more with the
hns3 being a secondary use case.

> >
> > What I was thinking of was the frag count. That is something the
> > driver should have the ability to manipulate, be it adding or removing
> > frags as it takes the section of memory it was given and it decides to
> > break it up further before handing it out in skb frames.
>
> As my understanding, there is no essential difference between frag
> count and frag offet if we want to do 'subdividing', just like we
> have frag_count for page pool and _refcount for page allocator, we
> may need a third one for this 'subdividing'.

There is a huge difference, and may be part of the reason why you and
I have such a different understanding of this.

The offset is just local to your fragmentation, whereas the count is
the global value for the page at which it can finally be freed back to
the pool. You could have multiple threads all working with different
offsets as long as they are all bounded within separate regions of the
page, however they must all agree on the frag count they are working
with since that is a property specific to the page. This is why
frag_count must be atomic whereas we keep frag_offset as a local
variable.

No additional counts needed. We never added another _refcount when we
were doing splitting in the drivers, and we wouldn't need to in order
to do splitting with page_pool pages. We would just have to start with
a frag count of 1.

> >
> >> That way I see the page splitting in page pool as a way to share a
> >> page between different desc, and page splitting in driver as way to
> >> reclaim some memory for small packet, something like ena driver is
> >> doing:
> >> https://lore.kernel.org/netdev/20230612121448.28829-1-darinzon@amazon.=
com/T/
> >>
> >> And hns3 driver has already done something similar for old per-desc
> >> page flipping with 64K page size:
> >>
> >> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/hi=
silicon/hns3/hns3_enet.c#L3737
> >
> > Yeah, I am well aware of the approach. I was the one that originally
> > implemented that in igb/ixgbe over a decade ago.
> >
> >> As we have done the page splitting to share a page between different d=
esc
> >> in the page pool, I really double that the benefit will justify the
> >> complexity of the page splitting in the driver.
> >
> > The point I am getting at is that there are drivers already using this
> > code. There is a tradeoff for adding complexity to update things to
> > make it fit another use case. What I question is if it is worth it for
> > the other drivers to take on any extra overhead you are adding for a
> > use case that doesn't really seem to fix the existing one.
>
> I am not sure I understand your point here.
> page_pool_alloc() is more of way to simplify the interface for
> driver, so yes, it is impossible to take care of all use cases,
> and there is some extra overhead for the simplicity, but it does
> not means that we can not try to start generalizing thing, right?
>
> If page_pool_alloc() does not fit a specific driver/hw' need, there
> are still page_pool_alloc_pages() and page_pool_alloc_frag()
> available.

No offence, it just comes across that you are wanting to fork the
fragmentation API to fit one specific use case and want to strip it
from all others.

When I had implemented the API I had intended for it to be used the
way the Mellanox driver isusing it while also supporting other use
cases as well. However I hadn't planned for it to be used in non-DMA
use cases for instance since the whole advantage of the API is that it
retains the DMA mapping.

> >>
> >> I am not sure if there is any other 'trying to pre-allocate things jus=
t
> >> isn't going to work' case that I missed, it will be very appreciatived
> >> if you can provide the complete cases here, so that we can discuss it
> >> throughly.
> >
> > The idea is to keep it simple. Basically just like with a classic page
> > we can add to or remove from the reference count. That is how most of
> > the drivers did all this before the page pool was available.
>
> I understand that is how most of the drivers did all this before the
> page pool was available, but I am really not convinced that we need
> that when page pool was available yet as the reasons mentioned at the
> begining.

Rather than debating this, perhaps it would be better to present the
code for how you plan to make use of all this. I know there was a bit
of veth code, but it ended up being a counterexample more than
anything else since it was using the page poool API in a spot where it
should have been using the page fragment cache API.

If we can see code that demonstrates the benefits of this change
without making things worse for other drivers then we can talk. My
concern is that last time I had to step in as it seemed like we just
kept going down paths that made a mess of things for everyone else to
barely enable one specific use case. I would rather not have to repeat
that.

> >
> >>>
> >>>> 3. the page pool handles it as this patch does.
> >>>
> >>> The problem is the page pool isn't handling it. It is forcing the
> >>> allocations larger without reporting them as of this patch. It is
> >>> trying to forecast what the next request is going to be which is
> >>> problematic since it doesn't have enough info to necessarily be makin=
g
> >>> such assumptions.
> >>
> >> We are talking about rx for networking, right? I think the driver
> >> does not have that kind of enough info too, Or I am missing something
> >> here?
> >
> > Yes, we are talking about Rx networking. Most drivers will map a page
> > without knowing the size of the frame they are going to receive. As
> > such they can end up breaking up the page into multiple fragments with
> > the offsets being provided by the device descriptors.
>
> For most hw without support for multi-packet in one desc, the driver
> still need to allocate a per-queue size buffer for the next packet,
> so I am really not sure the benefit will justify the complexity and
> the truesize underestimate exacerbating yet.

What I was getting at here are the drivers that are just blindly using
page pool pages without first verifying what the page size is. There
are some that blindly assume a page is always 4K because that is
something like 99% of their market. You then put the driver one
something like a PowerPC and the system has OOM issues since it is
sitting on a pile of 64K pages. The idea is that we make page pool
always return something like a 4K page unless a higher order is
requested and we just do page subdividing in page pool rather than
having to implement it in every driver.

> >
> >>>
> >>>> Is there any other options I missed for the specific case for virtio=
_net?
> >>>> What is your perfer option? And why?
> >>>
> >>> My advice would be to leave it to the driver.
> >>>
> >>> What concerns me is that you seem to be taking the page pool API in a
> >>> direction other than what it was really intended for. For any physica=
l
> >>> device you aren't going to necessarily know what size fragment you ar=
e
> >>> working with until you have already allocated the page and DMA has
> >>> been performed. That is why drivers such as the Mellanox driver are
> >>> fragmenting in the driver instead of allocated pre-fragmented pages.
> >>
> >> Why do you think using the page pool API to do the fragmenting in the
> >> driver is the direction that page pool was intended for?
> >>
> >> I thought page pool API was not intended for any fragmenting in the
> >> first place by the discussion in the maillist, I think we should be
> >> more open about what direction the page pool API is heading to
> >> considering the emerging use case:)
> >
> > The problem is virtual devices are very different from physical
> > devices. One of the big things we had specifically designed the page
> > pool for was to avoid the overhead of DMA mapping and unmapping
> > involved in allocating Rx buffers for network devices. Much of it was
> > based on the principals we had in drivers such as ixgbe that were
> > pinning the Rx pages using reference counting hacks in order to avoid
> > having to perform the unmap.
>
> I think I am agreed on this one if I understand it correctly, the basic
> idea is to aovid adding another layer of caching as page allocator has
> the per-cpu page allocator, right?
>
> If the veth can find a better sultion as discussed on other thread,
> then I may need to find another consumer for the new API:)
>
> >
> >>>
> >>>>>
> >>>>> If you are going to go down this path then you should have a consum=
er
> >>>>> for the API and fully implement it instead of taking half measures =
and
> >>>>> making truesize underreporting worse by evicting pages earlier.
> >>>>
> >>>> I am not sure I understand what do you mean by "a consumer for the A=
PI",
> >>>> Do you mean adding a new API something like page_pool_free() to do
> >>>> something ligthweight, such as decrementing the frag user and adjust=
ing
> >>>> the frag_offset, which is corresponding to the page_pool_alloc() API
> >>>> introduced in this patch?
> >>>
> >>> What I was getting at is that if you are going to add an API you have
> >>> to have a consumer for the API. That is rule #1 for kernel API
> >>> development. You don't add API without a consumer for it. The changes
> >>> you are making are to support some future implementation, and I see i=
t
> >>> breaking most of the existing implementation. That is my concern.
> >>
> >> The patch is extending a new api, the behavior of current api is prese=
rved
> >> as much as possible, so I am not sure which implementation is broken b=
y
> >> this patch? How and why?
> >>
> >> As for the '#1 for kernel API development', I think I had mention the
> >> usecase it is intended for in the coverletter, and if I recall correct=
ly,
> >> the page_pool_fragment_page() API you added also do not come with a
> >> actual consumer, I was overloaded at that time, so just toke a glance
> >> and wonder why there was no user with a API added.
> >
> > As I recall it was partly due to the fact that I had offered to step
> > in and take over that part of the implementation you were working on
> > as we had been going back and forth for a while without making much
> > progress on the patchset.
>
> Let's improve on that so that there is less of going back and forth
> for a while without making much progress this time:)

Agreed.
