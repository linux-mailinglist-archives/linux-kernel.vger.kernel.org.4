Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FFC741809
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjF1Sbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:31:48 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48453 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229941AbjF1Sbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:31:43 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B1F95C01EB;
        Wed, 28 Jun 2023 14:31:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 28 Jun 2023 14:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687977103; x=1688063503; bh=JJ
        8A5RWcyl1scz/K2Ger4aToKVFg8VkiR1tPU5FsSag=; b=K7QDnX6dKijyHALqGc
        DvstsLWTSqQV9gURPBfEaNdcw2EWzmjfedeBSQ/4MAs/v6zSufsbeEeS1Zob9mWK
        CTArJ4YZuHSiA0s1v6UknulKU1+xVSldYmt83rexOnHVclZd4QRZv2gtv8V5gals
        +D2BHMvulIyj18H6nLs7AoLcBWvzbViLTnzdFapEr3vo8sCIJpzjdWi8rSz+iq0Y
        zO/U9GI+T7cgDx94MuhHH2xwZ2l9D8YwXVNYO06wiO1NkQZPj8lwq+dhTl9MBC6w
        rcZhiAtERmQfNUMb6STFxNfGL5A3Hy3mrfDxzupVuA0A4QW/Km+yzJ0qAet7DJUC
        2cpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687977103; x=1688063503; bh=JJ8A5RWcyl1sc
        z/K2Ger4aToKVFg8VkiR1tPU5FsSag=; b=TTVpZcTbDJxcX/2LHybvbOl7QaXAg
        jhlBYrszR9zWNBy7B3l9YESBwjqrnnuP65wkXHvU2CQHHrikOuno8hKlaq6QIOpq
        kltjsLDiIhNEJFHvWJDJP9EvjybOxL3YG0ZACihT0nq5cdbqYZx8cQTkpDlePUB4
        sym+csiB81qVgM2N1LVBmUStDbrQh/Mi1J9n3syJZYXU/JHa3uHfwm+N1IZx5fnS
        vufbmbkY7MlXDhu0I3u+tdI5LGnWzIJarbIYlNwClSQOC0hZyTLlSytb6stbJT0N
        K2ZWORsrcI8cQpO7qA8BtbrLtXh9yAXCR4Ltx5aavo7QBv8MLpheCKzUw==
X-ME-Sender: <xms:jnycZOn5OybT29WMh_8Nu9ecDEPN1h7jNycf-vrSJG1NrF7f_a7E3Q>
    <xme:jnycZF3a0uLL9Nn_QdK_G-Uu5Z_1ct7-X9r269tzvWdFuUQs4JBewHMnfnbcu7V29
    BeTMaKB3lVRrg>
X-ME-Received: <xmr:jnycZMrfEu_0c_E_bxkzG2rMKs3tlpQc2ebIIHujErcgxcu3QCmHQ6ELmPzEvdaQoAxiUPWgi4RCcwSBhLLztzFEhbqJknId78jnwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:jnycZCkxNH-wDF4S8GsuoRaLIYpAdoLGMLcYcPdFm3RarK-buhbVdQ>
    <xmx:jnycZM2IcylwcT4JF01eg8J8ecSxO7Gev50i_0oOKHKwiA9GiPOvFg>
    <xmx:jnycZJsJ_NbAtXRxlp-4xnUw1BxFtfXL4gnSXUU8OLmBRpPW-BDNHw>
    <xmx:j3ycZCOW8r5Z8JC0TFCXrA5nn1fZS9VMXGJ5p4mKrPoCjy6Zjirlqw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 14:31:42 -0400 (EDT)
Date:   Wed, 28 Jun 2023 20:31:40 +0200
From:   Greg KH <greg@kroah.com>
To:     Dragos-Marian Panait <dragos.panait@windriver.com>
Cc:     stable@vger.kernel.org, Yang Lan <lanyang0908@gmail.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.4] gfs2: Don't deref jdesc in evict
Message-ID: <2023062832-snuggle-casino-7f9e@gregkh>
References: <20230628133052.1796173-1-dragos.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628133052.1796173-1-dragos.panait@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:30:52PM +0300, Dragos-Marian Panait wrote:
> From: Bob Peterson <rpeterso@redhat.com>
> 
> [ Upstream commit 504a10d9e46bc37b23d0a1ae2f28973c8516e636 ]
> 
> On corrupt gfs2 file systems the evict code can try to reference the
> journal descriptor structure, jdesc, after it has been freed and set to
> NULL. The sequence of events is:
> 
> init_journal()
> ...
> fail_jindex:
>    gfs2_jindex_free(sdp); <------frees journals, sets jdesc = NULL
>       if (gfs2_holder_initialized(&ji_gh))
>          gfs2_glock_dq_uninit(&ji_gh);
> fail:
>    iput(sdp->sd_jindex); <--references jdesc in evict_linked_inode
>       evict()
>          gfs2_evict_inode()
>             evict_linked_inode()
>                ret = gfs2_trans_begin(sdp, 0, sdp->sd_jdesc->jd_blocks);
> <------references the now freed/zeroed sd_jdesc pointer.
> 
> The call to gfs2_trans_begin is done because the truncate_inode_pages
> call can cause gfs2 events that require a transaction, such as removing
> journaled data (jdata) blocks from the journal.
> 
> This patch fixes the problem by adding a check for sdp->sd_jdesc to
> function gfs2_evict_inode. In theory, this should only happen to corrupt
> gfs2 file systems, when gfs2 detects the problem, reports it, then tries
> to evict all the system inodes it has read in up to that point.
> 
> Reported-by: Yang Lan <lanyang0908@gmail.com>
> Signed-off-by: Bob Peterson <rpeterso@redhat.com>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> [DP: adjusted context]
> Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
> ---
>  fs/gfs2/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

All now queued up, thanks.

greg k-h
