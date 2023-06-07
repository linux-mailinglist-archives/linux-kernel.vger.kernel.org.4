Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140B87268D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjFGSeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjFGSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:34:13 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680011FE9;
        Wed,  7 Jun 2023 11:34:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8384A5C017E;
        Wed,  7 Jun 2023 14:34:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 07 Jun 2023 14:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686162841; x=1686249241; bh=hI
        AsYVAmQhrwKHACsiAIdwxjB+I4M7q3AX8nU7deL08=; b=f3VlPMlix6wv8T5tim
        d3pG5yxns4bF6ExxzmVMzCbRz2MRvA42FEjLc5PUiadtvCg0hgviBGB3pYzCdJ31
        qQQA2gP6nCiffQtnaL3vRzpZ8U7UqvwBPe2dFANQJ05qbMstITkCwutjw3yIIpXJ
        UD4hRsVag5sZP9hou9DCtUWBWEkObZe86eqkw9Pys3QZUoZU3jNPbo4yAOFYpX41
        soc45iyP2UhOMo1EeLPReSsh1idruu9C5S2NOlWeBbd1KOpWqTz34OkOlQShvxNe
        7/JMxGXaUFH3NSnlHJG2Y1ZG92C3OttSOIQPy77LY9Oo6SlNyh2GuCBOmzdfJXYM
        2Sow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686162841; x=1686249241; bh=hIAsYVAmQhrwK
        HACsiAIdwxjB+I4M7q3AX8nU7deL08=; b=cjwkb0uv/EXxOHfEP8BBdKbrp/2Mn
        /VADnopGp4+Om8M4423PfUgBO2x3hMp1Wxu2xAoKwwKCsA5usR/wPMum1qe8JUGH
        4MEElq54uvv0gvhrUtW4HA0qBITFpkSsqf+rZtRZ8esIe0p4L/l4QTB5xu1ldstW
        gvbGDP97padpT+KhKhGBoJnJMy/i4VsLv5+r4U1u3gu/A6WFNv179HH+GXqEg87f
        3u34l3LdKro5fsT0rw/pK9oBrESrlYce6fe5su9CNT91+rPFUj4ciRJzfMpgAGCO
        prB66DHLPBuMcblZ0BFHa+CJTrCQIbQ0Gw8CM/w314UleHIyLuKNj2KQw==
X-ME-Sender: <xms:mc2AZGOqZK7gU6O53OnJGS84qHZ-AQcBzHtbi5LbJDxyr2zVn3zkyg>
    <xme:mc2AZE-aK-cJy7HV-41hgVSwgq7Ad1lKECv8GUAbOkoR8gUW1VxC93vbX3Q6zCC-P
    IQQHBjL3AGNpg>
X-ME-Received: <xmr:mc2AZNQFaFRGE-QH_JS7A5ZcFrmuSMw1QrUaRMo7ItT8m6VHys53wzgfx2tpL51r41bqBwmQ7xseohfG5PWsSsbZxshwZo-HYDPreQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:mc2AZGtf2uG2APQpSPPfDlng6J5b7Fy4HhTj775clZlJaSzNWhp-SQ>
    <xmx:mc2AZOeGnFgVQzCmHyjTzJ9pT7wf_lgs7NqYCDOo34wmCnnYuXAvVw>
    <xmx:mc2AZK2Ws4tv-rBEpaeqh9-OPhx9_PzuWI398alDN31if4iurtao2A>
    <xmx:mc2AZPWg3gn4yXhRxaGZGpscgjUYgHTDZ22YsuxfEdlepyymjJTzmQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 14:34:00 -0400 (EDT)
Date:   Wed, 7 Jun 2023 20:33:54 +0200
From:   Greg KH <greg@kroah.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH 6.3.y] mm/hugetlb: revert use of page_cache_next_miss()
Message-ID: <2023060745-kilometer-omnivore-4471@gregkh>
References: <20230606172022.128441-1-sidhartha.kumar@oracle.com>
 <2023060650-overlying-skiing-191d@gregkh>
 <c6ead868-3523-f25c-3f04-119da28a50ff@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ead868-3523-f25c-3f04-119da28a50ff@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:13:05AM -0700, Sidhartha Kumar wrote:
> On 6/6/23 10:38 AM, Greg KH wrote:
> > On Tue, Jun 06, 2023 at 10:20:22AM -0700, Sidhartha Kumar wrote:
> > > As reported by Ackerley[1], the use of page_cache_next_miss() in
> > > hugetlbfs_fallocate() introduces a bug where a second fallocate() call to
> > > same offset fails with -EEXIST. Revert this change and go back to the
> > > previous method of using get from the page cache and then dropping the
> > > reference on success.
> > > 
> > > hugetlbfs_pagecache_present() was also refactored to use
> > > page_cache_next_miss(), revert the usage there as well.
> > > 
> > > User visible impacts include hugetlb fallocate incorrectly returning
> > > EEXIST if pages are already present in the file. In addition, hugetlb
> > > pages will not be included in core dumps if they need to be brought in via
> > > GUP. userfaultfd UFFDIO_COPY also uses this code and will not notice pages
> > > already present in the cache. It may try to allocate a new page and
> > > potentially return ENOMEM as opposed to EEXIST.
> > > 
> > > Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
> > > Cc: <stable@vger.kernel.org> #v6.3
> > > Reported-by: Ackerley Tng <ackerleytng@google.com>
> > > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > 
> > > [1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
> > > ---
> > > 
> > > This revert is the safest way to fix 6.3. The upstream fix will either
> > > fix page_cache_next_miss() itself or use Ackerley's patch to introduce a
> > > new function to check if a page is present in the page cache. Both
> > > directions are currently under review so we can use this safe and simple
> > > fix for 6.3
> > 
> > Is there any specific reason why we don't just wait for the fix for
> > Linus's tree before applying this one, or applying the real fix instead?
> 
> I missed Andrew's message stating he would prefer the real fix[1].
> 
> Sorry for the noise,
> Sidhartha Kumar
> 
> [1] https://lore.kernel.org/lkml/20230603022209.GA114055@monkey/T/#mea6c8a015dbea5f9c2be88b9791996f4be6c2de8

Great, is that going to Linus's tree soon?

thanks,

greg k-h
