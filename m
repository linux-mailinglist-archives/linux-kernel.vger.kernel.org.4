Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49DF6F0757
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbjD0O1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243662AbjD0O1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:27:52 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BFB1FE6;
        Thu, 27 Apr 2023 07:27:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CC8405C0207;
        Thu, 27 Apr 2023 10:27:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 27 Apr 2023 10:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682605668; x=1682692068; bh=a5
        ON+ne5HB5nl4hoXlBqXG88QwWZJREMnOBOsnBrRv4=; b=ISY/db0+zxp0t+fkm6
        0n8WaCGUVCEHTBbni4+YEjjkmEErP7gn+L9QLMUJg7GyQ7ECHEzfSONRIkRmvKRl
        2tlhtbdncGXxvhrjJpOqFtefmejXFiwQiB2jyj4vvF+Xvddc6TvPuFTR1FaRHROZ
        VX+SoUKD9hG7vsFBmzmJYEBJdc9CdSNDdacPWzZZaFanjBDmTjDrYQ9N6EIICsKE
        YfTsRO0hAsqxe7BF45/Gwxy5ZPH8Jh/ANQNHmZn4tBhRxqND0DtpzdEwm5MNAdfp
        V7Yd4iU8kZpIH2G+YKHcpTdHnqHVKpb9xEx/YhTx9HD3NWGuj3g9SX7PwMnLjF79
        I3UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682605668; x=1682692068; bh=a5ON+ne5HB5nl
        4hoXlBqXG88QwWZJREMnOBOsnBrRv4=; b=aXBHwX7aqpVMTGsBDB+J9sN7vjDBi
        fKlo4XFYo6ZadStSpctoUaLLB/sEYz1F45U8O2PBjqrsdEv8cULZnl6SQYNpsHWA
        gSS3Q8IHQ5xDZGNQ+/3zyS8hiYZ451W/EHVe7l+6WQG6trnTFUitwS2MzI3b6U27
        z10RS84dhRwbNtJuX4cSkXH+EaQU/XSJC28FEXx2rVboMY/SlDz1z4vizdat89gF
        +aCImjXJVVan1tRWkRfO8XYlxN1iGdJgnTCzSznGuxlI0sSQW8I9c6DaBTByt+lG
        xU4TjXQJ6WBeXBexyOUizntMGrXwvv0Ho63YdeBtazRr/hIDamDAALPdw==
X-ME-Sender: <xms:ZIZKZM0406hTHT8y_V2QjCP4LUTAt54IavgjEzCVeKZN3HzfFOv3DQ>
    <xme:ZIZKZHF56RFsQkTdv0KNZTATjVGCryUTxI9A40Q5oNjdfehnHZ3D9SzY9eve2IpUp
    3odgUEWoPr-5A>
X-ME-Received: <xmr:ZIZKZE6TEE3isoH_nW4WD45XGOncNruOiu340vVeF0aTiSCLndXgIB5X4IPF5y2hYG7r-BeeaF5zK838J2ibqmYaOEnIqOPZS3LCKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjeekue
    dtffeftddtvdeggeffjeeuteelhfeifeegheeufeekjeevveelueelfefhnecuffhomhgr
    ihhnpehsuhhsvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:ZIZKZF04MmlAUfQWMaSZt2DpGPlQ-g-T45dM3GaZpTgMsf5A45E4zQ>
    <xmx:ZIZKZPFRBcHeWT17yqdiEy6R19Zrm8UJhbeuv0FqOCpw5yuSAU8THA>
    <xmx:ZIZKZO8F9f9Y5JLJiG8DkN3tOYs_nUPww6Rwbh75BQWQClF92hnHuw>
    <xmx:ZIZKZI29nXZAR3k9Qg4TvHdk7Bz-rv-8HI0CUcRs68p5vhDZq90lXg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 10:27:47 -0400 (EDT)
Date:   Thu, 27 Apr 2023 16:27:44 +0200
From:   Greg KH <greg@kroah.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, lstoakes@gmail.com,
        regressions@lists.linux.dev, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabian Vogt <fvogt@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH for v6.3 regression] mm/mremap: fix vm_pgoff in
 vma_merge() case 3
Message-ID: <2023042719-stratus-pavestone-505e@gregkh>
References: <20230427140959.27655-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427140959.27655-1-vbabka@suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 04:09:59PM +0200, Vlastimil Babka wrote:
> After upgrading build guests to v6.3, rpm started segfaulting for
> specific packages, which was bisected to commit 0503ea8f5ba7 ("mm/mmap:
> remove __vma_adjust()"). rpm is doing many mremap() operations with file
> mappings of its db. The problem is that in vma_merge() case 3 (we merge
> with the next vma, expanding it downwards) vm_pgoff is not adjusted as
> it should when vm_start changes. As a result the rpm process most likely
> sees data from the wrong offset of the file. Fix the vm_pgoff
> calculation.
> 
> For case 8 this is a non-functional change as the resulting vm_pgoff is
> the same.
> 
> Reported-and-bisected-by: Jiri Slaby <jirislaby@kernel.org>
> Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1210903
> Fixes: 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: <stable@vger.kernel.org>
> ---
> Hi, I'm sending this patch on top of v6.3 as I think it should be
> applied and backported to 6.3-stable rather sooner than later.
> This means there would be a small conflict when merging mm/mm-stable
> later. Alternatively it could be added to mm/mm-stable and upcoming 6.4
> pull request, but then the stable backport would need adjustment.
> It's up to Linus and Andrew.

That's not how the stable tree works, sorry, it needs to be in Linus's
tree _first_.

thanks,

greg k-h
