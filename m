Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502687260D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbjFGNNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbjFGNNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:13:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F0795
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:13:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 33B3F6732D; Wed,  7 Jun 2023 15:12:58 +0200 (CEST)
Date:   Wed, 7 Jun 2023 15:12:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20230607131257.GB19206@lst.de>
References: <20230518134253.909623-1-hch@lst.de> <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl> <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl> <c5defff8-882e-3482-0de1-e50a4bcdfa99@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5defff8-882e-3482-0de1-e50a4bcdfa99@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 10:37:09AM +0200, Juergen Gross wrote:
> In normal cases PCI passthrough in PV guests requires to start the guest
> with e820_host=1. So it should be rather easy to limit allocating the
> 64MB in PV guests to the cases where the memory map has non-RAM regions
> especially in the first 1MB of the memory.
>
> This will cover even hotplug cases. The only case not covered would be a
> guest started with e820_host=1 even if no PCI passthrough was planned.
> But this should be rather rare (at least I hope so).

So is this an ACK for the patch and can we go ahead with it?

(I'd still like to merge swiotlb-xen into swiotlb eventually, but it's
probably not going to happen this merge window)
