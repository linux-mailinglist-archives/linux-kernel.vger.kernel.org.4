Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C26C7F29
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCXNz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCXNzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:55:55 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3A212CF6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:55:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A51D65C00D9;
        Fri, 24 Mar 2023 09:55:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Mar 2023 09:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1679666153; x=1679752553; bh=EVVXoHGj3zpolObFfiWsoAlRi
        /eEAsJP3e63FytbD+A=; b=pIsQklgpfxEk0u/z9hxuDIDknrxlXv4xfdljX13+p
        jN1lsGal37SgSQjrgB0dqSgvJPJ3b/7b9JAuhat9cX/FLAvwlL31n+qW1481lThy
        1opasdhbwIhLpU7P8/hI1tBkreAohz0Y4vsQslP9bSsrXhRv10wOpjJHEMUDBSVs
        xTgvxaKXu96P6thUTGRwkb0saO5nuFBckuEH4/Ht3d3F3gQ6Vac8JfALo4ZPzTG5
        vLm4aLmq+8uerGZ4YEEoG9fmnvs70G/CmnYg8WBPuSgoqVvVCVYWK1HBGu2m4m4F
        WVy8JzR3jzTsF+Cvfr0UdrCO95/YGy+802D5cyOU3rBTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679666153; x=1679752553; bh=EVVXoHGj3zpolObFfiWsoAlRi/eEAsJP3e6
        3FytbD+A=; b=ZjcQ2/l6a2Veit2UWuHXGGVWqwSElmYN2qW4GH/iU1PoO93CvYp
        mNOlUjzRn8WGK+UEM+79m+JFuZ7gOlr9vt3mazPhuE4ytCZoMmuWBgok9d8qZ0uX
        pC/XLGcVxZ0OLA+++Mq8D357fwcz6ho+LgtkGt/NpNj253HGGrHqXz/95icqmLc1
        ML/OLWMM5/YVaWc05+6dUpt0drJliBgFFh9o4mOZAxKG3ePFiT8SUSo9+hXQp0i1
        fjZdDDbREYFd2N1W2/1sg0+LwSNnRl1jx6e2KpyMFKxUP98LklzQxeuznoEchwDY
        +80RGxG3dmsuCtdhTp6ehXymHzUEWYBgppg==
X-ME-Sender: <xms:6asdZLbtViJTf4ZX24EVIxBTBRUQjd2uSL_Jg_FicfASVziXnvs_Zg>
    <xme:6asdZKbWUvhjP0rLBovTd4jsHLh6lFb4_Zp7zT-A5BghhiSfpbf5fql0VwiN3kWx0
    HOQevUuQgWMxkqO_Xg>
X-ME-Received: <xmr:6asdZN_ghvQ9B1tNXoP3YGdBMCFmfdZZyfnWCHzJp3kS4qICeFCzk7oAesIZX40hsVbhNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepjeeiieeftddtjeffkeefgffgudekjedvgfdu
    geeljeehhedthfduveeitdetudetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:6asdZBqF7T_pQfWTgPgxaRt-z9cBq1Z76-3-r_Lp-akPeIrhlibXKw>
    <xmx:6asdZGrM8hlHxJJQ_bB8kPDYBnzKcB_J_m25HokcAHR0ow7I4BeFvA>
    <xmx:6asdZHThpg5ot3ZD-Ew8s2yYIKV9tEtP1lrtQBQkGCIHv1HXQAjwRg>
    <xmx:6asdZDAL4_80srUKPZGrVteCrdIYsc2pmotAH2YTzxJvpF6BHc5kxQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 09:55:53 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 802F610A607; Fri, 24 Mar 2023 16:55:50 +0300 (+03)
Date:   Fri, 24 Mar 2023 16:55:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARN_ON in move_normal_pmd
Message-ID: <20230324135550.q2xfuj4hjs7odbu5@box>
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz>
 <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
 <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:43:10AM -0400, Joel Fernandes wrote:
> On Fri, Mar 24, 2023 at 9:05 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Fri, Mar 24, 2023 at 12:15:24PM +0100, Michal Hocko wrote:
> > > Hi,
> > > our QA is regularly hitting
> > > [  544.198822][T20518] WARNING: CPU: 1 PID: 20518 at ../mm/mremap.c:255 move_pgt_entry+0x4c6/0x510
> > > triggered by thp01 LTP test. This has been brought up in the past and
> > > resulted in f81fdd0c4ab7 ("mm: document warning in move_normal_pmd() and
> > > make it warn only once"). While it is good that the underlying problem
> > > is understood, it doesn't seem there is enough interest to fix it
> > > properly. Which is fair but I am wondering whether the WARN_ON gives
> > > us anything here.
> > >
> > > Our QA process collects all unexpected side effects of tests and a WARN*
> > > in the log is certainly one of those. This trigger bugs which are mostly
> > > ignored as there is no upstream fix for them. This alone is nothing
> > > really critical but there are workloads which do run with panic on warn
> > > configured and this issue would put the system down which is unnecessary
> > > IMHO. Would it be sufficient to replace the WARN_ON_ONCE by
> > > pr_warn_once?
> >
> > What about relaxing the check to exclude temporary stack from the WARN
> > condition:
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 411a85682b58..eb0778b9d645 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -247,15 +247,12 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> >          * of any 4kB pages, but still there) PMD in the page table
> >          * tree.
> >          *
> > -        * Warn on it once - because we really should try to figure
> > -        * out how to do this better - but then say "I won't move
> > -        * this pmd".
> > -        *
> > -        * One alternative might be to just unmap the target pmd at
> > -        * this point, and verify that it really is empty. We'll see.
> > +        * Warn on it once unless it is initial (temporary) stack.
> >          */
> > -       if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
> > +       if (!pmd_none(*new_pmd)) {
> > +               WARN_ON_ONCE(!vma_is_temporary_stack(vma));
> >                 return false;
> > +       }
> 
> Wouldn't it be better to instead fix it from the caller side? Like
> making it non-overlapping.
> 
> Reading some old threads, I had tried to fix it [1] along these lines
> but Linus was rightfully concerned about that fix [2]. Maybe we can
> revisit and fix it properly this time.
> 
> Personally I feel the safest thing to do is to not do a
> non-overlapping mremap and get rid of the warning. Or is there a
> better way like unmapping the target from the caller side first,
> before the move?

Making it non-overlapping limits randomization effectiveness. We need to
quantify it at least.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
