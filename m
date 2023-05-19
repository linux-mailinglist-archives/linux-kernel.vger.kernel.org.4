Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5207097DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjESM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjESM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:59:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC20C187
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:59:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 725BF68C7B; Fri, 19 May 2023 14:58:57 +0200 (CEST)
Date:   Fri, 19 May 2023 14:58:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when
 xen-pcifront is enabling
Message-ID: <20230519125857.GA6994@lst.de>
References: <20230518134253.909623-1-hch@lst.de> <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl> <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl> <20230519124118.GA5869@lst.de> <8617570c-6dc4-74f5-7418-98f04f7e0ece@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8617570c-6dc4-74f5-7418-98f04f7e0ece@citrix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 01:49:46PM +0100, Andrew Cooper wrote:
> > The alternative would be to finally merge swiotlb-xen into swiotlb, in
> > which case we might be able to do this later.  Let me see what I can
> > do there.
> 
> If that is an option, it would be great to reduce the special-cashing.

I think it's doable, and I've been wanting it for a while.  I just
need motivated testers, but it seems like I just found at least two :)
