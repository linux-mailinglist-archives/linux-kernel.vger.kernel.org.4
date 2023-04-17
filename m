Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A986E4B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDQORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjDQORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:17:33 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4BBBBB0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:17:14 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 556965C00F4;
        Mon, 17 Apr 2023 10:17:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 17 Apr 2023 10:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1681741033; x=
        1681827433; bh=l15cdflCQ3SxSuEdRTgAeWktejfsY5ZPKXq6m2nekW4=; b=G
        KDDM4yg0ja82PR7UFA2IM88NqCebJi+TFhPe8bF23WcNjhVDQEWCH1TYfg/60PWJ
        2eq1+fp8TXDMhTdAo/E2HehgsceviXYt1VyjnZmNLEuWKMgElHZIGn5R/Z6tAA0p
        Kb3cUaoVqZa3bGq2fJmq8Oj0hhCotfNQiB2IIiaiBIHTmYzZwLT4chniAXhpmBFp
        UWxYRkEzUNums0CC5f+HhbgYFxsLO+HNXaaL2GbwLbEJJfXPYxN+HlfEJtetklRT
        SUMhclwXbBISsRIdWft2w+V41XlAI77zXdVkkI3ER0pDvi9eVz0bzuteQWf4+goy
        BZ8lKRk4DAlOxJdEkJBmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681741033; x=1681827433; bh=l15cdflCQ3SxS
        uEdRTgAeWktejfsY5ZPKXq6m2nekW4=; b=HF7lLdY3CG29HOuOyGNcjYY41pnEv
        MWBIHfX4aUc8tAYUFszbitfZZgH2Pfx6i6p48SFWRI+8fqFgrEdyooi7UblPTekR
        cdHHJP3Iyyf4WrF/QdmlOnQJ51hUmV4FB7Me++xJEC0Xo+etuYcMvn1J9iAK399O
        V83pXy9XNLaq/hGIJ4qyYd/WVSc0ifeAObIa7Y1gdzbiDkPiAYAp3Vsf2RbFhIeK
        S1xL91ij3fgpNdT2yUbJwq/RrTdXEBYxzR3H8Obp8+TPmD1U5zaorqbCYhjGlSwO
        DgoigqphQ21byer1j6UMHCssE1N4zMjFmoeKNXS4vFd9D4SjILRU0orLA==
X-ME-Sender: <xms:6FQ9ZJ2aK6vxxCPEwnujDN1tMnT7qy31LDz9CRpsNeC_82efDKOFfA>
    <xme:6FQ9ZAH_KwWWFROQNPE3U6K-723W797rjDrdAbHaVcQwbrlsyIj2Vx5UL53MN2Toq
    zx_EIw1EnXaXaVflpg>
X-ME-Received: <xmr:6FQ9ZJ7RIqUMmegwY4RZWC-C74hZarJKOjNk9kPUX5QLRt2sNLUp1-mFKXe_FkxATNT3sxg2MlKll4nDa9H6acQMhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephfduvedvgfduueekleeuleeihedvffdugffhteei
    ffevhfeutddtffeijeegueevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpmhgrrh
    gtrdhinhhfohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:6FQ9ZG2gsh7a7AfZLmtW0Mo3JYojU-LUQPQvPWGRvm3Xo2FzHL7dVw>
    <xmx:6FQ9ZMEA8DSYUxX73vgYYLZllY3pCt1BTZl4VCoU8C-J-rLIenRnGA>
    <xmx:6FQ9ZH9UsLvTi3W8sTDp2Et2voeIOM3YKtRS1VazXkEWWw0R2l8ulg>
    <xmx:6VQ9ZIjujCh3Rqaai1CTmVOzf24c8eby41BAQB1LRmNrSouq0u8iAA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 10:17:10 -0400 (EDT)
Date:   Mon, 17 Apr 2023 23:17:06 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     rdunlap@infradead.org
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, tiwai@suse.de,
        broonie@kernel.org
Subject: Re: [PATCH] MAINTAINERS: replace maintainer of FireWire subsystem
Message-ID: <20230417141706.GA493669@workstation>
Mail-Followup-To: rdunlap@infradead.org,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        tiwai@suse.de, broonie@kernel.org
References: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
 <20230310210356.561dbe63@kant>
 <20230311080343.GA378828@workstation>
 <20230311101554.14c211d4@kant>
 <20230312070728.GA421475@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312070728.GA421475@workstation>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

I'm sorry that I didn't notice your reply, but I'm off from the receivers
list of the message.

> Hi--
> 
>On 3/11/23 23:07, Takashi Sakamoto wrote:
>> Hi,
>> 
>>>
>>> It's good to see you being active in the kernel and related userland
>>> development/ maintainership, and that you have a plan for the next years.
>> 
>> At the moment, I have a problem about the list archive.
> 
> If there is still a problem about the mailing list archives,
> Hank Leininger at marc.info has been pretty good in the past about providing
> archives fore lore.kernel.org.
> See the bottom of https://marc.info/?q=about for his email address.
 
Thanks for the information. As a quick glimpse, linux1394-devel has been
archived since 2003. It looks to be a good source to push into
lore.kernel.org, while I know that the list archive should include many
spams since any one is allowed to post to the list without subscribing and
being moderated at one time. It is one of my reason not to use the list
so actively. I need to make filter to remove them before pushing.
Furthermore, the ownership of list is still unclear to me. I have a small
hesitation to use it further...
 
> Are you waiting for the kernel.org account before merging the update to the
> MAINTAINER's file?

I've already got the account and enough permission to linux1394
repository, but The repository is inactive so long, and abandoned. Looking
ahead to my future work, I'm preparing them at present.


Thanks

Takashi Sakamoto
