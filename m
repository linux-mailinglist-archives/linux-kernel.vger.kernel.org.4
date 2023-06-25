Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5317773CFC2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjFYJeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:34:08 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D53E5F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 02:34:07 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 529F05C0071;
        Sun, 25 Jun 2023 05:34:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 25 Jun 2023 05:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687685644; x=1687772044; bh=RjM4GlJucU1Ls0/IxjRJeTQsDlFI04X+oR2
        L/HWLcOU=; b=N3y6oVXIfLxMNjXEj2CdDjv6SnrrazLKLzVOXwB/Zxc0FUHhpH5
        9N22s/YV0SQNvbSUls1emOSWggGoX8221j9dqUrP3AWiNlk9a0MX3uFaJfLnjrBK
        84OHttyK7NrtLvajk1AkWo/S9hH0tHHmNQnUAnDv53CDxnKDlI+Dm10SfAvzlJXo
        DNo1jG893OrYDTLzEinjV0+FFcDkbFsQjuD7j0Wap5YImVLTEkhTdsZuohGhECPm
        HvNVsIyVZob54JB7DWCEI/DeU45RhAy1OJDmoA31Y0l+JcAwQTTYuKDidmS0zoHo
        oT7wJzZORndrWKHVa/R4BJy/Bi5c/izg3Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687685644; x=1687772044; bh=RjM4GlJucU1Ls0/IxjRJeTQsDlFI04X+oR2
        L/HWLcOU=; b=Mra/gTVVzBBlh2KZH+VStSusrtvPlFL8EvWIJkcdSC5CM1lnwoC
        bj0p4+Ex1LXkZxXC+i5B1Mz32zuZmWBh2+4Vvas+7Wa3E3ea7XU44sANJP4iXSBd
        yMFfpcITNUe7/bdi1bpnhUxhmiczSIuZEcM4u/lDvfRFcsx2cn2w7zX+UtTipUBe
        C0AEJW3KMvWNuZ1OyDBGlmQlV02GZp5RlL+IETX3o8XTKkzRpaZbP24/irzAUYBB
        gcvesxp9ZAJnI5840uh4Suetv8aFchXCmfKTBQ4iGw94zahHJHFbzEPumzsdfV/o
        a3H4DKJslWajKwPQiOmiTL0zz+eH64v/vjA==
X-ME-Sender: <xms:DAqYZHVrv8KyQ-Uw9oIpjKXInOZtjmGlx5DGrcan9G-4vgGpmV_FQA>
    <xme:DAqYZPn63bN184CHn3L7u3eS99Rro3K_dV-wmciBGI0DxIShb6um5vP94hpoNYfZz
    5jfNspuzgOKBA>
X-ME-Received: <xmr:DAqYZDbq60eZjAlpxoESTWnl56Tn306rEAyPTWntsumprTklofRoYis7qUtVG2mCePwWf4eQNb3ZPOQ9junaj5OFB92ZwcxPLhnrlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehtddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgke
    ffieefieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:DAqYZCWpipaVvzoPFHAZwM7YosPCAag3kLrEnNI_vT5b-cI1jKvCDw>
    <xmx:DAqYZBkHYe2ysyJcGVe-8GKQWt85vjqxPXAGXEv6yNSWmAqHWcgqjA>
    <xmx:DAqYZPcXo_j0sJ8q11wGgDPKCUrZ47Y8aVtqbh3_tURRNKlsJRNbcA>
    <xmx:DAqYZD1AkrXv2qqMdN35ic4A29uhZ2YS3jjKlSZatgoI4cnITLACTg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Jun 2023 05:34:03 -0400 (EDT)
Date:   Sun, 25 Jun 2023 11:34:00 +0200
From:   Greg KH <greg@kroah.com>
To:     =?utf-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "gregkh@google.com" <gregkh@google.com>,
        "zhangshiming@opp.com" <zhangshiming@opp.com>,
        =?utf-8?B?6YOt5YGl?= <guojian@oppo.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] mm: vmscan: export
 func:shrink_slab
Message-ID: <2023062554-gecko-cyclist-0c78@gregkh>
References: <20230616092112.387-1-lipeifeng@oppo.com>
 <33eabee3-f6f4-ee0c-d74b-98815a9567c4@redhat.com>
 <TYZPR02MB5595CE108D89A51973CF551AC65CA@TYZPR02MB5595.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR02MB5595CE108D89A51973CF551AC65CA@TYZPR02MB5595.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:05:27AM +0000, 李培锋(wink) wrote:
> On 16.06.23 11:21, lipeifeng@oppo.com wrote:
> >> From: lipeifeng <lipeifeng@oppo.com>
> >> 
> >> Some of shrinkers during shrink_slab would enter synchronous-wait due 
> >> to lock or other reasons, which would causes kswapd or direct_reclaim 
> >> to be blocked.
> >> 
> >> This patch export shrink_slab so that it can be called in drivers 
> >> which can shrink memory independently.
> >> 
> >> Signed-off-by: lipeifeng <lipeifeng@oppo.com>
> >> ---
> >>   mm/vmscan.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c index 
> >> 6d0cd2840cf0..2e54fa52e7ec 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1043,7 +1043,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >>    *
> >>    * Returns the number of reclaimed slab objects.
> >>    */
> >> -static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> >> +unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> >>   				 struct mem_cgroup *memcg,
> >>   				 int priority)
> >>   {
> >> @@ -1087,6 +1087,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> >>   	cond_resched();
> >>   	return freed;
> >>   }
> >> +EXPORT_SYMBOL_GPL(shrink_slab);
> >>   
> >>   static unsigned long drop_slab_node(int nid)
> >>   {
> >
> >It feels like something we don't want arbitrary drivers to call.
> >
> >Unrelated to that, this better be sent along with actual driver usage.
> 
> Hi Sir：
> 
> Virtually, we have implemented async shrink_slabd isolated from kswapd and direct_reclaim.
> The goal above it is to avoid the sync-wait in kswapd or direct_reclaim due to some shrinkers.
> 
> But the async shrink_slabd was only applied to mobile products so that I didn't make sure any
> risk in other products. For the above reasons, I wanna merge the patch to export shrink_slab
> and the patch of drivers would be considered to be pushed if I check all the risks.
> 
> Some informal code files of driver are attached for your reference.

You have to submit this as a real series, we can not accept exports for
no in-kernel users (nor would you want us to, as that ends up being an
unmaintainable mess.)

So please resubmit this as a proper patch series, with the user of this
function, and then it can be properly evaluated.  As-is, this can not be
accepted at all.

thanks,

greg k-h
