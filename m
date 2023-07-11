Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221CF74E2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGKApX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjGKApV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:45:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C419CA0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:45:17 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-765a1690003so399029885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689036317; x=1691628317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vDAChdCtpEMWX7FZp6dXco/84l2XQjYx3GS9hbCrEs=;
        b=QU2Ce+Q/ZLzGFSnA9bFQqtmexLsOQFptVRza5ba0p/yMIJRe853P6Oc1Xy0T/wfFuV
         TE7dFaHuDFn4rrGoClHA+PAw846CTYpq9xggmi4twNpCm4cKooJWzwzl/zlUX9lYodp2
         /mja+hg+XEfXqQkQ0ogC1AAFmEL103NKW4AGfSTSd1XNUrenllWXdMDgV7Jn2S494y7d
         J2PgBmj9qbp71tZlsBOl4fn1/AqVSJy+v2rIfLLZGDqc8XFJ3pmz5LtobHFXyUMgaQqR
         UwuZCwObiF0uviEdvoWP7cgk6GNDmqj0wOPr58FXp/fHMnZjX82xgFEgSg5fwVdhZlo9
         4j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036317; x=1691628317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vDAChdCtpEMWX7FZp6dXco/84l2XQjYx3GS9hbCrEs=;
        b=JI1YtbMutusBnr1QrJehx10TtmhCWKbpa620OJiTKYuEmrHei1n067toY0jB2z7tGX
         XawcGqWyGNuMteVMUVW8HqhM9KAnwdrnQKT4lqefbuWI1G9OLeL/jCBu0NzO2SL9nQ3s
         YahqUOsQIs+2XSARzDa3AKQh2SAYVOstAH+znYDsz3jFo+kA4qeHcHe4pf01jX6XuUGC
         lZ9EkYzJmWW2nRDXQ/r6dHmZ0KjadPVum+DfVeTNk30LdqofSX6zLFNurALIZ4DaYAkX
         n3vOU6BsW/ruCGZADlZbObpF1I6xfTTkBAs2bNI+Gg7e1LPmDx6FgsUG3pQ7iaEwAIr0
         eXtg==
X-Gm-Message-State: ABy/qLbNX+MhVIvsskxZrvuDVKyean0ynayXFExETHZrJognb+JbHEsr
        DUcpoVD2E/BuAreROwqN1Q/hAwkky1mWBPjk75sPDw==
X-Google-Smtp-Source: APBJJlGmMfPz0wI92CuityRQyRUT7Kh0+wLgEI4lVG/0GSswhkihLDqBBo+i2OAo23yAEXn+5c2cnEOyo2p340ynQzo=
X-Received: by 2002:a05:620a:468e:b0:767:405b:650f with SMTP id
 bq14-20020a05620a468e00b00767405b650fmr15044320qkb.45.1689036316710; Mon, 10
 Jul 2023 17:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230616122140.6e889357@kernel.org> <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
 <20230619110705.106ec599@kernel.org> <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org> <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca> <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca> <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca>
In-Reply-To: <ZKyZBbKEpmkFkpWV@ziepe.ca>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 10 Jul 2023 17:45:05 -0700
Message-ID: <CAHS8izOTiSO5PkM+x-CASjwew=U2j=JRNpbz_6NC6AsDTQ17Ug@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 4:49=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Jul 10, 2023 at 04:02:59PM -0700, Mina Almasry wrote:
> > On Mon, Jul 10, 2023 at 10:44=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > >
> > > On Wed, Jul 05, 2023 at 06:17:39PM -0700, Mina Almasry wrote:
> > >
> > > > Another issue is that in networks with low MTU, we could be DMAing
> > > > 1400/1500 bytes into each allocation, which is problematic if the
> > > > allocation is 8K+. I would need to investigate a bit to see if/how =
to
> > > > solve that, and we may end up having to split the page and again ru=
n
> > > > into the 'not enough room in struct page' problem.
> > >
> > > You don't have an intree driver to use this with, so who knows, but
> > > the out of tree GPU drivers tend to use a 64k memory management page
> > > size, and I don't expect you'd make progress with a design where a 64=
K
> > > naturaly sized allocator is producing 4k/8k non-compound pages just
> > > for netdev. We are still struggling with pagemap support for variable
> > > page size folios, so there is a bunch of technical blockers before
> > > drivers could do this.
> > >
> > > This is why it is so important to come with a complete in-tree
> > > solution, as we cannot review this design if your work is done with
> > > hacked up out of tree drivers.
> > >
> >
> > I think you're assuming the proposal requires dma-buf exporter driver
> > changes, and I have a 'hacked up out of tree driver' not visible to
> > you.
>
> Oh, I thought it was obvious what you did in patch 1 was a total
> non-starter when I said you can't abuse the ZONE_DEVICE pages like
> this.
>
> You must create ZONE_DEVICE P2P pages, not MEMORY_DEVICE_PRIVATE to
> represent P2P memory,

We can extend the memory_type enum, with something like MEMORY_DEVICE_DMABU=
F?

> and you can't do that automatically from the
> dmabuf core code.
>

Sorry, why not?

> Without doing this the DMA API doesn't actually work properly because
> it doesn't have enough information to know about what the underlying
> exporter is.
>

I didn't think it would matter that the DMA API doesn't work with
these pages, because the mapping already exists courtesy of
dma_buf_map_attachment(), and these dma-buf pages don't need to be
mapped (the dma_addr is already available). I'm providing
dma_buf_map_sg() in that patch to use instead of the DMA API. Would be
nice to help me understand why we would care why the DMA API doesn't
work with these pages when we're asking code using these pages to use
the provided API instead?

> The entire point of DEVICE_PRIVATE is that the page content, and
> access to the page's physical location, is *explicitly* unavailable to
> anyone but the pgmap owner.
>

This seems to be a semantics issue. Would setting the pages as
MEMORY_DEVICE_DMABUF address this?

> > > Fully and properly adding P2P ZONE_DEVICE to a real world driver is a
> > > pretty big ask still.
> >
> > There is no such ask.
>
> Well, there is from me if you want to use stuct pages as handles for
> P2P memory. That is what we have defined in the pgmap area.
>
> Also I should warn you that your 'option 2' is being NAK'd by
> Christoph for now, we are not adding any new code around DMABUF's
> hacky use of NULL sg_page scatterlist for P2P memory either. I've been
> working on solutions here but it is slow going.
>

Option 2, I think, doesn't care about the sg_page NULL. But it may be
pointless to discuss, I don't see how we could modify the page pool,
networking stack, and all the networking drivers to do anything other
than struct page (someone feel free to correct).

> > On dma-buf changes required. I do need approval from the dma-buf
> > maintainers,
>
> It is a neat hack, of sorts, to abuse DEVICE_PRIVATE to create struct
> pages for the exclusive use of pagepool - but you need more approval
> than just dmabuf maintainers to abuse the pgmap framework like
> this.
>

Who? I'd love to add them on subsequent proposals.

> At least from my position I want to see MEMORY_DEVICE_PCI_P2PDMA used
> to represent P2P memory.

Would using p2pdma API instead of dmabuf be an acceptable direction?

The nice thing about what I'm doing is that any existing dmabuf
exported would be supported, AFAICT. To use p2pdma I think I would
need to modify the drivers providing the device memory to do a
pci_p2pdma_add_resource(), and use the pci_p2pdma_map_sg() on the
importer driver (NIC), but that may work, with driver changes.

Would that be an acceptable direction to you? Or are you against the
approach in the RFC and don't have any alternative path forward for
this? Is this not a use case we want to support in some way in the
kernel?

> You haven't CC'd anyone from the mm community
> so I've added some people here to see if there are other opinions.
>

I CC'd get_maintainers.pl output and you because you showed interest
and get_maintainers did not add you automatically.

> To be clear, you need an explicit ack from mm people on the abusive
> use of pgmap in patch 1.
>

Who? I would love to add them on subsequent proposals.

> I know it is not what you want to hear, but there are actual reasons
> why the P2P DMA problem has been festering for so long, and hacky
> quick fixes like this are not going to be enough..
>

--
Thanks,
Mina
