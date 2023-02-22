Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90669FEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjBVWtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBVWtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:49:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F039DCA11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:49:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso10416926pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zZrIn1zhWqbXZNcQj8GbCBGSZOdZOUKk74ynuwKyG3w=;
        b=pXh4/jwK9iY/4mZJ1wuoiifTgDRYU7ucMnylFG63kW6Tftldj6Gk+bzrCWx9kN/hWb
         EyXsy7GR2tTuxWbSz01Pp1lZqc2QGv79LhMhSbq47jS6fwFxwjDNzKMtU7oz/VpVgYuL
         8n6uSplT2f3U8Fd88kX2+1XsfXIoTuf9uvm23/2Y5pUkMOjZ5AnK7qZa4EpMydvtOJk5
         zHaFm30oPpWyyN2RUVJrroyS8Iql1Oi2gNBxx2/DMVm4FkgF5vFLMBhCzC+8i28tpdj8
         5w0uv+SUbId3QdEZerBGnQ0GPoJw4hBcaibXd8BWTQ5NDhLhVggDyWL9Uvbjmcm1+8Ko
         nIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZrIn1zhWqbXZNcQj8GbCBGSZOdZOUKk74ynuwKyG3w=;
        b=k0PbbQQRARblZ5NSWcNTOSpHstqw1Hb6N4rzCnCo0TBVHCLa9FOb8OO3d0ARX+6Y+8
         g/APvDFPOjdBul3EDkIRLogBvXkonrmwP1nEgy6RARTeohwIFkH8bZGNakLHTtEDGBj+
         2sbFZM2lP6CtjgIzLPz2kIrN5z+w8WbMo85GOn/ZQZeLi6tP3CzZBym3R9ETK01DOyg/
         LtDsB+bxCWwN8TefY7/lDWp2e6zo7Q9HUQaDaS4OA1uNjXEgIxIrglNVf5/F6rhL2MVB
         gal0Y3Gg3r3JQU+j3TQEtWr+WfN6grriO9JptN73/hoiptT39uz22+P/aCSoT0rS+j63
         n7Sw==
X-Gm-Message-State: AO0yUKVolOXiPT5UaFQkc3ucclRylVI+4ml1LWFmXkrt0SMYO3XhdQr2
        2l3wva59oci3YKYVU5NkyItraj062WZg0Srl93WRO4VwDUs=
X-Google-Smtp-Source: AK7set81VNTF7HjTfvF1YgUtwMdxuBa7lLbtv1o9MVEo6Jd78I/wH4EARu75N6XjaNyxJYhjSf6zebPhlrxFjwrVEQM=
X-Received: by 2002:a17:90a:df85:b0:237:29b0:fb95 with SMTP id
 p5-20020a17090adf8500b0023729b0fb95mr26067pjv.5.1677106147264; Wed, 22 Feb
 2023 14:49:07 -0800 (PST)
MIME-Version: 1.0
References: <Y/U8bQd15aUO97vS@casper.infradead.org> <CAHbLzkrkZmbVMkh-Y-bDxgy0T0ZRRd+T+o5y5-wKmjKmhN0NmA@mail.gmail.com>
 <Y/WRlX+MkmxelNbg@casper.infradead.org>
In-Reply-To: <Y/WRlX+MkmxelNbg@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 22 Feb 2023 14:48:55 -0800
Message-ID: <CAHbLzkoimRevH7zMVUTmeu6SgmhjvOes7UoLmr=ceL1z4pwhRw@mail.gmail.com>
Subject: Re: What size anonymous folios should we allocate?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 7:52 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Feb 21, 2023 at 03:05:33PM -0800, Yang Shi wrote:
> > On Tue, Feb 21, 2023 at 1:49 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > In a sense this question is premature, because we don't have any code
> > > in place to handle folios which are any size but PMD_SIZE or PAGE_SIZE,
> > > but let's pretend that code already exists and is just waiting for us
> > > to answer this policy question.
> > >
> > > I'd like to reject three ideas up front: 1. a CONFIG option, 2. a boot
> > > option and 3. a sysfs tunable.  It is foolish to expect the distro
> > > packager or the sysadmin to be able to make such a decision.  The
> > > correct decision will depend upon the instantaneous workload of the
> > > entire machine and we'll want different answers for different VMAs.
> >
> > Yeah, I agree those 3 options should be avoided. For some
> > architectures, there are a or multiple sweet size(s) benefiting from
> > hardware. For example, ARM64 contiguous PTE supports up to 16
> > consecutive 4K pages to form a 64K entry in TLB instead of 16 4K
> > entries. Some implementations may support intermediate sizes (for
> > example, 8K, 16K and 32K, but this may make the hardware design
> > harder), but some may not. AMD's coalesce PTE supports a different
> > size (128K if I remember correctly). So the multiple of the size
> > supported by hardware (64K or 128K) seems like the common ground from
> > maximizing hardware benefit point of view. Of course, nothing prevents
> > the kernel from allocating other orders.
>
> All of this is true (although I think AMDs intermediate size is actually
> 32kB, not 128kB), but irrelevant.  Software overhead is FAR more important
> than hardware overhead.  If we swap out the wrong page or have to run
> around doing reclaim, that absolutely dwarfs the performance impact of
> using small TLB entries.
>
> So we need to strike the right balance between using larger folios
> for efficiency and smaller folios for precision of knowing which
> pages are still part of the process working set.

As long as the large folio is not PMD mapped, we know which subpages
are accessed. Anyway I do agree we need the balance.

>
> > Actually I was thinking about the reverse, starting from the biggest
> > possible order, for example, 2M -> 1M -> ... 64K -> ... 4K. And the
> > page fault path should be able to use the same fallback order. But
> > excessive fallback tries may be harmful either.
>
> What's your reasoning here?

There is no indicator to tell kernel what order is preferred or proper
for anonymous page, just like you elaborated. We don't know the access
pattern of the workloads either. But we have to start from an order.
Basically I looked at it from the other angle. The approach just
simply starts from an order which could maximize the hardware benefit.
This may incur some memory waste until memory reclamation is kicked
in. And there should be some feedback mechanism to give a hint for a
more proper order for the future page fault off the top of my head,
then we finally reach the balance.

I can't tell which one (starting from low order or high order) is
better for now.

>
> > > B. A further modification is that it will require three of the four
> > >    folios being combined to be on the active list.  If two (or more)
> > >    of the four folios are inactive, we should leave them alone; either
> > >    they will remain inactive and eventually be evicted, or they will be
> > >    activated and eligible for merging in a future pass of khugepaged.
> >
> > If we use the fallback policy, we should be able to just leave it to
> > reclamation time. When checking reference we could tell what PTEs are
> > accessed, then split if there is significant internal fragmentation.
>
> I think it's going to lead to excessive memory usage.  There was data
> presented last LSFMM that we already have far too much memory tied up
> in THP for many workloads.

It is possible. But that data was based on PMD size THP IIRC. The
lower order may make difference hopefully.

>
> > > C. We add a new wrinkle to the LRU handling code.  When our scan of the
> > >    active list examines a folio, we look to see how many of the PTEs
> > >    mapping the folio have been accessed.  If it is fewer than half, and
> > >    those half are all in either the first or last half of the folio, we
> > >    split it.  The active half stays on the active list and the inactive
> > >    half is moved to the inactive list.
> >
> > With contiguous PTE, every PTE still maintains its own access bit (but
> > it is implementation defined, some implementations may just set access
> > bit once for one PTE in the contiguous region per arm arm IIUC). But
> > anyway this is definitely feasible.
>
> If a CPU doesn't have separate access bits for PTEs, then we should just
> not use the contiguous bits.  Knowing which parts of the folio are
> unused is more important than using the larger TLB entries.

Yeah, we are on the same page.

>
> > > For the third case, in contrast, the parent had already established
> > > an appropriate size folio to use for this VMA before calling fork().
> > > Whether it is the parent or the child causing the COW, it should probably
> > > inherit that choice and we should default to the same size folio that
> > > was already found.
> >
> > Actually this is not what THP does now. The current THP behavior is to
> > split the PMD then fallback to order-0 page fault. For smaller orders,
> > we may consider allocating a large folio.
>
> I know it's not what THP does now.  I think that's because the gap
> between PMD and PAGE size is too large and we end up wasting too much
> memory.  We also have very crude mechanisms for determining when to
> use THPs.  With the adaptive mechanism I described above, I think it's
> time to change that.

Yeah, IIRC the major reason was the complain about long latency for
COW fault. Both THP allocation and data copy could incur the long
latency. So lower order may make difference hopefully.

>
